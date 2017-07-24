<?php
require_once("SuccessLog.php");
require_once("ErrorLog.php");
require_once("DBConn.php");
	



	function main(){
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
		//$ErrorLog -> JSONToPrint();

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
					$ErrorLog->JSONToPrint();
				}
			}
		} else
		{
			//echo "false";
			//정보 추가
			$DBConn->Add($AdminName,$ip,$Port,$Room);
			
		}
	}

	//값 체크 후 메인문
	$ErrorLog = new ErrorLog();

	//Value Check
	$ErrorLog -> Check("adminname");
	$ErrorLog -> Check("port");
	$ErrorLog -> Check("room");
	$ErrorLog -> Check("ip");

	if ($ErrorLog -> ErrorCount > 0) {
		$ErrorLog -> JSONToPrint();
	} else 
	{
		main($ErrorLog);
	}

	

?>