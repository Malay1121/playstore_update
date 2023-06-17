library playstore_update;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:peekanapp/peekanapp.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaystoreUpdate {
  PlaystoreUpdate({
    required this.packageName,
  });
  // Enter your application's package name. Example:- com.malay.youtuber.wallpaper.
  String packageName;

  // Checks for any updates from the playstore server and shows an update popup.
  void showPlaystoreUpdateDialog({
    // Do you want to show the app description(What's new).

    required bool showDescription,
    // Do you want users to see from from which version are they upgrading to which one?

    required bool showVersions,
    // Primary color of the popup.

    required Color primaryColor,
    // Stateful context to show popup
    required BuildContext context,
    // Allow users to dismiss the popup and allow them to use the app.

    required bool allowDismissal,
  }) async {
    PeekanappClient peekanapp = PeekanappClient();

    peekanapp
        .getPlayStoreAppDetails(appId: packageName.toString())
        .then((value) {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        if (value.version != packageInfo.version) {
          showDialog(
            context: context,
            builder: (context) {
              // Pop up update dialog class
              return UpdateDialog(
                allowDismissal: allowDismissal,
                description: value.recentChanges!,
                appLink: value.url,
                version: '${packageInfo.version} ➜ ${value.version}',
                showDescription: showDescription,
                showVersions: showVersions,
                primary: primaryColor,
              );
            },
          );
        }
      });
    });
  }

  // Checks for any updates from the playstore server and gives you all the details. You can use these details to make your own popup or notifier.
  Future<PlaystoreUpdateData> getPlaystoreUpdateDetails() async {
    try {
      PeekanappClient peekanapp = PeekanappClient();

      peekanapp
          .getPlayStoreAppDetails(appId: packageName.toString())
          .then((value) {
        PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
          Map<String, dynamic> data = value.toJSON();
          data.addEntries({
            'currentAppName': packageInfo.appName,
            'currentBuildNumber': packageInfo.buildNumber,
            'currentBuildSignature': packageInfo.buildSignature,
            'currentInstallerStore': packageInfo.installerStore,
            'currentPackageName': packageInfo.packageName,
            'currentVersion': packageInfo.version
          }.entries);
          // returns all the details about your app's current version and new version
          return PlaystoreUpdateData.fromJSON(data);
        });
      });
      return PlaystoreUpdateData();
    } on Exception {
      return PlaystoreUpdateData();
    }
  }
}

// Update details data model
class PlaystoreUpdateData {
  String? currentAppName;
  String? currentBuildNumber;
  String? currentBuildSignature;
  String? currentInstallerStore;
  String? currentPackageName;
  String? currentVersion;

  /// The URL of the app's page on the Google Play Store.
  String? url;

  /// The string identifier of the app.
  String? appId;

  /// The name of the app.
  String? title;

  /// The short description/summary of the app.
  String? summary;

  /// The description of the app.
  String? description;

  /// The description of the app in HTML format.
  String? descriptionHTML;

  /// The name of the app's developer.
  String? developer;

  /// The ID of the app's developer.
  String? developerId;

  /// The internal ID of the app's developer.
  String? developerInternalId;

  /// The email address of the app's developer.
  String? developerEmail;

  /// The website of the app's developer.
  String? developerWebsite;

  /// The physical address of the app's developer.
  String? developerAddress;

  /// The icon of the app.
  String? icon;

  /// The score of the app.
  num? score;

  /// The score of the app in string format.
  String? scoreText;

  /// The price of the app. 0 if free.
  num? price;

  /// The price of the app in string format.
  String? priceText;

  /// The currency of the app's price.
  String? currency;

  /// Whether the app is free to download.
  bool? free;

  /// The number of installs the app has received (approximation).
  String? installs;

  /// The minimum number of installs from the [installs] approximation.
  num? minInstalls;

  /// The maximum number of installs from the [installs] approximation.
  num? maxInstalls;

  /// The number of ratings the app has received.
  num? ratings;

  /// The number of reviews the app has received.
  num? reviews;

  /// A historgram containing the number of 1-5 star ratings of the app.
  Map<String, num>? histogram;

  /// Whether the app is available to download.
  bool? available;

  /// Whether the app offers in-app purchases.
  bool? offersIAP;

  /// The range of the in-app purchases contained within the app.
  String? iAPRange;

  /// The size of the app.
  String? size;

  /// The minimum version of Android that is required to install the app.
  String? androidVersion;

  /// The minimum version of Android that is required to install the app in
  /// string format.
  String? androidVersionText;

  /// The genre of the app.
  String? genre;

  /// The genre ID of the app.
  String? genreId;

  /// The family genre of the app.
  String? familyGenre;

  /// The family genre ID of the app.
  String? familyGenreId;

  /// The header image of the app.
  String? headerImage;

  /// A list of screenshots of the app.
  List<String>? screenshots;

  /// A video URL, if the app's page contains a video.
  String? video;

  /// A URL to the video's thumbnail, if any.
  String? videoImage;

  /// The app's content rating.
  String? contentRating;

  /// The description of the app's content rating.
  String? contentRatingDescription;

  /// Whether the app contains ads.
  bool? adSupported;

  /// The app's release date in string format (e.g. Mar 14, 2022).
  String? released;

  /// A UNIX timestamp of the app's last update date.
  num? updated;

  /// The last version of the app.
  String? version;

  /// The recent changes that have been made to the app.
  String? recentChanges;

  /// A list of comments that have been left on the app.
  List<String>? comments;

  /// The privacy policy URL of the app.
  String? privacyPolicy;

  PlaystoreUpdateData({
    this.currentAppName,
    this.currentBuildNumber,
    this.currentBuildSignature,
    this.currentInstallerStore,
    this.currentPackageName,
    this.currentVersion,
    this.url,
    this.appId,
    this.title,
    this.summary,
    this.description,
    this.descriptionHTML,
    this.developer,
    this.developerId,
    this.developerInternalId,
    this.developerEmail,
    this.developerWebsite,
    this.developerAddress,
    this.icon,
    this.score,
    this.scoreText,
    this.price,
    this.priceText,
    this.currency,
    this.free,
    this.installs,
    this.minInstalls,
    this.maxInstalls,
    this.ratings,
    this.reviews,
    this.histogram,
    this.available,
    this.offersIAP,
    this.iAPRange,
    this.size,
    this.androidVersion,
    this.androidVersionText,
    this.genre,
    this.genreId,
    this.familyGenre,
    this.familyGenreId,
    this.headerImage,
    this.screenshots,
    this.video,
    this.videoImage,
    this.contentRating,
    this.contentRatingDescription,
    this.adSupported,
    this.released,
    this.updated,
    this.version,
    this.recentChanges,
    this.comments,
    this.privacyPolicy,
  });
  factory PlaystoreUpdateData.fromJSON(Map<String, dynamic> json) {
    return PlaystoreUpdateData(
      url: json['url'] as String,
      currentAppName: json['currentAppName'] as String,
      currentBuildNumber: json['currentBuildNumber'] as String,
      currentBuildSignature: json['currentBuildSignature'] as String,
      currentInstallerStore: json['currentInstallerStore'] as String,
      currentPackageName: json['currentPackageName'] as String,
      currentVersion: json['currentVersion'] as String,
      appId: json['appId'] as String,
      title: json['title'] as String?,
      summary: json['summary'] as String?,
      description: json['description'] as String?,
      descriptionHTML: json['descriptionHTML'] as String?,
      developer: json['developer'] as String?,
      developerId: json['developerId'] as String?,
      developerInternalId: json['developerInternalId'] as String?,
      developerEmail: json['developerEmail'] as String?,
      developerWebsite: json['developerWebsite'] as String?,
      developerAddress: json['developerAddress'] as String?,
      icon: json['icon'] as String?,
      score: json['score'] as num?,
      scoreText: json['scoreText'] as String?,
      price: json['price'] as num?,
      priceText: json['priceText'] as String?,
      currency: json['currency'] as String?,
      free: json['free'] as bool?,
      installs: json['installs'] as String?,
      minInstalls: json['minInstalls'] as num?,
      maxInstalls: json['maxInstalls'] as num?,
      ratings: json['ratings'] as num?,
      reviews: json['reviews'] as num?,
      histogram: json['histogram'],
      available: json['available'] as bool?,
      offersIAP: json['offersIAP'] as bool?,
      iAPRange: json['IAPRange'] as String?,
      size: json['size'] as String?,
      androidVersion: json['androidVersion'] as String?,
      androidVersionText: json['androidVersionText'] as String?,
      genre: json['genre'] as String?,
      genreId: json['genreId'] as String?,
      familyGenre: json['familyGenre'] as String?,
      familyGenreId: json['familyGenreId'] as String?,
      headerImage: json['headerImage'] as String?,
      screenshots: (json['screenshots'] as List<dynamic>?)?.cast<String>(),
      video: json['video'] as String?,
      videoImage: json['videoImage'] as String?,
      contentRating: json['contentRating'] as String?,
      contentRatingDescription: json['contentRatingDescription'] as String?,
      adSupported: json['adSupported'] as bool?,
      released: json['released'] as String?,
      updated: json['updated'] as num?,
      version: json['version'] as String,
      recentChanges: json['recentChanges'] as String?,
      comments: (json['comments'] as List<dynamic>?)?.cast<String>(),
      privacyPolicy: json['privacyPolicy'] as String?,
    );
  }
}

// User interface of the popup
// ignore: must_be_immutable
class UpdateDialog extends StatefulWidget {
  String version;
  String description;
  String appLink;
  bool allowDismissal;
  bool showDescription;
  bool showVersions;
  Color primary;

  UpdateDialog({
    Key? key,
    required this.showDescription,
    required this.showVersions,
    this.version = " ",
    required this.description,
    required this.appLink,
    required this.allowDismissal,
    required this.primary,
  }) : super(key: key);

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  double screenHeight = 0;
  double screenWidth = 0;

  @override
  void dispose() {
    if (!widget.allowDismissal) {
      // SystemNavigator.pop(); this will close the app
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: screenHeight / 8,
          width: screenWidth / 1.5,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            color: widget.primary,
          ),
          child: const Center(
            child: Icon(
              Icons.error_outline_outlined,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        Container(
          height: screenHeight / 3,
          width: screenWidth / 1.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Stack(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                // About the update
                                child: Text(
                                  "ABOUT UPDATE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // App version
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  widget.version,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        // Update's description
                        Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                            child: Html(
                              data: widget.description,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // Check if dismissal is allowed
                        widget.allowDismissal
                            ? Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: widget.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "LATER",
                                        style: TextStyle(
                                          color: widget.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                        SizedBox(
                          width: widget.allowDismissal ? 16 : 0,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              await launchUrl(Uri.parse(widget.appLink));
                            },
                            child: Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: widget.primary,
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.primary,
                                    blurRadius: 10,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              // Update button
                              child: const Center(
                                child: Text(
                                  "UPDATE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
