```{r}
db_table_gav <- "{{ table_gav }}"
db_table_description <- db_tables_description[[db_table_gav]]
db_table_columns <- db_tables_columns[[db_table_gav]]
db_table_dependencies <- db_tables_dependencies[[db_table_gav]]
db_table_usages <- db_tables_usages[[db_table_gav]]
with_dependencies <- nrow(db_table_dependencies) > 0
with_usages <- nrow(db_table_usages) > 0
```

## Table {{ table_name }} {{{ table_anchor }}}

#### Description

`r render_description(db_table_description)`

#### Definition {.tabset}

##### Columns

```{r}
out_table_columns(db_table_columns)
```

##### Dependencies

`r if (!with_dependencies) { "NO DATA" }`
```{r}
if (with_dependencies) {
  out_table_dependencies(db_table_dependencies)
}
```

##### Usages

`r if (!with_usages) { "NO DATA" }`
```{r}
if (with_usages) {
  out_table_usages(db_table_usages)
}
```