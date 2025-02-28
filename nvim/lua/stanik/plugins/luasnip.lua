return {
    "L3MON4D3/LuaSnip",

    config = function()
        local ls = require("luasnip")
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node

        ls.add_snippets("all", {
            -- XML documentation summary
            s("summary", {
                t("/// <summary>"),
                t({ "", "/// " }), i(1, "Summary description"),
                t({ "", "/// </summary>" }),
            }),
            -- Start method
            s("Start", {
                t("private void Start()"), t({ "", "{" }),
                t({ "    // Called on the first frame" }),
                t({ "    " }), i(1),
                t({ "", "}" }),
            }),
            -- Awake method
            s("Awake", {
                t("private void Awake()"), t({ "", "{" }),
                t({ "    // Called when the script instance is being loaded" }),
                t({ "    " }), i(1),
                t({ "", "}" }),
            }),
            -- Update method
            s("Update", {
                t("private void Update()"), t({ "", "{" }),
                t({ "    // Called every frame" }),
                t({ "    " }), i(1),
                t({ "", "}" }),
            }),
            -- FixedUpdate method
            s("FixedUpdate", {
                t("private void FixedUpdate()"), t({ "", "{" }),
                t({ "    // Called every fixed framerate frame" }),
                t({ "    " }), i(1),
                t({ "", "}" }),
            }),
            -- OnDrawGizmos method
            s("OnDrawGizmos", {
                t("private void OnDrawGizmos()"), t({ "", "{" }),
                t({ "    // Used for drawing gizmos in the editor" }),
                t({ "    " }), i(1),
                t({ "", "}" }),
            }),
            -- OnEnable method
            s("OnEnable", {
                t("private void OnEnable()"), t({ "", "{" }),
                t({ "    // Called when the object becomes enabled and active" }),
                t({ "    " }), i(1),
                t({ "", "}" }),
            }),
            -- OnDisable method
            s("OnDisable", {
                t("private void OnDisable()"), t({ "", "{" }),
                t({ "    // Called when the object becomes disabled" }),
                t({ "    " }), i(1),
                t({ "", "}" }),
            }),
            -- Debug.Log helper
            s("log", {
                t("Debug.Log("), i(1, "\"Log message\""), t(");"),
            }),
        })
    end
}
