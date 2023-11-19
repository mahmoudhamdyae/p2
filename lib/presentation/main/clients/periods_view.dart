import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app/di.dart';
import 'clients_controller.dart';

class PeriodsView extends StatelessWidget {
  PeriodsView({super.key});
  final ClientsController controller = instance<ClientsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الفترات"),
      ),
      body: Placeholder(),
    );
  }
}
