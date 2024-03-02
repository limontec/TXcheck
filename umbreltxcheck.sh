TX=$1
sudo ~/umbrel/scripts/app compose bitcoin exec bitcoind bitcoin-cli getrawmempool | grep "$TX" > /dev/null
if [ $? -eq 0 ]; then
  echo "$TX found in mempool."
else
  echo "$TX not found in mempool."
  echo "Getting raw transaction..."
  HEX=$(sudo ~/umbrel/scripts/app compose bitcoin exec bitcoind bitcoin-cli getrawtransaction "$TX" | tr -cd '[:xdigit:]')
  echo "Sending raw transaction..."
  sudo ~/umbrel/scripts/app compose bitcoin exec bitcoind bitcoin-cli sendrawtransaction "$HEX"
  if [ $? -eq 0 ]; then
    echo "Done."
  else
    echo "Something is wrong, check your TX."
  fi
fi
