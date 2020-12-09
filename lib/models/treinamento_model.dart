import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/data/academia_data.dart';
import 'package:jiu_jitsu_acad/data/frequencia_data.dart';
import 'package:jiu_jitsu_acad/data/horarioTreino_data.dart';
import 'package:jiu_jitsu_acad/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Treinamento extends Model {
  UserModel user;
  Academia academia;
  List<HorarioTreino> horarios = [];
  List<FrequenciaUser> frequecias = [];
  bool isLoading = false;

  Treinamento(this.user) {
    if (user.isLoggedIn()) {
      _loadFrequencia();
      _loadHorarioTreino();
      
    }
  }
  static Treinamento of(BuildContext context) =>
      ScopedModel.of<Treinamento>(context);
  void registrarTreinamento(Map<String, dynamic> localizacaoAcademia) {}
  void addHorarioDeTreino(HorarioTreino horarioTreino) {
        horarios.add(horarioTreino);

    Firestore.instance.collection("users").document(user.firebaseUser.uid)
      .collection("horarioTreino").add(horarioTreino.toMap()).then((doc){
        horarioTreino.treinoId = doc.documentID;
    });

    notifyListeners();
  }
  void removeHorarioDeTreino(HorarioTreino horario){
        Firestore.instance.collection("users").document(user.firebaseUser.uid)
        .collection("horarioTreino").document(horario.treinoId).delete();

    horarios.remove(horario);

    notifyListeners();
  }

  void _loadHorarioTreino() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("horarioTreino")
        .getDocuments();
    horarios =
        query.documents.map((doc) => HorarioTreino.fromDocument(doc)).toList();        
    notifyListeners();
  }
  
  void _loadFrequencia() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("frequencia")
        .getDocuments();
    frequecias =
        query.documents.map((doc) => FrequenciaUser.fromDocument(doc)).toList();
    notifyListeners();
  }
}
