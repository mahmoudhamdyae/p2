import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testt/data/services/api_service.dart';
import 'package:testt/model/fridge.dart';
import 'package:testt/presentation/common/state_renderer/state_renderer.dart';
import 'package:testt/presentation/component/empty.dart';
import 'package:testt/presentation/main/fridges/bloc/fridges_bloc.dart';
import 'package:testt/presentation/main/fridges/edit_fridge/edit_fridge_view.dart';
import 'package:testt/presentation/main/fridges/view_fridge/fridge_view.dart';
import 'package:testt/presentation/resources/strings_manager.dart';
import 'package:testt/presentation/resources/values_manager.dart';

import '../../../app/di.dart';
import '../../component/error.dart';
import '../../resources/routes_manager.dart';

class FridgesView extends StatefulWidget {
  const FridgesView({Key? key}) : super(key: key);

  @override
  State<FridgesView> createState() => _FridgesViewState();
}

class _FridgesViewState extends State<FridgesView> {

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
      // body: BlocProvider(
      //   create: (BuildContext context) => FridgesBloc(instance()),
      //   child: const PricesList(),
      // ),
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

  _addAmber(int fridgeId) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _apiService.addAmber(fridgeId).then((value) {
        // _prices = value;
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

      if (_prices.isEmpty) {
        return emptyScreen(context, "لا يوجد ثلاجات");
      } else {
       return ListView.builder(
          itemCount: _prices.length,
          itemBuilder: (context, index) {
            final item = _prices[index];

            return RefreshIndicator(
              onRefresh: () async {
                await _getPrices();
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      ViewFridgeView(fridge: item)
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Card(
                    elevation: AppPadding.p8,
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p4),
                      child: ListTile(
                        title: Text(item.name),
                        subtitle: Text("${item.size} عنابر"),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton(onPressed: () {
                              _addAmber(item.id);
                            }, child: Text("Add Amber")),
                            IconButton(
                              onPressed: () async {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                    EditFridgeView(fridge: item)
                                ));
                              },
                              icon: const Icon(
                                  Icons.edit
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                return AwesomeDialog(
                                    btnCancelText: "الغاء",
                                    btnOkText: "حذف",
                                    context: context,
                                    dialogType: DialogType.noHeader,
                                    title: "حذف ثلاجة",
                                    desc: "هل أنت متأكد من حذف هذه الثلاجة ؟",
                                    btnCancelOnPress: () {},
                                    btnOkOnPress: () async {
                                      await _delFridge(item.id);
                                    }).show();
                              },
                              icon: const Icon(
                                  Icons.delete
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    }
  }
}
