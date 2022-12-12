
pragma solidity ^0.8.7;

contract voltex_ico {
    // Introducing the maximum number of voltex for sale
    uint public max_voltex = 1000000;
    // conversion rate for USD
    uint public usd_to_voltex = 1000;
    // Introducing the total number of voltex have been bought by the investor
    uint public total_voltex_bought = 0;
    //Mapping from the investor address to its equity in voltex and USD
    mapping(address => uint) equity_voltex;
    mapping(address => uint) equity_usd;

    //Checking if an investor can buy voltex
    modifier can_buy_voltex(uint usd_invested) {
        require(usd_invested * usd_to_voltex + total_voltex_bought <= max_voltex);
        _;
    }
    //Getting the equity in voltex of an investor
    function equity_in_voltex(address investor)external view returns(uint){
        return equity_voltex[investor];
    }
    function equity_in_usd(address investor)external view returns(uint){
        return equity_usd[investor];
    }
    // Buying voltex
    function buy_voltex(address investor, uint usd_invested) external
        can_buy_voltex(usd_invested){
            uint voltex_bought = usd_invested * usd_to_voltex;
            equity_voltex[investor] += voltex_bought;
            equity_usd[investor] = equity_voltex[investor] / usd_to_voltex;
            total_voltex_bought += voltex_bought;
         }
    // Selling voltex
    function sell_voltex(address investor, uint voltex_sold) external{
            equity_voltex[investor] -= voltex_sold;
            equity_usd[investor] = equity_voltex[investor] / usd_to_voltex;
            total_voltex_bought -= voltex_sold;
         }
}