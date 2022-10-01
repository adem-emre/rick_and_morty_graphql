import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_graphql/state_management/view/character_detail/character_detail_notifier.dart';

import '../../enum/load_status.dart';

class SmCharacterDetailView extends StatelessWidget {
  const SmCharacterDetailView({Key? key, required this.selectedCharacterId})
      : super(key: key);
  final String selectedCharacterId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CharacterDetailNotifier()..fetchCharacterDetail(selectedCharacterId),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Detail(State Management)"),
        ),
        body: Builder(builder: (context) {
          return Consumer<CharacterDetailNotifier>(
              builder: (_, characterDetailNotifier, __) {
            if (characterDetailNotifier.loadStatus == LoadStatus.error) {
              return const Center(child: Text("An error occured"));
            } else if (characterDetailNotifier.loadStatus ==
                LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: Image.network(
                    characterDetailNotifier.characterDetailModel?.image ?? "",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            characterDetailNotifier
                                    .characterDetailModel?.name ??
                                "",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            characterDetailNotifier
                                    .characterDetailModel?.species ??
                                "",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.purple),
                          ),
                        ],
                      ),
                      Text(
                        characterDetailNotifier.characterDetailModel?.gender ??
                            "",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Divider(),
                      Text(
                        "Episodes",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const Divider()
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: characterDetailNotifier
                        .characterDetailModel?.episode?.length,
                    itemBuilder: (BuildContext context, int index) {
                      final currentItem = characterDetailNotifier
                          .characterDetailModel?.episode?[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(currentItem?.id ?? ""),
                        ),
                        title: Text(currentItem?.name ?? ""),
                        subtitle: Text(currentItem?.episode ?? ""),
                      );
                    },
                  ),
                ),
              ],
            );
          });
        }),
      ),
    );
  }
}
