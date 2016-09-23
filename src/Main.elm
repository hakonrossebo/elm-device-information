import Html.App as App
import Material

import Models exposing (..)
import CustomPorts exposing (..)
import Updates exposing (..)
import Views exposing (..)
import Commands exposing (..)
import Subscriptions exposing (..)

model : Model
model =
  { mdl = Material.model
  , currentOrientation = {alpha = 0, beta = 0, gamma = 0}
  , currentBatteryStatus = Nothing
  , browserPlatformInfo = Nothing
  , statusText = "Ready"
  , currentDate = Nothing
  , location = Nothing
  , height = 800
  , width = 1600
 }


main : Program Never
main =
  App.program
    { init = ( model, Cmd.batch [(fetchbrowserplatforminfo "test"), (fetchbatterystatus "test"), getLocation, getDate] )
    , view = view
    , subscriptions = subscriptions
    , update = update
    }

