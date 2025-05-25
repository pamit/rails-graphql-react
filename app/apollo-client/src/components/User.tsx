import React, { useState, useEffect } from 'react';
import useFetch from './../hooks/useFetch';

type User = {
  id: number;
  name: string;
}

const User: React.FC = () => {
  // Custom hook
  const { data: userData, loading: userLoading } = useFetch<User[]>('http://localhost:3000/users');
  if (userLoading) return <p>Loading posts...</p>;

	return (
		<div>
			{userData?.map((user, index) => (
				<div key={user.id}>
					<h2>{user.name}</h2>
				</div>
			))}
		</div>
	);
};

export default User;
