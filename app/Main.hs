{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.Text (Text)
import Text.Pandoc.JSON

default (Text, String)

main :: IO ()
main = toJSONFilter literateAgda

literateAgda :: Block -> IO Block
literateAgda (CodeBlock (_, ["agda"], _) t) = do
  pure $ RawBlock (Format "latex") ("\\begin{code}" <> "\n" <> t <> "\n" <> "\\end{code}")
literateAgda (CodeBlock (_, ["agda", "hide"], _) t) = do
  pure $ RawBlock (Format "latex") ("\\begin{code}[hide]" <> "\n" <> t <> "\n" <> "\\end{code}")
literateAgda x = return x
