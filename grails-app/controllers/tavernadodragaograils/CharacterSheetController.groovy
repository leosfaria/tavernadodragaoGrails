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
        CharacterSheet characterSheet = new CharacterSheet(params)

        if(isValidSheet(characterSheet)) {
            setCharacterSheetImages(characterSheet)
            characterSheet.save(flush: true, failOnError: true)

            user.characterSheets << characterSheet
            user.save(flush: true, failOnError: true)

            flash.message = g.message(code: "tavernadodragaograils.CharacterSheet.save.success", args: [characterSheet.name])
            flash.messageType = "success"
        }

        render view: 'create', model: [userInstance: user]
    }

    def edit() {
        User user = springSecurityService.currentUser
        CharacterSheet sheet = CharacterSheet.findById(params.characterId)

        render view: 'edit', model: [userInstance: user, characterInstance: sheet]
    }

    void setCharacterSheetImages(CharacterSheet sheet) {
        List<CommonsMultipartFile> files = request.getFiles('imageFile')

        for (file in files) {
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
        }

        files.each { file ->
            CharacterImage image = new CharacterImage(image: file.bytes.encodeBase64().toString(), contentType: file.contentType)

            if(sheet.images == null) {
                sheet.images = []
            }

            sheet.images << image
        }
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
