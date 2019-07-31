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


data Config = Config
  { dstp :: Dstp
  }

data Dstp = Dstp
  { settings :: Maybe Settings
  , difinitions   :: Maybe (Array Difinitions)
  }

data Settings = Settings
  { headless :: Boolean
  , debug    :: Boolean
  }

data Difinitions = Difinitions
  { name    :: String
  , baseUrl :: String
  , enabled :: Boolean
  , routes   :: Maybe (Array Routes)
  }

data Types = GotoType Goto | InputType Input
data Routes = Routes
  { route :: Types
  }

data Goto = Goto
  { kind :: String
  , url :: String
  }

data Input = Input
  { kind :: String
  , field :: Field
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
derive instance genericRoutes :: Generic Routes _
derive instance genericTypes :: Generic Types _

instance showConfig :: Show Config where
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

instance showRoutes :: Show Routes where
 show = genericShow

instance showTypes :: Show Types where
 show = genericShow

instance decodeConfig :: Decode Config where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeDstp :: Decode Dstp where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeSettings :: Decode Settings where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeDifinitions :: Decode Difinitions where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeGoto :: Decode Goto where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeInput :: Decode Input where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeField :: Decode Field where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeRoutes :: Decode Routes where
  decode = genericDecode defaultOptions

instance decodeTypes :: Decode Types where
  decode = genericDecode defaultOptions

parseYaml' :: _
parseYaml' input = try $ runEffectFn1 safeLoadImpl input

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
