import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// import '../mainScreen/home_screen2.dart';
import '../approval_screen/approval_screen.dart';
import '../home_screen/home_screen.dart';
// import '../mainScreen/setting_screen.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 1;
  final screen = [const HomeScreen(), const ApprovalScreen()];
  final GlobalKey _key = GlobalKey();
  GlobalKey getKey() => _key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: getKey(),
        index: selectedIndex,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.my_library_books_rounded,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: HexColor("#F4A62A"),
        buttonBackgroundColor: HexColor('##F4A62A'),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOutBack,
        animationDuration: const Duration(milliseconds: 400),
        height: 70,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: screen[selectedIndex],
    );
  }
}
