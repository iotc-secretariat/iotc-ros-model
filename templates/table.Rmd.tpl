## Table {{ table_name }} {{{ table_anchor }}}

#### Description

`r render_description(variables$db_tables_description${{ table_gav }})`

#### Definition {.tabset}

##### Columns

```{r}
out_table_columns(variables$db_tables_columns${{ table_gav }})
```

##### Dependencies

```{r}
out_table_dependencies(variables$db_tables_dependencies${{ table_gav }})
```

##### Usages

```{r}
out_table_usages(variables$db_tables_usages${{ table_gav }})
```