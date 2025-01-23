import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelo/verduras_modelo.dart';

class VerdurasControlador {
  final String apiUrl = 'http://localhost:5000/verduras';

  Future<List<Verdura>> fetchVerduras() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Verdura.fromJson(item)).toList();
      } else {
        print('Failed to load verduras: ${response.statusCode}');
        throw Exception('Failed to load verduras');
      }
    } catch (e) {
      print('Error fetching verduras: $e');
      throw Exception('Error fetching verduras');
    }
  }

  Future<Verdura> fetchVerdura(int codigo) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/$codigo'));
      if (response.statusCode == 200) {
        return Verdura.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to load verdura: ${response.statusCode}');
        throw Exception('Failed to load verdura');
      }
    } catch (e) {
      print('Error fetching verdura: $e');
      throw Exception('Error fetching verdura');
    }
  }

  Future<Verdura> addVerdura(Verdura verdura) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(verdura.toJson()),
      );

      if (response.statusCode == 201) {
        return Verdura.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        throw Exception('Error: ${jsonDecode(response.body)['error']}');
      } else {
        throw Exception('Failed to add verdura: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding verdura: $e');
      throw Exception('Error adding verdura: $e');
    }
  }

  Future<Verdura> updateVerdura(int codigo, Verdura verdura) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/$codigo'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(verdura.toJson()),
      );
      if (response.statusCode == 200) {
        return Verdura.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to update verdura: ${response.statusCode}');
        throw Exception('Failed to update verdura');
      }
    } catch (e) {
      print('Error updating verdura: $e');
      throw Exception('Error updating verdura');
    }
  }

  Future<void> deleteVerdura(int codigo) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/$codigo'));
      if (response.statusCode != 204) {
        print('Failed to delete verdura: ${response.statusCode}');
        throw Exception('Failed to delete verdura');
      }
    } catch (e) {
      print('Error deleting verdura: $e');
      throw Exception('Error deleting verdura');
    }
  }
}