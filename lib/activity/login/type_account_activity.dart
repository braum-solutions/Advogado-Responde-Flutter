import 'package:advogado_responde/activity/login/oab_code_activity.dart';
import 'package:advogado_responde/activity/login/sign_up_activity.dart';
import 'package:flutter/material.dart';

class TypeAccountActivity extends StatefulWidget {
  String _name;
  String _lastName;
  String _imagePath;
  TypeAccountActivity(this._name, this._lastName, this._imagePath);

  @override
  _TypeAccountActivityState createState() =>
      _TypeAccountActivityState(_name, _lastName, _imagePath);
}

class _TypeAccountActivityState extends State<TypeAccountActivity> {
  String _name;
  String _lastName;
  String _imagePath;
  _TypeAccountActivityState(this._name, this._lastName, this._imagePath);

  @override
  Widget build(BuildContext context) {
    final title = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "${_name}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.blue),
        ),
        Text(", O que você é?",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700]))
      ],
    );

    final userButton = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpActivity(_name, _lastName, _imagePath, "0", null, null)));
      },
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child:
          Text("Sou um(a) Usuário(a)", style: TextStyle(color: Colors.white)),
    );

    final lawyerButton = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => OABCodeActivity(_name, _lastName, _imagePath, "1")));
      },
      padding: EdgeInsets.all(16),
      color: Theme.of(context).primaryColor,
      child:
          Text("Sou um(a) Advogado(a)", style: TextStyle(color: Colors.white)),
    );

    final subtitle = Text(
        "Precisamos saber que tipo de pessoa você é para podermos dar segmento com o seu cadastro",
        style: TextStyle(
          fontSize: 11.0,
        ),
        textAlign: TextAlign.center);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0.0,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 32.0, right: 32.0),
          children: <Widget>[
            title,
            SizedBox(height: 8.0),
            subtitle,
            SizedBox(height: 12.0),
            userButton,
            SizedBox(height: 8.0),
            lawyerButton
          ],
        ),
      ),
    );
  }
}
