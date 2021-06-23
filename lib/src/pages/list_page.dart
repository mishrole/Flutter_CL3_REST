import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cl3_t6nn_rodriguez_leon_mitchell/src/models/service_object.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;

import 'package:json_table/json_table.dart';

// ignore: must_be_immutable
class ListPage extends StatefulWidget {
  
  List<ServiceObject> oListService = [];
  int codServiceSelected = 0;
  String urlGeneral = "http://wscibertec2021.somee.com/Servicio";
  String urlList = "/Listar?";

  String jsonServices = '[{"CodigoServicio": 0,"NombreCliente": "","NumeroOrdenServicio": "","FechaProgramada": "","Linea": "","Estado": "","Observaciones": "","Eliminado": false,"CodigoError": 0,"DescripcionError": "","MensajeError": null}]';

  ListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListServices();
  
}

class _ListServices extends State<ListPage> {

  @override
  void initState() {
    super.initState();
  }
  
  String _nombre = "";
  String _orden = "";

  Future<String> _getServices() async {
    String urlListServices = widget.urlGeneral + widget.urlList +
     "NombreCliente=" + _nombre + "&NumeroOrdenServicio=" + _orden;
    
    var response = await http.get(Uri.parse(urlListServices));
    var data = response.body;

    var oListServicesTemp = List<ServiceObject>.from(json.decode(data).map((service) => ServiceObject.fromJson(service)));

    for(ServiceObject oServiceObject in oListServicesTemp) {
      print(oServiceObject.NombreCliente);
    }

    setState(() {
      widget.oListService = oListServicesTemp;
      widget.jsonServices = data;
    });

    return "Procesado";
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(widget.jsonServices);
    print("Ejecutado");
    return Scaffold(
      appBar: AppBar(title: Text('Consulta de Servicios')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    _crearInputNombre(),
                    _crearInputOrden(),
                  ]
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child:  Text('Se encontraron ' + widget.oListService.length.toString() + " Servicios"),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        _getServices();
                      }
                    },
                    child: Text('Consultar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Nuevo registro
                      },
                      child: Text('Nuevo'),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
              JsonTable(
                json,
                showColumnToggle: true,
                allowRowHighlight: true,
                rowHighlightColor: Colors.red[300],
                paginationRowCount: 10,
                onRowSelect: (index, map) {
                  widget.codServiceSelected = int.parse(map["CodigoServicio"].toString());
                },
              ),
              SizedBox(
                height: 80.0,
              ),
              Text(
                'Para consultar debe ingresar todos los campos'
              ),
            ],
          ),
        ),
      )
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('   ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  Widget _crearInputNombre() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Ingresa Cliente',
        labelText: 'Cliente'
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onChanged: (value) => setState(() {
        _nombre = value;
      }),
    );
  }

    Widget _crearInputOrden() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Ingresa Número de Orden',
        labelText: 'Nro Orden'
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onChanged: (value) => setState(() {
        _orden = value;
      }),
    );
  }
}
