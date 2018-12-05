port module Pages.Dashboard exposing (DashboardModel, DashboardMsg(..), init, update, view)

import Browser
import Entities.User exposing (JWT, JWTError)
import Html exposing (Html, a, button, div, figure, h1, h2, i, img, li, nav, section, span, text, ul)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import RemoteData exposing (RemoteData)



---- MODEL ----


type alias DashboardModel =
    {}


type alias Model a =
    { a
        | dashboardModel : DashboardModel
        , token : RemoteData JWTError JWT
    }


init : DashboardModel
init =
    {}



---- UPDATE ----


type DashboardMsg
    = Logout


update : DashboardMsg -> Model a -> ( Model a, Cmd DashboardMsg )
update msg ({ dashboardModel, token } as model) =
    case msg of
        Logout ->
            ( { model | token = RemoteData.NotAsked }, deleteJwt () )


port deleteJwt : () -> Cmd msg



---- VIEW ----


view : Model a -> Browser.Document DashboardMsg
view { dashboardModel, token } =
    { title = "Deplomator - A LizHacks thingy - Please login"
    , body =
        token
            |> RemoteData.map
                (\( rawToken, user ) ->
                    [ section [ class "hero is-fullheight" ]
                        [ div [ class "hero-head has-background-primary has-text-white" ]
                            [ nav [ class "navbar container flex items-center " ]
                                [ span [ class "flex-auto" ] [ text "CMP metrics Dashboard" ]
                                , figure [ class "image is-48x48" ]
                                    [ img [ class "is-rounded", src user.avatar ]
                                        []
                                    ]
                                , span [ class "p2" ] [ text user.name ]
                                , button [ class "button ", onClick Logout ] [ text "Logout" ]
                                ]
                            ]
                        , div [ class "hero-body" ]
                            [ div [ class "container has-text-centered" ]
                                [ text "there will be some plots there"
                                ]
                            ]
                        , div [ class "hero-foot" ]
                            [ text "there can be a footer here"
                            ]
                        ]
                    ]
                )
            |> RemoteData.withDefault []
    }
