<?php
$con = mysql_connect("localhost","root","password");
	if (!$con) {
	die('Could not connect: ' . mysql_error());
	}

mysql_select_db("datalogger", $con);

$result = mysql_query("SELECT * FROM HomeDataLog order by eDate DESC LIMIT 1");
echo "<Data>";
while($row = mysql_fetch_array($result)) 
	{
	echo "<DataRow watertop=\"" . number_format($row['watertop'],2,'.','') . "\"";
	echo " waterbase=\"" . number_format($row['waterbase'],2,'.','') . "\"";
	echo " waterpanel=\"" . number_format($row['waterpanel'],2,'.','') . "\"";
	echo " hometemp=\"" . number_format($row['hometemp'],2,'.','') . "\"";
	echo " mainsc=\"" . number_format($row['mainsc'],2,'.','') . "\"";
	echo " solarc=\"" . number_format($row['solarc'],2,'.','') . "\"";
	echo " batteryv=\"" . number_format($row['batteryv'],2,'.','') . "\"";
	echo " inverterc=\"" . number_format($row['inverterc'],2,'.','') . "\"";
	echo " generalc=\"" . number_format($row['generalc'],2,'.','') . "\"";
	echo " pumprunning=\"" . number_format($row['pumprunning'],0,'.','') . "\"";
	//echo "/>";
	}


mysql_select_db("boilercontrol", $con);

$result = mysql_query("SELECT * FROM tblOverride");

while($row = mysql_fetch_array($result)) 
	{
	echo " cHotWater=\"" . number_format($row['cHotWater'],0,'.','') . "\"";
	echo " cHeating=\"" . number_format($row['cHeating'],0,'.','') . "\"";
	echo "/>";
	
	}
echo "</Data>";
mysql_close($con);


?>
