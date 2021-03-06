import React, { Component } from 'react';
import { DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';
import TouchBackend from 'react-dnd-touch-backend';
import { changeNodeAtPath, removeNodeAtPath, SortableTreeWithoutDndContext as SortableTree } from 'react-sortable-tree';

const isTouchDevice = !!('ontouchstart' in window || navigator.maxTouchPoints);

class Todo extends Component {
	constructor(props) {
		super(props);

		this.state = {
			treeData: JSON.parse(this.props.treeData),
			sync: false
		};
	}

	componentDidUpdate(prevProps, prevState, snapshot) {
		if (typeof(prevState.treeData) !== "undefined" &&
				typeof(this.state.treeData) !== "undefined" &&
				this.state.sync === true) {
			fetch('/todos/sync', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({tree_data: this.state.treeData})})
				.then(response=>response.json())
				.then(response => {
					if(typeof(response.treeData) !== "undefined"){
						this.setState({treeData: JSON.parse(response.treeData), sync: false})
					}
				})
				.catch(error => { console.log(error) })
		}
	}

	render() {
		const getNodeKey = ({ treeIndex }) => treeIndex;
		return (
			<div>
				<div style={{ height: 300 }}>
					<SortableTree
						treeData={this.state.treeData}
						onChange={treeData => this.setState({ treeData, sync: true })}
						generateNodeProps={({ node, path }) => ({
							buttons: [
									<div className="checkbox-inline">
										<input
											type="checkbox"
											name="visible"
											value={!node.completed}
											checked={node.completed}
											className="todo-checkbox"
											onChange={(event)=>{
												const completed = event.target.value === "true";
												console.log(completed);
												console.log(node);
												console.log(path);
												this.setState({
													sync: true,
													treeData: changeNodeAtPath({
														treeData: this.state.treeData,
														path,
														getNodeKey,
														newNode: { ...node, completed: completed },
													})
												})
											}}
										/>
									</div>,
									<i
										className="fa fa-trash"
										onClick={() => {
											fetch(`/todos/${node.id}`, {
												method: 'DELETE',
												headers: {
													'Content-Type': 'application/json'
												}
											}).then(() => {
												this.setState(state => ({
													sync: true,
													treeData: removeNodeAtPath({
														treeData: state.treeData,
														path,
														getNodeKey,
													}),
												}));
											}).catch(error => console.log(error))
										}}
									/>,
							],
							title: (
								<input
									style={{ fontSize: '1.1rem' }}
									value={node.name}
									onChange={event => {
										const name = event.target.value;
										console.log(name);
										console.log(path);
										this.setState({
											sync: true,
											treeData: changeNodeAtPath({
												treeData: this.state.treeData,
												path,
												getNodeKey,
												newNode: { ...node, name },
											}),
										});
									}}
								/>
							),
						})}
					/>
				</div>
				<button
					className="btn full-btn btn-dark mt-5"
					onClick={() =>{
						const creator = this.props.creator_id;
						const house = this.props.house_id;
						this.setState(state => ({
							sync: true,
							treeData: state.treeData.concat({
								name: "New Task",
								creator_id: creator,
								house_id: house,
								completed: false,
								expanded: true,
								children: []
							}),
						}))
					}}
				>Add Todo</button>
			</div>
		);
	}
}

const WrappedTodo = DragDropContext(isTouchDevice ? TouchBackend : HTML5Backend)(
	Todo
);

export default WrappedTodo;