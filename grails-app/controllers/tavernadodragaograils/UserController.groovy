package tavernadodragaograils

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
                //TODO: fazer o groovy pegar a defaultMessage do message.properties corretamente e eleminar esses ifs
                if(user.errors.fieldError.field == "username") {
                    flash.message = g.message(code: "tavernadodragaograils.User.username.nullable.error")
                } else if(user.errors.fieldError.field == "email") {
                    if(user.errors.fieldErrors.codes.flatten().first().contains("unique")) {
                        flash.message = g.message(code: "tavernadodragaograils.User.email.unique.error")
                    } else {
                        flash.message = g.message(code: "tavernadodragaograils.User.email.blank.error")
                    }
                } else if(user.errors.fieldError.field == "password"){
                    flash.message = g.message(code: "tavernadodragaograils.User.password.blank.error")
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
