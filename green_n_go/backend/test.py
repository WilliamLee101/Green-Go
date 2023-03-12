def max_compatible_subset(gas_stations):
    gas_stations.sort()
    max_subset = []
    for i in range(len(gas_stations)):
        subset = [gas_stations[i]]
        current = i
        for j in range(i + 1, len(gas_stations)):
            if gas_stations[j][0]+gas_stations[j][1]>821:
                if (gas_stations[j][0]+gas_stations[j][1]-821 < subset[0][0] and subset[0][0]-subset[0][1]+821 > gas_stations[j][0]) and gas_stations[j][0] - gas_stations[current][0] > gas_stations[current][1] and gas_stations[j][0] - gas_stations[current][0] > gas_stations[j][1]:
                    current = j
                    subset.append(gas_stations[j])
                    
            elif gas_stations[j][0] - gas_stations[current][0] > gas_stations[current][1] and gas_stations[j][0] - gas_stations[current][0] > gas_stations[j][1]:
                current = j
                subset.append(gas_stations[j])
                
        if len(subset) > len(max_subset):
            max_subset = subset
    return max_subset

print(len([(100, 40), (130, 15), (160, 35), (190, 25), (220, 50), (270, 30), (300, 20), (348.4, 53.2), (400, 40), (430, 15), (470, 25), (500, 30), (540, 20), (570, 35), (610, 25), (640, 50), (690, 30), (720, 20), (820, 25), (750, 40), (23, 20), (50, 30), (70, 25)]))
x = max_compatible_subset([(100, 40), (130, 15), (160, 35), (190, 25), (220, 50), (270, 30), (300, 20), (348.4, 53.2), (400, 40), (430, 15), (470, 25), (500, 30), (540, 20), (570, 35), (610, 25), (640, 50), (690, 30), (720, 20), (820, 25), (820, 25), (750, 40), (23, 20), (50, 30), (70, 25), (820, 2)])
print(x)
print(len(x))