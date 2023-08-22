import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:whatschat/src/common/widgets/app_button.dart';
import 'package:whatschat/src/features/home/presentation/pages/home_screen.dart';
import 'package:whatschat/src/features/home/presentation/widgets/phone_field.dart';

import '../../../../../helpers/helpers.dart';
import '../../../../../helpers/mocks.dart';

void main() {
  testWidgets('home screen renders correctly', (tester) async {
    // Arrange
    const homePage = HomePage();

    // Act
    await tester.pumpApp(homePage);

    // Assert
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
    expect(find.byType(PhoneFieldView), findsOneWidget);
  });

  group('validate', () {
    testWidgets('should set isValid to true when form is valid',
        (tester) async {
      await tester.runAsync(() async {
        // Arrange
        const homePage = HomePage();
        await tester.pumpApp(homePage);
        final phoneField = find.byType(PhoneFieldView);

        // Act
        await tester.pumpAndSettle();
        await tester.enterText(phoneField, '9294199470');
        await tester.pumpAndSettle();
        await Future<void>.delayed(const Duration(milliseconds: 250));
        await tester.pumpAndSettle();

        final isValid =
            tester.state<HomePageState>(find.byType(HomePage)).isValid;

        // Assert
        expect(isValid, true);
        expect(find.byType(AppButton), findsOneWidget);
        expect(
          tester.widget<AppButton>(find.byType(AppButton)).onPressed,
          isNotNull,
        );
      });
    });
    testWidgets('should set isValid to false when form is invalid',
        (tester) async {
      await tester.runAsync(() async {
        // Arrange
        const homePage = HomePage();
        await tester.pumpApp(homePage);
        final phoneField = find.byType(PhoneFieldView);

        // Act
        await tester.pumpAndSettle();
        await tester.enterText(phoneField, '123');
        await tester.pumpAndSettle();
        await Future<void>.delayed(const Duration(milliseconds: 250));
        await tester.pumpAndSettle();

        final isValid =
            tester.state<HomePageState>(find.byType(HomePage)).isValid;

        // Assert
        expect(isValid, false);
        expect(find.byType(AppButton), findsOneWidget);
        expect(
          tester.widget<AppButton>(find.byType(AppButton)).onPressed,
          isNull,
        );
      });
    });
  });

  late MockUrlLauncher mock;

  setUp(() {
    mock = MockUrlLauncher();
    UrlLauncherPlatform.instance = mock;
  });
  group('onSubmit', () {
    testWidgets('opens link when canLaunchUrl returns true', (tester) async {
      await tester.runAsync(() async {
        // Arrange
        const homePage = HomePage();
        await tester.pumpApp(homePage);
        final phoneField = find.byType(PhoneFieldView);
        mock
          ..setLaunchExpectations(
            url: 'https://wa.me/19294199470?text=Hello',
            useSafariVC: false,
            useWebView: false,
            universalLinksOnly: false,
            enableJavaScript: true,
            enableDomStorage: true,
            headers: <String, String>{},
            webOnlyWindowName: null,
            launchMode: PreferredLaunchMode.externalApplication,
          )
          ..setResponse(response: true);

        // Act
        await tester.pumpAndSettle();
        await tester.enterText(phoneField, '9294199470');
        await tester.pumpAndSettle();
        await Future<void>.delayed(const Duration(milliseconds: 250));
        await tester.pumpAndSettle();
        final isValid =
            tester.state<HomePageState>(find.byType(HomePage)).isValid;

        // Assert
        expect(isValid, true);
        expect(find.byType(AppButton), findsOneWidget);
        expect(
          tester.widget<AppButton>(find.byType(AppButton)).onPressed,
          isNotNull,
        );

        // Act
        await tester.tap(find.byType(AppButton));
        await tester.pumpAndSettle();

        // Assert
        expect(mock.canLaunchCalled, isTrue);
        expect(mock.launchCalled, isTrue);
      });
    });

    testWidgets('shows snackbar when canLaunchUrl returns false',
        (tester) async {
      await tester.runAsync(() async {
        // Arrange
        const homePage = HomePage();
        await tester.pumpApp(homePage);
        final phoneField = find.byType(PhoneFieldView);
        mock
          ..setLaunchExpectations(
            url: 'https://wa.me/19294199470?text=Hello',
            useSafariVC: false,
            useWebView: false,
            universalLinksOnly: false,
            enableJavaScript: true,
            enableDomStorage: true,
            headers: <String, String>{},
            webOnlyWindowName: null,
            launchMode: PreferredLaunchMode.externalApplication,
          )
          ..setResponse(response: false);

        // Act
        await tester.pumpAndSettle();
        await tester.enterText(phoneField, '9294199470');
        await tester.pumpAndSettle();
        await Future<void>.delayed(const Duration(milliseconds: 250));
        await tester.pumpAndSettle();
        final isValid =
            tester.state<HomePageState>(find.byType(HomePage)).isValid;

        // Assert
        expect(isValid, true);
        expect(find.byType(AppButton), findsOneWidget);
        expect(
          tester.widget<AppButton>(find.byType(AppButton)).onPressed,
          isNotNull,
        );

        // Act
        await tester.tap(find.byType(AppButton));
        await tester.pumpAndSettle();

        // Assert
        expect(find.text('Could not launch WhatsApp'), findsOneWidget);
        expect(mock.canLaunchCalled, isTrue);
        expect(mock.launchCalled, isFalse);
      });
    });
  });
}
