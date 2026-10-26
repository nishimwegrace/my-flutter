import 'package:flutter_test/flutter_test.dart';
import 'package:kaze/app.dart';

void main() {
  testWidgets('login opens registration and legal placeholder screens', (
    tester,
  ) async {
    await tester.pumpWidget(const KazeApp());

    expect(find.text('Welcome back'), findsOneWidget);
    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();
    expect(find.text('Create an account'), findsOneWidget);
    expect(find.text('Please accept the terms to continue.'), findsNothing);

    final termsLink = find.text('Terms and Conditions');
    await tester.ensureVisible(termsLink);
    await tester.tap(termsLink);
    await tester.pumpAndSettle();
    expect(
      find.text('This information will be provided later.'),
      findsOneWidget,
    );
  });
}
