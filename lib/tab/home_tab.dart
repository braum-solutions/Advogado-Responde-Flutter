import 'package:advogado_responde/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 27, 27, 27),
            const Color.fromARGB(255, 66, 66, 66)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                model.reloadUserData();
                return SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text("Advogado Responde"),
                    centerTitle: true,
                  ),
                );
              },
            )
          ],
        )
      ],
    );
  }
}
