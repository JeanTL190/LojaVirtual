import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_virtual/formatters/telefoneFormatter.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreenGoogle extends StatefulWidget {
  final User _firebaseUser;
  SignUpScreenGoogle(this._firebaseUser);
  @override
  _SignUpScreenGoogleState createState() =>
      _SignUpScreenGoogleState(_firebaseUser);
}

class _SignUpScreenGoogleState extends State<SignUpScreenGoogle> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _referenceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final User _firebaseUser;
  _SignUpScreenGoogleState(this._firebaseUser) {
    _nameController.text = _firebaseUser.displayName;
    _phoneController.text = _firebaseUser.phoneNumber;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(child: CircularProgressIndicator());
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Nome Completo",
                    icon: Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text.isEmpty) return "Nome inválido!";
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "Telefone",
                    icon: Icon(
                      Icons.phone,
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(15),
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneTextInputFormatter(),
                  ],
                  validator: (text) {
                    if (text.isEmpty || text.length < 10)
                      return "Telefone inválido!";
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                      hintText: "Endereço", icon: Icon(Icons.home_work)),
                  validator: (text) {
                    if (text.isEmpty) return "Endereço inválido!";
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _referenceController,
                  decoration: InputDecoration(
                      hintText: "Referênciais (Opcional)",
                      icon: Icon(Icons.note_add)),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _firebaseUser.email,
                          "address": _addressController.text,
                          "phone": _phoneController.text,
                          "reference": _referenceController.text,
                        };
                        model.saveUserDataGoogle(
                            userData, _firebaseUser, context);
                      }
                    },
                    child: Text(
                      "Salvar",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Theme.of(context).primaryColor)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
