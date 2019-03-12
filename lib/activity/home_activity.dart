import 'package:advogado_responde/model/user_model.dart';
import 'package:advogado_responde/tab/home_tab.dart';
import 'package:advogado_responde/tab/profile_tab.dart';
import 'package:advogado_responde/tab/your_cases_tab.dart';
import 'package:advogado_responde/widget/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();

    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: model.userData["type"] == "0"
              ? <Widget>[
                  Scaffold(
                    body: HomeTab(),
                    drawer: CustomDrawer(_pageController),
                  ),
                  //? Test
                  Scaffold(
                    body: HomeTab(),
                    drawer: CustomDrawer(_pageController),
                  ),
                  //? Test
                  Scaffold(
                    body: YourCases(),
                    drawer: CustomDrawer(_pageController),
                  ),
                  //? Test
                  Scaffold(
                    body: HomeTab(),
                    drawer: CustomDrawer(_pageController),
                  ),
                  Scaffold(
                    body: ProfileTab(),
                    drawer: CustomDrawer(_pageController),
                  ),
                ]
              : <Widget>[
                  Scaffold(
                    body: HomeTab(),
                    drawer: CustomDrawer(_pageController),
                  ),
                  //? Test
                  Scaffold(
                    body: HomeTab(),
                    drawer: CustomDrawer(_pageController),
                  ),
                  //? Test
                  Scaffold(
                    body: HomeTab(),
                    drawer: CustomDrawer(_pageController),
                  ),
                  //? Test
                  Scaffold(
                    body: HomeTab(),
                    drawer: CustomDrawer(_pageController),
                  ),
                  Scaffold(
                    body: ProfileTab(),
                    drawer: CustomDrawer(_pageController),
                  ),
                ],
        );
      },
    );
  }
}
