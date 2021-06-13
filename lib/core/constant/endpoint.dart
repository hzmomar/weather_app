import 'package:path/path.dart' as p;


class Endpoint {
  Endpoint._();

  static final String _dataPath = '/data/';
  static final String _version = '2.5/';
  static final String _base = '$_dataPath$_version';
  static final String weather = p.join(_base, 'weather');
  static final String forecast = p.join(_base, 'forecast');
}
