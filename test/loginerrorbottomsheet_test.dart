import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_explorer/presentation/widgets/login_error_bottom_sheet.dart';

void main() {
  testWidgets('LoginErrorBottomSheet displays message and closes on button tap', (WidgetTester tester) async {
    const testMessage = 'This is a test error message';
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (_) => const LoginErrorBottomSheet(message: testMessage),
                    );
                  },
                  child: const Text('Open Error'),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('Open Error'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.error), findsOneWidget);
    expect(find.text(testMessage), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginErrorBottomSheet), findsNothing);
  });
}
