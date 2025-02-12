import 'package:atividade/components/appbar.dart';
import 'package:atividade/components/cardEmpresas.dart';
import 'package:atividade/components/drawer.dart';
import 'package:atividade/models/empresas.dart';
import 'package:atividade/repository/firecloud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirecloudRepository fcrp = ref.watch(firecloudRepositoryProvider);

    return Scaffold(
        appBar: AppBarExample(
          title: Text("Perfil"),
          actions: [],
        ),
        body: FutureBuilder(
            future: fcrp.recuperaEmpresa(),
            builder: (context, AsyncSnapshot<EmpresasModel> empresa) {
              if (empresa.hasData) {
                EmpresasModel? empresaDados = empresa.data;
                if (empresaDados is EmpresasModel) {
                  return CardEmpresas(empresa: empresaDados);
                }
              }
              return const CircularProgressIndicator();
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add FAB action here
            debugPrint('FAB pressed');
          },
          child: const Icon(Icons.add),
        ),
        drawer: const DrawerExample());
  }
}
