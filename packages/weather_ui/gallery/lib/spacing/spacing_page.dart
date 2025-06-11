import 'package:weather_ui/weather_ui.dart';
import 'package:flutter/material.dart';

class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SpacingPage());
  }

  @override
  Widget build(BuildContext context) {
    const spacingList = [
      _SpacingItem(spacing: WEATHERSpacing.xxxs, name: 'xxxs'),
      _SpacingItem(spacing: WEATHERSpacing.xxs, name: 'xxs'),
      _SpacingItem(spacing: WEATHERSpacing.xs, name: 'xs'),
      _SpacingItem(spacing: WEATHERSpacing.sm, name: 'sm'),
      _SpacingItem(spacing: WEATHERSpacing.md, name: 'md'),
      _SpacingItem(spacing: WEATHERSpacing.lg, name: 'lg'),
      _SpacingItem(spacing: WEATHERSpacing.xlg, name: 'xlg'),
      _SpacingItem(spacing: WEATHERSpacing.xxlg, name: 'xxlg'),
      _SpacingItem(spacing: WEATHERSpacing.xxxlg, name: 'xxxlg'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Spacing')),
      body: ListView.builder(
        itemCount: spacingList.length,
        itemBuilder: (_, index) => spacingList[index],
      ),
    );
  }
}

class _SpacingItem extends StatelessWidget {
  const _SpacingItem({required this.spacing, required this.name});

  final double spacing;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(WEATHERSpacing.sm),
      child: Row(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                color: WEATHERColors.black,
                width: WEATHERSpacing.xxs,
                height: WEATHERSpacing.lg,
              ),
              Container(
                width: spacing,
                height: WEATHERSpacing.lg,
                color: WEATHERColors.skyBlue,
              ),
              Container(
                color: WEATHERColors.black,
                width: WEATHERSpacing.xxs,
                height: WEATHERSpacing.lg,
              ),
            ],
          ),
          const SizedBox(width: WEATHERSpacing.sm),
          Text(name),
        ],
      ),
    );
  }
}
