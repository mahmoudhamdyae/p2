import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:testt/data/services/api_service.dart';
import 'package:testt/model/fridge.dart';
import 'package:testt/presentation/common/state_renderer/state_renderer.dart';
import 'package:testt/presentation/component/empty.dart';
import 'package:testt/presentation/resources/strings_manager.dart';

import '../../../app/di.dart';
import '../../component/error.dart';
import '../../resources/routes_manager.dart';

class PricesView extends StatefulWidget {
  const PricesView({Key? key}) : super(key: key);

  @override
  State<PricesView> createState() => _PricesViewState();
}

class _PricesViewState extends State<PricesView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: null,
          title: const Text(AppStrings.fridges)
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.addFridgeRoute);
          }),
      body: const PricesList(),
    );
  }
}

class PricesList extends StatefulWidget {
  const PricesList({super.key});

  @override
  State<PricesList> createState() => _PricesListState();
}

class _PricesListState extends State<PricesList> {
  final ApiService _apiService = instance<ApiService>();
  List<Fridge> _prices = [];
  bool _isLoading = true;
  String? _error;

  _getPrices() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _apiService.getFridges().then((value) {
        _prices = value;
        setState(() {
          _isLoading = false;
        });
      });
    } on Exception catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  _delFridge(int id) async {
    try {
      await _apiService.delFridge(id).then((value) {
        _prices.remove(value);
      });
    } on Exception catch (e) {
      showError(context, e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getPrices();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return StateRenderer(
          stateRendererType: StateRendererType.fullScreenLoadingState,
          retryActionFunction: () {});
    } else if (_error != null) {
      return StateRenderer(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: _error.toString().replaceFirst("Exception: ", ""),
          retryActionFunction: () {
            _getPrices();
          });
    } else {
      return ListView.builder(
        itemCount: _prices.length,
        itemBuilder: (context, index) {
          final item = _prices[index];

          if (_prices.isEmpty) {
            return emptyScreen(context, "لا يوجد ثلاجات");
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                await _getPrices();
              },
              child: ListTile(
                title: Text(item.name),
                subtitle: Text(item.size.toString()),
                leading: IconButton(
                  onPressed: () async {
                    return AwesomeDialog(
                        btnCancelText: "الغاء",
                        btnOkText: "حذف",
                        context: context,
                        dialogType: DialogType.noHeader,
                        title: "حذف ثلاجة",
                        desc: "هل أنت متأكد منحذف هذه الثلاجة ؟",
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          await _delFridge(item.id);
                        }).show();
                  },
                  icon: const Icon(
                      Icons.delete
                  ),
                ),
              ),
            );
          }
        },
      );
    }
  }
}
