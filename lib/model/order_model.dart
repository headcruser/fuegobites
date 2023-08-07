import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String ? docId;
  final String nombre;
  final String descripcion;
  final String fecha;
  final String fechaEntrega;
  final bool activo;
  final bool pagado;
  final double precio;

  OrderModel({
    this.docId,
    required this.nombre,
    required this.descripcion,
    required this.fecha,
    required this.fechaEntrega,
    required this.activo,
    required this.pagado,
    this.precio = 0
  });

  Map<String, dynamic> toMap() {
    return {    
      'nombre': nombre,
      'descripcion': descripcion,
      'fecha': fecha,
      'fecha_entrega': fechaEntrega,
      'activo': activo,
      'pagado': pagado,
      'precio': precio,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      docId: map['docId'] != null ? map['docId'] as String : null,
      nombre: map['nombre'] as String,
      descripcion: map['descripcion'] ?? '',
      fecha: map['fecha'] ?? '',
      fechaEntrega: map['fecha_entrega'] ?? '',
      activo: map['activo'] ?? false,
      pagado: map['pagado'] ?? false,
      precio: map['precio']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> doc){
    return  OrderModel(
      docId:  doc.id,
      nombre: doc['nombre'] ?? '', 
      descripcion: doc['descripcion'] ?? '',  
      fecha: '', 
      fechaEntrega: "", 
      activo: doc['activo'] ?? false, 
      pagado: doc['pagado'] ?? false,
      precio: 0,
    );
  } 
}
