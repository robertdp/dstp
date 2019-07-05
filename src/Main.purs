module Main where

import Effect.Console(log)
import Prelude

import Data.Puppeteer as P
import Data.Yaml as Y
import Effect (Effect)
import Effect.Aff (launchAff_)

main :: _
main = do
  log $ Y.parseYAML template


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
