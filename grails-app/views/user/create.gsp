<%--
  Created by IntelliJ IDEA.
  User: Leonardo
  Date: 13/03/2015
  Time: 22:51
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>New User</title>
</head>
<body>
<div style="color: #ff0000">
    <g:each in="${userInstance?.getErrors()?.fieldErrors}" var="error">
        ${error.defaultMessage}<br>
    </g:each>
</div>
<div style="width: 50%; margin: 0 auto;">
    <g:form action="save" class="form-horizontal">
        <fieldset>
            <legend>Sign Up</legend>
            <div class="form-group">
                <label for="username" class="col-lg-3 control-label">Username</label>
                <div class="col-lg-5">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Username">
                </div>
            </div>
            <div class="form-group">
                <label for="email" class="col-lg-3 control-label">Email</label>
                <div class="col-lg-5">
                    <input type="text" class="form-control" id="email" name="email" placeholder="Email">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-lg-3 control-label">Password</label>
                <div class="col-lg-5">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                </div>
            </div>
            <div class="form-group">
                <label for="confirmPassword" class="col-lg-3 control-label">Confirm Password</label>
                <div class="col-lg-5">
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password">
                </div>
            </div>
            <div class="form-group">
                <div class="col-lg-10 col-lg-offset-4">
                    <input type="button" class="btn btn-default" value="Cancel" onclick="window.location='/TavernaDoDragao/user/login';" />
                    <g:submitButton name="submit" value="Save" class="btn btn-primary" />
                </div>
            </div>
        </fieldset>
    </g:form>
</div>
</body>
</html>