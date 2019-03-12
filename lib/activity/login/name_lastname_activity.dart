import 'package:advogado_responde/activity/login/image_profile_activity.dart';
import 'package:flutter/material.dart';

class NameLastnameActivity extends StatefulWidget {
  @override
  _NameLastnameActivityState createState() => _NameLastnameActivityState();
}

class _NameLastnameActivityState extends State<NameLastnameActivity> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String textName = "";
  String _name;
  String _lastName;

  void nameControllerObserver() {
    setState(() {
      textName = nameController.text;
    });
  }

  @override
  void initState() {
    super.initState();
    nameController.addListener(nameControllerObserver);
  }

  @override
  Widget build(BuildContext context) {
    var textInputName = TextFormField(
        validator: (value) {
          if (value.length == 0) {
            return "Insira seu nome";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          _name = value;
        },
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: nameController,
        decoration: InputDecoration(
            labelText: "Nome",
            contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            labelStyle: TextStyle(color: Colors.blue),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))));

    var textInputLastName = TextFormField(
        validator: (value) {
          if (value.length == 0) {
            return "Insira seu sobrenome";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          _lastName = value;
        },
        keyboardType: TextInputType.text,
        autofocus: false,
        controller: lastNameController,
        decoration: InputDecoration(
            labelText: "Sobrenome",
            contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            labelStyle: TextStyle(color: Colors.blue),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))));

    final name_lastname = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Oi, ",
          style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        ),
        Text(
          textName.length > 0 ? nameController.text : "Qual é o seu nome ",
          style: TextStyle(
              color: nameController.text.length > 0
                  ? Colors.blue
                  : Colors.grey[700],
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        Text(
          textName.length > 0 ? "!" : "?",
          style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 20.0),
        )
      ],
    );

    final message_top = Text(
      "É necesário que você informe seu nome verdadeiro.\nNão utilize nome de terceiros",
      style: TextStyle(fontSize: 11.0),
      textAlign: TextAlign.center,
    );

    final continue_button = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          //? If all data are correct then save data to out variables
          _formKey.currentState.save();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ImageProfileActivity(_name, _lastName)));
        } else {
          //? If all data are not valid then start auto validation.
          setState(() {
            _autoValidate = true;
          });
        }
      },
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child: Text('CONTINUAR', style: TextStyle(color: Colors.white)),
    );

    final field_name_lastname = Row(
      children: <Widget>[
        Expanded(child: textInputName, flex: 1),
        SizedBox(width: 8.0),
        Expanded(child: textInputLastName, flex: 2),
      ],
    );

    final message_bottom = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Ao criar sua conta, você concorda com os",
          style: TextStyle(fontSize: 12.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {},
              child: Text("Termos de Serviço",
                  style: TextStyle(fontSize: 12.0, color: Colors.blue)),
            ),
            Text(
              " e ",
              style: TextStyle(fontSize: 12.0),
            ),
            InkWell(
              onTap: () {},
              child: Text("Política de Privacidade",
                  style: TextStyle(fontSize: 12.0, color: Colors.blue)),
            )
          ],
        )
      ],
    );

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
            Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[
                  name_lastname,
                  SizedBox(height: 8.0),
                  message_top,
                  field_name_lastname,
                ],
              ),
            ),
            SizedBox(height: 16.0),
            continue_button,
            SizedBox(height: 16.0),
            message_bottom
          ],
        ),
      ),
    );
  }
}
