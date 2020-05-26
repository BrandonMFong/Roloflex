# Don't need
# Just import csv from phpmyadmin

# https://vwiki.co.uk/MySQL_and_PowerShell

$null = [System.Reflection.Assembly]::LoadWithPartialName('MySql.Data');
$myconnection = New-Object MySql.Data.MySqlClient.MySqlConnection
$myconnection.ConnectionString = "server=localhost;user id=root;password=;database=roloflex;pooling=false";
# $myconnection.Open()
# $mycommand = $myconnection.CreateCommand();

$CSVFile = Import-Csv $PSScriptRoot\..\imports\Export5132020.csv;
# $mycommand.Parameters.AddWithValue("@val", "(SELECT EXISTS (SELECT 1 FROM contacts))");
# $mycommand.Parameters.AddWithValue("@MaxID", "(select id+1 from contacts)");
# foreach($row in $CSVFile)
for([int]$i = 0;$i -lt $CSVFile.Length;$i++)
{
    $myconnection.Open()
    $mycommand = $myconnection.CreateCommand();
    $mycommand.CommandText = "(SELECT EXISTS (SELECT 1 FROM contacts))";
    $val = $mycommand.ExecuteReader();
    [string]$valstring = $val.FieldCount.ToString();
    $mycommand.Dispose();
    $myconnection.Close();  

    $myconnection.Open()
    $mycommand = $myconnection.CreateCommand();
    $mycommand.CommandText = "select id+1 from contacts";
    $MaxID = $mycommand.ExecuteReader();
    [string]$MaxIDString = $MaxID.FieldCount.ToString();
    $mycommand.Dispose();
    $myconnection.Close();  

    $myconnection.Open()
    $mycommand = $myconnection.CreateCommand();
    [string]$querystring = "insert into contacts values ((SELECT IF($($valstring)=0, 1, $($MaxIDString))), uuid(), '$($CSVFile[$i].FirstName)', '$($CSVFile[$i].LastName)', '$($CSVFile[$i].Email)', '$($CSVFile[$i].Phone)');";    
    $mycommand.CommandText = $querystring;
    # something is probably wrong with the query I am passing
    # the query works from the gui but not through here
    $mycommand.ExecuteNonQuery(); # Execute command
    $mycommand.Dispose();
    $myconnection.Close();  
}

# $myconnection.Close();