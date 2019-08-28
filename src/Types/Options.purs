module Types.Options where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe)
import Foreign.Generic (defaultOptions, genericDecode)
import Foreign.Generic.Class (class Decode)

newtype Options = Options
  { headless   :: Maybe Boolean
  , sloMo      :: Maybe Number
  }

derive instance genericOptions :: Generic Options _

instance showOptions :: Show Options where
  show = genericShow

instance decodeOptions :: Decode Options where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }
