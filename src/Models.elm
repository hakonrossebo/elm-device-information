module Models exposing (..)

import Material
import Date
import Geolocation exposing (..)
import Time
import Array


type alias Model =
    { mdl : Material.Model
    , currentOrientation : Orientation
    , currentBatteryStatus : Maybe BatteryStatus
    , browserPlatformInfo : Maybe BrowserPlatformInfo
    , statusText : String
    , currentDate : Maybe Date.Date
    , location : Maybe Location
    , height : Int
    , width : Int
    }


type alias Orientation =
    { alpha : Float
    , beta : Float
    , gamma : Float
    }


type alias BatteryStatus =
    { charging : Bool
    , dischargingTime : Float
    , level : Float
    }


type alias BrowserPlatformInfo =
    { userAgent : String
    , browser : String
    , platform : String
    , oscpu : String
    , appName : String
    , appVersion : String
    , appCodeName : String
    }


type alias Mdl =
    Material.Model
