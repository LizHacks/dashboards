module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Browser.Navigation exposing (Key)
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (src)
import List
import Pages.Login as Login exposing (LoginModel)
import RemoteData exposing (WebData)
import Url exposing (Url)



---- MODEL ----


type alias Model =
    { loginModel : LoginModel
    , token : WebData String
    , key : Browser.Navigation.Key
    }


type alias Flags =
    Maybe String


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init maybeToken _ key =
    case maybeToken of
        Just token ->
            ( { loginModel = Login.init
              , key = key
              , token = RemoteData.Success token
              }
            , Cmd.none
            )

        Nothing ->
            ( { loginModel = Login.init
              , key = key
              , token = RemoteData.NotAsked
              }
            , Cmd.none
            )



---- UPDATE ----


type Msg
    = ChangeUrl Url
    | ClickedLink Browser.UrlRequest
    | LoginMsg Login.LoginMsg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeUrl _ ->
            ( model, Cmd.none )

        ClickedLink _ ->
            ( model, Cmd.none )

        LoginMsg loginMsg ->
            Login.update loginMsg model
                |> (\( newModel, loginCmd ) -> ( newModel, loginCmd |> Cmd.map LoginMsg ))



---- VIEW ----


mapDocument : (a -> Msg) -> Browser.Document a -> Browser.Document Msg
mapDocument toMsg { title, body } =
    { title = title
    , body = List.map (Html.map toMsg) body
    }


view : Model -> Browser.Document Msg
view ({ token } as model) =
    if RemoteData.isSuccess token then
        { title = "Deplomator - A LizHacks Thingy"
        , body =
            [ h1 [] [ text "There will be some stuff here" ]
            ]
        }

    else
        Login.view model |> mapDocument LoginMsg



---- PROGRAM ----


main : Program Flags Model Msg
main =
    Browser.application
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = ChangeUrl
        , onUrlRequest = ClickedLink
        }
