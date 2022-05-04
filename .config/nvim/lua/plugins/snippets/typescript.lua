local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

local M = {}

table.insert(
	M,
	s(
		"forof",
		fmt(
			[[
for (const {} of {}) {{
	{}
}}
]],
			{ i(1), i(2), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		"trycatch",
		fmt(
			[[
		try {{
			{}
		}} catch(e) {{
			logError('{}', e);
			return unhandledFailedResult();
		}}
]],
			{ i(0), i(1) }
		)
	)
)

table.insert(
	M,
	s(
		"af",
		fmt(
			[[
async {}({}){{
	{}
}}
]],
			{ i(1, "funcName"), i(2), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		"paf",
		fmt(
			[[
private async {}({}){{
	{}
}}
]],
			{ i(1, "funcName"), i(2), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		"eaf",
		fmt(
			[[
private async {}(req:Request, res:Response){{
	{}
}}
]],
			{ i(1, "funcName"), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		"sf",
		fmt(
			[[
async {}({}){{
	try {{
		{}
	}} catch(e) {{
		logError('{}:{}', e);
		return unhandledFailedResult();
	}}
}}
]],
			{ i(1, "funcName"), i(3), i(0), i(2, "serviceName"), rep(1) }
		)
	)
)

table.insert(
	M,
	s(
		"fget",
		fmt(
			[[
{} ({}) {{
	return this.hc.get<Result<{}>>(
		urlApi('{}'),
		{{observe: 'response'}}
	).pipe(ResultFilter.pipeFilter)
}}
]],
			{ i(1, "funcName"), i(2, "params"), i(3), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		"fpost",
		fmt(
			[[
{} ({}) {{
	return this.hc.post<Result<{}>>(
		urlApi('{}'),
		{{ {} }}
		{{observe: 'response'}}
	).pipe(ResultFilter.pipeFilter)
}}
]],
			{ i(1, "funcName"), i(2, "params"), i(3), i(4), i(0) }
		)
	)
)

table.insert(
	M,
	s(
		"ctrl",
		fmt(
			[[
export class {}Controller {{
	private static _instance: {}Controller;
	private readonly {}Svc: {}Service;
	private readonly router = Router();
	private constructor() {{
		this.{}Svc = {}Service.instance();
		this.initRouters();
	}}
	static instance() {{
		if(!{}Controller._instance) {{
			{}Controller._instance = new {}Controller();
		}}
		return {}Controller._instance;
	}}
	get routers() {{
		return this.router;
	}}
	private initRouters() {{
		{}
	}}
}}
]],
			{
				i(1),
				rep(1),
				l(l._1:lower(), 1),
				rep(1),
				l(l._1:lower(), 1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				i(0),
			}
		)
	)
)

table.insert(
	M,
	s(
		"svc",
		fmt(
			[[
export class {}Service {{
	private static _instance: {}Service;
	private readonly pool = StoreService.pool;
	static instance() {{
		if(!{}Service._instance) {{
			{}Service._instance = new {}Service();
		}}
		return {}Service._instance;
	}}
	{}
}}
]],
			{ i(1), rep(1), rep(1), rep(1), rep(1), rep(1), i(0) }
		)
	)
)

ls.add_snippets("typescript", M)