package tavernadodragaograils

class CharacterSheetController {

    def springSecurityService

    def create() {
        User user = springSecurityService.currentUser

        render view: 'create', model: [userInstance: user]
    }

    def save() {
        CharacterSheet sheet = new CharacterSheet(params)

        sheet.validate()
        if(sheet.hasErrors()) {
            flash.message = ""
            for(fieldError in sheet.errors.fieldErrors) {
                flash.message += fieldError.codes[3] + ";"
            }
            flash.messageType = 'error'
        } else {
            User user = springSecurityService.currentUser

            render view: 'home', model: [userInstance: user]
        }
    }
}
