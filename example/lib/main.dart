import 'package:flutter/material.dart';
import 'package:playstore_update/playstore_update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({
    super.key,
  });

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  void initState() {
    // TODO: implement initState
    PlaystoreUpdate(
            context: context,
            // Allow users to dismiss the popup and allow them to use the app.
            allowDismissal: true,
            // Enter your application's package name. Example:- com.malay.youtuber.wallpaper.
            packageName: 'com.malay.youtuber.wallpaper',
            // Do you want to show the app description(What's new).
            showDescription: true,
            // Do you want users to see from from which version are they upgrading to which one/
            showVersions: true,
            // Primary color of the popup.
            primaryColor: Colors.blue)
        .checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playstore update test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Demo Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
