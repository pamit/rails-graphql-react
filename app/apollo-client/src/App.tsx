import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Posts from './components/Posts';
import Post from './components/Post';
// import Count from './components/Counter';
// import WindowSize from './components/WindowSize';

const App: React.FC = () => {
  return (
    <Routes>
      <Route path="/posts" element={<Posts appName="Blog Posts"/>} />
      <Route path="/posts/:id" element={<Post />} />
    </Routes>

    // <Posts appName="Blog Posts">
    //   <hr/>
    // </Posts>

    // <Count />
    // <WindowSize />
  );
};

export default App;
