<li id="menuCharacters" class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="menuCharLink" aria-expanded="false">Characters <span class="caret"></span></a>
    <ul class="dropdown-menu" aria-labelledby="themes">
        <g:if test="${newCharacter}">
            <li>
                <g:link controller="characterSheet" action="create">
                    New Character
                </g:link>
            </li>
            <li class="divider"></li>
        </g:if>
        <li><a href="../cosmo/">Cosmo</a></li>
        <li><a href="../cyborg/">Cyborg</a></li>
        <li><a href="../lumen/">Lumen</a></li>
        <li><a href="../sandstone/">Sandstone</a></li>
        <li><a href="../superhero/">Superhero</a></li>
        <li><a href="../yeti/">Yeti</a></li>
    </ul>
</li>