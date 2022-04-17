## How did we get here

well.. let's start from the very beginning, 
and I'll try to add some humour, will make silly mistakes, leave out some details and only focus on topics which interests me to come to point quickly.

almost four and half billion years ago, some one created a planet name earth 🌎 or other theory is, perhaps gravity pulled swirling gas 🌀 and dust ☄️ in to become the third planet from the Sun 🌞.

like, I mentioned earlier, let's leave out the details how it was formed and deal with Fact, earth 🌎 is here to stay for quite some more time.

soon, with water, air, fire, sky, earth became home to things which started crawling, swimming, walking and running all over it, let's call these living things species.

Most of these species have one common pattern in behavior. They all eat 🥣, drink 🍷, sleep 🛌 and every time this cycle is broken, some species survive and other die 🪦.

for example, Dinosaurs 🦖, mammoths 🦣 and big foot 🦶🏿 couldn't survive because they cycle was interrupted.
It's not, these species don't fight back with interruptions, they do, and when successful, they survive.
Like cockroaches 🪳, they lived before Dinosaurs 🦖 and still here living healthy.

Most recent latest versions of one such species name human 🧝, has one attribute missing called intelligence 🧐💡 which all other species ever had.

which concludes to my point, let's focus on one such species name human, it's behavior pattern i.e. eat 🥣, drink 🍷, sleep 🛌
and missing attribute called intelligence 🧐💡.

let's visualize these points to paint our big picture.

```@example
# we are using Julia Language for Graph analysis
# TigerGraph provide RESTAPI end points, GSQL and GRAPHSTUDIO to connect TIGERGRAPH
# pyTigerGraph is a Python based library to connect with GRAPH database and run GSQLs
# we will use Julia PyCall package to connect with pyTigerGraph library
#######################################################################
## **perhaps, some day I will re-write pyTigerGraph package in Julia ##
#######################################################################

# open Julia REPL, Jupyter or your favorite Julia IDE, run following

# first import all packages required to support our data analysis
# rest of this chapter assume that below packages are imported once
import Pkg
Pkg.add("DataFrames")
Pkg.add("CSV")
Pkg.add("PyCall")
Pkg.build("PyCall");

# you will also need to install pyTigerGraph in your python environment
# !pip install -U pyTigerGraph
```

!!! info

    before proceeding any further, please setup Tiger Graph Server instance at [tgcloud.io](https://tgcloud.io)
    please don't expect these credentials to work for you, as there is cost involved to keep this.

    hostName = "https://p2p.i.tgcloud.io"

    userName = "tigercloud"

    password = "tigercloud"

    conn = tg.TigerGraphConnection(host=hostName, username=userName, password=password)


---

*now once you have TigerGraph and Julia environments setup, let's jump on to setup sample graph, vertices and edges to get a hang of tools.*

## create graph, vertices and edges

!!! info
    Below code is an example of using Julia Langauge to call pytigergraph Python package, run GSQLs on TGCLOUD.

    In future, depending on demand, I may write pytigergprah package in Julia Lang.

```@example
import Pkg
# you may not need to add conda, pytigergraph
# if you already have python setup
# these instructions are specific for julia setup
Pkg.add("Conda")
ENV["PYTHON"] = "/usr/bin/python3"
using PyCall
using Conda
Conda.pip_interop(true;)
# Conda.pip_interop(true; [env::Environment="/usr/bin/python3"])
Conda.pip("install", "pyTigerGraph")
Conda.add("pyTigerGraph")
tg = pyimport("pyTigerGraph")
# please don't expect below credentials to work for you, and signup at tgcloud
hostName = "https://p2p.i.tgcloud.io"
userName = "amit"
password = "password"
graphName = "P2P"
conn = tg.TigerGraphConnection(host=hostName, username=userName, password=password, graphname=graphName)
# conn.gsql(getSchema)
```

!!! warning
    Operations that DO NOT need a Token
    
    Viewing the schema of your graph using functions such as getSchema and getVertexTypes does not require you to have an authentication token. A token is also not required to run gsql commands through pyTigerGraph.
    
    Sample Connection
    
    conn = tg.TigerGraphConnection(host='https://pytigergraph-demo.i.tgcloud.io', username='tigergraph' password='password' graphname='DemoGraph')
    
    Operations that DO need a Token

    A token is required to view or modify any actual DATA in the graph. Examples are: upserting data, deleting edges, and getting stats about any loaded vertices. A token is also required to get version data about the TigerGraph instance.

    Sample Connection

    conn = tg.TigerGraphConnection(host='https://pytigergraph-demo.i.tgcloud.io', username='tigergraph' password='password' graphname='DemoGraph', apiToken='av1im8nd2v06clbnb424jj7fp09hp049')


!!! note
    Below code is directly executed over Python environment
    
    first you will also need to install pyTigerGraph in your python environment,

    !pip install -U pyTigerGraph
    
    then execute following commands to create TGCloud Graph

```@python
import pyTigerGraph as tg
hostName = "https://p2p.i.tgcloud.io"
userName = "amit"
password = "password"
graphName = "P2P"
conn = tg.TigerGraphConnection(host=hostName, username=userName, password=password, graphname=graphName)

conn.gsql("ls")
conn.gsql('''USE GLOBAL
DROP ALL
''')

conn.gsql('''
  USE GLOBAL
  CREATE VERTEX Galaxy (PRIMARY_ID unit STRING, star BOOL, gas BOOL, dust BOOL, breathableAir BOOL, water BOOL, land BOOL, sky BOOL) WITH primary_id_as_attribute="true"
  CREATE VERTEX Species (PRIMARY_ID unit STRING, intelligence BOOL, crawl INT, swim INT, walk INT, runningSpeed INT, eat INT, drink INT, sleep INT) WITH primary_id_as_attribute="true"
  CREATE VERTEX ItemMaster (PRIMARY_ID unit STRING, drug BOOL, category STRING, essentials BOOL, luxury BOOL) WITH primary_id_as_attribute="true"
  CREATE DIRECTED EDGE live_in (From Species, To Galaxy, living_since DATETIME) WITH REVERSE_EDGE="is_home"
  CREATE UNDIRECTED EDGE behavior (From Species, To Species, like_date DATETIME)
  CREATE DIRECTED EDGE give_food (From Galaxy, To Species) WITH REVERSE_EDGE="feeds"
  CREATE DIRECTED EDGE essentials (From Species, To Species) WITH REVERSE_EDGE="survival_Kit"
  CREATE DIRECTED EDGE used_by (From ItemMaster, To Species)
''')
results = conn.gsql('CREATE GRAPH P2P(Galaxy, Species, ItemMaster, live_in, behavior, give_food, essentials, used_by)')
```

![Graph 1](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graph1.png?raw=true)
    
#### Loading Data

```example
conn.gsql('''
USE GLOBAL
USE GRAPH P2P
CREATE LOADING JOB P2P_PATH FOR GRAPH P2P {
DEFINE FILENAME file1 = "sampleData/galaxy.csv";
DEFINE FILENAME file2 = "sampleData/species.csv";
DEFINE FILENAME file3 = "sampleData/itemmaster.csv";
LOAD file1 TO VERTEX Galaxy VALUES ($"unit", $"star", $"gas", $"dust", $"breathableAir", $"water", $"land", $"sky") USING header="true", separator=",";
LOAD file2 TO VERTEX Species VALUES ($"unit", $"intelligence", $"crawl", $"swim", $"walk", $"runningSpeed", $"eat", $"drink", $"sleep") USING header="true", separator=",";
LOAD file3 TO VERTEX ItemMaster VALUES ($"unit", $"drug", $"category", $"essentials", $"luxury") USING header="true", separator=",";
}
''')

results = conn.gsql('RUN LOADING JOB P2P_PATH USING file1="sampleData/galaxy.csv", "sampleData/species.csv", "sampleData/itemmaster.csv"')
```

You can also manually upload your data to TGCloud.

    Please see, a copy of datasets can be found inside sampleData folder. or use sampleData jupter notebook to generate more volume data sets.

![Graph 2](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graph2.png?raw=true)

You can also manually map your data to vertices/edges in TGCloud.

![Graph 3](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graph3.png?raw=true)

** Do NOT forget to publish your data mappings and load data.**

![Graph 4](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graph4.png?raw=true)


**Conclusion**

I would love to share my queries with you in details (and you'll figure it out, that I cheated).
but here is the conclusion.

Human needs TP, Cleaning Supplies as much as "Morphine" or "Oxygen" and god forbid, perhaps "Ventilators".

But Cockroaches don't because Cockroaches are living before Dinosaurs and still around, and that is all because of their behaviors which helps them survive.

**which is Eat Less, Drink more, Sleep less and RUN all day long.**

![Graph 5](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graph5.png?raw=true)


*I am not sure, if you buy all the logic above or not, but I am sure, you now know how to create, plot and define graph, vertices and edges.*

In next chapter, I promise, I will not use silly logic and instead will focus on real life data and use cases.