// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract TodoList {
    struct Todo {
        string content;
        bool completed;
    }

    mapping(address => Todo[]) todos;

    event TodoCreated(address indexed user, string content);
    event TodoToggled(address indexed user, uint256 index, bool completed);
    function create_todo(string calldata content) external {
        todos[msg.sender].push(Todo({
            content: content,
            completed: false
        }));
        emit TodoCreated(msg.sender, content);
    }

    function toggle_todo_completed(uint256 index) external {
        Todo storage todo = todos[msg.sender][index];
        todo.completed = !todo.completed;
        emit TodoToggled(msg.sender, index, todo.completed);
    }

    function getTodos(uint256 index) external view returns(string memory content, bool completed) {
        Todo storage todo = todos[msg.sender][index];
        return (todo.content, todo.completed);
    }
}
