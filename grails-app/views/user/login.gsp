<%--
  Created by IntelliJ IDEA.
  User: Leonardo
  Date: 09/03/2015
  Time: 17:19
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Login</title>
</head>

<body>
<g:if test="${flash.message}">
    ${flash.message}
</g:if>
<div style="width: 50%; margin: 0 auto;">
    <div>
        <g:form action="${createLink(uri: '/j_spring_security_check')}">
            <fieldset>
                <div class="form-group">
                    <label for="username" class="col-lg-2 control-label">Username</label>
                    <div class="col-lg-8">
                        <input type="text" class="form-control" id="username" name="username" placeholder="Username">
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-lg-2 control-label">Password</label>
                    <div class="col-lg-8">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-2">
                        <g:submitButton name="submit" value="Login" class="btn btn-primary" />
                    </div>
                </div>
            </fieldset>
        </g:form>
    </div>
    <div>
        Not a menber yet? <g:link action="signUp">Sign up here</g:link>
    </div>
</div>
</body>
</html>