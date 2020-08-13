.phony: all

all: litebird-scanning-strategy.mp4

litebird-scanning-strategy000.png: litebird-scanning-strategy.pov litebird-scanning-strategy.ini
	rm -rf litebird-scanning-strategy*.png
	povray litebird-scanning-strategy.ini

litebird-scanning-strategy.mp4: litebird-scanning-strategy000.png
	ffmpeg -framerate 25 -i 'litebird-scanning-strategy%03d.png' -y $@
