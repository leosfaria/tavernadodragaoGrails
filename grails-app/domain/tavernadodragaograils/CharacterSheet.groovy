package tavernadodragaograils

class CharacterSheet {

    String id

    String name

    List<CharacterImages> images = []

    static embedded = ['images']

    static constraints = {
        images nullable: true
    }
}
