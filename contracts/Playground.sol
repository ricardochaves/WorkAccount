// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Owner {
   address owner;
   constructor() {
      owner = msg.sender;
   }
   modifier onlyOwner {
      require(msg.sender == owner, 'Not a owner');
      _;
   }
}

contract Playground is Owner {

    function SomeTwoNumbers(uint n1, uint n2) pure public returns (uint) {
        return n1 + n2;
    }
    
    function ReceiveSenderFromMsg() payable public returns (address){
        return msg.sender;
    }

    function ReceiveValueFromMsg() payable public returns (uint){
        return msg.value;
    }

    function JustTheOwnerCanExecute() public view onlyOwner {
        msg.sender;
    }


    event OwnerAccesAcces();
    event ReturnUint(uint number);

    function EmitOwnerAccesAccesEvent() public onlyOwner {
        emit OwnerAccesAcces();
        emit ReturnUint(21);
    }

    

}