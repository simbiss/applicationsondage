import 'package:applicationsondage/sondages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:applicationsondage/main.dart';


class PageVisualiserSondages extends StatelessWidget {
  const PageVisualiserSondages({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    
    if (appState.sondages.isEmpty){
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Il y a aucun sondage disponible. Créer un si possible."),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child:  Text("La liste des sondages",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
          ),
          for (var unSondage in appState.sondages)
              Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: ListTile(
                  leading: const Icon(Icons.poll),
                  title: Text(unSondage.uneQuestion),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ),
        ],
      ),
    );

  }
    // Plan to to make a nav bar at the bottom with an add button to make a new sondage along side a deconnexion button 
    // On top of the navbar will just be a list of sondages that will be taken from a list create in app state with already predefined values
    // I might need to make a class for sondage as well as answers in the sondage 
    // But for now i can just focus on sondage since someone else will be doing the answers 
    // Im dumb
}