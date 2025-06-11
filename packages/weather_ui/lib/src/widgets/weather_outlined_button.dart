import 'package:weather_ui/weather_ui.dart';
import 'package:flutter/material.dart';


/// {@template outlined_button}
/// A button component based on material [OutlinedButton] widget
/// {@endtemplate}
class WEATHEROutlinedButton extends StatelessWidget {
  /// {@macro ui_outlined_button}
  const WEATHEROutlinedButton({
    required this.text,
    super.key,
    this.backgroundColor,
    this.darkBackgroundColor,
    this.textColor,
    this.onPressed,
    this.borderColor,
    this.icon,
  });
  
  /// Primary button which background color is the primary color of the theme
  const WEATHEROutlinedButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
  })  : backgroundColor = WEATHERColors.lightBlue200,
        darkBackgroundColor = WEATHERColors.blue,
        borderColor = WEATHERColors.white,
        textColor = WEATHERColors.black;

  /// Secondary button which background color
  /// is the secondary color of the theme
  const WEATHEROutlinedButton.secondary({
    required this.text,
    super.key,
    this.onPressed,
    this.icon,
  })  : backgroundColor = WEATHERColors.grey,
        darkBackgroundColor = WEATHERColors.grey,
        borderColor = WEATHERColors.white,
        textColor = WEATHERColors.white;

  /// Text on the button
  final String text;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// Background color of the button
  final Color? backgroundColor;

  /// Background color of the button in dark mode
  final Color? darkBackgroundColor;

  /// Text color of the button
  final Color? textColor;

  /// Border color of the button
  final Color? borderColor;

  /// Icon on the button
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final isInactive = onPressed == null;
    final theme = Theme.of(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        disabledBackgroundColor: theme.colorScheme.background,
        backgroundColor: backgroundColor,
        side: borderColor == null
            ? null
            : BorderSide(
                color: onPressed == null
                    ? (theme.colorScheme.onBackground)
                    : borderColor!,
              ),
        padding: const EdgeInsets.symmetric(
          horizontal: WEATHERSpacing.md,
          vertical: WEATHERSpacing.md,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: icon,
            ),
          SizedBox(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: WEATHERTextStyle.button.copyWith(
                color:
                    isInactive ? (theme.colorScheme.onBackground) : textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
