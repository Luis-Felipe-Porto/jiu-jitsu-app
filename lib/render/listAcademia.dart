import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/components/card_acad.dart';

class ListAcademia  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("academia").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else if(snapshot.data.documents.isNotEmpty){
            return ListView(
              children: snapshot.data.documents.map((doc) => CardAcad(doc)).toList()
                .reversed.toList(),
            );
          }else{
            return Center(child: Text('Nenhuma Academia Encontrada'),);
          }
          //adicionar "nenhuma academia"
        },
      );
  }
}