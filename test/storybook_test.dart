import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../storybook/app.dart';

void main() => testStorybook(
  storybook(),
  devices: {Device.iPhone8, Device.iPhone13, Device.pixel5, Device.iPadPro},
  filterStories: (Story story) {
    final skipStories = [];
    return !skipStories.contains(story.name);
  },
);