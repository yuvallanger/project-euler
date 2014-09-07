#! /usr/bin/env runhaskell

import Debug.Trace
import Control.DeepSeq

loadProblem :: IO [[Int]]
loadProblem = do
  fileStr <- readFile "euler-011.txt"
  let fileLined = lines fileStr
      fileWords = fmap words fileLined
      fileInt   = fmap (fmap read) fileWords
  return fileInt

getItem :: Int -> Int -> [[a]] -> a
getItem row col xss = x
  where
    xs = xss !! row
    x  = xs  !! col

getHoriz :: Int -> Int -> [[a]] -> [a]
getHoriz row col xss = [a, b, c, d]
  where
    [a, b, c, d] = [getItem row (col + i) xss | i <- [0..3]]

getVert :: Int -> Int -> [[a]] -> [a]
getVert row col xss = [a, b, c, d]
  where
    [a, b, c, d] = [getItem (row + i) col xss | i <- [0..3]]

getSlash :: Int -> Int -> [[a]] -> [a]
getSlash row col xss = [a, b, c, d]
  where
    [a, b, c, d] = [getItem (row + 3 - i) (col + i) xss | i <- [0..3]]

getBackslash :: Int -> Int -> [[a]] -> [a]
getBackslash row col xss = [a, b, c, d]
  where
    [a, b, c, d] = [getItem (row + i) (col + 3 - i) xss | i <- [0..3]]

getFours :: Show a => [[a]] -> [[a]]
getFours xss = trace (show . map length $ fours) foursConcat
  where
    horizes      = [getHoriz       row col xss | row <- [0..19], col <- [0..16]]
    verts        = [getVert        row col xss | row <- [0..16], col <- [0..19]]
    slashes      = [getSlash       row col xss | row <- [0..16], col <- [0..16]]
    backslashes  = [getBackslash   row col xss | row <- [0..16], col <- [0..16]]
    fours        = [horizes, verts, slashes, backslashes]
    foursConcat  = concat [horizes, verts, slashes, backslashes]

main :: IO ()
main = do
  nums <- loadProblem
  print $ maximum . map product . getFours $ nums
