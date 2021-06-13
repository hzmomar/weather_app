enum ViewState {
  idle,
  busy,
  empty,
  error,
}

enum ViewStateErrorType {
  defaultError,
  networkError,
  unauthorizedError
}

enum AppEnvironment { dev, uat, prod }