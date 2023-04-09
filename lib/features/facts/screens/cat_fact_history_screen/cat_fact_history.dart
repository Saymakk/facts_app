import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FactHistoryPage extends StatelessWidget {
  const FactHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('facts');
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: box.isEmpty
              ? const Center(child:  Text('Here is still nothing!'))
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset('assets/cat.png'),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text('${box.get(index)['fact']}'),
                      ),
                      subtitle: Text('${box.get(index)['date']}'),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
