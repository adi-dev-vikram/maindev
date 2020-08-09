
def compressor(s):
    lenStr=len(s)
    if lenStr == 0:
        return ""
    if lenStr==1:
        return s + "1"
    count=1
    last=s[0]
    r=""

    i=1

    while i < lenStr:
        if s[i]==s[i-1]:
            count +=1
        else:
            r = r + s[i-1] + str(count)
            count=1
        i+=1
    r = r + s[i-1] + str(count)
    return r


def main():

    #run leangth algo to compress string

    a = compressor('AAAAABBBBCC')
    print(a)
    print("Hello World!")

if __name__ == "__main__":
    main()