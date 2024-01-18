// Cette page est pour tester le package de graphs dans flutter

import 'package:applicationsondage/sondages.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'main.dart';

class ResultatSondage extends StatefulWidget {
  const ResultatSondage(
      {super.key, required this.title, required this.sondage});
  final String title;
  final Sondage sondage;

  @override
  State<ResultatSondage> createState() => _ResultatSondageState();
}

class _ResultatSondageState extends State<ResultatSondage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PieChart(PieChartData(sections: [
        for (var uneReponse in widget.sondage.listeReponses.entries)
          PieChartSectionData(
            value: uneReponse.value.toDouble(),
            title: uneReponse.key,
            showTitle: true,
            radius: 70,
            color: const Color.fromARGB(255, 54, 238, 224),
          ),
      ])),
    );
  }
}
