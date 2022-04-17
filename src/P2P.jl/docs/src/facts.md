# Getting Facts data

!!! info "ERP Data Structure"

    In this chapter, we will read, write and understand typical Finance, Supply chain datasets in Julia language. These datasets will layout foundations for Finance, Supply Chain Anaytics.

    **Target Audience:** This chapter, is meant for Julia Language consultants, ERP Analysts, IT Developers, Finance, Supply chain, HR & CRM managers, executive leaders or anyone curious to implement data science concepts in ERP space.

    **Once we understand these datasets, in following chapters, we will create Graphs, Vertices and Edges for data analysis, load actual data into Graphs.P2P.jl package supports these ERP systems data structures.**

most of the time, Organizations store these datasets in RDBMS tables, document databases and in some case, actual PDFs, images serve as document data itself.

In previous chapter, we saw business process operational workflow diagram and also learned high level physical ERDs.

In this chapter, we will use Julia language and Julia packages to mimic Finance & Supply chain data. Majority of this data is **sample data** and **DOES NOT**  bear any resemblance to real life data.

at the same time, I am using lots of actual real life data like UNSPSC codes, GUDID, Vendor, Item master data. Also, These datasets are not specific to any particular ERP systems like SAP, Oracle etc.

However, these sample dataset below are very close to real life data sets and are great assets to learn ERP systems architecture.


let's get started.

---

**Background:** Most of Enterprise ERP providers like SAP, Oracle, Microsoft build HCM, Finance, Supply Chain, CRM like systems, which store data in highly structured RDBMS tables.
Recent advancements in ERP systems also support authoring non-structured data like digital invoices, receipt or hand-held OCR readers.

All of these ERP systems are great OLTP systems, but depend on Analytic systems for creating dashboards, ad-hoc analysis, operational reporting or live predictive analytics.

Further, ERP systems depend on ELT/ELT or 3rd party tools for data mining, analysis and visualizations.

While data engineers use Java, Scala, SPARK based big data solutions to move data, they depend on 3rd party BI Reporting tools for creating dashboards, use Data Mining tools for data cleansing and AI Languages for advance predictive analytics.

When I started learning more about Julia Language, I thought of using Julia Language to solve ERP Analytics multiple languages problem.
Why not just use Julia Language to move, clean massive data set as Big data reporting solution, as Julia support multi-threading, distributing parallel computing.
Julia language and associated packages has first class support for large arrays, which can be used for data analysis.

and Julia has great visualization packages to publish interactive dashboards, live data reporting.

best of all, Julia is great in numerical computing, advance data science machine learning.

This blog, I am sharing my notes specific to perform typical ERP data analysis using Julia Language.

-----

## - About ERP Systems, General Ledger & Supply chain
A typical ERP system consists of many modules based on business domain, functions and operations.
GL is core of Finance and Supply chain domains and Buy to Pay, Order to Cash deal with different aspects of business operations in an Organization.
Many organization, use ERPs in different ways and may chose to implement all or some of the modules.
You can find examples of module specific business operations/processes diagram here.
- [General Ledger process flow](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/gl.png)
- [Account Payable process flow](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/ap.png)
- [Tax Analytics](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/tax.png)
- [Sample GL ERD - Entity Relaton Diagram](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/gl_erd.png)

A typical ERP modules list looks like below diagram.

![ERP Modules](https://github.com/AmitXShukla/AmitXShukla.github.io/raw/master/blogs/PlutoCon/ERP_modules.png)

A typical ERP business process flow looks like below diagram.

![ERP Processes](https://github.com/AmitXShukla/P2P.ai/blob/main/docs/assets/images/ERD_logical.png?raw=true)

A typical GL Balance sheet, Cash-flow or Income Statement looks like this 

[click here](https://s2.q4cdn.com/470004039/files/doc_financials/2020/q4/FY20_Q4_Consolidated_Financial_Statements.pdf)

In this notebook, I will do my best to cite examples from real world data like above mentioned GL Financial statement.

---

## start with Julia 
It literally takes < 1 min to install Julia environments on almost any machine.

Here is [link to my tutorial](https://amit-shukla.medium.com/setup-local-machine-ipad-android-tablets-for-julia-lang-data-science-computing-823d84f2cb28), which discuss Julia installation on different machines (including remote and mobile tablets).

## adding Packages

```@example
using Pkg
Pkg.add("DataFrames")
Pkg.add("Dates")
Pkg.add("CategoricalArrays")
using DataFrames, Dates, CategoricalArrays
Pkg.status()
```

**rest of this blog, I will assume, all packages are added and imported in current namespace/notebook scope.**
    
```@example
# run one command at a time
repeat(["AMIT","SHUKLA"], inner=5) # repeat list/string number of times
fill("34", 4) # repeat list/string number of times
range(1.0, stop=9.0, length=100) # generate n number of equal values between start and stop values
11000:1000:45000 # genarate a range of # from start to finish with set intervals
collect(1:4) # collect funtion collect all values in list
rand([1,2,3,4]) # random value from a list of values
rand(11000:1000:45000) # random value from a list of values
randn() # random # from a list of float values (+ or -)
```

```@example
using DataFrames, CategoricalArrays
# run one command at a time
# basic dataframe is constructed by passing column vectors (think of adding one excel column at a time)
org = "Apple Inc" # is a simple string
_ap = [1,2] # this is a vector

ap = categorical(_ap) # this is a vector
fy = categorical(repeat([2022], inner=2)) # this is a vector

actuals, budget = (98.40, 100) # this is a tuple
amount = (actuals = 98.54, budget = 100) # this is a named tuple
df_Ledger = DataFrame(Entity=fill(org), FiscalYear=fy, AccountingPeriod = ap, Actuals = actuals, Budget = budget)
# fill(org) or org will produce same results

# run one command at a time
# adding one row at a time, can be done, but is not very efficient
push!(df_Ledger, Dict(:Entity => "Google", :FiscalYear => 2022, 
        :AccountingPeriod => 1, :Actuals => 95.42, :Budget => 101))
push!(df_Ledger, Dict(:Entity => "Google", :FiscalYear => 2022, 
        :AccountingPeriod => 2, :Actuals => 91.42, :Budget => 99))
```

## create Finance Data model

Chart of accounts (organized hierarchy of account groups in tree form), Location/Department or Product based hierarchy allows businesses to group and report organization activities based on business processes.

These hierarchical grouping help capture monetary and statistical values of organization in finance statements.

---

To create Finance Data model and 
[Ledger Cash-flow or Balance Sheet like statements](https://s2.q4cdn.com/470004039/files/doc_financials/2020/q4/FY20_Q4_Consolidated_Financial_Statements.pdf),
We need associated dimensions (chartfields like chart of accounts).

We will discuss how to load actual data from CSV or RDBMS later. We will also learn how to group and create chartfield hierarchies later.

But for now, first Let's start with creating fake ACCOUNT, department and location chartfields.

```@example
using DataFrames, Dates
# create dummy data
accountsDF = DataFrame(
    ENTITY = "Apple Inc.",
    AS_OF_DATE=Date("1900-01-01", dateformat"y-m-d"),
    ID = 11000:1000:45000,
    CLASSIFICATION=repeat([
        "OPERATING_EXPENSES","NON-OPERATING_EXPENSES", "ASSETS","LIABILITIES","NET_WORTH","STATISTICS","REVENUE"
                ], inner=5),
    CATEGORY=[
        "Travel","Payroll","non-Payroll","Allowance","Cash",
        "Facility","Supply","Services","Investment","Misc.",
        "Depreciation","Gain","Service","Retired","Fault.",
        "Receipt","Accrual","Return","Credit","ROI",
        "Cash","Funds","Invest","Transfer","Roll-over",
        "FTE","Members","Non_Members","Temp","Contractors",
        "Sales","Merchant","Service","Consulting","Subscriptions"],
    STATUS="A",
    DESCR=repeat([
    "operating expenses","non-operating expenses","assets","liability","net-worth","stats","revenue"], inner=5),
    ACCOUNT_TYPE=repeat(["E","E","A","L","N","S","R"],inner=5));

show("Accounts DIM size is: "), show(size(accountsDF)), show("Accounts Dim sample: "), accountsDF[collect(1:5:35),:]
```

There is lot to unpack here in above Julia code and lot is wrong (not best practice for sure).

First, **what is a dataframe anyway**, think of Julia DataFrame as tabular representation of data arranged in rows and columns. Unlike SQL, you should get into habit of reading and writing one column at a time (not because of reason, you can't read/write rows) for faster performance. Each column is an Array or a list of values, referred as vector.

Above Julia code creates accounts dataframe with columns name as AS_OF_DATE, DESCR, CATEGORY, ACCOUNT_TYPE, CLASSIFICATION, STATUS.

There are 35 rows, with same AS_OF_DATE, IDs starting from 11000-45000 in 1000 incremental values, all with STATUS = A (Active), 7 distinct Descriptions and account types (E=Expense, L=Liability, A= Assets, N=Net worth, S=Stats, R=Revenue) repeating 5 times per category.

For 35 rows, it's fine to store data like this, but now is a good time to learn about Categorical and Pooled Arrays, in case when dataframe has millions of rows.

#### Accounts chartfield

```@example
using Pkg, DataFrames, CategoricalArrays, PooledArrays, Dates

# here CLASSIFICATION column vector stores 3500 distinct values in an array
CLASSIFICATION=repeat(["OPERATING_EXPENSES","NON-OPERATING_EXPENSES", "ASSETS","LIABILITIES","NET_WORTH","STATISTICS","REVENUE"
                ], inner=500)

cl = categorical(CLASSIFICATION)
levels(cl)

# using PooledArrays
pl = categorical(CLASSIFICATION)
levels(pl)

# show values in tabular format
# run one command at a time
df = DataFrame(Dict("Descr" => "CLASSIFICATION...ARR...", "Value" => size(CLASSIFICATION)[1]))
push!(df,("CAT...ARR...",size(cl)[1]))
push!(df,("CAT...ARR..COMPRESS.",size(compress(cl))[1]))
push!(df,("POOL...ARR...",size(pl)[1]))
push!(df,("POOL...ARR..COMPRESS.",size(compress(pl))[1]))
push!(df,("CAT...LEVELs...",size(levels(cl))[1]))
push!(df,("POOL...LEVELs...",size(levels(pl))[1]))
push!(df,("CLASSIFICATION...MEMSIZE", Base.summarysize(CLASSIFICATION)))
push!(df,("CAT...ARR...MEMSIZE", Base.summarysize(cl)))
push!(df,("POOL...ARR...MEMSIZE", Base.summarysize(pl)))
push!(df,("CAT...ARR..COMPRESS...MEMSIZE", Base.summarysize(compress(cl))))
push!(df,("POOL...ARR..COMPRESS...MEMSIZE", Base.summarysize(compress(pl))))

first(df,5)

accountsDF = DataFrame(
    ENTITY = "Apple Inc.",
    AS_OF_DATE=Date("1900-01-01", dateformat"y-m-d"),
    ID = 11000:1000:45000,
    CLASSIFICATION=repeat([
        "OPERATING_EXPENSES","NON-OPERATING_EXPENSES", "ASSETS","LIABILITIES","NET_WORTH","STATISTICS","REVENUE"
                ], inner=5),
    CATEGORY=[
        "Travel","Payroll","non-Payroll","Allowance","Cash",
        "Facility","Supply","Services","Investment","Misc.",
        "Depreciation","Gain","Service","Retired","Fault.",
        "Receipt","Accrual","Return","Credit","ROI",
        "Cash","Funds","Invest","Transfer","Roll-over",
        "FTE","Members","Non_Members","Temp","Contractors",
        "Sales","Merchant","Service","Consulting","Subscriptions"],
    STATUS="A",
    DESCR=repeat([
    "operating expenses","non-operating expenses","assets","liability","net-worth","stats","revenue"], inner=5),
    ACCOUNT_TYPE=repeat(["E","E","A","L","N","S","R"],inner=5))
```

**Categorical and Pooled Arrays** as name suggests, are data structure to store voluminous data efficiently,specially when a column in a data frame has small number of distinct values (aka levels), repeated across entire column vector.

as an example, Finance Ledger may have millions of transactions and every row has one of these seven type of accounts. It's not recommended to store repeating value of entire string in every row. Instead, using a Categorical or PooledArray data type, memory/data size can be significantly reduced with out losing any data quality. (size(..) stays same for original, Categorical and PooledArray data type.

as you can see in above example, size of categorical / pooled array data type matches with original column vector but significantly reduces size/memory of data. (Base.summarysize(...)) is reduced 50% and is further reduced by 85% if used with compress(...))

Using Categorical Array type over PooledArray is recommended when there are fewer unique values, user need meaningful ordering and grouping. On the other hand, PoolArray is preferred when small memory usage is needed.

#### Department chartfield
```@exmaple
using DataFrames
## create Accounts chartfield
# DEPARTMENT Chartfield
deptDF = DataFrame(
    AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
    ID = 1100:100:1500,
    CLASSIFICATION=["SALES","HR", "IT","BUSINESS","OTHERS"],
    CATEGORY=["sales","human_resource","IT_Staff","business","others"],
    STATUS="A",
    DESCR=[
    "Sales & Marketing","Human Resource","Infomration Technology","Business leaders","other temp"
        ],
    DEPT_TYPE=["S","H","I","B","O"]);
size(deptDF),deptDF[collect(1:5),:]
```

#### Location chartfield
```@exmaple
using DataFrames
locationDF = DataFrame(
    AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
    ID = 11:1:22,
    CLASSIFICATION=repeat([
        "Region A","Region B", "Region C"], inner=4),
    CATEGORY=repeat([
        "Region A","Region B", "Region C"], inner=4),
    STATUS="A",
    DESCR=[
"Boston","New York","Philadelphia","Cleveland","Richmond",
"Atlanta","Chicago","St. Louis","Minneapolis","Kansas City",
"Dallas","San Francisco"],
    LOC_TYPE="Physical");
locationDF[:,:]
```

#### Ledger FACT
```@example
## pu
using DataFrames, Dates
accountsDF = DataFrame(
    ENTITY = "Apple Inc.",
    AS_OF_DATE=Date("1900-01-01", dateformat"y-m-d"),
    ID = 11000:1000:45000,
    CLASSIFICATION=repeat([
        "OPERATING_EXPENSES","NON-OPERATING_EXPENSES", "ASSETS","LIABILITIES","NET_WORTH","STATISTICS","REVENUE"
                ], inner=5),
    CATEGORY=[
        "Travel","Payroll","non-Payroll","Allowance","Cash",
        "Facility","Supply","Services","Investment","Misc.",
        "Depreciation","Gain","Service","Retired","Fault.",
        "Receipt","Accrual","Return","Credit","ROI",
        "Cash","Funds","Invest","Transfer","Roll-over",
        "FTE","Members","Non_Members","Temp","Contractors",
        "Sales","Merchant","Service","Consulting","Subscriptions"],
    STATUS="A",
    DESCR=repeat([
    "operating expenses","non-operating expenses","assets","liability","net-worth","stats","revenue"], inner=5),
    ACCOUNT_TYPE=repeat(["E","E","A","L","N","S","R"],inner=5))
# DEPARTMENT Chartfield
deptDF = DataFrame(
    AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
    ID = 1100:100:1500,
    CLASSIFICATION=["SALES","HR", "IT","BUSINESS","OTHERS"],
    CATEGORY=["sales","human_resource","IT_Staff","business","others"],
    STATUS="A",
    DESCR=[
    "Sales & Marketing","Human Resource","Infomration Technology","Business leaders","other temp"
        ],
    DEPT_TYPE=["S","H","I","B","O"]);
size(deptDF),deptDF[collect(1:5),:]

locationDF = DataFrame(
    AS_OF_DATE=Date("2000-01-01", dateformat"y-m-d"), 
    ID = 11:1:22,
    CLASSIFICATION=repeat([
        "Region A","Region B", "Region C"], inner=4),
    CATEGORY=repeat([
        "Region A","Region B", "Region C"], inner=4),
    STATUS="A",
    DESCR=[
"Boston","New York","Philadelphia","Cleveland","Richmond",
"Atlanta","Chicago","St. Louis","Minneapolis","Kansas City",
"Dallas","San Francisco"],
    LOC_TYPE="Physical");
locationDF[:,:]

# creating Ledger
ledgerDF = DataFrame(
            LEDGER = String[], FISCAL_YEAR = Int[], PERIOD = Int[], ORGID = String[],
            OPER_UNIT = String[], ACCOUNT = Int[], DEPT = Int[], LOCATION = Int[],
            POSTED_TOTAL = Float64[]
            );

# create 2020 Period 1-12 Actuals Ledger 
l = "Actuals";
fy = 2020;
for p = 1:12
    for i = 1:10^5
        push!(ledgerDF, (l, fy, p, "ABC Inc.", rand(locationDF.CATEGORY),
            rand(accountsDF.ID), rand(deptDF.ID), rand(locationDF.ID), rand()*10^8))
    end
end

# create 2021 Period 1-4 Actuals Ledger 
l = "Actuals";
fy = 2021;
for p = 1:4
    for i = 1:10^5
        push!(ledgerDF, (l, fy, p, "ABC Inc.", rand(locationDF.CATEGORY),
            rand(accountsDF.ID), rand(deptDF.ID), rand(locationDF.ID), rand()*10^8))
    end
end

# create 2021 Period 1-4 Budget Ledger 
l = "Budget";
fy = 2021;
for p = 1:12
    for i = 1:10^5
        push!(ledgerDF, (l, fy, p, "ABC Inc.", rand(locationDF.CATEGORY),
            rand(accountsDF.ID), rand(deptDF.ID), rand(locationDF.ID), rand()*10^8))
    end
end

# here is ~3 million rows ledger dataframe
first(ledgerDF,5)
```
## Supply chain data model

you will need following packages.

```@example
using Pkg
Pkg.add("DataFrames")
Pkg.add("Dates")
Pkg.add("CategoricalArrays")
Pkg.add("Interact")
Pkg.add("WebIO")
Pkg.add("CSV")
Pkg.add("XLSX")
Pkg.add("DelimitedFiles")
Pkg.add("Distributions")
Pkg.build("WebIO")
Pkg.status();

using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
```

*rest of this blog, I will assume, you have added all packages and imported in current namespace/notebook scope.*

#### Supply Chain Data
We already covered DataFrames and ERP Finance data model in previous sections. in below section, let's recreate all Supply Chain DataFrames to continue advance analytics and visualization.

!!! note
    All of Finance and supply chain data discussed here is also uploaded in GitHub repo under sampleData folder.
    This same script can be used to produce more voluminous data.


#### Dimensions

- Item master, Item Attribs, Item Costing

    **UNSPSC:**  The United Nations Standard Products and Services Code® (UNSPSC®) is a global classification system of products and services.
                These codes are used to classify products and services.
    
    **GUDID:** The Global Unique Device Identification Database (GUDID) is a database administered by the FDA that will serve as a reference catalog for every device with a unique device identifier (UDI).

    **GTIN:** Global Trade Item Number (GTIN) can be used by a company to uniquely identify all of its trade items. GS1 defines trade items as products or services that are priced, ordered or invoiced at any point in the supply chain.

    **GMDN:** The Global Medical Device Nomenclature (GMDN) is a comprehensive set of terms, within a structured category hierarchy, which name and group ALL medical device products including implantables, medical equipment, consumables, and diagnostic devices.
    
    
- Vendor master, Vendor Attribs, Vendor Costing
    Customer/Buyer/Procurement Officer Attribs
    shipto, warehouse, storage & inventory locations

#### Transactions

-   PurchaseOrder
-   MSR - Material Service
-   Voucher
-   Invoice
-   Receipt
-   Shipment
-   Sales, Revenue
-   Travel, Expense, TimeCard
-   Accounting Lines

## Item Master
```@example
import Pkg
Pkg.add("XLSX")
Pkg.add("CSV")
using XLSX, CSV, DataFrames
###############################
## create SUPPLY CHAIN DATA ###
###############################
# Item master, Item Attribs, Item Costing ##
#       UNSPSC, GUDID, GTIN, GMDN
############################################

##########
# UNSPSC #
##########
# UNSPSC file can be downloaded from this link https://www.ungm.org/Public/UNSPSC
# xf = XLSX.readxlsx("assets/sampleData/UNGM_UNSPSC_09-Apr-2022..xlsx")
# xf will display names of sheets and rows with data
# let's read this data in to a DataFrame

# using below command will read xlsx data into DataFrame but will not render column labels
# df = DataFrame(XLSX.readdata("assets/sampleData/UNGM_UNSPSC_09-Apr-2022..xlsx", "UNSPSC", "A1:D12988"), :auto)
# dfUNSPSC = DataFrame(XLSX.readtable("assets/sampleData/UNGM_UNSPSC_09-Apr-2022..xlsx", "UNSPSC")...)
# ... operator will splat the tuple (data, column_labels) into the constructor of DataFrame

# replace missing values with an integer 99999
# replace!(dfUNSPSC."Parent key", missing => 99999)

# let's export this clean csv, we'll load this into database
# CSV.write("UNSPSC.csv", dfUNSPSC)

# # remember to empty dataFrame after usage
# # Julia will flush it out automatically after session,
# # but often ERP data gets bulky during session
# Base.summarysize(dfUNSPSC)
# empty!(dfUNSPSC)
# Base.summarysize(dfUNSPSC)

# first(dfUNSPSC, 5)
```

#### GUDID Database

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
##########
# GUDID ##
##########
# The complete list of GUDID Data Elements and descriptions can be found at this link.
# https://www.fda.gov/media/120974/download
# The complete GUDID Database (delimited version) download (250+MB)
# https://accessgudid.nlm.nih.gov/release_files/download/AccessGUDID_Delimited_Full_Release_20220401.zip
# let's extract all GUDID files in a folder
# readdir(pwd())
# readdir("assets/sampleData/GUDID")
# since these files are in txt (delimited) format, we'll use delimited pkg

########################
## large txt files #####
## read one at a time ##
########################

# data, header = readdlm("assets/sampleData/GUDID/contacts.txt", '|', header=true)
# dfGUDIDcontacts = DataFrame(data, vec(header))

# data, header = readdlm("assets/sampleData/GUDID/identifiers.txt", '|', header=true)
# dfGUDIDidentifiers = DataFrame(data, vec(header))

# data, header = readdlm("assets/sampleData/GUDID/device.txt", '|', header=true)
# dfGUDIDdevice = DataFrame(data, vec(header))

# # remember to empty dataFrame after usage
# # Julia will flush it out automatically after session,
# # but often ERP data gets bulky during session
# Base.summarysize(dfGUDIDcontacts),Base.summarysize(dfGUDIDidentifiers),Base.summarysize(dfGUDIDdevice)
# empty!(dfGUDIDcontacts)
# empty!(dfGUDIDidentifiers)
# empty!(dfGUDIDdevice)
# Base.summarysize(dfGUDIDcontacts),Base.summarysize(dfGUDIDidentifiers),Base.summarysize(dfGUDIDdevice)
```

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
##########
# GTIN ###
##########

# xf = XLSX.readxlsx("assets/sampleData/DS_GTIN_ALL.xlsx")
# xf will display names of sheets and rows with data
# let's read this data in to a DataFrame

# using below command will read xlsx data into DataFrame but will not render column labels
# df = DataFrame(XLSX.readdata("assets/sampleData/DS_GTIN_ALL.xlsx", "Worksheet", "A14:E143403   "), :auto)
# dfGTIN = DataFrame(XLSX.readtable("assets/sampleData/DS_GTIN_ALL.xlsx", "Worksheet";first_row=14)...)
# ... operator will splat the tuple (data, column_labels) into the constructor of DataFrame

# replace missing values with an integer 99999
# replace!(dfUNSPSC."Parent key", missing => 99999)
# size(dfUNSPSC)

# let's export this clean csv, we'll load this into database
# CSV.write("UNSPSC.csv", dfUNSPSC)
# readdir(pwd())

# # remember to empty dataFrame after usage
# # Julia will flush it out automatically after session,
# # but often ERP data gets bulky during session
# Base.summarysize(dfGTIN)
# empty!(dfGTIN)
# Base.summarysize(dfGTIN)
```

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
##########
# GMDN ###
##########

## GMDN data is not available

# # remember to empty dataFrame after usage
# # Julia will flush it out automatically after session,
# # but often ERP data gets bulky during session
# Base.summarysize(dfGMDN)
# empty!(dfGMDN)
# Base.summarysize(dfGMDN)
```

#### Vendor Master

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
#################
# Vendor master #
#################
# data, header = readdlm("assets/sampleData/GUDID/device.txt", '|', header=true)
# dfGUDIDdevice = DataFrame(data, vec(header))
# create Vendor Master from GUDID dataset
# show(first(dfGUDIDdevice,5), allcols=true)
# show(first(dfGUDIDdevice[:,[:brandName, :catalogNumber, :dunsNumber, :companyName, :rx, :otc]],5), allcols=true)
# names(dfGUDIDdevice)
# dfVendor = unique(dfGUDIDdevice[:,[:brandName, :catalogNumber, :dunsNumber, :companyName, :rx, :otc]])
# dfVendor = unique(dfGUDIDdevice[:,[:companyName]]) # 7574 unique vendors

# dfVendor = unique(dfGUDIDdevice[:,[:brandName, :dunsNumber, :companyName, :rx, :otc]])
# dfVendor is a good dataset, have 216k rows for 7574 unique vendors

# # remember to empty dataFrame after usage
# # Julia will flush it out automatically after session,
# # but often ERP data gets bulky during session
# Base.summarysize(dfVendor)
# empty!(dfVendor)
# Base.summarysize(dfVendor)
```

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
#### Location Master

#  data, header = readdlm("assets/sampleData/uscities.csv", ',', header=true)
#  dfLocation = DataFrame(data, vec(header))

# # remember to empty dataFrame after usage
# # Julia will flush it out automatically after session,
# # but often ERP data gets bulky during session
# Base.summarysize(dfLocation)
# empty!(dfLocation)
# Base.summarysize(dfLocation)
```

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
dfOrgMaster = DataFrame(
    ENTITY=repeat(["HeadOffice"], inner=8),
    GROUP=repeat(["Operations"], inner=8),
    DEPARTMENT=["Procurement","Procurement","Procurement","Procurement","Procurement","HR","HR","MFG"],
    UNIT=["Sourcing","Sourcing","Maintenance","Support","Services","Helpdesk","ServiceCall","IT"])
```

## creating complete Supply Chain Data Model DataFrames
now since we created Supply chain attribute, chartfields / dimensions

- item master
- vendor master
- location master
- org Hierarchy

using above chartfields, let's create following Supply Chain Transactions

- MSR - Material Service request
- PurchaseOrder
- Voucher
- Invoice
- Receipt
- Shipment
- Sales, Revenue
- Travel, Expense, TimeCard
- Accounting Lines


#### MSR - Material Service request

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
sampleSize = 1000 # number of rows, scale as needed

# data, header = readdlm("assets/sampleData/GUDID/device.txt", '|', header=true)
# df GUDIDdevice = DataFrame(data, vec(header))
# dfVendor = unique(dfGUDIDdevice[:,[:brandName, :dunsNumber, :companyName, :rx, :otc]])
# data, header = readdlm("assets/sampleData/uscities.csv", ',', header=true)
# dfLocation = DataFrame(data, vec(header))
# dfOrgMaster = DataFrame(
#    ENTITY=repeat(["HeadOffice"], inner=8),
#    GROUP=repeat(["Operations"], inner=8),
#    DEPARTMENT=["Procurement","Procurement","Procurement","Procurement","Procurement","HR","HR","MFG"],
#    UNIT=["Sourcing","Sourcing","Maintenance","Support","Services","Helpdesk","ServiceCall","IT"])

# dfMSR = DataFrame(
#    UNIT = rand(dfOrgMaster.UNIT, sampleSize),
#    MSR_DATE=rand(collect(Date(2020,1,1):Day(1):Date(2022,5,1)), sampleSize),
#    FROM_UNIT = rand(dfOrgMaster.UNIT, sampleSize),
#    TO_UNIT = rand(dfOrgMaster.UNIT, sampleSize),
#    GUDID = rand(dfGUDIDdevice.PrimaryDI, sampleSize),
#    QTY = rand(dfOrgMaster.UNIT, sampleSize));
# first(dfMSR, 5)
```

#### PO - Purchase Order

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
sampleSize = 1000 # number of rows, scale as needed

# data, header = readdlm("assets/sampleData/GUDID/device.txt", '|', header=true)
# dfGUDIDdevice = DataFrame(data, vec(header))
# dfVendor = unique(dfGUDIDdevice[:,[:brandName, :dunsNumber, :companyName, :rx, :otc]])
# data, header = readdlm("assets/sampleData/uscities.csv", ',', header=true)
# dfLocation = DataFrame(data, vec(header))
dfOrgMaster = DataFrame(
    ENTITY=repeat(["HeadOffice"], inner=8),
    GROUP=repeat(["Operations"], inner=8),
    DEPARTMENT=["Procurement","Procurement","Procurement","Procurement","Procurement","HR","HR","MFG"],
    UNIT=["Sourcing","Sourcing","Maintenance","Support","Services","Helpdesk","ServiceCall","IT"]);

# dfPO = DataFrame(
#    UNIT = rand(dfOrgMaster.UNIT, sampleSize),
#    PO_DATE=rand(collect(Date(2020,1,1):Day(1):Date(2022,5,1)), sampleSize),
#    VENDOR=rand(unique(dfVendor.companyName), sampleSize),
#    GUDID = rand(dfGUDIDdevice.PrimaryDI, sampleSize),
#    QTY = rand(1:150, sampleSize),
#    UNIT_PRICE = rand(Normal(100, 2), sampleSize)
#    );
# show(first(dfPO, 5),allcols=true)
```

#### Invoice - Voucher Invoice
```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions

sampleSize = 1000 # number of rows, scale as needed

# data, header = readdlm("assets/sampleData/GUDID/device.txt", '|', header=true)
# dfGUDIDdevice = DataFrame(data, vec(header))
# dfVendor = unique(dfGUDIDdevice[:,[:brandName, :dunsNumber, :companyName, :rx, :otc]])
# data, header = readdlm("assets/sampleData/uscities.csv", ',', header=true)
# dfLocation = DataFrame(data, vec(header))
dfOrgMaster = DataFrame(
    ENTITY=repeat(["HeadOffice"], inner=8),
    GROUP=repeat(["Operations"], inner=8),
    DEPARTMENT=["Procurement","Procurement","Procurement","Procurement","Procurement","HR","HR","MFG"],
    UNIT=["Sourcing","Sourcing","Maintenance","Support","Services","Helpdesk","ServiceCall","IT"]);

# dfVCHR = DataFrame(
#    UNIT = rand(dfOrgMaster.UNIT, sampleSize),
#    VCHR_DATE=rand(collect(Date(2020,1,1):Day(1):Date(2022,5,1)), sampleSize),
#    STATUS=rand(["Closed","Paid","Open","Cancelled","Exception"], sampleSize),
#    VENDOR_INVOICE_NUM = rand(10001:9999999, sampleSize),
#    VENDOR=rand(unique(dfVendor.companyName), sampleSize),
#    GUDID = rand(dfGUDIDdevice.PrimaryDI, sampleSize),
#    QTY = rand(1:150, sampleSize),
#    UNIT_PRICE = rand(Normal(100, 2), sampleSize)
#    );
# show(first(dfVCHR, 5),allcols=true)
```

#### Sales - Revenue Register

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
sampleSize = 1000 # number of rows, scale as needed

# data, header = readdlm("assets/sampleData/GUDID/device.txt", '|', header=true)
# dfGUDIDdevice = DataFrame(data, vec(header))
# dfVendor = unique(dfGUDIDdevice[:,[:brandName, :dunsNumber, :companyName, :rx, :otc]])
# data, header = readdlm("assets/sampleData/uscities.csv", ',', header=true)
# dfLocation = DataFrame(data, vec(header))
dfOrgMaster = DataFrame(
    ENTITY=repeat(["HeadOffice"], inner=8),
    GROUP=repeat(["Operations"], inner=8),
    DEPARTMENT=["Procurement","Procurement","Procurement","Procurement","Procurement","HR","HR","MFG"],
    UNIT=["Sourcing","Sourcing","Maintenance","Support","Services","Helpdesk","ServiceCall","IT"]);

# dfREVENUE = DataFrame(
#    UNIT = rand(dfOrgMaster.UNIT, sampleSize),
#    SALES_DATE=rand(collect(Date(2020,1,1):Day(1):Date(2022,5,1)), sampleSize),
#    STATUS=rand(["Sold","Pending","Hold","Cancelled","Exception"], sampleSize),
#    SALES_RECEIPT_NUM = rand(10001:9999999, sampleSize),
#    CUSTOMER=rand(unique(dfVendor.companyName), sampleSize),
#    GUDID = rand(dfGUDIDdevice.PrimaryDI, sampleSize),
#    QTY = rand(1:150, sampleSize),
#    UNIT_PRICE = rand(Normal(100, 2), sampleSize)
#    );
# show(first(dfREVENUE, 5),allcols=true)
```

#### Shipment - Receipt

```@example
using DataFrames, Dates, Interact, CategoricalArrays, WebIO, CSV, XLSX, DelimitedFiles, Distributions
sampleSize = 1000 # number of rows, scale as needed

# data, header = readdlm("assets/sampleData/GUDID/device.txt", '|', header=true)
# dfGUDIDdevice = DataFrame(data, vec(header))
# dfVendor = unique(dfGUDIDdevice[:,[:brandName, :dunsNumber, :companyName, :rx, :otc]])
# data, header = readdlm("assets/sampleData/uscities.csv", ',', header=true)
# dfLocation = DataFrame(data, vec(header))
dfOrgMaster = DataFrame(
    ENTITY=repeat(["HeadOffice"], inner=8),
    GROUP=repeat(["Operations"], inner=8),
    DEPARTMENT=["Procurement","Procurement","Procurement","Procurement","Procurement","HR","HR","MFG"],
    UNIT=["Sourcing","Sourcing","Maintenance","Support","Services","Helpdesk","ServiceCall","IT"])

# dfSHIPRECEIPT = DataFrame(
#    UNIT = rand(dfOrgMaster.UNIT, sampleSize),
#    SHIP_DATE=rand(collect(Date(2020,1,1):Day(1):Date(2022,5,1)), sampleSize),
#    STATUS=rand(["Shippped","Returned","In process","Cancelled","Exception"], sampleSize),
#    SHIPMENT_NUM = rand(10001:9999999, sampleSize),
#    CUSTOMER=rand(unique(dfVendor.companyName), sampleSize),
#    GUDID = rand(dfGUDIDdevice.PrimaryDI, sampleSize),
#    QTY = rand(1:150, sampleSize),
#    UNIT_PRICE = rand(Normal(100, 2), sampleSize)
#    );
# show(first(dfSHIPRECEIPT, 5),allcols=true)
```