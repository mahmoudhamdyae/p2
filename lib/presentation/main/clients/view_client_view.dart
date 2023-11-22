import 'package:flutter/material.dart';
import 'package:testt/model/client.dart';

class ViewClientView extends StatelessWidget {
  Client client;
  ViewClientView({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(client.name),
      ),
      body: Placeholder(),
    );
  }
}
