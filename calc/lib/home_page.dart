import 'package:calc/setState/imc_setstate.dart';
import 'package:calc/value_notifier/imc_value-notifier.dart';
import 'package:flutter/material.dart';

import 'change-notifier/imc_change-notifier.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  void _goToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _goToPage(context, ImcSetstatePage()),
              child: Text('SetState'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, ValueNotifierPage()),
              child: Text('ValueNotifier'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => _goToPage(context, ChangeNotifierPage()),
              child: Text('ChangeNotifier'),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Bloc Pattern (Streams)'),
            )
          ],
        ),
      ),
    );
  }
}
