module DataModel

# this data model provide necessary definitions to work with JSON objects fetched from RestAPI
# most of these struct are one-way ready-only data pull
# means, OliveAI front-end is not used to store/update any value and is only used to query, read and display information
# last_updated field used in below structs are not client generated and reflect when RestAPI is last last_updated

# TODO: why structypes are mutable below, if these are read only structs, they need to be ordered structs

import Base: ==

using StructTypes, Dates

export SystemAlert, AnomalyDetection, AIAlert, ItemDetail, ElasticSearch, User

mutable struct SystemAlert
    id::Int64
    entity::String
    unit::String
    status::String
    last_updated::DateTime
    message::String
end
# define structType of JSON deserialization
StructTypes.StructType(::Type{SystemAlert}) = StructTypes.Mutable()
StructTypes.idproperty(::Type{SystemAlert}) = :id

mutable struct AnomalyDetection
    price::String
    purchaseRecommendation::String
    qtyOrdered::String
    qtyOnHand::String
    matchExceptionRaised::String
    last_updated::DateTime
end
# define structType of JSON deserialization
StructTypes.StructType(::Type{AnomalyDetection}) = StructTypes.Mutable()

mutable struct AIAlert
    anomalyDetection::AnomalyDetection
    purchaseRecommendation::String
end
# define structType of JSON deserialization
StructTypes.StructType(::Type{AIAlert}) = StructTypes.Mutable()

mutable struct ItemDetail
    transactionType::String
    itemID::String
    UNSPSC::String
    entity::String
    category::String
    resultType::String
    preferredItem::String
    preferredVendor::String
    onContract::String
    description::String
    message::String
end
# define structType of JSON deserialization
StructTypes.StructType(::Type{ItemDetail}) = StructTypes.Mutable()

mutable struct ElasticSearch
    txnType::String
    UID::String
    sdesc::String
    ldesc::String
    alert::String
    last_updated::DateTime
end
# define structType of JSON deserialization
StructTypes.StructType(::Type{ElasticSearch}) = StructTypes.Mutable()

mutable struct User
    id::Int64 # service-managed
    username::String
    password::String
end

==(x::User, y::User) = x.id == y.id
User() = User(0, "", "")
User(username::String, password::String) = User(0, username, password)
User(id::Int64, username::String) = User(id, username, "")
StructTypes.StructType(::Type{User}) = StructTypes.Mutable()
StructTypes.idproperty(::Type{User}) = :id

end # module