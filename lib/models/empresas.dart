import 'package:cloud_firestore/cloud_firestore.dart';

class EmpresasModel {
  final String id;
  final String nome;
  final DateTime fimData;
  final DateTime inicioData;

  EmpresasModel(
      {required this.nome,
      required this.fimData,
      required this.inicioData,
      required this.id});

  static fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> docs) {
    final data = docs.data();
    return EmpresasModel(
        id: data['id'].toString(),
        nome: data['nome'],
        fimData: DateTime.parse(data['fimData']),
        inicioData: DateTime.parse(data['inicioData']));
  }

  Map<String, dynamic> get toFirestore {
    return {
      'id': id,
      'nome': nome,
      'inicioData': inicioData.toIso8601String(),
      'fimData': fimData.toIso8601String(),
    };
  }
}
