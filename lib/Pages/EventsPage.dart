import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  /* final events = [
    {
      'avatar' : 'legend1.jpg',
      'date' : '30/04/2022, 13h à 20h',
      'subject' : 'Recréer Symfony',
      'speaker' : 'Lior Chamla',
      'type' : 'Demo practise'
    },
    {
      'avatar' : 'legend2.jpg',
      'date' : '30/04/2022, 16h à 18h',
      'subject' : 'Sécurité des applications webs',
      'speaker' : 'Jonathan Boyer',
      'type' : 'Present partner'
    },
    {
      'avatar' : 'legend3.jpg',
      'date' : '21/01/2022, 14h à 15h30',
      'subject' : 'Maîtriser les bases de Linux',
      'speaker' : 'Jason Champagne',
      'type' : 'Demo practise'
    },
  ]; */

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Events").orderBy("date")/*.where("type", isEqualTo: "Demo")*/.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blue,),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text("Aucun évènement dans la base de données", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            );
          }

          List<dynamic> events = [];
          snapshot.data!.docs.forEach((element) {
            events.add(element);
          });

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {

              final event = events[index];

              final avatar = event['avatar'].toString().toLowerCase();
              final Timestamp timestamp = event['date'];
              final String date = DateFormat.yMd().add_jm().format(timestamp.toDate());
              final subject = event['subject'];
              final speaker = event['speaker'];
              final type = event['type'];

              return Card(
                child: ListTile(
                  leading: Image.asset("assets/images/$avatar"),
                  title: Text("$subject"),
                  subtitle: Text("$speaker, $date,   *$type*"),
                  trailing: Icon(Icons.more_vert),
                ),
              );
            },
          );

        }
    );

      /* ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {

          final event = events[index];

          final avatar = event['avatar'];
          final date = event['date'];
          final subject = event['subject'];
          final speaker = event['speaker'];
          final type = event['type'];

          return Card(
            child: ListTile(
              leading: Image.asset("assets/images/$avatar"),
              title: Text("$subject"),
              subtitle: Text("$speaker, $date"),
              trailing: Icon(Icons.more_vert),
            ),
          );
        },
      ) */
  }
}
