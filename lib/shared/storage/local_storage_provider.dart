import 'package:path_provider/path_provider.dart' as path_provider;

class LocalStorageProvider {
  LocalStorageProvider._();

  static String? _path;

  static String get path {
    if (_path != null) {
      return _path!;
    } else {
      throw Exception('Path is not initialized');
    }
  }

  static Future<void> init() async {
    final dirPath = await path_provider.getApplicationDocumentsDirectory();
    _path = dirPath.path;
  }
}
