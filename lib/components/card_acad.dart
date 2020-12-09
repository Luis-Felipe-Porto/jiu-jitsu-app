import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/views/frequencia_screen.dart';
import 'package:jiu_jitsu_acad/views/horario_screen.dart';

class CardAcad extends StatelessWidget {

  final DocumentSnapshot snapshot;
  CardAcad(this.snapshot);
  
  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      color: Colors.grey[300],
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "${snapshot.data["imgAcad"]}"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Color(0x80212121), BlendMode.darken)),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ListTile(
                trailing: Icon(Icons.location_on),
                title: Text(
                 "${snapshot.data["nome"]}",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text("${snapshot.data["endereco"]}"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: 120,
                    child: RaisedButton(
                      elevation: 0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Horario()));
                      },
                      child: Text(
                        'Horário',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: RaisedButton(
                      elevation: 0,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Frequencia()));
                      },
                      child: Text(
                        'Frequência',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
