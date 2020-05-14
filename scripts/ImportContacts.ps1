$null = [System.Reflection.Assembly]::LoadWithPartialName('MySql.Data');
$myconnection = New-Object MySql.Data.MySqlClient.MySqlConnection
$myconnection.ConnectionString = "server=localhost;user id=root;password=;database=roloflex;pooling=false";
$myconnection.Open()
$mycommand = New-Object MySql.Data.MySqlClient.MySqlCommand
$mycommand.Connection = $myconnection


$CSVFile = Import-Csv $PSScriptRoot\..\imports\Export5132020.csv;
foreach($row in $CSVFile)
{
    $querystring =
    "
        set @val = (SELECT EXISTS (SELECT 1 FROM contacts));
        set @id = (SELECT IF(@val=0, 1, (select id+1 from contacts)));
        insert into contacts values (@id, uuid(), '$($row.FirstName)', '$($row.LastName)', '$($row.Email)', '$($row.Phone)');
    ";
    $mycommand.CommandText = $querystring;
    $myreader = $mycommand.ExecuteReader();
    while($myreader.Read()){ $myreader.GetString(0); }
}

$myconnection.Close()