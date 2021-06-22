import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consulta de Servicio')),
      
    );
  }
}

class ListServices extends StatefulWidget {
  final String titulo;
  ListServices(this.titulo);

  @override
  State<StatefulWidget> createState() => _ListServices();
}

class _ListServices extends State<ListServices> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consulta de Servicios')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

          ]
        ),
      )
    );
  }
}
