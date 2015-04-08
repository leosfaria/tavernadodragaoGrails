package tavernadodragaograils

import org.springframework.validation.FieldError

class UserController {
    def springSecurityService

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

                home()
                return
            }

            render view: '/login/auth', model: [userInstance: user]
        }
    }
}
