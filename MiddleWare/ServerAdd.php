<?php
	//DB Add
	class DBConn { // DB 접속 클래스
		const db_id = ""; // DB 계정명
		const db_pw = ""; // DB 비밀번호
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

	$DBConn = new DBConn();
	$ErrorLog = new ErrorLog();
	//$ErrorLog -> Add("test","test2");
	
	//변수 체크
	if (isset($_GET['adminname'])){
		$AdminName = $_GET['adminname'];
	} else
	{

	}
	if (isset($_GET['port'])) {
		$Port = $_GET['port'];	
	}
	if (isset($_GET['room'])) {
		$Room = $_GET['room'];
	}
	if (isset($_GET['ip'])) {
		$ip = $_GET['ip'];
	}

	//이미 있는지 체크
	if ($DBConn->Check($AdminName,$Room)) {
		//echo "true";
		//중복 확인

		//정보 갱신
		if ($DBConn->Update($AdminName, $ip, $Port, $Room)) {
			//true
		}

	}
	else {
		//echo "false";
		//정보 추가
		
	}

	if(isset($ErrorLog)) { // ErrorLog가 있으면
		if ($ErrorLog -> ErrorCount > 0)
		{
			$ErrorLog -> JSONToPrint();	// Error Json 출력
		}
	}

	

?>