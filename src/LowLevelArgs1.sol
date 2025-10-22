// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelArgs1 {
    function main(address a, uint256 x) public {
        // call rare(x) using a low-level call
        // if the low level call reverts, revert also
        // -----------------
        // Solution 1
        // bytes memory data = abi.encodeWithSignature("rare(uint256)", x);
        // (bool success, bytes memory returnedData) = a.call(data);
        // require(success);
        // -----------------
        // bonus challenge: use an interface and a high level call to accomplish the same task

        try IRare(a).rare(x) {} catch (bytes memory returedData) {
            revert();
        }
    }
}

interface IRare {
    function rare(uint256 x) external;
}
