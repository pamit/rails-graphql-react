import { gql } from '@apollo/client';

export const GET_POSTS = gql`
    query {
        posts {
            id
            title
            content
        }
    }
`;

export const GET_POST = gql`
    query GetPost($id: ID!) {
        post(id: $id) {
            id
            title
            content
        }
    }
`;

export const CREATE_POST = gql`
    mutation CreatePost($title: String!, $content: String!) {
        createPost(input: { title: $title, content: $content }) {
            post {
                id
                title
                content
            }
            errors
        }
    }
`;
