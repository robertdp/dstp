module Data.Puppeteer where

import Prelude

import Control.Promise (Promise)
import Control.Promise as Promise
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Class.Console as Console

foreign import data Browser :: Type
foreign import data Page :: Type

foreign import _launch :: forall options. options -> Effect (Promise Browser)
foreign import _newPage :: Browser -> Effect (Promise Page)
foreign import _goto :: Page -> String -> Effect (Promise Unit)
foreign import _close :: Browser -> Effect (Promise Unit)
foreign import _click :: Page -> Selector -> Effect (Promise Unit)
foreign import _screenshot :: Page -> ScreenshotOptions -> Effect (Promise Unit)
foreign import _submit :: Page -> Selector -> Effect (Promise Unit)
foreign import _waitForNavigation :: Page -> Effect (Promise Unit)
foreign import _waitForSelector :: Page -> Selector -> Effect (Promise Unit)

type Options =
  { headless :: Boolean
  , sloMo    :: Int
  }

type Selector = String

type ScreenshotOptions =
  { path             :: String
  --, extension      :: String
  --, quality        :: Number
  , fullPage         :: Boolean
  --, clip           :: Clip
  --, omitBackground :: Boolean
  --, encoding       :: String
  }

type Clip =
  { x      :: Number
  , y      :: Number
  , width  :: Number
  , height :: Number
  }

launch :: Options -> Aff Browser
launch options = do
  promise <- liftEffect (_launch options)
  Promise.toAff promise


newPage :: Browser -> Aff Page
newPage browser = do
  promise <- liftEffect (_newPage browser)
  Promise.toAff promise

goto :: Page -> String -> Aff Unit
goto page url = do
  promise <- liftEffect (_goto page url)
  Promise.toAff promise

close :: Browser -> Aff Unit
close browser = do
  Console.log "Closing browser"
  promise <- liftEffect (_close browser)
  Promise.toAff promise

click :: Page -> Selector -> Aff Unit
click page selector = do
  Console.log "click"
  promise <- liftEffect (_click page selector)
  Promise.toAff promise

screenshot :: Page -> ScreenshotOptions -> Aff Unit
screenshot page option = do
  Console.log "screenshot"
  promise <- liftEffect (_screenshot page option)
  Promise.toAff promise

submit :: Page -> Selector -> Aff Unit
submit page selector = do
  Console.log "submit"
  promise <- liftEffect (_submit page selector)
  Promise.toAff promise

waitForNavigation :: Page -> Aff Unit
waitForNavigation page = do
  Console.log "waitForNavigation"
  promise <- liftEffect (_waitForNavigation page)
  Promise.toAff promise

waitForSelector :: Page -> Selector -> Aff Unit
waitForSelector page selector = do
  Console.log "waitForSelector"
  promise <- liftEffect (_waitForSelector page selector)
  Promise.toAff promise


--test :: forall a b. (a -> b) -> Aff Unit
--test arg = do
--  promise <- liftEffect $ arg
--  Promise.toAff promise
