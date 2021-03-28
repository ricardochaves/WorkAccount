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

  });
});