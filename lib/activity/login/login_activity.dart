import 'package:advogado_responde/activity/login/sign_in_activity.dart';
import 'package:advogado_responde/activity/login/name_lastname_activity.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LoginActivity extends StatefulWidget {
  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  List<String> textSlider = new List();

  @override
  void initState() {
    super.initState();
    textSlider.add("FAÇA PERGUNTAS PARA\nADVOGADOS ONLINE");
    textSlider.add("SEM SAIR DE CASA\nTUDO EM SEU CELULAR");
    textSlider.add("ADVOGADOS VERIFICADOS\nPELO SITE DA OAB");
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 27, 27, 27),
            const Color.fromARGB(255, 50, 50, 50)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    final _textSlider = CarouselSlider(
        autoPlay: true,
        height: 50.0,
        autoPlayDuration: new Duration(seconds: 2),
        interval: new Duration(seconds: 3),
        items: textSlider.map((txt) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 30.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(color: Colors.transparent),
                child: Text(
                  txt,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                )),
          );
        }).toList());

    final _logoImage = Image.asset(
      "assets/arlogo.png",
      width: 150.0,
      height: 150.0,
    );

    final _createAccountButton = Padding(
      padding: EdgeInsets.fromLTRB(32.0, 4.0, 32.0, 4.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NameLastnameActivity()));
        },
        padding: EdgeInsets.all(16),
        color: Colors.blue,
        child:
            Text('Crie sua conta agora mesmo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
      ),
    );

    final _haveAccountButton = FlatButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignInActivity()));
        },
        child: Text(
          "Você já tem uma conta?",
          style: TextStyle(color: Colors.white),
        ));

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _logoImage,
              SizedBox(height: 16.0),
              _textSlider,
              _createAccountButton,
              _haveAccountButton
            ],
          ),
        )
      ],
    );
  }
}
