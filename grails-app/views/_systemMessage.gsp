<g:if test="${flash.messageType != null}">
    <div class="${flash.messageType == 'error'?'alert alert-danger error':'alert alert-success success'} alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <g:each in="${flash.message.split(';')}" var="messageCode">
            <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
            <g:message code="${messageCode}" locale="pt_BR" /><br>
        </g:each>
    </div>
</g:if>