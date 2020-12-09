import 'package:cloud_firestore/cloud_firestore.dart';


class FrequenciaUser {
  String freqId;
  DateTime data;
  bool situacao;

  
  FrequenciaUser();

  FrequenciaUser.fromDocument(DocumentSnapshot document) {
    freqId = document.documentID;
    data =  document.data["data"].toDate();
    situacao = document.data["situacao"];
    
  }

  Map<String, dynamic> toMap() {
    return {
      "data": data,
      "situacao": situacao,
    };
  }
}
