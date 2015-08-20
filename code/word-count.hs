-- Read from stdin and produce a sorted word frequency table

import Data.Char
import Data.List.Split
import qualified Data.Map as Map
import Data.List
import Data.Ord


-- Convert convert alphabeta character to lower case
-- and non-alphabet character to space
normalizeChar c = if isAlpha c then toLower c else ' '

-- Normalize each character in a string
normalizeString = map normalizeChar

-- Split string on space and filter empty strings
getWords s = filter (not . null) (splitOn " " s)

-- Count frequency of unique elements in a list
count xs = map (\x -> (length x, head x)) (group (sort xs))

-- Sort descending by frequency
sortByCount xs = sortBy (flip (comparing $ fst)) xs

main = do
    text <- getContents
    words <- return $ (getWords . normalizeString) text
    sequence_ [ putStrLn ("   " ++ show a ++ " " ++ b)
        | (a, b) <- (sortByCount . count) words ]

