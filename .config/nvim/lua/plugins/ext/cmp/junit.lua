local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

function source.get_trigger_characters()
  return { "t" }
end

function source.complete(self, params, callback)
  if vim.bo.filetype ~= "java" then
    callback({ items = {}, isIncomplete = false })
    return
  end

  local indent_width = vim.fn.indent(vim.fn.line('.'))

  local snippet = table.concat({
    "@Test",
    "void testSomething() {",
    "  // TODO: implement",
    "}",
  }, "\n")

  callback({
    items = {
      {
        label = "Create JUnit test",
        insertText = snippet,
        kind = require("cmp").lsp.CompletionItemKind.Snippet,
      },
    },
    isIncomplete = false,
  })
end

return source

