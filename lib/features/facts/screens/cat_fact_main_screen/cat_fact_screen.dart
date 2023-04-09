import 'package:dio/dio.dart';
import 'package:facts_app/features/facts/cubit/cat_fact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cat_fact_history_screen/cat_fact_history.dart';

class FactScreen extends StatefulWidget {
  const FactScreen({Key? key}) : super(key: key);

  @override
  State<FactScreen> createState() => _FactScreenState();
}

class _FactScreenState extends State<FactScreen> {
  dynamic imageProvider;

  final _box = Hive.box('facts');

  @override
  void initState() {
    super.initState();
    _loadImage();
    context.read<CatFactCubit>().fetchFact();
  }

  String? fact;
  dynamic image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              _box.clear();
            },
            child: Text(
              'Clear history!',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FactHistoryPage(),
                    ),
                  );
                },
                child: const Text(
                  'Facts history',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
            BlocBuilder<CatFactCubit, CatFactState>(
              builder: (context, state) {
                if (state is CatFactLoading) {
                  return const CircularProgressIndicator();
                } else if (state is CatFactLoaded) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        imageProvider != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image(
                                  image: imageProvider,
                                  width: MediaQuery.of(context).size.width * .8,
                                ),
                              )
                            : const CircularProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          state.fact,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else if (state is CatFactError) {
                  return Text(
                    state.message,
                    style: const TextStyle(fontSize: 18),
                  );
                } else {
                  return const Text('Press the button to fetch a cat fact!');
                }
              },
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
                onPressed: () async {

                  context.read<CatFactCubit>().fetchFact();
                  _loadImage();
                  // setState(() {});
                },
                child: Text(
                  'Another fact!',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadImage() async {
    try {
      final response = await Dio().get(
        'https://cataas.com/cat',
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      final bytes = response.data;
      final image = await decodeImageFromList(bytes);
      setState(() {
        imageProvider = MemoryImage(bytes);
      });

    } catch (e) {
      print('Error loading image: $e');
    }
  }
}
