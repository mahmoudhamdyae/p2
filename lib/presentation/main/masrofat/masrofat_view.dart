import 'package:flutter/material.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

class MasrofatView extends StatelessWidget {
  const MasrofatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.masrofat),
      ),
      body: const Placeholder(),
    );
  }
}
