import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:moodo/model/style.dart';
import 'package:moodo/view/favPage.dart';
import 'package:moodo/view/homePage.dart';
import 'package:moodo/view/listDoaPage.dart';
import 'package:moodo/view/pagiPetang.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<StatefulWidget> pages = [
    HomePage(),
    ListDoaPage(),
    PagiPetangPage(),
    FavPage()
  ];

  PageController controller = PageController();

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Moodo",
      theme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: Colors.teal,
          accentColor: Colors.tealAccent),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: DoubleBackToCloseApp(
          snackBar: SnackBar(
            content: Text(
              "Tap back again to exit",
              style: TextStyle(
                color: Colors.teal,
                fontFamily: "Poppins",
                fontSize: 14,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
            backgroundColor: Colors.white,
            elevation: 2.0,
            margin: EdgeInsets.only(bottom: 33, left: 16, right: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100.0))),
          ),
          child: Scaffold(
            extendBody: true,
            body: PageView.builder(
                itemCount: 4,
                controller: controller,
                onPageChanged: (page) {
                  setState(() {
                    _selectedIndex = page;
                  });
                },
                itemBuilder: (context, position) {
                  return pages[position];
                }),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(bottom: 24, right: 8, left: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  gradient: Style().gradasi,
                  borderRadius: BorderRadius.circular(64),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        color: Colors.white,
                        offset: Offset(0, 0))
                  ]),
              child: SafeArea(
                  child: GNav(
                      // curve: Curves.fastOutSlowIn,
                      rippleColor: Color(0xff65db9f),
                      hoverColor: Color(0xff65db9f),
                      gap: 0,
                      activeColor: Colors.teal,
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      duration: Duration(milliseconds: 800),
                      tabBackgroundColor: Colors.white,
                      tabs: [
                        GButton(
                            icon: Icons.home_rounded,
                            iconColor: Colors.white,
                            text: ' Home',
                            textStyle: TextStyle(
                              color: Colors.teal,
                              fontFamily: "Poppins",
                              fontSize: 14,
                            )),
                        GButton(
                          icon: Icons.search,
                          iconColor: Colors.white,
                          text: ' Cari doa',
                          textStyle: TextStyle(
                            color: Colors.teal,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                        GButton(
                          icon: Icons.wb_sunny,
                          iconColor: Colors.white,
                          text: ' Pagi - Petang',
                          textStyle: TextStyle(
                            color: Colors.teal,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                        GButton(
                          icon: Icons.favorite_outlined,
                          iconColor: Colors.white,
                          text: ' Favorite',
                          textStyle: TextStyle(
                            color: Colors.teal,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                      ],
                      selectedIndex: _selectedIndex,
                      onTabChange: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                        controller.jumpToPage(index);
                      })),
            ),
          ),
        ),
      ),
    );
  }
}
