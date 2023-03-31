import 'package:flutter/material.dart';

import '../screens/payments_list/payments_list.dart';

class SelectedRows extends ChangeNotifier {
  final List<Transaction> _selectedRows = [];

  List<Transaction> get selectedRows => _selectedRows;

  void add(Transaction txn) {
    _selectedRows.add(txn);
    notifyListeners();
  }

  void remove(Transaction txn) {
    _selectedRows.remove(txn);
    notifyListeners();
  }

  void clear() {
    _selectedRows.clear();
    notifyListeners();
  }
}
