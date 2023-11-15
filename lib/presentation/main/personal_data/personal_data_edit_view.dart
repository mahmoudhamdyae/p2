import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testt/presentation/main/personal_data/personal_data_controller.dart';

import '../../../app/di.dart';

class PersonalDataEditView extends StatelessWidget {
  PersonalDataEditView({super.key});

  PersonalDataController controller = instance<PersonalDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل البيانات"),
      ),
      body: Placeholder(),
    );
  }
}
