import React, { useState, useEffect } from 'react';

const Counter: React.FC = () => {
    const [count, setCount] = useState<number>(0);

    // setTimeout(() => {
    //     setCount(count + 2);
    //     console.log('Count1');
    // }, 1000);

    useEffect(() => {
        const interval = setInterval(() => {
            setCount(count => count + 1);
        }, 1000);

        return () => clearInterval(interval);
    }, []);

    return <p>Count: {count}</p>;
}

export default Counter;
