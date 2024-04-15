import 'package:code_hero/app/modules/shared/response/response_presentation.dart';

abstract class GetHeroesUseCase {
  Future<ResponsePresentation> call({String? search});
}
