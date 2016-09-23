module Messages exposing (..)

import Material
import Models exposing (..)
import Date
import Geolocation exposing (..)

type Msg
  = NoOp
  | Resize Int Int
  | Mdl (Material.Msg Msg)
  | OrientationMessage Orientation
  | BatteryMessage BatteryStatus
  | BrowserPlatformInfoMessage BrowserPlatformInfo
  | NewDate Date.Date
  | LocationReceived Location



