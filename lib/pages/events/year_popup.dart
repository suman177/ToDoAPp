import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/pages/provider/event_provider.dart';

class YearPopup extends StatefulWidget {
  const YearPopup({Key? key}) : super(key: key);

  @override
  State<YearPopup> createState() => _YearPopupState();
}

class _YearPopupState extends State<YearPopup> {
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

  void scroll(double position) {
    _controller.jumpTo(position);
  }

  Widget _body() {
    final eventProvider = Provider.of<EventProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      height: height * 0.8,
      width: width * 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text("Year")],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: 500,
                  shrinkWrap: true,
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      key: _key[index],
                      child: GestureDetector(
                        onTap: () {
                          eventProvider.selectYear = (2000 + index);
                          print(eventProvider.selectedYear);
                          Navigator.of(context).pop();
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (2000 + index).toString(),
                                key: Key((2000 + index).toString()),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              color: Colors.redAccent, //color of divider
                              height: 1, //height spacing of divider
                              thickness: 1, //thickness of divier line
                              indent: 20, //spacing at the start of divider
                              endIndent: 20, //spacing at the end of divider
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
