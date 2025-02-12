import 'package:atividade/models/empresas.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/alertas.dart';
// Making a typedef is optional but can make the code more readable.

final firecloudRepositoryProvider = Provider<FirecloudRepository>(
    (ref) =>
         FirecloudRepository(instance: FirebaseFirestore.instance));

abstract class FirecloudDataSource {
  Future<List<AlertasModel>> recuperaListaAlertas();
  Future<EmpresasModel> recuperaEmpresa();
  Future<bool> apagarAlerta(AlertasModel alerta);
  Future<bool> renovarLicenca({required DateTime date, required EmpresasModel empresaModel});
}

class FirecloudRepository implements FirecloudDataSource {
  FirebaseFirestore instance;
  FirecloudRepository({required this.instance});

  @override
  Future<bool> renovarLicenca({required DateTime date, required EmpresasModel empresaModel}) async {
    try {
      final query = instance.collection('empresas').where('id', isEqualTo: empresaModel.id);
      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        print('No document found with idEmpresa: ${empresaModel.id}');
        return false;
      }
      final batch = instance.batch();

      //Cria o novo objeto de empresa que irá modificar o atual presente na base de dados
      EmpresasModel empresa = EmpresasModel.fromFirestore(snapshot.docs.first);
      EmpresasModel novaEmpresa = EmpresasModel(nome: empresa.nome, fimData: date, inicioData: empresa.inicioData, id: empresa.id);

      batch.update(snapshot.docs.first.reference, novaEmpresa.toFirestore);
      await batch.commit();
      return true;
    } catch (e) {
      print('Error deleting alert ${empresaModel.id}: $e');
      return false;
    }
  }

  @override
  Future<bool> apagarAlerta(AlertasModel alerta) async {
    try {
      final query = instance.collection('alertas').where('id', isEqualTo: alerta.id);
      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        print('No document found with id: ${alerta.id}');
        return false;
      }

      // Use a batch to delete all matching documents (if multiple)
      final batch = instance.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
      return true;
    } catch (e) {
      print('Error deleting alert ${alerta.id}: $e');
      return false;
    }
  }
  
  @override
  Future<EmpresasModel> recuperaEmpresa() async {
    try {
      final query = instance.collection('empresas').where('id', isEqualTo: '1');
      final snapshot = await query.get();
      return EmpresasModel.fromFirestore(snapshot.docs.first);
    } catch (e) {
      throw Exception("Error fetching alerts: $e");
    }
  }
  @override
  Future<List<AlertasModel>> recuperaListaAlertas() async {
    try {
      final query = instance.collection('alertas');
      final snapshot = await query.get();
      final results = snapshot.docs
          .map<AlertasModel>((doc) => AlertasModel.fromFirestore(doc))
          .toList();
      return results;
    } catch (e) {
      throw Exception("Error fetching alerts: $e");
    }
  }
}
