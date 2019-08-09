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
import Foreign.Generic (class Decode, Foreign, decode, defaultOptions, genericDecode)
import Foreign.Generic.Class (class Decode)

foreign import safeLoadImpl :: EffectFn1 String Foreign

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
