import 'package:flutter/material.dart';

/// A convenience wrapper that applies a consistent page layout.
/// Wraps [body] in a [Scaffold] with an optional [appBar] and
/// [floatingActionButton].
class AppScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(child: body),
      floatingActionButton: floatingActionButton,
    );
  }
}
