# docker-electrumx-flushcount-meme
DB::flush_count overflow fix for ElectrumX servers running in a docker container


This shell script is for ElectrumX docker containers using https://github.com/lukechilds/docker-electrumx

This script is to solve the ElectrumX DB::flush_count overflow meme https://github.com/kyuupichan/electrumx/issues/185

A flush_count would overflow after 455 days for Bitcoin. For altcoins with a faster blocktime it happens much quicker.

This script is originally written for Viacoin with a blocktime of 24 seconds (25x faster than Bitcoin so the flush count needs to be done more often.

Please use the right environment variables for your ElectrumX container

DAEMON_URL, COIN and -V


original usage from https://github.com/lukechilds/docker-electrumx
```docker run \
  -v /home/username/electrumx:/data \
  -e DAEMON_URL=http://user:pass@host:port \
  -e COIN=BitcoinSegwit \
  -p 50002:50002 \
  lukechilds/electrumx
  ```

 please note in this script -v is different:
 ```
 -v /root/electrumx:/data \
 ```
 You need to change this if you want it to work 
 
 ### TODO
 - [x] flush
-  [ ] cronjob every x days to flush
-  [ ] make it easier to use

### manual cronjob example to flush every day

```sudo crontab -e```

add to the end of the file

```55 23 * * * /path/to/flushcount.sh```

```sudo /etc/init.d/cron start```

 
## This script is for now only tested on Viacoin with VialectrumX fork
Feel free to contribute, this would help others running ElectrumX within a docker container

License
-------

This tool is released under the terms of the MIT license. See [COPYING](COPYING) for more
information or see https://opensource.org/licenses/MIT.
