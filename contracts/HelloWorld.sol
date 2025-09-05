// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3 .0;

contract HelloWorld {
    string internal message = "Hello World";

    //emit to notify when the message has be modified
    event messageUpdated(string _message, address _writer);

    //function to updateMessage
    function UpdateMessage(string memory _text) public {
        message = _text;
        emit messageUpdated(_text, msg.sender);
    }

    //function to ReadMessage
    function ReadMessage() public view returns (string memory) {
        return message;
    }
}
