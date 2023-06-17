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
      home: const DemoPopupPage(),
    );
  }
}

// Show Update Popup
class DemoPopupPage extends StatefulWidget {
  const DemoPopupPage({
    super.key,
  });

  @override
  State<DemoPopupPage> createState() => _DemoPopupPageState();
}

class _DemoPopupPageState extends State<DemoPopupPage> {
  @override
  void initState() {
    super.initState();
    PlaystoreUpdate(
      // Enter your application's package name. Example:- com.malay.youtuber.wallpaper.
      packageName: 'com.malay.youtuber.wallpaper',
    ).showPlaystoreUpdateDialog(
        // Stateful context to show popup
        context: context,
        // Allow users to dismiss the popup and allow them to use the app.
        allowDismissal: true,

        // Do you want to show the app description(What's new).
        showDescription: true,
        // Do you want users to see from from which version are they upgrading to which one/
        showVersions: true,
        // Primary color of the popup.
        primaryColor: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playstore update test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Demo Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const DemoUpdateDataCustomPage()));
              },
              child: Text(
                'Go to Playstore update data. Custom Popup Screen',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DemoUpdateDataCustomPage extends StatefulWidget {
  const DemoUpdateDataCustomPage({
    super.key,
  });

  @override
  State<DemoUpdateDataCustomPage> createState() =>
      _DemoUpdateDataCustomPageState();
}

class _DemoUpdateDataCustomPageState extends State<DemoUpdateDataCustomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playstore update test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Demo Update Data Custom Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            GestureDetector(
              onTap: () async {
                // Get all the details about your app from playstore and the current version of the users.
                PlaystoreUpdateData playstoreUpdateData = await PlaystoreUpdate(
                  // Enter your application's package name. Example:- com.malay.youtuber.wallpaper.
                  packageName: 'com.malay.youtuber.wallpaper',
                ).getPlaystoreUpdateDetails();
                playstoreUpdateData.version;
              },
              child: Text(
                'Get App Update Information',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
