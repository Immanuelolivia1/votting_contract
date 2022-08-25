//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract Voting{

    event votedEvent(uint id);

    address INEC;

    uint public candidateCount;

    struct candidate{
        string name;
        uint id;
        uint voteCounts;
        bool voted;
    }

    mapping(uint => candidate) public seeCandidate;
    mapping(address => bool) public checkVote;

    constructor() {
        addCandidate("Peter Obi", 1);
        addCandidate("Abubakar Attiku", 2);
        addCandidate("Tinubu", 3);
        INEC = msg.sender;
    }

    function addCandidate(string memory _name, uint _id) private {
        candidate storage c = seeCandidate[candidateCount];
        c.name = _name;
        c.id = _id;
        // c.voteCounts = 7;
        // c.voted = false;
        // seeCandidate[candidateCount](candidate(_name, 0, 7, false));
        candidateCount++;
    }
    function getCandidates(uint index) external view returns(candidate memory){
        return seeCandidate[index];




        // string[] memory names = new string[](candidateCount);
        // uint[] memory voteCounts = new uint[](candidateCount);
        // for(uint i = 0; 1 < candidateCount; i++) {
        //     names[i] = seeCandidate[i].name;
        //     voteCounts[i] = seeCandidate[i].voteCounts;
        // }
        // return (names, voteCounts);
    }

    function vote(uint index) external {
        require(INEC != msg.sender, "You don't have the right to vote!");
        require(!checkVote[msg.sender], "already voted");
        checkVote[msg.sender] = true;

        // require(id >= 0 && id <= candidateCount -1);
        candidate storage c = seeCandidate[index];
        c.voteCounts++;

        emit votedEvent(index);


    }

    
}