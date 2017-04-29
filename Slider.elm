{- This is a slider implementation I found online.
  This will be a good basis for my specific slider implementation.
  I will have to adapt it to my specific needs and add on to it,
  but this is a good starting point.
-}

module Slider exposing (..)

import Html
import Html exposing (..)
import Html.Attributes as H exposing (..)
import Html.Events exposing (on, onInput)
import String

type alias Model =
  Int


type Msg =
  ChangeSlider String


update : Msg -> Model -> Model
update (ChangeSlider v) model =
    String.toInt v |> Result.withDefault 0


view : Model -> Html Msg
view model =
  div []
    [ input
      [ type_ "range"
      , H.min "0"
      , H.max "50"
      , value <| toString model
      , onInput ChangeSlider
      ] []
    ,  text <| toString model
    ]


main =
  Html.beginnerProgram
    { model = 0
    , view = view
    , update = update
    }
