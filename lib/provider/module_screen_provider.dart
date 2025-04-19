import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trogon_test/models/module_model.dart';

class ModuleProvider extends ChangeNotifier {
  bool isDataLoading = false;
  List<ModuleModel> moduleList = [];

  Future<void> fetchModulesBySubjectId(String subjectId) async {
    moduleList.clear();
    setDataLoading(true);

    final String apiUrl = 'https://trogon.info/interview/php/api/modules.php?subject_id=$subjectId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        moduleList = data.map((module) => ModuleModel.fromJson(module)).toList();
      } else {
        debugPrint('Failed to load modules. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }

    setDataLoading(false);
    notifyListeners();
  }

  void setDataLoading(bool loading) {
    isDataLoading = loading;
    notifyListeners();
  }
}
