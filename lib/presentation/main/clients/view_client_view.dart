import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:testt/model/client.dart';
import 'package:testt/presentation/component/alert.dart';
import 'package:testt/presentation/main/clients/dialogs/resubscribe_dialog.dart';

import '../../../app/di.dart';
import '../../component/error.dart';
import 'clients_controller.dart';
import 'edit_client_view.dart';

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
                  controller.amber.value.id = client.amberId;
                  controller.amber.value.name = client.amberName;
                  controller.fridge.value.id = client.fridgeId;
                  controller.fridge.value.name = client.fridgeName;
                  controller.term.value.id = client.termId;
                  controller.term.value.name = client.termName;
                  controller.price.value.id = client.priceId;
                  controller.price.value.vegetableName = client.vegetableName;
                  controller.status.value = client.status;
                  controller.fixedPrice.value = int.parse(client.priceAll);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditClient(client: client)));
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
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "اسم العميل: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.name,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "رقم الهاتف: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.phone,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "العنوان: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.address,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "الثلاجة: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.fridgeName,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "العنبر: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.amberName,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "نوع الثمار: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.vegetableName,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "الفترة: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.termName,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "الكمية: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.quantity,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "السعر الكلى: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.priceAll,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // تفاصيل أخرى الطريقة الثانية
          client.ton == "0" && client.smallShakara == "0" && client.bigShakara == "0" ? Container() : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "تفاصيل أخرى ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "عدد الأطنان: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.ton.toString(),
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "عدد الشكاير الصغيرة: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.smallShakara.toString(),
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "عدد الشكاير الكبيرة: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.bigShakara.toString(),
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // تفاصيل أخرى الطريقة الثالثة
          client.average == "0" ? Container() : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "تفاصيل أخرى ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "متوسط وزن الشكارة: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.average.toString(),
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "عدد الشكاير: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.shakyir.toString(),
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "سعر الشكارة الواحدة: ",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 23,
                            ),
                          ),
                          Text(
                            client.priceOne.toString(),
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () {
                controller.amber.value.id = client.amberId;
                controller.amber.value.name = client.amberName;
                controller.fridge.value.id = client.fridgeId;
                controller.fridge.value.name = client.fridgeName;
                controller.term.value.id = client.termId;
                controller.term.value.name = client.termName;
                controller.price.value.id = client.priceId;
                controller.price.value.vegetableName = client.vegetableName;
                showResubscribeDialog(context, client.id.toString());
              },
              child: const Text("تجديد الاشتراك"),
            ),
          )
        ],
          ),
      ),
    );
  }
}
