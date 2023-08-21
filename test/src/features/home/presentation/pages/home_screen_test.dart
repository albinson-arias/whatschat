import 'package:flutter_test/flutter_test.dart';
import 'package:whatschat/src/features/home/presentation/pages/home_screen.dart';

import '../../../../../helpers/helpers.dart';

void main() {
  testWidgets('home screen renders correctly', (tester) async {
    // Arrange
    const homePage = HomePage();

    // Act
    await tester.pumpApp(homePage);

    // Assert
    expect(find.byType(HomePage), findsOneWidget);
  });
}
