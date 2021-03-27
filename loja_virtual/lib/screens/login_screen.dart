import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {},
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text.isEmpty || !text.contains("@"))
                  return "E-mail inválido!";
              },
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Senha"),
              obscureText: true,
              validator: (text) {
                if (text.isEmpty || text.length < 6) return "Senha inválida!";
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Esqueci minha senha",
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {}
                },
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Theme.of(context).primaryColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
