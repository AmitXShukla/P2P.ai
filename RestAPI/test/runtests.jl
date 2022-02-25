using Test, RestAPI

const DBFILE = joinpath(dirname(pathof(RestAPI)), "../assets/p2pai.sqlite")
const AUTHFILE = "file://" * joinpath(dirname(pathof(RestAPI)), "../assets/env.dev.json")

# ------------------------------------------------------------ #
# this is demo app, call simple router instead of AUTH_ROUTER
# authentication is skipped
# ------------------------------------------------------------ #
# server = @async RestAPI.run(DBFILE, AUTHFILE)
server = @async RestAPI.init("./assets/p2p.sqlite")

Client.createSysAlert(
    1,
    "SCAL",
    "San Francisco",
    "yellow",
    DateTime("2022-02-23", "yyyy-mm-dd"),
    "ALERT: DocCART Surgical items at par location Oakland are low 
in inventory, Auto Replenishment POs must dispatch to avoid deficit."
)

# Client.createUser("amit", "password")
# user = Client.loginUser("amit", "password")

# using HTTP;
# HTTP.CookieRequest.default_cookiejar[1];

# alb1 = Client.createAlbum("Free Yourself Up", "Lake Street Dive", 2018, ["Baby Don't Leave Me Alone With My Thoughts", "Good Kisser"])
# @test Client.pickAlbumToListen() == alb1
# @test Client.pickAlbumToListen() == alb1

# @test Client.getAlbum(alb1.id) == alb1

# push!(alb1.songs, "Shame, Shame, Shame")
# alb2 = Client.updateAlbum(alb1)
# @test length(alb2.songs) == 3
# @test length(Client.getAlbum(alb1.id).songs) == 3

# Client.deleteAlbum(alb1.id)
# Client.pickAlbumToListen()

# alb2 = Client.createAlbum("Haunted Heart", "Charlie Haden Quartet West", 1991, ["Introduction", "Hello My Lovely"])
# @test Client.pickAlbumToListen() == alb2

# Client.createAlbum("Hazards Of Love", "The Decemberists", 2009, ["Prelude", "The Hazards Of Love 1"])
# Client.createAlbum("Tapestry", "Carole King", 1971, ["I Feel The Earth Move", "So Far Away"])
