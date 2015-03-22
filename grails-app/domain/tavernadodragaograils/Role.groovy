package tavernadodragaograils

/**
 * Created by Leonardo on 22/03/2015.
 */
enum Role {
    ROLE_ADMIN,
    ROLE_USER

    String getAuthority() {
        return this.name()
    }
}