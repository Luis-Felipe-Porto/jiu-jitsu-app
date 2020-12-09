import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/data/horarioTreino_data.dart';
import 'package:jiu_jitsu_acad/models/treinamento_model.dart';

class HorarioCard extends StatelessWidget {
  final HorarioTreino horario;

  const HorarioCard(this.horario);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.access_time,
      ),
      title: Text('${horario.dia} - das ${horario.inicio} até ${horario.fim}'),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.redAccent),
        onPressed: () {
          Treinamento.of(context).removeHorarioDeTreino(horario);
        },
      ),
    );
  }
}
