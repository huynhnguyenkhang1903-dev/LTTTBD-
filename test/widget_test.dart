import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Kiểm tra giao diện 3 cột và ngôi sao ở giữa', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Kiểm tra 3 cột tiêu đề
    expect(find.text('Cột 1'), findsOneWidget);
    expect(find.text('Cột 2'), findsOneWidget);
    expect(find.text('Cột 3'), findsOneWidget);

    // Kiểm tra text ở hàng dưới cùng
    expect(find.text('Cột 1: Xin chào'), findsOneWidget);
    expect(find.text('Cột 2: Flutter'), findsOneWidget);

    // Kiểm tra biểu tượng ngôi sao
    expect(find.byIcon(Icons.star), findsNWidgets(2)); // 1 ở Cột 1 và 1 ở giữa màn hình
  });
}
