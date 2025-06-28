import 'package:flutter/material.dart';
import 'package:simple_calc/repository/repository_operations.dart';

class HistoricController extends ChangeNotifier {
  List<List<dynamic>> get data => RepositoryOperations.getOnBox();

  clear(){
    RepositoryOperations.clearBox();
    notifyListeners();
  }
}