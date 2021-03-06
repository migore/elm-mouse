module Main exposing (..)

import Html exposing (Html, div, text, program)
import Html.Attributes exposing (style)
import Mouse exposing (Position)


type Msg
    = Moved Position
    | Down Position
    | Up Position


type Model
    = NotStarted
    | MouseDown RedSquarePosition ShadowSquarePosition
    | MouseUp RedSquarePosition


type alias RedSquarePosition =
    Position


type alias ShadowSquarePosition =
    Position


type alias Color =
    String


init : ( Model, Cmd msg )
init =
    ( NotStarted, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Moved position ->
            case model of
                MouseDown redSquare shadowSquare ->
                    MouseDown redSquare position ! []

                _ ->
                    model ! []

        Down position ->
            MouseDown position position ! []

        Up position ->
            MouseUp position ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ Mouse.moves Moved, Mouse.downs Down, Mouse.ups Up ]


view : Model -> Html Msg
view model =
    case model of
        NotStarted ->
            text "Click and drag to play!"

        MouseDown redSquare graySquare ->
            div []
                [ drawSquare "red" redSquare
                , drawSquare "gray" graySquare
                ]

        MouseUp redSquare ->
            div []
                [ drawSquare "blue" redSquare
                ]

drawSquare : Color -> Position -> Html msg
drawSquare color position =
    div
        [ style
            [ ( "position", "fixed" )
            , ( "background-color", color )
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
