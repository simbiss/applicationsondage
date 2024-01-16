import 'package:applicationsondage/creation_sondage.dart';
import 'package:flutter/material.dart';

import 'sondages.dart';

class ListeSondagesPage extends StatelessWidget {
  final List<Sondage> listeSondages;

  ListeSondagesPage({required this.listeSondages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des sondages'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: listeSondages.length,
        itemBuilder: (context, index) {
          Sondage sondage = listeSondages[index];
          return ListTile(
            title: Text(sondage.uneQuestion),
            subtitle: Text(sondage.listeReponses.join(", ")),
          );
        },
      ),
    );
  }
}
