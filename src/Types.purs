module Dstp.Types where

import Prelude

import Control.Monad.Error.Class (throwError)
import Data.Maybe (Maybe, fromMaybe)
import Data.Symbol (SProxy(..))
import Foreign.Generic (class Decode, class Encode, ForeignError(..), decode, encode)
import Record as Record


type Settings =
  { options :: Maybe Options
  , tasks :: Maybe Task
  }

type Options =
  { headless :: Maybe Boolean
  , sloMo :: Maybe Number
  }

type Task =
  { name :: String
  , baseUrl :: String
  , enabled :: Boolean
  , commands :: Array Command
  }

data Command
  = Goto
      { url :: String
      }
  | SetInput
      { selector :: String
      , value    :: String
      }
  | Click
      { selector :: String
      }
  | Screenshot ScreenshotOptions
  | WaitForSelector
      { selector :: String
      }

type ScreenshotOptions =
  { path :: String
  , extension :: String
  , quality :: Number
  , fullPage :: Boolean
  , omitBackground :: Boolean
  , encoding :: String
  }

instance decodeCommand :: Decode Command where
  decode cmd = do
    { command } <- decode cmd :: _ { command :: String }
    case command of
      "Goto" -> Goto <$> decode cmd
      "SetInput" -> SetInput <$> decode cmd
      "Click" -> Click <$> decode cmd
      "Screenshot" -> map Screenshot $
        decode cmd <#> \opts -> opts
          { quality = fromMaybe 0.8 opts.quality
          , fullPage = fromMaybe true opts.fullPage
          , omitBackground = fromMaybe false opts.omitBackground
          , encoding = fromMaybe "binary" opts.encoding
          }
      "WaitForSelector" -> WaitForSelector <$> decode cmd
      _ -> throwError $ pure $ ForeignError $ "Unrecognised command: " <> command

instance encodeCommand :: Encode Command where
  encode (Goto opts) = encode $ Record.insert (SProxy :: _ "command") "Goto" opts
  encode (SetInput opts) = encode $ Record.insert (SProxy :: _ "command") "SetInput" opts
  encode (Click opts) = encode $ Record.insert (SProxy :: _ "command") "Click" opts
  encode (Screenshot opts) = encode $ Record.insert (SProxy :: _ "command") "Screenshot" opts
  encode (WaitForSelector opts) = encode $ Record.insert (SProxy :: _ "command") "WaitForSelector" opts