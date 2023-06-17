<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# playstore_update

A Flutter package that helps you show a popup to your users whenever you publish a new update on Google Play Store.

## Example

<img src="https://user-images.githubusercontent.com/56907997/229843728-cc0ec8bc-1f4a-418f-a58f-05027563fef8.png" width="45%"></img> <img src="https://user-images.githubusercontent.com/56907997/229843743-94dfb850-2189-4686-8f9c-1dd5e5069a2d.png" width="45%"></img> 

## Description

In this package, you can show a popup to users whenever you publish a new update on Google Play Store. You can customize the popup according to your needs and this packages is still in development. This package is really very easy to use and beginner friendly. More features will be coming soon, and they will make the package better and more customizable!

## Ekxample

#### Showing Popup in the init state

```
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
```



#### Getting Play store and local app update details
##### Can be used to make a custom notifier for an update or show details about your app from Play Store or local app

```
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
```



## Author

<a href="https://github.com/Malay1121"><img src="https://avatars.githubusercontent.com/u/56907997?v=3" title="Malay1121" width="80" height="80"></a>

<a class="github-button" href="https://github.com/Malay1121" aria-label="Follow @Malay1121 on GitHub">Follow @Malay1121</a>

<a class="github-button" href="https://www.linkedin.com/malay-patel-dev/" aria-label="LinkedIn: malay-patel-dev">LinkedIn: @Malay Patel</a>
