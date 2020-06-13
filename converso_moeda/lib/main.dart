import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MaterialApp(
  home: Home(),
  theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintStyle: TextStyle(color: Colors.amber),
      )),
));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double _euro;
  double _dollar;
  static const _request = "https://api.hgbrasil.com/finance?key=45e75b89";

  Future<Map> _getData() async {
    http.Response response = await http.get(_request);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
              future: _getData(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return _getText("Carregando Dados...");
                  default:
                    if(snapshot.hasError) {
                        return _getText("Erro ao carregar dados");
                    }
                    _dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                    _euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(
                              Icons.monetization_on,
                              size: 150.0,
                              color: Colors.amber
                          )
                        ]
                      ),
                    );
                }
              }
          ),
    );
  }
}

Widget _getText(String text) {
  return Center(
      child: Text(
          text,
          style: TextStyle(
              color: Colors.amber,
              fontSize: 25.0
          ),
          textAlign: TextAlign.center
      )
  );
}