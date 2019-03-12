import 'package:advogado_responde/activity/edit_profile_activity.dart';
import 'package:advogado_responde/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  Widget _listTileWidget(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _lawyerTile(UserModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _listTileWidget(
            "Nome Completo",
            "${model.userData["name"]} ${model.userData["lastName"]}",
            Icons.person),
        _listTileWidget(
            "Telefone",
            model.userData["phone"] == null
                ? "Não inserido"
                : model.userData["phone"],
            Icons.phone),
        _listTileWidget(
            "Endereço Profissional",
            model.userData["address"] == null
                ? "Não inserido"
                : "${model.userData["address"]}, ${model.userData["number"]}, ${model.userData["neighborhood"]}\n${model.userData["city"]} - ${model.userData["uf"]}\n${model.userData["zipcode"]}",
            Icons.map),
        _listTileWidget(
            "Mini Curriculo",
            model.userData["curriculum"] == null
                ? "Não inserido"
                : model.userData["curriculum"],
            Icons.book),
        SizedBox(height: 10.0)
      ],
    );
  }

  Widget _userTile(UserModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _listTileWidget(
            "Nome Completo",
            "${model.userData["name"]} ${model.userData["lastName"]}",
            Icons.person),
        _listTileWidget("E-mail", model.getUserEmail(), Icons.email),
        _listTileWidget(
            "Telefone",
            model.userData["phone"] == null
                ? "Não inserido"
                : "${model.userData["ddd"]}${model.userData["phone"]}",
            Icons.phone),
        _listTileWidget(
            "Endereço",
            model.userData["address"] == null
                ? "Não inserido"
                : "${model.userData["address"]}, ${model.userData["number"]}, ${model.userData["neighborhood"]}\n${model.userData["city"]} - ${model.userData["uf"]}\n${model.userData["zipcode"]}",
            Icons.map),
        SizedBox(height: 10.0)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrooled) {
          return <Widget>[
            ScopedModelDescendant<UserModel>(
              builder: (context, child, model) {
                return SliverAppBar(
                    actions: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditProfile()));
                        },
                        color: Colors.white,
                        icon: Icon(Icons.edit),
                      )
                    ],
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(
                        "Perfil",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      background: Image.network(
                        model.userData["image"],
                        fit: BoxFit.cover,
                      ),
                    ));
              },
            )
          ];
        },
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(12.0),
          children: <Widget>[
            Card(
                elevation: 2.0,
                child: ScopedModelDescendant<UserModel>(
                  builder: (context, child, model) {
                    if (model.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (model.userData["type"] == "1") {
                        return _lawyerTile(model);
                      } else {
                        return _userTile(model);
                      }
                    }
                  },
                ))
          ],
        ));
  }
}
