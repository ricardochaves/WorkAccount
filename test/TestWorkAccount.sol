// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

import "../contracts/WorkAccount.sol";
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

contract TestWorkAccount {


    function testAddNewVirtualAccount() public{

        WorkAccount work_account = WorkAccount(DeployedAddresses.WorkAccount());

        address expectedWorker;
        address expectedRetailStore;

        uint accountID = work_account.addNewVirtualAccount(expectedWorker, expectedRetailStore);

        address owner;
        uint status;
        address worker;
        address retailStore;

        (owner, worker, retailStore, status) = work_account.getVirtualAccount(accountID);

        Assert.equal(retailStore, expectedRetailStore, "Account RetailStore should match");
        Assert.equal(worker, expectedWorker, "Account worker should match");
        Assert.equal(status, uint(WorkAccount.VirtualAccountStatus.active), "Account status at creation should be .active");
        //Assert.equal(owner, this, "The function caller should be the owner");
    
    }



}