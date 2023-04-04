library playstore_update;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:peekanapp/peekanapp.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaystoreUpdate {
  PlaystoreUpdate({
    required this.context,
    required this.allowDismissal,
    required this.packageName,
    required this.showDescription,
    required this.showVersions,
    required this.primaryColor,
  });
  final BuildContext context;
  // Enter your application's package name. Example:- com.malay.youtuber.wallpaper.
  final String packageName;
  // Allow users to dismiss the popup and allow them to use the app.
  final bool allowDismissal;
  // Do you want to show the app description(What's new).
  final bool showDescription;
  // Do you want users to see from from which version are they upgrading to which one/
  final bool showVersions;
  // Primary color of the popup.
  Color primaryColor;
  void checkForUpdate() async {
    PeekanappClient peekanapp = PeekanappClient();

    peekanapp
        .getPlayStoreAppDetails(appId: packageName.toString())
        .then((value) {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        if (value.version != packageInfo.version) {
          showDialog(
            context: context,
            builder: (context) {
              return UpdateDialog(
                allowDismissal: allowDismissal,
                description: value.recentChanges!,
                appLink: value.url,
                version: packageInfo.version + ' ➜ ' + value.version,
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
}

class UpdateDialog extends StatefulWidget {
  final String version;
  final String description;
  final String appLink;
  final bool allowDismissal;
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
            borderRadius: BorderRadius.only(
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
                                child: Text(
                                  "ABOUT UPDATE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: Center(
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
