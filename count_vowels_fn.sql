create or replace FUNCTION count_vowels_fn(v_string VARCHAR2) RETURN VARCHAR2 IS
cnt NUMBER := 0;
BEGIN
    FOR i IN 1..LENGTH(v_string) LOOP
    IF SUBSTR(LOWER(v_string),i,1) IN ('a','e','i','o','u') THEN
        cnt := cnt+1;
        END IF;
    END LOOP;
     RETURN 'Vowels count in given string is : ' || cnt;
END;