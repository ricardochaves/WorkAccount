const Playground = artifacts.require('Playground');
const truffleAssert = require('truffle-assertions');

contract('Playground', function (accounts) {
  const [ fundingAccount, notOwner, acc3, _ ] = accounts;

  context('once deployed', function () {
    beforeEach(async function () {
      this.contract = await Playground.new({ from: fundingAccount });
    });

    it('should some two uint numbers', async function () {
      let value = await this.contract.SomeTwoNumbers(2, 2);
      assert.equal(value,4);
    });

    it('should receive the sender from msg', async function () {
      let result = await this.contract.ReceiveSenderFromMsg.call({from: fundingAccount});
      assert.equal(result,fundingAccount);
      
    });

    it('should receive the value from msg', async function () {
      let result = await this.contract.ReceiveValueFromMsg.call({value: 10});
      assert.equal(result.toNumber(),10);
    });

    context("Modifiers", function (){

      it('sould execute with sucess using owner account', async function (){
        await this.contract.JustTheOwnerCanExecute();
      });

      it('rejects when the send is not the owner', async function () {
        await truffleAssert.reverts(this.contract.JustTheOwnerCanExecute({from: notOwner}));
      });
      
    });

    context("Events", function() {
      it('Should emit events: OwnerAccesAcces and ReturnUint', async function () {
        const result = await this.contract.EmitOwnerAccesAccesEvent({from: fundingAccount});
        truffleAssert.eventEmitted(result, 'OwnerAccesAcces');
        truffleAssert.eventEmitted(result, 'ReturnUint', (event) => {
          return event[0].words[0] == 21;
        });
        //truffleAssert.prettyPrintEmittedEvents(result);
      });
    });

    context("Payable Address", function() {
      it('Should execute without error', async function () {
        const result = await this.contract.ConvertSenderToPayable({from: fundingAccount});
      });
    });

    context("Transactions", function() {
      it("Should transfer some eth to a contract", async function() {
        amount = 10;
        await this.contract.send(amount, {from: accounts[0]});
        assert.equal(await web3.eth.getBalance(this.contract.address), amount);
      });

      it("Should transfer some eth to a account", async function() {
        await this.contract.send(10, {from: accounts[0]});
        let amountToTransfer = BigInt(1);
        let BalanceAcc3  = await web3.eth.getBalance(acc3)
        let expectedBalanceAcc3 = BigInt(BalanceAcc3) + amountToTransfer;

        await this.contract.DepositFromSenderToAccount(acc3, amountToTransfer);

        assert.equal(await web3.eth.getBalance(acc3), expectedBalanceAcc3); 
      });
    });
  });
});