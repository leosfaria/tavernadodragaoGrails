<li id="news" class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="newsLink" aria-expanded="false">News <span class="caret"></span></a>
    <ul class="dropdown-menu news" aria-labelledby="themes">
        <g:if test="${!userInstance.friendRequests?.isEmpty()}">
            <h3 class="section-name">You receive a friend request!</h3>
            <g:each in="${userInstance.friendRequests}" var="friend">
                <li>
                    <img class="img-user" src="${createLink(controller: 'user', action: 'imageAvatar', params: [id: friend.id])}" />
                    <div class="container-accept">
                        <span class="user-name">${friend.username}</span>
                        <a class="btn btn-success btn-xs btn-accept" href="${createLink(controller: 'user', action: 'acceptFriend', params: [friendId: friend.id])}">Accept</a>
                        <a class="btn btn-danger btn-xs btn-decline" href="${createLink(controller: 'user', action: 'declineFriend', params: [friendId: friend.id])}">Decline</a>
                    </div>
                </li>
            </g:each>
        </g:if>
        <g:else>
            <li>
                <label>Nothing to show</label>
            </li>
        </g:else>
    </ul>
</li>