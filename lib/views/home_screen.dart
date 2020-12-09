import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/components/card_acad.dart';
import 'package:jiu_jitsu_acad/models/user_model.dart';
import 'package:jiu_jitsu_acad/render/listAcademia.dart';
import 'package:jiu_jitsu_acad/views/login_screen.dart';

class JiuJitsuApp extends StatefulWidget {
  @override
  _JiuJitsuAppState createState() => _JiuJitsuAppState();
}

class _JiuJitsuAppState extends State<JiuJitsuApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIscrolled) {
            return <Widget>[
              SliverAppBar(
                floating: false,
                expandedHeight: 300.0,
                pinned: true,
                title: Text("Jiu-Jitsu", style: TextStyle(color: Colors.white)),
                centerTitle: true,
                backgroundColor: Color.fromARGB(255, 45, 51, 53),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'assets/jiu_jitsu_garra.png',
                    fit: BoxFit.cover,
                    color: Color(0xaa212121),
                    colorBlendMode: BlendMode.darken,
                  ),
                ),
                actions: <Widget>[
                  FlatButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                        UserModel.of(context).signOut();
                      },
                      icon: Icon(Icons.exit_to_app,color:Colors.white,),
                      label: Text('sair',style: TextStyle(color:Colors.white),))
                ],
                
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListAcademia(),
          )),
    );
  }
}
