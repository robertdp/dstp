module Data.Fs where

import Data.Generic.Rep.Show
import Effect
import Effect.Uncurried
import Foreign.Generic
import Node.Encoding
import Node.FS.Sync
import Prelude

import Control.Promise as Promise
import Data.Either (Either(..))
import Data.Generic.Rep (class Generic)
import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Exception (try)

readFile :: String -> Effect String
readFile path = readTextFile UTF8 path
