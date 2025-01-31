pragma circom 2.0.0;

include "../node_modules/circomlib/circuits/comparators.circom";
include "../node_modules/circomlib/circuits/poseidon.circom";

template creditScoreConstraint() {
    // public
    signal input hashData;
    signal input ownerAddress;
    signal input threshold;
    // private
    signal input creditScore; 

    // true/false
    signal output out;

    // check hash of creditScore to be equal to hashData
    component hash = Poseidon(2);
    hash.inputs[0] <== ownerAddress;
    hash.inputs[1] <== creditScore;
    hashData === hash.out;

    // considering max creditScore 127
    component greaterEqThan = GreaterEqThan(8); 
    greaterEqThan.in[0] <== creditScore;
    greaterEqThan.in[1] <== threshold;

    out <-- greaterEqThan.out;
    out === 1;
}

component main {public [hashData,ownerAddress,threshold]} = creditScoreConstraint();
