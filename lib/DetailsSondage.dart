import 'package:applicationsondage/PageVisualiserSondage.dart';
import 'package:applicationsondage/pageReponse.dart';
import 'package:applicationsondage/sondages.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'creation_sondage.dart';
import 'main.dart';
import 'ResultatSondage.dart';
import 'package:applicationsondage/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  bool isFavori = false;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(AppLocalizations.of(context)!.created_by(
                    "${widget.sondage.utilisateur?.username.toString()}")),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (appState.sondagesFavoris.contains(widget.sondage)) {
                      appState.supprimerSondageFavori(widget.sondage);
                    } else {
                      appState.addSondageFavori(widget.sondage);
                    }
                  });
                },
                icon: Icon(
                  appState.sondagesFavoris.contains(widget.sondage)
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
              ),
            ],
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
            child: Text(AppLocalizations.of(context)!.btn_vote),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultatSondage(
                            title: 'Résultat du sondage',
                            sondage: widget.sondage)));
              },
              child: Text(AppLocalizations.of(context)!.btn_result))
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
