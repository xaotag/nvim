return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  ft = { "rust" },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        on_attach = function(client, bufnr)
          -- 覆盖默认LSP键位为rust-analyzer专用的更强大功能
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Rust 专用键位
          map("n", "<leader>rr", "<cmd>RustLsp run<cr>", "Run")
          map("n", "<leader>rt", "<cmd>RustLsp testables<cr>", "Test")
          map("n", "<leader>rd", "<cmd>RustLsp debug<cr>", "Debug")
          map("n", "<leader>rc", "<cmd>RustLsp openCargo<cr>", "Open Cargo.toml")
          map("n", "<leader>rp", "<cmd>RustLsp parentModule<cr>", "Parent Module")
          map("n", "<leader>rs", "<cmd>RustLsp searchScope<cr>", "Search Scope")
          map("n", "<leader>rw", "<cmd>RustLsp reloadWorkspace<cr>", "Reload Workspace")
          map("n", "<leader>rm", "<cmd>RustLsp expandMacro<cr>", "Expand Macro")
          map("n", "<leader>re", "<cmd>RustLsp explainError<cr>", "Explain Error")
          map("n", "<leader>ra", "<cmd>RustLsp codeAction<cr>", "Code Action")
          map("n", "J", "<cmd>RustLsp joinLines<cr>", "Join Lines")
          map("n", "K", "<cmd>RustLsp hover actions<cr>", "Hover Actions")
        end,
        settings = {
          ["rust-analyzer"] = {
            -- 代码质量检测
            check = {
              command = "clippy",
              features = "all",
              extraArgs = { "--", "-W", "clippy::all", "-W", "clippy::pedantic" },
              invocationStrategy = "on_save",
            },
            checkOnSave = {
              enable = true,
              command = "clippy",
              features = "all",
            },
            -- 补全增强
            completion = {
              autoimport = {
                enable = true,
              },
              postfix = {
                enable = true,
              },
              snippets = {
                custom = {
                  ["Arc::new"] = {
                    postfix = "arc",
                    body = "std::sync::Arc::new(${receiver})",
                    requires = "std::sync::Arc",
                    description = "Wrap in Arc",
                  },
                  ["Mutex::new"] = {
                    postfix = "mutex",
                    body = "std::sync::Mutex::new(${receiver})",
                    requires = "std::sync::Mutex",
                    description = "Wrap in Mutex",
                  },
                  ["Ok"] = {
                    postfix = "ok",
                    body = "Ok(${receiver})",
                    description = "Wrap in Ok",
                  },
                  ["Err"] = {
                    postfix = "err",
                    body = "Err(${receiver})",
                    description = "Wrap in Err",
                  },
                  ["Some"] = {
                    postfix = "some",
                    body = "Some(${receiver})",
                    description = "Wrap in Some",
                  },
                },
              },
            },
            -- 类型提示增强
            inlayHints = {
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closureCaptureHints = { enable = true },
              closureReturnTypeHints = { enable = "always" },
              closingBraceHints = { enable = true, minLines = 25 },
              discriminantHints = { enable = "always" },
              expressionAdjustmentHints = { enable = "always" },
              lifetimeElisionHints = { enable = "always", useParameterNames = true },
              parameterHints = { enable = true },
              rangeExclusiveHints = { enable = true },
              renderColons = true,
              typeHints = { enable = true, hideClosureInitialization = false },
            },
            -- 代码诊断增强
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
              disabled = { "unresolved-proc-macro" },
              enableExperimental = true,
              previewRustcOutput = true,
              useRustcErrorCode = true,
              warningsAsHint = {},
              warningsAsInfo = {},
            },
            -- 语义增强
            semanticHighlighting = {
              operator = {
                specialization = {
                  enable = true,
                },
              },
              punctuation = {
                enable = true,
                separate = {
                  macro = {
                    bang = true,
                  },
                },
              },
              strings = {
                enable = true,
              },
            },
            -- 工作区配置
            workspace = {
              symbol = {
                search = {
                  limit = 1024,
                  scope = "workspace_and_dependencies",
                },
              },
            },
            -- 格式化
            rustfmt = {
              extraArgs = { "+nightly" },
              rangeFormatting = {
                enable = true,
              },
            },
            -- Cargo 配置
            cargo = {
              autoreload = true,
              buildScripts = {
                enable = true,
                useRustcWrapper = true,
              },
              features = "all",
              loadOutDirsFromCheck = true,
            },
            -- 辅助功能
            assist = {
              emitMustUse = true,
              expressionFillDefault = "todo",
            },
            callInfo = {
              full = true,
            },
            hover = {
              actions = {
                debug = { enable = true },
                enable = true,
                gotoTypeDef = { enable = true },
                implementations = { enable = true },
                references = { enable = true },
                run = { enable = true },
              },
              documentation = {
                enable = true,
                keywords = { enable = true },
              },
            },
            -- 引用查找
            references = {
              excludeImports = false,
            },
            -- 重构
            rename = {
              allowExternalItems = true,
            },
            signatureInfo = {
              detail = "full",
              documentation = {
                enable = true,
              },
            },
            -- 语法树
            syntaxTree = {
              enable = true,
            },
            -- 测试
            test = {
              enable = true,
            },
            -- 代码 lens
            lens = {
              enable = true,
              debug = { enable = true },
              implementations = { enable = true },
              references = {
                adt = { enable = true },
                enumVariant = { enable = true },
                method = { enable = true },
                trait = { enable = true },
              },
              run = { enable = true },
            },
            --  proc macro 支持
            procMacro = {
              attributes = {
                enable = true,
              },
              enable = true,
            },
          },
        },
      },
    }
  end,
}
