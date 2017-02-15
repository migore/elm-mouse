module Main exposing (..)

import Html exposing (Html, div, text, program)


type Msg
    = NoOp


type alias Model =
    String


init : ( Model, Cmd msg )
init =
    ( "Hello", Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    text model


main =
    program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
