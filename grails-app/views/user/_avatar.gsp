<div>
    <g:link controller="user" action="${action}" class="colorBlack">
        <img src="${createLink(controller: 'user', action: 'imageAvatar', params: [id: userInstance?.id])}" />
    </g:link>
</div>
<div>
    <g:link controller="user" action="${action}" class="colorBlack">
        <label>${userInstance?.username}</label>
    </g:link>
</div>