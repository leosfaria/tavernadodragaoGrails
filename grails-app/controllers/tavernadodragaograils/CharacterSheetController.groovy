package tavernadodragaograils

import org.springframework.web.multipart.commons.CommonsMultipartFile

class CharacterSheetController {

    def springSecurityService

    def create() {
        User user = springSecurityService.currentUser

        render view: 'create', model: [userInstance: user]
    }

    def save() {
        User user = springSecurityService.currentUser
        CharacterSheet sheet = new CharacterSheet(params)

        if(isValidSheet(sheet)) {
            setCharacterSheetImage(sheet)
            sheet.save(flush: true, failOnError: true)

            flash.message = "tavernadodragaograils.CharacterSheet.save.success"
            flash.messageType = "success"
        }

        render view: 'create', model: [userInstance: user]
    }

    void setCharacterSheetImage(CharacterSheet sheet) {
        CommonsMultipartFile file = request.getFile('imageFile')

        if(file.size > 10000000) {
            flash.message = g.message(code: "tavernadodragaograils.CharacterSheet.image.size.error")
            flash.messageType = 'error'
            return
        }

        if(!file.contentType.contains("image")) {
            flash.message = g.message(code: "tavernadodragaograils.User.image.format.error")
            flash.messageType = 'error'
            return
        }

        CharacterImage image = new CharacterImage(image: file.bytes.encodeBase64().toString(), contentType: file.contentType)

        if(sheet.images == null) {
            sheet.images = []
        }

        sheet.images << image
    }

    boolean isValidSheet(CharacterSheet sheet) {
        flash.message = ""

        sheet.validate()
        if (sheet.hasErrors()) {
            for (fieldError in sheet.errors.fieldErrors) {
                flash.message += fieldError.codes[3] + ";"
            }
            flash.messageType = 'error'
        }

        if (!params.imageFile || params.imageFile.size == 0) {
            flash.message += "tavernadodragaograils.CharacterSheet.image.nullable.error;"
            flash.messageType = 'error'
        }

        return flash.messageType != 'error'
    }
}
