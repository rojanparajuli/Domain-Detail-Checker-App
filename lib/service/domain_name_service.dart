import 'dart:convert';
import 'package:domain_checker/components/api.dart';
import 'package:domain_checker/model/domain_name_model.dart';
import 'package:http/http.dart' as http;

class DomainService {
  Future<DomainName?> fetchDomains(String domain) async {
    final response = await http.get(Uri.parse('${Api.domainname}$domain'));
    print("Response:${response.body}");
    print("Status code:${response.statusCode}");

    if (response.statusCode == 200) {
      return DomainName.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load domain data');
    }
  }
}
