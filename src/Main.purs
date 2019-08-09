module Main where

import Config as C
import Prelude

import Data.Fs as F
import Data.Maybe (Maybe(..))
import Data.Puppeteer as P
import Data.Yaml as Y
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class.Console as Console

main :: _
main =  do
  yamlStr <- F.readFile "./config/config.yaml"
  config <- loadConfig yamlStr
  Console.logShow config

loadConfig :: String -> Effect Unit
loadConfig config = do
  maybeYaml <- Y.parseYaml config
  case maybeYaml of
    Nothing -> Console.log "can't load config file"
    Just (yaml :: C.Config) -> Console.log $ show yaml

launch :: C.Settings -> Effect Unit
launch options = launchAff_ do
  P.launch options


--puppeteer :: Effect Unit
--puppeteer = launchAff_ do
--  browser <- P.launch { headless: false
--                      , sloMo: 250
--                      }
--  page <- P.newPage browser
--  P.goto page "https://www.amazon.co.jp"
--  --P.click page "#nav-orders"
--  P.screenshot page { path: "test.png"
--                    , fullPage: true
--                    }
--  P.close browser
