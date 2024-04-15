import 'package:code_hero/app/modules/heroes/data/repositories/get_heroes_repository_impl.dart';
import 'package:code_hero/app/modules/heroes/domain/usecases/get_heroes_usecase_impl.dart';
import 'package:code_hero/app/modules/heroes/external/datasources/get_heroes_datasource_impl.dart';
import 'package:code_hero/app/modules/heroes/presentation/heroes/heroes_controller.dart';
import 'package:code_hero/app/modules/heroes/presentation/heroes/heroes_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

 
class HeroesModule extends Module {
  @override
  final List<Bind> binds = [
    $GetHeroesDataSourceImpl,
    $GetHeroesRepositoryImpl,
    $GetHeroesUseCaseImpl,
    $HeroesController,
 ];

 @override
 final List<ModularRoute> routes = [
   ChildRoute(Modular.initialRoute, child: (_, args) => const HeroesPage()),
   
 ];

}