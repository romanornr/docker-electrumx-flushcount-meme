# This shell script is for ElectrumX docker containers using https://github.com/lukechilds/docker-electrumx
# This script is to solve the ElectrumX DB::flush_count overflow meme https://github.com/kyuupichan/electrumx/issues/185
# A flush_count would overflow after 455 days for Bitcoin. For altcoins with a faster blocktime it happens much quicker.
# This script is originally written for Viacoin with a blocktime of 24 seconds (25x faster than Bitcoin so the flush count needs to be done more often.

# Please use the right environment variables for your ElectrumX container 
# DAEMON_URL, COIN and -V

# original usage from https://github.com/lukechilds/docker-electrumx
#
#docker run \
#  -v /home/username/electrumx:/data \
#  -e DAEMON_URL=http://user:pass@host:port \
#  -e COIN=BitcoinSegwit \
#  -p 50002:50002 \
#  lukechilds/electrumx

# please note in this script -v is different:
# -v /root/electrumx:/data \
# You need to change this if you want it to work 
# This script is for now only tested on Viacoin with VialectrumX fork


#docker rm $(docker ps -a -f status=exited -q) #### remove all dead containers
CONTAINERID=$(docker ps -a -q)
echo $CONTAINERID

# Here we stop the container running electrumx
STOP=$(docker stop $(docker ps -a -q))
# Run that meme script 
FLUSH=$(docker run   -e DAEMON_URL=http://rpcuser:rpcpass@44.61.99.89:8332 -e COIN=BitcoinSegwit -e CACHE_MB=1600 -p 50002:50002 -v /root/electrumx:/data lukechilds/electrumx python electrumx_compact_history.py)
RESTART=$(docker run \
  -v /root/electrumx:/data \
  -e DAEMON_URL=http://rpcuser:viacoinpass@44.61.99.89:8332 \
  -e COIN=BitcoinSegwit \
  -e CACHE_MB=1600 \
  -p 50002:50002 \
  lukechilds/electrumx)
