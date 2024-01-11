import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sondage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int? selectedOption;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showError = false;
  List<String> choix = ['Sirène', 'Dragon', 'Chimère', "Licorne", "Pégase"];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    //deux colonnes précédentes pour que la taille soit définie
                    itemCount: choix.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(choix[index]),
                        leading: Radio<int>(
                          value: index + 1,
                          groupValue: selectedOption,
                          onChanged: (int? value) {
                            setState(() {
                              selectedOption = value!;
                              print('Choix: $selectedOption - '+ choix[selectedOption!-1]);
                            });
                          },
                        ),
                      );
                    },
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (selectedOption == null) {
                          showError = true;
                        } else {
                          showError = false;
                          // Validation successful, proceed with form submission
                          print('Répondu avec succès, choix envoyé: $selectedOption - '+ choix[selectedOption!-1]);
                        }
                      });
                    },
                    child: Text('Envoyer'),
                  ),
                  if (showError)
                    Text(
                      'Veuillez choisir une option',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
