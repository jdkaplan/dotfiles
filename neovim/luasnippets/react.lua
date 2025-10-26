local snippets = {
  -- const [show, setShow] = useState(false);
  s("rstate", {
    t("const ["),
    i(1),
    t(","),
    l(l._1:gsub("^%l", string.upper):gsub("^", "set"), 1),
    t("] = useState("),
    i(0),
    t(");"),
  }),
}

local autosnippets = {}

return snippets, autosnippets
