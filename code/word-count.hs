import Data.Char
import Data.List.Split
import qualified Data.Map as Map
import Data.List
import Data.Ord


-- Convert string to lowercase
lowerStr s = map toLower s

-- Convert non-alphabet character to space
nonAlphaToSpace c = if isAlpha c then c else ' '

-- Convert non-alphabet characters in string to spaces
convertNonAlpha s = map nonAlphaToSpace s

-- Split string on space and filter empty strings
getWords s = filter (not . null) (splitOn " " s)

-- Count frequency of unique elements in a list
count xs = map (\x -> (length x, head x)) (group (sort xs))

-- Sort descending by frequency
sortByCount xs = sortBy (flip (comparing $ fst)) xs

main = do
    text <- getContents
    words <- return $ (getWords . convertNonAlpha . lowerStr) text
    sequence_ [ putStrLn ("   " ++ show a ++ " " ++ b)
        | (a, b) <- (sortByCount . count) words ]

