LAZY_PLUGIN_SPEC = {}

function ET_SPEC(item)
  -- local plugin_dir = "et/plugins/"
  -- local plugin_spec = plugin_dir .. item
  table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

