# Download playlists using zotify

```bash
docker build -t zotify .

# Run this command from root of zotify project folder!
docker run --rm --name zotify -p 4381:4381 -v "$PWD/Zotify Music:/root/Music/Zotify Music" -it zotify python3 -m zotify --output="{playlist}/{artist}/{album}/{artist} - {song_name}" --download-quality=very_high --download-format=copy --md-allgenres=True --retry-attempts=2 --download-lyrics=False --download-real-time=True --print-downloads=True --print-errors=True --print-warnings=True --print-skips=True --skip-existing=True --bulk-wait-time=5 -e True --m3u8-location="/root/Music/Zotify Music" --realtime-speed-factor=10 -p
```
