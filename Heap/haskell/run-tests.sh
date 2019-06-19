#!/bin/bash

if [ "$1" == "install" ];
then
	apt-get install cabal-install
	cabal update
	cabal install random
	cabal install QuickCheck
fi
rm -rf .hpc/
rm *.hi *.html *.tix TestHeap

ghc -fhpc TestHeap.hs --make
./TestHeap > test.log 2>&1
hpc markup TestHeap --exclude=Main --exclude=QC
