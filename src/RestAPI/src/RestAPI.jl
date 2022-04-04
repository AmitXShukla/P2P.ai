module RestAPI

greet() = print("Hello World!")
export greet, Client

include("./models/datamodel.jl")
using .DataModel

include("./provider/connection.jl")
using .ConnectionPools

include("./provider/workers.jl")
using .Workers

include("./provider/auth.jl")
using .Auth

include("./provider/context.jl")
using .Contexts

include("./provider/schema.jl")
using .Schema

include("./blocs/service.jl")
using .Service

include("./router/router.jl")
using .Router

include("./client/clients.jl")
using .Client

# function init(dbfile, authkeysfile)
#     Workers.init()
#     Schema.init(dbfile)
#     Auth.init(authkeysfile)
#     Router.run()
# end

function init(dbfile)
    Workers.init()
    Schema.init(dbfile)
    # Auth.init(authkeysfile)
    Router.run()
end

end # module