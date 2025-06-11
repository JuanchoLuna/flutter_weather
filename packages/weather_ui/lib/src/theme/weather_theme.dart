import 'package:flutter/material.dart';
import 'package:weather_ui/weather_ui.dart';
import 'package:flutter/services.dart';

/// A class that provides the theme for the app.
class WEATHERTheme {
  /// Light Theme example based on Material 2 Design.
  ThemeData get lightTheme {
    return ThemeData(
      primaryColor: WEATHERColors.skyBlue,
      canvasColor: _backgroundColor,
      scaffoldBackgroundColor: _backgroundColor,
      iconTheme: _lightIconTheme,
      appBarTheme: _lightAppBarTheme,
      dividerTheme: _dividerTheme,
      textTheme: _lightTextTheme,
      buttonTheme: _buttonTheme,
      splashColor: WEATHERColors.transparent,
      elevatedButtonTheme: _elevatedButtonTheme,
      textButtonTheme: _textButtonTheme,
      colorScheme: _lightColorScheme,
      bottomSheetTheme: _lightBottomSheetTheme,
      listTileTheme: _listTileTheme,
      switchTheme: _switchTheme,
      progressIndicatorTheme: _progressIndicatorTheme,
      tabBarTheme: _tabBarTheme,
      bottomNavigationBarTheme: _bottomAppBarTheme,
      chipTheme: _chipTheme,
      dividerColor: WEATHERColors.grey,
      outlinedButtonTheme: _lightOutlinedButtonTheme,
    );
  }

  /// Dark Theme example based on Material 2 Design.
  ThemeData get darkTheme => lightTheme.copyWith(
        chipTheme: _darkChipTheme,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: WEATHERColors.black,
        colorScheme: _darkColorScheme,
        appBarTheme: _darkAppBarTheme,
        disabledColor: WEATHERColors.white.withOpacity(0.5),
        textTheme: _darkTextTheme,
        unselectedWidgetColor: WEATHERColors.lightGrey,
        iconTheme: _darkIconTheme,
        bottomSheetTheme: _darkBottomSheetTheme,
        outlinedButtonTheme: _darkOutlinedButtonTheme,
        textButtonTheme: _darkTextButtonTheme,
      );

  /// Returns the correct color based on the current theme.
  ColorScheme get _lightColorScheme {
    return ColorScheme.light(
      primary: WEATHERColors.skyBlue,
      primaryContainer: WEATHERColors.lightBlue200,
      onPrimaryContainer: WEATHERColors.oceanBlue,
      secondary: WEATHERColors.paleSky,
      onSecondary: WEATHERColors.white,
      secondaryContainer: WEATHERColors.lightBlue200,
      onSecondaryContainer: WEATHERColors.oceanBlue,
      tertiary: WEATHERColors.secondary.shade700,
      onTertiary: WEATHERColors.white,
      tertiaryContainer: WEATHERColors.secondary.shade300,
      onTertiaryContainer: WEATHERColors.secondary.shade700,
      error: WEATHERColors.red,
      errorContainer: WEATHERColors.red.shade200,
      onErrorContainer: WEATHERColors.redWine,
      background: _backgroundColor,
      onBackground: WEATHERColors.onBackground,
      surfaceVariant: WEATHERColors.surface,
      onSurfaceVariant: WEATHERColors.grey,
      inversePrimary: WEATHERColors.crystalBlue,
    );
  }

  /// Returns the correct color based on the current theme.
  ColorScheme get _darkColorScheme => _lightColorScheme.copyWith(
        background: WEATHERColors.black,
        onBackground: WEATHERColors.white,
        surface: WEATHERColors.black,
        onSurface: WEATHERColors.lightGrey,
        primary: WEATHERColors.blue,
        onPrimary: WEATHERColors.oceanBlue,
        primaryContainer: WEATHERColors.oceanBlue,
        onPrimaryContainer: WEATHERColors.lightBlue200,
        secondary: WEATHERColors.paleSky,
        onSecondary: WEATHERColors.lightGrey,
        secondaryContainer: WEATHERColors.liver,
        onSecondaryContainer: WEATHERColors.brightGrey,
      );

  /// Returns the correct background color based on the current theme.
  Color get _backgroundColor => WEATHERColors.white;

  /// Returns the correct [AppBarTheme] based on the current theme.
  AppBarTheme get _lightAppBarTheme {
    return AppBarTheme(
      iconTheme: _lightIconTheme,
      titleTextStyle: _lightTextTheme.titleMedium,
      elevation: 0,
      toolbarHeight: 64,
      backgroundColor: WEATHERColors.white,
      toolbarTextStyle: _lightTextTheme.titleLarge,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  /// Returns the correct [AppBarTheme] based on the current theme.
  AppBarTheme get _darkAppBarTheme {
    return _lightAppBarTheme.copyWith(
      backgroundColor: WEATHERColors.grey,
      iconTheme: _darkIconTheme,
      toolbarTextStyle: _darkTextTheme.titleLarge,
      titleTextStyle: _darkTextTheme.titleMedium,
    );
  }

  /// Returns the correct [IconThemeData] based on the current theme.
  IconThemeData get _lightIconTheme {
    return const IconThemeData(
      color: WEATHERColors.black,
    );
  }

  /// Returns the correct [IconThemeData] based on the current theme.
  IconThemeData get _darkIconTheme {
    return const IconThemeData(
      color: WEATHERColors.white,
    );
  }

  /// Returns the correct [DividerThemeData] based on the current theme.
  DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      color: WEATHERColors.outlineLight,
      space: WEATHERSpacing.lg,
      thickness: WEATHERSpacing.xxxs,
      indent: WEATHERSpacing.lg,
      endIndent: WEATHERSpacing.lg,
    );
  }

  /// Returns the correct [TextTheme] based on the current theme.
  TextTheme get _lightTextTheme => lightUITextTheme;

  /// Returns the correct [TextTheme] based on the current theme.
  TextTheme get _darkTextTheme {
    return _lightTextTheme.apply(
      bodyColor: WEATHERColors.white,
      displayColor: WEATHERColors.white,
      decorationColor: WEATHERColors.white,
    );
  }

  /// The UI text theme based on [WEATHERTextStyle].
  static final lightUITextTheme = TextTheme(
    displayLarge: WEATHERTextStyle.headline1,
    displayMedium: WEATHERTextStyle.headline2,
    displaySmall: WEATHERTextStyle.headline3,
    titleMedium: WEATHERTextStyle.subtitle1,
    titleSmall: WEATHERTextStyle.subtitle2,
    bodyLarge: WEATHERTextStyle.bodyText1,
    bodyMedium: WEATHERTextStyle.bodyText2,
    labelLarge: WEATHERTextStyle.button,
    bodySmall: WEATHERTextStyle.caption,
    labelSmall: WEATHERTextStyle.overline,
  ).apply(
    bodyColor: WEATHERColors.black,
    displayColor: WEATHERColors.black,
    decorationColor: WEATHERColors.black,
  );

  /// Returns the correct [ChipThemeData] based on the current theme.
  ChipThemeData get _chipTheme {
    return ChipThemeData(
      backgroundColor: WEATHERColors.secondary.shade300,
      disabledColor: _backgroundColor,
      selectedColor: WEATHERColors.secondary.shade700,
      secondarySelectedColor: WEATHERColors.secondary.shade700,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      labelStyle: WEATHERTextStyle.button.copyWith(color: WEATHERColors.black),
      secondaryLabelStyle:
          WEATHERTextStyle.labelSmall.copyWith(color: WEATHERColors.white),
      brightness: Brightness.light,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(),
      ),
    );
  }

  /// Returns the correct [ChipThemeData] based on the current theme.
  ChipThemeData get _darkChipTheme {
    return _chipTheme.copyWith(
      backgroundColor: WEATHERColors.white,
      disabledColor: _backgroundColor,
      selectedColor: WEATHERColors.secondary.shade700,
      secondarySelectedColor: WEATHERColors.secondary.shade700,
      labelStyle: WEATHERTextStyle.button.copyWith(
        color: WEATHERColors.secondary.shade700,
      ),
      secondaryLabelStyle: WEATHERTextStyle.labelSmall.copyWith(
        color: WEATHERColors.black,
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: WEATHERColors.white, width: 2),
        borderRadius: BorderRadius.circular(22),
      ),
    );
  }

  /// Returns the correct [ButtonThemeData] based on the current theme.
  ButtonThemeData get _buttonTheme {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WEATHERSpacing.sm),
      ),
      padding: const EdgeInsets.symmetric(vertical: WEATHERSpacing.lg),
      buttonColor: WEATHERColors.blue,
      disabledColor: WEATHERColors.lightGrey,
      height: 48,
      minWidth: 48,
    );
  }

  /// Returns the correct [ElevatedButtonThemeData] based on the current theme.
  ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(vertical: WEATHERSpacing.lg),
        textStyle: _lightTextTheme.labelLarge?.copyWith(
          fontWeight: WEATHERFontWeight.bold,
        ),
        backgroundColor: WEATHERColors.blue,
      ),
    );
  }

  /// Returns the correct [TextButtonThemeData] based on the current theme.
  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _lightTextTheme.labelLarge?.copyWith(
          fontWeight: WEATHERFontWeight.light,
        ),
        foregroundColor: WEATHERColors.black,
      ),
    );
  }

  /// Returns the correct [TextButtonThemeData] based on the current theme.
  TextButtonThemeData get _darkTextButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _lightTextTheme.labelLarge?.copyWith(
          fontWeight: WEATHERFontWeight.light,
        ),
        foregroundColor: WEATHERColors.white,
      ),
    );
  }

  /// Returns the correct [BottomSheetThemeData] based on the current theme.
  BottomSheetThemeData get _lightBottomSheetTheme {
    return const BottomSheetThemeData(
      backgroundColor: WEATHERColors.modalBackground,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(WEATHERSpacing.lg),
          topRight: Radius.circular(WEATHERSpacing.lg),
        ),
      ),
    );
  }

  /// Returns the correct [BottomSheetThemeData] based on the current theme.
  BottomSheetThemeData get _darkBottomSheetTheme {
    return _lightBottomSheetTheme.copyWith(
      backgroundColor: WEATHERColors.grey,
    );
  }

  /// Returns the correct [ListTileThemeData] based on the current theme.
  ListTileThemeData get _listTileTheme {
    return const ListTileThemeData(
      iconColor: WEATHERColors.onBackground,
      contentPadding: EdgeInsets.all(WEATHERSpacing.lg),
    );
  }

  /// Returns the correct [SwitchThemeData] based on the current theme.
  SwitchThemeData get _switchTheme {
    return SwitchThemeData(
      thumbColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return WEATHERColors.darkAqua;
        }
        return WEATHERColors.black;
      }),
      trackColor:
          MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return WEATHERColors.primaryContainer;
        }
        return WEATHERColors.paleSky;
      }),
    );
  }

  /// Returns the correct [ProgressIndicatorThemeData] based on the current
  /// theme.
  ProgressIndicatorThemeData get _progressIndicatorTheme {
    return const ProgressIndicatorThemeData(
      color: WEATHERColors.darkAqua,
      circularTrackColor: WEATHERColors.borderOutline,
    );
  }

  /// Returns the correct [TabBarTheme] based on the current theme.
  TabBarThemeData get _tabBarTheme {
    return TabBarThemeData(
      labelStyle: WEATHERTextStyle.button,
      labelColor: WEATHERColors.darkAqua,
      labelPadding: const EdgeInsets.symmetric(
        horizontal: WEATHERSpacing.lg,
        vertical: WEATHERSpacing.md + WEATHERSpacing.xxs,
      ),
      unselectedLabelStyle: WEATHERTextStyle.button,
      unselectedLabelColor: WEATHERColors.mediumEmphasisSurface,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3,
          color: WEATHERColors.darkAqua,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  /// Returns the correct [BottomNavigationBarThemeData] based on the current
  /// theme.
  BottomNavigationBarThemeData get _bottomAppBarTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: WEATHERColors.black,
      selectedItemColor: WEATHERColors.white,
      unselectedItemColor: WEATHERColors.white.withOpacity(0.74),
    );
  }

  /// Returns the correct [OutlinedButtonThemeData] based on the current theme.
  OutlinedButtonThemeData get _lightOutlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const StadiumBorder()),
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => WEATHERColors.white,
        ),
        side: MaterialStateProperty.resolveWith(
          (states) => const BorderSide(),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: WEATHERSpacing.xlg,
            vertical: WEATHERSpacing.lg,
          ),
        ),
        alignment: Alignment.center,
        textStyle: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled)
              ? WEATHERTextStyle.button.copyWith(
                  color: WEATHERColors.black,
                  fontWeight: FontWeight.w500,
                )
              : WEATHERTextStyle.button.copyWith(
                  color: states.contains(MaterialState.disabled)
                      ? WEATHERColors.black
                      : WEATHERColors.white,
                  fontWeight: FontWeight.w500,
                ),
        ),
      ),
    );
  }

  /// Returns the correct [OutlinedButtonThemeData] based on the current theme.
  OutlinedButtonThemeData get _darkOutlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(const StadiumBorder()),
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => WEATHERColors.black,
        ),
        side: MaterialStateProperty.resolveWith(
          (states) => const BorderSide(color: WEATHERColors.white),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: WEATHERSpacing.xlg,
            vertical: WEATHERSpacing.lg,
          ),
        ),
        alignment: Alignment.center,
        textStyle: MaterialStateProperty.resolveWith(
          (states) => states.contains(MaterialState.disabled)
              ? WEATHERTextStyle.button.copyWith(
                  color: WEATHERColors.white,
                  fontWeight: FontWeight.w500,
                )
              : WEATHERTextStyle.button.copyWith(
                  color: states.contains(MaterialState.disabled)
                      ? WEATHERColors.black
                      : WEATHERColors.white,
                  fontWeight: FontWeight.w500,
                ),
        ),
      ),
    );
  }
}
