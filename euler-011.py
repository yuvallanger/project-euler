#!/usr/bin/env python3

import functools

# loadProblem :: IO [[Int]]
def loadProblem():
  return [[int(n) for n in line.split(' ')] for line in open("euler-011.txt").readlines()]

# getHoriz :: Int -> Int -> [[a]] -> [a]
def getHoriz(row, col, xss):
    [a, b, c, d] = [xss[row][col + i] for i in range(4)]
    return [a, b, c, d]

# getVert :: Int -> Int -> [[a]] -> [a]
def getVert(row, col, xss):
    [a, b, c, d] = [xss[row + i][col] for i in range(4)]
    return [a, b, c, d]

# getSlash :: Int -> Int -> [[a]] -> [a]
def getSlash(row, col, xss):
    [a, b, c, d] = [xss[row + 3 - i][col + i] for i in range(4)]
    return [a, b, c, d]

# getBackslash :: Int -> Int -> [[a]] -> [a]
def getBackslash(row, col, xss):
    [a, b, c, d] = [xss[row + i][col + 3 - i] for i in range(4)]
    return [a, b, c, d]

# getFours :: Show a => [[a]] -> [[a]]
def getFours(xss):
    horizes = [getHoriz(row, col, xss) for row in range(20) for col in range(17)]
    verts = [getVert(row, col, xss) for row in range(17) for col in range(20)]
    slashes = [getSlash(row, col, xss) for row in range(17) for col in range(17)]
    backslashes = [getBackslash(row, col, xss) for row in range(17) for col in range(17)]
    fours = [n for l in [horizes, verts, slashes, backslashes] for n in l]
    return fours

# main :: IO ()
def main():
  nums = loadProblem()
  print(max((functools.reduce(lambda x, y: x*y, fours) for fours in getFours(nums))))

if __name__ == '__main__':
    main()
