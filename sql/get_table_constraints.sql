SELECT c.conname,
       c.contype,
       pg_get_constraintdef(c.oid) AS definition
FROM pg_constraint c
         JOIN pg_class t ON t.oid = c.conrelid
         JOIN pg_namespace n ON n.oid = t.relnamespace
WHERE n.nspname = $1
  AND t.relname = $2
  AND c.contype = ANY (string_to_array($3::text, ',')::"char"[])
ORDER BY CASE c.contype
             WHEN 'p' THEN 1
             WHEN 'u' THEN 2
             WHEN 'f' THEN 3
             ELSE 4
             END,
         c.conname