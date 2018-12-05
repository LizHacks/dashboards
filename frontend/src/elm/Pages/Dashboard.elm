port module Pages.Dashboard exposing (DashboardModel, DashboardMsg(..), init, update, view)

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
