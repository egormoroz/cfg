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
  (#match? @injection.content "(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP|TRUNCATE|WITH|MERGE).*(FROM|INTO|VALUES|SET|TABLE)|GROUP BY|ORDER BY|HAVING|JOIN|UNION|PRIMARY KEY|FOREIGN KEY|CONSTRAINT|INDEX|ADD COLUMN|DROP COLUMN|ALTER COLUMN|BEGIN|COMMIT|ROLLBACK")
  (#set! injection.language "sql"))
