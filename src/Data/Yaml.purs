module Data.Yaml where


import Control.Apply
import Prelude

import Control.Monad.Except (lift, runExcept)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)
import Effect.Exception (try)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Foreign.Generic (class Decode, Foreign, decode)

foreign import safeLoadImpl :: EffectFn1 String Foreign

{-
yaml structure

dstp:
  settings:
    headless: boolean
    debug: boolean

  difinitions:
    - name string
      baseUrl: string
      enabled: boolean
      route:
        - type: "goto"
          url: string
        - type: "imput"
          field:
            selector: string
            value: string


-}

data Kind = Goto | Input

type Dstp =
  { setting :: Setting
  , routes  :: Maybe (Array Difinitions)
  }

type Setting =
  { headless :: Boolean
  , debug    :: Boolean
  }

type Difinitions =
  { name    :: String
  , baseUrl :: String
  , enabled :: Boolean
  -- todo: multipule types
  , route   :: Array Goto
  }

type Goto = { url :: String }

type Input = { field :: Array Field }

type Field =
  { selector :: String
  , value    :: String
  }

parseYaml' :: _
parseYaml' input = do
  try $ runEffectFn1 safeLoadImpl input

parseYaml :: forall a. Decode a => String -> Effect (Maybe a)
parseYaml input = do
  maybeYaml <- try $ runEffectFn1 safeLoadImpl input
  pure case maybeYaml of
    Left loadErr ->
      Nothing
    Right yaml -> do
      case runExcept(decode yaml) of
        Left decodeErr ->
          Nothing
        Right output ->
          Just output
