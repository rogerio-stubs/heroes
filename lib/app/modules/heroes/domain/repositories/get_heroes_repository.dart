import 'package:code_hero/app/modules/heroes/domain/models/dtos/heroes_dto.dart';

abstract class GetHeroesRepository {
  Future<List<HeroesDto>> call({String? search});
}
  