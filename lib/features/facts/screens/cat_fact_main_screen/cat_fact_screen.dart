import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cat_fact_history_screen/cat_fact_history.dart';
import 'cubit/cat_fact_cubit.dart';
import 'cubit/cat_image_cubit.dart';

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
    context.read<CatFactCubit>().fetchFact();
    context.read<CatImageCubit>().fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    final emptyBox = const SnackBar(content: Text('History is empty yet!'));
    final clearedBox = const SnackBar(content: Text('History is cleared!'));
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              if (_box.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(emptyBox);
              } else {
                await _box.clear();
                ScaffoldMessenger.of(context).showSnackBar(clearedBox);
              }
            },
            child: const Text(
              'Clear history!',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          TextButton(
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
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            blocImage(),
            const SizedBox(
              height: 50,
            ),
            blocFact(),
            const Expanded(
                child: SizedBox(
              height: 10,
            )),
            changeFactButton(),
          ],
        ),
      ),
    );
  }

  Widget blocImage() {
    return BlocBuilder<CatImageCubit, CatImageState>(
      builder: (context, state) {
        if (state is CatImageLoading) {
          return DefaultTextStyle(
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Loading image...'),
              ],
              isRepeatingAnimation: true,
            ),
          );
        } else if (state is CatImageLoaded) {
          return Center(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    fit: BoxFit.fill,
                    image: state.image,
                    width: MediaQuery.of(context).size.width * .8,
                    // height: MediaQuery.of(context).size.height * .5,
                  ),
                ),
              ],
            ),
          );
        } else if (state is CatImageError) {
          return Text(
            state.message,
            style: const TextStyle(fontSize: 18),
          );
        } else {
          return const Text('');
        }
      },
    );
  }

  Widget blocFact() {
    return BlocBuilder<CatFactCubit, CatFactState>(
      builder: (context, state) {
        if (state is CatFactLoading) {
          return DefaultTextStyle(
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText('Loading fact...'),
              ],
              isRepeatingAnimation: true,
            ),
          );
        } else if (state is CatFactLoaded) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    state.fact,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
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
    );
  }

  Widget changeFactButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
        onPressed: () async {
          context.read<CatFactCubit>().fetchFact();
          // CatImageProvider().loadImage();
          context.read<CatImageCubit>().fetchImage();
          // setState(() {});
        },
        child: const Text(
          'Another fact!',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
