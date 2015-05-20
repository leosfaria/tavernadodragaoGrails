package tavernadodragaograils

import org.apache.commons.fileupload.disk.DiskFileItem
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.commons.CommonsMultipartFile

class UserController {
    def springSecurityService
    def passwordEncoder

    def home() {
        render view: 'home', model: [userInstance: springSecurityService.currentUser]
    }

    def save() {
        User user = new User(params.id)

        if(!user.id) {
            user.properties = params

            user.validate()
            if(user.hasErrors()) {
                flash.message = ""
                for(fieldError in user.errors.fieldErrors) {
                    flash.message += fieldError.codes[3] + ";"
                }
                flash.messageType = 'error'
            } else if(user.password != params.confirmPassword) {
                flash.message = g.message(code: "tavernadodragaograils.User.confirmPassword.validator.error")
                flash.messageType = 'error'
            } else {
                user.save(flush: true, failOnError: true)
                springSecurityService.reauthenticate(user.username, user.password)
                home()
                return
            }

            render view: '/login/auth', model: [userInstance: user]
        }
    }

    def edit(){
        render view: 'edit', model: [userInstance: springSecurityService.currentUser]
    }

    def update() {
        User user = springSecurityService.currentUser

        if(params.password != null && !params.password.isEmpty()) {
            if(!passwordEncoder.isPasswordValid(user.password, params.password, null)) {
                flash.message = g.message(code: "tavernadodragaograils.User.update.password.error")
                flash.messageType = "error"
            } else if (params.newPassword != params.confirmNewPassword) {
                flash.message = g.message(code: "tavernadodragaograils.User.confirmPassword.validator.error")
                flash.messageType = 'error'
            } else if(params.newPassword == null || params.newPassword.isEmpty()){
                flash.message = g.message(code: "tavernadodragaograils.User.update.newpassword.nullable.error")
                flash.messageType = "error"
            } else {
                user.password = params.newPassword
            }
        }

        if(params.username != null && !params.username.isEmpty()) {
            user.username = params.username
        }

        if(params.image.size != 0) {
            def externalPath = "c:/Leo/Projects/Taverna/tavernadodragaoGrails/userData/avatar/"

            def file = request.getFile('image')

            user.image = file.bytes.encodeBase64().toString()
            user.contentType = file.contentType
        }

        if(flash.messageType != "error") {
            user.save(flush: true, failOnError: true)

            flash.message = g.message(code: "tavernadodragaograils.User.update.success")
            flash.messageType = 'success'
        }

        render view: 'edit', model: [userInstance: user]
    }

    def imageAvatar() {
        User user = User.get(params.id)
        def contentType = ""
        def image = ""

        if(user.contentType) {
            contentType = user.contentType
            image = user.image
        } else {
            File defaultImg = new File("grails-app/assets/images/yourImageDefault.jpg");

            contentType = "image/jpg"
            image = defaultImg.bytes.encodeBase64().toString()
        }

        response.setContentType(contentType)
        response.getOutputStream().write(image.decodeBase64())
    }
}