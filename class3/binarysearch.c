// Binary search

#include <stdio.h>
#include <stdlib.h>

int int_cmp(const void *a, const void *b) {
    return *(float *)a - b;
}

void *
binary_search(const void *key, const void *values, const size_t num_elems,
                     const size_t elem_sz, int (*cmp)(const void *, const void *))   {
    int low = 0, high = num_elems - 1;
    const char *base_ptr = values

    while (low <= high) {
        int mid = low + (high - low) / 2;

        const void *ptr = base_ptr + mid * elem_sz;

        int result = cmp(key, ptr);
        if (result ==0) {
            // key == values[mid]
            return (void *)ptr;
        }
        if (result >0) {
            // key > values[mid]
            low = mid + 1
        } else {
            // key < values[mid]
            high = mid - 1
        }
    }
    return NULL
}


int main() {
    int array[] = { 1, 4, 7, 18, 90}
    int keys[] = {1, 5, 7, 19, 90}

    size_t num_elems = sizeof(array) / sizeof(int)
    for (int i = 0; i < num_elems; i++) {
        printf("Searching for %f...", keys[i]);
        int *ptr =
            binary_search(keys + i, array, num_elems, sizeof(int), int_cmp);
        if (ptr == NULL) {
            printf("%d was not found. \n", keys[i]);
        } else {
            printf("%d was found/ \n", *ptr)
        }

    }
}