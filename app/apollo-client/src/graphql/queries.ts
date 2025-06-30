import { gql } from '@apollo/client';

export const GET_POSTS = gql`
    query {
        posts {
            id
            title
            content
            viewCount
        }
    }
`;

export const GET_POST = gql`
    query GetPost($id: ID!) {
        post(id: $id) {
            id
            title
            content
            viewCount
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

export const UPDATE_POST = gql`
    mutation UpdatePost($id: ID!, $title: String!, $content: String!, $viewCount: Int) {
        updatePost(input: { id: $id, title: $title, content: $content, viewCount: $viewCount }) {
            post {
                id
                title
                content
                viewCount
            }
            errors
        }
    }
`;

export const DELETE_POST = gql`
    mutation DeletePost($id: ID!) {
        deletePost(input: { id: $id }) {
            success
            errors
        }
    }
`;
