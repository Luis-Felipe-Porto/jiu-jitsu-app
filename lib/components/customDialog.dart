import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiu_jitsu_acad/data/horarioTreino_data.dart';
import 'package:jiu_jitsu_acad/models/treinamento_model.dart';
import 'package:jiu_jitsu_acad/models/user_model.dart';

class CustomDialog extends StatefulWidget {
  static const List<String> semana = [
    "Seg",
    "Ter",
    "Qua",
    "Qui",
    "Sex",
    "Sáb",
    "Dom"
  ];

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  HorarioTreino novoHorario = HorarioTreino();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 350,
        child: Column(
          children: <Widget>[
            DropDownField(
              onValueChanged: (dynamic value) {
                novoHorario.dia = value;
              },
              required: false,
              hintText: 'Semana Treino',
              labelText: 'Dias',
              items: CustomDialog.semana,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton.icon(
                        onPressed: () async {
                          final TimeOfDay pickedInicio = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          setState(() {
                            if(!(pickedInicio==null)){
                              novoHorario.inicio = '${pickedInicio?.hour.toString()}:${pickedInicio?.minute.toString()}';
                            }
                            
                          });
                        },
                        icon: Icon(Icons.alarm_add),
                        label: Text('Inicio ${novoHorario.inicio==null?'-- : --':novoHorario.inicio}')),
                    FlatButton.icon(
                        onPressed: () async {
                          final TimeOfDay pickedFim = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          setState(() {
                            if(!(pickedFim==null)){
                              novoHorario.fim = '${pickedFim?.hour.toString()}:${pickedFim?.minute.toString()}';
                            }
                          });
                        },
                        icon: Icon(Icons.timer_off),
                        label: Text('Fim ${novoHorario.fim==null?'-- : --':novoHorario.fim}')),
                  ],
                ),
                SizedBox(
                  width: 120,
                  child: RaisedButton(
                    elevation: 0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      if(!(novoHorario.fim==null||novoHorario.fim==null)){
                        print(novoHorario.toMap());
                        Treinamento.of(context).addHorarioDeTreino(novoHorario);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Adicionar',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
