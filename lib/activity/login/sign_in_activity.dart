import 'package:advogado_responde/activity/home_activity.dart';
import 'package:advogado_responde/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

class SignInActivity extends StatefulWidget {
  @override
  _SignInActivityState createState() => _SignInActivityState();
}

class _SignInActivityState extends State<SignInActivity> {
  String _email, _password;

  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final welcome = Text(
      "Bem vindo de volta",
      style: TextStyle(
          fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
    );

    final login_continue = Text(
      "Faça o login para continuar",
      style: TextStyle(color: Colors.grey[700]),
    );

    Widget email() {
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
        controller: emailController,
        decoration: InputDecoration(
            labelText: "E-mail",
            labelStyle: TextStyle(color: Colors.blue),
            contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      );
    }

    Widget password() {
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
        controller: senhaController,
        decoration: InputDecoration(
            labelText: "Senha",
            labelStyle: TextStyle(color: Colors.blue),
            contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      );
    }

    Widget login_button() {
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
                    model.signIn(
                        email: _email,
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
                child: Text('ENTRAR', style: TextStyle(color: Colors.white)));
          }
        },
      );
    }

    void onFailRec() {
      _showSnackbar("Erro ao recuperar a senha!", Colors.red);
    }

    void onSucessRec() {
      _showSnackbar("E-mail de recuperação de senha enviado!", Colors.green);
    }

    Widget forgot_password() {
      return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoadingRec) {
          return Center(child: CircularProgressIndicator());
        } else {
          return FlatButton(
              onPressed: () {
                if (emailController.text.isEmpty) {
                  _showSnackbar("Preencha seu e-mail para recuperar a senha",
                      Colors.yellow);
                } else {
                  model.recoveryPassword(
                      email: emailController.text,
                      onFail: onFailRec,
                      onSucess: onSucessRec);
                }
              },
              child: Text(
                "ESQUECEU SUA SENHA?",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ));
        }
      });
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Center(
          child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 32.0, right: 32.0),
        children: <Widget>[
          welcome,
          login_continue,
          Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: <Widget>[
                email(),
                SizedBox(height: 8.0),
                password(),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          login_button(),
          SizedBox(height: 8.0),
          forgot_password()
        ],
      )),
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
    _showSnackbar("Usuário logado com sucesso!", Colors.green);
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeActivity()));
    });
  }

  void _onFail() {
    _showSnackbar("Falha ao criar o usuário!", Colors.red);
  }
}
