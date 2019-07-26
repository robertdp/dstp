module Data.Yaml where


import Prelude

import Control.Monad.Except (runExcept)
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (try)
import Effect.Uncurried (EffectFn1, runEffectFn1)
import Foreign.Generic (Foreign, decode, defaultOptions, genericDecode)
import Foreign.Generic.Class (class Decode)

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


data Config = Config
  { dstp :: Dstp
  }

data Dstp = Dstp
  { settings :: Settings
  , routes   :: Maybe (Array Difinitions)
  }

data Settings = Settings
  { headless :: Boolean
  , debug    :: Boolean
  }

data Difinitions = Difinitions
  { name    :: String
  , baseUrl :: String
  , enabled :: Boolean
  -- , routes   :: Array Kind
  }

data Goto = Goto
  { url :: String
  }

data Input = Input
  { field :: Array Field
  }

data Field = Field
  { selector :: String
  , value    :: String
  }

derive instance genericRoot :: Generic Config _
derive instance genericDstp :: Generic Dstp _
derive instance genericSettings :: Generic Settings _
derive instance genericDifinitions :: Generic Difinitions _
derive instance genericGoto :: Generic Goto _
derive instance genericInput :: Generic Input _
derive instance genericField :: Generic Field _

instance showRoot :: Show Config where
  show = genericShow

instance showDstp :: Show Dstp where
  show = genericShow

instance showSetting :: Show Settings where
  show = genericShow

instance showDifinitions :: Show Difinitions where
  show = genericShow

instance showGoto :: Show Goto where
 show = genericShow

instance showInput :: Show Input where
 show = genericShow

instance showField :: Show Field where
 show = genericShow

instance decodeRoot :: Decode Config where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeDstp :: Decode Dstp where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeSettings :: Decode Settings where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeDifinitions :: Decode Difinitions where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

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
