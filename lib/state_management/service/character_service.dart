
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_and_morty_graphql/models/character.dart';
import 'package:rick_and_morty_graphql/models/character_detail_model.dart';
import 'package:rick_and_morty_graphql/queries/character_query.dart' as queries;

class CharacterService {
  final GraphQLClient _graphQLClient;

  CharacterService(this._graphQLClient);

  factory CharacterService.create(){
     final httpLink = HttpLink("https://rickandmortyapi.com/graphql");
    final link = Link.from([httpLink]);
    return CharacterService(
      GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }

  Future<List<Character>?> fetchCharacters() async {
    final result = await _graphQLClient
        .query(QueryOptions(document: gql(queries.readCharacters)));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    List<Character>? characters =
        (result.data?["characters"]?["results"] as List?)
            ?.map((character) => Character.fromJson(character))
            .toList();
    return characters;
  }

  Future<CharacterDetailModel?> fetchCharacterDetail(
      String selectedCharacterId) async {
    final result = await _graphQLClient.query(QueryOptions(
        document: gql(queries.readCharacterById),
        variables: {"characterId": selectedCharacterId}));
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }
    CharacterDetailModel? characterDetail = (result
                    .data?["charactersByIds"] as List?)
                ?.map((character) => CharacterDetailModel.fromJson(character))
                .toList()[0];
    return characterDetail;
  }
}
