module Dstp where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe)
import Foreign.Generic (defaultOptions, genericDecode)
import Foreign.Generic.Class (class Decode)

data Dstp = Dstp
  { dstp :: { settings    :: Maybe PuppeteerOptions
            , difinitions :: Maybe Difinitions
            }
  }

data Settings = Settings
  { puppeteer :: Maybe PuppeteerOptions
  }

data PuppeteerOptions = PuppeteerOptions
  { headless   :: Maybe Boolean
  , sloMo      :: Maybe Number
  }

data Difinitions = Difinitions
  { name    :: String
  , baseUrl :: String
  , enabled :: Boolean
  , routes  :: { goto       :: Maybe Goto
               , input      :: Maybe Input
               , click      :: Maybe Click
               , screenshot :: Maybe Screenshot
               , waitForNavigation :: Maybe Unit
               , waitForSelector :: Maybe WaitForSelector
               }
  }

data Goto = Goto
  { url :: String
  }

data Input = Input
  { field :: Field
  }

data Field = Field
  { selector :: String
  , value    :: String
  }

data Click = Click
  { selector :: String
  }

data Screenshot = Screenshot
  { path           :: Maybe String
  , extension      :: Maybe String
  , quality        :: Maybe Number
  , fullPage       :: Maybe Boolean
  , clip           :: Maybe Clip
  , omitBackground :: Maybe Boolean
  , encoding       :: Maybe String
  }

data Clip = Clip
  { x      :: Maybe Number
  , y      :: Maybe Number
  , width  :: Maybe Number
  , height :: Maybe Number
  }

data WaitForSelector = WaitForSelector
  { selector :: Maybe String
  }


derive instance genericDstp :: Generic Dstp _
derive instance genericSettings :: Generic Settings _
derive instance genericDifinitions :: Generic Difinitions _
derive instance genericGoto :: Generic Goto _
derive instance genericInput :: Generic Input _
derive instance genericField :: Generic Field _
derive instance genericPuppeteerOptions :: Generic PuppeteerOptions _
derive instance genericClick :: Generic Click _
derive instance genericScreenshot :: Generic Screenshot _
derive instance genericClip :: Generic Clip _
derive instance genericWfs :: Generic WaitForSelector _

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

instance showPuppeteerOptions :: Show PuppeteerOptions where
  show = genericShow

instance showClick :: Show Click where
  show = genericShow

instance showScreenshot :: Show Screenshot where
  show = genericShow

instance showClip :: Show Clip where
  show = genericShow

instance shoewWaitForSelector :: Show WaitForSelector where
  show = genericShow

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

instance decodePuppeterOptions :: Decode PuppeteerOptions where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeClick :: Decode Click where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeScreenshot :: Decode Screenshot where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeClip :: Decode Clip where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

instance decodeWaitForSelector :: Decode WaitForSelector where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

