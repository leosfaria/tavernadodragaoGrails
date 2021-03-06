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
<!------------  Menu    ------------->
<div class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a href="/" class="navbar-brand">Taverna do Dragao</a>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">
            <form action="${postUrl}" method="POST">
                <label>Email:</label>
                <input type="text" class="form-control authNavbarImput" id="username" name="j_username" placeholder="Email">
                <label>Password:</label>
                <input type="password" class="form-control authNavbarImput" id="password" name="j_password" placeholder="Password">
                <g:submitButton name="submit" value="Login" class="btn btn-primary" />
            </form>
        </div>
    </div>
</div>
<!------------  End Menu ------------->
<g:render template="../systemMessage" />

<div class="signUp">
    <g:form controller="user" action="save" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
            <legend>Sign Up</legend>
            <div class="form-group">
                <label for="password" class="col-lg-3 control-label">Upload Photo:</label>
                <div class="col-lg-5">
                    <input type="file" id="imageFile" name="imageFile" class="fileInputBtn">
                    <a href="javascript:void(0);" class="btn btn-primary" id="imageAddBtn">Select File</a>
                    <div id="formatError" style="display: none;">
                        <span style="color: #ff0000">* Formato inválido</span>
                    </div>
                    <div id="imagePreview" class="imagePreview">
                        <img id="image" src="#" alt="your image" class="previewAvatar" />
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="username" class="col-lg-3 control-label">Username</label>
                <div class="col-lg-5">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Username" value="${userInstance?.username}">
                </div>
                <span>*</span>
            </div>
            <div class="form-group">
                <label for="email" class="col-lg-3 control-label">Email</label>
                <div class="col-lg-5">
                    <input type="text" class="form-control" id="email" name="email" placeholder="Email" value="${userInstance?.email}">
                </div>
                <span>*</span>
            </div>
            <div class="form-group">
                <label for="password" class="col-lg-3 control-label">Password</label>
                <div class="col-lg-5">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" value="${userInstance?.password}">
                </div>
                <span>*</span>
            </div>
            <div class="form-group">
                <label for="confirmPassword" class="col-lg-3 control-label">Confirm Password</label>
                <div class="col-lg-5">
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" value="${userInstance?.confirmPassword}">
                </div>
                <span>*</span>
            </div>
            <div class="form-group">
                <div class="col-lg-10 col-lg-offset-4">
                    <input type="button" class="btn btn-default" value="Cancel" onclick="window.location='/tavernadodragaoGrails/user/login';" />
                    <g:submitButton name="submit" value="Save" class="btn btn-primary" />
                </div>
            </div>
        </fieldset>
    </g:form>

    <span>* Fields Required</span>
</div>
<!--script>
    $(function () {
        $('#fileupload').fileupload();
    });
</script-->
</body>
</html>