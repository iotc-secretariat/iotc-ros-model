```{r}
db_schema <- db_metadata$schema("{{ schema_name }}")
```

# Schema {{ schema_name }} {{{ schema_anchor }}}

#### Description

`r render_description(db_schema$schema_description())`

{{{ extra_content }}}

{{{ table_sections }}}