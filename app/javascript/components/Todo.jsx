import React, { Component } from 'react';
import SortableTree, { changeNodeAtPath } from 'react-sortable-tree';

export default class Todo extends Component {
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
							title: (
								<input
									style={{ fontSize: '1.1rem' }}
									value={node.name}
									onChange={event => {
										const name = event.target.value;
										console.log(name);
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
			</div>
		);
	}
}