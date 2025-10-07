// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract StringConcat {
    function concat(
        string memory a,
        string memory b
    ) public pure returns (string memory) {
        // return the concatenation of a and b

        // we can have two different options for it
        // option 1 is for solidity less than 0.8.12

        // option 1:  return string(abi.encodePacked(a, b));
        return string.concat(a, b); // option 2
    }
}
