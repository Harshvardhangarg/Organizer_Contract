// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract eventOrg{
    struct Event{
        address organizer;
        string name;
        uint date;
        uint price;
        uint ticketCount;
        uint ticketRemain;
    }
    mapping(uint=>Event) public events;
    mapping(address=>mapping(uint=>uint)) public tickets;
    uint public nextid;
    function createEvent(string memory name,uint date,uint price, uint ticketCount) external{
        require(date>block.timestamp,"set later dates");
        require(ticketCount>0);
        events[nextid]=Event(msg.sender,name,date,price,ticketCount,ticketCount);
        nextid++;
    }

    function buyTicket(uint id, uint quantity) external payable{
        require(events[id].date!=0,"Event should Exist!");
        require(events[id].date>block.timestamp,"already occured!"); 
        Event storage _event = events[id];
        require(msg.value==(_event.price*quantity),"not enough money"); 
        require(_event.ticketRemain>=quantity,"not enough ticket");
        _event.ticketRemain-=quantity;
        tickets[msg.sender][id]+=quantity;  

    }

    function transferTicket(uint id,uint quantity, address to) external{
        require(events[id].date!=0,"Event should Exist!");
        require(events[id].date>block.timestamp,"already occured!"); 
        require(tickets[msg.sender][id]>=quantity,"You do not have enough tickets");
        tickets[msg.sender][id]-=quantity;
        tickets[to][id]+=quantity;

    }
}
