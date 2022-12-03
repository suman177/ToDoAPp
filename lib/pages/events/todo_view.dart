import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/pages/events/add_todo_event.dart';
import 'package:testapp/pages/provider/event_provider.dart';

class ToDoView extends StatefulWidget {
  const ToDoView({Key? key}) : super(key: key);

  @override
  State<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

  final ScrollController _controller = ScrollController();
  List<GlobalKey> _key = [];

  @override
  void initState() {
    _key = List.generate(500, (index) => GlobalKey());
    super.initState();
  }

  Widget _body() {
    final eventProvider = Provider.of<EventProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: ListView.builder(
          itemCount: eventProvider.monthInDays(),
          shrinkWrap: true,
          controller: _controller,
          itemBuilder: (context, index) {
            final model = eventProvider.getToDoModel(
                (index + 1).toString(),
                eventProvider.selectedYear.toString(),
                eventProvider.selectedMonth.toString());
            return Padding(
              padding: const EdgeInsets.all(8.0),
              key: _key[index],
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AddEventsToDo(selectedDate: (index + 1).toString())));
                },
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (index + 1).toString(),
                                key: Key((2000 + index).toString()),
                              ),
                            ),
                            Text(
                              eventProvider.selectedMonth,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 20,
                          width: 1,
                          color: Colors.brown,
                        ),
                        model != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(model.selTime.toString()),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(model.day +
                                            "-" +
                                            model.month +
                                            "-" +
                                            model.year.toString()),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(model.description.toString()),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      color: Colors.redAccent, //color of divider
                      height: 1, //height spacing of divider
                      thickness: 1, //thickness of divier line
                      indent: 10, //spacing at the start of divider
                      endIndent: 10, //spacing at the end of divider
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
