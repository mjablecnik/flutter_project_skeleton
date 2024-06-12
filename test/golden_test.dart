import 'package:flutter/material.dart';
import 'package:flutter_project_skeleton/core/i18n/translations.g.dart';
import '../storybook/app.dart';
import 'core/device.dart';
import 'core/golden_test_device_scenario.dart';
import 'package:alchemist/alchemist.dart';
import 'package:flutter_project_skeleton/view/pages/error_page.dart';

void main() {
  // final s = storybook();
  // for (var story in s.stories) {
  //   goldenTest(
  //     story.description ?? "golden test",
  //     fileName: story.name,
  //     builder: () => TranslationProvider(
  //       child: GoldenTestGroup(
  //         children: [
  //           GoldenTestDeviceScenario(
  //             device: Device.smallPhone,
  //             name: '${story.description} on small phone',
  //             builder: () => buildWidgetUnderTest(),
  //           ),
  //           //GoldenTestDeviceScenario(
  //           //  device: Device.tabletLandscape,
  //           //  name: '${story.description} on tablet',
  //           //  builder: () => Builder(builder: story.builder),
  //           //),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buildWidgetUnderTest() => const ErrorPage(
    title: "Internet error",
    description: "Bohužel se nám nepodařilo navázat internetové spojení.",
  );

  goldenTest(
    'golden test',
    fileName: 'error_page',
    builder: () => TranslationProvider(
      child: GoldenTestGroup(
        children: [
          GoldenTestDeviceScenario(
            device: Device.smallPhone,
            name: 'golden test ErrorPage on small phone',
            builder: buildWidgetUnderTest,
          ),
          GoldenTestDeviceScenario(
            device: Device.tabletLandscape,
            name: 'golden test ErrorPage on tablet',
            builder: buildWidgetUnderTest,
          ),
        ],
      ),
    ),
  );
}
