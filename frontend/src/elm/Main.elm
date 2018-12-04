module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import Url exposing (Url)



---- MODEL ----


type alias Model =
    { token : Maybe String
    }


type alias Flags =
    Maybe String


init : Flags -> ( Model, Cmd Msg )
init maybeToken =
    ( { token = maybeToken
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ChangeUrl Url
    | ClickedLink Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "Deplomator - A LizHacks thingy"
    , body =
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        ]
    }



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.application
        { view = view
        , init = \flags _ _ -> init flags
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = ChangeUrl
        , onUrlRequest = ClickedLink
        }
