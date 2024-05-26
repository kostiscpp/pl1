#include <iostream>
#include <vector>
#include <cmath>
#include <fstream>
long long closestSumToHalf(const std::vector<long long>& array) {
    long long totalSum = 0;
    for (long long num : array) {
        totalSum += num;
    }
    long long bestDiff = totalSum;
    for (long long i = 0; i < array.size(); ++i) {
        long long currentSum = 0;
        for (long long j = i; j < array.size(); ++j) {
            currentSum += array[j];
            if (std::abs(2*currentSum - totalSum) < bestDiff) {
				bestDiff = std::abs(2*currentSum - totalSum);
//				std::cout << i << ", " << j << " sum " << bestDiff << std::endl;
            }
        }
    }

    return bestDiff;
}

int main(int argv, char *argc[]) {
    long long N;
	std::ifstream file(argc[1]);
	file >> N;
	std::vector<long long> array(N);
	for(long long i = 0; i < N; ++i) {
		file >> array[i];
	}
	file.close();
	long long result = closestSumToHalf(array);
    std::cout << result << std::endl;
    return 0;
}
