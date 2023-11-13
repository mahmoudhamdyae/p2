import 'package:flutter/material.dart';

import '../../resources/strings_manager.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.users_button),
      ),
      body: Placeholder(),
    );
  }
}
