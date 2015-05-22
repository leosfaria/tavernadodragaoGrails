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
                        <g:form controller="search" action="search">
                            <input type="text" id="query" name="query" placeholder="Busca">
                        </g:form>
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
        <label>Recent Activity</label>
    </div>
    <div class="homeRight">
        <label>Party</label><br/>
        <label>Table</label>
    </div>
</div>
</body>
</html>