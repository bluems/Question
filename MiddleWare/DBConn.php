<?php
require_once("ErrorLog.php");
require_once("SuccessLog.php");
//DB Add
	class DBConnClassConn
	{
		public $ErrorLog, $SuccessLog;
		function __construct()
		{
			$this -> ErrorLog = new ErrorLog();
			$this -> SuccessLog = new SuccessLog();
		}
	}

	class DBConn extends DBConnClassConn { // DB 접속 클래스
		const db_id = "question"; // DB 계정명
		const db_pw = "quest0507&"; // DB 비밀번호
		const serverTable = "server"; //DB 테이블

		// DB 접속 설정
		const dsn = "mysql:host=localhost;port=3306;dbname=question;charset=utf8";

		function __construct() {
			// 생성자
		}


		function Add($AdminName, $ip, $Port, $Room)
		{	//DB에 정보 추가 
			$query = "INSERT INTO `".self::serverTable."` (`num`, `room`, `name`, `ip`, `port`) VALUES (NULL, '".$Room."', '".$AdminName."', '".$ip."', '".$Port."')";

			try {
				$db = new PDO(self::dsn, self::db_id, self::db_pw);
				$db -> setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
				$db -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
				$stmt = $db -> prepare($query);
				$stmt -> bindParam(':ip', $ip);
				$stmt -> bindParam(':port', $port);
				$stmt -> bindParam(':adminName', $AdminName);
				$stmt -> bindParam(':room', $Room);
				$stmt -> execute();
			} catch (PDOException $e) {
				//echo $e -> getMessage();
				$this -> ErrorLog -> Add("Add", $e -> getMessage());
			}
		}

		function Check($AdminName, $Room) {
			// DB에 정보 유무 체크
			$query = "select * from server where room=:room and name=:adminName";


			try {
				$db = new PDO(self::dsn, self::db_id, self::db_pw);
				$db -> setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
				$db -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
				$stmt = $db -> prepare($query);
				$stmt -> bindParam(':adminName', $AdminName);
				$stmt -> bindParam(':room', $Room);
				$stmt -> execute();
				$result = $stmt -> fetch();

				if ($result['name'] === $AdminName || $result['room'] === $Room)
					return true;
				else
					return false;
			} catch (PDOException $e) {
				$this -> ErrorLog -> Add("Add", $e -> getMessage());
				return false;
			}
		}

		function Update($AdminName, $ip, $Port, $Room) {
			// DB에 정보 최신화 갱신
			$query = "UPDATE `".self::serverTable."` SET `ip` = '".$ip."', `port` = ".$Port." WHERE `name` = '".$AdminName."' and `room` = '".$Room."'";

			try {
				$db = new PDO(self::dsn, self::db_id, self::db_pw);
				$db -> setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
				$db -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
				$stmt = $db -> prepare($query);
				$stmt -> bindParam(':adminName', $AdminName);
				$stmt -> bindParam(':ip', $ip);
				$stmt -> bindParam(':port', $Port);
				$stmt -> bindParam(':room', $Room);
				$stmt -> execute();
				$result = $stmt -> fetch();
				return true;
			} catch (PDOException $e) {
				$this -> ErrorLog -> Add("Add", $e -> getMessage());
				return false;
			}
		}
	}
?>