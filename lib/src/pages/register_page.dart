import 'dart:convert';

import 'package:cl3_t6nn_rodriguez_leon_mitchell/src/models/service_object.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async' show Future;

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Servicio')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: <Widget>[
          ServiceFormWidget(),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ServiceFormWidget extends StatefulWidget {
  ServiceFormWidget({Key? key}) : super(key: key);

  ServiceObject oService = new ServiceObject();
  String urlGeneral = "http://wscibertec2021.somee.com/Servicio";
  String urlCreate = "/RegistraModifica?Accion=";
  String message = "";

  @override
  State<StatefulWidget> createState() => _ServiceForm();
  
}

class _ServiceForm extends State<ServiceFormWidget> {

  @override
  void initState() {
    super.initState();
    widget.oService.initialize();
  }

  String _nombre = '';
  String _orden = '';
  String _fecha = '';
  String _linea = '';
  String _estado = '';
  String _observaciones = '';

  TextEditingController _inputFieldDateController = new TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _crearInputNombre(),
          _crearInputOrden(),
          _crearInputFecha(context),
          _crearInputLinea(),
          _crearInputEstado(),
          _crearInputObservaciones(),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    _saveNewService();
                  }
                },
                child: Text('Grabar'),
              ),
            ),
          )
        ],
      ),
    );
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

  Widget _crearInputFecha(BuildContext context) {
    return TextFormField(
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        hintText: 'Ingresa Fecha',
        labelText: 'Fecha'
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      }
    );
  }

  Widget _crearInputLinea() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Ingresa Línea',
        labelText: 'Línea'
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onChanged: (value) => setState(() {
        _linea = value;
      }),
    );
  }

  Widget _crearInputEstado() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Ingresa Estado',
        labelText: 'Estado'
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onChanged: (value) => setState(() {
        _estado = value;
      }),
    );
  }

  Widget _crearInputObservaciones() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Ingresa Observaciones',
        labelText: 'Observaciones'
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onChanged: (value) => setState(() {
        _observaciones = value;
      }),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2030),
      locale: Locale('es', 'ES')
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.toString();
        _inputFieldDateController.text = _fecha;
      });
    }
  }

  Future<String> _saveNewService() async {
    String accion = "N";

    String urlParams = "${widget.urlGeneral}${widget.urlCreate}$accion&NombreCliente=$_nombre&NumeroOrdenServicio=$_orden&FechaProgramada=$_fecha&Linea=$_linea&Estado=$_estado&Observaciones=$_observaciones";

    var response = await http.get(Uri.parse(urlParams));
    var data = response.body;

    setState(() {
      widget.oService = ServiceObject.fromJson(json.decode(data));

      if(widget.oService.CodigoServicio != 0) {
        widget.message = "Grabado correctamente";
        _showAlert(context);
      } else {
        widget.message = "Ocurrió un error al guardar";
        _showAlert(context);
      }
    });

    return "Registrando";
  }

    void _showAlert(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return Center(
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text(widget.message),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
            ],
          ),
          actions: <Widget>[
            ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text('Aceptar')),
          ],
        ),
      );
    });
  }
}

