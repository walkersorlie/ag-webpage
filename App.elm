module App exposing (main)

import IntroDialog exposing (..)
import View exposing (..)
-- import Slider exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


{- Maybe one 'View' module to represent the view
  subscriptions maybe???
-}


main =
  Html.beginnerProgram
    { model = Dialog.model
    , view = View.view
    , update = Dialog.update
    }
