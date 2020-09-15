# BabyNamesByState
This is a small rework of my Perl final project

## Table of Contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Usage](#usage)

## General info
BabyNamesFromState is a script that processes a version of the 'Baby Names from Social Security Card Applications' dataset from the Social Security Administration. This dataset contains state records from the year 1910 to 2014. This script takes in a name/gender and a year, then displays each record that matches, and eventually displays the states with the least and most instances of that name/gender.

## Technologies
Script created using:
* Perl version: 5.32

## Setup
### a. Install Perl 5.32:
Please use the appropriate guide for your environment of choice:
* https://www.perl.org/get.html

### b. Get Dataset:
This file is currently on my Drive since the SSA updated their dataset format.
* [StateNames.csv](https://drive.google.com/file/d/1Hge1EyyQhw1HQ5rB_I7fqz5_9dBmuNzD/view?usp=sharing)

### c. Move Dataset:
Move StateNames.csv to the same directory as BabyNamesByState.pl.

## Usage
Run the script as you would any other Perl script:
```
$ cd ../BabyNamesByState
$ perl BabyNamesByState.pl
```

Running the script looking for "Andrew" from every year:

```
$ cd ../BabyNamesByState
$ perl BabyNamesByState.pl "Andrew" "all"
```

Running the script looking for all males in 1996:
```
$ cd ../BabyNamesByState
$ perl BabyNamesByState.pl "M" "1996"
```
