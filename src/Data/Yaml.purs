module Data.Yaml where


import Control.Apply
import Data.Generic.Rep
import Foreign.Generic.Class
import Prelude

import Control.Monad.Except (lift, runExcept)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Newtype (class Newtype, unwrap, wrap)
import Effect (Effect)
import Effect.Class.Console as Console
import Effect.Console (log)
import Effect.Exception (try)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Foreign.Generic (class Decode, Foreign, decode, defaultOptions, genericDecode)

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

--data Kind = Goto | Input

newtype Root = Root
  { dstp :: Dstp
  }

newtype Dstp = Dstp
  { settings :: Settings
  , routes   :: Maybe (Array Difinitions)
  }

newtype Settings = Settings
  { headless :: Boolean
  , debug    :: Boolean
  }

newtype Difinitions = Difinitions
  { name    :: String
  , baseUrl :: String
  , enabled :: Boolean
  --, routes   :: Array Kind
  }

newtype Goto = Goto { url :: String }

newtype Input = Input { field :: Array Field }

newtype Field = Field
  { selector :: String
  , value    :: String
  }

derive instance genericRoot :: Generic Root _
derive instance genericDstp :: Generic Dstp _
derive instance genericSettings :: Generic Settings _
derive instance genericDifinitions :: Generic Difinitions _

instance showRoot :: Show Root where
  show = genericShow

instance showDstp :: Show Dstp where
  show = genericShow

instance showSetting :: Show Settings where
  show = genericShow

instance showDifinitions :: Show Difinitions where
  show = genericShow

--instance showGoto :: Show Goto where
--  show = genericShow

--instance showInput :: Show Input where
--  show = show $ genericShow
--
--instance showField :: Show Field where
--  show = genericShow

instance decodeRoot :: Decode Root where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeDstp :: Decode Dstp where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeSettings :: Decode Settings where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeDifinitions :: Decode Difinitions where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }



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
