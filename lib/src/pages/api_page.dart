import 'dart:async';
import 'dart:convert';

import 'package:api_personas/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  @override
  _ApiPageState createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  Future<List<Person>> _listaPersons;

  Future<List<Person>> _obtenerPersons() async {
    List<Person> persons = [];
    final response =
        await http.get(Uri.parse("https://randomuser.me/api/?results=30"));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

      for (var item in jsonData['results']) {
        persons.add(Person(
            nameF: item['name']['first'],
            nameL: item['name']['last'],
            gender: item['gender'],
            email: item['email'],
            picM: item['picture']['large']));
      }
    } else {
      throw Exception('Fallo la llamada a la API');
    }

    return persons;
  }

  @override
  void initState() {
    super.initState();
    _listaPersons = _obtenerPersons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random User: Carlos Fernando Soto Zepeda'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _listaPersons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: _listadoPersons(snapshot.data),
              );
            } else if (snapshot.error) {
              print(snapshot.error);
              return Text('Error al conectar con la API');
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _listadoPersons(List<Person> data) {
    List<Widget> personList = [];

    for (var person in data) {
      personList.add(Card(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(person.picM),
              ),

              //Image.network(person.picM),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      person.nameF + ' ' + person.nameL,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[800]),
                    ),
                    Text(
                      'Género: ' + person.gender,
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      person.email,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
    }

    return personList;
  }
}
