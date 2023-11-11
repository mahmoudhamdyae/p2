import 'package:flutter/material.dart';
import 'package:testt/model/fridge.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

class ViewFridgeView extends StatefulWidget {
  final Fridge fridge;
  const ViewFridgeView({Key? key, required this.fridge}) : super(key: key);

  @override
  State<ViewFridgeView> createState() => _ViewFridgeViewState();
}

class _ViewFridgeViewState extends State<ViewFridgeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.edit_fridge),
      ),
      body: const Placeholder(),
    );
  }
}
