import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:storybook_toolkit_tester/storybook_toolkit_tester.dart';

import '../storybook/app.dart';

void main() => testStorybook(
      storybook(),
      devices: {
        Devices.ios.iPhoneSE,
        Devices.ios.iPhone13ProMax,
        Devices.android.onePlus8Pro,
        Devices.android.samsungGalaxyA50,
        Devices.android.sonyXperia1II,
      },
      filterStories: (Story story) {
        final skipStories = [];
        return !skipStories.contains(story.name);
      },
    );
