package tavernadodragaograils

class User {

    String username
    String email
    String password
    String confirmPassword

    static transients = ['confirmPassword']

    static constraints = {
        username blank: false
        email blank: false
        password blank: false, minSize: 3
    }
}
