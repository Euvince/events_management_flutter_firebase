import 'package:asynconf2/Pages/AddEventPage.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/ori_logo.png", height: 400,),
          Padding(padding: EdgeInsets.only(bottom: 15)),
          Text(
            "Bienvenu au salon de l'asynconf 2022 qui réunit chaque année tous les développeurs",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            "Salon de présentation de l'asynconf 2022 de Graven, tous les devs y sont conviés",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          /* ElevatedButton(
              onPressed: () {
                /* Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => AddEventPage()
                    )
                ); */
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text("Bouton cliqué")
                    )
                );
                print("Bouton cliqué");
              },
              child: Text("Afficher le planning", style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                padding: MaterialStatePropertyAll(EdgeInsets.all(11))
              ),
          ), */
          ElevatedButton.icon(
            onPressed: () {
              /* Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => AddEventPage()
                    )
                ); */
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("Bouton cliqué")
                  )
              );
              print("Bouton cliqué");
            },
            icon: Icon(Icons.calendar_month, color: Colors.white,),
            label: Text("Afficher le planning", style: TextStyle(color: Colors.white),),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
                padding: MaterialStatePropertyAll(EdgeInsets.all(11))
            ),
          ),
        ],
      ),
    );
  }
}