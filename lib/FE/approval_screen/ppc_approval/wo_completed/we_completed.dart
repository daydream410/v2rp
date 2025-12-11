import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/BE/resD.dart';
import 'package:v2rp1/routes/api_name.dart';
import '../../../../BE/controller.dart';
import '../../../../BE/reqip.dart';
import '../../../../main.dart';
import '../../../navbar/navbar.dart';
import 'wo_completed2.dart';

class WoCompleted extends StatefulWidget {
  WoCompleted({Key? key}) : super(key: key);

  @override
  State<WoCompleted> createState() => _WoCompletedState();
}

class _WoCompletedState extends State<WoCompleted> {
  static TextControllers textControllers = Get.put(TextControllers());
  static late List dataaa = <CaConfirmData>[];
  static late List _foundUsers = <CaConfirmData>[];
  late Future dataFuture;
  
  // Pagination variables
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  bool isSearching = false; // New variable to track search state
  ScrollController _scrollController = ScrollController();
  
  // Cache management variables
  static const String CACHE_KEY = 'wo_completed_cache';
  static const String CACHE_TIMESTAMP_KEY = 'wo_completed_cache_timestamp';
  static const String CACHE_LAST_ACCESS_KEY = 'wo_completed_cache_last_access';
  static const String CACHE_PAGES_KEY = 'wo_completed_cache_pages';
  static const int CACHE_DURATION_MINUTES = 15; // Cache berlaku 15 menit setelah tidak ada aktivitas
  Map<int, List> cachedPages = {}; // Cache per halaman

  @override
  void initState() {
    super.initState();
    dataFuture = getDataa();
    _scrollController.addListener(_scrollListener);
    _loadCachedData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  // Update last access time for cache
  Future<void> _updateCacheLastAccess() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(CACHE_LAST_ACCESS_KEY, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print("Error updating cache last access: $e");
    }
  }

  // Check if cache is still valid based on last access time
  Future<bool> _isCacheValid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastAccess = prefs.getInt(CACHE_LAST_ACCESS_KEY);
      
      if (lastAccess == null) return false;
      
      final now = DateTime.now().millisecondsSinceEpoch;
      final timeSinceLastAccess = now - lastAccess;
      final maxAge = CACHE_DURATION_MINUTES * 60 * 1000; // Convert to milliseconds
      
      return timeSinceLastAccess < maxAge;
    } catch (e) {
      print("Error checking cache validity: $e");
      return false;
    }
  }

  // Load cached data on init
  void _loadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cacheData = prefs.getString(CACHE_KEY);
    final cacheTimestamp = prefs.getInt(CACHE_TIMESTAMP_KEY);
    
    if (cacheData != null && cacheTimestamp != null) {
      // Check cache validity based on last access time
      bool isValid = await _isCacheValid();
      
      if (isValid) {
        // Update last access time since we're using the cache
        await _updateCacheLastAccess();
        // Cache masih valid, load dari cache
        try {
          // Load main cache data
          final List cachedList = json.decode(cacheData);
          
          // Load all cached pages
          final cachedPagesData = prefs.getString(CACHE_PAGES_KEY);
          if (cachedPagesData != null) {
            final Map<String, dynamic> pages = json.decode(cachedPagesData);
            cachedPages.clear();
            
            // Restore all cached pages
            pages.forEach((key, value) {
              cachedPages[int.parse(key)] = List.from(value);
            });
            
            // Rebuild complete data from all cached pages in order
            List completeData = [];
            for (int i = 1; i <= cachedPages.length; i++) {
              if (cachedPages.containsKey(i)) {
                completeData.addAll(cachedPages[i]!);
              }
            }
            
            // Determine current page based on data length
            currentPage = ((completeData.length - 1) ~/ 20) + 1;
            
            setState(() {
              dataaa = completeData;
              _foundUsers = dataaa;
              hasMoreData = cachedPages.containsKey(currentPage) && cachedPages[currentPage]!.length >= 20;
            });
            
            print("Loaded data from cache (last access updated) - Total items: ${completeData.length}, Current page: $currentPage, Cached pages: ${cachedPages.keys.toList()}");
          } else {
            // Fallback to main cache only
            setState(() {
              dataaa = cachedList;
              _foundUsers = dataaa;
            });
            print("Loaded data from main cache only (last access updated)");
          }
        } catch (e) {
          print("Error loading cached data: $e");
          await _clearCache();
        }
      } else {
        // Cache expired based on last access time, hapus cache lama
        await _clearCache();
        print("Cache expired (no activity for ${CACHE_DURATION_MINUTES} minutes), loading fresh data");
      }
    }
  }

  // Save data to cache
  Future<void> _saveToCache(List data, int page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert data to JSON-safe format
      List jsonSafeData = _convertToJsonSafe(data);
      
      // For page 1, save as main cache
      if (page == 1) {
        await prefs.setString(CACHE_KEY, json.encode(jsonSafeData));
        await prefs.setInt(CACHE_TIMESTAMP_KEY, DateTime.now().millisecondsSinceEpoch);
      }
      
      // Update last access time when saving new data
      await _updateCacheLastAccess();
      
      // Load existing cached pages
      final cachedPagesData = prefs.getString(CACHE_PAGES_KEY);
      if (cachedPagesData != null) {
        try {
          final Map<String, dynamic> existingPages = json.decode(cachedPagesData);
          existingPages.forEach((key, value) {
            cachedPages[int.parse(key)] = List.from(value);
          });
        } catch (e) {
          print("Error loading existing cache pages: $e");
        }
      }
      
      // Save current page to cached pages
      cachedPages[page] = List.from(jsonSafeData);
      
      // Convert cached pages to JSON-safe format
      Map<String, dynamic> jsonSafeCachedPages = {};
      cachedPages.forEach((key, value) {
        jsonSafeCachedPages[key.toString()] = _convertToJsonSafe(value);
      });
      
      await prefs.setString(CACHE_PAGES_KEY, json.encode(jsonSafeCachedPages));
      
      print("Data saved to cache for page $page (Total cached pages: ${cachedPages.length})");
    } catch (e) {
      print("Error saving to cache: $e");
      // Don't throw error, just log it so app continues to work
    }
  }

  // Convert data to JSON-safe format
  List _convertToJsonSafe(List data) {
    try {
      // Convert to JSON string and back to ensure it's JSON-safe
      String jsonString = json.encode(data);
      return json.decode(jsonString);
    } catch (e) {
      print("Error converting data to JSON-safe format: $e");
      // Return empty list if conversion fails
      return [];
    }
  }

  // Load cached page data
  Future<List?> _loadCachedPage(int page) async {
    // Check cache validity based on last access time
    bool isValid = await _isCacheValid();
    
    if (isValid) {
      // Update last access time since we're accessing the cache
      await _updateCacheLastAccess();
      
      final prefs = await SharedPreferences.getInstance();
      final cachedPagesData = prefs.getString(CACHE_PAGES_KEY);
      if (cachedPagesData != null) {
        final Map<String, dynamic> pages = json.decode(cachedPagesData);
        if (pages.containsKey(page.toString())) {
          print("Loading page $page from cache (last access updated)");
          return List.from(pages[page.toString()]);
        }
      }
    } else {
      print("Cache expired (no activity for ${CACHE_DURATION_MINUTES} minutes), will fetch fresh data");
    }
    return null;
  }

  // Clear cache
  Future<void> _clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(CACHE_KEY);
    await prefs.remove(CACHE_TIMESTAMP_KEY);
    await prefs.remove(CACHE_LAST_ACCESS_KEY);
    await prefs.remove(CACHE_PAGES_KEY);
    cachedPages.clear();
    print("Cache cleared");
  }

  // Clear cache when transaction is completed (call this when needed)
  Future<void> _invalidateCacheOnTransactionComplete(String reffno) async {
    // Remove specific transaction from local data
    dataaa.removeWhere((item) => 
      item is Map && 
      item['header'] is Map && 
      item['header']['reffno'] == reffno);
    _foundUsers.removeWhere((item) => 
      item is Map && 
      item['header'] is Map && 
      item['header']['reffno'] == reffno);
    
    // Update cache by removing the specific transaction but preserving other data
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Update main cache
      List jsonSafeData = _convertToJsonSafe(dataaa);
      await prefs.setString(CACHE_KEY, json.encode(jsonSafeData));
      
      // Update page-specific cache
      final cachedPagesData = prefs.getString(CACHE_PAGES_KEY);
      if (cachedPagesData != null) {
        final Map<String, dynamic> pages = json.decode(cachedPagesData);
        bool cacheUpdated = false;
        
        // Remove transaction from each cached page
        pages.forEach((pageKey, pageData) {
          if (pageData is List) {
            int initialLength = pageData.length;
            pageData.removeWhere((item) => 
              item is Map && 
              item['header'] is Map && 
              item['header']['reffno'] == reffno);
            
            if (pageData.length != initialLength) {
              cacheUpdated = true;
            }
          }
        });
        
        if (cacheUpdated) {
          await prefs.setString(CACHE_PAGES_KEY, json.encode(pages));
        }
      }
      
      // Update last access time to keep cache valid
      await _updateCacheLastAccess();
      
    } catch (e) {
      print("Error updating cache after transaction completion: $e");
    }
    
    setState(() {
      _foundUsers = dataaa;
    });
    
    print("Cache updated for transaction completion: $reffno");
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      if (!isLoadingMore && hasMoreData) {
        _loadMoreData();
      }
    }
  }

  void _loadMoreData() async {
    if (isLoadingMore || !hasMoreData) return;
    
    setState(() {
      isLoadingMore = true;
    });

    try {
      currentPage++;
      print("_loadMoreData - Loading page: $currentPage");
      
      // Check if page is cached first
      List? cachedPageData = await _loadCachedPage(currentPage);
      List moreData;
      
      if (cachedPageData != null) {
        moreData = cachedPageData;
        print("Using cached data for page $currentPage");
      } else {
        moreData = await getDataaPaginated(currentPage);
        if (moreData.isNotEmpty) {
          // Save new page to cache with error handling
          try {
            await _saveToCache(moreData, currentPage);
          } catch (cacheError) {
            print("Cache save error (continuing without cache): $cacheError");
            // Continue execution even if cache fails
          }
        }
      }
      
      if (moreData.isEmpty) {
        setState(() {
          hasMoreData = false;
        });
      } else {
        setState(() {
          dataaa.addAll(moreData);
          _foundUsers = dataaa;
          hasMoreData = moreData.length >= 20; // Update hasMoreData based on current page data
        });
        print("Added ${moreData.length} items to page $currentPage. Total items: ${dataaa.length}");
      }
    } catch (e) {
      print('Error loading more data: $e');
      // Reset current page if there was an error
      if (currentPage > 1) {
        currentPage--;
      }
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  void _performSearch() async {
    String enteredKeyword = textControllers.WoCompletedController.value.text.trim();
    
    if (enteredKeyword.isEmpty) {
      // Jika search box kosong, load data normal
      setState(() {
        _foundUsers = dataaa;
        isSearching = false;
      });
    } else {
      // Jika ada input, hit API dengan parameter reffno
      try {
        setState(() {
          isSearching = true; // Show loading indicator
        });
        
        List searchResults = await getDataaWithSearch(enteredKeyword, 1);
        
        setState(() {
          _foundUsers = searchResults;
          isSearching = false;
        });
      } catch (e) {
        print("Error searching: $e");
        setState(() {
          _foundUsers = [];
          isSearching = false;
        });
      }
    }
  }

  void _resetSearch() {
    textControllers.WoCompletedController.value.clear();
    setState(() {
      _foundUsers = dataaa;
      isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return WillPopScope(
      onWillPop: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are You sure?'),
            content: const Text('Do you want to exit V2RP Mobile?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        throw (e);
      },
      child: isIOS
          ? CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                transitionBetweenRoutes: true,
                middle: const Text("Work Order Completed"),
                leading: GestureDetector(
                  child: const Icon(CupertinoIcons.back),
                  onTap: () {
                    Get.to(() => const Navbar());
                  },
                ),
              ),
              child: LiquidPullToRefresh(
                onRefresh: getDataa2,
                color: HexColor("#F4A62A"),
                height: 140,
                showChildOpacityTransition: false,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CupertinoTextField(
                                  controller: textControllers.WoCompletedController.value,
                                  placeholder: 'WO No.',
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.systemGrey6,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefix: const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Icon(CupertinoIcons.search, color: CupertinoColors.systemGrey),
                                  ),
                                  onSubmitted: (value) => _performSearch(),
                                ),
                              ),
                              const SizedBox(width: 6),
                              CupertinoButton(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                minSize: 0,
                                color: isSearching ? CupertinoColors.systemGrey : HexColor('#F4A62A'),
                                onPressed: isSearching ? null : _performSearch,
                                child: isSearching 
                                  ? const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 12,
                                          height: 12,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Text('...', style: TextStyle(color: Colors.white, fontSize: 12)),
                                      ],
                                    )
                                  : const Icon(CupertinoIcons.search, color: Colors.white, size: 16),
                              ),
                              const SizedBox(width: 4),
                              CupertinoButton(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                minSize: 0,
                                color: CupertinoColors.systemGrey,
                                onPressed: _resetSearch,
                                child: const Icon(CupertinoIcons.clear, color: Colors.white, size: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Colors.black,
                          ),
                          const SizedBox(height: 10),
                          // Show search loading overlay
                          if (isSearching)
                            Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF4A62A)),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Searching...',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Please wait while we search for your Work Orders',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            FutureBuilder(
                            future: dataFuture,
                            builder: (context, snapshot) {
                              if (snapshot.error != null) {
                                return const Center(
                                  child: Text('Error Loading Data'),
                                );
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: Column(
                                  children: [
                                    DefaultTextStyle(
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                      child: Text(
                                        'Loading...',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    CircularProgressIndicator(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    DefaultTextStyle(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                        ),
                                        child:
                                            Text('Please Kindly Waiting...')),
                                  ],
                                ));
                              } else {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListView.separated(
                                    controller: _scrollController,
                                    // shrinkWrap: true,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      );
                                    },
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: _foundUsers.length + (isLoadingMore || isSearching ? 1 : 0),
                                    itemBuilder: (context, index) {
                                      if (index == _foundUsers.length) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                const CircularProgressIndicator(),
                                                const SizedBox(height: 8),
                                                Text(isSearching ? 'Searching...' : 'Loading...'),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                      return Card(
                                        elevation: 5,
                                        child: ListTile(
                                          title: Text(
                                            _foundUsers[index]['header']
                                                ['reffno'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            _foundUsers[index]['header']
                                                    ['username'] +
                                                " || " +
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime.parse(
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['tanggal'])),
                                          ),
                                          onTap: () {
                                            Get.to(() => WoCompleted2(
                                              seckey: _foundUsers[index]
                                                  ['seckey'],
                                              reffno: _foundUsers[index]
                                                  ['header']['reffno'],
                                              tanggal: _foundUsers[index]
                                                  ['header']['tanggal'],
                                              duedate: _foundUsers[index]
                                                  ['header']['duedate'],
                                              amount: _foundUsers[index]
                                                  ['header']['amount'],
                                              username: _foundUsers[index]
                                                  ['header']['username'],
                                              locationname: _foundUsers[index]
                                                  ['header']['locationName'],
                                              projectid: _foundUsers[index]
                                                  ['header']['projectid'],
                                              description: _foundUsers[index]
                                                  ['header']['ket'],
                                              wipacc: _foundUsers[index]
                                                  ['header']['wipacc'],
                                              wipaccName: _foundUsers[index]
                                                  ['header']['wipaccName'],
                                            ));
                                          },
                                          trailing: IconButton(
                                            icon: const Icon(Icons
                                                .arrow_forward_ios_rounded),
                                            onPressed: () {
                                              Get.to(() => WoCompleted2(
                                                seckey: _foundUsers[index]
                                                    ['seckey'],
                                                reffno: _foundUsers[index]
                                                    ['header']['reffno'],
                                                tanggal: _foundUsers[index]
                                                    ['header']['tanggal'],
                                                duedate: _foundUsers[index]
                                                    ['header']['duedate'],
                                                amount: _foundUsers[index]
                                                    ['header']['amount'],
                                                username: _foundUsers[index]
                                                    ['header']['username'],
                                                locationname: _foundUsers[index]
                                                    ['header']['locationName'],
                                                projectid: _foundUsers[index]
                                                    ['header']['projectid'],
                                                description: _foundUsers[index]
                                                    ['header']['ket'],
                                                wipacc: _foundUsers[index]
                                                    ['header']['wipacc'],
                                                wipaccName: _foundUsers[index]
                                                    ['header']['wipaccName'],
                                              ));
                                            },
                                            color: HexColor('#F4A62A'),
                                            hoverColor: HexColor('#F4A62A'),
                                            splashColor: HexColor('#F4A62A'),
                                          ),
                                          tileColor: Colors.white,
                                          textColor: Colors.black,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text("Work Order Completed"),
                centerTitle: true,
                backgroundColor: HexColor("#F4A62A"),
                foregroundColor: Colors.white,
                elevation: 1,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Get.to(() => const Navbar());
                  },
                ),
              ),
              body: LiquidPullToRefresh(
                onRefresh: getDataa2,
                color: HexColor("#F4A62A"),
                height: 150,
                showChildOpacityTransition: false,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 0,
                      top: 15.0,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: textControllers.WoCompletedController.value,
                                onSubmitted: (value) => _performSearch(),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.assignment),
                                  hintText: 'WO No.',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            ElevatedButton(
                              onPressed: isSearching ? null : _performSearch,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSearching ? Colors.grey : HexColor('#F4A62A'),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                minimumSize: const Size(40, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: isSearching 
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : const Icon(Icons.search, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 4),
                            ElevatedButton(
                              onPressed: _resetSearch,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                minimumSize: const Size(40, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Icon(Icons.clear, color: Colors.white, size: 20),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 0.8,
                          height: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Item List'),
                            const SizedBox(height: 25.0),
                            // Show search loading overlay for Android
                            if (isSearching)
                              Container(
                                height: MediaQuery.of(context).size.height * 0.5,
                                child: const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF4A62A)),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'Searching...',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Please wait while we search for your Work Orders',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              FutureBuilder(
                              future: dataFuture,
                              builder: (context, snapshot) {
                                if (snapshot.error != null) {
                                  return const Center(
                                    child: Text('Error Loading Data'),
                                  );
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: Column(
                                    children: [
                                      Text('Loading...'),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      CircularProgressIndicator(),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text('Please Kindly Waiting...'),
                                    ],
                                  ));
                                } else {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.65,
                                        child: ListView.separated(
                                          controller: _scrollController,
                                          // shrinkWrap: true,
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            );
                                          },
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: _foundUsers.length + (isLoadingMore || isSearching ? 1 : 0),
                                          itemBuilder: (context, index) {
                                            if (index == _foundUsers.length) {
                                              return Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      const CircularProgressIndicator(),
                                                      const SizedBox(height: 8),
                                                      Text(isSearching ? 'Searching...' : 'Loading...'),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                            return Card(
                                              elevation: 5,
                                              child: ListTile(
                                                title: Text(
                                                  _foundUsers[index]['header']
                                                      ['reffno'],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  _foundUsers[index]['header']
                                                          ['username'] +
                                                      " || " +
                                                      DateFormat('yyyy-MM-dd')
                                                          .format(DateTime.parse(
                                                              _foundUsers[index]
                                                                      ['header']
                                                                  ['tanggal'])),
                                                ),
                                                onTap: () {
                                                  Get.to(() => WoCompleted2(
                                                    seckey: _foundUsers[index]
                                                        ['seckey'],
                                                    reffno: _foundUsers[index]
                                                        ['header']['reffno'],
                                                    tanggal:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['tanggal'],
                                                    duedate:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['duedate'],
                                                    amount: _foundUsers[index]
                                                        ['header']['amount'],
                                                    username:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['username'],
                                                    locationname:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['locationName'],
                                                    projectid:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['projectid'],
                                                    description:
                                                        _foundUsers[index]
                                                            ['header']['ket'],
                                                    wipacc: _foundUsers[index]
                                                        ['header']['wipacc'],
                                                    wipaccName:
                                                        _foundUsers[index]
                                                                ['header']
                                                            ['wipaccName'],
                                                  ));
                                                },
                                                trailing: IconButton(
                                                  icon: const Icon(Icons
                                                      .arrow_forward_rounded),
                                                  onPressed: () {
                                                    Get.to(() => WoCompleted2(
                                                      seckey: _foundUsers[index]
                                                          ['seckey'],
                                                      reffno: _foundUsers[index]
                                                          ['header']['reffno'],
                                                      tanggal:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['tanggal'],
                                                      duedate:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['duedate'],
                                                      amount: _foundUsers[index]
                                                          ['header']['amount'],
                                                      username:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['username'],
                                                      locationname:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['locationName'],
                                                      projectid:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['projectid'],
                                                      description:
                                                          _foundUsers[index]
                                                              ['header']['ket'],
                                                      wipacc: _foundUsers[index]
                                                          ['header']['wipacc'],
                                                      wipaccName:
                                                          _foundUsers[index]
                                                                  ['header']
                                                              ['wipaccName'],
                                                    ));
                                                  },
                                                  color: HexColor('#F4A62A'),
                                                  hoverColor:
                                                      HexColor('#F4A62A'),
                                                  splashColor:
                                                      HexColor('#F4A62A'),
                                                ),
                                                tileColor: Colors.white,
                                                textColor: Colors.black,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> getDataa() async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    try {
      print("getDataa - Loading page: $currentPage");
      
      // Check if we have cached data first
      List? cachedData = await _loadCachedPage(currentPage);
      
      if (cachedData != null && cachedData.isNotEmpty) {
        // Don't update currentPage and hasMoreData here if we're loading from cache
        // The _loadCachedData method already handled this
        print("Using cached data for initial load - skipping API call");
        return;
      }
      
      // Only reset pagination if we're actually loading from API
      currentPage = 1;
      hasMoreData = true;
      
      // Update last access time when making new API request
      await _updateCacheLastAccess();
      
      var getData = await http.get(
        Uri.https(ApiName.v2rp, '${ApiName.woCompletedPage}$currentPage'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);

      setState(() {
        dataaa = caConfirmData['data'] ?? [];
        _foundUsers = dataaa;
        hasMoreData = (caConfirmData['data'] ?? []).length >= 20;
      });

      // Save to cache with error handling
      if (dataaa.isNotEmpty) {
        try {
          await _saveToCache(dataaa, currentPage);
        } catch (cacheError) {
          print("Cache save error (continuing without cache): $cacheError");
          // Continue execution even if cache fails
        }
      }

      print("getdataaaa " + caConfirmData.toString());
      print("dataaaaaaaaaaaaaaa " + dataaa.toString());
    } catch (e) {
      print(e);
    }
  }

  Future<List> getDataaPaginated(int page) async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    
    try {
      print("getDataaPaginated - Loading page: $page");
      
      // Update last access time when making new API request
      await _updateCacheLastAccess();
      
      var getData = await http.get(
        Uri.https(ApiName.v2rp, '${ApiName.woCompletedPage}$page'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);
      return caConfirmData['data'] ?? [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  // New method for search with API call
  Future<List> getDataaWithSearch(String reffno, int page) async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    
    try {
      print("getDataaWithSearch - Searching reffno: $reffno, page: $page");
      
      // Update last access time when making new API request
      await _updateCacheLastAccess();
      
      // Construct URL with search parameters using proper Uri.https with queryParameters
      Map<String, String> queryParams = {
        'reffno': reffno,
        'page': page.toString(),
      };
      
      var uri = Uri.https(ApiName.v2rp, ApiName.woCompleted, queryParams);
      print("Search URI: $uri");
      
      var getData = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);
      
      print("Search API response: ${caConfirmData.toString()}");
      return caConfirmData['data'] ?? [];
    } catch (e) {
      print("Error in search API: $e");
      return [];
    }
  }

  Future<void> getDataa2() async {
    HttpOverrides.global = MyHttpOverrides();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var finalKulonuwun = sharedPreferences.getString('kulonuwun');
    var finalMonggo = sharedPreferences.getString('monggo');
    var kulonuwun = MsgHeader.kulonuwun;
    var monggo = MsgHeader.monggo;
    try {
      // Clear cache on refresh to get fresh data
      await _clearCache();
      
      currentPage = 1;
      hasMoreData = true;
      
      print("getDataa2 (refresh) - Loading fresh data for page: $currentPage");
      
      // Update last access time when making new API request
      await _updateCacheLastAccess();
      
      var getData = await http.get(
        Uri.https(ApiName.v2rp, '${ApiName.woCompletedPage}$currentPage'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'kulonuwun': finalKulonuwun ?? kulonuwun,
          'monggo': finalMonggo ?? monggo,
        },
      );
      final caConfirmData = json.decode(getData.body);

      setState(() {
        dataaa = caConfirmData['data'] ?? [];
        _foundUsers = dataaa;
        hasMoreData = (caConfirmData['data'] ?? []).length >= 20;
      });

      // Save fresh data to cache with error handling
      if (dataaa.isNotEmpty) {
        try {
          await _saveToCache(dataaa, currentPage);
        } catch (cacheError) {
          print("Cache save error (continuing without cache): $cacheError");
          // Continue execution even if cache fails
        }
      }

      print("getdataaaa (refresh) " + caConfirmData.toString());
      print("dataaaaaaaaaaaaaaa (refresh) " + dataaa.toString());
    } catch (e) {
      print(e);
    }
  }

  // Method untuk dipanggil ketika transaksi selesai diproses
  // Panggil method ini dari halaman detail (wo_completed2.dart) setelah approval/reject
  static Future<void> invalidateTransactionCache(String reffno) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Load and update main cache
      final cacheData = prefs.getString(CACHE_KEY);
      if (cacheData != null) {
        List cachedList = json.decode(cacheData);
        
        // Remove completed transaction from main cache
        cachedList.removeWhere((item) => 
          item is Map && 
          item['header'] is Map && 
          item['header']['reffno'] == reffno
        );
        
        // Update cache with JSON-safe data
        List jsonSafeList = [];
        try {
          String jsonString = json.encode(cachedList);
          jsonSafeList = json.decode(jsonString);
        } catch (e) {
          print("Error converting cache to JSON-safe format: $e");
          jsonSafeList = cachedList; // Use original if conversion fails
        }
        
        await prefs.setString(CACHE_KEY, json.encode(jsonSafeList));
        print("Transaction $reffno removed from main cache");
      }
      
      // Load and update page-specific cache
      final cachedPagesData = prefs.getString(CACHE_PAGES_KEY);
      if (cachedPagesData != null) {
        try {
          final Map<String, dynamic> pages = json.decode(cachedPagesData);
          bool cacheUpdated = false;
          
          // Remove transaction from each cached page
          pages.forEach((pageKey, pageData) {
            if (pageData is List) {
              int initialLength = pageData.length;
              pageData.removeWhere((item) => 
                item is Map && 
                item['header'] is Map && 
                item['header']['reffno'] == reffno);
              
              if (pageData.length != initialLength) {
                cacheUpdated = true;
                print("Transaction $reffno removed from cached page $pageKey");
              }
            }
          });
          
          if (cacheUpdated) {
            // Save updated page cache
            await prefs.setString(CACHE_PAGES_KEY, json.encode(pages));
            print("Page cache updated - transaction removed but cache preserved");
          }
        } catch (e) {
          print("Error updating page cache: $e");
          // Don't clear cache on error, just log it
        }
      }
      
      // Update last access time to keep cache valid instead of clearing it
      await prefs.setInt(CACHE_LAST_ACCESS_KEY, DateTime.now().millisecondsSinceEpoch);
      print("Cache last access time updated to keep cache valid");
      
    } catch (e) {
      print("Error invalidating transaction cache: $e");
      // Only clear all cache if there's a critical error
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove(CACHE_KEY);
        await prefs.remove(CACHE_TIMESTAMP_KEY);
        await prefs.remove(CACHE_LAST_ACCESS_KEY);
        await prefs.remove(CACHE_PAGES_KEY);
        print("All cache cleared due to critical error");
      } catch (clearError) {
        print("Error clearing cache: $clearError");
      }
    }
  }

  // Method untuk force refresh dari external call
  void forceRefresh() {
    getDataa2();
  }
}
