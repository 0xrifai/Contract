// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DailyCheckin {
    mapping(address => uint256) public lastCheckinDay;
    
    mapping(address => uint256) public totalCheckins;

    event CheckedIn(address indexed user, uint256 dayNumber, uint256 totalCheckins);

    function checkIn() external {
        uint256 currentDay = getCurrentDay();
        
        require(lastCheckinDay[msg.sender] < currentDay, "Already checked in today");
        
        lastCheckinDay[msg.sender] = currentDay;
        totalCheckins[msg.sender] += 1;
        
        emit CheckedIn(msg.sender, currentDay, totalCheckins[msg.sender]);
    }
    
    function getCurrentDay() public view returns (uint256) {
        return block.timestamp / 1 days;
    }
    
    function hasCheckedInToday(address user) external view returns (bool) {
        return lastCheckinDay[user] == getCurrentDay();
    }
    
    function getUserStats(address user) external view returns (uint256 lastDay, uint256 total) {
        return (lastCheckinDay[user], totalCheckins[user]);
    }
}
