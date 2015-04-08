package tavernadodragaograils

class User {

    transient springSecurityService

    String username
    String email
    String password
    String confirmPassword

    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired
    static transients = ['confirmPassword']

    static constraints = {
        username blank: false
        email blank: false, unique: true
        password blank: false, minSize: 3
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
