import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:storybook_toolkit_tester/storybook_toolkit_tester.dart';

import '../storybook/app.dart';

void main() => testStorybook(
  storybook(),
  devices: {Devices.android.smallPhone, Devices.ios.iPhone12, Devices.ios.iPad},
  filterStories: (Story story) {
    final skipStories = [];
    return !skipStories.contains(story.name);
  },
);