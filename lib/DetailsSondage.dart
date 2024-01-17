import 'package:applicationsondage/PageVisualiserSondage.dart';
import 'package:applicationsondage/pageReponse.dart';
import 'package:applicationsondage/sondages.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'creation_sondage.dart';

class DetailsSondages extends StatefulWidget {
  const DetailsSondages(
      {super.key, required this.title, required this.sondage});
  final String title;
  final Sondage sondage;

  @override
  State<DetailsSondages> createState() => _DetailsSondagesState();
}

class _DetailsSondagesState extends State<DetailsSondages> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(widget.sondage.uneQuestion,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
          ),
          Container(
            child: Text("Cree par : ${widget.sondage.utilisateur?.username}"),
          ),
          for (var map in widget.sondage.listeReponses.entries)
            ListTile(
              tileColor: const Color.fromARGB(255, 54, 238, 224),
              title: Text("${map.key} "),
              subtitle: Text("Nombre de repondants : ${map.value}"),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageReponse(
                    title: "Repondre au sondage",
                    sondage: widget.sondage,
                  ),
                ),
              );
            },
            child: const Text("Voter"),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 76, 82, 112),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 76, 82, 112),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 3, 162, 184),
            gap: 12,
            padding: const EdgeInsets.all(20),
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageVisualiserSondages(
                          title: "Application de sondage"),
                    ),
                  );
                }
                if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreationSondage(),
                    ),
                  );
                }
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.favorite,
                text: 'Favoris',
              ),
              GButton(
                icon: Icons.add,
                text: 'Ajouter',
              ),
              GButton(icon: Icons.account_circle, text: 'Profil')
            ],
          ),
        ),
      ),
    );
  }
}