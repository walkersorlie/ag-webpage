module IntroDialog exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html msg
view =
  nonChangeMsg

nonChangeMsg : Html msg
nonChangeMsg =
  div []
      [ p [] [ text "I will display all intro info here. This stuff will not be affected by the slider"]
      ]
