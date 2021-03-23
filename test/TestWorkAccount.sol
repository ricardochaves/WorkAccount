// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/WorkAccount.sol";
// import "truffle/Assert.sol";


contract TestWorkAccount {


    WorkAccount work_account;

    function beforeEach() public {
        work_account = WorkAccount(DeployedAddresses.WorkAccount());
    }

    function testAddNewVirtualAccount() public{

        address payable expectedWorker = 0x0000000000000000000000000000000000000000;
        address payable expectedRetailStore = 0x5c15741C7ABb1b0E8FB0BD41b5ed8c17219926A1;

        uint accountID = work_account.addNewVirtualAccount(expectedWorker, expectedRetailStore);

        Assert.equal(accountID, 1, "test");

        address owner;
        uint status;
        address worker;
        address retailStore;

        (owner, worker, retailStore,status) = work_account.getVirtualAccount(accountID);

        Assert.equal(retailStore, expectedRetailStore, "Account RetailStore should match");
        Assert.equal(worker, expectedWorker, "Account worker should match");
        Assert.equal(status, uint(WorkAccount.VirtualAccountStatus.active), "Account status at creation should be .active");
        Assert.equal(owner, address(this), "The function caller should be the owner");
    
    }



}