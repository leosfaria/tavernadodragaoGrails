package tavernadodragaograils

import javassist.bytecode.ByteArray

class User {

    transient springSecurityService

    String id

    String username
    String email
    String password
    String confirmPassword

    String image
    String contentType

    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    static transients = ['confirmPassword']

    static constraints = {
        username blank: false
        email blank: false, unique: true
        password blank: false, minSize: 3
        image nullable: true
        contentType nullable: true
    }

    Set<Role> getAuthorities() {
        return  [Role.ROLE_USER]
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService.encodePassword(password)
    }
}
