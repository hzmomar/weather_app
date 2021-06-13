import 'package:teleport_air_asia/core/service/locator/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseView<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value) builder;
  final Function(AppLifecycleState, T)? didChangeAppLifeCycle;
  final Function(T)? onModelReady;
  final T? viewModel;

  const BaseView({
    required this.builder,
    Key? key,
    this.didChangeAppLifeCycle,
    this.onModelReady,
    this.viewModel,
  })  : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends ChangeNotifier> extends State<BaseView<T>>
    with WidgetsBindingObserver {
  late T model;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget.didChangeAppLifeCycle?.call(state, model);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    model = widget.viewModel ?? locator<T>();
    widget.onModelReady?.call(model);
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    return widget.viewModel != null
        ? ChangeNotifierProvider.value(
            value: widget.viewModel,
            child: widget.builder(context, widget.viewModel!),
          )
        : ChangeNotifierProvider(
            create: (context) => model,
            builder: (ctx, vm) {
              return widget.builder(ctx, model);
            },
          );
  }
}

class BaseView2<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  final Widget Function(BuildContext context, A viewModel1, B viewModel2)
      builder;
  final A? model1;
  final B? model2;
  final Widget? child;
  final Function(A model1, B model2)? onModelReady;

  const BaseView2({
    required this.builder,
    this.model1,
    this.model2,
    Key? key,
    this.child,
    this.onModelReady,
  })  : super(key: key);

  @override
  _BaseView2State<A, B> createState() => _BaseView2State<A, B>();
}

class _BaseView2State<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<BaseView2<A, B>> {
  late A model1;
  late B model2;

  @override
  void initState() {
    model1 = widget.model1 ?? locator<A>();
    model2 = widget.model2 ?? locator<B>();
    widget.onModelReady?.call(model1, model2);
    super.initState();
  }

  @override
  Widget build(BuildContext _) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>.value(value: model1),
        ChangeNotifierProvider<B>.value(value: model2),
      ],
      builder: (context, child) {
        return widget.builder(context, model1, model2);
      },
    );
  }
}
