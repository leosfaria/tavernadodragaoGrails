package tavernadodragaograils

import grails.plugin.springsecurity.SpringSecurityUtils
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.web.multipart.commons.CommonsMultipartFile

class UserController {
    def springSecurityService
    def passwordEncoder

    def home() {
        render view: 'home', model: [userInstance: springSecurityService.currentUser]
    }

    def save() {
        User user = new User(params)

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
            if(params.imageFile != null && params.imageFile.size != 0) {
                setUserImage(user)
            }

            if(flash.messageType != 'error') {
                user.save(flush: true, failOnError: true)

                //Login in
                Authentication auth = new UsernamePasswordAuthenticationToken(user, null, user.getAuthoritiesGranted())
                SecurityContextHolder.getContext().setAuthentication(auth)

                home()
                return
            }
        }

        def config = SpringSecurityUtils.securityConfig
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"

        render view: '/login/auth', model: [postUrl: postUrl, rememberMeParameter: config.rememberMe.parameter,
                                            userInstance: user]
    }

    def edit(){
        render view: 'edit', model: [userInstance: springSecurityService.currentUser]
    }

    def update() {
        User user = springSecurityService.currentUser
        User oldUser = new User(username: user.username, password: user.password, image: user.image)

        if(params.password != null && !params.password.isEmpty() && isUserNewPasswordValid(user)) {
            user.password = params.newPassword
        }

        if(params.username != null && !params.username.isEmpty()) {
            user.username = params.username
        }

        if(params.imageFile != null && params.imageFile.size != 0) {
            setUserImage(user)
        }

        if(flash.messageType != "error" && isUserChanged(user, oldUser)) {
            user.save(flush: true, failOnError: true)

            flash.message = g.message(code: "tavernadodragaograils.User.update.success")
            flash.messageType = 'success'
        }

        render view: 'edit', model: [userInstance: user]
    }

    def addFriend() {
        User user = User.get(params.friendId)

        if(user) {
            User userLogged = springSecurityService.currentUser

            if(!user.friendRequests) {
                user.friendRequests = []
            }

            if(!userLogged.friends.contains(user)) {
                user.friendRequests << userLogged
                user.save(flush: true, failOnError: true)

                flash.message = g.message(code: "tavernadodragaograils.User.friend.request.send")
                flash.messageType = 'success'
            }
        } else {
            flash.message = g.message(code: "tavernadodragaograils.User.not.found.error")
            flash.messageType = 'error'
        }

        home()
    }

    def acceptFriend() {
        User user = User.get(params.friendId)

        if(user) {
            User userLogged = springSecurityService.currentUser

            if(!userLogged.friends) {
                userLogged.friends = []
            }

            if(!user.friends) {
                user.friends = []
            }

            if(!userLogged.friends.contains(user)) {
                user.friends << userLogged
                user.save(flush: true, failOnError: true)

                userLogged.friends << user
                userLogged.friendRequests.remove(user)
                userLogged.save(flush: true, failOnError: true)

                flash.message = g.message(code: "tavernadodragaograils.User.friend.request.accept", args: [user.username])
                flash.messageType = 'success'
            }
        } else {
            flash.message = g.message(code: "tavernadodragaograils.User.not.found.error")
            flash.messageType = 'error'
        }

        home()
    }

    def declineFriend() {
        User user = User.get(params.friendId)

        if(user) {
            User userLogged = springSecurityService.currentUser

            userLogged.friendRequests.remove(user)
            userLogged.save(flush: true, failOnError: true)
        } else {
            flash.message = g.message(code: "tavernadodragaograils.User.not.found.error")
            flash.messageType = 'error'
        }

        home()
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

    void setUserImage(User user) {
        CommonsMultipartFile file = request.getFile('imageFile')

        if(file.size > 5000000) {
            flash.message = g.message(code: "tavernadodragaograils.User.image.size.error")
            flash.messageType = 'error'
            return
        }

        if(!file.contentType.contains("image")) {
            flash.message = g.message(code: "tavernadodragaograils.User.image.format.error")
            flash.messageType = 'error'
            return
        }

        user.image = file.bytes.encodeBase64().toString()
        user.contentType = file.contentType
    }

    Boolean isUserNewPasswordValid(User loggedUser) {
        if(!passwordEncoder.isPasswordValid(loggedUser.password, params.password, null)) {
            flash.message = g.message(code: "tavernadodragaograils.User.update.password.error")
            flash.messageType = "error"
        } else if (params.newPassword != params.confirmNewPassword) {
            flash.message = g.message(code: "tavernadodragaograils.User.confirmPassword.validator.error")
            flash.messageType = 'error'
        } else if(params.newPassword == null || params.newPassword.isEmpty()) {
            flash.message = g.message(code: "tavernadodragaograils.User.update.newpassword.nullable.error")
            flash.messageType = "error"
        } else if(params.newPassword.size() < 3) {
            flash.message = g.message(code: "tavernadodragaograils.User.password.minSize.error")
            flash.messageType = "error"
        }

        return flash.messageType != "error"
    }

    Boolean isUserChanged(User newUser, User loggedUser) {
        return newUser.username != loggedUser.username || newUser.password != loggedUser.password || newUser.image != loggedUser.image
    }
}