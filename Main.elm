module Main exposing (..)

import Html exposing (Html, div, text, program)
import Html.Attributes exposing (style)
import Mouse exposing (Position)


type Msg
    = Moved Position
    | Up Position


type alias Model =
    { current : Maybe Position
    , lastUp : Maybe Position
    }


init : ( Model, Cmd msg )
init =
    ( Model Nothing Nothing, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Moved position ->
            ( { model | current = Just position }, Cmd.none )

        Up position ->
            ( { model | lastUp = Just position }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Mouse.moves Moved, Mouse.ups Up ]


view : Model -> Html Msg
view model =
    case model.current of
        Nothing ->
            text "Mouse hasn't moved yet!"

        Just position ->
            div []
                [ text ("X:" ++ (toString position.x) ++ "Y:" ++ (toString position.y))
                , lastUpCircle model
                ]


lastUpCircle : Model -> Html msg
lastUpCircle model =
    case model.lastUp of
        Nothing ->
            div [] []

        Just position ->
            div
                [ style
                    [ ( "position", "fixed" )
                    , ( "background-color", "red" )
                    , ( "width", "100px" )
                    , ( "height", "100px" )
                    , ( "top", (toString position.y) ++ "px" )
                    , ( "left", (toString position.x) ++ "px" )
                    ]
                ]
                []


main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
