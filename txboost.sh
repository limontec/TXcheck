TX=$1
echo "Getting raw transaction..."
HEX=$(curl -sSL "https://mempool.space/api/tx/$TX/hex" | tr -cd '[:xdigit:]')
echo "Broadcasting via mempool.space node..."
curl -X POST -sSLd "$HEX" -w "\n" "https://mempool.space/api/tx"
echo "Broadcasting  via blockstream.info node..."
curl -X POST -sSLd "$HEX" -w "\n" "https://blockstream.info/api/tx"
echo "Broadcasting via blockchain.info node..."
curl -X POST -sSLd "tx=$HEX" -w "\n" "https://blockchain.info/pushtx"
echo "Broadcasting via viabtc.com node..."
curl -X POST -H 'Content-Type: application/json' -sSLd "{\"coin\":\"BTC\",\"raw_tx\":\"$HEX\"}" -w "\n" "https://www.viabtc.com/res/tools/broadcast"
