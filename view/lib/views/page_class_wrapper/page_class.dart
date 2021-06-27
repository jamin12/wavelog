import 'package:blog/views/wrappers/react_wrappers.dart';
import 'package:flutter/material.dart';

abstract class PageClass extends StatelessWidget {
  const PageClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => _render();

  Widget _render() =>
      ReactWrappers(webScaffold: webScaffold, appScaffold: appScaffold);
  Widget webScaffold(BuildContext context);
  Widget appScaffold(BuildContext context);
}
