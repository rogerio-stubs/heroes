import 'package:code_hero/app/modules/heroes/domain/models/dtos/heroes_dto.dart';
import 'package:code_hero/app/modules/heroes/domain/usecases/get_heroes_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $HeroesController = Bind.singleton((i) => HeroesController(i()));

class HeroesController extends ChangeNotifier {
  HeroesController(this._getHeroesUseCase);

  final GetHeroesUseCase _getHeroesUseCase;
  final TextEditingController searchController = TextEditingController();

  final List<bool> pagination = [true, false, false];

  List<HeroesDto> heroes = [];

  Future<List<HeroesDto>> getHeroes(String? search) async {
    var response = await _getHeroesUseCase(search: search);

    if (!response.success) {
      print('Error: ${response.message}');
      heroes = [];
      return heroes;
    } else {
      heroes = response.body;
    }

    notifyListeners();
    return heroes;
  }

  bool getPagination(int index) => pagination[index];
  int getPaginationIndex() {
    int paginationIndex = pagination.indexWhere((element) => element == true);
    notifyListeners();
    return paginationIndex;
  }

  setPagination(int index) {
    pagination.fillRange(0, pagination.length, false);
    pagination[index] = true;
    notifyListeners();
  }

  void changePagination(int index) {
    setPagination(index);
    notifyListeners();
  }
}
