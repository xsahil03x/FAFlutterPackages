import 'package:flutter/material.dart';

///[color] 0xFF0097CD
const color_primary = Color(0xFF0097CD);

///[color] 0xFF005486
const color_primaryDark = Color(0xFF005486);

///[color] 0xFFE5F8FF
const color_primaryLight = Color(0xFFE5F8FF);

///[color] 0xFF5B666E
const color_secondary = Color(0xFF5B666E);

///[color] 0xFF282B2D
const color_secondaryDark = Color(0xFF282B2D);

///[color] 0xFFEEEEEE
const color_secondaryLight = Color(0xFFEEEEEE);

///[color] 0xFFFFFFFF
const color_backgroundLight = Color(0xFFFFFFFF);

///[color] 0xFFF5F5F5
const color_backgroundDark = Color(0xFFF5F5F5);

///[color] 0xDE000000
const color_textBlackHigh = Color(0xDE000000);

///[color] 0x99000000
const color_textBlackMedium = Color(0x99000000);

///[color] 0x4D000000
const color_textBlackLow = Color(0x4D000000);

///[color] 0xFFFFFFFF
const color_textWhiteHigh = Color(0xFFFFFFFF);

///[color] 0x99FFFFFF
const color_textWhiteMedium = Color(0x99FFFFFF);

///[color] 0x4DFFFFFF
const color_textWhiteLow = Color(0x4DFFFFFF);

///[color] 0xFF307146
const color_greenDark = Color(0xFF307146);

///[color] 0xFF4BA42A
const color_greenLight = Color(0xFF4BA42A);

///[color] 0xFFEC4497
const color_magenta = Color(0xFFEC4497);

///[color] 0xFFA139A7
const color_purple = Color(0xFFA139A7);

///[color] 0xFF49ACAA
const color_cyan = Color(0xFF49ACAA);

///[color] 0xFF2B5797
const color_blueDark = Color(0xFF2B5797);

///[color] 0xFF2D89EF
const color_blueLight = Color(0xFF2D89EF);

///[color] 0xFFF9C446
const color_yellow = Color(0xFFF9C446);

///[color] 0xFFDA5330
const color_orange = Color(0xFFDA5330);

///[color] 0xFFED3833
const color_red = Color(0xFFED3833);

///[color] 0xFFFFFFFF
const color_white = Color(0xFFFFFFFF);

///[color] 0xAAFFFFFF
const color_white_alpha = Color(0xAAFFFFFF);

///[color] 0xFF000000
const color_black = Color(0xFF000000);

///[color] 0xE1E1E1
const color_grey = Color(0xFFE1E1E1);

///[color] 0x00000000
const color_transparent = Color(0x00000000);

///[color] 0xFFE9E9E9
const color_grey_extra = Color(0xFFE1E1E1);

///[color] 0xFFE9E9E9
const color_shimmer_base = Color(0xFFDDDDDD);

const color_shimmer = Color(0xEEFFFFFF);

const linePercentageDisableColor = color_backgroundDark;
const cardColor = color_backgroundLight;

List<Color> colorRange(Color startColor, Color endColor, int limit) {
  List<Color> colors = [];
  /* Logger.debug(startColor.value.toString());
  Logger.debug(endColor.value.toString());*/
  for (var i = 0; i < limit; i++) {
    colors.add(Color.fromRGBO(
        colorInterpolation(startColor.red, endColor.red, limit - 1, i),
        colorInterpolation(startColor.green, endColor.green, limit - 1, i),
        colorInterpolation(startColor.blue, endColor.blue, limit - 1, i),
        1));
  }
  /*colors.forEach((c) {
    Logger.debug(c.value.toString());
  });*/
  return colors;
}

int colorInterpolation(int color1, int color2, int limit, int i) {
  limit = limit != 0 ? limit : 1;
  double increment = (i / limit);
  double color1Value = color1 * (1 - increment);
  double color2Value = color2 * (increment);
  int value = (color1Value + color2Value).toInt();
  //Logger.debug('$i $color1 $color1Value $color2 $color2Value $value');
  return value;
}
