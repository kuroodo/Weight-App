import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        color: Theme.of(context).textTheme.titleLarge!.color!.withOpacity(.75));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Weight App",
          style: style,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Linkify(
            text: "https://github.com/kuroodo/Weight-App",
            style: style,
            textAlign: TextAlign.center,
            onOpen: (link) async {
              if (await canLaunchUrl(Uri.parse(link.url))) {
                await launchUrl(
                  Uri.parse(link.url),
                  mode: LaunchMode.externalApplication,
                );
              } else {
                throw 'Could not launch $link';
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            "MIT License",
            style: style,
          ),
        ),
      ],
    );
  }
}
