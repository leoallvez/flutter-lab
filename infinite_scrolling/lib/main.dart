import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> dogsImages = new List();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    fetchFive();
    _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        fetchFive();
      }
    });
  }

  @override
  void dispose() {
    //_scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: dogsImages.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              //constraints: BoxConstraints.tightFor(height: 150.0),
              child: Card(child: Image.network(dogsImages[index], fit: BoxFit.fitWidth)),
            );
          }),
    );
  }

  fetch() async {
    final response = await http.get("https://dog.ceo/api/breeds/image/random");
    if(response.statusCode == 200) {
      setState(() {
        dogsImages.add(json.decode(response.body)["message"]);
      });
    } else {
      throw Exception("failed to load images");
    }
  }

  fetchFive() {
    for(int i = 0; i < 5; i++) {
      fetch();
    }
  }
}
