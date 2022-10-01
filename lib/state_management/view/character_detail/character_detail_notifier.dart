import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty_graphql/state_management/enum/load_status.dart';
import 'package:rick_and_morty_graphql/state_management/service/character_service.dart';

import '../../../models/character_detail_model.dart';

class CharacterDetailNotifier extends ChangeNotifier{
  final CharacterService _characterService = CharacterService.create();

  LoadStatus loadStatus = LoadStatus.idle;
  CharacterDetailModel? characterDetailModel;

  
  Future<void> fetchCharacterDetail(String characterId)async {
   try {
    loadStatus = LoadStatus.loading;
    characterDetailModel = await _characterService.fetchCharacterDetail(characterId);
    loadStatus = LoadStatus.loaded;
   } catch (e) {
     loadStatus = LoadStatus.error;
     debugPrint("Error : $e");
   }
   notifyListeners();
  }

}