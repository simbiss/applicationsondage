import 'package:applicationsondage/sondages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Application Sondage',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        ),
        home: const PageVisualierSondages(title: 'Application Sondage'),
      ),  
    );
  }
}

class MyAppState extends ChangeNotifier {
  var sondages = <String>[];
}

class PageVisualierSondages extends StatelessWidget {
  const PageVisualierSondages({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // TODO: implement build
    throw UnimplementedError();
  }
    // Plan to to make a nav bar at the bottom with an add button to make a new sondage along side a deconnexion button 
    // On top of the navbar will just be a list of sondages that will be taken from a list create in app state with already predefined values
    // I might need to make a class for sondage as well as answers in the sondage 
    // But for now i can just focus on sondage since someone else will be doing the answers 
    // Im dumb
}
