import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_graphql/state_management/enum/load_status.dart';
import 'package:rick_and_morty_graphql/state_management/view/character_detail/sm_character_detail.dart';
import 'package:rick_and_morty_graphql/state_management/view/character_list/character_list_notifier.dart';

class SmCharacterList extends StatelessWidget {
  const SmCharacterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CharacterListNotifer()..fetchCharacters(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Characters(State Management)",
          ),
        ),
        body: Builder(
          builder: (context) {
            return Consumer<CharacterListNotifer>(
                builder: (_, characterListNotifier, __) {
              if (characterListNotifier.loadStatus == LoadStatus.error) {
                return const Center(child: Text("An error occured"));
              } else if (characterListNotifier.loadStatus == LoadStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
    
              return ListView.builder(
                itemCount: characterListNotifier.characters?.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          characterListNotifier.characters?[index].image ?? ""),
                    ),
                    title: Text(characterListNotifier.characters?[index].name ?? ""),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SmCharacterDetailView(
                                  selectedCharacterId:
                                      characterListNotifier.characters?[index].id ??
                                          "")));
                    },
                  );
                },
              );
            });
          }
        ),
      ),
    );
  }
}
