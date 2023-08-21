import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {}

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.mockGoRouter,
    required this.child,
    super.key,
  });

  /// The [MockGoRouter] instance to provide.
  final MockGoRouter mockGoRouter;

  /// The child [Widget] to wrap.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InheritedGoRouter(goRouter: mockGoRouter, child: child);
  }
}
