<?php

require_once("QMessage.php");

class ErrorLog extends QMessage {
		var $ErrorCount = 0; // Error 갯수 카운트

		function Add($ErrorCode, $ErrorString) {
			// Error 목록 추가
			$this->MessageList['Error'][$this -> ErrorCount] = array('ErrorCode' => $ErrorCode,'ErrorString' => $ErrorString);
			$this->ErrorCount = $this->ErrorCount + 1;
			//print_r($this -> MessageList);
		}

		function JSONToPrint() {
			//Error 목록 JSON 출력
			echo die(json_encode($this -> MessageList['Error']));
		}

		function Check($AValue) {
			if (isset($_GET[$AValue])){
				if(empty($_GET[$AValue])) {
					$this -> Add("NoValue", $AValue." is not set");
				}
			} else
			{
				$this -> Add("UnDefined","Undefined variable: ".$AValue);
			}
		}
	}
?>