; Combined DB method detection (Query/QueryRow/Exec) for both string types
(
(call_expression
  function: (selector_expression
    operand: (identifier)
    field: (field_identifier) @_method (#match? @_method "^(Query|QueryRow|Exec)$"))
  arguments: (argument_list
    (_)?  ; optional context
    [(interpreted_string_literal
       (interpreted_string_literal_content) @injection.content)
     (raw_string_literal
       (raw_string_literal_content) @injection.content)]))
  (#set! injection.language "sql")
)

; Sprintf detection
(
(call_expression
  function: (selector_expression
    operand: (identifier) @_pkg (#eq? @_pkg "fmt")
    field: (field_identifier) @_method (#eq? @_method "Sprintf"))
  arguments: (argument_list
    [(interpreted_string_literal
       (interpreted_string_literal_content) @injection.content)
     (raw_string_literal
       (raw_string_literal_content) @injection.content)]))
  (#set! injection.language "sql")
)

; Combined keyword-based detection for any SQL-like content
([
  (interpreted_string_literal_content)
  (raw_string_literal_content)
] @injection.content
  (#match? @injection.content "(SELECT|select|INSERT|insert|UPDATE|update|DELETE|delete|CREATE|create|ALTER|alter|DROP|drop|TRUNCATE|truncate|WITH|with|MERGE|merge).*(FROM|from|INTO|into|VALUES|values|SET|set|TABLE|table)|GROUP BY|group by|ORDER BY|order by|HAVING|having|JOIN|join|UNION|union|PRIMARY KEY|primary key|FOREIGN KEY|foreign key|CONSTRAINT|constraint|INDEX|index|ADD COLUMN|add column|DROP COLUMN|drop column|ALTER COLUMN|alter column|BEGIN|begin|COMMIT|commit|ROLLBACK|rollback")
  (#set! injection.language "sql"))
