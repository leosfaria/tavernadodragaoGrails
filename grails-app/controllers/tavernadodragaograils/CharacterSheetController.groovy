package tavernadodragaograils

class CharacterSheetController {

    def springSecurityService

    def create() {
        User user = springSecurityService.currentUser

        render view: 'create', model: [userInstance: user]
    }

    def save() {
        User user = springSecurityService.currentUser
        CharacterSheet sheet = new CharacterSheet(params)

        sheet.validate()
        if(sheet.hasErrors()) {
            flash.message = ""
            for(fieldError in sheet.errors.fieldErrors) {
                flash.message += fieldError.codes[3] + ";"
            }
            flash.messageType = 'error'
        } else {

        }

        render view: 'create', model: [userInstance: user]
    }
}
