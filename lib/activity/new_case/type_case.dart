import 'package:advogado_responde/activity/new_case/file_case.dart';
import 'package:flutter/material.dart';

class TypeCase extends StatefulWidget {
  @override
  _TypeCaseState createState() => _TypeCaseState();
}

class _TypeCaseState extends State<TypeCase> {
  String _dropdownValue = "q";
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _items = <String>[
    "Acidentário",
    "Administrativo",
    "Aeronáutico",
    "Agrário",
    "Ambiental",
    "Bancário",
    "Canônico",
    "Civil",
    "Constitucional",
    "Consumidor",
    "Contratual",
    "Digital",
    "Mulher",
    "Sucessões",
    "Família",
    "Negócios",
    "Propriedade",
    "Trânsito",
    "Desportivo",
    "Petróleo",
    "Trabalho",
    "Educacional",
    "Eleitoral",
    "Empresarial",
    "Espacial",
    "Financeiro",
    "Imobiliário",
    "Internacional",
    "Marítimo",
    "Médico",
    "Militar",
    "Minerário",
    "Penal",
    "Providenciário",
    "Processual do Trabalho",
    "Sanitário",
    "Sindical",
    "Societário",
    "Tributário",
    "Urbanístico",
    "Humanos"
  ];

  Widget _title() {
    return Text(
      "Área de Atuação",
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

  void _showSnackbar(String text, Color color, int seconds) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      duration: Duration(seconds: seconds),
    ));
  }

  Widget _button() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        if (_dropdownValue == "") {
          _showSnackbar("Selecione um tipo de caso", Colors.yellow, 3);
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FileCase(_dropdownValue)));
        }
      },
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child: Text('CONTINUAR', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _dropdownbutton() {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey[500], width: 1),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          onChanged: (String itemSelected) {
            setState(() {
              _dropdownValue = _items.indexOf(itemSelected).toString();
            });
          },
          value: _items[1],
          items: _items.map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _space() {
    return SizedBox(height: 8.0);
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
                "Selecione a área de atuação, que mais se encaixe no seu caso. isso ajudará os advogados a entenderem melhor o seu caso.",
                14.0),
            _space(),
            _dropdownbutton(),
            _space(),
            _button(),
            _space(),
            _text(
                "Ao clicar em continuar você estará concordando que ao criar um novo caso, você ficará responsável por todos os dados que irá inserir e compartilhar com os advogados.",
                13.0)
          ],
        ),
      ),
    );
  }
}
