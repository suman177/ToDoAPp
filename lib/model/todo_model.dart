class ToDoModel {
  final DateTime dateTime;
  final String title;
  final String description;
  final String selTime;
  final String day;
  final String year;
  final String month;

  ToDoModel(
      {required this.dateTime,
      required this.title,
      required this.description,
      required this.selTime,
      required this.day,
      required this.year,
      required this.month});
}
