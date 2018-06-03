pragma solidity ^0.4.0;

contract charge_database {

   struct Charge {
       address user_id;
       uint32 charger_id;
       uint32 start;
       uint32 duration;
       uint8 mode;
       uint256 bonus;
   }
  
   address[] usersByAddress;
   
   mapping (bytes32 => Charge) Charges; 
   bytes32[] chargesList; 

   uint32[] contractsList;
   
   function addNewCustomer(address user_id) public returns (bool success) {
      usersByAddress.push(user_id);
      return true;
  }
  
  function addNewCharge(  address user_id, 
                          uint32 charger_id,
                          uint32 start,
                          uint32 duration,
                          uint8 mode,
                          uint256 bonus
                          ) public returns (bytes32) {

    bytes32 chargeId = keccak256(user_id, charger_id, start);
    Charges[chargeId] = Charge(user_id, charger_id, start, duration, mode, bonus);

    chargesList.push(chargeId);
    return chargeId;
  }

  function getUsersList() public constant returns (address[]) { 
      return usersByAddress; 
  }

  function getChargesList() public constant returns (bytes32[]) { 
      return chargesList; 
  }

  function getChargeData(bytes32 chargeId) public constant returns (
                                   uint32,
                                   uint32,
                                   uint32,
                                   uint8,
                                   uint256) {
    return (Charges[chargeId].charger_id,
            Charges[chargeId].start,
            Charges[chargeId].duration,
            Charges[chargeId].mode,
            Charges[chargeId].bonus);
  }

}
