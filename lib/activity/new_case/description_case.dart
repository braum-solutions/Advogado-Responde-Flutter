import 'package:advogado_responde/activity/home_activity.dart';
import 'package:advogado_responde/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class DescriptionCase extends StatefulWidget {
  String _image, _pdf, _type;
  DescriptionCase(_image, _pdf, _type);
  @override
  _DescriptionCaseState createState() =>
      _DescriptionCaseState(_image, _pdf, _type);
}

class _DescriptionCaseState extends State<DescriptionCase> {
  String _image, _pdf, _type;
  _DescriptionCaseState(_image, _pdf, _type);

  final _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;

  Widget _title() {
    return Text(
      "Descrição do Caso",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.grey[700]),
    );
  }

  Widget _text(String text, double size) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: size, color: Colors.grey[600]),
    );
  }

  Widget _content() {
    return Form(
      key: _formKey,
      child: TextFormField(
        validator: (value) {
          if (value.length < 50) {
            return "A descrição deve ter mais de 50 caracteres";
          } else {
            return null;
          }
        },
        autovalidate: _autoValidate,
        keyboardType: TextInputType.multiline,
        autofocus: false,
        controller: _descriptionController,
        decoration: InputDecoration(
            labelText: "Descrição",
            labelStyle: TextStyle(color: Colors.blue),
            contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      ),
    );
  }

  Widget _doneButton() {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        if(model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              Map<String, dynamic> newCase = {
                "type" :_type,
                "image" :_image,
                "pdf" : _pdf,
                "description" : _descriptionController,
                "user" : model.uid()
              };
            } else {
              setState(() {
                _autoValidate = true;
              });
            }
          },
          padding: EdgeInsets.all(16),
          color: Colors.blue,
          child: Text('CONCLUIR', style: TextStyle(color: Colors.white)),
        );
        };
      },
    );
  }

  Widget _space() {
    return SizedBox(height: 8.0);
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
    _showSnackbar("Novo caso criado com sucesso!", Colors.green);
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeActivity()));
    });
  }

  void _onFail() {
    _showSnackbar("Falha ao criar o novo caso!", Colors.red);
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
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          children: <Widget>[
            _title(),
            _space(),
            _text(
                "Faça uma descrição completa de seu caso para que os advogados possam ter um bom entendimento de seu caso e que possam ajudar a resolver o seu problema",
                13.0),
            _content(),
            _space(),
            _doneButton(),
            _space(),
            _text(
                "Ao clicar em concluir, você afirma que todos os dados do tipo pdf, imagem ou texto são veridicos.",
                12.0)
          ],
        ),
      ),
    );
  }
}
