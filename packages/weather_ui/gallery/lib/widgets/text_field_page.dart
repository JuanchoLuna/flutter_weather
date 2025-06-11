import 'package:weather_ui/weather_ui.dart';
import 'package:flutter/material.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const TextFieldPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Field',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(WEATHERSpacing.lg),
        child: Column(
          children: [
            WEATHERTextField.emailTextField(
              onChanged: (_) {},
            ),
            const SizedBox(height: WEATHERSpacing.sm),
            WEATHERTextField.passwordTextField(
              onChanged: (_) {},
            ),
            const SizedBox(height: WEATHERSpacing.sm),
            WEATHERTextField(
              hintText: 'Default text field',
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
