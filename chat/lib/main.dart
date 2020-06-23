import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
  //Escrevendo dados na base de dados.
  Firestore.instance.collection("mensagens").document().setData({
      "texto": "Tudo bem? atualiza mensagem",
      "from": "João",
      "read": false
  });
  //Lendo dados na base de dados.
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }

}
