SELECT column_name,
       data_type,
       udt_name,
       character_maximum_length,
       numeric_precision,
       numeric_scale,
       datetime_precision,
       is_nullable,
       ordinal_position
FROM information_schema.columns
WHERE table_schema = $1
  AND table_name = $2
ORDER BY ordinal_position