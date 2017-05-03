module Poultry exposing (main)

import Html exposing (..)
import Html.Attributes as H exposing (..)
import Html.Events exposing (on, onInput)
import Element exposing (..)
import String


{-
  The type of message the 'view' is expecting
-}
type Msg =
  ChangeSlider String


{-
  This model represents the body text and the number
  that will influence how the results are displayed
-}
type alias Model  =
  { currentVal : Int
  }


{-
  Set what the first view of what the model looks like
-}
initialModel : Model
initialModel =
  { currentVal = 0 }


{-
  This is the update function that updates the slider.
  The value of the slider is used to update the carbon footprint of the user
-}
update : Msg -> Model -> Model
update num model =
  case num of
    ChangeSlider v ->
      { model | currentVal = String.toInt v |> Result.withDefault 0 }


{-
  Represents the slider and the paragraph of text.

  Have IntroDialog, then a slider, then some text that wont change,
  then another Dialog, then a slider, etc.
-}
view : Model -> Html Msg
view model =
  div []
    [ hr [] []
    , bodyUpdate model    -- displays the text before the slider
    , div []
      [ input
        [ type_ "range"
        , H.min "0"
        , H.max "50"
        , value <| toString model.currentVal
        , onInput ChangeSlider
        ] []
        ,  text <| toString model.currentVal
      ]
      , chickens model
      , hr [] []
      , hr [] []
      , hr [] []
      , endingText
    ]

{-
  White meat: consumption (kCal/day)*365*EF (kg CO2e/kCal) = emissions (kg CO2e/yr)

  Include info about how it's hard to get an exact number
  Combined turkey with chicken meat
-}
calcVal : Int -> Html msg
calcVal sliderVal =
  div []
    [ makePar ("For white meat, if you eat " ++ toString sliderVal ++ " pound(s) a month, your yearly white meat C02e emissions would be " ++ toString (calcWhiteMeatEmiss sliderVal) ++ " lbs C02e, or approximately " ++ toString (calcTons sliderVal) ++ " tons C02e per year.")
    , sub [] [ text "(The total emissions includes production emissions and post-production emissions.)" ]
    ]


{-
  Converts pounds to kilograms
  Rounds to the nearest whole number
-}
calcKilos : Int -> Float
calcKilos poundToKilo  =
  (toFloat poundToKilo / 0.453592)


{-
  Calculates the carbon emission of white meat
-}
calcWhiteMeatEmiss : Int -> Int
calcWhiteMeatEmiss poundOfWhiteMeat =
  round (((calcKilos poundOfWhiteMeat / 30.44) * 1716.5 * 365 * (17.8/1716.5)) * 2.20462)


{-
  Converts pounds to tons
  Rounds to the nearest whole number
-}
calcTons : Int -> Int
calcTons tons =
  round ((toFloat (calcWhiteMeatEmiss tons)) * 0.0005)


{-
  Creates a paragraph HTML header to pass to bodyUpdate
-}
makePar : String -> Html msg
makePar words =
  p [] [ text words ]


{-
  Represents the text area that will be updated depending on the value of the slider
-}
bodyUpdate : Model -> Html msg
bodyUpdate model =
  let val =
    calcVal model.currentVal
  in
    div []
      [ val
      ]

{-
  Creates an HTML msg of a sad chicken
-}
addSadChicken : Element.Element
addSadChicken =
    Element.image 210 210 "sadChicken.jpeg"


{-
  Adds pictures (and accompanying text) of either a happy chicken, sad chickens, or a dead planet depending on what the slider value is
-}
chickens : Model -> Html msg
chickens model =
  if (model.currentVal < 3) then
    div []
      [ Element.toHtml (Element.image 260 254 "happyChicken.png")
      , p [] [ text "Yah, you're eating no poultry! Imagine all the chickens and turkeys who are thanking you, not to mention the planet, which you are helping to save by consuming less poultry!" ]
      ]
  else if ((3 <= model.currentVal) && (model.currentVal < 12)) then
    div []
      [ Element.toHtml addSadChicken
      , p [] [ text "You're still eating poultry, but more or less the amount the average American eats, so don't think you're an outlier. You are average (but I think you can be better than average!)." ]
      ]
  else if ((12 <= model.currentVal) && (model.currentVal < 21)) then
    div []
      [ Element.toHtml (Element.flow Element.right [addSadChicken, addSadChicken])
      , p [] [ text "Ooh, you are eating more poultry than the average American conumes. The chickens and turkeys aren't too pleased, and neither is the planet." ]
      ]
  else if ((21 <= model.currentVal) && (model.currentVal < 31)) then
    div []
      [ Element.toHtml (Element.flow Element.right [addSadChicken, addSadChicken, addSadChicken])
      , p [] [ text "Oh man you really like you're poultry, don't you? I strongly suggest cutting back, because even though poultry is generally healthier than red meat, vegetables are still much better, especially for the planet." ]
      ]
  else if ((31 <= model.currentVal) && (model.currentVal < 41)) then
    div []
      [ Element.toHtml (Element.flow Element.right [addSadChicken, addSadChicken, addSadChicken, addSadChicken])
      , p [] [ text "Wow, you are eating about 4x as much poultry as the average American. The planet is really suffering. Turn back now!" ]
      ]
  else
    div []
      [ Element.toHtml (Element.image 250 250 "deadEarth.jpg")
      , p [] [ text "Good thing we all don't eat as much as you. You are eating 5x the amount of poultry as the average American. If every American ate this much poultry, there wouldn't be enough space on Earth to sustain us. Reconsider your choices." ]
      ]


{-
  Ending paragraph to that proposes a simple solution for everyone to take
  http://www.earthontheedge.com/how-much-co2-are-you-emitting/
  http://www.nationalchickencouncil.org/about-the-industry/statistics/per-capita-consumption-of-poultry-and-livestock-1965-to-estimated-2012-in-pounds/
  http://shrinkthatfootprint.com/calculate-your-carbon-footprint
-}
endingText : Html msg
endingText =
  div []
    [ p [] [ text "Hopefully after interacting witht this webpage, you have discovered that animal products cause serious harm to the environment in the form of carbon emissions, not even including other factors such as water runoff, land grabbing, etc. The issue of climate change and the environmental crisis is many-faceted and cannot be attributed to one root cause. However, a simple action every consumer can take is to consume fewer animal products. By switching from an average American diet to a vegetarian diet that still includes dairy, you can save around 661 pounds of C02 equivalents a year. If you switch to a vegan diet, you can save about 1542 pounds of C02 equivalents each year! That's a lot! It may seem challenging at the beginning, but trying to cut down the number of days you eat meat a week by 1, say from 5 days to 4 days, can be the first step towards reducing your animal product carbon footprint altogether." ]
    , hr [] []
    , div []
        [ a [ source1 ] [ text "Link to the info for how much C02e you can save from switching to vegetarian/vegan diets." ]
        ]
    , div []
        [ a [ source2 ] [ text "Link to the calculations I used to calculate carbon emissions." ]
        ]
    , div []
        [ a [ source3 ] [text "Link to the data for the average American meat consumption." ]
        ]
    , div []
        [ a [ source4 ] [ text "Link to great information about the carbon emissions from many different types of food, not just animal products." ]
        ]
    ]


{-
  Source link
-}
source1 : Html.Attribute msg
source1 =
  href "http://www.earthontheedge.com/how-much-co2-are-you-emitting/"


{-
  Source link
-}
source2 : Html.Attribute msg
source2 =
  href "http://shrinkthatfootprint.com/calculate-your-carbon-footprint"


{-
  Source link
-}
source3 : Html.Attribute msg
source3 =
  href "http://www.nationalchickencouncil.org/about-the-industry/statistics/per-capita-consumption-of-poultry-and-livestock-1965-to-estimated-2012-in-pounds/"


{-
  Source link
-}
source4 : Html.Attribute msg
source4 =
  href "http://static.ewg.org/reports/2011/meateaters/pdf/methodology_ewg_meat_eaters_guide_to_health_and_climate_2011.pdf"


{-
  Runs Poultry.elm, with the slider starting at the value '9'
-}
main =
  Html.beginnerProgram
    { model = { currentVal = 9 }
    , view = view
    , update = update
    }
