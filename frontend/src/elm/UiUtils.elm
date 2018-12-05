module UiUtils exposing (BulmaType(..), FieldConfig, defaultFieldConfig, field)

import Html exposing (Html, div, form, i, input, label, span)
import Html.Attributes exposing (class, classList, type_)


type BulmaType
    = Primary
    | Link
    | Info
    | Success
    | Warning
    | Danger


bulmaTypeToClassName : BulmaType -> String
bulmaTypeToClassName bulmaType =
    case bulmaType of
        Primary ->
            "is-primary"

        Link ->
            "is-link"

        Info ->
            "is-info"

        Success ->
            "is-success"

        Warning ->
            "is-warning"

        Danger ->
            "is-danger"


type alias FieldConfig =
    { type_ : String
    , placeholder : String
    , iconLeft : Maybe String
    , iconRight : Maybe String
    , status : Maybe ( BulmaType, String )
    }


defaultFieldConfig : FieldConfig
defaultFieldConfig =
    { type_ = "text"
    , placeholder = ""
    , iconLeft = Nothing
    , iconRight = Nothing
    , status = Nothing
    }


field : FieldConfig -> List (Html msg) -> (String -> msg) -> Html msg
field config labelContent onChange =
    div [ class "field" ]
        [ label [ class "label" ] labelContent
        , div
            [ classList [ ( "control", True ), ( "has-icon-left", config.iconLeft /= Nothing ), ( "has-icon-right", config.iconRight /= Nothing ) ] ]
          <|
            input
                [ class "input", type_ config.type_ ]
                []
                :: ([ config.iconLeft
                        |> Maybe.map
                            (\iconClass ->
                                span [ class "icon is-small is-left" ]
                                    [ i [ class iconClass ] []
                                    ]
                            )
                    , config.iconRight
                        |> Maybe.map
                            (\iconClass ->
                                span [ class "icon is-small is-right" ] [ i [ class iconClass ] [] ]
                            )
                    ]
                        |> List.filterMap identity
                   )
        ]
