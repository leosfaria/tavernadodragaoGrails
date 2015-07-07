<%--
  Created by IntelliJ IDEA.
  User: Leonardo
  Date: 11/04/2015
  Time: 19:29
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Taverna</title>
</head>
<body>
<div>
    <g:render template="../menu/menu" model="[userInstance: userInstance]" />

    <!------------  Home    ------------->
    <div class="homeLeft">
        <g:render template="avatar" model="[userInstance: userInstance, action: 'home']"/>
    </div>
    <div class="homeMiddle">
        <g:render template="../systemMessage" />

        <g:form controller="user" action="update" enctype="multipart/form-data" class="form-horizontal">
            <fieldset>
                <legend>Edit Profile</legend>
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
                    <label for="username" class="col-lg-3 control-label">Username:</label>
                    <div class="col-lg-5">
                        <input type="text" class="form-control" id="username" name="username" placeholder="Username" value="${userInstance?.username}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-lg-3 control-label">Password:</label>
                    <div class="col-lg-5">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" value="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="newPassword" class="col-lg-3 control-label">New Password:</label>
                    <div class="col-lg-5">
                        <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="New Password" value="">
                    </div>
                </div>
                <div class="form-group">
                    <label for="confirmNewPassword" class="col-lg-3 control-label">Confirm New Password:</label>
                    <div class="col-lg-5">
                        <input type="password" class="form-control" id="confirmNewPassword" name="confirmNewPassword" placeholder="Confirm New Password" value="">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-6">
                        <g:submitButton name="submit" value="Save" class="btn btn-primary" />
                    </div>
                </div>
            </fieldset>
        </g:form>
    </div>
    <div class="homeRight">
    </div>
</div>
</body>
</html>