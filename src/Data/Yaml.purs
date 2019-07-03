module Data.Yaml where


import Data.Function.Uncurried (Fn1, runFn1)

foreign import _safeLoad :: Fn1 String String

safeLoad :: String -> String
safeLoad yaml = do
  runFn1 _safeLoad yaml
