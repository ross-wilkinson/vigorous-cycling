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

