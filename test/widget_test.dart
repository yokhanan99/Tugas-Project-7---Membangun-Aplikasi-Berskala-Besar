import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kampus/app.dart';
import 'package:nusa_kampus/config/dependencies.dart';
import 'package:provider/provider.dart';

import 'fakes.dart';

void main() {
  testWidgets('centang tugas mengubah badge tab Tugas', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: buildProviders(service: FakeCampusService()),
        child: const NusaKampusApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('2'), findsOneWidget); // badge awal

    await tester.tap(find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Tugas'),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.pumpAndSettle();

    expect(find.text('1'), findsOneWidget); // badge berkurang
  });
}
