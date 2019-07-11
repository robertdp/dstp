module Main where

import Data.Either
import Data.List.NonEmpty
import Foreign
import Prelude

import Control.Monad.Except (runExcept)
import Data.Maybe (Maybe(..))
import Data.Newtype (class Newtype, unwrap, wrap)
import Data.NonEmpty as NonEmpty
import Data.Puppeteer as P
import Data.Yaml as Y
import Effect (Effect)
import Effect.Aff (error, launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console as Console
import Foreign.Generic (class Decode, Foreign, decode)

main :: _
main = do
  maybeYaml <- Y.parseYaml' template
  case maybeYaml of
    Left e -> Console.log $ show e
    Right yaml -> do
      case runExcept(decode yaml) of
        Left decodeErr ->
          Console.log $ show $ decodeErr
        Right output ->
          Console.log output

--main :: _
--main =  do
--  maybeYaml <- Y.parseYaml template
--  case maybeYaml of
--    Nothing -> Console.log "can't load"
--    Just yaml -> Console.log yaml

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
