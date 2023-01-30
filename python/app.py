nums = [20, 13, 3, 3, 4, 5, 1, 2, 8, 7, 9, 0, 11]


def merge_sort(arr):
    if len(arr) < 2:
        return arr

    midIdx = len(arr) // 2
    l = arr[:midIdx]
    r = arr[midIdx:]
    return merge(merge_sort(l), merge_sort(r))


def merge(left, right):
    res = []
    l = r = 0
    while l < len(left) and r < len(right):
        if left[l] < right[r]:
            res.append(left[l])
            l += 1
        else:
            res.append(right[r])
            r += 1

    res.extend(left[l:])
    res.extend(right[r:])

    return res


print(merge_sort(nums))
