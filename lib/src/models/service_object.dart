import 'dart:convert';

class ServiceObject {
  int? CodigoServicio;
  String? NombreCliente;
  String? NumeroOrdenServicio;
  String? FechaProgramada;
  String? Linea;
  String? Estado;
  String? Observaciones;
  bool? Eliminado;
  int? CodigoError;
  String? DescripcionError;
  String? MensajeError;

  void initialize() {
    this.CodigoServicio = 0;
    this.NombreCliente = "";
    this.NumeroOrdenServicio = "";
    this.FechaProgramada = "";
    this.Linea = "";
    this.Estado = "";
    this.Observaciones = "";
    this.Eliminado = false;
    this.CodigoError = 0;
    this.DescripcionError = "";
    this.MensajeError = "";
  }

  ServiceObject(
      { required this.CodigoServicio,
      required this.NombreCliente,
      required this.NumeroOrdenServicio,
      required this.FechaProgramada,
      required this.Linea,
      required this.Estado,
      required this.Observaciones,
      required this.Eliminado,
      required this.CodigoError,
      required this.DescripcionError,
      required this.MensajeError});

  factory ServiceObject.fromJson(Map<String, dynamic> json) {
    return ServiceObject(
      CodigoServicio: json["CodigoServicio"],
      NombreCliente: json["NombreCliente"],
      NumeroOrdenServicio: json["NumeroOrdenServicio"],
      FechaProgramada: json["FechaProgramada"],
      Linea: json["Linea"],
      Estado: json["Estado"],
      Observaciones: json["Observaciones"],
      Eliminado: json["Eliminado"],
      CodigoError: json["CodigoError"],
      DescripcionError: json["DescripcionError"],
      MensajeError: json["MensajeError"],
    );
  }
}
