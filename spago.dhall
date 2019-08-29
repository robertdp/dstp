{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name =
    "dstp"
, dependencies =
    [ "aff"
    , "aff-promise"
    , "console"
    , "foreign-generic"
    , "generics-rep"
    , "node-fs"
    , "prelude"
    , "yargs"
    ]
, packages =
    ./packages.dhall
, sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
}
