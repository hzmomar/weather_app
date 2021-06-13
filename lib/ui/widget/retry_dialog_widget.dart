import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teleport_air_asia/core/service/localization/get_localization.dart';
import 'package:teleport_air_asia/core/service/navigation/navigation_service.dart';
import 'package:teleport_air_asia/ui/shared/roboto_style.dart';
import 'package:teleport_air_asia/ui/shared/theme_color.dart';

void showRetryDialog({
  required String? subtitle,
  required BuildContext context,
  required Function callback,
  String? title,
  Function? onSecondaryActionPressed,
}) {
  showModal(
    context: context,
    configuration: const FadeScaleTransitionConfiguration(
      barrierColor: Colors.black54,
      barrierDismissible: true,
    ),
    builder: (BuildContext context) => Dialog(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        color: ThemeColor.shadeWhite,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// title text
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                title ?? getLocalization.error,
                style: RobotoStyle.h5.copyWith(color: ThemeColor.shadeBlack),
                textAlign: TextAlign.center,
              ),
            ),

            /// subtitle text
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                subtitle ?? '',
                style: RobotoStyle.bodyText1
                    .copyWith(color: ThemeColor.shade80),
                textAlign: TextAlign.center,
              ),
            ),

            /// primary action button
            MaterialButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(3),
                ),
              ),
              highlightElevation: 0,
              focusElevation: 0,
              disabledElevation: 0,
              hoverElevation: 0,
              color: ThemeColor.informationB500,
              height: 48,
              elevation: 0,
              minWidth: MediaQuery.of(context).size.width,
              disabledColor: ThemeColor.shadeWhite,
              onPressed: () {
                callback.call();
                navigationService.pop();
              },
              child: Text(
                getLocalization.retry,
                textAlign: TextAlign.center,
                style: RobotoStyle.button.copyWith(
                  color: ThemeColor.shadeWhite,
                ),
              )
            ),

            /// secondary action text
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: InkWell(
                onTap: () {
                  navigationService.pop();
                  onSecondaryActionPressed?.call();
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Text(
                  getLocalization.cancel,
                  textAlign: TextAlign.center,
                  style: RobotoStyle.button,
                ),
              ),
            )
          ],
        ),
      ),
    )
  );
}
