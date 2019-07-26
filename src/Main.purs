module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Puppeteer as P
import Data.Yaml as Y
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class.Console as Console

main :: _
main =  do
  loadConfig template

loadConfig :: String -> Effect Unit
loadConfig config = do
  maybeYaml <- Y.parseYaml config
  case maybeYaml of
    Nothing -> Console.log "can't load"
    Just (yaml :: Y.Config) -> Console.log $ show yaml


template :: String
template = """
dstp:
  settings:
    headless: false
    debug: true
"""

puppeteer :: Effect Unit
puppeteer = launchAff_ do
  browser <- P.launch { headless: false
                      , sloMo: 250
                      }
  page <- P.newPage browser
  P.goto page "https://www.amazon.co.jp"
  --P.click page "#nav-orders"
  P.screenshot page { path: "test.png"
                    , fullPage: true
                    }
  P.close browser
