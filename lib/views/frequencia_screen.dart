import 'package:calendarro/calendarro.dart';
import 'package:flutter/material.dart';
import 'package:jiu_jitsu_acad/components/frequencia_tile.dart';
import 'package:jiu_jitsu_acad/models/treinamento_model.dart';
import 'package:scoped_model/scoped_model.dart';


class Frequencia extends StatefulWidget {
  @override
  _FrequenciaState createState() => _FrequenciaState();
}

class _FrequenciaState extends State<Frequencia> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frequência'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<Treinamento>(
        
        builder: (context,child,model) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Calendarro(
                  
                  displayMode: DisplayMode.MONTHS,
                  selectedDates: model.frequecias.map((e) => e.data).toList(),
                  selectionMode: SelectionMode.MULTI,
                ),
              ),
              model.frequecias.isNotEmpty?
              Column(children: model.frequecias.map((e) => TileFrequencia(e)).toList(),)
              : Padding(
                padding: const EdgeInsets.only(top:20.0),
                child: Text('Nenhuma Frequencia Registrada'),
              ),
            ],
          );
        }
      ),
    );
  }
}
