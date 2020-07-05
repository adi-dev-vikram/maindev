def findPair(A, sum):

	# create an empty Hash Map
	dict = {}

	# do for each element
	for i, e in enumerate(A):

		# check if pair (e, sum-e) exists

		# if difference is seen before, print the pair
		if sum - e in dict:
			print("Pair found at index", dict.get(sum - e), "and", i)
			return

		# store index of current element in the dictionary
		dict[e] = i

	# No pair with given sum exists in the list
	print("Pair not found")


# Find pair with given sum in the list
if __name__ == '__main__':

	A = [8, 7, 2, 5, 3, 1]
	sum = 10

	findPair(A, sum)