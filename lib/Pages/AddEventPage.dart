import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';


class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  final _formKey = new GlobalKey<FormState>();

  final _confNameController = new TextEditingController();
  final _speakerNameController = new TextEditingController();
  String _selectedConfType = "Talk";
  DateTime _selectedConfDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();

    _confNameController.dispose();
    _speakerNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text("Libellé de la conférence", /* style: TextStyle(color: Colors.blue),*/),
                  hintText: "Entrez le libellé de la conférence",
                  border: OutlineInputBorder()
                ),
                controller: _confNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Remplissez ce champ s'il vous plaît.";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    label: Text("Auteur de la conférence", /* style: TextStyle(color: Colors.blue),*/),
                    hintText: "Entrez le l'auteur de la conférence",
                    border: OutlineInputBorder()
                ),
                controller: _speakerNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Remplissez ce champ s'il vous plaît.";
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
                items: [
                  DropdownMenuItem(
                    child: Text("Demo Practise"),
                    value: "Demo",
                  ),
                  DropdownMenuItem(
                    child: Text("Partner Present"),
                    value: "Partner",
                  ),
                  DropdownMenuItem(
                    child: Text("Talk Show"),
                    value: "Talk",
                  ),
                ],
                value: _selectedConfType,
                onChanged: (value) {
                  setState(() {
                    _selectedConfType = value!;
                  });
                },
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                      hintText: "Sélectionnez la date de conférence",
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      labelText: 'Entrez une date',
                      suffixIcon: Icon(Icons.event_note)
                  ),
                  firstDate: DateTime.now().add(const Duration(days: 10)),
                  lastDate: DateTime.now().add(const Duration(days: 40)),
                  mode: DateTimeFieldPickerMode.dateAndTime,
                  autovalidateMode: AutovalidateMode.always,
                  initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                  // validator: (e) => (e?.day ?? 0 ) == 1 ? 'Sélectionnez une date' : null,
                  validator: (value) {
                    if (value == null) {
                      return "Remplissez ce champ s'il vous plaît.";
                    }
                    return null;
                  },
                  onChanged: (DateTime? value) {
                    print(value);
                  },
                )
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Soumettre", style: TextStyle(color: Colors.white, fontSize: 17),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.blue),
                    padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final subject = _confNameController.text;
                      final speaker = _speakerNameController.text;

                      CollectionReference eventReference = FirebaseFirestore.instance.collection("Events");
                      eventReference.add({
                        'subject' : subject,
                        'speaker' : speaker,
                        'type' : _selectedConfType,
                        'date' : _selectedConfDate,
                        'avatar' : 'legend1.jpg'
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Formulaire soumis"),
                            backgroundColor: Colors.blue,
                          )
                      );
                      FocusScope.of(context).requestFocus(FocusNode());

                      print("Libellé de la conférence : $subject");
                      print("Auteur de la conférence : $speaker");
                      print("Type de la conférence : $_selectedConfType");
                      print("Date et Heure de la conférence : $_selectedConfDate");

                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
