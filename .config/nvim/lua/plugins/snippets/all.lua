local ls = require("luasnip")

local s, i = ls.snippet, ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local M = {}

table.insert(
	M,
	s(
		"if",
		fmt(
			[[
if ({}) {{
	{}
}}
]],
			{ i(1), i(0) }
		)
	)
)

ls.add_snippets("all", M)