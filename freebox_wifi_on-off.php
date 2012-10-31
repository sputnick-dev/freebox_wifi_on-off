<!DOCTYPE html>
<meta http-equiv="content-language" content="fr, en">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<style type="text/css">
  body {
	background-color: black;
	color:white;
	font: 32px Arial, Helvetica, sans-serif;
	}
    h1 {
	background-color: black;
	color:red;
	font: 52px Arial, Helvetica, sans-serif;
	}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Wifi switch</title>
</head>
<body>
<?php
if (isset($_REQUEST['mode'])) {
	$mode = $_REQUEST['mode'];
	echo "Sending mode $mode";
    if ($mode == 'status') { echo "<h1>status"; }
	system("/usr/bin/perl /home/sputnick/repository/perl/free-wifi_on-off.pl $mode 2>&1");
    if ($mode == 'status') { echo "</h1> "; }
}
else echo("Usage:<br>http://{$_SERVER['HTTP_HOST']}{$_SERVER['REQUEST_URI']}?mode=on<br>http://{$_SERVER['HTTP_HOST']}{$_SERVER['REQUEST_URI']}?mode=off<br>http://{$_SERVER['HTTP_HOST']}{$_SERVER['REQUEST_URI']}?mode=status");
?>
</body>
</html>
