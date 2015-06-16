<?php
 
/*
Change all $_POST to $_GET, should be as simple as that.
*/
$debug = 1;
//////////  FILL IN THIS INFORMATION HERE! ////////////
//variables unique to my DB
  $host = "mysql5.cws.oregonstate.edu"; //hostname is usually localhost by default
  $user = "cw_61398_web"; //insert the name of the user here
  $pass = "SiHu2bDP";  //insert the password here
  $database = "cw_61398";  //insert name of database wherein table was exported
////////////////////////////////////////////////////////

/****************************************************************************************** 	
***	SET DATE*** date

	CASE: 			Set the date for the term
	REQUIREMENTS:	onidID - (varchar), date
	DESCRIPTION:	automatic function---- use warrens trick for term dates
******************************************************************************************/
if(isset($_GET['onidID']) && isset($_GET['fname']) && isset($_GET['lname']) )
{		
	$linkID = mysql_connect($host,$user,$pass) or die("Could not connect to host.");
	mysql_select_db($database, $linkID) or die("Could not find database.");
	$onidID = $_GET['onidID'];
	$fname = $_GET['fname'];
	$lname = $_GET['lname'];
	$table = "temp";
	$query = "INSERT INTO $table (user_email, user_fname, user_lname) VALUES
				('$onidID', '$fname', '$lname')"; 
	$result = mysql_query($query) or die("Unable to complete newUser query");
	if($debug)
		echo 1;
}

/****************************************************************************************** 	
***	SET SPHERE *** X, Y, Z, date

	CASE: 			Set spherex,y,z in data table - referenced by onidID
	REQUIREMENTS:	onidID - (varchar), sphereX - (float), sphereY - (float), sphereZ - (float)
	DESCRIPTION:	Given an onidID store spherex, y and z. 
******************************************************************************************/

/****************************************************************************************** 	
***	GET SPHERE *** X, Y, Z, date

	CASE: 			Get spherex,y,z in data table - referenced by onidID
	REQUIREMENTS:	onidID - (varchar), sphereX - (float), sphereY - (float), sphereZ - (float)
	DESCRIPTION:	Given an onidID return spherex, y and z. 
******************************************************************************************/


/****************************************************************************************** 	
***	GET ALL SPHERES *** table return, date

	CASE: 			return class spheres
	REQUIREMENTS:	date range for class
	DESCRIPTION:	Given a date range, search table and return all coordinates within the
			range. 
******************************************************************************************/

/****************************************************************************************** 	
***	GET ALL PARTICIPANTS *** onidID, date

	CASE: 			if onidID matches allowed onidID return table of participating onidID's
	REQUIREMENTS:	date range - (date), onidID - (varchar)
	DESCRIPTION:	Given an onidID if it matches the allowed onidID return all participants
			for the current term range. 
******************************************************************************************/

/****************************************************************************************** 	
***	SET MASTER ONIDID *** onidID, code

	CASE: 			if code is correct add the current onidID
	REQUIREMENTS:	code - (undecided), onidID - (varchar)
	DESCRIPTION:	if the code matches the code we setup as something to look at then
			add the onidID to a table of allowed onidID's to look at participant 
			list else throw an errar saying the user could not be added as a master. 
******************************************************************************************/



?>