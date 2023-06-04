import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Accordion Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AccordionHomePage(),
    );
  }
}

class AccordionHomePage extends StatefulWidget {
  const AccordionHomePage({super.key});

  @override
  _AccordionHomePageState createState() => _AccordionHomePageState();
}

class _AccordionHomePageState extends State<AccordionHomePage> {
  final List<Item> _data = generateItems(5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Accordion Demo'),
      ),
      body: ListView(
        children: _data.map<Widget>((Item item) {
          return ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                item.isExpanded = !isExpanded;
              });
            },
            animationDuration: const Duration(
                milliseconds: 500), // adjust duration of the animation here
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.headerValue),
                  );
                },
                body: ListTile(
                  title: Text(item.expandedValue),
                ),
                isExpanded: item.isExpanded,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}
