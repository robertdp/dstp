module Types.Dstp where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe)
import Foreign.Generic (defaultOptions, genericDecode)
import Foreign.Generic.Class (class Decode)
import Types.Settings (Settings)

data Dstp = Dstp
  { dstp :: Settings
  }


derive instance genericDstp :: Generic Dstp _

instance showDstp :: Show Dstp where
  show = genericShow

instance decodeDstp :: Decode Dstp where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }

