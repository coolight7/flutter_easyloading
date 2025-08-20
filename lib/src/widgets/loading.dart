// The MIT License (MIT)
//
// Copyright (c) 2020 nslogx
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../easy_loading.dart';
import './overlay_entry.dart';

class FlutterEasyLoading extends StatefulWidget {
  final Widget? child;

  const FlutterEasyLoading({
    super.key,
    required this.child,
  }) : assert(child != null);

  @override
  _FlutterEasyLoadingState createState() => _FlutterEasyLoadingState();
}

class _FlutterEasyLoadingState extends State<FlutterEasyLoading> {
  EasyLoadingOverlayEntry? overlayEntry;
  EasyLoadingOverlayEntry? childOverlayEntity;

  @override
  void initState() {
    super.initState();
    EasyLoading.instance.overlayEntry?.remove();
    EasyLoading.instance.overlayEntry?.dispose();
    EasyLoading.instance.overlayEntry = null;
    overlayEntry = EasyLoadingOverlayEntry(
      builder: (BuildContext context) =>
          EasyLoading.instance.widget ?? const SizedBox(),
    );
    childOverlayEntity = EasyLoadingOverlayEntry(
      builder: (BuildContext context) {
        if (widget.child != null) {
          return widget.child!;
        } else {
          return const SizedBox();
        }
      },
    );
    EasyLoading.instance.overlayEntry = overlayEntry;
  }

  @override
  void dispose() {
    childOverlayEntity?.remove();
    childOverlayEntity?.dispose();
    childOverlayEntity = null;
    overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0x00000000),
      animationDuration: Duration.zero,
      child: Overlay(
        initialEntries: [
          if (null != childOverlayEntity) childOverlayEntity!,
          if (null != overlayEntry) overlayEntry!,
        ],
      ),
    );
  }
}
