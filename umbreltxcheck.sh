TX=$1
sudo ~/umbrel/scripts/app compose bitcoin exec bitcoind bitcoin-cli getrawmempool | grep "$TX" > /dev/null
if [ $? -eq 0 ]; then
  echo "$TX found in mempool."
else
  echo "$TX not found in mempool."
  echo "Getting raw transaction..." #You will need the hex from others nodes
  HEX=$(curl -sSL "https://mempool.space/api/tx/$TX/hex" | tr -cd '[:xdigit:]') #You also can use blockstream.info
  sudo ~/umbrel/scripts/app compose bitcoin exec bitcoind bitcoin-cli sendrawtransaction "$HEX"
  if [ $? -eq 0 ]; then
    echo "Transaction sent."
  fi
fi
