# P2P.ai

## Supply Chain Rx_Inventory API with Predictive Analytics
A complete data science AI framework to manage live Supply Chain Rx Inventory ERPs using Predictive Analytics.

---
#### Author: Amit Shukla
#### Contact: info@elishconsulting.com
#### License: Creative Commons, CC0 1.0 Universal

#### Documentation: https://amitxshukla.github.io/P2P.ai/#/ai

*please do not clone, @copyright <a href="www.elishconsulting.com">www.elishconsulting.com</a>*

[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/youtube.svg" width=40 height=50>](https://youtube.com/AmitShukla_AI)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/github.svg" width=40 height=50>](https://github.com/AmitXShukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/medium.svg" width=40 height=50>](https://medium.com/@Amit_Shukla)
[<img src="https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/assets/icons/twitter_1.svg" width=40 height=50>](https://twitter.com/ashuklax)


## Technologies
```sbtshell
Frontend: Olive AI
Backend: Oracle
Rest API: Julia Genie
Ai: Julia, Fluxml.ai, H2O.ai, Oracle AutoML
``` 

# About P2P.ai
Managing supply chain (Procure 2 Pay operations) is always a challenging tasks for any organization whether small, medium and large. And managing these operations effectively become even more critical for Healthcare providers.

Business user must have complete visibility and require operation intelligence information readily available to make quick, effective and informed decisions.

SCM Rx Inventory AI Olive LOOP solves this problem. 

It acts as an AI assistant to help user make quick informed decision. As user input, search for Items, Purchase orders, DocCART or other SCM related information, Olive Loop connects to a REST API, which render live data & predictive analytics based on pre-trained AI models, historical transactions stored in system.

# how does it work

    user login to Healthcare OLTP / ERP Application
    user input
    for example, PO12345 | VNDR12345 | ITEM12345 (use these string for **demo)

    -> Olive Helps Aptitudes / Sensor
        -> Elastic search
            -> ITEM
                | About ITEM
                - ALERTs
                    - Anomaly
                        | Price variation
                        | Qty variation
                        | Preferred ITEM
                    - Recommendation Engine
                        | bought together
                        | preferred vendor
                        | on/off contract
                    - DocRxCART
                        | low inventory
                        | Auto Replenishment
            -> IN (PO | REQ | RECV | VNDR | RECV | AT_PAR | DocRxCART)
                | About transaction
                - ALERTs
                    - Anomaly
                        | MXP (Match Exception)
                            | Price variation
                            | Qty variation
                            | Preferred ITEM
                    - Recommendation Engine
                        | preferred vendor
                        | on/off contract
    
    ** in demo environment, use input such as - PO12345 | VNDR12345 | ITEM12345
    ** in production, backend AI build a unique index tables for elastic search and acknowledge and classify user input search accordingly.

# Technology stack
    Front end: Olive Helps
    Middleware: Olive Loop
    REST API: JuliaLang | NodeJS
    AI/ML API: https://github.com/AmitXShukla/P2P.jl
    Cloud: any (** Oracle OCI | Microsoft Azure | AWS)
    Database: any (**Oracle | MYSQL | Firebase | MongoDB)
    AI: JuliaLang & FluxML.ai | Python & Pytorch

# Application Process
![Application Process](docs/assets/images/Application_Process.png)

# System Process
![Application Process](docs/assets/images/ERD.png)

# Dictionary
    SCM - Supply chain Management
    AUTO_REPL - Auto replenishment - automated Critical Item order when below threshold
    Rx - Pharmacy
    IN | INV - Inventory
    OLTP - Online Transaction Processing system
    ITEM - Product
    ITEM_CAT - Item Catalogue | Item Category
    UNSPSC - United Nations Standard Products and Services Code
    PO - Purchase Order
    MSR - Material Service Request | internal item transfers among Entities
    REQ - Requisition (request to create purchase order)
    RECV - Receiving
    MXP - Match Exception - Transactions which failed to match
    ON_Contract - Items which are on-contract with a given vendor
    PREF_ITEM - Items/Products identified as preferred
    Vendor - Vendor | Supplier | Manufacturer | Service Provider
    ENTITY - Operating business unit | Region | Business group
    AT_PAR - Items/Products which are critical to business operations
    DocRxCART - Items/Products which are critical to doctor's office
    CART_ITEMS - Items/Products which are critical to business operations

# License Agreement
https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/LICENSE

# Privacy Policy
https://raw.githubusercontent.com/AmitXShukla/P2P.ai/main/LICENSE

# Aptitudes used
    clipboardListener
    keyboardListener
    networkExample
    searchListener

# how Loop/Author uses the user’s information
    SCM_Rx_IN loop reads clipboard/ user input text and access/search database / AI Prediction analytics through REST API and renders results.

    This loop does NOT store any user input information anywhere in application and it does NOT alter/update any back-end information based on Olive Helps loop user input.

# Declare where your loop is sending users’ information, including the subdomain level
    loop does NOT send/store any user information, except search strings are used to access API and pull data from database/API.

# Provide documentation and/or source code of how data transmitted from Olive Helps is being consumed and/or persisted

    SCM_Rx_IN loop reads clipboard/ user input text and access/search database / AI Prediction analytics through REST API and renders results.

    This loop does NOT store any user input information anywhere in application and it does NOT alter/update any back-end information based on Olive Helps loop user input.
    Please refer to Application process above for more details.

# Confirm all servers associated with your loops, transmitted, and/or persisted data are hosted in the US

    All servers associated with loops, transmitted and/or persisted data are hosted in US.

# Confirm no data will be transmitted outside of the US

    No data will be transmitted outside of the US

# how to trigger each type of Whisper or workflow within the Loop
    user login to Healthcare OLTP / ERP Application
    user input
    for example, PO12345 | VNDR12345 | ITEM12345 (use these string for **demo)

    -> Olive Helps Aptitudes / Sensor
        -> Elastic search
            -> ITEM
                | About ITEM
                - ALERTs
                    - Anomaly
                        | Price variation
                        | Qty variation
                        | Preferred ITEM
                    - Recommendation Engine
                        | bought together
                        | preferred vendor
                        | on/off contract
                    - DocRxCART
                        | low inventory
                        | Auto Replenishment
            -> IN (PO | REQ | RECV | VNDR | RECV | AT_PAR | DocRxCART)
                | About transaction
                - ALERTs
                    - Anomaly
                        | MXP (Match Exception)
                            | Price variation
                            | Qty variation
                            | Preferred ITEM
                    - Recommendation Engine
                        | preferred vendor
                        | on/off contract
    
    ** in demo environment, use input such as - PO12345 | VNDR12345 | ITEM12345
    ** in production, backend AI build a unique index tables for elastic search and acknowledge and classify user input search accordingly.


# Submit detailed explanations of any non-obvious features, including supporting documentation where appropriate
    this loop also used a pre-trained spacy.io NLP model

    please see ML_Models folder in GitHub repository.

# loop is utilizing the loopOpenHandler to initiate loop's start whisper upon selection from search dropdown
    tested