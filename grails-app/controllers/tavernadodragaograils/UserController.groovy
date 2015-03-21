package tavernadodragaograils

class UserController {

    def login() {
        render view: 'login'
    }

    def signUp() {
        render view: 'create'
    }

    def save() {
        User user = new User(params.id)

        if(!user.id) {
            user.properties = params
            user.confirmPassword = params.confirmPassword

            user.validate()

            if(!user.hasErrors()) {
                user.save(flush: true)

                render view: 'login'

                flash.message = 'User saved!'
                return
            }


            render view: 'create', model: [userInstance: user]
        }
    }
}
