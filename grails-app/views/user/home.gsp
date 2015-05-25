<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Taverna</title>
    <asset:javascript src="home.js"/>
</head>
<body>
<div>
    <g:render template="../menu/menu" model="[userInstance: userInstance, charactersheet: true, search: true, news: true, newCharacter: true]" />

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