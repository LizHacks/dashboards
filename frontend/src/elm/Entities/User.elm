module User exposing (User, JWT)

import Jwt

type alias User = {}

type JWT =
  JWT (String, User)


parseJwtString: String -> Result JwtError JWT
parseJwtString token =

