String readCharacters ="""
query CharacterNameAndImage{
    characters{
      results{
      name
      image
      }
    }
}
""";

String readCharacterById = """
query CharacterById(\$characterId : ID!){
   charactersByIds(ids:\$characterId) {
     id
    name
    image
    gender
    species
    episode{
      name
      episode
      id
    }
   }
}
""";