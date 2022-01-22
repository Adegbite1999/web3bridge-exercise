<!-- HOW THE SMART CONTRACT WORKS -->
<!-- Aim of project  -->
The aim of this smart contract is to create a todoList smart contract that enables us createTasks and CheckTask and keep track of our task count on the storage memory. If these was a web 2.0 project, the aim would have been to create a full fledge CRUD app i.e 
1. We are able to create tasks 
2. Read Tasks 
3. Update the tasks 
4. Delete the tasks
But due to the immutability of the blockchain, we can't delete from the blockchain, performing an update seems impossible but it can be achieved by either delegating event calls or creating a new instance of todoList.

First we create a global variable count;

uint public count;

Then define struct of Task with variable id, content, completed

Then create a refrence type mapping named tasks with key uint which refrences the Task struct

We then create events TaskCreated, TaskCompleted which will be emitted whenever there's a function call.

The function createTask() visibility is decleared as public and it receive the parameter _content which is a string and stored on the memory.

The  function checkTask() visibility is decleared to be public and receive the parameter _id. 
