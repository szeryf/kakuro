import Data.List
import Data.Char

digits :: [Int]
digits = [1..9]

combinations :: Int -> [a] -> [[a]]
combinations 0 _  = [ [] ]
combinations n xs = [ y:ys | y:xs' <- tails xs
                           , ys <- combinations (n-1) xs']

kakuroSums :: Int -> Int -> [[Int]]
kakuroSums k count = sort $
                     filter (\l -> k == sum l)
                            (combinations count digits)

combs :: [[a]] -> [[a]]
combs ((x:xs):xxs) = (map (x:) (combs xxs)) ++ combs (xs:xxs)
combs (xs:[]) = map (\x -> [x]) xs
combs ([]:xxs) = []
combs [] = [[]]

unique :: Eq a => [a] -> Bool
unique lst = lst == nub lst

kakuro :: Int -> [[Int]] -> [[Int]]
kakuro k lst = sort $
               filter (\l -> k == sum l)
               (filter unique (combs lst))

parse :: String -> [[Int]]
parse s = parse' s [] []
  where parse' (' ':xs) tmp res = tmp:parse' xs [] res
        parse' ('_':xs) tmp res = parse' xs digits res
        parse' (  x:xs) tmp res = parse' xs ((digitToInt x):tmp) res
        parse' [] tmp res = tmp:res

pk :: Int -> String -> [[Int]]
pk k s = kakuro k (parse s)

packOne :: [Int] -> [[Int]] -> [[Int]]
packOne (x:xs) (r:rs) | x `elem` r =    r  : (packOne xs rs)
                      | otherwise  = (x:r) : (packOne xs rs)
packOne xs [] = map (:[]) xs

pack :: [[Int]] -> [[Int]]
pack lst = map sort (pack' lst [])
  where pack' (x:xs) res = pack' xs (packOne x res)
        pack' [] res = res

-- main = do putStrLn $ show (kakuro 33 [[8,9],[7,9],[3],[7,8,9],[6]])
main = do putStrLn $ show $ pack result
          putStrLn $ intercalate "\n" $ map show result
         where result = pk 20 "8 15 12 145 45"
         -- where result = pk 22 "2 13 _ 135 7 45"
         -- where result = pk 23 "6 13 _ 1235 9"
