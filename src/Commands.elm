module Commands exposing (..)

import Task
import Date
import Window
import Messages exposing (..)
import Geolocation exposing (..)

getDate : Cmd Msg
getDate =
    Task.perform  NewDate Date.now

getLocation : Cmd Msg
getLocation =
    Task.attempt LocationResult Geolocation.now

initialSizeCmd : Cmd Msg
initialSizeCmd =
    Task.perform sizeToMsg Window.size


sizeToMsg : Window.Size -> Msg
sizeToMsg size =
    Resize size.width size.height

