import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/common/commom.dart';
import 'package:testapp/pages/events/month_popup.dart';
import 'package:testapp/pages/events/todo_view.dart';
import 'package:testapp/pages/events/year_popup.dart';
import 'package:testapp/pages/provider/event_provider.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: const Center(
      child: Text("Events",
          style: TextStyle(
            color: Colors.white,
          )),
    ));
  }

  Widget _body() {
    final eventsProvider = Provider.of<EventProvider>(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: commonButton(
                  text: eventsProvider.selectedYear.toString(),
                  onPressed: () async {
                    print("Peressed");
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            children: const [YearPopup()],
                          );
                        });
                  },
                  minWidth: width * 0.3),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: commonButton(
                  text: eventsProvider.selectedMonth.toString(),
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            children: const [MonthPopup()],
                          );
                        });
                  },
                  minWidth: width * 0.3),
            ),
          ],
        ),

        //ToDo View
        const Expanded(child: ToDoView())
      ],
    );
  }
}
