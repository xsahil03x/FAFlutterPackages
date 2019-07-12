import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:fa_flutter_packages/common/dimensions.dart';
import 'package:flutter/material.dart';

get cardShape => Platform.isAndroid
    ? RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      )
    : RoundedRectangleBorder();

var rng = new Random();
var letters = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];

Color get rngColor =>
    Color.fromRGBO(rng.nextInt(255), rng.nextInt(255), rng.nextInt(255), 1);

List<String> createRandomList(int size, String postfix, int limit) {
  List<String> list = new List();
  for (var i = 0; i < size; i++) {
    list.add(rng.nextInt(limit).toString() + postfix);
  }
  return list;
}

List<double> createRandomDoubleList(int size, int limit) {
  List<double> list = new List();
  for (var i = 0; i < size; i++) {
    list.add(rng.nextInt(limit).toDouble());
  }
  return list;
}

String createRandomString(int charSize) {
  var str = '';
  for (var i = 0; i < charSize; i++) str = str + letters[rng.nextInt(25)];
  return str;
}

String truncateString(String input, {bool enable = true, int limit = 8}) {
  if (enable) {
    if (input.length > limit) {
      return input.substring(0, limit) + '..';
    }
  }
  return input;
}
