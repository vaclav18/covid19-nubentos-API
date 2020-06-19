import 'package:covid19_api/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum Endpoint {
  cases,
  todayCases,
  deaths,
  recovered,
  critical,
  active
}

class API {
  API ({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String tokenHost = 'cors-anywhere.herokuapp.com'; //workarround
  static final String host = 'apigw.nubentos.com';
  static final int port = 443;
  static final String tokenPath = host + '/token';
  static final String path = 't/nubentos.com/ncovapi/2.0.0';

  Uri tokenUri() => Uri(
    scheme: 'https',
    host: tokenHost,
    port: port,
    path: tokenPath,
    queryParameters: {'grant_type': 'client_credentials'},

    );

  Uri endpointUri(Endpoint endpoint) => Uri (
    scheme: 'https',
    host: host,
    port: port,
    path: '$path/${_paths[endpoint]}',
    queryParameters: {'grant_type': 'client_credentials'},

  );
  
  static Map<Endpoint, String> _paths = {
    Endpoint.cases:'cases',
    Endpoint.todayCases: 'todayCases',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
    Endpoint.critical: 'critical',
    Endpoint.active: 'active'
    
  };
}


