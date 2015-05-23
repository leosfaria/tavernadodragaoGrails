package tavernadodragaograils

import grails.converters.JSON

class SearchController {
    def springSecurityService

    def search() {
        User user = springSecurityService.currentUser

        def query = User.where {
            ne("id", "${user.id}")
            or {
                ilike('username', "%${params.q}%")
                ilike('email', "%${params.q}%")
            }
        }

        def users = query.list(max: 5, offset: 0).collect {
            def map = [id: it.id,
             value: it.username,
             img: createLink(controller: 'user', action: 'imageAvatar', params: [id: it.id])
            ]

            if(!user.friends.contains(it)) {
                map.put('friend', createLink(controller: 'user', action: 'addFriend', params: [id: it.id]))
            }

            map
        }

        render text: users as JSON
    }
}
