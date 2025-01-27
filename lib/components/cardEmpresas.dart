import 'package:atividade/models/empresas.dart';
import 'package:atividade/repository/firecloud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardEmpresas extends ConsumerWidget {
  final EmpresasModel empresa;
  const CardEmpresas({super.key, required this.empresa});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(empresa.nome),
        subtitle: Row(
          children: <Widget>[
            const Icon(Icons.calendar_month, size: 16),
            const Text("Inicio:", style: TextStyle(fontSize: 12)),
            Expanded(
              child: Text(
                empresa.inicioData.toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            const Icon(Icons.calendar_month, size: 16),
            const Text("Fim:", style: TextStyle(fontSize: 12)),
            Expanded(
              child: Text(
                empresa.fimData.toString(),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          height: 48, // Match the constraint
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Renovar",
                style: TextStyle(fontSize: 12), // Smaller text
              ),
              IconButton(
                padding: EdgeInsets.zero, // Remove padding
                constraints: const BoxConstraints(), // Remove constraints
                visualDensity: VisualDensity.compact, // Minimize space
                iconSize: 20, // Smaller icon
                onPressed: () async {
                  DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050));
                  if (date is DateTime){
                    await ref.watch(firecloudRepositoryProvider).renovarLicenca(date: date, empresaModel: empresa);
                    ref.invalidate(firecloudRepositoryProvider);
                  }
                },
                icon: const Icon(Icons.autorenew),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
