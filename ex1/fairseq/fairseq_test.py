import random
import subprocess

def generate_random_array():
    total_sum = 0
    length = 0
    array = []
    while total_sum < 1000000000 and length <= 1000000:
        num = random.randint(1, 100)
        if total_sum + num <= 1000000000:
            array.append(num)
            total_sum += num
            length += 1
#            print(total_sum/10000000,"% " )
#            print(length)
    return array

def write_array_to_file(array, filename):
    with open(filename, 'w') as f:
        f.write(str(len(array)))
        f.write("\n")
        first = 1
        for num in array:
            if first == 0:
                first = 1
            else:
                f.write(" ")
            f.write(str(num))

def closest_sum_to_half(array):
    total_sum = sum(array)
    half_sum = total_sum / 2
    closest_sum = float('inf')

    for i in range(len(array)):
        current_sum = 0
        for j in range(i, len(array)):
            current_sum += array[j]
            if abs(current_sum - half_sum) < abs(closest_sum - half_sum):
                closest_sum = current_sum
            print(i,j)

    return abs(total_sum - 2*closest_sum)

def execute_executables(executable1, executable2, filename):
    output_file1 = "output_executable1.txt"
    output_file2 = "output_executable2.txt"

    with open(output_file1, 'w') as f1:
        subprocess.run([executable1, filename], stdout=f1)

    with open(output_file2, 'w') as f2:
        subprocess.run([executable2, filename], stdout=f2)

    return output_file1, output_file2

if __name__ == "__main__":
    # Generate random array
    random_array = generate_random_array()
    filename = "random_array.txt"
    python_res = -1 #closest_sum_to_half(random_array)
    print(python_res)
    
    # Write array to file
    write_array_to_file(random_array, filename)
    
    # Execute executables and store their outputs
    executable1 = "./test"
    executable2 = "./val"
    output_file1, output_file2 = execute_executables(executable1, executable2, filename)
    
    # Compare outputs
    with open(output_file1, 'r') as f1, open(output_file2, 'r') as f2:
        output1 = f1.read().strip()
        output2 = f2.read().strip()

    if output1 == output2:
        print("Outputs are the same")
    else:
        print("Outputs are different")

    # Convert outputs to integers
    result1 = int(output1)
    result2 = int(output2)

    
    # Check if the results are correct using the function
    if python_res != result1:
        print("Result 1 is incorrect according to the function")
    if python_res != result2:
        print("Result 2 is incorrect according to the function")
