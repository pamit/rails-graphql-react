import { useEffect, useState } from "react";

const useFetch = <T>(url: string): { data: T | null, loading: boolean} => {
    const [data, setData] = useState<T | null>(null);
    const [loading, setLoading] = useState<boolean>(true);

    useEffect(() => {
        fetch(url)
          .then(res => res.json())
          .then(json => {
            setData(json);
            setLoading(false);
          });
      }, [url]);

    return { data, loading };
};

export default useFetch;
