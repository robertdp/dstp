module Data.Yaml where

import Control.Monad.Error.Class
import Control.Monad.Except
import Data.List.Types
import Effect.Aff.Compat
import Foreign
import Prelude

import Data.Either (Either(..))
import Data.Function.Uncurried (Fn3, runFn3)
import Effect (Effect)
import Effect.Aff (Aff, Error)
import Effect.Class (liftEffect)
import Effect.Class.Console as Console

foreign import _safeLoad :: String -> F Foreign


safeLoad :: String -> Either (NonEmptyList ForeignError) Foreign
safeLoad yaml = runExcept $ _safeLoad yaml
