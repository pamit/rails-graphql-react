import React, { useEffect, useState } from 'react';

function WindowSizeTracker() {
  const [width, setWidth] = useState(window.innerWidth);

  useEffect(() => {
    const handleResize = () => {
      setWidth(window.innerWidth);
    };

    window.addEventListener('resize', handleResize);

    // 🧹 Cleanup function
    return () => {
      window.removeEventListener('resize', handleResize);
    };
  }, []); // Run once on mount

  return <div>Window width: {width}px</div>;
}

export default WindowSizeTracker;
