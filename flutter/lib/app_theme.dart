import 'package:flutter/material.dart';

class AppTheme {
  static TextTheme textTheme() {
    final typography = Typography.material2018();
    final textTheme = typography.englishLike.merge(typography.black);
    final ratio = 0.5;
    return textTheme.copyWith(
      bodyText1: textTheme.bodyText1
          ?.copyWith(height: 1.4, fontSize: textTheme.bodyText1!.fontSize! * ratio, locale: Locale('ja', 'JP')),
      bodyText2: textTheme.bodyText2?.copyWith(height: 1.4),
      subtitle1: textTheme.subtitle1?.copyWith(height: 1.4),
      subtitle2: textTheme.subtitle2?.copyWith(height: 1.4),
      headline1: textTheme.headline1?.copyWith(fontSize: textTheme.headline1!.fontSize! * ratio),
      headline2: textTheme.headline2?.copyWith(fontSize: textTheme.headline2!.fontSize! * ratio),
      headline4: textTheme.headline4?.copyWith(height: 1.4),
      headline5: textTheme.headline5?.copyWith(height: 1.4, color: Colors.black45),
      headline6: textTheme.headline6?.copyWith(height: 1.4),
      caption: textTheme.caption?.copyWith(height: 1.6),
    );
  }

  static ThemeData get theme => ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
        ),
        textTheme: textTheme(),
      );
}
