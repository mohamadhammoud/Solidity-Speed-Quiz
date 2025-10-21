// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract Account2 {
    address immutable owner;

    constructor(address _owner) payable {
        owner = _owner;
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner");
        (bool ok, ) = owner.call{value: address(this).balance}("");
        require(ok);
    }
}

contract AccountMaker {
    function makeAccount(address owner) external payable returns (address) {
        // use create2 to create an account with the owner address
        // the salt should be the owner address
        // the value sent to them should be msg.value

        // SOLUTION1
        bytes memory bytecode = type(Account2).creationCode;
        // convert address to byte32 as salt
        bytes32 ownerB32 = bytes32(bytes20(uint160(owner)));
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),
                address(this),
                ownerB32,
                keccak256(abi.encodePacked(bytecode, abi.encode(owner)))
            )
        );
        address predictedAddress = address(uint160(uint256(hash)));
        (bool ok, ) = predictedAddress.call{value: msg.value}("");
        require(ok);
        // NOTE: cast last 20 bytes of hash to address
        return predictedAddress;

        // SOLUTION 2
        // // salt = owner address padded to 32 bytes (matches the test's predictAddress)
        // bytes32 salt = bytes32(bytes20(uint160(owner)));
        // // Deploy via CREATE2; forwards msg.value to the new Account2
        // Account2 acct = new Account2{salt: salt, value: msg.value}(owner);
        // // Return the deployed address
        // return address(acct);
    }
}
