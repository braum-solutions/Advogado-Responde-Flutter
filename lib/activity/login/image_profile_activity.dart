import 'dart:io';

import 'package:advogado_responde/activity/login/type_account_activity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfileActivity extends StatefulWidget {
  String name ;
  String lastName;
  ImageProfileActivity(this.name, this.lastName);

  @override
  _ImageProfileActivityState createState() =>
      _ImageProfileActivityState(name, lastName);
}

class _ImageProfileActivityState extends State<ImageProfileActivity> {
  String _name;
  String _lastName;
  _ImageProfileActivityState(this._name, this._lastName);

  String _imagePath = null;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      "Que tal uma foto?",
      style: TextStyle(
          fontSize: 20.0, color: Colors.grey[700], fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );

    final subtitle = Text(
      "Escolha uma imagem de sua galeria ou tire uma foto pela câmera para que os outros usuários possam saber quem você é.",
      style: TextStyle(
        fontSize: 12.0,
      ),
      textAlign: TextAlign.center,
    );

    final image = Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100.0),
        child: Container(
          width: 140.0,
          height: 140.0,
          decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: _imagePath == null
                      ? AssetImage("assets/person.png")
                      : FileImage(File(_imagePath)))),
        ),
      ),
    );

    void pickImage(ImageSource type) {
      ImagePicker.pickImage(source: type).then((file) {
        if (file == null)
          return;
        else
          setState(() {
            _imagePath = file.path;
          });
      });
    }

    void _settingModalBottomSheet(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.camera_alt),
                      title: new Text('Câmera'),
                      onTap: () {
                        Navigator.pop(context);
                        pickImage(ImageSource.camera);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.panorama),
                    title: new Text('Galeria'),
                    onTap: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            );
          });
    }

    final choose_image = FlatButton(
        onPressed: () {
          _settingModalBottomSheet(context);
        },
        child: Text(
          "Escolher Imagem",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ));

    final continue_button = RaisedButton(
      onPressed: () {
        _imagePath.isEmpty
            ? Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Escolha uma foto para continuar"),
                duration: Duration(seconds: 3)))
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => TypeAccountActivity(_name, _lastName, _imagePath)));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child: Text(
        "Continuar",
        style: TextStyle(color: Colors.white),
      ),
    );

    return Scaffold(
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
            title,
            SizedBox(height: 10.0),
            subtitle,
            SizedBox(height: 10.0),
            image,
            SizedBox(height: 2.0),
            choose_image,
            SizedBox(height: 2.0),
            continue_button
          ],
        ),
      ),
    );
  }
}
