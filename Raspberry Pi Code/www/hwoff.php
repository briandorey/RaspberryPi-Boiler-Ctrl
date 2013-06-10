<?php
error_reporting(E_ALL);
ini_set('display_errors', '1');
include("php_serial.class.php");

$serial = new phpSerial();
$serial->deviceSet("/dev/ttyAMA0");

$serial->confBaudRate(9600); //Baud rate: 9600
$serial->confParity("none"); //Parity (this is the "N" in "8-N-1")
$serial->confCharacterLength(8); //Character length (this is the "8" in "8-N-1")
$serial->confStopBits(1); //Stop bits (this is the "1" in "8-N-1")
$serial->confFlowControl("none"); //Device does not support flow control of any kind, so set it to none.


$serial->deviceOpen();

$serial->sendMessage("i\r" );

$serial->deviceClose();


$dbhost = 'localhost';
$dbuser = 'root';
$dbpass = 'password';
$conn = mysql_connect($dbhost, $dbuser, $dbpass);
if (! $conn) {
	die('Cound not connect: ' .mysql_error());
}

$sql = 'UPDATE tblOverride set cHotWater = 0 where pkey = 1';


mysql_select_db('boilercontrol');
$retval = mysql_query( $sql, $conn);
if (! $retval) {
	die('Update failed');
}
echo "Updated successfully";
//cHotWater
//cHeating

mysql_close();


?>
