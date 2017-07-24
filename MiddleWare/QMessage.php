<?php
class QMessage {
	protected $MessageList;

	function JSONToPrint() {
		echo die(json_encode($this -> MessageList));
	}
}
?>