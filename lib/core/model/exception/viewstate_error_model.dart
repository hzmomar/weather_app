import 'package:teleport_air_asia/core/constant/enum.dart';
import 'package:teleport_air_asia/core/service/localization/get_localization.dart';

class ViewStateError {
  final ViewStateErrorType _errorType;
  String? title;
  String? message;
  int? errorCode;

  ViewStateError(this._errorType, {this.message, this.title, this.errorCode}) {
    title ??= getLocalization.error;
    message ??= message ?? '';
    errorCode = errorCode;
  }

  ViewStateErrorType get errorType => _errorType;

  bool get isDefaultError => _errorType == ViewStateErrorType.defaultError;
  bool get isNetworkTimeOut => _errorType == ViewStateErrorType.networkError;
  bool get isUnauthorized => _errorType == ViewStateErrorType.unauthorizedError;

  @override
  String toString() {
    return 'ViewStateError{_errorType: $_errorType, title: $title, message: $message}';
  }
}