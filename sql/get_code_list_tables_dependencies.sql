SELECT source_ns.nspname    AS source_schema,
       source_table.relname AS source_table,
       target_ns.nspname    AS target_schema,
       target_table.relname AS target_table
FROM pg_constraint c
         JOIN pg_class source_table
              ON source_table.oid = c.conrelid
         JOIN pg_namespace source_ns
              ON source_ns.oid = source_table.relnamespace
         JOIN pg_class target_table
              ON target_table.oid = c.confrelid
         JOIN pg_namespace target_ns
              ON target_ns.oid = target_table.relnamespace
WHERE c.contype = 'f'
  AND source_ns.nspname LIKE $1
    AND target_ns.nspname LIKE $1
ORDER BY source_schema, source_table;