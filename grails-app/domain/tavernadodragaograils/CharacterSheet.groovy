package tavernadodragaograils

class CharacterSheet {

    String id

    String name

    String sheet

    List<CharacterImage> images = []

    static embedded = ['images']

    static constraints = {
        name unique: true
    }
}
