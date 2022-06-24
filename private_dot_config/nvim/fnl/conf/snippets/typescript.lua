local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local d = ls.dynamic_node
local r = ls.restore_node

return {
	-- class
	s("class", {
		t("class "),
		i(1, "class_name"),
		t(" "),
		c(2, {
			t("{"),
			sn(nil, {
				t("extends "),
				i(1, "other_class"),
				t(" {"),
			}),
			sn(nil, {
				t("implements "),
				i(1, "an_interface"),
				t(" {"),
			}),
		}),
		t({ "", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	-- constructor
	s("ctor", {
		c(1, {
			t(""),
			t("public "),
			t("private "),
			t("protected "),
		}),
		t({ "constructor() {", "\tsuper()", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	-- function
	s("func", {
		c(1, {
			t("function "),
			t("async function "),
			t("function* "),
		}),
		i(2, "function_name"),
		-- TODO: Receive parameters
		t({ "()" }),
		d(3, function(args)
			local function_type = args[1][1]
			if function_type == "function " then
				return sn(nil, {
					t(": "),
					r(1, "return_type", i(nil, "void")),
				})
			end
			if function_type == "async function " then
				return sn(nil, {
					t(": Promise<"),
					r(1, "return_type", i(nil, "void")),
					t(">"),
				})
			end
			if function_type == "function* " then
				return sn(nil, {
					t(": Generator<"),
					r(1, "return_type", i(nil, "void")),
					t(", "),
					i(2, "void"),
					t(", "),
					i(3, "unknown"),
					t(">"),
				})
			end
			return sn(nil, { t("") })
		end, { 1 }),
		t({ " {", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	-- try/catch
	s("try", {
		t({ "try {", "\t" }),
		i(0, "// code here"),
		t({ "", "} catch(error) {", "\t" }),
		i(1, "// handle error here"),
		t({ "", "}" }),
	}),
}
