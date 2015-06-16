<?php
 
/*
Change all $_POST to $_GET, should be as simple as that.
*/
$debug = 1;
//////////  FILL IN THIS INFORMATION HERE! ////////////
//variables unique to my DB
  $host = "mysql5.cws.oregonstate.edu"; //hostname is usually localhost by default
  $user = "cw_61989_web"; //insert the name of the user here
  $pass = "kLTTYXSi";  //insert the password here
  $database = "cw_61989";  //insert name of database wherein table was exported
  $table = "hdfs313_class";
////////////////////////////////////////////////////////





/****************************************************************************************** 	
	ADD USER ***	tile,year, term

	CASE: 			Create entry for new user
	REQUIREMENTS:	tile - (varchar placement of character), year - (varchar current year), term - (varchar current term)
	DESCRIPTION:	Stores the current users spot on the gameboard with the current year and term
******************************************************************************************/



if(isset($_GET['tile']) && isset($_GET['year']) && isset($_GET['term']))
{		
	$linkID = mysql_connect($host,$user,$pass) or die("Could not connect to host.");
	mysql_select_db($database, $linkID) or die("Could not find database.");
	$tile = $_GET['tile'];
	$today = date("Y-m-d");
	$year = $_GET['year'];
	$term = $_GET['term'];

	$query = "INSERT INTO $table (tile,date,year,term) VALUES
				('$tile','$today','$year','$term')"; 
	$result = mysql_query($query) or die("Unable to complete newUser query");
	if($debug)
		echo 1;
}


/****************************************************************************************** 	
***	Get User Positions ***	ID, year,term

	CASE: 			Select all data for a given date range, adding later
	REQUIREMENTS:	ID - (int of any value), year - (varchar current year), term - (varchar current term)
	DESCRIPTION:	Given an ID, year, term return an array of all possible data.
******************************************************************************************/


 else if(isset($_GET['ID']) && isset($_GET['year']) && isset($_GET['term']))
{

	$ID = $_GET['ID'];
	$year = $_GET['year'];
	$term = $_GET['term'];

	$linkID = mysql_connect($host,$user,$pass) or die("Could not connect to host.");
	mysql_select_db($database, $linkID) or die("Could not find database.");
				
	$q1 = 	"SELECT tile FROM $table WHERE year='$year' AND term='$term'";
				
	$r1 = mysql_query($q1) or die("select data from DB failed");
	//$temp =  mysql_fetch_row($r1);

	while($temp =  mysql_fetch_array($r1))
			{
				echo $temp[0];
				echo ",";
			}

}


?>