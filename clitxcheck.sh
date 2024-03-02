TX=$1
sudo ./bitcoin-cli getrawmempool | grep "$TX" > /dev/null
if [ $? -eq 0 ]; then
  echo "$TX found in mempool."
else
  echo "$TX not found in mempool."
  echo "Getting raw transaction..."
  HEX=$(sudo ./bitcoin-cli getrawtransaction "$TX" | tr -cd '[:xdigit:]')
  echo "Sending raw transaction..."
  sudo ./bitcoin-cli sendrawtransaction "$HEX"
  if [ $? -eq 0 ]; then
    echo "Done."
  else
    echo "Something is wrong, check your TX."
  fi
fi
