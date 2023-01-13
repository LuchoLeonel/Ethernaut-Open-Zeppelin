// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0 <0.9.0;

import 'forge-std/Script.sol';
import '../hacks/HackMotorbike.sol';
import 'isolmate/interfaces/tokens/IERC20.sol';

abstract contract Deploy is Script {
    function _deploy(string memory _greeting, IERC20 _token) internal {
        vm.startBroadcast();
        new HackMotorbike(address(uint160(0x0000000000000000000000006d3bd638400e42e1afc8f50765f4d040871e4f65)));
        vm.stopBroadcast();
    }
}

contract DeployMainnet is Deploy {
    function run() external {
        IERC20 weth = IERC20(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

        _deploy('some real greeting', weth);
    }
}

contract DeployRinkeby is Deploy {
    function run() external {
        IERC20 weth = IERC20(0xDf032Bc4B9dC2782Bb09352007D4C57B75160B15);

        _deploy('some test greeting', weth);
    }
}

contract DeployGoerli is Deploy {
    function run() external {
        IERC20 weth = IERC20(0xDf032Bc4B9dC2782Bb09352007D4C57B75160B15);

        _deploy('some test greeting', weth);
    }
}
