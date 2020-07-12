class Solution(object):
    def moveZeroes(self, nums):
        count =0
        for i in range(len(nums)):
            if nums[i]!=0:
                nums[count],nums[i]=nums[i],nums[count]
                count+=1
