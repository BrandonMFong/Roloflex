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
    <?php
        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "roloflex";
        
        // Create connection
        $conn = new mysqli($servername, $username, $password, $dbname);
        // Check connection
        if ($conn->connect_error) 
        {
          die("Connection failed: " . $conn->connect_error);
        }
        
        $sql = "SELECT Firstname, Lastname, Email, Phonenumber FROM Contacts";
        $result = $conn->query($sql);
        
        echo "<table style=\"width:100%\">";
        echo "<tr><th>Firstname</th><th>Lastname</th><th>Email</th><th>Phonenumber</th></tr>";
            if ($result->num_rows > 0) 
            {
                // output data of each row
                while($row = $result->fetch_assoc()) 
                {
                    echo "<tr>";
                    echo "<td>" . $row['Firstname'] . "</td>";
                    echo "<td>" . $row['Lastname'] . "</td>";
                    echo "<td>" . $row['Email'] . "</td>";
                    echo "<td>" . $row['Phonenumber'] . "</td>";
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
