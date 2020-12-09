import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/models/treinamento_model.dart';
import 'package:jiu_jitsu_acad/models/user_model.dart';
import 'package:jiu_jitsu_acad/views/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<Treinamento>(
              model: Treinamento(model),
              child: MaterialApp(
                  title: 'Jiu Jitsu',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primaryColor: Color.fromARGB(255, 45, 51, 53),
                    primarySwatch: Colors.grey,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  home: LoginScreen()));
        },
      ),
    );
  }
}
