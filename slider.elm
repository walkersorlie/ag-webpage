module Slider exposing (..)

import Html exposing (Attribute, div, text, input)
import Html.Attributes as H exposing (..)
import Html.Events exposing (on, onInput)
import Json.Decode exposing (string, map)
import String

type alias Model = Int

type Msg
    = Update String

update : Msg -> Model -> Model
update (Update v) model =
    String.toInt v |> Result.withDefault 0

view model =
  div []
    [ input
      [ type_ "range"
      , H.min "0"
      , H.max "25"
      , value <| toString model
      , onInput Update
      ] []
    , text <| toString model
    ]

main =
  Html.beginnerProgram
    { model = 0
    , view = view
    , update = update
    }
