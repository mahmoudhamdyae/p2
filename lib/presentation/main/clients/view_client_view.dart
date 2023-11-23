import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:testt/presentation/component/alert.dart';
import 'package:testt/presentation/main/clients/dialogs/resubscribe_dialog.dart';

import '../../../app/di.dart';
import '../../component/error.dart';
import 'clients_controller.dart';
import 'edit_client_view.dart';

class ViewClientView extends StatelessWidget {
  final ClientsController controller = instance<ClientsController>();

  ViewClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.client.value.name),
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
                          await controller.delClient(controller.client.value).then((value) {
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
                  controller.amber.value.id = controller.client.value.amberId;
                  controller.amber.value.name = controller.client.value.amberName;
                  controller.fridge.value.id = controller.client.value.fridgeId;
                  controller.fridge.value.name = controller.client.value.fridgeName;
                  controller.term.value.id = controller.client.value.termId;
                  controller.term.value.name = controller.client.value.termName;
                  controller.price.value.id = controller.client.value.priceId;
                  controller.price.value.vegetableName = controller.client.value.vegetableName;
                  controller.status.value = controller.client.value.status;
                  controller.fixedPrice.value = int.parse(controller.client.value.priceAll);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditClient(client: controller.client.value)));
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
                            controller.client.value.name,
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
                            controller.client.value.phone,
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
                            controller.client.value.address,
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
                            controller.client.value.fridgeName,
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
                            controller.client.value.amberName,
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
                            controller.client.value.vegetableName,
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
                            controller.client.value.termName,
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
                            controller.client.value.quantity,
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
                            controller.client.value.priceAll,
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
            controller.client.value.ton == "0" && controller.client.value.smallShakara == "0" && controller.client.value.bigShakara == "0" ? Container() : Padding(
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
                            controller.client.value.ton.toString(),
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
                            controller.client.value.smallShakara.toString(),
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
                            controller.client.value.bigShakara.toString(),
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
            controller.client.value.average == "0" ? Container() : Padding(
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
                            controller.client.value.average.toString(),
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
                            controller.client.value.shakyir.toString(),
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
                            controller.client.value.priceOne.toString(),
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
                controller.amber.value.id = controller.client.value.amberId;
                controller.amber.value.name = controller.client.value.amberName;
                controller.fridge.value.id = controller.client.value.fridgeId;
                controller.fridge.value.name = controller.client.value.fridgeName;
                controller.term.value.id = controller.client.value.termId;
                controller.term.value.name = controller.client.value.termName;
                controller.price.value.id = controller.client.value.priceId;
                controller.price.value.vegetableName = controller.client.value.vegetableName;
                showResubscribeDialog(context, controller.client.value.id.toString());
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
