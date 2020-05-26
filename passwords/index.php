<!DOCTYPE html>
<html>
    <head>
        <style>
            table, th, td {
            border: 1px solid black;
            }
        </style>
    </head>
  <body>
    <p><a href="/Roloflex">Home</a></p>
    <!-- <p><a href="/">Home</a></p> -->
    <?php
        include '../functions/GetEnvVar.php';
        $GLOBALS['XMLReader'] = simplexml_load_string($_SESSION['XMLReader-String']);
        $GLOBALS['Env'] = simplexml_load_string($_SESSION['Env-String']);
        
        $creds = GetCorrectEnvironment($GLOBALS['Env']->Environment);
        $servername = $creds->Servername;
        $username = $creds->Username;
        $password = $creds->Password;
        $dbname = $creds->Database;
        
        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);
        // Check connection
        if ($conn->connect_error) 
        {
          die("Connection failed: " . $conn->connect_error);
        }
        
        $sql = "select * from passwords";
        $result = $conn->query($sql);
        
        echo "<table style=\"width:100%\">";
        echo "<tr><th>Description</th><th>Password</th></tr>";
            if ($result->num_rows > 0) 
            {
                // output data of each row
                while($row = $result->fetch_assoc()) 
                {
                    echo "<tr>";
                    echo "<td>" . $row['Description'] . "</td>";
                    echo "<td>" . $row['Value'] . "</td>";
                    echo "</tr>";
                }
            } 
            else 
            {
                echo "0 results";
            }
            $conn->close();
        echo "</table>";
    ?>
  </body>
</html>
