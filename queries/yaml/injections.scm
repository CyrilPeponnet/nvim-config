(
	(block_mapping_pair
		key: (flow_node (plain_scalar) @key)
		value: ((block_node (block_scalar)) @injection.content)
	)
	(#match? @key "^script$")
	(#set! injection.include-children)
	(#set! injection.language "lua")
)

(
	(block_mapping_pair
		key: (flow_node (plain_scalar) @key)
		value: ((block_node (block_scalar)) @injection.content)
	)
	(#match? @key "^(assignPolicy|accessPolicy|contentPolicy|defaultRules|rules)$")
	(#set! injection.include-children)
	(#set! injection.language "rego")
)
