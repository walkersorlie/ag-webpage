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
      [ p [] [ text "The world is currently facing a global convergence of seven different crises, but perhaps the most well-known and public crisis is climate change. The environmental crisis has been slowly growing in magnitude over the last century, mostly in part to the increase in industrial agriculture and other globalized practices. Industrial agriculture promotes monocropping (the farming of one or two main crops on a farming system), pesticide and fertilizer use, fossil fuel consumption, and anthropocentrism (the belief that humans are superiour to nature), all of which have contributed to a state of environmental degredation, the likes of which humanity has not seen. " ]
      , div []
          [ Element.toHtml (Element.container 736 414 middle (Element.image 736 414 "world-fire.jpeg"))
          ]
      , div []
          [ blockquote [] [ smashMouthQuote ]
          ]
      , hr [] []
      , div []
          [ p [] [ text "Lets take a loot at three different sectors of the animal products industry: meat, dairy, and poultry. These are the three biggest hydrocarbon emitters that fall under the animal product banner."]
          ]
      , hr [] []
      ]
