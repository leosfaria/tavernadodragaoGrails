<div class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <g:link controller="user" action="home" class="navbar-brand">Taverna do Dragao</g:link>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">
            <ul class="nav navbar-nav">
                <g:if test="${charactersheet}">
                    <g:render template="../menu/characters" model="[userInstance: userInstance, newCharacter: newCharacter]" />
                </g:if>
                <g:if test="${search}">
                    <li class="homeMenuSearch">
                        <input type="text" id="search" name="search" placeholder="Busca">
                    </li>
                </g:if>
                <g:if test="${news}">
                    <g:render template="../menu/news" model="[userInstance: userInstance]" />
                </g:if>
                <li>
                    <g:link controller='logout'>Logout</g:link>
                </li>
            </ul>
        </div>
    </div>
</div>