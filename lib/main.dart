import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

const List<String> list = <String>['Velg språk', 'Norsk', 'Engelsk', 'Russisk', 'Polsk', 'Spansk'];

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
      home: MyHomePage(
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String translated = 'Translation';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.translate),
        title: const Text('Google Translate 2.0'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body:
      Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                const DropdownButtonExample(),
                const Spacer(),
                IconButton(icon: const Icon(Icons.swap_horiz),
                  onPressed: () {
                    setState(() {
                      // her må funksjonaliteten for å bytte språk
                    });
                  },),
                const Spacer(),
                const DropdownButtonExample(),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(12),
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                children: [
                  const Text('man må trykke på bytte knappen øverst for å oversette :///'),
                  const SizedBox(height: 8),
                  TextField(
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter Text',
                    ),
                    onChanged: (text) async {
                      // final translator = GoogleTranslator();
                      // final input = text;

                      final translation = await text.translate(from: 'en', to: 'es',);
                      // translator.translate(input, to: 'en').then((result) => translated = result as String);

                      // kan ikke bruke setState, så får ikke kjørt appen
                      //setState(() {
                      translated = translation.text;
                      //});
                    },
                  ),
                  const Divider(height: 32),
                  Text(
                    translated,
                    style: const TextStyle(
                      fontSize: 36,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValueLeft = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValueLeft,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.blue,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValueLeft = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}



