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
        <g:each in="${userInstance.characterSheets}" var="characterSheet">
            <li>
                <g:link controller="characterSheet" action="edit" params="[characterId: characterSheet.id]">${characterSheet.name}</g:link>
            </li>
        </g:each>
    </ul>
</li>