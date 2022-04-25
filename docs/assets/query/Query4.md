## loss in cash flow, income , revenue during 2020

    **please see:** to see meaningful results, increase sample size in Julia/Python notebook and create data at-least 5-10 million rows per data frame
    GitHub doesn't allow voluminous data upload, hence, I uploaded only 1000 rows per dataframe

    look at assets/sampleData/sampleData.ipynb file and change variable SampleSize,
    then re-run / extract sample data CSVs to load into Graph.

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
  CREATE VERTEX Account (PRIMARY_ID ID INT, ENTITY STRING, AS_OF_DATE DATETIME, CLASSIFICATION STRING,CATEGORY STRING, STATUS STRING,DESCR STRING,ACCOUNT_TYPE STRING) WITH primary_id_as_attribute="true"
  CREATE VERTEX Location (PRIMARY_ID ID INT, AS_OF_DATE DATETIME, CLASSIFICATION STRING,CATEGORY STRING, STATUS STRING,DESCR STRING,LOC_TYPE STRING) WITH primary_id_as_attribute="true"
  CREATE VERTEX Department (PRIMARY_ID ID INT, AS_OF_DATE DATETIME, CLASSIFICATION STRING,CATEGORY STRING, STATUS STRING,DESCR STRING,DEPT_TYPE STRING) WITH primary_id_as_attribute="true"
  CREATE VERTEX Ledger (PRIMARY_ID LEDGER STRING, FISCAL_YEAR INT, PERIOD INT, ORGID STRING, OPER_UNIT STRING, ACCOUNT INT, DEPT INT, LOCATION INT, POSTED_TOTAL STRING) WITH primary_id_as_attribute="true"
  CREATE DIRECTED EDGE by_account (From Ledger, To Account) WITH REVERSE_EDGE="account_family"
  CREATE DIRECTED EDGE by_location (From Ledger, To Location) WITH REVERSE_EDGE="region"
  CREATE DIRECTED EDGE by_department (From Ledger, To Department) WITH REVERSE_EDGE="dept_class"
''')
results = conn.gsql('CREATE GRAPH P2PFinSCM(Account, Location, Department, Ledger, by_account, by_location, by_department)')
```

![P2P Graph 1](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graphp2p1.png?raw=true)

```example
conn.gsql('''
USE GLOBAL
USE GRAPH P2P
CREATE LOADING JOB P2P_PATH FOR GRAPH P2P {
DEFINE FILENAME file1 = "sampleData/accounts.csv";
DEFINE FILENAME file2 = "sampleData/locations.csv";
DEFINE FILENAME file3 = "sampleData/department.csv";
DEFINE FILENAME file4 = "sampleData/ledger.csv";
LOAD file1 TO VERTEX Account VALUES ($"ENTITY", $"AS_OF_DATE", $"ID", $"CLASSIFICATION", $"CATEGORY", $"STATUS", $"DESCR", $"ACCOUNT_TYPE") USING header="true", separator=",";
LOAD file2 TO VERTEX Location VALUES ($"AS_OF_DATE", $"ID", $"CLASSIFICATION", $"CATEGORY", $"STATUS", $"DESCR", $"LOC_TYPE") USING header="true", separator=",";
LOAD file2 TO VERTEX Department VALUES ($"AS_OF_DATE", $"ID", $"CLASSIFICATION", $"CATEGORY", $"STATUS", $"DESCR", $"DEPT_TYPE") USING header="true", separator=",";
LOAD file4 TO VERTEX Ledger VALUES ($"LEDGER", $"FISCAL_YEAR", $"PERIOD", $"ORGID", $"OPER_UNIT", $"ACCOUNT", $"DEPT", $"LOCATION", $"POSTED_TOTAL") USING header="true", separator=",";
}
''')
results = conn.gsql('RUN LOADING JOB P2P_PATH USING file1="sampleData/galaxy.csv", "sampleData/species.csv", "sampleData/itemmaster.csv"')
```

## given employees are working remote, what are savings in operating expenses, if one fourth of locations in California are permanently closed

USE GRAPH P2PFinSCM
SET syntax_version="v2"

  pick cashflow accounts (reuse previous compiled queries)

#### a 2-hop query can produce similar results but can calculate average as well
// we need yearly average, for year 2020

CREATE QUERY acctRollupV41 (VERTEX<Account> a) {
    OrAccum  @visited = FALSE;
    AvgAccum @@avg_total;
    AvgAccum @@avg_period;
    
    start = {a};

    first_neighbors = SELECT tgt
        FROM start:s -(by_account:b)- Ledger:tgt
        ACCUM tgt.@visited += TRUE, s.@visited += TRUE;

    second_neighbors = SELECT tgt
        FROM first_neighbors -(:b)- :tgt
        WHERE tgt.@visited == FALSE
        AND tgt.FISCAL_YEAR == 2020
        POST-ACCUM @@avg_total += tgt.POSTED_TOTAL;
        POST-ACCUM @@avg_period += tgt.FISCAL_YEAR;

    PRINT second_neighbors;
    PRINT @@avg_total;
    PRINT @@avg_period;
}

#### a 2-hop query can produce similar results but can calculate average as well
// we need yearly average, for year <> 2020

CREATE QUERY acctRollupV42 (VERTEX<Account> a) {
    OrAccum  @visited = FALSE;
    AvgAccum @@avg_total;
    AvgAccum @@avg_period;
    
    start = {a};

    first_neighbors = SELECT tgt
        FROM start:s -(by_account:b)- Ledger:tgt
        ACCUM tgt.@visited += TRUE, s.@visited += TRUE;

    second_neighbors = SELECT tgt
        FROM first_neighbors -(:b)- :tgt
        WHERE tgt.@visited == FALSE
        AND tgt.FISCAL_YEAR !== 2020
        POST-ACCUM @@avg_total += tgt.POSTED_TOTAL;
        POST-ACCUM @@avg_period += tgt.FISCAL_YEAR;

    PRINT second_neighbors;
    PRINT @@avg_total;
    PRINT @@avg_period;
}