import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_explorer/presentation/widgets/login_error_bottom_sheet.dart';

void main() {
  testWidgets('ErrorBottomSheet displays message and closes on button tap', (WidgetTester tester) async {
    const testMessage = 'This is a test error message';

    // Build a basic app with a button to open the bottom sheet
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

    // Tap the button to open the bottom sheet
    await tester.tap(find.text('Open Error'));
    await tester.pumpAndSettle();

    // Verify the error icon, message, and close button are present
    expect(find.byIcon(Icons.error), findsOneWidget);
    expect(find.text(testMessage), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);

    // Tap the "Close" button
    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    // Bottom sheet should now be closed
    expect(find.byType(LoginErrorBottomSheet), findsNothing);
  });
}
