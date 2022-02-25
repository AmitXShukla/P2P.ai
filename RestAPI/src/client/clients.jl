module Client

using HTTP, JSON3, Base64
using ..DataModel, ..Auth, ..Schema

const SERVER = Ref{String}("http://localhost:8080")
const AUTH_TOKEN = Ref{String}()

# function createUser(username, password)
#     body = (; username, password = base64encode(password))
#     resp = HTTP.post(string(SERVER[], "/user"), [], JSON3.write(body); cookies = true)
#     if HTTP.hasheader(resp, Auth.JWT_TOKEN_COOKIE_NAME)
#         AUTH_TOKEN[] = HTTP.header(resp, Auth.JWT_TOKEN_COOKIE_NAME)
#     end
#     return JSON3.read(resp.body, User)
# end

# function loginUser(username, password)
#     body = (; username, password = base64encode(password))
#     resp = HTTP.post(string(SERVER[], "/user/login"), [], JSON3.write(body); cookies = true)
#     if HTTP.hasheader(resp, Auth.JWT_TOKEN_COOKIE_NAME)
#         AUTH_TOKEN[] = HTTP.header(resp, Auth.JWT_TOKEN_COOKIE_NAME)
#     end
#     return JSON3.read(resp.body, User)
# end

# function createAlbum(name, artist, year, songs)
#     body = (; name, artist, year, songs)
#     resp = HTTP.post(string(SERVER[], "/album"), [Auth.JWT_TOKEN_COOKIE_NAME => AUTH_TOKEN[]], JSON3.write(body); cookies = true)
#     return JSON3.read(resp.body, Album)
# end

# function getAlbum(id)
#     resp = HTTP.get(string(SERVER[], "/album/$id"), [Auth.JWT_TOKEN_COOKIE_NAME => AUTH_TOKEN[]]; cookies = true)
#     return JSON3.read(resp.body, Album)
# end

# function updateAlbum(album)
#     resp = HTTP.put(string(SERVER[], "/album/$(album.id)"), [Auth.JWT_TOKEN_COOKIE_NAME => AUTH_TOKEN[]], JSON3.write(album); cookies = true)
#     return JSON3.read(resp.body, Album)
# end

# function deleteAlbum(id)
#     resp = HTTP.delete(string(SERVER[], "/album/$id"), [Auth.JWT_TOKEN_COOKIE_NAME => AUTH_TOKEN[]]; cookies = true)
#     return
# end

# function pickAlbumToListen()
#     resp = HTTP.get(string(SERVER[], "/"), [Auth.JWT_TOKEN_COOKIE_NAME => AUTH_TOKEN[]]; cookies = true)
#     return JSON3.read(resp.body, Album)
# end

function getSystemAlerts()
    resp = HTTP.get(string(SERVER[], "/sysai"); cookies = false)
    return JSON3.read(resp.body, SystemAlert)
end

# systemalerts or any mutable operations are strictly performed through backend
# router must not expose any mutable routes to end user
# without appropriate authentication

# this is demo app, and below function is only for testing purpose

function createSysAlert(id, entity, unit, status, last_updated, message)
    sysalert = SystemAlert(id, entity, unit, status, last_updated, message)
    # body = (; id, entity, unit, status, last_updated, message)
    Schema.insert!(sysalert)
    # resp = HTTP.post(string(SERVER[], "/album"), [Auth.JWT_TOKEN_COOKIE_NAME => AUTH_TOKEN[]], JSON3.write(body); cookies = true)
    # return JSON3.read(resp.body, Album)
end

end # module