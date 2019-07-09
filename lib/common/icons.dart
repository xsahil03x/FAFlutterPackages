import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

get icBack => Platform.isAndroid ? Icons.arrow_back : CupertinoIcons.back;

get icExpandable =>
    Platform.isAndroid ? Icons.keyboard_arrow_down : CupertinoIcons.fullscreen;
