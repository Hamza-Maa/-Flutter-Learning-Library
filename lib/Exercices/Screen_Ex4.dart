import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterExScreen extends ConsumerWidget {
  const CounterExScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod First'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWidget(),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Divider(
                  height: 2,
                  thickness: 2,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(counterProvider.notifier)
                          .update((state) => state - 1);
                    },
                    child: const Text(
                      '- 1',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(counterProvider.notifier)
                          .update((state) => state + 1);
                    },
                    child: const Text(
                      '+ 1',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final counterProvider = StateProvider<int>((ref) {
  return 0;
});

class TextWidget extends ConsumerWidget {
  const TextWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int valueCounter = ref.watch(counterProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Counter',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          valueCounter.toString(),
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
