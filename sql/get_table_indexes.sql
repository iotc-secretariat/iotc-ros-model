SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = $1
  AND tablename = $2
ORDER BY indexname