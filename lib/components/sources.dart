import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart'; // Correct import
import 'package:get/get.dart';
import 'package:newsapp/controllers/news_controller.dart';
import 'package:newsapp/widgets/source_card.dart';

class Sources extends StatelessWidget {
  final NewsController _newsController = Get.find();

  void _launchURL(BuildContext context, String url) async {
    final theme = Theme.of(context); // Fetch the current theme
    try {
      await launchUrl(
        Uri.parse(url),
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: theme.colorScheme.surface,
            navigationBarColor: theme.colorScheme.surface,
          ),
          urlBarHidingEnabled: true,
          showTitle: true,
          browser: const CustomTabsBrowserConfiguration(
            prefersDefaultBrowser: true,
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error launching custom tab: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      child: Obx(() {
        if (_newsController.isSourcesLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: _newsController.sourceList.length,
          itemBuilder: (context, index) {
            var sources = _newsController.sourceList;
            return InkWell(
              onTap: () => _launchURL(context, sources[index].url),
              child: SourceCard(
                sourceName: sources[index].name,
                country: sources[index].country,
              ),
            );
          },
        );
      }),
    );
  }
}
