//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// Useful for debugging. Remove when deploying to a live network.
import "hardhat/console.sol";


interface IKintoID {
	function isKYC(address _account) external view returns (bool);
}

contract WeatherPredictionMarkt {
	// State Variables
	enum BetSide { Pro, Cons }
	struct Result {
		BetSide winner;
		BetSide loser;
	}
	Result public result;
	bool public betFinished;
	mapping(BetSide => uint) public betsPerSide;
	mapping(address => mapping(BetSide => uint)) public betsPerGambler;
	address public oracle;

	struct PredictionLocation {
		int32 latitude;
		int32 longitude;
		int32 radius;
	}
	PredictionLocation public betLocation;
	string public prediction;

	//Maximum latitude value
	int32 constant public MAX_LATITUDE = 90000000;
	//Minimum latitude value
	int32 constant public MIN_LATITUDE = -90000000;
	//Maximum longitude value
	int32 constant public MAX_LONGITUDE = 180000000;
	//Minimum longitude value
	int32 constant public MIN_LONGITUDE = -180000000;
	//Maximum allowed radius value in meters
	int32 constant public MAX_RADIUS = 20000000;
	//Minimum allowed radius value in meters
	int32 constant public MIN_RADIUS = 1;

	event BetPlaced(
		PredictionLocation indexed betLocation,
		string prediction,
		address bettor,
		BetSide betSide,
		uint256 value
	);

	event BetPaid(
		PredictionLocation indexed betLocation,
		string prediction,
		address bettor,
		BetSide betSide,
		uint256 value
	);

	constructor(address _oracle, string _prediction, int32[] data) {
		require(data.length == 3);
		require(data[0] <= MAX_LATITUDE && data[0] >= MIN_LATITUDE);
		require(data[1] <= MAX_LONGITUDE && data[1] >= MIN_LONGITUDE);
		require(data[2] <= MAX_RADIUS && data[2] >= MIN_RADIUS);
		betLocation.latitude = data[0];
		betLocation.longitude = data[1];
		betLocation.radius = data[2];

		oracle = _oracle;
		prediction = _prediction;
	}

	/**
	 *
	 *
	 */
	function bet(BetSide _betSide) public payable {
		require(betFinished == false, 'Prediction location is not available.');
		require(IKintoID.isKYC(msg.sender) == true, 'Betting address needs to have a valid KYC.');
		betsPerSide[_betSide] += msg.value;
		betsPerGambler[msg.sender][_betSide] += msg.value;

		emit BetPlaced(
			betLocation,
			prediction,
			msg.sender,
			_betSide,
			msg.value
	    );
	}

	/**
	 *
	 *
	 */
	function withdraw() external {
		uint gamblerBet = betsPerGambler[msg.sender][result.winner];
		require(IKintoID.isKYC(msg.sender) == true, 'Betting address needs to have a valid KYC.');
		require(gamblerBet > 0, 'you do not have any stake in the winning prediction');
		require(betFinished == true, 'Bet result is not yet available.');

		uint gain = gamblerBet + betsPerSide[result.loser] * gamblerBet / betsPerSide[result.winner];
		betsPerSide[msg.sender][BetSide.Cons] = 0;
		betsPerSide[msg.sender][BetSide.Pro] = 0;

		(bool success, ) = payable(msg.sender).call{ value: gain }("");
		require(success, "withdrawal failed");

		emit BetPaid(
			betLocation,
			prediction,
			msg.sender,
			result.winner,
			msg.value
		);
	}

	/**
	 *
	 *
	 */
	function report(BetSide _winner, BetSide _loser) external {
		require(oracle == msg.sender, 'only oracle');
		require(_winner != _loser, 'winner and loser cannot be the same');
		result.winner = _winner;
		result.loser = _loser;
		betFinished = true;
	}

	/**
	 * Function that allows the contract to receive ETH
	 */
	receive() external payable {}
}
