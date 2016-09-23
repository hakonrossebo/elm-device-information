module Commands exposing (..)

import Task
import Date
import Array
import Window

import Models exposing (..)
import Messages exposing (..)
import Utils exposing (..)
import Geolocation


getDate : Cmd Msg
getDate = Task.perform (\_ -> NoOp) NewDate Date.now

getLocation : Cmd Msg
getLocation = Task.perform (\_ -> NoOp) LocationReceived Geolocation.now

initialSizeCmd : Cmd Msg
initialSizeCmd =
    Task.perform (\_ -> NoOp) sizeToMsg Window.size

sizeToMsg : Window.Size -> Msg
sizeToMsg size =
    Resize size.width size.height
