import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../data/datasources/get_heroes_datasource.dart';

final $GetHeroesDataSourceImpl =
    Bind.singleton((i) => GetHeroesDataSourceImpl());

class GetHeroesDataSourceImpl implements GetHeroesDataSource {
  final String publicKey = '458e6b0b51b39f9cf1fb101b36371989';
  final String privateKey = '24a0c6e2164771075e0db8660178ac43903444a4';
  final _httpClient = Dio();

  GetHeroesDataSourceImpl() {
    _httpClient.options.baseUrl = 'https://gateway.marvel.com:443';
    _httpClient.options.headers['Content-Type'] = 'application/json';
  }

  @override
  Future<List<Map<String, dynamic>>> call({String? search}) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash = generateHash(timestamp);
    final url = '/v1/public/characters${search != null && search.isNotEmpty ? '?name=${Uri.encodeComponent(search)}' : ''}';
    var heroes = await _httpClient.get(
      url,
      queryParameters: {
        "apikey": publicKey,
        "ts": timestamp,
        "hash": hash,
      },
    );
    final Map<String, dynamic> jsonMap = heroes.data;
    final List<Map<String, dynamic>> results =
        List<Map<String, dynamic>>.from(jsonMap['data']['results']);
    return results;
  }

  String generateHash(String timestamp) {
    final String hash =
        md5.convert(utf8.encode(timestamp + privateKey + publicKey)).toString();
    return hash;
  }
}
