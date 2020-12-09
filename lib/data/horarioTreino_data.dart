import 'package:cloud_firestore/cloud_firestore.dart';

enum DiaDaSemana { Seg, Ter, Qua, Qui, Sex, Sab, Dom }

class HorarioTreino {
  String treinoId;
  String dia;
  String inicio;
  String fim;

  HorarioTreino();

  HorarioTreino.fromDocument(DocumentSnapshot document) {
    treinoId = document.documentID;
    dia =  document.data["dia"];
    inicio = document.data["inicio"];
    fim = document.data["fim"];
  }

  Map<String, dynamic> toMap() {
    return {
      "dia": dia,
      "inicio": inicio,
      "fim": fim,
    };
  }
  
}
