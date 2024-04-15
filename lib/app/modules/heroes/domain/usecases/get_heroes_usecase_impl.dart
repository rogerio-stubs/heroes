import 'package:code_hero/app/modules/heroes/domain/repositories/get_heroes_repository.dart';
import 'package:code_hero/app/modules/shared/response/response_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'get_heroes_usecase.dart';


final $GetHeroesUseCaseImpl = Bind.singleton((i) => GetHeroesUseCaseImpl(i<GetHeroesRepository>()));

class GetHeroesUseCaseImpl implements GetHeroesUseCase {
  GetHeroesUseCaseImpl(this._getHeroesRepository);

  final GetHeroesRepository _getHeroesRepository;

  @override
  Future<ResponsePresentation> call({String? search}) async  {
    try {
      final heroes = await _getHeroesRepository(search: search);
      return ResponsePresentation(success: true, body: heroes);
    } catch (e) {
      return ResponsePresentation(success: false, message: e.toString());
    }
  }
    
} 
  