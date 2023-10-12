#!/usr/bin/env bash

# Exit on first error
set -e

DEV1=$(evmosd keys show -a dev1 --home $HOME/.tmp-evmosd)
VALADDR=$(evmosd q staking validators --node http://localhost:26657 | grep operator_address | cut -c 21-71)

# Set up a delegation for old strategic reserve (=dev1 in this example)
evmosd tx staking delegate $VALADDR 12345aevmos \
--from dev1 \
--home $HOME/.tmp-evmosd \
--fees 500000000000000aevmos \
--gas auto \
--gas-adjustment 2.0 \
-b sync \
-y

