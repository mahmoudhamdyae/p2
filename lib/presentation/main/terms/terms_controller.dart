import 'package:get/get.dart';
import 'package:testt/model/term.dart';

import '../../../data/services/api_service.dart';

class TermsController extends GetxController {

  final ApiService _apiService;
  RxList<Term> terms = List<Term>.empty().obs;
  Rx<Term> term = Term(-1, "", "", "", -1).obs;
  Rx<bool> isLoading = true.obs;
  Rx<String> error = ''.obs;

  TermsController(this._apiService);

  Future<void> getTerms() async {
    try {
      isLoading.value = true;
      terms.value = List<Term>.empty();
      error.value = '';
      await _apiService.getTerms().then((value) {
        terms.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      terms.value = List<Term>.empty();
      isLoading.value = false;
    }
  }

  Future<void> delTerm(Term term) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.delTerm(term.id.toString()).then((value) {
        terms.value.remove(term);
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      terms.value = List<Term>.empty();
      isLoading.value = false;
    }
  }

  Future<void> addTerm(String name, String start, String end) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.addTerm(name, start, end).then((value) {
        terms.value.add(Term(-1, name, start, end, -1));
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      terms.value = List<Term>.empty();
      isLoading.value = false;
    }
  }

  Future<void> updateTerm(String termId, String name, String start, String end) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.updateTerm(termId, name, start, end).then((value) {
        terms.value = terms.value.map((term2) {
          if (term2.id.toString() == termId) {
            return Term(term2.id, term2.name, term2.start, term2.end, term2.user_id);
          } else {
            return term2;
          }
        }).toList();
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      terms.value = List<Term>.empty();
      isLoading.value = false;
    }
  }

  Future showTerm(String termId) async {
    try {
      isLoading.value = true;
      error.value = '';
      await _apiService.showTerm(termId).then((term2) {
        term.value = term2;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }

  void search(String query) async {
    try {
      // isLoading.value = true;
      error.value = '';
      await _apiService.searchTerm(query).then((value) {
        terms.value = value;
        error.value = '';
        isLoading.value = false;
      });
    } on Exception catch (e) {
      error.value = e.toString();
      isLoading.value = false;
    }
  }
}