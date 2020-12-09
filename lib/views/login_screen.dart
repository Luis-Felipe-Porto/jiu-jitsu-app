import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/models/user_model.dart';
import 'package:jiu_jitsu_acad/views/home_screen.dart';
import 'package:jiu_jitsu_acad/views/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: FlatButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  icon: Icon(Icons.person_add),
                  label: Text('Cadastrar')),
            )
          ],
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Jiu-Jitsu',
                  style: TextStyle(fontSize: 20.0),
                ),
                Image.asset('assets/icon-login.png', height: 200, width: 200),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 35.0),
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
                            if (text.isEmpty || text.length < 6)
                              return 'Email inválido!';
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 35.0),
                        child: TextFormField(
                          controller: _passController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[300],
                              border: InputBorder.none,
                              hintText: 'Senha',
                              contentPadding: EdgeInsets.all(16.0),
                              prefixIcon: Icon(Icons.lock)),
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          // ignore: missing_return
                          validator: (text) {
                            if (text.isEmpty || text.length < 6)
                              return 'Senha inválido!';
                          },
                        ),
                      ),
                      FlatButton(
                          onPressed: () {}, child: Text('Esqueceu a senha?')),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 45,
                        width: 200,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              model.signIn(
                                  email: _emailController.text,
                                  pass: _passController.text,
                                  onSuccess: _onSuccess,
                                  onFail: _onFail);
                            }
                          },
                          child: Text(
                            'Entrar',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }

  void _onSuccess() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => JiuJitsuApp()),
        (route) => false);
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
