import './../App.css';
import { Link } from 'react-router-dom';

const Main: React.FC = () => {
  return (
    <div className='main-page'>
      <Link to='/posts'>
        VIEW POSTS!
      </Link>
    </div>
  );
};

export default Main;
