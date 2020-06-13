import argparse
import sys
print(sys.argv)
parser = argparse.ArgumentParser()
parser.add_argument("-n", action="store", dest="num", type=int)

#parser.add_argument("-h", action="store", dest="val", type=int)

results = parser.parse_args()
print(results.num)
