create or replace FUNCTION anagram_checker_fn (v_string1 VARCHAR2, v_string2 VARCHAR2) RETURN VARCHAR2 IS
res VARCHAR2(10) := 'FALSE';  -- setting  res variable as false
BEGIN
    FOR i IN 1..length(v_string1) LOOP
            FOR l IN REVERSE 1..length(v_string2) LOOP
                    IF SUBSTR(v_string1, i , 1) = SUBSTR(v_string2, l, 1) THEN
                        res := 'TRUE';
                    ELSE 
                        res := 'FALSE';
                    END IF; 
            END LOOP;

    END LOOP;
    IF res = 'TRUE' THEN
        RETURN 'Given both strings "' || v_string1 || '" and "' || v_string2 || '" are anagram to each other';
    ELSE
        RETURN 'Given both strings "' || v_string1 || '" and "' || v_string2 || '" are not anagram to each other';
    END IF;
END;