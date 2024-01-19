import 'package:applicationsondage/PageVisualiserSondage.dart';
import 'package:applicationsondage/pageReponse.dart';
import 'package:applicationsondage/sondages.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'indicator.dart';
import 'creation_sondage.dart';
import 'main.dart';
import 'Votes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'creation_sondage.dart';
import 'main.dart';
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
  int indexPieColors = 0;
  int indexKeyColors = 0;
  bool isFavori = false;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
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
          const SizedBox(
            height: 4,
          ),
          if (appState.hasVoted(widget.sondage, appState.utilisateurLoggedIn) ==
              true)
            AspectRatio(
              aspectRatio: 1,
              child: PieChart(PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: List.generate(
                  widget.sondage.listeReponses.entries.length,
                  (index) {
                    var uneReponse =
                        widget.sondage.listeReponses.entries.elementAt(index);
                    return PieChartSectionData(
                      color: colorRotator(index),
                      value: uneReponse.value.toDouble(),
                      title: uneReponse.key,
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                      ),
                    );
                  },
                ),
              )),
            ),
          if (appState.hasVoted(widget.sondage, appState.utilisateurLoggedIn) ==
              true)
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    widget.sondage.listeReponses.entries.length, (index) {
                  var uneReponse =
                      widget.sondage.listeReponses.entries.elementAt(index);
                  return Column(
                    children: [
                      Indicator(
                        color: colorRotator(index),
                        text: uneReponse.key,
                        isSquare: true,
                      ),
                      const SizedBox(
                        height: 4,
                      )
                    ],
                  );
                })),
          const SizedBox(
            width: 28,
          ),
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

  Color colorRotator(int index) {
    switch (index % 4) {
      case 0:
        return const Color.fromARGB(255, 54, 238, 224);
      case 1:
        return const Color.fromARGB(255, 246, 82, 160);
      case 2:
        return const Color.fromARGB(255, 244, 255, 97);
      case 3:
        return const Color.fromARGB(255, 54, 238, 94);
      default:
        return const Color.fromARGB(255, 54, 238, 94);
    }
  }
}
