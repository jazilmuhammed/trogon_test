import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/subject_model.dart';

class SubjectProvider extends ChangeNotifier {
  List<SubjectModel> _subjects = [];
  bool _isLoading = false;

  List<SubjectModel> get subjects => _subjects;
  bool get isLoading => _isLoading;

  Future<void> fetchSubjects() async {
    _setLoading(true);

    try {
      final response = await http.get(Uri.parse('https://trogon.info/interview/php/api/subjects.php'));

      if (response.statusCode == 200) {
        final List<SubjectModel> fetchedSubjects = subjectModelFromJson(response.body);
        _subjects = fetchedSubjects;
      } else {
        debugPrint('Failed to load subjects. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint("Error fetching subjects: $e");
    }

    _setLoading(false);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearSubjects() {
    _subjects.clear();
    notifyListeners();
  }
}
