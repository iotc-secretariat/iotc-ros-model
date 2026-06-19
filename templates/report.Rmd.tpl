---
title: "{{title}}"
subtitle: "{{sub_title}}"
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

| Icon | Meaning |
|------|---------|
| <span class="pk-icon"></span> | Primary Key column |
| <span class="fk-icon"></span> | Foreign Key column |
| <span class="mandatory-icon"></span> | Mandatory (NOT NULL) column |

Columns that belong to a primary key are displayed in **bold**.

{{{ schema_sections }}}

