<%--
  Created by IntelliJ IDEA.
  User: Leonardo
  Date: 25/05/2015
  Time: 18:07
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Taverna</title>
</head>
<body>
    <g:render template="../menu/menu" model="[userInstance: userInstance, charactersheet: true]" />

    <div class="homeLeft">
        <g:render template="../user/avatar" model="[userInstance: userInstance, action: 'home']"/>
    </div>
</body>
</html>