import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';
import { ApolloClient, InMemoryCache, ApolloProvider } from '@apollo/client';
import { BrowserRouter } from 'react-router-dom';

console.log("REACT_APP_API_URL:", process.env.REACT_APP_API_URL);

const client = new ApolloClient({
  uri: process.env.REACT_APP_API_URL,
  // uri: 'http://localhost:3000/graphql', // Rails API
  // uri: 'http://localhost:4000', // Apollo Gateway
  cache: new InMemoryCache(),
  connectToDevTools: true
});

const root = ReactDOM.createRoot(
  document.getElementById('root') as HTMLElement
);
root.render(
  <React.StrictMode>
    <ApolloProvider client={client}>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </ApolloProvider>
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
