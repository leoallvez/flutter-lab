import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heigthController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!";

  void _resetField() => setState(() {
      weightController.text = "";
      heigthController.text = "";
      _infoText = "Informe seus dados!";
  });

  void _calculate() => setState((){
    double weight = double.parse(weightController.text);
    double heigth = double.parse(heigthController.text) / 100;
    double imc = weight/(heigth*heigth);
    int result = imc.round();
    if(imc < 18.6) {
      _infoText = "Abaixo do peso ($result)";
    } else if(imc >= 18.6 && imc < 24.9) {
      _infoText = "Peso ideal ($result)";
    } else if(imc >= 24.9 && imc < 29.9) {
      _infoText = "Levemente Acima do Peso ($result)";
    } else if(imc >= 29.9 && imc < 34.9) {
      _infoText = "Obesidade Grau I ($result)";
    } else if(imc >= 34.9 && imc < 39.9) {
      _infoText = "Obesidade Grau II ($result)";
    } else if(imc >= 40) {
      _infoText = "Obesidade Grau III ($result)";
    }
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () => _resetField()
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.green
              ),
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0
                ),
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira seu peso";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: heigthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(
                      color: Colors.green
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0
                ),
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira sua altura";
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                          "Calcular",
                          style: TextStyle(
                              color: Colors.white, fontSize: 25.0
                          )),
                      color: Colors.green,
                    )
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
        )
      )
    );
  }
}

