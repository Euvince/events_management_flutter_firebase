import 'package:asynconf2/Pages/AddEventPage.dart';
import 'package:asynconf2/Pages/EventsPage.dart';
import 'package:asynconf2/Pages/HomePage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asynconf 2022',
      home: Scaffold(
        appBar: AppBar(
          title: [
            Text("Acceuil", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Poppins"),),
            Text("Planning des évènements", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Poppins"),),
            Text("Ajouter un évènement", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Poppins"),),
          ][_currentIndex],
          backgroundColor: Colors.blue,
        ),
        body: [
          HomePage(),
          EventsPage(),
          AddEventPage(),
        ][_currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            /* Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => AddEventPage()
                )
            ); */
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Bouton cliqué"),
                  backgroundColor: Colors.blue,
                )
            );
            print("Bouton cliqué");
          },
          backgroundColor: Colors.blue,
          child: Icon(Icons.add, color: Colors.white,),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          selectedFontSize: 18,
          elevation: 20,
          iconSize: 32,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Acceuil"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: "Planning"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Ajouter"
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

