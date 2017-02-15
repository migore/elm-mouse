module Main exposing (..)

import Html exposing (Html, div, text, program)
import Html.Attributes exposing (style)
import Mouse exposing (Position)


type Msg
    = Moved Position
    | Down Position
    | Up Position


type alias Model =
    { current : Maybe Position
    , square : Maybe Position
    , isDown : Bool
    }


init : ( Model, Cmd msg )
init =
    ( Model Nothing Nothing False, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Moved position ->
            ( { model | current = Just position }, Cmd.none )

        Down position ->
            ( { model | isDown = True, square = Just position }, Cmd.none )

        Up position ->
            ( { model | isDown = False, square = Just position }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Mouse.moves Moved, Mouse.downs Down, Mouse.ups Up ]


view : Model -> Html Msg
view model =
    case model.current of
        Nothing ->
            text "Mouse hasn't moved yet!"

        Just position ->
            div []
                [ text ("X:" ++ (toString position.x) ++ "Y:" ++ (toString position.y))
                , redSquare model
                , mouseFollowSquare model
                ]


mouseFollowSquare : Model -> Html msg
mouseFollowSquare model =
    case model.isDown of
        False ->
            div [] []

        True ->
            case model.current of
                Nothing ->
                    div [] []

                Just position ->
                    div
                        [ style
                            [ ( "position", "fixed" )
                            , ( "background-color", "gray" )
                            , ( "width", "100px" )
                            , ( "height", "100px" )
                            , ( "top", centerSquareCssPixels position.y )
                            , ( "left", centerSquareCssPixels position.x )
                            ]
                        ]
                        []


redSquare : Model -> Html msg
redSquare model =
    case model.square of
        Nothing ->
            div [] []

        Just position ->
            div
                [ style
                    [ ( "position", "fixed" )
                    , ( "background-color", "red" )
                    , ( "width", "100px" )
                    , ( "height", "100px" )
                    , ( "top", centerSquareCssPixels position.y )
                    , ( "left", centerSquareCssPixels position.x )
                    ]
                ]
                []


centerSquareCssPixels : Int -> String
centerSquareCssPixels value =
    let
        center =
            value - halfSquareSide
    in
        (toString center) ++ "px"


halfSquareSide : Int
halfSquareSide =
    50


main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
