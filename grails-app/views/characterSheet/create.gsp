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
    <div class="homeMiddle">
        <g:render template="../systemMessage" />

        <g:form action="save" enctype="multipart/form-data" class="form-horizontal">
            <fieldset>
                <legend>Upload Character</legend>
                <div class="form-group">
                    <label for="name" class="col-lg-3 control-label">Name:</label>
                    <div class="col-lg-5">
                        <input type="text" class="form-control" id="name" name="name" placeholder="Character Name" value="${characterInstance?.name}">
                    </div>
                </div>
                <div class="form-group">
                    <label for="imageFile" class="col-lg-3 control-label">CharacterSheet:</label>
                    <div class="col-lg-2">
                        <input type="file" id="imageFile" name="imageFile" multiple class="fileInputBtn">
                        <a href="javascript:void(0);" class="btn btn-primary" id="imageAddBtn">Add File</a>
                        <div id="imagePreview">
                            <a rel="fancybox-thumb" href="#">
                                <img id="image" src="#" alt="your image" class="previewImages" />
                            </a>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-10 col-lg-offset-4">
                        <input type="button" class="btn btn-default" value="Cancel" onclick="window.location='/tavernadodragaoGrails/';" />
                        <g:submitButton name="submit" value="Save" class="btn btn-primary" />
                    </div>
                </div>
            </fieldset>
        </g:form>
    </div>
</body>
</html>