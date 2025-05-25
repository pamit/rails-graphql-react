import React, { useState } from 'react';
import './../App.css';
import { useQuery, useMutation } from '@apollo/client';
import { GET_POSTS, CREATE_POST } from '../graphql/queries';
import Post from './Post';
import { Link } from 'react-router-dom';

type Props = {
  appName: string;
  children?: React.ReactNode;
}

const Posts: React.FC<Props> = ({ appName, children }) => {
  // const titleRef = useRef<HTMLInputElement>(null);
  // useEffect(() => {
  //   console.log('App mounted', titleRef.current);
  //   titleRef.current?.focus(); // not working!
  // }, []);

  // GraphQL
  const { data, loading, error } = useQuery(GET_POSTS);
  const [createPost] = useMutation(CREATE_POST, { errorPolicy: 'all' });

  const [title, setTitle] = useState('')
  const [content, setContent] = useState('');
  const [formError, setFormError] = useState('');
  const [serverErrors, setServerErrors] = useState<string[]>([]);

  if (loading) return <p>Loading posts...</p>;
  if (error) return <p>Error: {error.message}</p>;

  const handleCreate = async(event: { preventDefault: () => void; }) => {
    event.preventDefault();

    setFormError('');
    setServerErrors([]);
    // if (!title.trim()) {
    //   setFormError('Title is required');
    //   return;
    // }

    try {
      const result = await createPost({
        variables: { title, content },
        refetchQueries: [{ query: GET_POSTS }]
      });

      // handle GraphQL-level errors
      if (result?.errors?.length ?? 0 > 0) {
        console.log('GraphQL errors:', result?.errors);
        setServerErrors(result?.errors?.map(err => err.message) ?? []);
        return;
      }

      setTitle('');
      setContent('');
    } catch (error: any) {
      // Handle transport-level or fatal GraphQL errors
      setFormError('A server error occurred. Please try again.');
      console.error('GraphQL Error:', error.graphQLErrors);
      console.error('GraphQL networkError:', error.networkError);
    }
  };

  return (
    <div>
      <div className="posts-div">
        <h1 style={{ margin: '10px' }}>{appName}</h1>
        {data.posts.map((post: any) => (
          <div key={post.id}
            className="post-item"
            style={{ gap: '0.5rem' }}
          >
            <div className="post-title">{post.title}</div>
            <span> | </span>
            <Link to={`/posts/${post.id}`} className="post-link">
              View
            </Link>
          </div>
        ))}
      </div>
      <br/><br/>

      <div style={{ margin: '10px' }}>
        {formError && <p style={{ color: 'red' }}>{formError}</p>}
        {serverErrors.map((err, idx) => (
          <p key={idx} style={{ color: 'red' }}>{err}</p>
        ))}
        <input
          value={title}
          // ref={titleRef}
          onChange={e => setTitle(e.target.value)}
          placeholder='Title' />
        <br/>
        <textarea
          value={content}
          onChange={e => setContent(e.target.value)}
          placeholder='Content' />
        <br/>
        <button onClick={handleCreate}>Create</button>
      </div>

    </div>
  );
};

export default Posts;