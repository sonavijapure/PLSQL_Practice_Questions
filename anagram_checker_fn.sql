create or replace function anagram_checker_fn (
   v_string1 varchar2,
   v_string2 varchar2
) return varchar2 is
   res    varchar2(10) := 'TRUE';  -- assume they are anagrams initially
   v_char varchar2(10);
   cnt    number := 0;
begin
   if length(v_string1) <> length(v_string2) then
      return 'Given both strings "'
             || v_string1
             || '" and "'
             || v_string2
             || '" are not anagram to each other';
      res := 'FALSE';
   else
        --loop through first string
      for i in 1..length(v_string1) loop
         v_char := substr(
            v_string1,
            i,
            1
         );
         cnt := 0;  -- Reset count for each character

              -- Loop through the second string to count occurrences
         for l in 1..length(v_string2) loop
            if substr(
               v_string2,
               l,
               1
            ) = v_char then
               cnt := cnt + 1;
            end if;
         end loop;

            -- If the count of any character doesn't match, they are not anagrams
         if cnt = 0 then
            res := 'FALSE'; -- no need to check further
            exit;
         end if;
      end loop;
   end if;
   if res = 'TRUE' then
      return 'Given both strings "'
             || v_string1
             || '" and "'
             || v_string2
             || '" are anagram to each other';
   else
      return 'Given both strings "'
             || v_string1
             || '" and "'
             || v_string2
             || '" are not anagram to each other';
   end if;
end;