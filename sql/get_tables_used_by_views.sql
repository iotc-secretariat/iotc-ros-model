SELECT
  view_schema,
  view_name,
  table_schema,
  table_name,
  format('%I.%I', view_schema, view_name) AS view_id,
  format('%I.%I', table_schema, table_name) AS table_id
FROM information_schema.view_table_usage
WHERE view_schema LIKE $1::text
ORDER BY view_schema, view_name, table_schema, table_name;