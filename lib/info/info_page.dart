import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:humble_counter/configs.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: AppInsets.standard,
        child: Column(
          children: [
            const Text(Constants.appInfo),
            _buildLink('Point Free', Constants.pointFreeUrl),
            _buildLink('WolframAlpha', Constants.wolframAlphaUrl),
            _buildLink('Numbers API', Constants.numbersApiUrl),
            _buildLink('Flutter', Constants.flutterUrl),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: const Text('Info'),
    );
  }

  Widget _buildLink(String title, String url) {
    return InkWell(
      onTap: () => onLinkTap(url),
      child: Text(
        title,
        style: Styles.linkTextStyle,
      ),
    );
  }

  void onLinkTap(String url) async {
    try {
      final res = await launchUrl(Uri.parse(url));
      if (!res) {
        if (kDebugMode) {
          print('Failed to open url $url');
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}