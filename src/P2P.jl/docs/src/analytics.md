# Analytics

In previous chapters, we learned, created and loaded Finance and Supply chain datasets in to Julia language dataframes, RDBMS database.

We also created a Graph schema, loaded ERP data into Graph schema and created pattern matching Graph SQLs to get data insights.

In this chapter, we'll load Original ERP dataset WITH Graph GSQLs results to run interactive data analytics.

These interactive data anlytics will help us run interactive visualiztion/analysis on following sample scenarios.


## what-if, would, could, should

#### Finance
- Region A is merged with Region B
- Employee resume work from office, how much Travel amounts % will increase.
- % of Office supply expenses given to Employee as home office setup
- would Region A, Cash Flow Investment have returned 7% ROI
- would Region B received Government/investor funding
- could have increased IT operating expenses by 5%
- could have reduced HR temp staff
- should have paid vendor invoiced on time to recive rebate
- should have applied loan to increase production
- should have retired a particular Asset

#### Supply chain
- during 2020, what UNSPSC category experience highest surge in source orders
- during 2020, in "cleaning, supplies" category, what are the other items sold more than average
- what are most requested items in "cleaning, supplies" category
- what are most requested items in "essentials" category
- what are most requested items in "life savings drugs / GUDID implants" category
- was there an decrease in implants, in other words, were they any cardiac or other critical operational surgery delay during covid
- what are items purchase together with devices in category = ventilators
- was there an increased use items categorized as "controlled substance" items
- what are the items, which were in backlog most frequently and waited longest

## GL BalanceSheet, IncomeStatement & CashFlow

#### Balance Sheet (Interactive)
```julia
@manipulate for ld = Dict("Actuals"=> "Actuals", "Budget" => "Budget"), 
                rg = Dict("Region A"=> "Region A", "Region B" => "Region B", "Region C" => "Region C"),
                yr = slider(2020:1:2022; value=2021),
                qtr = 1:1:4
    
    @show ld, rg, yr, qtr
    
select(gdf_plot[(
    (gdf_plot.FISCAL_YEAR .== yr)
    .&
    (gdf_plot.QTR .== qtr)
    .&
    (gdf_plot.LEDGER .== ld)
    .&
    (gdf_plot.OPER_UNIT .== rg)
    ),:],
        :OPER_UNIT => :Org,
        :FISCAL_YEAR => :FY,
        :QTR => :Qtr,
        :ACCOUNTS_CLASSIFICATION => :Accounts,
        :DEPT_CLASSIFICATION => :Dept,
        # :LOCATION_CLASSIFICATION => :Region,
        :LOCATION_DESCR => :Loc,
        :TOTAL => :TOTAL)
end
```

```@example
using Pkg
Pkg.add("DataFrames")
Pkg.add("Dates")
Pkg.add("CategoricalArrays")
Pkg.add("Interact")
Pkg.add("WebIO")
Pkg.build("WebIO")
using DataFrames, Dates, Interact, CategoricalArrays, WebIO
Pkg.status();
```

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

# LOCATION Chartfield
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
size(ledgerDF)

# rename dimensions columns for innerjoin
df_accounts = rename(accountsDF, :ID => :ACCOUNTS_ID, :CLASSIFICATION => :ACCOUNTS_CLASSIFICATION, 
    :CATEGORY => :ACCOUNTS_CATEGORY, :DESCR => :ACCOUNTS_DESCR);
df_dept = rename(deptDF, :ID => :DEPT_ID, :CLASSIFICATION => :DEPT_CLASSIFICATION, 
    :CATEGORY => :DEPT_CATEGORY, :DESCR => :DEPT_DESCR);
df_location = rename(locationDF, :ID => :LOCATION_ID, :CLASSIFICATION => :LOCATION_CLASSIFICATION,
    :CATEGORY => :LOCATION_CATEGORY, :DESCR => :LOCATION_DESCR);

# join Ledger accounts chartfield with accounts chartfield dataframe to pull all accounts fields
# join Ledger dept chartfield with dept chartfield dataframe to pull all dept fields
# join Ledger location chartfield with location chartfield dataframe to pull all location fields
df_ledger = innerjoin(
                innerjoin(
                    innerjoin(ledgerDF, df_accounts, on = [:ACCOUNT => :ACCOUNTS_ID], makeunique=true),
                    df_dept, on = [:DEPT => :DEPT_ID], makeunique=true), df_location,
                on = [:LOCATION => :LOCATION_ID], makeunique=true);

# note, how ledger DF has 28 columns now (inclusive of all chartfields join)
size(df_accounts),size(df_dept),size(df_location), size(ledgerDF), size(df_ledger)

function periodToQtr(x)
    if x ∈ 1:3
        return 1
    elseif x ∈ 4:6
        return 2
    elseif x ∈ 7:9
        return 3
    else return 4
    end
end

# now we will use this function to transform a new column
transform!(df_ledger, :PERIOD => ByRow(periodToQtr) => :QTR)

# let's create one more generic function, which converts a number to USD currency
function numToCurrency(x)
        return string("USD ",round(x/10^6; digits = 2), " million")
end

transform!(df_ledger, :POSTED_TOTAL => ByRow(numToCurrency) => :TOTAL)
df_ledger[1:5,["POSTED_TOTAL","TOTAL"]]
"df_ledger_size after transformation is: ", size(df_ledger)
```

#### Income Statement (Interactive)

```
@manipulate for ld = Dict("Actuals"=> "Actuals", "Budget" => "Budget"), 
                rg = Dict("Region A"=> "Region A", "Region B" => "Region B", "Region C" => "Region C"),
                yr = slider(2020:1:2022; value=2021),
                qtr = 1:1:4
    
    @show ld, rg, yr, qtr
    
select(gdf_plot[(
    (gdf_plot.FISCAL_YEAR .== yr)
    .&
    (gdf_plot.QTR .== qtr)
    .&
    (gdf_plot.LEDGER .== ld)
    .&
    (gdf_plot.OPER_UNIT .== rg)
    .&
    (in.(gdf_plot.ACCOUNTS_CLASSIFICATION, Ref(["ASSETS", "LIABILITIES", "REVENUE","NET_WORTH"])))
    ),:],
        :OPER_UNIT => :Org,
        :FISCAL_YEAR => :FY,
        :QTR => :Qtr,
        :ACCOUNTS_CLASSIFICATION => :Accounts,
        :DEPT_CLASSIFICATION => :Dept,
        # :LOCATION_CLASSIFICATION => :Region,
        :LOCATION_DESCR => :Loc,
        :TOTAL => :TOTAL)
end
```

#### Cash Flow Statement (Interactive)

```
@manipulate for ld = Dict("Actuals"=> "Actuals", "Budget" => "Budget"), 
                rg = Dict("Region A"=> "Region A", "Region B" => "Region B", "Region C" => "Region C"),
                yr = slider(2020:1:2022; value=2021),
                qtr = 1:1:4
    
    @show ld, rg, yr, qtr
    
select(gdf_plot[(
    (gdf_plot.FISCAL_YEAR .== yr)
    .&
    (gdf_plot.QTR .== qtr)
    .&
    (gdf_plot.LEDGER .== ld)
    .&
    (gdf_plot.OPER_UNIT .== rg)
    .&
    (in.(gdf_plot.ACCOUNTS_CLASSIFICATION, Ref(["NON-OPERATING_EXPENSES","OPERATING_EXPENSES"])))
    ),:],
        :OPER_UNIT => :Org,
        :FISCAL_YEAR => :FY,
        :QTR => :Qtr,
        :ACCOUNTS_CLASSIFICATION => :Accounts,
        :DEPT_CLASSIFICATION => :Dept,
        # :LOCATION_CLASSIFICATION => :Region,
        :LOCATION_DESCR => :Loc,
        :TOTAL => :TOTAL)
end
```

#### Supplychain Material Service Request

```
sampleSize = 1000 # number of rows, scale as needed

dfMSR = DataFrame(
    UNIT = rand(dfOrgMaster.UNIT, sampleSize),
    MSR_DATE=rand(collect(Date(2020,1,1):Day(1):Date(2022,5,1)), sampleSize),
    FROM_UNIT = rand(dfOrgMaster.UNIT, sampleSize),
    TO_UNIT = rand(dfOrgMaster.UNIT, sampleSize),
    GUDID = rand(dfGUDIDdevice.PrimaryDI, sampleSize),
    QTY = rand(dfOrgMaster.UNIT, sampleSize));
first(dfMSR, 5)
```

#### ITEM/Vendor Master Voucher Invoice data
```
sampleSize = 1000 # number of rows, scale as needed

dfVCHR = DataFrame(
    UNIT = rand(dfOrgMaster.UNIT, sampleSize),
    VCHR_DATE=rand(collect(Date(2020,1,1):Day(1):Date(2022,5,1)), sampleSize),
    STATUS=rand(["Closed","Paid","Open","Cancelled","Exception"], sampleSize),
    VENDOR_INVOICE_NUM = rand(10001:9999999, sampleSize),
    VENDOR=rand(unique(dfVendor.companyName), sampleSize),
    GUDID = rand(dfGUDIDdevice.PrimaryDI, sampleSize),
    QTY = rand(1:150, sampleSize),
    UNIT_PRICE = rand(Normal(100, 2), sampleSize)
    );
show(first(dfVCHR, 5),allcols=true)
```

#### Supply chain Shipment Receipt data

```
sampleSize = 1000 # number of rows, scale as needed
dfSHIPRECEIPT = DataFrame(
    UNIT = rand(dfOrgMaster.UNIT, sampleSize),
    SHIP_DATE=rand(collect(Date(2020,1,1):Day(1):Date(2022,5,1)), sampleSize),
    STATUS=rand(["Shippped","Returned","In process","Cancelled","Exception"], sampleSize),
    SHIPMENT_NUM = rand(10001:9999999, sampleSize),
    CUSTOMER=rand(unique(dfVendor.companyName), sampleSize),
    GUDID = rand(dfGUDIDdevice.PrimaryDI, sampleSize),
    QTY = rand(1:150, sampleSize),
    UNIT_PRICE = rand(Normal(100, 2), sampleSize)
    );
show(first(dfSHIPRECEIPT, 5),allcols=true)
```

## Supply chain Procurement Pipeline

```
## Ledger Visual
#	plot_data = gdf_plot[(
#		(gdf_plot.FISCAL_YEAR .== yr_p)
#		.&
#		(gdf_plot.LEDGER .== ld_p)
#		.&
#		(gdf_plot.OPER_UNIT .== rg_p)
#		.&
#		(gdf_plot.LOCATION_DESCR .== ldescr)
#		.&
#		(gdf_plot.DEPT_CLASSIFICATION .== ddescr)
#		.&
#		(gdf_plot.ACCOUNTS_CLASSIFICATION .== adescr))
#		, :];
#	# @df plot_data scatter(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", label="$ld_p Total by #    $yr_p for $rg_p")
#	@df plot_data plot(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
#		label=[
#			"$ld_p by $yr_p for $rg_p $ldescr $adescr $ddescr"
#			],
#		lw=3)

## Actuals vs Budget comparison

#	plot_data_a = gdf_plot[(
#		(gdf_plot.FISCAL_YEAR .== yr_p)
#		.&
#		(gdf_plot.LEDGER .== "Actuals")
#		.&
#		(gdf_plot.OPER_UNIT .== rg_p)
#		.&
#		(gdf_plot.LOCATION_DESCR .== ldescr)
#		.&
#		(gdf_plot.DEPT_CLASSIFICATION .== ddescr)
#		.&
#		(gdf_plot.ACCOUNTS_CLASSIFICATION .== adescr))
#		, :];
	# @df plot_data scatter(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", label="$ld_p Total by # $yr_p for $rg_p")
#	plot_data_b = gdf_plot[(
#		(gdf_plot.FISCAL_YEAR .== yr_p)
#		.&
#		(gdf_plot.LEDGER .== "Budget")
#		.&
#		(gdf_plot.OPER_UNIT .== rg_p)
#		.&
#		(gdf_plot.LOCATION_DESCR .== ldescr)
#		.&
#		(gdf_plot.DEPT_CLASSIFICATION .== ddescr)
#		.&
#		(gdf_plot.ACCOUNTS_CLASSIFICATION .== adescr))
#		, :];
# @df plot_data scatter(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", label="$ld_p Total by $yr_p # for $rg_p")
#	@df plot_data_a plot(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
#		label=[
#			"Actuals by $yr_p for $rg_p $ldescr $adescr $ddescr"
#			],
#		lw=3)
#	@df plot_data_b plot!(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
#		label=[
#			"Budget by $yr_p for $rg_p $ldescr $adescr $ddescr"
#			],
#		lw=3)

# plot_data

	# plot_data = gdf_plot[(
	# 	(gdf_plot.FISCAL_YEAR .== yr_p)
	# 	.&
	# 	(gdf_plot.LEDGER .== ld_p)
	# 	.&
	# 	(gdf_plot.OPER_UNIT .== rg_p)
	# 	.&
	# 	(gdf_plot.LOCATION_DESCR .== ldescr)
	# 	.&
	# 	(gdf_plot.DEPT_CLASSIFICATION .== ddescr)
	# 	.&
	# 	(gdf_plot.ACCOUNTS_CLASSIFICATION .== adescr))
	# 	, :];
	# @df plot_data scatter(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", label="$ld_p Total by $yr_p for $rg_p")
	# @df gdf_plot plot(:QTR, :ACCOUNTS_CLASSIFICATION, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
	# 	label=[
	# 		"$ld_p by $yr_p for $rg_p $ldescr $adescr $ddescr"
	# 		],
	# 	lw=3)
#	@df gdf_plot scatter(:QTR, :ACCOUNTS_CLASSIFICATION, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
#		label=[
#			"$ld_p by $yr_p for $rg_p $ldescr for $ddescr"
#			],
#		lw=3)


	# plot_data = gdf_plot[(
	# 	(gdf_plot.FISCAL_YEAR .== yr_p)
	# 	.&
	# 	(gdf_plot.LEDGER .== ld_p)
	# 	.&
	# 	(gdf_plot.OPER_UNIT .== rg_p)
	# 	.&
	# 	(gdf_plot.LOCATION_DESCR .== ldescr)
	# 	.&
	# 	(gdf_plot.DEPT_CLASSIFICATION .== ddescr)
	# 	.&
	# 	(gdf_plot.ACCOUNTS_CLASSIFICATION .== adescr))
	# 	, :];
	# @df plot_data scatter(:QTR, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", label="$ld_p Total by $yr_p for $rg_p")
	# @df gdf_plot plot(:QTR, :ACCOUNTS_CLASSIFICATION, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
	# 	label=[
	# 		"$ld_p by $yr_p for $rg_p $ldescr $adescr $ddescr"
	# 		],
	# 	lw=3)
#	@df gdf_plot scatter(:QTR, :DEPT_CLASSIFICATION, :TOTAL/10^8, title = "Finance Ledger Data", xlabel="Quarter", ylabel="Total (in USD million)", 
#		label=[
#			"$ld_p by $yr_p for $rg_p $ldescr for $adescr"
#			],
#		lw=3)
```