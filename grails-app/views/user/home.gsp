<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Taverna</title>
    <asset:javascript src="home.js"/>
</head>
<body>
<div>
    <!------------  Menu    ------------->
    <div class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <g:link action="home" class="navbar-brand">Taverna do Dragao</g:link>
            </div>
            <div class="navbar-collapse collapse" id="navbar-main">
                <ul class="nav navbar-nav">
                    <li id="menuCharacters" class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="menuCharLink" aria-expanded="false">Characters <span class="caret"></span></a>
                        <ul class="dropdown-menu" aria-labelledby="themes">
                            <li><a href="../default/">New Character</a></li>
                            <li class="divider"></li>
                            <li><a href="../cosmo/">Cosmo</a></li>
                            <li><a href="../cyborg/">Cyborg</a></li>
                            <li><a href="../lumen/">Lumen</a></li>
                            <li><a href="../sandstone/">Sandstone</a></li>
                            <li><a href="../superhero/">Superhero</a></li>
                            <li><a href="../yeti/">Yeti</a></li>
                        </ul>
                    </li>
                    <li class="homeMenuSearch">
                        <input type="text" id="search" name="search" placeholder="Busca">
                    </li>
                    <li id="news" class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="newsLink" aria-expanded="false">News <span class="caret"></span></a>
                        <ul class="dropdown-menu news" aria-labelledby="themes">
                            <g:if test="${!userInstance.friendRequests?.isEmpty()}">
                                <g:each in="${userInstance.friendRequests}" var="friend">
                                    <li>
                                        <img src="${createLink(controller: 'user', action: 'imageAvatar', params: [id: friend.id])}" />
                                        <label>You receive a friend request!</label>
                                        <label>${friend.username}</label>
                                        <a href="${createLink(controller: 'user', action: 'acceptFriend', params: [id: friend.id])}">Accept</a>
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
                    <li>
                        <g:link controller='logout'>Logout</g:link>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!------------  End Menu ------------->
    <!------------  Home    ------------->
    <div class="homeLeft">
        <g:render template="avatar" model="[userInstance: userInstance, action: 'edit']"/>
    </div>
    <div class="homeMiddle">
        <g:if test="${flash.messageType != null}">
            <div class="${flash.messageType}">
                <g:each in="${flash.message.split(';')}" var="messageCode">
                    <g:message code="${messageCode}" locale="pt_BR" /><br>
                </g:each>
            </div>
        </g:if>
        <label>Recent Activity</label>
    </div>
    <div class="homeRight">
        <label>Party</label><br/>
        <g:each in="${userInstance.friends}" var="friend">
            <g:render template="friend" model="[userInstance: friend]"/>
        </g:each>
        <label>Table</label>
    </div>
</div>
</body>
</html>