# Longest Word Game (Rails)

You get ten random letters; make the longest English word you can from them.

## Run locally

```bash
bundle install
bin/rails server     # http://localhost:3000
bin/rails test
```

## Word list

Words are checked against a local list, so the game works offline. The first of these that exists is used:

1. the file named in the `WORDS_FILE` environment variable
2. `db/words.txt` (git-ignored)
3. `/usr/share/dict/words` (present on macOS and most Linux systems)

On a machine without a system dictionary: `cp /path/to/any/words.txt db/words.txt`.
