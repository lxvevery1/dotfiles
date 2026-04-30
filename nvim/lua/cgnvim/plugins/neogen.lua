return {
    "danymat/neogen",
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
    config = function()
        local neogen = require('neogen')

        neogen.setup({
            languages = {
                cs = {
                    template = {
                        annotation_convention = "xmldoc"
                    },
                    -- кастомный генератор
                    generator = {
                        func = {
                            { nil, "/// <summary>" },
                            { nil, "/// " },
                            { nil, "/// </summary>" },

                            -- params автоматически из treesitter
                            { "parameters", function(param)
                                return "/// <param name=\"" .. param.name .. "\"></param>"
                            end },

                            -- return только если не void
                            { "return", function(ret)
                                if ret and ret.type ~= "void" then
                                    return "/// <returns></returns>"
                                end
                            end },
                        }
                    }
                }
            }
        })
    end,
}
