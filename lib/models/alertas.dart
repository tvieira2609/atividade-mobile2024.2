import 'package:cloud_firestore/cloud_firestore.dart';

class AlertasModel {
  final String idEmpresa;
  final DateTime timestamp;
  final String evento;
  final String id;
  AlertasModel({required this.idEmpresa, required this.timestamp, required this.evento, required this.id});

  static fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> docs){
    final data = docs.data();
    return AlertasModel(
      idEmpresa: data['idEmpresa'].toString(),
      timestamp: DateTime.parse(data['timestamp']),
      evento: data['evento'],
      id: data['id'].toString()
    );
  }
}