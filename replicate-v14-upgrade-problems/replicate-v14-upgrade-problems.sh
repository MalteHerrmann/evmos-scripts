#!/usr/bin/env bash

# Exit on first error
set -e

DEV0=$(evmosd keys show -a dev0 --home $HOME/.tmp-evmosd)
DEV1=$(evmosd keys show -a dev1 --home $HOME/.tmp-evmosd)
DEV2=$(evmosd keys show -a dev2 --home $HOME/.tmp-evmosd)
DEV3=$(evmosd keys show -a dev3 --home $HOME/.tmp-evmosd)
VALADDR=$(evmosd q staking validators --node http://localhost:26657 | grep operator_address | cut -c 21-71)

# Store the exemplary vesting schedule in a file
echo '{"start_time":1689804000,"periods":[{"coins":"100000000000000000aevmos","length_seconds":272160000}]}' > vesting_schedule.json

# Create vesting accounts for three addresses:
# - evmos1pxjncpsu2rd3hjxgswkqaenrpu3v5yxurzm7jp from dev0
# - evmos12aqyq9d4k7a8hzh5av2xgxp0njan48498dvj2s from dev1
# - evmos1rtj2r4eaz0v68mxjt5jleynm85yjfu2uxm7pxx from dev1
evmosd tx vesting create-clawback-vesting-account evmos1pxjncpsu2rd3hjxgswkqaenrpu3v5yxurzm7jp \
--vesting vesting_schedule.json \
--from dev1 \
--fees 5000000000000000aevmos \
--gas-adjustment 2.0 \
--home $HOME/.tmp-evmosd \
-b block \
-y

evmosd tx vesting create-clawback-vesting-account evmos12aqyq9d4k7a8hzh5av2xgxp0njan48498dvj2s \
--vesting vesting_schedule.json \
--from dev0 \
--fees 5000000000000000aevmos \
--gas-adjustment 2.0 \
--home $HOME/.tmp-evmosd \
-b block \
-y

evmosd tx vesting create-clawback-vesting-account evmos1rtj2r4eaz0v68mxjt5jleynm85yjfu2uxm7pxx \
--vesting vesting_schedule.json \
--from dev0 \
--fees 5000000000000000aevmos \
--gas-adjustment 1.5 \
--home $HOME/.tmp-evmosd \
-b block \
-y

# Set up a delegation for old strategic reserve (=dev2 in this example)
evmosd tx staking delegate $VALADDR 12345aevmos \
--from dev2 \
--home $HOME/.tmp-evmosd \
--gas auto \
--fees 100000000000000aevmos \
--gas-adjustment 1.5 \
-b block \
-y

