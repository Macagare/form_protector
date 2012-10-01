This is where the action comes!

<cfscript>
protector = createObject("component", "cfc.de.cmd.protector.Protector").init();
isValid = protector.checkAnswer( form.captcha );
</cfscript>

<cfif isValid >
    <cflocation url="complete.cfm" addtoken="false" />
<cfelse>
    <p>
    <b>Sorry, wrong imput.</b><br/>
    Don't use the back button. <a href="index.cfm">Go back to form</a>
    </p>
</cfif>
