import 'package:atividade/components/appbar.dart';
import 'package:atividade/components/cardAlertas.dart';
import 'package:atividade/components/drawer.dart';
import 'package:atividade/models/alertas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:atividade/repository/firecloud.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fcrp = ref.watch(firecloudRepositoryProvider);

    return Scaffold(
        appBar: AppBarExample(
          title: const Text("Alertas"),
          actions: [],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return ref.invalidate(firecloudRepositoryProvider);
          },
          child: FutureBuilder(
              future: fcrp.recuperaListaAlertas(),
              builder: (context, AsyncSnapshot<List<AlertasModel>> alerta) {
                if (alerta.hasData) {
                  List<AlertasModel>? alertasDados = alerta.data;
                  if (alertasDados is List<AlertasModel>) {
                    return ListView.builder(
                        itemCount: alertasDados.length,
                        itemBuilder: (context, index) =>
                            CardAlerts(alert: alertasDados[index]));
                  }
                }
                return const CircularProgressIndicator();
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your action here
            debugPrint('FAB pressed');
          },
          child: const Icon(Icons.add),
        ),
        drawer: const DrawerExample());
  }
}
