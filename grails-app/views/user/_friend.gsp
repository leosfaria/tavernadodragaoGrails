<div class="friend">
    <div>
        <g:link action="viewDoCara" class="colorBlack">
            <img src="${createLink(controller: 'user', action: 'imageAvatar', params: [id: userInstance?.id])}" />
        </g:link>
    </div>
    <div>
        <g:link action="viewDoCara" class="colorBlack">
            <label>${userInstance?.username}</label>
        </g:link>
    </div>
</div>