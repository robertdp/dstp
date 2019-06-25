module Main where

import Control.Monad.Error.Class
import Control.Monad.Except
import Effect.Aff.Compat
import Foreign
import Prelude

import Data.Either (Either(..))
import Data.Puppeteer as P
import Data.Yaml as Y
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Console (log)

main :: _
main = do
  case (Y.safeLoad template) of
    Right yaml -> log $ tagOf yaml
    Left e -> log "error occured"


template :: String
template = """
dstp:
  settings:
    headless: false
    debug: true
"""


--main :: Effect Unit
--main = launchAff_ do
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
