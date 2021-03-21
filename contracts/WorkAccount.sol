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
        address retail_store;
        VirtualAccountStatus status;
    }

    VirtualAccount[] private _accounts;

    modifier onlyIfVirtualAccountExists(uint itemID) {
        require(_accounts[itemID].owner != address(0));
        _;
    }

    function addNewVirtualAccount(address worker, address retail_store) public returns (uint){
      
      _accounts.push(VirtualAccount({
          owner: msg.sender,
          worker: worker,
          retail_store: retail_store,
          status: VirtualAccountStatus.active
          }));

      // VirtualAccount is pushed to the end, so the lenth is used for
      // the ID of the VirtualAccount
      return _accounts.length;
    }

    function getVirtualAccount(uint itemID) public view onlyIfVirtualAccountExists(itemID)returns (address, address, address, uint) {

        VirtualAccount storage virtual_account = _accounts[itemID];
        return (virtual_account.owner, virtual_account.worker, virtual_account.retail_store, uint(virtual_account.status));
    }

}
