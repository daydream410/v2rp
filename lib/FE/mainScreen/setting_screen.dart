// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2rp1/FE/mainScreen/login_screen4.dart';
import 'package:v2rp1/FE/navbar/navbar.dart';
import 'package:v2rp1/main.dart' show getAndSaveFcmToken;

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? finalEmail = '';
  String? finalUsername = '';
  bool _isLoading = true;
  Map<String, dynamic>? _profileData;
  String? _errorMessage;
  bool _isLoadingRoles = false;
  List<Map<String, dynamic>> _roles = [];

  @override
  void initState() {
    super.initState();
    getEmail();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? kulonuwun = prefs.getString('kulonuwun');
      final String? monggo = prefs.getString('monggo');

      if (kulonuwun == null || monggo == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Session expired. Please login again.';
        });
        return;
      }

      var headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'kulonuwun': kulonuwun,
        'monggo': monggo,
      };

      var request = http.Request(
        'GET',
        Uri.parse('https://v2rp.net/dev/api/v2/mobile/profile'),
      );

      request.headers.addAll(headers);

      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Connection timeout. Please try again.');
        },
      );

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData['success'] == true && responseData['data'] != null) {
          setState(() {
            _profileData = responseData['data'] as Map<String, dynamic>;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = responseData['message'] ?? 'Failed to load profile';
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'Failed to load profile. Status: ${response.statusCode}';
        });
      }
    } on TimeoutException {
      setState(() {
        _isLoading = false;
        _errorMessage =
            'Connection timeout. Please check your internet connection.';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error loading profile: $e';
      });
      print('Profile fetch error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isTablet = size.width > 600;
    double responsivePadding = isTablet ? 32.0 : 16.0;

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
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
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        );
        if (shouldPop == true) {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: fetchProfile,
            color: HexColor("#F4A62A"),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(responsivePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.02),
                    // Profile Header Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            HexColor("#F4A62A"),
                            HexColor("#F4A62A").withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor("#F4A62A").withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isTablet ? 32.0 : 24.0),
                        child: Column(
                          children: [
                            // Profile Picture
                            Container(
                              width: isTablet ? 120.0 : 100.0,
                              height: isTablet ? 120.0 : 100.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'images/pp.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.white,
                                      child: Icon(
                                        Icons.person,
                                        size: isTablet ? 60.0 : 50.0,
                                        color: HexColor("#F4A62A"),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: isTablet ? 20.0 : 16.0),
                            // Email
                            if (finalEmail != null && finalEmail!.isNotEmpty)
                              Text(
                                finalEmail!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 20.0 : 18.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            SizedBox(height: isTablet ? 12.0 : 8.0),
                            // Username
                            if (finalUsername != null &&
                                finalUsername!.isNotEmpty)
                              Text(
                                finalUsername!,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: isTablet ? 16.0 : 14.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // Profile Information Card
                    if (_isLoading)
                      Container(
                        padding: EdgeInsets.all(40),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              HexColor("#F4A62A"),
                            ),
                          ),
                        ),
                      )
                    else if (_errorMessage != null)
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red[200]!),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 40,
                            ),
                            SizedBox(height: 12),
                            Text(
                              _errorMessage!,
                              style: TextStyle(
                                color: Colors.red[900],
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: fetchProfile,
                              icon: Icon(Icons.refresh),
                              label: Text('Retry'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: HexColor("#F4A62A"),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    else if (_profileData != null)
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isTablet ? 24.0 : 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.person_outline,
                                    color: HexColor("#F4A62A"),
                                    size: isTablet ? 28.0 : 24.0,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Profile Information',
                                    style: TextStyle(
                                      fontSize: isTablet ? 22.0 : 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              _buildInfoRow(
                                icon: Icons.badge,
                                label: 'Role',
                                value: _profileData!['role'] ?? 'N/A',
                                isTablet: isTablet,
                              ),
                              Divider(height: 32),
                              _buildInfoRow(
                                icon: Icons.business,
                                label: 'Company',
                                value: _profileData!['company'] ?? 'N/A',
                                isTablet: isTablet,
                              ),
                              Divider(height: 32),
                              _buildInfoRow(
                                icon: Icons.business_center,
                                label: 'Company Name',
                                value: _profileData!['companyname'] ?? 'N/A',
                                isTablet: isTablet,
                                isMultiline: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: size.height * 0.02),
                    // Change Company Button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor("#F4A62A").withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed:
                            _isLoadingRoles ? null : _showChangeCompanyDialog,
                        icon: _isLoadingRoles
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Icon(
                                Icons.business_center,
                                size: isTablet ? 24.0 : 20.0,
                              ),
                        label: Text(
                          _isLoadingRoles ? 'Loading...' : 'Change Company',
                          style: TextStyle(
                            fontSize: isTablet ? 18.0 : 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor("#F4A62A"),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 18.0 : 16.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // Logout Button
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm Logout'),
                              content: const Text(
                                'Are you sure you want to logout?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: const Text('Logout'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.remove('username');
                            sharedPreferences.remove('email');
                            sharedPreferences.remove('password');
                            sharedPreferences.remove('kulonuwun');
                            sharedPreferences.remove('monggo');
                            sharedPreferences.remove('seckey');
                            sharedPreferences.remove('otp_roles');
                            await sharedPreferences.clear();

                            Get.offAll(() => const LoginPage4());
                            Get.snackbar(
                              "Success Logout",
                              "From V2RP Mobile",
                              colorText: Colors.white,
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.red,
                              isDismissible: true,
                              dismissDirection: DismissDirection.vertical,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: isTablet ? 18.0 : 16.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              size: isTablet ? 24.0 : 20.0,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'LOGOUT',
                              style: TextStyle(
                                fontSize: isTablet ? 20.0 : 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    // Version Card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isTablet ? 24.0 : 20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: HexColor("#F4A62A"),
                              size: isTablet ? 28.0 : 24.0,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Version',
                              style: TextStyle(
                                fontSize: isTablet ? 18.0 : 16.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '1.2.7',
                              style: TextStyle(
                                fontSize: isTablet ? 18.0 : 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required bool isTablet,
    bool isMultiline = false,
  }) {
    return Row(
      crossAxisAlignment:
          isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: HexColor("#F4A62A"),
          size: isTablet ? 24.0 : 20.0,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: isTablet ? 14.0 : 12.0,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: isTablet ? 16.0 : 15.0,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.w600,
                ),
                maxLines: isMultiline ? 3 : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future getEmail() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      finalEmail = sharedPreferences.getString('email');
      finalUsername = sharedPreferences.getString('username');
    });
  }

  Future<void> _fetchRoles() async {
    setState(() {
      _isLoadingRoles = true;
      _roles = [];
    });

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? kulonuwun = prefs.getString('kulonuwun');
      final String? monggo = prefs.getString('monggo');

      if (kulonuwun == null || monggo == null) {
        if (mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: 'Session expired. Please login again.',
            barrierDismissible: true,
            confirmBtnColor: HexColor("#F4A62A"),
          );
        }
        setState(() {
          _isLoadingRoles = false;
        });
        return;
      }

      var headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'kulonuwun': kulonuwun,
        'monggo': monggo,
      };

      var request = http.Request(
        'GET',
        Uri.parse('https://v2rp.net/dev/api/v2/mobile/change/role'),
      );

      request.headers.addAll(headers);

      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Connection timeout. Please try again.');
        },
      );

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData['success'] == true && responseData['data'] != null) {
          List<dynamic> rolesList = responseData['data'] as List<dynamic>;
          setState(() {
            _roles =
                rolesList.map((role) => role as Map<String, dynamic>).toList();
            _isLoadingRoles = false;
          });
        } else {
          setState(() {
            _isLoadingRoles = false;
          });
          if (mounted) {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: responseData['message'] ?? 'Failed to load roles',
              barrierDismissible: true,
              confirmBtnColor: HexColor("#F4A62A"),
            );
          }
        }
      } else {
        setState(() {
          _isLoadingRoles = false;
        });
        if (mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: 'Failed to load roles. Status: ${response.statusCode}',
            barrierDismissible: true,
            confirmBtnColor: HexColor("#F4A62A"),
          );
        }
      }
    } on TimeoutException {
      setState(() {
        _isLoadingRoles = false;
      });
      if (mounted) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Connection Timeout',
          text: 'Please check your internet connection and try again.',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
      }
    } catch (e) {
      setState(() {
        _isLoadingRoles = false;
      });
      if (mounted) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Error loading roles: $e',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
      }
      print('Fetch roles error: $e');
    }
  }

  void _showChangeCompanyDialog() {
    _fetchRoles().then((_) {
      if (!mounted || _roles.isEmpty) return;

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          Size dialogSize = MediaQuery.of(context).size;
          bool isTabletDialog = dialogSize.width > 600;
          double dialogPadding = isTabletDialog ? 24.0 : 20.0;
          double dialogTitleFontSize = isTabletDialog ? 24.0 : 22.0;
          double dialogIconSize = isTabletDialog ? 32.0 : 28.0;
          double roleCardPadding = isTabletDialog ? 20.0 : 16.0;
          double roleIconSize = isTabletDialog ? 60.0 : 50.0;
          double roleIconInnerSize = isTabletDialog ? 32.0 : 28.0;
          double roleTitleFontSize = isTabletDialog ? 18.0 : 16.0;
          double roleSubtitleFontSize = isTabletDialog ? 15.0 : 14.0;
          double roleCompanyFontSize = isTabletDialog ? 13.0 : 12.0;
          double roleBadgeFontSize = isTabletDialog ? 11.0 : 10.0;
          double listPadding = isTabletDialog ? 20.0 : 16.0;
          double maxDialogWidth = isTabletDialog ? 600.0 : double.infinity;

          return Container(
            height: dialogSize.height * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(dialogPadding),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        HexColor("#F4A62A"),
                        HexColor("#F4A62A").withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.business_center,
                        color: Colors.white,
                        size: dialogIconSize,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Change Company',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: dialogTitleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: isTabletDialog ? 28.0 : 24.0,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                // Roles List
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxDialogWidth),
                      child: ListView.builder(
                        padding: EdgeInsets.all(listPadding),
                        itemCount: _roles.length,
                        itemBuilder: (context, index) {
                          final role = _roles[index];
                          final currentRole = _profileData?['role'] ?? '';
                          final currentCompany = _profileData?['company'] ?? '';
                          final isCurrentRole = role['role'] == currentRole &&
                              role['company'] == currentCompany;

                          return Container(
                            margin: EdgeInsets.only(
                              bottom: isTabletDialog ? 16.0 : 12.0,
                            ),
                            decoration: BoxDecoration(
                              color: isCurrentRole
                                  ? HexColor("#F4A62A").withOpacity(0.1)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isCurrentRole
                                    ? HexColor("#F4A62A")
                                    : Colors.grey[300]!,
                                width: isCurrentRole ? 2 : 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: isCurrentRole
                                    ? null
                                    : () => _chooseRole(role),
                                borderRadius: BorderRadius.circular(16),
                                child: Padding(
                                  padding: EdgeInsets.all(roleCardPadding),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: roleIconSize,
                                        height: roleIconSize,
                                        decoration: BoxDecoration(
                                          color: HexColor("#F4A62A")
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Icon(
                                          Icons.business,
                                          color: HexColor("#F4A62A"),
                                          size: roleIconInnerSize,
                                        ),
                                      ),
                                      SizedBox(
                                          width: isTabletDialog ? 20.0 : 16.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    role['role'] ?? 'N/A',
                                                    style: TextStyle(
                                                      fontSize:
                                                          roleTitleFontSize,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey[900],
                                                    ),
                                                  ),
                                                ),
                                                if (isCurrentRole)
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: isTabletDialog
                                                          ? 10.0
                                                          : 8.0,
                                                      vertical: isTabletDialog
                                                          ? 6.0
                                                          : 4.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#F4A62A"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    child: Text(
                                                      'Current',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            roleBadgeFontSize,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              role['companyname'] ?? 'N/A',
                                              style: TextStyle(
                                                fontSize: roleSubtitleFontSize,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 4),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.domain,
                                                  size: isTabletDialog
                                                      ? 14.0
                                                      : 12.0,
                                                  color: Colors.grey[600],
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  role['company'] ?? 'N/A',
                                                  style: TextStyle(
                                                    fontSize:
                                                        roleCompanyFontSize,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (!isCurrentRole)
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: HexColor("#F4A62A"),
                                          size: isTabletDialog ? 22.0 : 20.0,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Future<void> _chooseRole(Map<String, dynamic> role) async {
    Navigator.of(context).pop(); // Close dialog

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fcmToken = prefs.getString('fcm_token');
      final String? seckey = role['seckey'];

      if (seckey == null || seckey.isEmpty) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Invalid role data',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
        return;
      }

      // If FCM token is not available, get it first
      if (fcmToken == null || fcmToken.isEmpty) {
        fcmToken = await getAndSaveFcmToken();
      }

      String platform = Platform.isAndroid ? 'android' : 'ios';

      var headers = {
        'Content-Type': 'application/json',
      };

      var request = http.Request(
        'POST',
        Uri.parse('https://v2rp.net/dev/api/v2/mobile/choose/role/$seckey'),
      );

      request.body = jsonEncode({
        'fcmtoken': fcmToken ?? '',
        'platform': platform,
      });

      request.headers.addAll(headers);

      var streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw TimeoutException('Connection timeout. Please try again.');
        },
      );

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData['success'] == true && responseData['data'] != null) {
          var data = responseData['data'] as Map<String, dynamic>;
          String? newKulonuwun = data['kulonuwun'];
          String? newMonggo = data['monggo'];

          if (newKulonuwun != null && newMonggo != null) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setString('kulonuwun', newKulonuwun);
            await prefs.setString('monggo', newMonggo);

            // Refresh profile data
            await fetchProfile();

            if (mounted) {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                title: 'Success',
                text: 'Company changed successfully',
                barrierDismissible: true,
                confirmBtnColor: HexColor("#F4A62A"),
                onConfirmBtnTap: () {
                  Navigator.of(context).pop();
                  // Navigate to navbar to refresh the app
                  Get.offAll(const Navbar());
                },
              );
            }
          } else {
            throw Exception('Invalid response data');
          }
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: responseData['message'] ?? 'Failed to change company',
            barrierDismissible: true,
            confirmBtnColor: HexColor("#F4A62A"),
          );
        }
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Failed to change company. Status: ${response.statusCode}',
          barrierDismissible: true,
          confirmBtnColor: HexColor("#F4A62A"),
        );
      }
    } on TimeoutException {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Connection Timeout',
        text: 'Please check your internet connection and try again.',
        barrierDismissible: true,
        confirmBtnColor: HexColor("#F4A62A"),
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error changing company: $e',
        barrierDismissible: true,
        confirmBtnColor: HexColor("#F4A62A"),
      );
      print('Choose role error: $e');
    }
  }
}
