import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Main from './components/Main';
import Posts from './components/Posts';
import Post from './components/Post';
// import Count from './components/Counter';
// import WindowSize from './components/WindowSize';

type UserContextType = {
    user: string | null;
  };
export const UserContext = React.createContext<UserContextType>({ user: null });

const App: React.FC = () => {
  return (
    <UserContext.Provider value={{ user : 'John' }}>
      <Routes>
        <Route path="/" element={<Main />} />
        <Route path="/posts" element={<Posts appName="Posts"/>} />
        <Route path="/posts/:id" element={<Post />} />
      </Routes>
    </UserContext.Provider>

    // <Count />
    // <WindowSize />
  );
};

export default App;
