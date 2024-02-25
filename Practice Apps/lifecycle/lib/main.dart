import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

bool mm = true;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Lifecycle(),
    );
  }
}

class Lifecycle extends StatefulWidget {
  const Lifecycle({super.key});

  @override
  State createState() {
    print('Create State');
    return _LifecycleState();
  }
}

class _LifecycleState extends State {
  @override
  void initState() {
    super.initState();
    print("In init State");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("In didChangeDependencies");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print('In setState');
  }

  @override
  Widget build(BuildContext context) {
    print('In build Method');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifecycle'),
      ),
      body: const Scaffold(
        body: Text('Hello'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            mm = false;
          });
        },
        child: const Icon(Icons.forward),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print('In deactivate State');
  }

  @override
  void dispose() {
    super.dispose();
    print('In dispose State');
  }
}
