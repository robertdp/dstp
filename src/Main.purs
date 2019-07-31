module Main where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Puppeteer as P
import Data.Yaml as Y
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class.Console as Console
import Data.Either (Either(..))
import Control.Monad.Except (runExcept)
import Foreign.Generic (decode)

main :: _
main =  do
  loadConfig' template

loadConfig' :: _
loadConfig' config = do
  maybeYaml <- Y.parseYaml' config
  case maybeYaml of
    Left loadErr ->
      Console.log $ show loadErr
    Right yaml -> do
      case runExcept(decode yaml) of
        Left decodeErr ->
          Console.log $ show decodeErr
        Right (output :: Y.Config) ->
          Console.log $ show output


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

  difinitions:
    - name: 'bord'
      baseUrl: 'https://example.com'
      enabled: true
      routes:
       - kind: 'goto'
         url: 'login'
       - kind: 'input'
         field:
           selector: 'input[type=\"email\"]'
           value: 'hogehoge@example.com'

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
