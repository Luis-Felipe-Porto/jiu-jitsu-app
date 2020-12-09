
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiu_jitsu_acad/data/frequencia_data.dart';

class TileFrequencia extends StatelessWidget {
  final FrequenciaUser frequencia;
  TileFrequencia(this.frequencia);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.calendar_today),
      title: Text(
        '${DateFormat("dd-MM-yyyy- H:mm").format(frequencia.data)}',
        style: TextStyle(color:frequencia.situacao? Colors.green:Colors.redAccent, fontWeight: FontWeight.w600),
      ),
      subtitle: Text('Situação: ${frequencia.situacao?'Presente':'Ausente'}'),
    );
  }
}
