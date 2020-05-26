<?php

  session_start();
      
  // Load xml
  $_SESSION['XMLReader-String'] = file_get_contents("config/Application.xml") or die("Failed to load");
  $_SESSION['Env-String'] = file_get_contents("config/Env.xml") or die("Failed to load");

?>

<!DOCTYPE html>
<html>
  <body style="text-align: center;">
    <h2><a href="contacts/">Contacts</a></h2>
    <h2><a href="passwords/">Passwords</a></h2>
  </body>
</html>
