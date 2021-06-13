import 'package:flutter/material.dart';
import 'package:teleport_air_asia/core/service/localization/get_localization.dart';
import 'package:teleport_air_asia/core/viewmodel/startup_vm.dart';
import 'package:teleport_air_asia/ui/view/base_view.dart';
import 'package:teleport_air_asia/ui/widget/retry_dialog_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return BaseView<StartupVM>(
      onModelReady: (vm) => handleStartup(vm, _),
      builder: (context, vm) {
        return Scaffold(
          body: Center(
            child: Text(getLocalization.splashScreen),
          ),
        );
      },
    );
  }

  Future<void> handleStartup(StartupVM vm, BuildContext context) async {
    await vm.handleStartUp();
    checkError(vm, context, () => handleStartup(vm, context));
  }

  void checkError(StartupVM vm, BuildContext context, Function callback) {
    if (vm.isError) {
      showRetryDialog(
        subtitle: vm.viewStateError?.message,
        context: context,
        callback: callback,
      );
    }
  }
}
