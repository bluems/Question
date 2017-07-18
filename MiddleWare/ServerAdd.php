<?php
	//DB Add

class DBConn {
	const db_id = "question";
	const db_pw = "questksac@";


	function Add($AdminName, $ip, $Port, $Room)
	{
		$dsn = "mysql:host=localhost;port=3306;dbname=question;charset=utf8";
		$query = "INSERT INTO ";

		try {
			$db = new PDO($dsn, DBConn::db_id, DBConn::db_pw);
			$db -> setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
			$db -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$stmt = $db -> prepare($query);
			$stmt -> bindParam(':ip', $ip);
			$stmt -> bindParam(':port', $port);
			$stmt -> bindParam(':adminName', $AdminName);
			$stmt -> bindParam(':room', $Room);
			$stmt -> execute();
		} catch (PDOException $e) {
			echo $e -> getMessage();
		}
	}

	function Check($AdminName, $Room) {
		$dsn = "mysql:host=localhost;port=3306;dbname=question;charset=utf8";
		$query = "select * from server where room=:room and name=:adminName";

		try {
			$db = new PDO($dsn, DBConn::db_id, DBConn::db_pw);
			$db -> setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
			$db -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$stmt = $db -> prepare($query);
			$stmt -> bindParam(':adminName', $AdminName);
			$stmt -> bindParam(':room', $Room);
			$stmt -> execute();
			$result = $stmt -> fetch();
			//print_r($result);
			echo $result['name']
			if ($result['name'] === $AdminName || $result['room'] === $Room)
				return true;
			else
				return false;
		} catch (PDOException $e) {
			echo $e -> getMEssage();
			return false;
		}
	}
}
	$DBConn = new DBConn();

	//변수 체크
	if (isset($_GET['adminname']))
		$AdminName = utf8_encode($_GET['adminname']);
	if (isset($_GET['port'])) {
		$Port = $_GET['port'];	
	}
	if (isset($_GET['room'])) {
		$Room = utf8_encode($_GET['room']);
	}
	
	if ($DBConn->Check($AdminName,$Room)) {
		echo "true";
	}
	else {
		echo "false";
	}

?>