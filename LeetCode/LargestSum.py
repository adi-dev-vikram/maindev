arr1 = [1,2,4,-6,7,-6,10,-11, 20]

if len(arr1)==0:
    print('0')

max_sum=curr_sum=arr1[0]

for num in arr1[1:]:
    curr_sum=max(curr_sum+num, num)
    max_sum=max(curr_sum,max_sum)
print(max_sum)