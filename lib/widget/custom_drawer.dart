import 'package:advogado_responde/model/user_model.dart';
import 'package:advogado_responde/tiles/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBackground() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 203, 236, 241),
            Colors.white
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Stack(
            children: <Widget>[
              _buildDrawerBackground(),
              ListView(
                padding: EdgeInsets.only(top: 16.0),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 24.0, bottom: 8.0),
                    padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                    height: 170.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 8.0,
                          left: 0.0,
                          child: Text(
                            "Advogado\nResponde",
                            style: TextStyle(
                                fontSize: 34.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ScopedModelDescendant<UserModel>(
                                builder: (context, child, model) {
                                  if (model.isLoading) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Olá,",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${model.userData["name"]} ${model.userData["lastName"]}",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  DrawerTile(Icons.home, "Inicio", pageController, 0),
                  DrawerTile(Icons.fiber_new, "Novo Caso", pageController, 1),
                  DrawerTile(Icons.list, "Seus Casos", pageController, 2),
                  DrawerTile(Icons.chat, "Chat", pageController, 3),
                  DrawerTile(Icons.person, "Perfil", pageController, 4),
                  DrawerTile(Icons.exit_to_app, "Sair", pageController, 5),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
