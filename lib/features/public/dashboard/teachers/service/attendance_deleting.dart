import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> deleteAttendance(String attendanceId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  final url = Uri.parse(
    'https://api.badriyya.in/class/attendance/$attendanceId',
  ); // Replace with your actual DELETE endpoint
  try {
    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
