import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;
  bool isLoadingRec = false;
  bool isLoadingSave = false;
  bool isLoadingPic = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Map<String, dynamic> userData = Map();

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    _user = null;
    notifyListeners();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String password,
      @required String imagePath,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: password)
        .then((user) async {
      _user = user;
      await _saveUserData(userData);
      await uploadImage(imagePath);
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      print("Erro ao criar a conta");
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String password,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) async {
      _user = user;
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      print("Erro ao fazer o login: ${e}");
      isLoading = false;
      notifyListeners();
    });
  }

  bool isLogedIn() {
    return _user != null;
  }

  void recoveryPassword(
      {@required String email,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) {
    isLoadingRec = true;
    notifyListeners();
    _auth.sendPasswordResetEmail(email: email).then((_) {
      onSucess();
      isLoadingRec = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoadingRec = false;
      notifyListeners();
    });
  }

  String uid() {
    return _user.uid;
  }

  Future<Null> createNewCase(
      {@required String type,
      @required String image,
      @required String pdf,
      @required String description,
      @required String user}) {}

  Future<Null> updateUserData(
      {@required String name,
      @required String lastName,
      @required String cpf,
      @required String birth,
      @required String oabCode,
      @required String oabUF,
      @required String displayName,
      @required String ddd,
      @required String phone,
      @required String zipcode,
      @required String city,
      @required String uf,
      @required String address,
      @required String number,
      @required String neighborhood,
      @required String complement,
      @required String curriculum,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoadingSave = true;
    notifyListeners();
    Map<String, dynamic> userInfo;
    userData["type"] == "1"
        ? userInfo = {
            "name": name,
            "lastName": lastName,
            "cpf": cpf,
            "birth": birth,
            "oabCode": oabCode,
            "oabUf": oabUF,
            "display_name": displayName,
            "ddd": ddd,
            "phone": phone,
            "zipcode": zipcode,
            "city": city,
            "uf": uf,
            "address": address,
            "number": number,
            "neighborhood": neighborhood,
            "complement": complement,
            "curriculum": curriculum
          }
        : userInfo = {
            "name": name,
            "lastName": lastName,
            "cpf": cpf,
            "birth": birth,
            "ddd": ddd,
            "phone": phone,
            "zipcode": zipcode,
            "city": city,
            "uf": uf,
            "address": address,
            "number": number,
            "neighborhood": neighborhood,
            "complement": complement
          };
    print(userInfo);
    await Firestore.instance
        .collection("users")
        .document(_user.uid)
        .updateData(userInfo)
        .then((_) async {
      isLoadingSave = false;
      await reloadUserData();
      onSuccess();
      notifyListeners();
    }).catchError((e) {
      print("Erro ao atualizar os dados");
      isLoadingSave = false;
      notifyListeners();
    });
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(_user.uid)
        .setData(userData);
  }

  Future<String> uploadImage(String image) async {
    isLoadingPic = true;
    notifyListeners();
    try {
      StorageReference ref = FirebaseStorage.instance
          .ref()
          .child("user_images")
          .child(_user.uid)
          .child("profile.jpg");

      StorageUploadTask task = ref.putFile(File(image));

      Map<String, dynamic> userImage = {
        "image": await (await task.onComplete).ref.getDownloadURL()
      };

      await Firestore.instance
          .collection("users")
          .document(_user.uid)
          .updateData(userImage);
      isLoadingPic = false;
      notifyListeners();
    } catch (e) {
      isLoadingPic = false;
      notifyListeners();
      print("Erro ao fazer upload da imagem: ${e}");
    }
  }

  String getUserEmail() {
    return _user.email;
  }

  Future<Null> reloadUserData() async {
    DocumentSnapshot docUser =
        await Firestore.instance.collection("users").document(_user.uid).get();
    userData = docUser.data;
  }

  Future<Null> _loadCurrentUser() async {
    isLoading = true;
    notifyListeners();
    if (_user == null) {
      _user = await _auth.currentUser();
    }
    if (_user != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(_user.uid)
            .get();
        userData = docUser.data;
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
