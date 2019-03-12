import 'dart:io';

import 'package:advogado_responde/activity/home_activity.dart';
import 'package:advogado_responde/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpActivity extends StatefulWidget {
  String _name, _lastName, _imagePath, _type, _oabCode, _oabUF;
  SignUpActivity(this._name, this._lastName, this._imagePath, this._type,
      this._oabCode, this._oabUF);

  @override
  _SignUpActivityState createState() => _SignUpActivityState(
      _name, _lastName, _imagePath, _type, _oabCode, _oabUF);
}

class _SignUpActivityState extends State<SignUpActivity> {
  String _name,
      _lastName,
      _imagePath,
      _type,
      _oabCode,
      _oabUF,
      _email,
      _password,
      _confirmPassword,
      _uid;
  _SignUpActivityState(this._name, this._lastName, this._imagePath, this._type,
      this._oabCode, this._oabUF);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypePasswordController = TextEditingController();

  Widget title() {
    return Row(
      children: <Widget>[
        Text(
          "Oi, ",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
              fontSize: 20.0),
        ),
        Text(
          "${_name}",
          style: TextStyle(
              color: Colors.blue, fontSize: 20.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  final subtitle = Text(
    "Cadastre-se para continuar",
    style: TextStyle(fontSize: 11.0, color: Colors.grey[700]),
  );

  Widget textInputEmail(TextEditingController tec, String name) {
    return TextFormField(
      validator: (value) {
        if (value.length == 0) {
          return "Insira seu E-mail";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _email = value;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: tec,
      decoration: InputDecoration(
          labelText: name,
          contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          labelStyle: TextStyle(color: Colors.blue),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  Widget textInputPassword(TextEditingController tec, String name) {
    return TextFormField(
      validator: (value) {
        if (value.length == 0) {
          return "Insira sua senha";
        } else if (value.length < 6) {
          return "Sua senha deve ter mais de 6 digitos";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _password = value;
      },
      obscureText: true,
      autofocus: false,
      controller: tec,
      decoration: InputDecoration(
          labelText: name,
          contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          labelStyle: TextStyle(color: Colors.blue),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  Widget textInputConfirmPassword(TextEditingController tec, String name) {
    return TextFormField(
      validator: (value) {
        if (value.length == 0) {
          return "Confirme sua senha";
        } else if (value.length < 6) {
          return "Sua senha deve ter mais de 6 digitos";
        } else if (value != passwordController.text) {
          print("value: ${value} password: ${passwordController.text}");
          return "Senhas não conferem";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _confirmPassword = value;
      },
      obscureText: true,
      autofocus: false,
      controller: tec,
      decoration: InputDecoration(
          labelText: name,
          contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          labelStyle: TextStyle(color: Colors.blue),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );
  }

  Widget sign_up_button() {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        if (model.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                Map<String, dynamic> userData;
                _type == "1"
                    ? userData = {
                        "email": _email,
                        "name": _name,
                        "lastName": _lastName,
                        "oabCode": _oabCode,
                        "oabUf": _oabUF,
                        "type": "1"
                      }
                    : userData = {
                        "email": _email,
                        "name": _name,
                        "lastName": _lastName,
                        "type": "0"
                      };

                model.signUp(
                    userData: userData,
                    imagePath: _imagePath,
                    password: _password,
                    onSuccess: _onSuccess,
                    onFail: _onFail);
              } else {
                setState(() {
                  _autoValidate = true;
                });
              }
            },
            padding: EdgeInsets.all(16),
            color: Colors.blue,
            child: Text('CADASTRAR', style: TextStyle(color: Colors.white)),
          );
        }
      },
    );
  }

  void _showSnackbar(String text, Color color) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 2),
    ));
  }

  void _onSuccess() {
    _showSnackbar("Usuário criado com sucesso!", Colors.green);
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeActivity()));
    });
  }

  void _onFail() {
    _showSnackbar("Falha ao criar o usuário!", Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 32.0, right: 32.0),
          children: <Widget>[
            title(),
            SizedBox(height: 8.0),
            subtitle,
            SizedBox(height: 8.0),
            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[
                  textInputEmail(emailController, "E-mail"),
                  textInputPassword(passwordController, "Senha"),
                  textInputConfirmPassword(
                      retypePasswordController, "Confirme sua senha"),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            sign_up_button()
          ],
        ),
      ),
    );
  }
}
