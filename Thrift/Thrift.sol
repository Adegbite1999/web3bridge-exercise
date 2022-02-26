// SPDX-License-Identifier: CC-BY-SA-4.0
contract purse{


struct thriftOrg{
address[] thrifters;
uint256 maturityTime;
address lastCollector;
mapping(address=>uint) collections;
bool valid;
uint totalAmount;
mapping(address=>uint[]) thriftAmountsCollected;
}

mapping(uint=>thriftOrg) public thrifts;
uint thriftIndex=0;

function addThrift() external returns(uint tIndex_){
    thriftOrg storage t=thrifts[thriftIndex];
    t.maturityTime=block.timestamp+100;
    t.valid=true;
}

function joinThrift(uint _thriftId) external payable{
confirm(_thriftId);
thriftOrg storage t=thrifts[thriftIndex];
t.thrifters.push(msg.sender);
t.collections[msg.sender]+=msg.value;
t.totalAmount+=msg.value;
}


 function collectThrift(uint _tId) public {
 thriftOrg storage t=thrifts[thriftIndex];   
 (address nxtCollector,uint index)=getNextCollector(t.thrifters,t.lastCollector);
    assert(msg.sender==nxtCollector);
    assert(block.timestamp>=t.maturityTime);
payable(msg.sender).transfer(t.totalAmount);
//if the last Collector is the last person in the array
if(index==t.thrifters.length-1){
reset(_tId);
}
t.thriftAmountsCollected[msg.sender].push(t.totalAmount);
 }





function confirm(uint _id) private{
    assert(thrifts[_id].valid);
}
function getNextCollector(address[] memory _in,address _last) public returns(address _next,uint index){
    assert(_in.length>1);
if(_last==address(0)){
    _next=_in[0];
}
if(_last!=address(0)){
uint i__=findIndex(_in,_last);
_next=_in[i__+1];
index=i__;
}

}

function findIndex(address[] memory in1,address target) private returns(uint index){
    assert(in1.length>1);
for(uint i=0;i<in1.length;i++){
if(target==in1[i]){
    index=i;
}
}
}
function reset(uint _tId) private {
    thrifts[_tId].lastCollector=address(0);
    thrifts[_tId].maturityTime+=100;
}
}
