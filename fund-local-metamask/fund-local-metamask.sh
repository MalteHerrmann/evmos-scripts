# Convert Testnet MetaMask Hex Address 
HEXADDR=0x43C13f8f62616390909F831f066a9AB103F2c864 && \
BECH32ADDR=$(evmosd debug addr $HEXADDR | grep "Bech32 Acc" | cut -c 13-56) && \
echo "Funding $BECH32ADDR..."

# Send funds from dev0 account to MetaMask
evmosd tx bank send dev0 $BECH32ADDR 100000000000000000000aevmos \
--home $HOME/.tmp-evmosd \
--from dev0 \
--fees 200000000000000aevmos \
--gas auto \
-b block \
-y

