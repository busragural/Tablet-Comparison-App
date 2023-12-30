import 'dart:convert';
import 'package:http/http.dart' as http;

class FlaskService {
  Future<void> runScraper(String scraperName) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.146.8:5000/run_scraper'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'scraper_name': scraperName}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          print('Scraper Result: ${data['result']}');
        } else {
          print('Error running scraper: ${data['error']}');
        }
      } else {
        print('Failed to connect to the server');
      }
    } catch (e) {
      print('Exception during HTTP request: $e');
    }
  }
}
