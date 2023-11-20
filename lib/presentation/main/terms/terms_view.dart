import 'package:flutter/material.dart';
import 'package:testt/presentation/main/terms/terms_controller.dart';

import '../../../app/di.dart';
import '../clients/clients_controller.dart';

class TermsView extends StatelessWidget {
  TermsView({super.key});
  final TermsController controller = instance<TermsController>();

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
