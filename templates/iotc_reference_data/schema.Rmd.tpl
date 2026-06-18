```{r}
db_schema <- db_metadata$schema("{{ schema_name }}")
```

# Schema {{ schema_name }} {{{ schema_anchor }}}

#### Description

`r ifelse(is.na(db_schema$schema_description()), '<p class="error">Not filled</p>', paste0('*', db_schema$schema_description(), '*'))`

{{{ table_sections }}}