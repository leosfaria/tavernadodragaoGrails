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
                    <label for="imageFile" class="col-lg-3 control-label">Character Image:</label>
                    <div class="col-lg-5">
                        <input type="file" id="imageFile" name="imageFile" multiple class="fileInputBtn">
                        <a href="javascript:void(0);" class="btn btn-primary" id="imageAddBtn">Add File</a>
                        <div id="formatError" style="display: none;">
                            <span style="color: #ff0000">* Formato inválido</span>
                        </div>
                        <div id="imagePreview">
                            <a rel="fancybox-thumb" href="#">
                                <img id="image" src="#" alt="your image" class="previewImages" />
                            </a>
                        </div>
                    </div>
                </div>
                <div id="imagePreviewBox"></div>
                <div class="form-group">
                    <label for="sheet" class="col-lg-3 control-label">CharacterSheet:</label>
                    <div class="col-lg-5">
                        <g:textArea name="sheet" rows="30" cols="80" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-6 col-lg-offset-3">
                        <input type="button" class="btn btn-default" value="Cancel" onclick="window.location='/tavernadodragaoGrails/';" />
                        <g:submitButton name="submit" value="Save" class="btn btn-primary" />
                    </div>
                </div>
            </fieldset>
        </g:form>
    </div>
</body>
</html>