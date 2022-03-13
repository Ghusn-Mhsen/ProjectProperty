// import 'dart:convert';
//
// import 'package:flutter_app666/property.dart';
// import 'package:http/http.dart' as http ;
// class Api{
//
//   static const String baseUrl="https://10.0.2.2/project";
//  static Future<property> createproperty(property pro) async {
//
//     final response = await http.post(
//       Uri.parse('$baseUrl/upload.php'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(pro.toJson()),
//     );
//
//     if (response.statusCode == 200) {
//       // If the server did return a 200 CREATED response,
//    {
//
//       // then parse the JSON.
// try {
//   return property.fromJson(json.decode(response.body));
// }
// catch(e)
//    }
//     } else {
//       // If the server did not return a 201 CREATED response,
//       // then throw an exception.
//       throw Exception('Failed to load property');
//     }
//   }
//
//  static Future<List<property>> fetchproperty() async {
//
//     final response = await http.get(Uri.parse('$baseUrl'),);
//     if (response.statusCode == 200) {
//       // If the server did return a 200 OK response,
//       // then parse the JSON.
//      final parsed =json.decode(response.body).cast<Map<String,dynamic>>();
//      return parsed.map<property>((item)=>property.fromJson(item)).tolist();
//     } else {
//       // If the server did not return a 200 OK response,
//       // then throw an exception.
//       throw Exception('Failed to load property');
//     }
//   }
//
//
//  static Future<property> deleteAlbum(property pro) async {
//    final http.Response response = await http.delete(
//      Uri.parse('$baseUrl'),
//      headers: <String, String>{ 'Content-Type': 'application/json; charset=UTF-8', }, );
//    if (response.statusCode == 200) {
//        // If the server returned a 200 OK response,
//      // then parse the JSON. After deleting, // you'll get an empty JSON `{}` response.
//      // Don't return `null`, otherwise // `snapshot.hasData` will always return false
//      // on `FutureBuilder`.
//      return property.fromJson(jsonDecode(response.body)); }
//      else { throw Exception('Failed to delete album.'); } }
//
// }
