push!(LOAD_PATH, "../src/")
using Documenter, P2P

makedocs(sitename="P2P.ai",
    pages=[
        "Introduction" => "introduction.md"
        "Tutorials" => [
            "About GL" => "tutorials/aboutgl.md"
            "GL Processes" => "tutorials/glprocesses.md"
            "ERD" => "tutorials/erd.md"
            "Installing Julia" => "tutorials/installation.md"
            "ELT vs ETL" => "tutorials/elt.md"
            "Self-Service Data Analytic" => "tutorials/selfservice.md"
            "Visualizations, Buttons, sliders, filters, n-D plots, plots vs graphs" => "tutorials/plots.md"
            "p-value, null hypothesis and real time analytic" => "tutorials/analytic.md"
            "Time Series, Impact analysis" => "tutorials/timeseries.md"
            "Basics of ML" => "tutorials/mlbasics.md"
            "ML for GL" => "tutorials/mlforgl.md"
            "NLP for GL" => "tutorials/nlp.md"
            "Graph Theory / Network Science" => "tutorials/graph.md"
        ]
        "API" => "api.md"
    ],
)