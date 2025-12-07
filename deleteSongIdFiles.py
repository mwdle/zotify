# Recursively searches for and deletes all Zotify .song_ids files in the provided directory.

import os
import argparse

parser = argparse.ArgumentParser()

if __name__ == "__main__":
    parser.add_argument('dir', type=str, help="directory to look in")
    args = parser.parse_args()
    for root, _, files in os.walk(args.dir):
        for file in files:
            if file == ".song_ids":
                os.remove(os.path.join(root, file))
