{- 
 - Authors: Anders Linn and Thaer Khawaja
 -
 - A solver for the RushHour puzzle. The goal of this puzzle is to get the goal car from the
 - left side of the screen to the right side by sliding it across. Other cars can block its
 - path. To solve the puzzle, slide the other vehicles around to make a path for the goal car to
 - get through.
 -
 - Expects a list of Strings greater than or equal to 3x3.
 - Currently represents empty spaces with '-' and vehicles with different letters, like 'WWW'
 - or 'CC'. The goal car should be marked as 'XX'.
 -
 - Example puzzle:
 -									["--B---",
 -									 "--B---",
 -     							 "XXB---",
 -     							 "--AA--",
 -     							 "------",
 -     							 "------"]
 -
 - Searching can be quite time consuming when the search space is large. 
 - The hardest puzzles take about 30 seconds to solve.
 -}

import Data.List
import Data.Maybe
import qualified Data.PQueue.Min

{- Initialize algorithm.
 - Print the states in reverse order from the goal state using astarsearch
 -}
rushHour start = printStates(reverse (astarsearch (Data.PQueue.Min.singleton(((heuristic start 0), 0) , (start,[]))) []))

{- A* search algorithm. 
 - Expands neighbor states according to how many moves they are from the original state and
 - how far away from the goal state they are estimated to be. 
 -}
astarsearch :: Data.PQueue.Min.MinQueue((Integer, Integer), ([String], [[String]])) -> [[String]] -> [[String]]
astarsearch unexplored explored
   | Data.PQueue.Min.null unexplored                = []
   | isGoal nextState                               = nextState:path
   | elem nextState explored                        = astarsearch (Data.PQueue.Min.deleteMin unexplored) explored
   | otherwise                                      = result
     where result = astarsearch (insertAll 
                                  (generateNewStates nextState path pathLength)
                                  (Data.PQueue.Min.deleteMin unexplored))
                                (nextState:explored);
           stateInfo = fromJust (Data.PQueue.Min.getMin unexplored);
           nextState = fst (snd stateInfo);
           path = snd (snd stateInfo);
           pathLength = snd (fst stateInfo)

-- checks if goal is reached, astarsearch helper function
isGoal [] = False
isGoal (x:xs) = if (isGoalHelper x) == True then True else isGoal xs

isGoalHelper (x:y:[]) = if (x == 'X' && x == y) then True else False
isGoalHelper (x:y:ys) = isGoalHelper (y:ys)

-- insert all new states into the frontier, astarsearch helper function
insertAll :: [((Integer,Integer),([String],[[String]]))] -> Data.PQueue.Min.MinQueue((Integer, Integer), ([String], [[String]])) -> Data.PQueue.Min.MinQueue((Integer, Integer), ([String], [[String]]))
insertAll [] queue = queue
insertAll (x:xs) queue = insertAll xs (Data.PQueue.Min.insert x queue)

{- Heuristic function
 - Counts the distance to the goal, as well has how many vehicles are in the way, and how many vehicles are in turn blocking those vehicles.
 -}
heuristic :: [String] -> Integer -> Integer
heuristic toCheck pathLength = (distToGoal (findGoalRow toCheck) 0) + (numBlockedObstacles toCheck) + pathLength

distToGoal :: String -> Integer -> Integer
distToGoal [] count = count
distToGoal (x:xs)  count
  | x == '-'        = distToGoal xs (count + 1)
  | otherwise       = distToGoal xs (count + 2)

findGoalRow :: [String] -> String
findGoalRow (x:[])  = findGoalCar x
findGoalRow (x:xs)
  | not (null (findGoalCar x))  = findGoalCar x
  | otherwise                   = findGoalRow xs

findGoalCar :: String -> String
findGoalCar [] = []
findGoalCar (x:[]) = []
findGoalCar (x:y:xs)
  | (x == y) && (x == 'X')    = xs
  | otherwise                 = findGoalCar xs

numBlockedObstacles :: [String] -> Integer
numBlockedObstacles list  = numBlockedObstaclesHelper list (pathFromGoalCar) 0
    where pathFromGoalCar = findGoalRow list

numBlockedObstaclesHelper :: [String] -> String -> Integer -> Integer
numBlockedObstaclesHelper _ [] count = count
numBlockedObstaclesHelper list (x:xs) count
  | x == '-'        = numBlockedObstaclesHelper list xs count
  | otherwise       = numBlockedObstaclesHelper list xs (count + (checkBlocked list x))

checkBlocked :: [String] -> Char -> Integer
checkBlocked list x = checkBlockedHelper (findVehicleRow (transpose list) x) x 0

checkBlockedHelper :: String -> Char -> Integer -> Integer
checkBlockedHelper [] _ count = count
checkBlockedHelper (y:ys) x count
  | x == y          = checkBlockedHelper ys x count
  | y == '-'        = checkBlockedHelper ys x count
  | otherwise       = checkBlockedHelper ys x (count + 1)

findVehicleRow :: [String] -> Char -> String
findVehicleRow (x:[]) _ = x
findVehicleRow (x:xs) char
  | not (null (findVehicle x char)) = x
  | otherwise                       = findVehicleRow xs char

findVehicle :: String -> Char -> String
findVehicle [] _ = []
findVehicle (x:[]) _ = []
findVehicle (x:y:xs) char
  | (x == y) && (x == char)   = xs
  | otherwise                 = findVehicle (y:xs) char

numObstacles :: [String] -> Integer
numObstacles list = numObstaclesHelper (pathFromGoalCar) 0
    where pathFromGoalCar = findGoalRow list

numObstaclesHelper :: String -> Integer -> Integer
numObstaclesHelper [] count = count
numObstaclesHelper (x:xs) count
  | x == '-'        = numObstaclesHelper xs count
  | otherwise       = numObstaclesHelper xs (count + 1)



{-  
 - Generates all possible new states.
 -}
generateNewStates :: [String] -> [[String]] -> Integer -> [((Integer,Integer),([String],[[String]]))]
generateNewStates currState path length =
    [ ((h,newLength),(e,newPath)) | e <- (concat  [(generateAllHorizontalMoves currState), (generateAllVerticalMoves currState)]), let h = (heuristic e newLength)]
    where newPath = currState:path;
          newLength = length + 1

generateAllHorizontalMoves :: [String] -> [[String]]
generateAllHorizontalMoves currState = concat [ generateHorizontalMoves e currState | e <- currState ]

generateAllVerticalMoves :: [String] -> [[String]]
generateAllVerticalMoves currState = map transpose (generateAllHorizontalMoves (transpose currState))

generateHorizontalMoves :: String -> [String] -> [[String]]
generateHorizontalMoves currRow currState = [ combine r currRow currState | r <- (generateMoves currRow) ]

generateVerticalMoves :: String -> [String] -> [[String]]
generateVerticalMoves currCol currState = generateHorizontalMoves currCol currState

combine :: String -> String -> [String] -> [String]
combine _  _ [] = []
combine row orig (x:xs)
  | orig == x         = row:xs
  | otherwise         = x:(combine row orig xs)

--generate a list of all the possible moves for a given row or column
generateMoves :: String -> [String]
generateMoves [] = []
generateMoves (_:[]) = []
generateMoves (_:_:[]) = []
generateMoves (x:y:z:[])
  | y == '-'            = []
  | x == y && z == '-'  = [(z:x:y:[])]
  | x == '-' && y == z = [(y:z:x:[])]
  | otherwise           = []

generateMoves (w:x:y:z:zs)
  | not (null result) && isTruck  = result:(getResult (w:) (getResult (x:) (generateMoves (y:z:zs))))
  | null result && isTruck        = (getResult (w:) (getResult (x:) (generateMoves (y:z:zs))))
  | not (null result)             = result:(getResult (w:) (generateMoves (x:y:z:zs)))
  | otherwise                     = (getResult (w:) (generateMoves (x:y:z:zs)))
    where result = generateMovesHelper (w:x:y:z:zs);
          isTruck = (w == x && w == y && z == '-')

getResult :: (String -> String) -> [String] -> [String]
getResult _ [] = []
getResult f list = map f list

-- checks for possible moves in a given subset of string
generateMovesHelper :: String -> String
generateMovesHelper (w:x:y:z:zs)
  | x == '-'                      = []
  | w == x && w == y && z == '-'  = z:w:x:y:zs
  | w == x && y == '-'            = y:w:x:z:zs
  | w == '-' && x == y && x /= z  = x:y:w:z:zs
  | w == '-' && x == y && x == z  = x:y:z:w:zs
  | otherwise                     = []

{- Helper function for viewing output and test cases -}

printStates states = mapM_ printState states

printState state = do
  mapM_ putStrLn state
  putStrLn ""

-- pass these as parameters to rushHour function
	
w = ["--B---",
     "--B---",
     "XXB---",
     "--AA--",
     "------",
     "------"]

x = ["--BDD-",
     "--B-E-",
     "XXB-E-",
     "--AAC-",
     "GF-HC-",
     "GF-HC-"]


y = ["DBBB--",
     "D--C--",
     "XX-C--",
     "E-IIIH",
     "E----H",
     "FFFGGH"]

z = ["A-LLLK",
     "AHHIJK",
     "XXGIJK",
     "BBGFJ-",
     "---FEE",
     "-CCDD-"]

a = ["------",
     "------",
     "------",
     "------",
     "------",
     "------"]

b = ["AABC--",
     "D-BC--",
     "DXXC--",
     "DEEE--",
     "------",
     "---FFF"]


c = ["AA-BBB",
     "---DCC",
     "IXXD-F",
     "I-HEEF",
     "JJH--F",
     "--HGGG"]
