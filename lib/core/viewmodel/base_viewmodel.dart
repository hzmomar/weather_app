import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:teleport_air_asia/core/constant/enum.dart';
import 'package:teleport_air_asia/core/model/exception/failure_exception.dart';
import 'package:teleport_air_asia/core/model/flavor_manager.dart';
import 'package:teleport_air_asia/core/model/exception/viewstate_error_model.dart';
import 'package:teleport_air_asia/core/service/localization/get_localization.dart';
import 'package:teleport_air_asia/core/service/locator/locator.dart';
import 'package:teleport_air_asia/core/service/service.dart';

abstract class BaseViewModel with ChangeNotifier {
  bool _disposed = false;

  ViewState _viewState;

  ViewStateError? _viewStateError;

  ViewStateError? get viewStateError => _viewStateError;

  BaseViewModel({ViewState? viewState})
      : _viewState = viewState ?? ViewState.idle;

  Service service = locator<Service>();

  ViewState get viewState => _viewState;

  bool get isBusy => _viewState == ViewState.busy;

  bool get isIdle => _viewState == ViewState.idle;

  bool get isEmpty => _viewState == ViewState.empty;

  bool get isError => _viewState == ViewState.error;

  set viewState(ViewState viewState) {
    if (_viewState != viewState) {
      _viewState = viewState;
      notifyListeners();
    }
  }

  void setIdle() {
    viewState = ViewState.idle;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setBusy() {
    viewState = ViewState.busy;
  }

  void setError(dynamic e, dynamic s, {String? title}) {
    ViewStateErrorType errorType = ViewStateErrorType.defaultError;
    String? message;
    int? errorCode;

    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        errorType = ViewStateErrorType.networkError;
        message = e.error;
      } else if (e.type == DioErrorType.response) {
        message = e.error;
      } else if (e.type == DioErrorType.cancel) {
        message = e.error;
      } else if (e.error is SocketException) {
        errorType = ViewStateErrorType.networkError;
        message = getLocalization.noInternetFullMsg;
      } else {
        message = e.error.toString();
      }
    } else if (e is FailureException) {
      message = e.toString();
      errorCode = e.error.code;
    } else {
      message = e.toString();
    }
    _viewStateError = ViewStateError(errorType,
        message: message ?? '', title: title, errorCode: errorCode);
    viewState = ViewState.error;
    print(e.toString());
    if (FlavorManager.instance.isDev) {
      print(s);
    }
    onError(viewStateError);
  }

  void onError(ViewStateError? viewStateError) {}

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
