<?php
	//DB Add
	class DBConn { // DB 접속 클래스
		const db_id = "question"; // DB 계정명
		const db_pw = "questksac@"; // DB 비밀번호
		const serverTable = "server"; //DB 테이블

		// DB 접속 설정
		const dsn = "mysql:host=localhost;port=3306;dbname=question;charset=utf8";

		function __construct() {
			// 생성자
		}


		function Add($AdminName, $ip, $Port, $Room)
		{	//DB에 정보 추가 
			$query = "INSERT INTO ";

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
				echo $e -> getMessage();
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
				echo $e -> getMEssage();
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
				echo $e -> getMessage();
				return false;
			}
		}
	}

	class ErrorLog {

		var $ErrorList; // Error 목록 저장
		var $ErrorCount = 0; // Error 갯수 카운트

		function Add($ErrorCode, $ErrorString) {
			// Error 목록 추가
			$this->ErrorList['Error'][$this -> ErrorCount] = array('ErrorCode' => $ErrorCode,'ErrorString' => $ErrorString);
			$this->ErrorCount = $this->ErrorCount + 1;
		}

		function JSONToPrint() {
			//Error 목록 JSON 출력
			echo die(json_encode($this -> ErrorList));
		}
	}

	function main($ErrorLog){
		$DBConn = new DBConn();

		$AdminName = $_GET['adminname'];
		$Port = $_GET['port'];
		$Room = $_GET['room'];
		$ip = $_GET['ip'];
		//echo $Valued -> $adminname;

		if (isset($_GET['confirm'])){
			if(empty($_GET['confirm'])===false) {
				$ErrorLog -> Add("NoValue","confirm is not set");
			}
			$confirm = $_GET['confirm'];
		} else
		{
			$confirm = "0";
		}
		$ErrorLog -> JSONToPrint();

			//이미 있는지 체크
		if ($DBConn->Check($AdminName,$Room)) {
			//echo "true";
			//중복 확인
			if ($confirm === "0") {
				//재확인
				
			} else {
				//정보 갱신
				if ($DBConn->Update($AdminName, $ip, $Port, $Room)) {
					//true
					echo "false";
				}
			}

			

		} else
		{
			//echo "false";
			//정보 추가
			
		}
	}

	$ErrorLog = new ErrorLog();

	if (isset($_GET['adminname'])){
		if(empty($_GET['adminname'])) {
			$ErrorLog -> Add("NoValue","adminname is not set");
		}
	} else
	{
		$ErrorLog -> Add("UnDefined","Undefined variable: adminname");
	}

	if (isset($_GET['port'])) {
		if(empty($_GET['port'])) {
			$ErrorLog -> Add("NoValue","port is not set");
		}	
	} else
	{
		$ErrorLog -> Add("UnDefined","Undefined variable: port");
	}

	if (isset($_GET['room'])) {
		if(empty($_GET['room'])) {
			$ErrorLog -> Add("NoValue","room is not set");
		}
	} else
	{
		$ErrorLog -> Add("UnDefined","Undefined variable: room");
	}

	if (isset($_GET['ip'])) {
		if(empty($_GET['ip'])) {
			$ErrorLog -> Add("NoValue","ip is not set");
		} 
	} else
	{
		$ErrorLog -> Add("UnDefined","Undefined variable: ip");
	}

	if ($ErrorLog -> ErrorCount > 0) {
		$ErrorLog -> JSONToPrint();
	} else 
	{
		main($ErrorLog);
	}

	

?>