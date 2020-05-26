<?php 
    session_start();

    $GLOBALS['XMLReader'] = simplexml_load_string($_SESSION['XMLReader-String']);
    $GLOBALS['Env'] = simplexml_load_string($_SESSION['Env-String']);

    function GetCorrectEnvironment(string $ConfigEnv)
    {
        $val = 0;
        foreach($GLOBALS['XMLReader']->Variables->Variable as $cred)
        {
            if($ConfigEnv == $cred['Environment']){$val = $cred;}
        }
        return $val;
    }
?>