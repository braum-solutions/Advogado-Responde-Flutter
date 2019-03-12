import 'package:advogado_responde/activity/new_case/description_case.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class FileCase extends StatefulWidget {
  String _type;
  FileCase(_type);
  @override
  _FileCaseState createState() => _FileCaseState(_type);
}

class _FileCaseState extends State<FileCase> {
  String _type;
  _FileCaseState(_type);
  String _image = "";
  String _pdf = "";

  void _showDialog(String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  "Continuar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DescriptionCase(_image, _pdf, _type)));
                },
              )
            ],
          );
        });
  }

  void _pickPDF() async {
    String _file = await FilePicker.getFilePath(
        type: FileType.CUSTOM, fileExtension: "pdf");
    if (_file != null) {
      setState(() {
        _pdf = _file;
      });
    }
  }

  void _pickImage(ImageSource type) {
    ImagePicker.pickImage(source: type).then((file) {
      if (file == null)
        return;
      else
        setState(() {
          _image = file.path;
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
                      _pickImage(ImageSource.camera);
                    }),
                new ListTile(
                  leading: new Icon(Icons.panorama),
                  title: new Text('Galeria'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _title() {
    return Text(
      "Upload de Arquivo",
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

  Widget _buttonImagePdf() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              _settingModalBottomSheet(context);
            },
            padding: EdgeInsets.all(16),
            color: _image == "" ? Theme.of(context).primaryColor : Colors.blue,
            child: Text('IMAGEM', style: TextStyle(color: Colors.white)),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          flex: 1,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              _pickPDF();
            },
            padding: EdgeInsets.all(16),
            color: _pdf == "" ? Theme.of(context).primaryColor : Colors.blue,
            child: Text('PDF', style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

  Widget _continueButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        if (_image == "" && _pdf == "") {
          _showDialog("Sem Aquivos",
              "Você não escolheu nenhum arquivo, deseja continuar?");
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DescriptionCase(_image, _pdf, _type)));
        }
      },
      padding: EdgeInsets.all(16),
      color: Colors.blue,
      child: Text('CONTINUAR', style: TextStyle(color: Colors.white)),
    );
  }

  Widget _space() {
    return SizedBox(height: 8.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          shrinkWrap: true,
          children: <Widget>[
            _title(),
            _space(),
            _text(
                "Caso você tenha algum arquivo de imagem e/ou pdf que possa ajudar os advogados a entenderem melhor o seu caso, faã o upload clicando nos botões abaixo, caso não tenha clique em continuar",
                13.0),
            _space(),
            _buttonImagePdf(),
            _space(),
            _continueButton(),
            _space(),
            _text(
                "Ao clicar em continuar você estará concordando que ao criar um novo caso, você ficará responsável por todos os dados que irá inserir e compartilhar com os advogados.",
                12.0)
          ],
        ),
      ),
    );
  }
}
