import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_and_morty_graphql/models/character.dart';
import 'package:rick_and_morty_graphql/queries/character_query.dart' as queries;

class CharacterList extends StatelessWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
          options: QueryOptions(document: gql(queries.readCharacters)),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Center(child: Text(result.exception.toString()));
            } else if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            List<Character>? characters = (result.data?["characters"]?["results"] as List?)?.map((character) => Character.fromJson(character)).toList();

            return ListView.builder(
              itemCount: characters?.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(characters?[index].image ?? ""),
                  ),
                  title: Text(characters?[index].name ?? ""),
                );
              },
            );
          }),
    );
  }
}
