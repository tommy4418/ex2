import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final exit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want to exit an app?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        );
        return exit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('First Screen'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Go next'),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondScreen()),
              );
              if (result != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('Returned: $result'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Return 42'),
              onPressed: () => Navigator.of(context).pop(42),
            ),
            ElevatedButton(
              child: Text('Return AbErVaLlG'),
              onPressed: () => Navigator.of(context).pop('AbErVaLlG'),
            ),
          ],
        ),
      ),
    );
  }
}