/*
Name: Akshath Jain
Date: 3/18/19
Purpose: Basic smoke test for the sliding_up_panel_plus package
Copyright: © 2019, Akshath Jain. All rights reserved.
Licensing: See LICENSE in the project root.
*/

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sliding_up_panel_plus/sliding_up_panel_plus.dart';

void main() {
  testWidgets('SlidingUpPanel renders with the new package entrypoint', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SlidingUpPanel(panel: const SizedBox(), body: const SizedBox()),
      ),
    );

    expect(find.byType(SlidingUpPanel), findsOneWidget);
  });
}
