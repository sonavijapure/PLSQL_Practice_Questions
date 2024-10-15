create or replace FUNCTION calculate_fibonacci_fn(len NUMBER) RETURN VARCHAR2 IS
m NUMBER := 0; 
n NUMBER := 1;
res NUMBER := 0;
BEGIN
    IF len = 0 THEN
    RETURN m;
    ELSIF len = 1 THEN
    RETURN n;
    ELSE
    FOR i IN 2..len LOOP
        res := m + n;
        m := n;
        n := res;
    END LOOP;
    END IF;
    RETURN 'The ' || len ||'th Fibonacci number is: '|| res ;
END;