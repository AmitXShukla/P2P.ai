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
LOAD file1 TO VERTEX Account VALUES ($"ENTITY", $"AS_OF_DATE", $"ID", $"CLASSIFICATION", $"CATEGORY", $"STATUS", $"DESCR", $"ACCOUNT_TYPE") USING header="true", separator=",";
LOAD file2 TO VERTEX Location VALUES ($"AS_OF_DATE", $"ID", $"CLASSIFICATION", $"CATEGORY", $"STATUS", $"DESCR", $"LOC_TYPE") USING header="true", separator=",";
LOAD file2 TO VERTEX Department VALUES ($"AS_OF_DATE", $"ID", $"CLASSIFICATION", $"CATEGORY", $"STATUS", $"DESCR", $"DEPT_TYPE") USING header="true", separator=",";
LOAD file4 TO VERTEX Ledger VALUES ($"LEDGER", $"FISCAL_YEAR", $"PERIOD", $"ORGID", $"OPER_UNIT", $"ACCOUNT", $"DEPT", $"LOCATION", $"POSTED_TOTAL") USING header="true", separator=",";
}
''')
results = conn.gsql('RUN LOADING JOB P2P_PATH USING file1="sampleData/galaxy.csv", "sampleData/species.csv", "sampleData/itemmaster.csv"')
```

You can also manually upload your data to TGCloud.

    Please see, a copy of datasets can be found inside sampleData folder. or use sampleData jupter notebook to generate more volume data sets.

![P2P Graph 2](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graphp2p2.png?raw=true)

You can also manually map your data to vertices/edges in TGCloud.

**Do NOT forget to publish your data mappings and load data.**

![P2P Graph 3](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graphp2p3.png?raw=true)

## Supply Chain Graph

```@python
import pyTigerGraph as tg
hostName = "https://p2p.i.tgcloud.io"
userName = "amit"
password = "password"
graphName = "P2PSCM"
conn = tg.TigerGraphConnection(host=hostName, username=userName, password=password, graphname=graphName)

conn.gsql("ls")
conn.gsql('''USE GLOBAL
DROP ALL
''')

conn.gsql('''
USE GLOBAL

CREATE VERTEX UNSPSC (PRIMARY_ID Code INT, KeyTO STRING, PARENT_KEY STRING, Title STRING) WITH primary_id_as_attribute="true"
CREATE VERTEX GUDID (PRIMARY_ID PrimaryDI STRING, publicDeviceRecordKey STRING, publicVersionStatus STRING, deviceRecordStatus STRING, publicVersionNumber STRING, publicVersionDate STRING, devicePublishDate STRING, deviceCommDistributionEndDate STRING, deviceCommDistributionStatus STRING, brandName STRING, versionModelNumber STRING, catalogNumber STRING, dunsNumber STRING, companyName STRING, deviceCount STRING, deviceDescription STRING, DMExempt STRING, premarketExempt STRING, deviceHCTP STRING, deviceKit STRING, deviceCombinationProduct STRING, singleUse STRING, lotBatch STRING, serialNumber STRING, manufacturingDate STRING, expirationDate STRING, donationIdNumber STRING, labeledContainsNRL STRING, labeledNoNRL STRING, MRISafetyStatus STRING, rx STRING, otc STRING, deviceSterile STRING, sterilizationPriorToUse STRING) WITH primary_id_as_attribute="true"

CREATE VERTEX LOCATION_MASTER (PRIMARY_ID city STRING, city_ascii STRING, state_id STRING, state_name STRING, county_fips STRING, county_name STRING, lat STRING, lng STRING, population STRING, density STRING, source STRING, military STRING, incorporated STRING, timezone STRING, ranking STRING, zips STRING, id STRING) WITH primary_id_as_attribute="true"

CREATE VERTEX ORG_MASTER (PRIMARY_ID ENTITY STRING, GROUPTOORG STRING, DEPARTMENT STRING, UNIT STRING) WITH primary_id_as_attribute="true"

CREATE VERTEX MSR (PRIMARY_ID UNIT STRING, MSR_DATE STRING, FROM_UNIT STRING, TO_UNIT STRING, GUDID STRING, QTY STRING) WITH primary_id_as_attribute="true"

CREATE VERTEX PO (PRIMARY_ID UNIT STRING, PO_DATE STRING, VENDOR STRING, GUDID STRING, QTY STRING, UNIT_PRICE STRING) WITH primary_id_as_attribute="true"

CREATE VERTEX SALES (PRIMARY_ID UNIT STRING, SALES_DATE STRING, STATUS STRING, SALES_RECEIPT_NUM STRING, CUSTOMER STRING, GUDID STRING, QTY STRING, UNIT_PRICE STRING) WITH primary_id_as_attribute="true"

CREATE VERTEX SHIPRECEIPT (PRIMARY_ID UNIT STRING, SHIP_DATE STRING, STATUS STRING, SHIPMENT_NUM STRING, CUSTOMER STRING, GUDID STRING, QTY STRING, UNIT_PRICE STRING) WITH primary_id_as_attribute="true"

CREATE VERTEX VENDOR (PRIMARY_ID brandName STRING, dunsNumber STRING, companyName STRING, rx STRING, otc STRING) WITH primary_id_as_attribute="true"

CREATE VERTEX VOUCHER (PRIMARY_ID UNIT STRING, VCHR_DATE STRING, STATUS STRING, VENDOR_INVOICE_NUM STRING, VENDOR STRING, GUDID STRING, QTY STRING, UNIT_PRICE STRING) WITH primary_id_as_attribute="true"

CREATE DIRECTED EDGE by_UNSPSC (From GUDID, To UNSPSC)
CREATE DIRECTED EDGE PO_LOCATION_MASTER (From PO, To LOCATION_MASTER)
CREATE DIRECTED EDGE PO_ORG_MASTER (From PO, To ORG_MASTER)
CREATE DIRECTED EDGE PO_VENDOR (From PO, To VENDOR)
CREATE DIRECTED EDGE PO_GUDID (From PO, To GUDID)
CREATE DIRECTED EDGE MSR_LOCATION_MASTER (From MSR, To LOCATION_MASTER)
CREATE DIRECTED EDGE MSR_ORG_MASTER (From MSR, To ORG_MASTER)
CREATE DIRECTED EDGE MSR_VENDOR (From MSR, To VENDOR)
CREATE DIRECTED EDGE MSR_GUDID (From MSR, To GUDID)
CREATE DIRECTED EDGE SALES_LOCATION_MASTER (From SALES, To LOCATION_MASTER)
CREATE DIRECTED EDGE SALES_ORG_MASTER (From SALES, To ORG_MASTER)
CREATE DIRECTED EDGE SALES_VENDOR (From SALES, To VENDOR)
CREATE DIRECTED EDGE SALES_GUDID (From SALES, To GUDID)
CREATE DIRECTED EDGE SHIPRECEIPT_LOCATION_MASTER (From SHIPRECEIPT, To LOCATION_MASTER)
CREATE DIRECTED EDGE SHIPRECEIPT_ORG_MASTER (From SHIPRECEIPT, To ORG_MASTER)
CREATE DIRECTED EDGE SHIPRECEIPT_VENDOR (From SHIPRECEIPT, To VENDOR)
CREATE DIRECTED EDGE SHIPRECEIPT_GUDID (From SHIPRECEIPT, To GUDID)
CREATE DIRECTED EDGE VOUCHER_LOCATION_MASTER (From VOUCHER, To LOCATION_MASTER)
CREATE DIRECTED EDGE VOUCHER_ORG_MASTER (From VOUCHER, To ORG_MASTER)
CREATE DIRECTED EDGE VOUCHER_VENDOR (From VOUCHER, To VENDOR)
CREATE DIRECTED EDGE VOUCHER_GUDID (From VOUCHER, To GUDID)
''')
results = conn.gsql('''CREATE GRAPH P2PSCM(UNSPSC, GUDID, LOCATION_MASTER, ORG_MASTER, MSR, PO, SALES, SHIPRECEIPT, VENDOR, VOUCHER, 
by_UNSPSC, PO_LOCATION_MASTER, PO_ORG_MASTER, PO_VENDOR, PO_GUDID, MSR_LOCATION_MASTER, MSR_ORG_MASTER, MSR_VENDOR, MSR_GUDID, SALES_LOCATION_MASTER, SALES_ORG_MASTER, SALES_VENDOR, SALES_GUDID, SHIPRECEIPT_LOCATION_MASTER, SHIPRECEIPT_ORG_MASTER, SHIPRECEIPT_VENDOR, SHIPRECEIPT_GUDID, VOUCHER_LOCATION_MASTER, VOUCHER_ORG_MASTER, VOUCHER_VENDOR, VOUCHER_GUDID)''')
```

**Do NOT forget to publish your data mappings and load data.**

![P2P Graph 4](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/graphp2p4.png?raw=true)
