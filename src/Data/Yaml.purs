module Data.Yaml where


import Control.Monad.Except
import Data.Either
import Data.Identity
import Effect.Exception
import Effect.Unsafe
import Foreign
import Prelude

import Data.Bifunctor (lmap)
import Data.Function.Uncurried (Fn1, runFn1)

foreign import safeLoadImpl :: Fn1 String (F Foreign)

{-
yaml structure

dstp:
  settings:
    headless: boolean
    debug: boolean

  difinitions:
    - name string
      baseUrl: string
      enabled: boolean
      route:
        - type: "goto"
          url: string
        - type: "imput"
          field:
            selector: string
            value: string


-}

data Kind = Goto | Input

type Dstp =
  { setting :: Setting
  , routes  :: Array Difinitions
  }

type Setting =
  { headless :: Boolean
  , debug    :: Boolean
  }

type Difinitions =
  { name    :: String
  , baseUrl :: String
  , enabled :: Boolean
  -- todo: multipule types
  , route   :: Array Goto
  }

type Goto = { url :: String }

type Input = { field :: Array Field }

type Field =
  { selector :: String
  , value    :: String
  }

safeLoad :: String -> F Foreign
safeLoad yaml = runFn1 safeLoadImpl yaml

parseYAML :: String -> String
parseYAML yaml = case runExcept $ safeLoad yaml of
  Left err -> "counld not parse yaml"
  Right result -> tagOf result
