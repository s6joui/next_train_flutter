import 'package:flutter/material.dart';
import 'package:next_train_flutter/presentation/arrival_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar.large(
          title: const Text('Next train',
              style: TextStyle(fontWeight: FontWeight.w800)),
          actions: const [
            IconButton(onPressed: null, icon: Icon(Icons.search))
          ],
        ),
        const ArrivalListWidget()
      ]),
    );
  }
}
