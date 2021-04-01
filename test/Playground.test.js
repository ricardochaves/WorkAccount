const Playground = artifacts.require('Playground');
const truffleAssert = require('truffle-assertions');

contract('Playground', function (accounts) {
  const [ owner, notOwner, _ ] = accounts;



  context('once deployed', function () {
    beforeEach(async function () {

      this.contract = await Playground.new();
    });

    it('should some two uint numbers', async function () {
      let value = await this.contract.SomeTwoNumbers(2, 2);
      assert.equal(value,4);
    });

    it('should receive the sender from msg', async function () {
      let instance = await Playground.deployed();
      let result = await instance.ReceiveSenderFromMsg.call({from: owner});
      assert.equal(result,owner);
      
    });

    it('should receive the value from msg', async function () {
      let instance = await Playground.deployed();
      let result = await instance.ReceiveValueFromMsg.call({value: 10});
      assert.equal(result.toNumber(),10);
    });

    context("Modifiers", function (){

      it('sould execute with sucess using owner account', async function (){
        let instance = await Playground.deployed();
        await instance.JustTheOwnerCanExecute();
      });

      it('rejects when the send is not the owner', async function () {
        let instance = await Playground.deployed();
        await truffleAssert.reverts(instance.JustTheOwnerCanExecute({from: notOwner}));
      });
      
    });

    context("Events", function() {
      it('Should emit events: OwnerAccesAcces and ReturnUint', async function () {
        let instance = await Playground.deployed();
        const result = await instance.EmitOwnerAccesAccesEvent({from: owner});
        truffleAssert.eventEmitted(result, 'OwnerAccesAcces');
        truffleAssert.eventEmitted(result, 'ReturnUint', (event) => {
          return event[0].words[0] == 21;
        });
        //truffleAssert.prettyPrintEmittedEvents(result);
      });
    });

    context("Payable Address", function() {
      it('Should execute without error', async function () {
        let instance = await Playground.deployed();
        const result = await instance.ConvertSenderToPayable({from: owner});
      });
    });

    context("Transactions", function() {
      it("Should transfer some eth", async function() {
        let instance = await Playground.deployed();
        const result = await instance.DepositFromSenderToAccount(notOwner, 1);
      })
    })

  });
});