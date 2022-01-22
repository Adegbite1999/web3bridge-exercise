// SPDX-License-Identifier: CC-BY-SA-4.0
pragma solidity ^0.8.9;

contract Todo {
    // Initialized global count variable
  uint public count;
//   Declare struct of task
  struct Task {
      uint id;
      string content;
      bool completed;
  }  
// Declare maing of task, serves as pointer to tasks
mapping(uint => Task) public tasks;

// declare an event
event TaskCreated(
    uint id,
    string content,
    bool completed
);
event TaskCompleted(
    uint id,
    bool completed
);
function createTask(string memory _content) public {
count = count + 1;
tasks[count] = Task(count, _content, false);
emit TaskCreated(count, _content, false);

}

function checkTask(uint _id) public {
    Task memory _task = tasks[_id];
    _task.completed = true;
    tasks[_id] = _task;
    emit TaskCompleted(_id, true);
}

}