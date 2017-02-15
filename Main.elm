module Main exposing (..)

import Mouse exposing (Position)
import Html exposing (Html, div, text, program)


type Msg
    = Moved Position


type alias Model =
    Maybe Position


init : ( Model, Cmd msg )
init =
    ( Nothing, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Moved position ->
            ( Just position, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves Moved


view : Model -> Html Msg
view model =
    case model of
        Nothing ->
            text "Mouse hasn't moved yet!"

        Just position ->
            text ("X:" ++ (toString position.x) ++ "Y:" ++ (toString position.y))


main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
