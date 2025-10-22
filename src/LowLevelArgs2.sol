// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelArgs2 {
    function main(address a, uint256 x, uint256 y) public {
        // call rare(x, y) using a low-level call
        // if the low level call reverts, revert also

        // Solution 1
        // bytes memory data = abi.encodeWithSignature(
        //     "rare(uint256,uint256)",
        //     x,
        //     y
        // );

        // (bool success, bytes memory returnedData) = a.call(data);
        // require(success);

        // bonus challenge: use an interface and a high level call to accomplish the same task
        // Solution 2
        try IRare(a).rare(x, y) {} catch (bytes memory lowLevelError) {
            revert();
        }
    }
}
interface IRare {
    function rare(uint256 x, uint256 y) external;
}
