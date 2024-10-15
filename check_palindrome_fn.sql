create or replace FUNCTION check_palindrome_fn(v_string VARCHAR2)
RETURN VARCHAR2
IS
v_is_palindrome BOOLEAN := TRUE; -- Assume it is a palindrome
result VARCHAR2(50);
BEGIN
    FOR i IN 1 .. LENGTH(v_string) LOOP
        IF (SUBSTR(v_string, i, 1) != SUBSTR(v_string, LENGTH(v_string) - i + 1, 1)) THEN
            v_is_palindrome := FALSE; -- Set flag to false if characters do not match
            EXIT; -- Exit the loop early
        END IF;
    END LOOP;

    IF v_is_palindrome THEN
        RETURN 'Given string: ' || v_string || ' is a Palindrome';
    ELSE
        RETURN 'Given string: ' || v_string || ' is not a Palindrome';
    END IF;
END;