import 'package:advogado_responde/activity/home_activity.dart';
import 'package:advogado_responde/activity/login/login_activity.dart';
import 'package:advogado_responde/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(AdvogadoResponde());

class AdvogadoResponde extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
          title: "Advogado Responde",
          theme: ThemeData(
              primaryColor: const Color.fromARGB(255, 66, 66, 66),
              primarySwatch: Colors.blue),
          debugShowCheckedModeBanner: false,
          home: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if (model.isLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (model.isLogedIn()) {
                  return HomeActivity();
                } else {
                  return LoginActivity();
                }
              }
            },
          )),
    );
  }
}
