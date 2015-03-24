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
            user.confirmPassword = params.confirmPassword

            user.validate()

            if(!user.hasErrors()) {
                user.save(flush: true, failOnError: true)

                render view: 'home'

                flash.message = 'User saved!'
                return
            }


            render view: '/login/auth', model: [userInstance: user]
        }
    }
}
