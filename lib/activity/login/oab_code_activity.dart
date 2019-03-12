import 'package:advogado_responde/activity/login/sign_up_activity.dart';
import 'package:flutter/material.dart';

class OABCodeActivity extends StatefulWidget {
  String _name;
  String _lastName;
  String _imagePath;
  String _type;
  OABCodeActivity(this._name, this._lastName, this._imagePath, this._type);

  @override
  _OABCodeActivityState createState() =>
      _OABCodeActivityState(_name, _lastName, _imagePath, _type);
}

class _OABCodeActivityState extends State<OABCodeActivity> {
  String _name;
  String _lastName;
  String _imagePath;
  String _type;
  String _oabCode;
  _OABCodeActivityState(
      this._name, this._lastName, this._imagePath, this._type);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  final oabController = TextEditingController();
  int _oabUF;
  var oabItens = <String>[
    "OAB/AC",
    "OAB/AL",
    "OAB/AP",
    "OAB/AM",
    "OAB/BA",
    "OAB/CE",
    "OAB/DF",
    "OAB/ES",
    "OAB/GO",
    "OAB/MA",
    "OAB/MT",
    "OAB/MS",
    "OAB/MG",
    "OAB/PA",
    "OAB/PB",
    "OAB/PR",
    "OAB/PE",
    "OAB/PI",
    "OAB/RJ",
    "OAB/RN",
    "OAB/RS",
    "OAB/RO",
    "OAB/RR",
    "OAB/SC",
    "OAB/SP",
    "OAB/SE",
    "OAB/TO"
  ];

  @override
  Widget build(BuildContext context) {
    final title = Text(
      "Informe o código de seu OAB",
      style: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.grey[700]),
      textAlign: TextAlign.center,
    );

    final subtitle = Text(
      "Caro usuário, para você atuar como um legitimo advogado, precisamos que nos informe o código de seu OAB. Se o seu código for autenticado pelo site da OAB, você receberá um selo de verificado que aparecerá em seu perfil para outros usuários verem.",
      style: TextStyle(fontSize: 11.0),
      textAlign: TextAlign.center,
    );

    final dropDownItens = Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey[500], width: 1),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: new Text('OAB/UF'),
          isExpanded: true,
          onChanged: (String itemSelected) {
            setState(() {
              _oabUF = oabItens.indexOf(itemSelected);
            });
          },
          value: oabItens[1],
          items: oabItens.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
        ),
      ),
    );

    final oab_code = TextFormField(
      validator: (value) {
        if (value.length == 0) {
          return "Insira seu Código OAB";
        } else if (value.length < 6) {
          return "Insira um Código válido";
        } else {
          return null;
        }
      },
      onSaved: (value) {
        _oabCode = value;
      },
      keyboardType: TextInputType.number,
      autofocus: false,
      controller: oabController,
      decoration: InputDecoration(
          labelText: "Código OAB",
          contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
          labelStyle: TextStyle(color: Colors.blue),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue))),
    );

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(child: dropDownItens, flex: 1),
        SizedBox(width: 8.0),
        Expanded(
            child: Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: oab_code,
            ),
            flex: 1),
      ],
    );

    final continue_button = RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          //? If all data are correct then save data to out variables
          _formKey.currentState.save();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignUpActivity(_name, _lastName,
                      _imagePath, _type, _oabCode, _oabUF.toString())));
        } else {
          //? If all data are not valid then start auto validation.
          setState(() {
            _autoValidate = true;
          });
        }
      },
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child: Text("CONTINUAR", style: TextStyle(color: Colors.white)),
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
            SizedBox(height: 8.0),
            subtitle,
            SizedBox(height: 12.0),
            content,
            SizedBox(height: 8.0),
            continue_button
          ],
        ),
      ),
    );
  }
}
