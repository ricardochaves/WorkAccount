// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract WorkAccount {
    enum VirtualAccountStatus {
        active,
        done
    }
    struct VirtualAccount {
        address payable owner;
        address payable worker;
        address payable retailStore;
        VirtualAccountStatus status;
    }

    VirtualAccount[] private _accounts;

    modifier onlyIfVirtualAccountExists(uint itemID) {
        
        require(_accounts[itemID-1].owner != address(0));
        _;
    }

    function addNewVirtualAccount(address payable worker, address payable retailStore) public returns (uint){
      
      _accounts.push(VirtualAccount({
          owner: msg.sender,
          worker: worker,
          retailStore: retailStore,
          status: VirtualAccountStatus.active
          }));

      // VirtualAccount is pushed to the end, so the lenth is used for
      // the ID of the VirtualAccount
      return _accounts.length;
    }

    function getVirtualAccount(uint accountID) public view onlyIfVirtualAccountExists(accountID) returns (address payable, address payable, address payable, uint) {

        VirtualAccount storage virtualAccount = _accounts[accountID-1];
        return (virtualAccount.owner, virtualAccount.worker, virtualAccount.retailStore, uint(virtualAccount.status));
    }

    function depositETH(uint accountID) public payable onlyIfVirtualAccountExists(accountID){
        
        address payable ow;
        (ow, , ,) = this.getVirtualAccount(accountID);

        require(msg.sender == ow, "Just the owner can deposit ETH");

        ow.transfer(msg.value);
    }
}
