module View exposing (view)

import IntroDialog exposing (view)
import Dialog exposing (..)
import Html exposing (..)
import Html.Attributes as H exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ IntroDialog.view
        , div []
          [ Dialog.view ]
        ]
