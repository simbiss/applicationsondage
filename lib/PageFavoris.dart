import 'package:applicationsondage/DetailsSondage.dart';
import 'package:applicationsondage/PageVisualiserSondage.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:applicationsondage/main.dart';

import 'creation_sondage.dart';

class PageFavoris extends StatefulWidget {
  const PageFavoris({super.key, required this.title});
  final String title;

  @override
  State<PageFavoris> createState() => _PageFavorisState();
}

class _PageFavorisState extends State<PageFavoris> {
  var selectedIndex = 3;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text("Les sondages favouris",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
          ),
          for (var unSondage in appState.sondagesFavoris)
            Container(
              color: const Color.fromARGB(255, 246, 82, 160),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailsSondages(title: "", sondage: unSondage)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            unSondage.uneQuestion,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Icon(Icons.poll)
                    ],
                  ),
                ),
              ),
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
            selectedIndex: 1,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
                if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreationSondage(),
                    ),
                  );
                }
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PageVisualiserSondages(
                          title: "Application sondages"),
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
