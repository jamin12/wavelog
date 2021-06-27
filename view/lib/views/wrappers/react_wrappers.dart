import 'package:flutter/material.dart';

class ReactBaseSize {
  double _standardSize = 800;
  bool _isWebCheck() => identical(0, 0.0);
}

// ignore: must_be_immutable
class ReactWrappers extends StatelessWidget with ReactBaseSize {
  final WidgetBuilder webScaffold;
  final WidgetBuilder appScaffold;

  ReactWrappers(
      {Key? key, required this.webScaffold, required this.appScaffold})
      : super(key: key);

  @override
  Widget build(BuildContext context) => _widget(context);

  Widget _widget(BuildContext context) {
    if (_isWebCheck() && MediaQuery.of(context).size.width > _standardSize)
      return webScaffold(context);
    return appScaffold(context);
  }
}
