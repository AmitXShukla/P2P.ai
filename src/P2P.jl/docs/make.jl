push!(LOAD_PATH, "../src/")
using Documenter, P2P

makedocs(sitename="P2P.ai",
    pages=[
        "Introduction" => "index.md"
        "Define Problem" => "define.md"
        "How did we get here" => "path.md"
        "what do we know" => "process.md"
        "get Facts straight" => "facts.md"
        "graph" => "graph.md"
        "data insights" => "query.md"
        "analytics" => "analytics.md"
        "AI predictions" => "ml.md"
        "API" => "api.md"
    ],
)