import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  runApp(MyApp());
  //Escrevendo dados na base de dados.
  /*
  Firestore.instance.collection("mensagens").document().setData({
      "texto": "Tudo bem? atualiza mensagem",
      "from": "João",
      "read": false
  });
  */
  //Lendo dados na base de dados.
  //Pegando todos os dados de um document.
  QuerySnapshot snapshot1 = await Firestore.instance.collection("mensagens").getDocuments();
  snapshot1.documents.forEach((doc) {
    //print(doc.documentID);
    //print(doc.data);
  });
  //Pegando varios documentos
  DocumentSnapshot snapshot2 = await Firestore.instance.collection("mensagens").document('evkZelrHvp0lJXUVFrEn').get();
  //print(snapshot2.data);

  //Pegando dados em tempo real.
  int count = 1;
  Firestore.instance.collection("mensagens").snapshots().listen((snapshot) {
    print("documentos ${count++} --------------------------------------------");
    snapshot.documents.forEach((doc) {
      print(doc.data);
    });
  });
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
