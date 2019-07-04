module Data.Yaml where


import Data.Function.Uncurried (Fn1, runFn1)

foreign import _safeLoad :: Fn1 String String

data Kind = Goto | Input | Submit | Click

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

safeLoad :: String -> String
safeLoad yaml = do
  runFn1 _safeLoad yaml
