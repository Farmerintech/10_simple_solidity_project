// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30; // Use a more recent and secure version of Solidity

contract PoolContract {
    mapping(address => Pool) public pools;

    struct PoolItem {
        uint256 id;
        string name;
        uint256 votes;
    }

    // Struct to represent the complete poll.
    struct Pool {
        address owner;
        PoolItem[] items;
    }

    // Modifier to restrict a function to the owner of a specific pool.
    modifier isPoolOwner(address _poolOwner) {
        require(msg.sender == _poolOwner, "Only the pool owner can call this function.");
        _;
    }

    // Function to create a new poll.
    // Takes an array of strings for the pool item names.
    function createPool(string[] memory _itemNames) public {
        // Require that a pool with this address does not already exist.
        require(pools[msg.sender].owner == address(0), "A pool already exists for this address.");

        // Create a new Pool struct in memory.
        Pool storage newPool = pools[msg.sender];
        newPool.owner = msg.sender;

        // Populate the items array for the new pool.
        for (uint256 i = 0; i < _itemNames.length; i++) {
            newPool.items.push(PoolItem({
                id: i,
                name: _itemNames[i],
                votes: 0
            }));
        }
    }

    function vote(address _poolOwner, uint256 _itemId) public {
        // Check if the pool exists.
        require(pools[_poolOwner].owner != address(0), "Pool does not exist.");

        // Check if the item ID is valid.
        require(_itemId < pools[_poolOwner].items.length, "Invalid item ID.");
        pools[_poolOwner].items[_itemId].votes++;
    }

    // Function to get the details of a specific poll.
    function getPool(address _poolOwner) public view returns (Pool memory) {
        require(pools[_poolOwner].owner != address(0), "Pool does not exist.");
        return pools[_poolOwner];
    }
}