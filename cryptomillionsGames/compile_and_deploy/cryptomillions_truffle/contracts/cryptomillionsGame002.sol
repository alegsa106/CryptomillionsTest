pragma solidity ^0.4.24;

contract cryptomillionsGame002
{
    address owner;
    address manager; 

    event RegisterEvent(
        address userAccount,
        uint256 block_number,
        bytes32 block_hash
    );

    event UpdateTicketAmountEvent(
        address userAccount,
        uint256 block_number,
        bytes32 block_hash
    );

    address[4] public beneficiaryList;
    
    struct Game {
        uint id_game;
        string  game_name;
    }

    struct Sorteo {
        int256 id_sorteo;
    }

    struct Register  {
        address account;
        address walletFundation;
        address walletAdministration;
        address walletBag;
        int256[] numbers;
        string amount_to_foundation;
        string amount_to_administration;
        string amount_to_bag;
        uint ticketNumber;
        uint created_at;
        uint updated_at;
        string total;
        Sorteo sorteo;
        Game game;
    }

    mapping(int256 => address[]) indexMapping;
    
    mapping(address => Register) registers;

    mapping (address => uint256) internal balances;
    
    constructor() public
    {
        owner = msg.sender;
        manager = msg.sender;
    }

    function registerBuyTicket(
        address walletUser, address walletFoundation, address walletAdministration, address walletBag, int256[] numbers,
        string memory total, uint ticketNumber, string amount_to_foundation, uint256 percentFoundation,
        string amount_to_administration, uint256 percentAdministration, string amount_to_bag, uint256 percentBag,
        int256 id_sorteo, uint id_game, string memory game_name) public payable onlyManagerOrOwner
    {
        if(msg.value == 0) revert("");
        
        beneficiaryList[0] = walletUser;
        beneficiaryList[1] = walletFoundation;
        beneficiaryList[2] = walletAdministration;
        beneficiaryList[3] = walletBag;

        indexMapping[id_sorteo].push(beneficiaryList[0]);           
        registers[beneficiaryList[0]].account = beneficiaryList[0];
        registers[beneficiaryList[0]].numbers = numbers;
        registers[beneficiaryList[0]].walletFundation = walletFoundation;
        registers[beneficiaryList[0]].walletAdministration = walletAdministration;
        registers[beneficiaryList[0]].walletBag = walletBag;
        registers[beneficiaryList[0]].created_at = 0;
        registers[beneficiaryList[0]].updated_at = 0;
        registers[beneficiaryList[0]].total = total; 
        registers[beneficiaryList[0]].amount_to_foundation = amount_to_foundation;
        registers[beneficiaryList[0]].amount_to_administration = amount_to_administration;
        registers[beneficiaryList[0]].amount_to_bag = amount_to_bag;
        registers[beneficiaryList[0]].ticketNumber = ticketNumber;
        registers[beneficiaryList[0]].sorteo = Sorteo({id_sorteo : id_sorteo });
        registers[beneficiaryList[0]].game = Game({id_game : id_game, game_name : game_name});
        
        walletFoundation.transfer(msg.value * percentFoundation / 100);
        walletAdministration.transfer(msg.value * percentAdministration / 100);
        walletBag.transfer(msg.value * percentBag / 100);
        
        emit RegisterEvent(registers[beneficiaryList[0]].account, block.number, blockhash(block.number));
    }
    
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }

    modifier onlyManagerOrOwner() {
        require(owner == msg.sender || manager == msg.sender, "");
        _;
    }
    
    function setManager(address _manager) public onlyOwner {
        manager = _manager;
    }
    
    function getAddressByIdSorteo(int256 id_sorteo) public view returns (address[] memory) {
        return indexMapping[id_sorteo];
    }
    
    function getGameIdByWalletUser(address walletUser) public view returns (uint) {
        return registers[walletUser].game.id_game;
    }
    
    function getNumberByWalletUser(address walletUser) public view returns (int256[] memory){
        return  registers[walletUser].numbers;
    }

    function getTicketNumber(address walletUser) public view returns(uint) {
        return  registers[walletUser].ticketNumber;
    }
    
    function kill() public onlyOwner {
        selfdestruct(owner);
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "");
        _;
    }
}