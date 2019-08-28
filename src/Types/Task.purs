module Types.Task where

import Prelude

import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Maybe (Maybe)
import Foreign.Generic (defaultOptions, genericDecode)
import Foreign.Generic.Class (class Decode)
import Types.Commands (Commands)

data Task = Task
  { name    :: String
  , baseUrl :: String
  , enabled :: Boolean
  , commands  :: Commands
  }

derive instance genericDifinitions :: Generic Task _

instance showDifinitions :: Show Task where
  show = genericShow

instance decodeDifinitions :: Decode Task where
  decode = genericDecode $ defaultOptions { unwrapSingleConstructors = true }
