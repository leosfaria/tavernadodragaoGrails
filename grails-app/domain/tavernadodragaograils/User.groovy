package tavernadodragaograils

import javassist.bytecode.ByteArray
import org.springframework.security.core.GrantedAuthority

class User {

    transient springSecurityService

    String id

    String username
    String email
    String password
    String confirmPassword

    String image
    String contentType

    List<User> friends = []

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
        friends nullable: true
    }

    static hasMany = [ friends: User ]

    Set<Role> getAuthorities() {
        return  [Role.ROLE_USER]
    }

    Collection<GrantedAuthority> getAuthoritiesGranted() {
        //make everyone ROLE_USER
        Collection<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>()

        GrantedAuthority grantedAuthority = new GrantedAuthority() {
            //anonymous inner type
            public String getAuthority() {
                return "ROLE_USER"
            }
        }

        grantedAuthorities.add(grantedAuthority)
        return grantedAuthorities
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
