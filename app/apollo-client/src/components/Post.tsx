import React from 'react';
import { useParams } from 'react-router-dom';
import './../App.css';
import { useQuery } from '@apollo/client';
import { GET_POST } from '../graphql/queries';
import { Link } from 'react-router-dom';

const Post: React.FC = () => {
  const { id } = useParams<{ id: string }>();

  // GraphQL
  const { data, loading, error } = useQuery(GET_POST, { variables: { id } });

  if (loading) return <p>Loading post...</p>;
  if (error) return <p>Error: {error.message}</p>;

  const post = data?.post;
  if (!post) return <p>Post not found.</p>;

  return (
    <div className="post-div">
      <div>
        <h2>{post.title}</h2>
        <p>{post.content}</p>
      </div>

      <br/>
      <p>
        <Link to="/posts" className="text-blue-500 underline">
          Back
        </Link>
      </p>
    </div>
  );
};

export default Post;
