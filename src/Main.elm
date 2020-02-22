module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, button, div, h1, img, input, label, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick, onInput)



---- MODEL ----


type alias Model =
    { title : String, savedTitle : Bool }


init : ( Model, Cmd Msg )
init =
    ( { title = "Remote Retro Board", savedTitle = False }, Cmd.none )



---- UPDATE ----


type Msg
    = UpdateTitle String
    | SaveTitle


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTitle str ->
            ( { model | title = str }, Cmd.none )

        SaveTitle ->
            ( { model | savedTitle = True }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ h1 [] [ text model.title ]
            , handleTitle model
            ]
        ]


handleTitle : Model -> Html Msg
handleTitle model =
    if model.savedTitle then
        div [] []

    else
        div []
            [ label [] [ text "Change Title" ]
            , input [ onInput UpdateTitle ] []
            , button [ onClick SaveTitle ] [ text "Save Title" ]
            ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
