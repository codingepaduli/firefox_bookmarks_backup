#!/usr/bin/env python
#
# Decompression utility for files in Mozilla's "mozLz4" format. Firefox uses this file format to
# compress e. g. bookmark backups (*.jsonlz4).
# Note from internet: This file format is in fact just plain LZ4 data with a custom header (magic number [8 bytes] and  uncompressed file size [4 bytes, little endian]).
#
# Require: apt-get install python3-lz4
# This Python 3 script requires the LZ4 bindings for Python, see: https://pypi.python.org/pypi/lz4

import lz4.block
import sys

from argparse import ArgumentParser

def decompress(lz4File):
    """Decompress the current lz4 file"""
    if lz4File.read(8) != b"mozLz40\0":
        raise IOError("Invalid magic number")

    # if you want to compress, create funcion with 
    # return b"mozLz40\0" + lz4.block.compress(lz4File.read())
    return lz4.block.decompress(lz4File.read())


if __name__ == "__main__":
    argparser = ArgumentParser(prog='decompressMozLz4', allow_abbrev=False, description="decompression utility for Mozilla's mozLz4 format")
    argparser.add_argument(
            "-d",               # short parameter name
            "--decompress",     # long parameter name
            action="store_true",
            help="Option to decompress the input file."
        )
    argparser.add_argument(
            "in_file",
            type=str,
            help="Path to the input file in mozLz4 format to decompress."
        )
    argparser.add_argument(
            "out_file",
            type=str,
            help="Path to output file."
        )

    parsed_args = argparser.parse_args()

    try:
        with open(parsed_args.in_file, "rb") as in_file:
            with open(parsed_args.out_file, "wb") as out_file:
            
                try:
                    data = decompress(in_file)
                except Exception as e:
                    print("Fails to decompress file `%s': %s" % (parsed_args.in_file, e), file=sys.stderr)
                    sys.exit(2)
            
                out_file.write(data)
    
            # with keyword automatically closes the file
    except IOError as e:
        print("Could not open input file in reading mode or output file in writing mode: %s" % (e), file=sys.stderr)
        sys.exit(3)
