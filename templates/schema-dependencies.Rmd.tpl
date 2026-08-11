## Dependencies

Here is the dependency tree:

```{r}
out_data_dependencies(variables$db_reverse_dependencies_tree${{ schema_name }}, "{{ entry_point }}")
```

[Visit the dependency graph](`r sprintf('ROS_database%s_dependencies_%s.html', "{{ domain_report }}", "{{ schema_name }}")`){target='_blank'}