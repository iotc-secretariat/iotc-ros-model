---
title: "{{ title }} `r variables$domain_title`."
subtitle: "Last updated: `r variables$last_update`"
author: "Author: [IOTC Secretariat](mailto:IOTC-Secretariat@fao.org)"
output:
  html_document:
    mathjax: null
    includes:
      in_header: "../templates/html_template_header.html"
    css: "../templates/html_template.css"
    number_sections: FALSE
    toc: yes
    toc_float:
      collapsed: FALSE
    anchor_sections: TRUE
    smooth_scroll: FALSE
---
```{r, setup, include=FALSE}
knitr::opts_chunk$set(fig.width = 8, echo = FALSE, message = FALSE)
```

# Abstract

{{ abstract_content }}

### Legend

```{r legend}
output_legend()
```

Columns that belong to a primary key are displayed in **bold**.

{{{ schema_sections }}}

