# Graph Analysis

In previous chapter, we loaded physical ERDs with actual datasets in Julia Dataframes.
I also shared, JuliaLang scripts to export these ERP datasets in csv.

In this chapter, we will create a **complete ERP graph** with vertices, edges and load these datasets into ERP P2P Graph.

let's get started.

---

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
graphName = "P2PFinSCM"
conn = tg.TigerGraphConnection(host=hostName, username=userName, password=password, graphname=graphName)
# conn.gsql(getSchema)
```

!!! note
    Below code is directly executed over Python environment
    
    first you will also need to install pyTigerGraph in your python environment,

    !pip install -U pyTigerGraph
    
    then execute following commands to create TGCloud Graph

## Finance Graph

```@python
import pyTigerGraph as tg
hostName = "https://p2p.i.tgcloud.io"
userName = "amit"
password = "password"
graphName = "P2PFinSCM"
conn = tg.TigerGraphConnection(host=hostName, username=userName, password=password, graphname=graphName)

conn.gsql("ls")
conn.gsql('''USE GLOBAL
DROP ALL
''')

conn.gsql('''
  USE GLOBAL
  CREATE VERTEX Account (ENTITY STRING, AS_OF_DATE DATETIME, PRIMARY_ID ID INT, CLASSIFICATION STRING,CATEGORY STRING, STATUS STRING,DESCR STRING,ACCOUNT_TYPE STRING) WITH primary_id_as_attribute="true"
  CREATE VERTEX Location (AS_OF_DATE DATETIME, PRIMARY_ID ID INT, CLASSIFICATION STRING,CATEGORY STRING, STATUS STRING,DESCR STRING,LOC_TYPE STRING) WITH primary_id_as_attribute="true"
  CREATE VERTEX Department (AS_OF_DATE DATETIME, PRIMARY_ID ID INT, CLASSIFICATION STRING,CATEGORY STRING, STATUS STRING,DESCR STRING,DEPT_TYPE STRING) WITH primary_id_as_attribute="true"
  CREATE VERTEX Ledger (PRIMARY_ID LEDGER STRING, FISCAL_YEAR INT, PERIOD INT, ORGID STRING, OPER_UNIT STRING, ACCOUNT INT, DEPT INT, LOCATION INT, POSTED_TOTAL STRING) WITH primary_id_as_attribute="true"
  CREATE DIRECTED EDGE by_account (From Ledger, To Account) WITH REVERSE_EDGE="booked_in"
  CREATE UNDIRECTED EDGE by_location (From Ledger, To Location) WITH REVERSE_EDGE="booked_in"
  CREATE DIRECTED EDGE by_department (From Ledger, To Department) WITH REVERSE_EDGE="booked_in"
''')
results = conn.gsql('CREATE GRAPH P2PFinSCM(Account, Location, Department, Ledger, by_account, by_location, by_department)')
```

![P2P Graph 1](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graphp2p1.png?raw=true)
    
#### Loading Data

```example
conn.gsql('''
USE GLOBAL
USE GRAPH P2P
CREATE LOADING JOB P2P_PATH FOR GRAPH P2P {
DEFINE FILENAME file1 = "sampleData/accounts.csv";
DEFINE FILENAME file2 = "sampleData/locations.csv";
DEFINE FILENAME file3 = "sampleData/department.csv";
DEFINE FILENAME file4 = "sampleData/ledger.csv";
LOAD file1 TO VERTEX Account VALUES ($"unit", $"star", $"gas", $"dust", $"breathableAir", $"water", $"land", $"sky") USING header="true", separator=",";
LOAD file2 TO VERTEX Location VALUES ($"unit", $"intelligence", $"crawl", $"swim", $"walk", $"runningSpeed", $"eat", $"drink", $"sleep") USING header="true", separator=",";
LOAD file3 TO VERTEX Department VALUES ($"unit", $"drug", $"category", $"essentials", $"luxury") USING header="true", separator=",";
LOAD file4 TO VERTEX Ledger VALUES ($"unit", $"drug", $"category", $"essentials", $"luxury") USING header="true", separator=",";
}
''')

results = conn.gsql('RUN LOADING JOB P2P_PATH USING file1="sampleData/galaxy.csv", "sampleData/species.csv", "sampleData/itemmaster.csv"')
```

You can also manually upload your data to TGCloud.

    Please see, a copy of datasets can be found inside sampleData folder. or use sampleData jupter notebook to generate more volume data sets.

![P2P Graph 2](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graphp2p2.png?raw=true)

You can also manually map your data to vertices/edges in TGCloud.

![P2P Graph 3](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graphp2p3.png?raw=true)

**Do NOT forget to publish your data mappings and load data.**

![P2P Graph 4](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graphp2p4.png?raw=true)
