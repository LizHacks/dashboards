port module Login exposing (LoginModel, LoginMsg(..), init, update, view)

import Browser
import Config
import Html exposing (Html, button, div, form, h1, h2, img, section, text)
import Html.Attributes exposing (class, classList, src)
import Html.Events exposing (onSubmit)
import Http
import Json.Decode as Decode
import Json.Encode as Encode
import RemoteData exposing (WebData)
import UiUtils exposing (defaultFieldConfig, field)



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
    | LoginUpdate (WebData String)


update : LoginMsg -> Model a -> ( Model a, Cmd LoginMsg )
update msg ({ loginModel } as model) =
    case msg of
        UpdateEmail newEmail ->
            ( { model
                | loginModel =
                    { loginModel
                        | email = newEmail
                    }
              }
            , Cmd.none
            )

        UpdatePassword newPassword ->
            ( { model
                | loginModel =
                    { loginModel
                        | password = newPassword
                    }
              }
            , Cmd.none
            )

        LoginUpdate newToken ->
            -- TODO give feedback when the login fails
            ( { model | token = newToken }
            , case newToken of
                RemoteData.Loading ->
                    attemptLogin loginModel

                RemoteData.Success token ->
                    saveJwt token

                RemoteData.Failure err ->
                    Cmd.none

                RemoteData.NotAsked ->
                    Cmd.none
            )


attemptLogin : LoginModel -> Cmd LoginMsg
attemptLogin { email, password } =
    Http.post
        { url = Config.baseAccountApi ++ "/login"
        , body =
            Http.jsonBody <|
                Encode.object
                    [ ( "email", Encode.string email )
                    , ( "password", Encode.string password )
                    ]
        , expect = Http.expectJson (RemoteData.fromResult >> LoginUpdate) authTokenDecoder
        }


authTokenDecoder : Decode.Decoder String
authTokenDecoder =
    Decode.at [ "result", "token" ] Decode.string


port saveJwt : String -> Cmd msg



---- VIEW ----


view : Model a -> Browser.Document LoginMsg
view model =
    { title = "Deplomator - A LizHacks thingy - Please login"
    , body =
        [ section [ class "section" ]
            [ div [ class "container" ]
                [ h1 [ class "title" ] [ text "Deplomator: deploy and monitor repositive" ]
                , h2 [ class "subtitle" ] [ text "Before seeing cool charts and deploying anything: Login!" ]
                , div [ class "columns is-centered" ]
                    [ form [ class "column is-half", onSubmit (LoginUpdate RemoteData.Loading) ]
                        [ field
                            { defaultFieldConfig
                                | placeholder = "liz@repositive.io"
                            }
                            [ text "Email" ]
                            UpdateEmail
                        , field
                            { defaultFieldConfig
                                | placeholder = "**************"
                                , type_ = "password"
                            }
                            [ text "Password" ]
                            UpdatePassword
                        , div [ class "field" ]
                            [ div [ class "control" ]
                                [ button
                                    [ classList
                                        [ ( "button is-primary", True )
                                        , ( "is-loading is-disabled", RemoteData.isLoading model.token )
                                        ]
                                    ]
                                    [ text "Login!" ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        ]
    }
