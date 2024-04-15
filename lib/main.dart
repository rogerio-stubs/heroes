import 'package:code_hero/app/modules/heroes/data/repositories/get_heroes_repository_impl.dart';
import 'package:code_hero/app/modules/heroes/domain/usecases/get_heroes_usecase_impl.dart';
import 'package:code_hero/app/modules/heroes/external/datasources/get_heroes_datasource_impl.dart';
import 'package:code_hero/app/modules/heroes/presentation/heroes/heroes_controller.dart';
import 'package:code_hero/app/modules/heroes/presentation/heroes/heroes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HeroesController>(
          create: (context) => HeroesController(GetHeroesUseCaseImpl(
              GetHeroesRepositoryImpl(GetHeroesDataSourceImpl()))),
          child: const HeroesPage(),
        )
      ],
      child: ModularApp(
        module: AppModule(),
        child: AppWidget(),
      ),
    ),
  );
}
