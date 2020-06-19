import 'dart:convert';

import 'package:covid19_api/app/services/api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class APIService {
    APIService(this.api);
    final API api;

    Future<String> getAccessToken() async{
      final response = await http.post(
        api.tokenUri().toString(),
        headers: {'Authorization': 'Basic ${api.apiKey}',
        'X-Requested-With': 'XMLHttpRequest'}
      ); //'Access-Control-Allow-Origin': '*' server
      print('response ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // a map assigned
        final accessToken = data['access_token'];// access_token is a key
        if (accessToken != null) {
          print('OK ' + accessToken);
          return accessToken;
        }
      }
      print('Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
      throw response;
    }

    Future<int> getEndpointData({
      @required String accessToken,
      @required Endpoint endpoint,

    }) async {
      final uri = api.endpointUri(endpoint);
      final response = await http.get(
        uri.toString(),
        headers: {'Authorization': 'Bearer $accessToken'}
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final Map<String, dynamic> endpointData = data[0];
          final int result = endpointData['data'];
          if (result != null) {
            return result;
          }

        }
      }
      print('Request ${api.endpointUri(endpoint)} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
      throw response;
    }
}