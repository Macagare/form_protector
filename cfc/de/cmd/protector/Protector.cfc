/**
*
* @file cfc/de/cmd/protector/Protector.cfc
* @author Christian Mueller  
* @description Form submit protector against unwanted submits or spam.
*
*/

component output="false" displayname=""  {

    public function init(){
        return this;
    }


    public Struct function getCaptchaParams(param) {
        var captcha = {};

        captcha["text"]   = this.getQuestion();
        captcha["size"]   = 18;
        captcha["width"]  = 250;
        captcha["height"] = 30;
        captcha["font"]   = "Verdana,Arial,Courier New,Courier";

        return captcha;
    }
    

    private String function getQuestion(param) {
        /*
        ask for:
        - calculation
        - date or time
        - alphabet
        - general things, user can answer
        
        important:
        - must be save of history back!
        - short text
        */
        var random   = rand();
        var question = "";

        if( random lt 0.5 ){
            question = this.getCalcQuestion();
        } else {
            question = this.getWordQuestion();
        }

        session["capchaSolution"] = hash( question.answer, "SHA");
        return question.text;
    }


    public Boolean function checkAnswer(string answer = "") {
        if( structKeyExists(session, "capchaSolution") and len(session.capchaSolution) and session.capchaSolution eq hash( arguments.answer, "SHA") ) {
            session.capchaSolution = "";
            return true;
        }
        return false;
    }

    public Struct function getWordQuestion() {
        var question       = {};
        var baseword       ="LoremIpsum";
        question["answer"] = baseword;
        question["text"]   = baseword;
        var occurance      = javaCast("int", len(baseword) * 0.3 ); 
        for ( i = 1; i lte occurance; i = i + 1 ) {
            question["text"] = replaceAt(question["text"], javaCast("int", rand() * len(baseword) ), 1, "_" );
        }
        return question;
    }

    public Struct function getCalcQuestion() {
        var question       = {};
        var random         = rand();
        var calcResult     = 0;
        var calcPart1      = 0;
        var calcPart2      = 0;

        question["text"]   = "";
        question["answer"] = "";

        if(random lt 0.25) {
            // addition
            calcPart1        = javaCast("int", ( rand() * 20 ) + 1 );
            calcPart2        = javaCast("int", ( rand() * 20 ) + 1 );
            calcResult       = calcPart1 + calcPart2;
            question["text"] = question["text"] & calcPart1 & " + " & calcPart2;
        }elseif( random lt 0.5) {
            // substraction
            calcResult       = javaCast("int", rand() * 20 );
            calcPart1        = calcResult + javaCast("int", rand() * calcResult );
            calcPart2        = calcPart1 - calcResult;  
            question["text"] = question["text"] & calcPart1 & " - " & calcPart2;
        }elseif( random lt 0.75) {
            // multiplication
            calcPart1        = javaCast("int", ( rand() * 9 ) + 1 );
            calcPart2        = javaCast("int", ( rand() * 9 ) + 1 );
            calcResult       = calcPart1 * calcPart2;
            question["text"] = question["text"] & calcPart1 & " x " & calcPart2;
        } else {
            // division
            calcPart1        = javaCast("int", ( rand() * 6 ) + 1 );
            calcPart2        = javaCast("int", ( rand() * 6 ) + 1 );
            calcResult       = calcPart1 * calcPart2;
            question["text"] = question["text"] & calcResult & " / " & calcPart1;
            calcResult       = calcPart2;
        }

        question["answer"] = calcResult;
        question["text"]   = question["text"] & " = ?";
        return question;
    }


    private String function replaceAt(string source, numeric position, numeric count, string replaceContent) {
        if( arguments.position gt 0 and ( arguments.position + arguments.count lt len(arguments.source ) ) ){
            return left(arguments.source, position) & arguments.replaceContent &  right(arguments.source, len( arguments.source ) - ( arguments.position + arguments.count ) );
        }
        return arguments.source;
    }
    
    
    
    
}