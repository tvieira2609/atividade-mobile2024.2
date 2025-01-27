import 'package:atividade/models/alertas.dart';
import 'package:atividade/repository/firecloud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardAlerts extends ConsumerWidget {
  final AlertasModel alert;
  const CardAlerts({super.key, required this.alert});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(this.alert.evento),
        subtitle: Row(children: <Widget>[
          const Icon(Icons.calendar_month, size: 16),
          const Text("Data:", style: TextStyle(fontSize: 12)),
          Expanded(
            child: Text(
              alert.timestamp.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ]),
        trailing: IconButton(
            onPressed: () async {
              await ref.watch(firecloudRepositoryProvider).apagarAlerta(alert);
              ref.invalidate(firecloudRepositoryProvider);
            },
            icon: const Icon(Icons.delete_forever)),
      ),
    );
  }
}
