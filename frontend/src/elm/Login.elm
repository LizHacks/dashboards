module Login exposing (LoginModel, LoginMsg(..), init, update, view)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import RemoteData exposing (WebData)



---- MODEL ----


type alias LoginModel =
    { email : String
    , password : String
    }


type alias Model a =
    { a
        | loginModel : LoginModel
        , token : WebData String
    }


init : LoginModel
init =
    { email = ""
    , password = ""
    }



---- UPDATE ----


type LoginMsg
    = UpdateEmail String
    | UpdatePassword String
    | LoadingUpdate (WebData ())


update : LoginMsg -> Model a -> ( Model a, Cmd LoginMsg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model a -> Browser.Document LoginMsg
view model =
    { title = "Deplomator - A LizHacks thingy - Please login"
    , body =
        [ h1 [] [ text "Before seeing cool charts and deploying anything: Login!" ]
        ]
    }
