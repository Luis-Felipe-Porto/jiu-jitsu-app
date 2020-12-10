import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  bool _verificarDataTreino() {
    bool treino = false;
    DateTime hoje = DateTime.now();
    horarios.forEach((element) {
      if (element.dia.toLowerCase() ==
          DateFormat.E('pt_BR').format(hoje).toLowerCase()) {
        treino = true;
        print(DateFormat.E('pt_BR').format(hoje).toLowerCase());
        print(element.dia.toLowerCase());
      }
    });
    return treino;
  }

  bool _verificarHoraTreino() {
    DateTime hoje = DateTime.now();
    bool treino = false;
    horarios.forEach((element) {
      if (element.inicio.toLowerCase() ==
          DateFormat.Hm('pt_BR').format(hoje).toLowerCase()) {
        treino = true;
      }
    });
    return treino;
  }

  bool _alunoNaAcademia() {
    //Pegar A localização e comparar
    return true;
  }

  void registrarTreinamento() {
    FrequenciaUser frequencia = FrequenciaUser();
    _loadHorarioTreino().then((value) {
      if (_verificarDataTreino()) {
        //se aluno tiver na academia
        frequencia.situacao = _alunoNaAcademia();
        frequencia.data = DateTime.now();
        addFrequencia(frequencia);
      }
    });
  }

  void addFrequencia(FrequenciaUser frequecia) {
    frequecias.add(frequecia);
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("frequencia")
        .add(frequecia.toMap())
        .then((doc) {
      frequecia.freqId = doc.documentID;
    });
    notifyListeners();
  }

  void addHorarioDeTreino(HorarioTreino horarioTreino) {
    horarios.add(horarioTreino);

    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("horarioTreino")
        .add(horarioTreino.toMap())
        .then((doc) {
      horarioTreino.treinoId = doc.documentID;
    });

    notifyListeners();
  }

  void removeHorarioDeTreino(HorarioTreino horario) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("horarioTreino")
        .document(horario.treinoId)
        .delete();

    horarios.remove(horario);

    notifyListeners();
  }

  Future<void> _loadHorarioTreino() async {
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
