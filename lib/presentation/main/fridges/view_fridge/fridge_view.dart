import 'package:flutter/material.dart';
import 'package:testt/app/di.dart';
import 'package:testt/model/fridge.dart';
import 'package:testt/presentation/main/fridges/fridges_controller.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

class ViewFridgeView extends StatelessWidget {
  final Fridge fridge;

  const ViewFridgeView({super.key, required this.fridge});

  @override
  Widget build(BuildContext context) {
    FridgesController controller = instance<FridgesController>();
    controller.showFridge(fridge.id);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.edit_fridge),
      ),
      body: const Placeholder(),
    );
  }
}