import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class BaseView<T extends Store> extends StatefulWidget {
  const BaseView({
    required this.builder,
    required this.model,
    required this.onModelReady,
    this.dispose,
    Key? key,
  }) : super(key: key);

  final Widget Function(BuildContext context, T value) builder;
  final T model;
  final Function(T model) onModelReady;
  final VoidCallback? dispose;

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Store> extends State<BaseView<T>> {
  late T model;

  @override
  void initState() {
    model = widget.model;
    widget.onModelReady(model);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.dispose != null) {
      widget.dispose!();
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, model);
}
