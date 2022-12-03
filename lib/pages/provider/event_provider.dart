import 'package:flutter/material.dart';
import 'package:testapp/model/todo_model.dart';

class EventProvider with ChangeNotifier {
  int _selectedYear = 2022;
  String _selectedMonth = "Jan";

  final List<ToDoModel> _list = [];

  addToDo(ToDoModel toDoModel) {
    _list.add(toDoModel);
    notifyListeners();
  }

  ToDoModel? getToDoModel(String day, String year, String month) {
    final list = _list.where((element) {
      return element.day == day.toString() &&
          element.year == year.toString() &&
          element.month == month.toString();
    });
    if (list.isEmpty) {
      return null;
    }
    return list.first;
  }

  List<String> _months = [];

  List<String> getAllMonths() {
    _months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];
    return _months;
  }

  set selectMonth(String month) {
    _selectedMonth = month;
    notifyListeners();
  }

  String get selectedMonth => _selectedMonth;

  int get selectedYear => _selectedYear;

  set selectYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  getAllDays() {
    final items = List<DateTime>.generate(
        60,
        (i) => DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).add(Duration(days: i)));
  }

  int monthInDays() {
    int selectedMonth = getAllMonths().indexOf(_selectedMonth) + 1;
    return DateTimeRange(
            start: DateTime(_selectedYear, selectedMonth, 1),
            end: DateTime(_selectedYear, selectedMonth + 1))
        .duration
        .inDays;
  }
}
