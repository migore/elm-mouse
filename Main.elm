module Main exposing (..)

import Mouse exposing (Position)
import Html exposing (Html, div, text, program)


type Msg
    = Moved Position


type alias Model =
    Position


init : ( Model, Cmd msg )
init =
    ( Position 100 100, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Moved position ->
            ( position, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Mouse.moves Moved


view : Model -> Html Msg
view model =
    text ("X:" ++ (toString model.x) ++ "Y:" ++ (toString model.y))


main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
