// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

struct Point {
    uint256 x;
    uint256 y;
}

contract LowLevelStruct {
    function main(address a) public returns (uint256 x, uint256 y) {
        // call function "point()" on address a
        // do not use an interface
        // point() returns a struct with two uint256 fields, i.e.
        // struct Point {
        //     uint256 x;
        //     uint256 y;
        // }
        // return the two fields
        // revert if the low level call reverts
        // ------------------------------------
        // Solution 1
        // bytes memory data = abi.encodeWithSignature("point()");
        // (bool success, bytes memory returnedData) = a.call(data);
        // require(success);
        // (uint256 x, uint256 y) = abi.decode(returnedData, (uint256, uint256));
        // return (x, y);
        // bonus challenge: use an interface and a high level call to accomplish the same task

        try IPoint(a).point() returns (Point memory p) {
            return (p.x, p.y);
        } catch (bytes memory lowLevelData) {
            revert();
        }
    }
}

interface IPoint {
    function point() external returns (Point memory);
}
