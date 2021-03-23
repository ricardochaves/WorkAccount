// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract WorkAccount {
    enum VirtualAccountStatus {
        active,
        done
    }
    struct VirtualAccount {
        address owner;
        address worker;
        address retailStore;
        VirtualAccountStatus status;
    }

    VirtualAccount[] private _accounts;

    modifier onlyIfVirtualAccountExists(uint itemID) {
        require(_accounts[itemID-1].owner != address(0));
        _;
    }

    function addNewVirtualAccount(address worker, address retailStore) public returns (uint){
      
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

    function getVirtualAccount(uint itemID) public view onlyIfVirtualAccountExists(itemID)returns (address, address, address, uint) {

        VirtualAccount storage virtualAccount = _accounts[itemID-1];
        return (virtualAccount.owner, virtualAccount.worker, virtualAccount.retailStore, uint(virtualAccount.status));
    }

}
