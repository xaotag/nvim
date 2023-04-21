local opts = {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = {enable = true}
    }
  },
  init_options = {provideFormatter = false}
}

return opts
