import 'package:code_hero/app/modules/heroes/data/datasources/get_heroes_datasource.dart';
import 'package:code_hero/app/modules/heroes/domain/models/dtos/heroes_dto.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../domain/repositories/get_heroes_repository.dart';

final $GetHeroesRepositoryImpl =
    Bind.singleton((i) => GetHeroesRepositoryImpl(i()));

class GetHeroesRepositoryImpl implements GetHeroesRepository {
  GetHeroesRepositoryImpl(this._getHeroesDataSource);

  final GetHeroesDataSource _getHeroesDataSource;
  @override
  Future<List<HeroesDto>> call({String? search}) async {
    try {
      final result = await _getHeroesDataSource(search: search);
      var teste = result.map((e) => HeroesDto.fromJson(e)).toList();
      return teste;
    } catch (e) {
      rethrow;
    }
  }
}
