import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/components/customDialog.dart';
import 'package:jiu_jitsu_acad/components/tileHorario_card.dart';

import 'package:jiu_jitsu_acad/models/treinamento_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Horario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Horário'),
        centerTitle: true,
      ),
      body:
          ScopedModelDescendant<Treinamento>(builder: (context, child, model) {
        return model.horarios.isNotEmpty
            ? ListView(
                children: model.horarios.map((e) => HorarioCard(e)).toList())
            : Center(

                child: Text(
                  'Nenhum Horário Adicionado',
                  style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.0),
                ),
              );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15.0, bottom: 15.0),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomDialog());
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
