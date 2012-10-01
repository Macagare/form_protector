<html>
<head>
    <title>Test Form</title>
</head>
<body>
<cfscript>
protector = createObject("component", "cfc.de.cmd.protector.Protector").init();
captchaParams = protector.getCaptchaParams();
</cfscript>

<form name="exampleform" id="exampleform" enctype="application/x-www-form-urlencoded" action="action.cfm" method="post">
    <table>
        <tr>
            <td><label for="Title"><span>Anrede*</span></label></td>
            <td>
                <select name="Title" id="Title">
                    <option value="">Bitte ausw&auml;hlen</option>
                    <option value="Frau">Frau</option>
                    <option value="Herr">Herr</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>
                <label for="firstname"><span>Vorname*</span></label>
            </td>
            <td>
                <input size="15" type="text" name="firstname" id="firstname" value="">
            </td>
        </tr>
        <tr>
            <td>
                <label for="lastname"><span>Nachname*</span></label>
            </td>
            <td>
                <input size="15" type="text" name="lastname" id="lastname" value="">
            </td>
        </tr>
        <tr>
            <td>
                <label for="firma"><span>Firma</span></label>
            </td>
            <td>
                <input size="15" type="text" name="firma" id="firma" value="">
            </td>
        </tr>
        <tr>
            <td>
                <label for="address"><span>Strasse und Hausnummer*</span></label>
            </td>
            <td>
                <input size="15" type="text" name="address" id="address" value="">
            </td>
        </tr>
        <tr>
            <td>
                <label for="zip"><span>PLZ*</span></label>
            </td>
            <td>
                <input size="15" type="text" name="zip" id="zip" value="">
            </td>
        </tr>
        <tr>
            <td>
                <label for="city"><span>Ort*</span></label>
            </td>
            <td>
                <input size="15" type="text" name="city" id="city" value="">
            </td>
        </tr>
        <tr>
            <td>
                <label for="country"><span>Land*</span></label>
            </td>
            <td>
                <select name="country" id="country" class="required 0">
                    <option value="">W&auml;hlen Sie</option>
                    <option value="DE" selected="selected">Deutschland</option>
                    <option value="AT">&Ouml;sterreich</option>
                    <option value="FR">Frankreich</option>
                    <option value="IT">Italien</option>
                    <option value="US">USA</option>
                    <option value="NL">Niederlande</option>
                    <option value="GB">Vereinigtes K&ouml;nigreich</option>
                    <option value="ES">Spanien</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>
                <label for="email"><span>E-Mail*</span></label>
            </td>
            <td>
                <input size="15" type="text" name="email" id="email" class="required email" value="">
            </td>
        </tr>
        <tr>
            <td>
                <cfimage action="captcha" fontSize="#captchaParams.size#" width="#captchaParams.width#" height="#captchaParams.height#" text="#captchaParams.text#" fonts="captchaParams.font" />
            </td>
            <td>
                <input size="15" type="text" name="captcha" id="captcha" value="">
            </td>
        </tr>
        <tr>
            <td>
                <input type="submit" value="Submit" name="submit">
                <input type="button" name="submit_hidden" disabled="" style="display:none" value="Please wait . . .">
            </td>
        </tr>        
    </table>
</form>

</body>
</html>