<li id="menuCharacters" class="dropdown">
    <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="menuCharLink" aria-expanded="false">
        Characters
        <g:if test="${newCharacter || userInstance.characterSheets}">
            <span class="caret"></span>
        </g:if>
    </a>
    <g:if test="${newCharacter}">
        <ul class="dropdown-menu" aria-labelledby="themes">
            <li>
                <g:link controller="characterSheet" action="create">
                    New Character
                </g:link>
            </li>
            <g:if test="${userInstance.characterSheets}">
                <li class="divider"></li>
            </g:if>
            <g:each in="${userInstance.characterSheets}" var="characterSheet">
                <li>
                    <g:link controller="characterSheet" action="edit" params="[characterId: characterSheet.id]">${characterSheet.name}</g:link>
                </li>
            </g:each>
        </ul>
    </g:if>
    <g:else>
        <g:if test="${userInstance.characterSheets}">
            <ul class="dropdown-menu" aria-labelledby="themes">
                <g:each in="${userInstance.characterSheets}" var="characterSheet">
                    <li>
                        <g:link controller="characterSheet" action="edit" params="[characterId: characterSheet.id]">${characterSheet.name}</g:link>
                    </li>
                </g:each>
            </ul>
        </g:if>
    </g:else>
</li>