// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/widgets.dart';
import 'package:nba_stats/controller/api_request.dart';
import 'package:nba_stats/model/data.dart';

import '../model/game.dart';

class Games extends StatefulWidget {
  const Games({super.key});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  DateTime startDate = DateTime(2023, 10, 23);
  late DateTime selectedDate;
  List<Data> futurePartidos = [];

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    selectedDate = selectedDate;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Theme.of(context).primaryColorLight,
            child: DatePicker(
              initialSelectedDate: DateTime.now(),
              controller: DatePickerController(),
              startDate,
              selectionColor: Theme.of(context).primaryColor,
              selectedTextColor: Theme.of(context).hintColor,
              onDateChange: handleDateChange,
              daysCount: 243,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: FutureBuilder(
              future: ApiService.listarPartidos(selectedDate),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return _ListaPartidos(
                      snapshot.data != null ? snapshot.data.data : []);
                }
              }),
        ),
      ],
    );
  }

  void handleDateChange(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }
}

class _ListaPartidos extends StatelessWidget {
  List<Data> partidos;
  _ListaPartidos(this.partidos);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: partidos.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Row(
              children: [
                Container(
                  width: 70,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: 
                  Image.asset('assets/img_teams/' + partidos[i].visitorTeam.city +' '+partidos[i].visitorTeam.name + '.png')
                  ),
                Center(
                    child: Text(partidos[i].visitorTeam.name +
                        ' ' +
                        partidos[i].visitorTeamScore.toString() +
                        '-' +
                        partidos[i].homeTeamScore.toString() +
                        ' ' +
                        partidos[i].homeTeam.name)),

                Container(
                  width: 70,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: 
                  Image.asset('assets/img_teams/' + partidos[i].homeTeam.city +' '+ partidos[i].homeTeam.name + '.png')
                  ),        
              ],
            ),
            subtitle: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(partidos[i].time),
                if (partidos[i].time == 'Not started')
                  Text(' ' +(partidos[i].status?.add(const Duration(hours: 2)).hour).toString() + ':' + (partidos[i].status?.add(const Duration(hours: 2)).minute).toString().padLeft(2, '0'))
                else
                  const SizedBox()
              ],
            )),
          );
        });
  }
}