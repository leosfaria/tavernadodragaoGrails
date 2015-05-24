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
                    admin.confirmPassword = "admin"
                    admin.save(flush: true, failOnError: true)
                }

                User test = User.findOrCreateByUsername("ragnarok")
                if (!test.id) {
                    test.email = "ragnarok@odin.com.br"
                    test.password = "rag"
                    test.confirmPassword = "rag"
                    test.save(flush: true, failOnError: true)
                }
            }
        }
    }

    def destroy = {
    }
}