import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String translated = 'Translation';
  String originalText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFececec),
      appBar: AppBar(
        leading: const Icon(Icons.translate),
        title: const Text('Google Translate 2.0'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const DropdownButtonExample(),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.autorenew),
                  onPressed: () {
                    setState(() {
                      // her må funksjonaliteten for å bytte språk
                    });
                  },
                ),
                const Spacer(),
                const DropdownButtonExample(),
              ],
            ),
            SizedBox(
              height: 150.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(8),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    hintText: 'Enter text',
                  ),
                  onChanged: (text) async {
                    // final translator = GoogleTranslator();
                    // final input = text;

                    final translation = await text.translate(
                      from: 'en',
                      to: 'ru',
                    );
                    // translator.translate(input, to: 'en').then((result) => translated = result as String);

                    // kan ikke bruke setState, så får ikke kjørt appen
                    setState(() {
                    translated = translation.text;
                    originalText = text;
                    });
                  },
                ),
              ),
            ),
            const Divider(
              height: 24,
              color: Colors.black87,
            ),
            SizedBox(
              height: 200.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.blue,
                margin: const EdgeInsets.all(8),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(12),
                  children: [
                    Row(
                      children: const [
                        Text(
                          'RUSSIAN',
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        Icon(
                          Icons.star_border,
                          color: Colors.white,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      translated,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                     Text(
                      originalText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 24,
              color: Colors.black87,
            ),
            SizedBox(
              height: 200.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Colors.white,
                margin: const EdgeInsets.all(8),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(12),
                  children: [
                    Text(
                      translated,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

const List<String> list = <String>[
  'Velg språk',
  'Norsk',
  'Engelsk',
  'Russisk',
  'Polsk',
  'Spansk'
];

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
