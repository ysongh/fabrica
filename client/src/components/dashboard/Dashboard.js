import React from 'react';
import { Container, FormControl, Select, MenuItem, Button, Typography } from '@material-ui/core';
import AddCircleIcon from '@material-ui/icons/AddCircle';

import './Dashboard.css';
import Sidebar from '../sidebar/Sidebar';
import DCard from './DCard';

const Dashboard = ({blockchain, postcount}) => {
	const [filterByStatus, setFilterByStatus] = React.useState('1');

	const handleChange = (event) => {
		setFilterByStatus(event.target.value);
	};

	return(
		<div className="dashboard">
			<Sidebar />
			<Container maxWidth="md">
				<div className="dashboard__header">
					<div className="dashboard__headerLeft">
						<Typography variant="h4">
							Invoices
						</Typography>
						<Typography variant="p">
							There are {postcount} total invoices
						</Typography>
					</div>
					<div className="dashboard__headerRight">
						<FormControl>
							<Select
								value={filterByStatus}
								onChange={handleChange}
								>
							<MenuItem value="1" >Filter by Status</MenuItem>
							<MenuItem value="2">Paid</MenuItem>
							<MenuItem value="3">Pending</MenuItem>
							</Select>
						</FormControl>
						<Button
							className="dashboard__btnAdd"
							variant="contained"
							color="primary"
							size="large"
							startIcon={<AddCircleIcon style={{ fontSize: '2rem'}} />}
						>
							New Invoice
						</Button>
					</div>
				</div>

				<div>
					<DCard />
					<DCard />
					<DCard />
					<DCard />
					<DCard />
					<DCard />
				</div>
			</Container>
			
		</div>
		
	)
}

export default Dashboard;