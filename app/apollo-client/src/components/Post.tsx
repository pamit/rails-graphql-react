import React, { useEffect, useRef } from 'react';
import { useParams } from 'react-router-dom';
import './../App.css';
import { useQuery, useMutation } from '@apollo/client';
import { GET_POST, UPDATE_POST } from '../graphql/queries';
import { Link } from 'react-router-dom';

const Post: React.FC = () => {
  const { id } = useParams<{ id: string }>();

  // GraphQL
  const { data, loading, error } = useQuery(GET_POST, { variables: { id } });
  const post = data?.post;
  const [updatePost] = useMutation(UPDATE_POST);

  const hasIncrementedRef = useRef(false);

  useEffect(() => {
    const navigationEntry = window.performance?.getEntriesByType('navigation')?.[0] as PerformanceNavigationTiming | undefined;
    const isPageReload = navigationEntry?.type === 'reload';

    if (post && isPageReload && !hasIncrementedRef.current) {
      updatePost({
        variables: { id: post.id, title: post.title, content: post.content, viewCount: post.viewCount + 1 },
        refetchQueries: [{ query: GET_POST, variables: { id } }]
      });

      hasIncrementedRef.current = true;
    }
  }, [id, post, updatePost]);

  if (loading) return <p>Loading post...</p>;
  if (error) return <p>Error: {error.message}</p>;
  if (!post) return <p>Post not found.</p>;

  return (
    <div className="post-div">
      <div>
        <h2>{post.title}</h2>
        <p>{post.content}</p>
        <p>Viewed: {post.viewCount}</p>
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
