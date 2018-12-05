module User exposing (JWT, User)

import Http
import Json.Decode as Decode
import Json.Decode.Extra exposing (andMap)
import Jwt


type alias User =
    { userId : String
    , name : String
    , email : String
    , avatar : String
    }


type JWTError
    = HttpError Http.Error
    | JwtDecodeError Jwt.JwtError


type JWT
    = JWT ( String, User )


parseJwtString : String -> Result Jwt.JwtError JWT
parseJwtString token =
    Jwt.decodeToken userDecoder token
        |> Result.map (\user -> JWT ( token, user ))


userDecoder : Decode.Decoder User
userDecoder =
    Decode.succeed User
        |> andMap (field "user_id" Decode.string)
        |> andMap (field "name" Decode.string)
        |> andMap (field "email" Decode.string)
        |> andMap (field "avatar" Decode.string)



{--
example of a token
{
 "user_id": "16f89a8a-4be9-4581-a94b-17104b9f6ac9",
 "name": "Leo Jeusset (vendor)",
 "email": "leo_pdxvendor@repositive.io",
 "created_at": "2018-02-09T12:39:33.029Z",
 "updated_at": "2018-02-09T12:39:33.029Z",
 "organisation_type": "pdx-vendor",
 "organisation_id": "8799cd23-6d30-4c0a-aa81-bea172e46fd6",
 "avatar": "https://avatar-dev.pdx.repositive.io/83c03fd2-fb9e-4bb9-8116-ad9a5ddb9641",
 "memberships": [
  {
   "organisation_id": "8799cd23-6d30-4c0a-aa81-bea172e46fd6",
   "organisation_type": "pdx-vendor",
   "membership_role": "ADMIN",
   "membership_status": "ACCEPTED"
  }
 ],
 "iat": 1543993402,
 "exp": 1544007872,
 "jti": "605a3087-4ca4-4751-898e-610c0c623108"
}

--}
