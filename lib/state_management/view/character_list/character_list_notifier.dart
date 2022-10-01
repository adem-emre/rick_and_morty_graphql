import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty_graphql/models/character.dart';
import 'package:rick_and_morty_graphql/state_management/enum/load_status.dart';
import 'package:rick_and_morty_graphql/state_management/service/character_service.dart';

class CharacterListNotifer extends ChangeNotifier{
  final CharacterService _characterService = CharacterService.create();

  LoadStatus loadStatus = LoadStatus.idle;
  List<Character>? characters;

  
  Future<void> fetchCharacters()async {
   try {
    loadStatus = LoadStatus.loading;
    characters = await _characterService.fetchCharacters();
    loadStatus = LoadStatus.loaded;
   } catch (e) {
     loadStatus = LoadStatus.error;
     debugPrint("Error : $e");
   }
   notifyListeners();
  }

}