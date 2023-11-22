import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:testt/model/client.dart';
import 'package:testt/presentation/component/alert.dart';

import '../../../app/di.dart';
import '../../component/error.dart';
import 'clients_controller.dart';

class ViewClientView extends StatelessWidget {
  final ClientsController controller = instance<ClientsController>();
  Client client;

  ViewClientView({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(client.name),
        actions: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  return AwesomeDialog(
                      btnCancelText:
                      "الغاء",
                      btnOkText: "حذف",
                      context: context,
                      dialogType: DialogType
                          .noHeader,
                      title: "حذف",
                      desc:
                      "هل أنت متأكد من حذف العميل ؟",
                      btnCancelOnPress:
                          () {},
                      btnOkOnPress: () async {
                        showLoading(context);
                        try {
                          await controller.delClient(client).then((value) {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          });
                        }  on Exception catch (e) {
                          Navigator.of(context).pop();
                          showError(context, e.toString());
                        }
                      }).show();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  // controller.amber.value = client.amber;
                  // controller.fridge.value = client.fridge;
                  // controller.term.value = client.term;
                  // controller.price.value = client.;
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => EditClient(name: client.name,phone:  client.phone, address: client.address)));
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("ggg")
          ],
        ),
      ),
    );
  }
}
