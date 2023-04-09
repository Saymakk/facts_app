import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FactHistoryPage extends StatelessWidget {
  const FactHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _box = Hive.box('facts');
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemCount: _box.length,
            itemBuilder: (context, index) {
              return Text('${_box.get(index)}');
            },
          ),
        ),
      ),
    );
  }
}
