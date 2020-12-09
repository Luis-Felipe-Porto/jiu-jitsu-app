import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/models/user_model.dart';
import 'package:jiu_jitsu_acad/views/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _nomeController = TextEditingController();
  final _passController = TextEditingController();
  final _novaPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Bem-Vindo Mestre!'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 30.0),
                  child: TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: InputBorder.none,
                        hintText: 'Nome',
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(Icons.person)),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length < 2)
                        return 'Nome inválido!';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 30.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: InputBorder.none,
                        hintText: 'E-mail',
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(Icons.email)),
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || !text.contains('@'))
                        return 'Email inválido!';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 30.0),
                  child: TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: InputBorder.none,
                        hintText: 'Senha',
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(Icons.vpn_key)),
                    obscureText: true,
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length < 3)
                        return 'senha inválida!';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 30.0),
                  child: TextFormField(
                    controller: _novaPassController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: InputBorder.none,
                        hintText: 'Confirme Sua Senha',
                        contentPadding: EdgeInsets.all(16.0),
                        prefixIcon: Icon(Icons.vpn_key)),
                    obscureText: true,
                    // ignore: missing_return
                    validator: (text) {
                      if (_novaPassController.text != _passController.text)
                        return 'senha diferentes';
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 30.0),
                  child: SizedBox(
                    height: 50.0,
                    width: double.infinity,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> userData = {
                            "name": _nomeController.text,
                            "email": _emailController.text,
                          };

                          model.signUp(
                            userData: userData,
                            pass: _passController.text,
                            onSucess: _onSuccess,
                            onFail: _onFail,
                          );
                        }
                      },
                      child: Text('Cadastrar'),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Cadastro Realizado!"),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3),
    ));
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Cadastrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
