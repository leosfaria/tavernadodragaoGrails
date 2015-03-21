import tavernadodragaograils.User

class BootStrap {

    def grailsApplication

    def init = { servletContext ->
        grailsApplication.controllerClasses.each() { controllerClass ->
            def oldRedirect = controllerClass.metaClass.pickMethod("redirect", [Map] as Class[])
            controllerClass.metaClass.redirect = { Map args ->
                args.base = grailsApplication.config.grails.serverURL
                oldRedirect.invoke(delegate, args)
            }
        }

        environments {
            development {
                User admin = User.findOrCreateByUsername("admin")
                if (!admin.id) {
                    admin.email = "admin@admin.com.br"
                    admin.password = "admin"
                    admin.save(flush: true, failOnError: true)
                }
            }
        }
    }

    def destroy = {
    }
}