// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelReturnUint {
    function main(address a) public returns (uint256) {
        // call function "bar()" on address a
        // do not use an interface
        // return the return value of the call

        bytes memory data = abi.encodeWithSignature("bar()");

        (bool success, bytes memory returnedData) = a.call(data);

        uint256 num = abi.decode(returnedData, (uint256));

        return num;

        // bonus challenge: use an interface and a high level call to accomplish the same task
    }
}
