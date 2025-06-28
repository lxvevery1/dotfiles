return {
    "L3MON4D3/LuaSnip",

    ft = "cs",

    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node

        local function log_snippet(trigger)
            return s(trigger, {
                t("Debug.Log(\""), i(1, "Log message"), t("\");"),
            })
        end

        local function unity_method_snippet(name)
            return s(name, {
                t("private void " .. name .. "()"),
                t({ "", "{" }),
                t({ "", "    " }), i(1), -- Cursor is placed inside the method
                t({ "", "}" }),
            })
        end

        local function unity_method_physics_collider_snippet(name)
            return s(name, {
                t("private void " .. name .. "(Collider other)"),
                t({ "", "{" }),
                t({ "", "    " }), i(1), -- Cursor is placed inside the method
                t({ "", "}" }),
            })
        end

        local function unity_method_physics_collision_snippet(name)
            return s(name, {
                t("private void " .. name .. "(Collision collision)"),
                t({ "", "{" }),
                t({ "", "    " }), i(1), -- Cursor is placed inside the method
                t({ "", "}" }),
            })
        end

        ls.add_snippets("all", {

            -- XML documentation summary
            s("summary", {
                t("/// <summary>"),
                t({ "", "/// " }), i(1, "Summary description"),
                t({ "", "/// </summary>" }),
            }),

            s("feature", {
                t("/* --------------------- "),
                i(1, "What feature"),
                t({ " --------------------- */" }),
            }),
            unity_method_snippet("Start"),
            unity_method_snippet("Awake"),
            unity_method_snippet("Update"),
            unity_method_snippet("FixedUpdate"),
            unity_method_snippet("LateDisable"),
            unity_method_snippet("Reset"),
            unity_method_snippet("OnDestroy"),
            unity_method_snippet("OnEnable"),
            unity_method_snippet("OnDisable"),
            unity_method_snippet("OnDrawGizmos"),

            unity_method_physics_collider_snippet("OnTriggerEnter"),
            unity_method_physics_collider_snippet("OnTriggerStay"),
            unity_method_physics_collider_snippet("OnTriggerExit"),

            unity_method_physics_collision_snippet("OnCollisionEnter"),
            unity_method_physics_collision_snippet("OnCollisionExit"),
            unity_method_physics_collision_snippet("OnCollisionStay"),

            log_snippet("log"),
            log_snippet("Logger"),

        })
    end
}
