import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Mulish',
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int eixoX = 0;
  int eixoY = 0;
  void subir() {
    setState(() {
      eixoX++;
    });
  }

  void descer() {
    setState(() {
      eixoX--;
    });
  }

  void direita() {
    setState(() {
      eixoY++;
    });
  }

  void esquerda() {
    setState(() {
      eixoY--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Card(
          elevation: 10.0,
          shape: CircleBorder(),
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: Center(child: Text('PRESS', style: TextStyle())),
          )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onPanUpdate: (details) {
              if (details.delta.dx > 0) {
                subir();
              } else {
                descer();
              }
              if (details.delta.dy > 0) {
                direita();
              } else {
                esquerda();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue[400],
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
