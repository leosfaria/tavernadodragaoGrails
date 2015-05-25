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

            if(user.friendRequests.contains(it)) {
                map.put('friendAccept', createLink(controller: 'user', action: 'acceptFriend', params: [friendId: it.id]))
                map.put('friendDecline', createLink(controller: 'user', action: 'declineFriend', params: [friendId: it.id]))
            } else if(it.friendRequests.contains(user)) {
                map.put('friendRequestSent', true)
            } else if(!user.friends.contains(it)) {
                map.put('friendAdd', createLink(controller: 'user', action: 'addFriend', params: [friendId: it.id]))
            }

            map
        }

        render text: users as JSON
    }
}
