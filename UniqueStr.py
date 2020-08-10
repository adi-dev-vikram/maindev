def is_unique(str1):

    if len(str1)==0:
        return False
    if len(str1)==1:
        return True

    char_dict ={}

    for s in str1:
        if s not in char_dict:
            char_dict[s]=1
        else:
            char_dict[s]+=1
    for k,v in char_dict.items():
        if char_dict[k] > 1:
            return False
        else:
            return True


def main():
    a = is_unique("aaaabcde")
    print(a)

if __name__ == "__main__":
    main()