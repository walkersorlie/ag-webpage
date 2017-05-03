module IntroDialog exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Element exposing (..)
import Text exposing (..)
import Color exposing (..)


{-
  Displays the text from this module in Dialog.elm where it is called
-}
view : Html msg
view =
  nonChangeMsg


{-
  Alias for Style
  Used to create custom styles
-}
type alias Style =
  { typeface : List String
  , height : Maybe Float
  , color : Color
  , bold : Bool
  , italic : Bool
  , line : Maybe Line
  }


{-
  Custom style that can be used to format text
-}
myStyle : Style
myStyle =
    { typeface = [ "Times New Roman", "arial" ]
    , height = Just 17
    , color = black
    , bold = True
    , italic = False
    , line = Nothing
    }


{-
  Takes a String, applies myStyle, then returns a Text type
-}
myText : String -> Text
myText string =
  Text.style myStyle (concat [ fromString "\""
                            , fromString string
                            , fromString "\""
                            , fromString " - Smash Mouth"
                            ] )


{-
  Classic Smash Mouth quote to describe the burning world
-}
smashMouthQuote : Html msg
smashMouthQuote =
  Element.toHtml (leftAligned (myText "My worlds on fire, how about yours?"))


{-
  The function that combines different texts into one div
-}
nonChangeMsg : Html msg
nonChangeMsg =
  div []
      [ p [] [ text "The world is currently facing a global convergence of crises, and perhaps the most well-known crises is that of the environment." ]
      , div []
          [ Element.toHtml (Element.container 736 414 middle (Element.image 736 414 "world-fire.jpeg"))
          ]
      , div []
          [ blockquote [] [ smashMouthQuote ]
          ]
      ]
