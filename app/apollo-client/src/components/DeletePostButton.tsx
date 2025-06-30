import { useMutation } from '@apollo/client';
import { DELETE_POST } from '../graphql/queries';

type Props = {
    postId: string;
    onDelete?: () => void; // callback after delete
};

const DeletePostButton: React.FC<Props> = ({ postId, onDelete }) => {
    const [deletePost, { loading, error }] = useMutation(DELETE_POST, {
        variables: { id: postId },
        onCompleted: (data) => {
            if (data.deletePost.success) {
                if (onDelete) onDelete();
            } else {
                console.error('Delete failed:', data.deletePost.errors);
            }
        }
    });

    return (
        <>
            <button onClick={() => deletePost()} disabled={loading} className="post-link-delete">
                {loading ? 'Deleting...' : 'Delete'}
            </button>
            {error && <p className="text-red-500">Error: {error.message}</p>}
        </>
    );
};

export default DeletePostButton;
