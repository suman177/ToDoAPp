import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/common/text_form_field.dart';
import 'package:testapp/model/todo_model.dart';
import 'package:testapp/pages/provider/event_provider.dart';

class AddEventsToDo extends StatefulWidget {
  const AddEventsToDo({Key? key, required this.selectedDate}) : super(key: key);
  final String selectedDate;
  @override
  State<AddEventsToDo> createState() => _AddEventsToDoState();
}

class _AddEventsToDoState extends State<AddEventsToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomSheet: _bottomSheet(),
    );
  }

  _bottomSheet() {
    final eventProvider = Provider.of<EventProvider>(context);
    return MaterialButton(
      onPressed: () {
        ToDoModel toDoModel = ToDoModel(
            dateTime: DateTime.now(),
            day: widget.selectedDate,
            year: eventProvider.selectedYear.toString(),
            month: eventProvider.selectedMonth.toString(),
            title: titleController.text,
            description: descriptionController.text,
            selTime: selectedTime!.hour.toString() +
                " " +
                selectedTime!.minute.toString());
        eventProvider.addToDo(toDoModel);
        Navigator.of(context).pop();
      },
      padding: EdgeInsets.zero,
      height: 50,
      minWidth: MediaQuery.of(context).size.width,
      color: Colors.blue[900],
      child: const Text(
        "Save",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            )),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: Text("Events",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
        ));
  }

  Widget _body() {
    final eventsProvider = Provider.of<EventProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          dateTime(),
          const SizedBox(height: 25),
          title(),
          const SizedBox(height: 25),
          description()
        ],
      ),
    );
  }

  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedS != null && pickedS != selectedTime) {
      setState(() {
        selectedTime = pickedS;
      });
    }
  }

  Widget dateTime() {
    final eventProvider = Provider.of<EventProvider>(context);
    return Row(
      children: [
        const Flexible(flex: 1, child: Text("Date & Time")),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  _selectTime(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown),
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(selectedTime == null
                      ? "HH::MM"
                      : selectedTime!.hour.toString() +
                          " " +
                          selectedTime!.minute.toString()),
                ),
              ),
              Text(widget.selectedDate +
                  "-" +
                  eventProvider.selectedMonth +
                  "-" +
                  eventProvider.selectedYear.toString())
            ],
          ),
        ),
      ],
    );
  }

  final titleController = TextEditingController();
  final tiKey = GlobalKey<FormState>();
  final desKey = GlobalKey<FormState>();
  final descriptionController = TextEditingController();

  Widget title() {
    final eventProvider = Provider.of<EventProvider>(context);
    return Row(
      children: [
        const Flexible(flex: 1, child: Text("Title")),
        const SizedBox(
          width: 100,
        ),
        Flexible(
          flex: 2,
          child: TextFormFieldWidget(
              textEditingController: titleController,
              formKey: tiKey,
              hintText: "Title"),
        ),
      ],
    );
  }

  Widget description() {
    final eventProvider = Provider.of<EventProvider>(context);
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Description"),
        SizedBox(
          height: 40,
          width: width * 0.9,
          child: LongTextFormFieldWidget(
              textEditingController: descriptionController,
              formKey: desKey,
              hintText: "Description"),
        ),
      ],
    );
  }
}
