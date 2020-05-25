# https://vwiki.co.uk/MySQL_and_PowerShell

$null = [System.Reflection.Assembly]::LoadWithPartialName('MySql.Data');
$myconnection = New-Object MySql.Data.MySqlClient.MySqlConnection
$myconnection.ConnectionString = "server=localhost;user id=root;password=;database=roloflex;pooling=false";
$myconnection.Open()
$mycommand = $myconnection.CreateCommand();

$CSVFile = Import-Csv $PSScriptRoot\..\imports\Export5132020.csv;
# foreach($row in $CSVFile)
for([int]$i = 0;$i -lt $CSVFile.Length;$i++)
{
    [string]$querystring = "insert into contacts values ((SELECT IF(@val=0, 1, (select id+1 from contacts))), uuid(), '$($CSVFile[$i].FirstName)', '$($CSVFile[$i].LastName)', '$($CSVFile[$i].Email)', '$($CSVFile[$i].Phone)');";
    
    $mycommand.CommandText = $querystring;
    $mycommand.Parameters.AddWithValue("@name", "(SELECT EXISTS (SELECT 1 FROM contacts))");
    # something is probably wrong with the query I am passing
    # the query works from the gui but not through here
    $mycommand.ExecuteNonQuery(); # Execute command
    $mycommand.Dispose()       
}

$myconnection.Close()