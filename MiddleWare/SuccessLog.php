<?php

require_once("QMessage.php");

class SuccessLog extends QMessage {
		var $SuccessCount = 0; // Error 갯수 카운트

		function Add($SuccessString) {
			// Error 목록 추가
			$this -> MessageList['Success'][$this -> SuccessCount] = array('SuccessString' => $SuccessString);
			$this -> SuccessCount = $this -> SuccessCount + 1;
			//print_r($this -> MessageList);
		}

		function JSONToPrint() {
			//Error 목록 JSON 출력
			echo die(json_encode($this -> MessageList['Success']));
		}
	
}?>