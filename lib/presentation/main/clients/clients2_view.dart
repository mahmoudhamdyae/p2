import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testt/app/di.dart';
import 'package:testt/presentation/main/clients/clients_controller.dart';

class Clients2View extends StatelessWidget {
  Clients2View({super.key});
  final ClientsController controller = instance<ClientsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("عملاء"),
      ),
      body: Placeholder(),
    );
  }
}
