module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Either (Either(..))
import Global.Unsafe (unsafeStringify)
import Simple.JSON (readJSON)

type MyRecord =
  { a :: String
  , b :: Int
  , c :: Boolean
  }

goodJSON = """{
  "a": "apple",
  "b": 1,
  "c": true
}"""

badJSON = """{
  "a": "apple"
  "b": "wrong type",
  "c": true
}"""

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  let
    (goodParse :: Either _ MyRecord) = readJSON goodJSON
    (badParse :: Either _ MyRecord) = readJSON badJSON
    logEitherMyRecord (Left _) = log $ "failed to parse"
    logEitherMyRecord (Right _) = log "successfully parsed"
  logEitherMyRecord goodParse
  logEitherMyRecord badParse
  -- result:
  -- successfully parsed
  -- failed to parse
