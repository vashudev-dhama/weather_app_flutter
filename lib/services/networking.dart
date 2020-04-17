import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkConnection {
  NetworkConnection(this.url);

  /// URL for which connection need to be establish.
  final String url;

  /// Get the JSON data from mentioned [url] with http GET request.
  Future getWeatherJsonData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
