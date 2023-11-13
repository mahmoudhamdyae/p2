import 'package:flutter/material.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

class ClientsView extends StatelessWidget {
  const ClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.clients_button),
      ),
    body: Placeholder(),
    );
  }
}
