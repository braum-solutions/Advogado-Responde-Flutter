import 'package:advogado_responde/activity/new_case/type_case.dart';
import 'package:advogado_responde/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DrawerTile extends StatefulWidget {
  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  DrawerTileState createState() {
    return new DrawerTileState();
  }
}

class DrawerTileState extends State<DrawerTile> {
  Future<void> _logout() async {
    return await FirebaseAuth.instance.signOut();
  }

  Future<bool> _dialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Finalizar Sessão"),
            content: Text("Deseja realmente finalizar a sessão do aplicativo?"),
            actions: <Widget>[
              FlatButton(
                child: const Text("Sair"),
                onPressed: () {
                  _logout();
                  Navigator.of(context).pop(true);
                },
              ),
              FlatButton(
                child: const Text("Cancelar"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                if (model.userData["type"] == "1") {
                  if (widget.page == 5) {
                    model.signOut();
                  } else if (widget.page == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TypeCase()));
                  } else {
                    Navigator.of(context).pop();
                    widget.pageController.jumpToPage(widget.page);
                  }
                } else {
                  if (widget.page == 5) {
                    model.signOut();
                  } else {
                    Navigator.of(context).pop();
                    widget.pageController.jumpToPage(widget.page);
                  }
                }
              });
            },
            child: Container(
              margin: EdgeInsets.only(left: 24.0),
              height: 60.0,
              child: Row(
                children: <Widget>[
                  Icon(
                    widget.icon,
                    size: 32.0,
                    color: widget.pageController.page == widget.page
                        ? Colors.blue
                        : Colors.grey[700],
                  ),
                  SizedBox(
                    width: 32.0,
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: widget.pageController.page.round() == widget.page
                            ? Colors.blue
                            : Colors.grey[700]),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
