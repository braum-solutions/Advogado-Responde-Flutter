import 'dart:io';

import 'package:advogado_responde/model/user_model.dart';
import 'package:advogado_responde/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _birthController = TextEditingController();
  final _dddController = TextEditingController();
  final _phoneController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _complementController = TextEditingController();
  final _oabCodeController = TextEditingController();
  final _displayNameController = TextEditingController();
  final _miniCurriculumController = TextEditingController();

  var _array_uf = [
    "UF",
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO"
  ];

  var _array_uf_oab = [
    "OAB/UF",
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

  String _name,
      _lastName,
      _cpf,
      _birth,
      _ddd,
      _phone,
      _zipCode,
      _city,
      _address,
      _number,
      _neighborhood,
      _complement,
      _curriculum,
      _displayName,
      _oabCode,
      _oabUF,
      _uf,
      _image;

  bool _loaded = false;
  bool _isEnable = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  void pickImage(ImageSource type, UserModel model) {
    ImagePicker.pickImage(source: type).then((file) {
      if (file == null)
        return;
      else
        setState(() {
          _image = file.path;
          model.uploadImage(file.path);
        });
    });
  }

  void _settingModalBottomSheet(context, UserModel model) {
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
                      pickImage(ImageSource.camera, model);
                    }),
                new ListTile(
                  leading: new Icon(Icons.panorama),
                  title: new Text('Galeria'),
                  onTap: () {
                    Navigator.pop(context);
                    pickImage(ImageSource.gallery, model);
                  },
                ),
              ],
            ),
          );
        });
  }

  Widget _profilePicture(UserModel model) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 2.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Foto de Perfil",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              SizedBox(height: 10.0),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: model.userData["image"] == null
                                ? AssetImage("assets/person.png")
                                : NetworkImage(model.userData["image"]))),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: ScopedModelDescendant<UserModel>(
                  builder: (context, child, model) {
                    if (model.isLoadingPic) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          _settingModalBottomSheet(context, model);
                        },
                        padding: EdgeInsets.all(16),
                        color: Theme.of(context).primaryColor,
                        child: Text("ALTERAR FOTO",
                            style: TextStyle(color: Colors.white)),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ));
  }

  Widget _personalData(UserModel model) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 2.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Dados Pessoais",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                              enabled: _isEnable,
                              controller: _nameController,
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
                              autofocus: false,
                              autovalidate: _autoValidate,
                              decoration: InputDecoration(
                                  labelText: "Nome",
                                  labelStyle: TextStyle(color: Colors.blue),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                            )),
                        SizedBox(width: 5.0),
                        Expanded(
                            flex: 2,
                            child: TextFormField(
                              enabled: _isEnable,
                              controller: _lastNameController,
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
                              autofocus: false,
                              autovalidate: _autoValidate,
                              decoration: InputDecoration(
                                  labelText: "Sobrenome",
                                  labelStyle: TextStyle(color: Colors.blue),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                            ))
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(height: 5.0),
                        TextFormField(
                          enabled: _isEnable,
                          controller: _cpfController,
                          validator: (value) {
                            if (value.length == 0) {
                              return "Insira seu CPF";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _cpf = value;
                          },
                          autofocus: false,
                          maxLength: 11,
                          autovalidate: _autoValidate,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "CPF",
                              labelStyle: TextStyle(color: Colors.blue),
                              contentPadding:
                                  EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                        ),
                        SizedBox(height: 5.0),
                        TextFormField(
                          enabled: _isEnable,
                          controller: _birthController,
                          validator: (value) {
                            if (value.length == 0) {
                              return "Insira sua Data de Nascimento";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _birth = value;
                          },
                          autofocus: false,
                          maxLength: 10,
                          keyboardType: TextInputType.datetime,
                          autovalidate: _autoValidate,
                          decoration: InputDecoration(
                              labelText: "Data de Nascimento",
                              labelStyle: TextStyle(color: Colors.blue),
                              contentPadding:
                                  EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue))),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget _phoneContact(UserModel model) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 2.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Telefone para Contato",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: TextFormField(
                            enabled: _isEnable,
                            controller: _dddController,
                            validator: (value) {
                              if (value.length == 0) {
                                return "Insira seu DDD";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _ddd = value;
                            },
                            autofocus: false,
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            autovalidate: _autoValidate,
                            decoration: InputDecoration(
                                labelText: "DDD",
                                labelStyle: TextStyle(color: Colors.blue),
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          )),
                      SizedBox(width: 5.0),
                      Expanded(
                          flex: 3,
                          child: TextFormField(
                            enabled: _isEnable,
                            controller: _phoneController,
                            validator: (value) {
                              if (value.length == 0) {
                                return "Insira seu telefone";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _phone = value;
                            },
                            autofocus: false,
                            maxLength: 9,
                            keyboardType: TextInputType.number,
                            autovalidate: _autoValidate,
                            decoration: InputDecoration(
                                labelText: "Telefone",
                                labelStyle: TextStyle(color: Colors.blue),
                                contentPadding:
                                    EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          )),
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget _personalAddress(UserModel model) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 2.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Endereço",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        enabled: _isEnable,
                        controller: _zipcodeController,
                        validator: (value) {
                          if (value.length == 0) {
                            return "Insira seu CEP";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _zipCode = value;
                        },
                        autofocus: false,
                        autovalidate: _autoValidate,
                        maxLength: 9,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "CEP",
                            labelStyle: TextStyle(color: Colors.blue),
                            contentPadding:
                                EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              enabled: _isEnable,
                              controller: _cityController,
                              validator: (value) {
                                if (value.length == 0) {
                                  return "Insira seu cidade";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _city = value;
                              },
                              autofocus: false,
                              autovalidate: _autoValidate,
                              decoration: InputDecoration(
                                  labelText: "Cidade",
                                  labelStyle: TextStyle(color: Colors.blue),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                border: Border.all(
                                    color: Colors.grey[500], width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: new Text('UF'),
                                  isExpanded: true,
                                  onChanged: (String itemSelected) {
                                    setState(() {
                                      _uf = itemSelected;
                                    });
                                  },
                                  value: model.userData["uf"],
                                  items: _array_uf.map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              enabled: _isEnable,
                              controller: _addressController,
                              validator: (value) {
                                if (value.length == 0) {
                                  return "Insira seu endereço";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _address = value;
                              },
                              autofocus: false,
                              autovalidate: _autoValidate,
                              decoration: InputDecoration(
                                  labelText: "Endereço",
                                  labelStyle: TextStyle(color: Colors.blue),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Expanded(
                              flex: 1,
                              child: TextFormField(
                                enabled: _isEnable,
                                controller: _numberController,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "Insira o numero de sua casa";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  _number = value;
                                },
                                autofocus: false,
                                keyboardType: TextInputType.number,
                                autovalidate: _autoValidate,
                                decoration: InputDecoration(
                                    labelText: "Número",
                                    labelStyle: TextStyle(color: Colors.blue),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              )),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        enabled: _isEnable,
                        controller: _neighborhoodController,
                        validator: (value) {
                          if (value.length == 0) {
                            return "Insira seu bairro";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _neighborhood = value;
                        },
                        autofocus: false,
                        autovalidate: _autoValidate,
                        decoration: InputDecoration(
                            labelText: "Bairro",
                            labelStyle: TextStyle(color: Colors.blue),
                            contentPadding:
                                EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                      SizedBox(height: 5.0),
                      TextFormField(
                        enabled: _isEnable,
                        controller: _complementController,
                        onSaved: (value) {
                          _complement = value;
                        },
                        autofocus: false,
                        autovalidate: _autoValidate,
                        decoration: InputDecoration(
                            labelText: "Complemento",
                            labelStyle: TextStyle(color: Colors.blue),
                            contentPadding:
                                EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue))),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget _profissionalData(UserModel model) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 2.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Dados Profissionais",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      TextFormField(
                        enabled: _isEnable,
                        controller: _oabCodeController,
                        validator: (value) {
                          if (value.length == 0) {
                            return "Insira seu registro OAB";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _oabCode = value;
                        },
                        autofocus: false,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        autovalidate: _autoValidate,
                        decoration: InputDecoration(
                            labelText: "Registro OAB",
                            labelStyle: TextStyle(color: Colors.blue),
                            contentPadding:
                                EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                      Text("OB UF",
                          style: TextStyle(color: Colors.blue, fontSize: 12.0)),
                      Container(
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
                                _oabUF = itemSelected;
                              });
                            },
                            value: model.userData["oabUF"],
                            items: _array_uf_oab.map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      TextFormField(
                        enabled: _isEnable,
                        controller: _displayNameController,
                        validator: (value) {
                          if (value.length == 0) {
                            return "Insira seu Nome de Exibição";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _displayName = value;
                        },
                        autofocus: false,
                        autovalidate: _autoValidate,
                        decoration: InputDecoration(
                            labelText: "Nome de Exibição",
                            labelStyle: TextStyle(color: Colors.blue),
                            contentPadding:
                                EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue))),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }

  Widget _miniCurriculum(UserModel model) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        elevation: 2.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.blue,
                child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Mini-Curriculo",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
              ),
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    enabled: _isEnable,
                    controller: _miniCurriculumController,
                    validator: (value) {
                      if (value.length == 0) {
                        return "Insira algo sobre sua profissão";
                      } else if (value.length == 50) {
                        return "Seu mini-curriculo deve ter mais de 50 Caracteres";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _curriculum = value;
                    },
                    autofocus: false,
                    autovalidate: _autoValidate,
                    decoration: InputDecoration(
                        labelText: "Descreva sua experiência profissional",
                        labelStyle: TextStyle(color: Colors.blue),
                        contentPadding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue))),
                  ))
            ],
          ),
        ));
  }

  void _setText(UserModel model) {
    print("type: ${model.userData["type"]}");
    if (model.userData["type"] == "1") {
      _oabCodeController.text = model.userData["oabCode"];
      _displayNameController.text = model.userData["display_name"];
      _miniCurriculumController.text = model.userData["curriculum"];
    }
    _nameController.text = model.userData["name"];
    _lastNameController.text = model.userData["lastName"];
    _cpfController.text = model.userData["cpf"];
    _birthController.text = model.userData["birth"];
    _dddController.text = model.userData["ddd"];
    _phoneController.text = model.userData["phone"];
    _zipcodeController.text = model.userData["zipcode"];
    _cityController.text = model.userData["city"];
    _addressController.text = model.userData["address"];
    _numberController.text = model.userData["number"];
    _neighborhoodController.text = model.userData["neighborhood"];
    _complementController.text = model.userData["complement"];
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

  void _onSuccess() {
    _showSnackbar("Perfil atualizado com sucesso!", Colors.green, 2);
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    setState(() {
      _isEnable = false;
    });
    _showSnackbar("Falha ao atualizar seu perfil!", Colors.red, 2);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      if (!_loaded) {
        _setText(model);
        _loaded = true;
      }
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text("Meu Perfil"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.save,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              setState(() {
                _isEnable = false;
              });
              _showSnackbar("Aguarde!", Colors.blue, 1);
              model.updateUserData(
                  address: _addressController.text,
                  birth: _birthController.text,
                  city: _cityController.text,
                  complement: _complementController.text,
                  curriculum: _miniCurriculumController.text,
                  cpf: _cpfController.text,
                  ddd: _dddController.text,
                  displayName: _displayNameController.text,
                  lastName: _lastNameController.text,
                  name: _nameController.text,
                  neighborhood: _neighborhoodController.text,
                  number: _numberController.text,
                  oabCode: _oabCodeController.text,
                  oabUF: _oabUF,
                  phone: _phoneController.text,
                  uf: _uf,
                  zipcode: _zipcodeController.text,
                  onFail: _onFail,
                  onSuccess: _onSuccess);
            } else {
              setState(() {
                _autoValidate = true;
              });
            }
          },
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(12.0),
            shrinkWrap: true,
            children: model.userData["type"] == "1"
                ? <Widget>[
                    _profilePicture(model),
                    _personalData(model),
                    _profissionalData(model),
                    _phoneContact(model),
                    _personalAddress(model),
                    _miniCurriculum(model)
                  ]
                : <Widget>[
                    _profilePicture(model),
                    _personalData(model),
                    _phoneContact(model),
                    _personalAddress(model)
                  ],
          ),
        ),
      );
    });
  }
}
