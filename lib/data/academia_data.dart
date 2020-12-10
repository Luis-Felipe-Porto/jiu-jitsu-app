import 'package:cloud_firestore/cloud_firestore.dart';

class Academia {
  String acadId;
  String nome;
  String registro;
  
  Academia();

  Academia.fromDocument(DocumentSnapshot document) {
    acadId = document.documentID;
    nome = document.data["nome"];
    registro = document.data["registro"];
  }

  Map<String, dynamic> toMap() {
    return {
      "nome": nome,
      "registro": registro,
    };
  }
}
