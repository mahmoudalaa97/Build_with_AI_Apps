import 'package:flutter/material.dart';
 
class LoadingOrResultWidget extends StatelessWidget {
  final bool isLoading;
  final Widget loadingWidget;
  final Widget resultWidget;

  const LoadingOrResultWidget({
    Key? key,
    required this.isLoading,
    this.loadingWidget = const CircularProgressIndicator(),
    required this.resultWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading ? loadingWidget : resultWidget;
  }
}