%% Process vigorous cycling pilot data
% Calculate exact finishing times and create plots of time series data

%% Initialize 
clear; clc; close all

%% Set directories
expDir = '/Users/rosswilkinson/Google Drive/projects/vigorous-cycling/';
datDir = [expDir '/data'];
codDir = [expDir '/matlab'];
docDir = [expDir '/docs'];
resDir = [expDir '/results'];

%% Load data
cd(datDir)

<<<<<<< HEAD:matlab/vigorAnalysis_pilot05.m
t_ba = readtable('2021_07_02_13_25_46.csv');
t_n1 = readtable('2021_07_02_13_32_56.csv');
t_n2 = readtable('2021_07_02_13_39_25.csv');
t_r1 = readtable('2021_07_02_13_46_15.csv');
t_n3 = readtable('2021_07_02_13_54_04.csv');
t_n4 = readtable('2021_07_02_14_01_26.csv');
t_r2 = readtable('2021_07_02_14_08_10.csv');
t_tt = readtable('2021_07_02_14_14_54.csv');
