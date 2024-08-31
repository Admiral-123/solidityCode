// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/*
A calls B, sends 100 wei
        B calls C, sends 50 wei
A ---> B ---> C
              msg.sender=B
              msg.value=50
              exe code on C's state var.
              uses ETH in C


A calls B, sends 100 wei
        B delegatecalls C
A ---> B ---> C
                msg.sender=A
                msg.value=100
                exe code on B's state var.
                uses ETH in B

*/

// delegatecall allows a contract to execute another contract's code in its own context. This means that the state changes occur in the calling contract, not the called contract.




contract TestDelegateCall{
    uint public num;
    address public sender;
    uint public val;



    function setVar(uint _num)external payable {
        num=2*_num;
        sender=msg.sender;      // i can create any changes in function's logic in this contract and redeploy it many times
        val=msg.value;
    }
}


contract DelegateCall{      // this contract will be stable, we'll use the address and param to find the output from the redeployed contract
    uint public num;
    address public sender;      // in using delegateCall all state var should be in chronological order as the above contract
    uint public val;

    function setVar(address _test,uint _num)external payable{
        // _test.delegatecall(abi.encodeWithSignature("setVar(uint256)", _num));

         (bool success, bytes memory data)=_test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVar.selector,_num));     // both of the code will do exactly same thing

         require(success,"delegateCall failed");
        
        
    }
}