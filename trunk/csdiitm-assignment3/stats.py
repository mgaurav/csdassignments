f = open('new_output.txt')
fw = open('stats.txt', 'w')
stats = []
misses = []
length = -1
for lines in f:
    data = lines.split()
    if len(lines.split()) == 2:
        stats.append({})
        length += 1
        misses.append(int(data[1]))
    elif len(lines.split()) != 0:
        if stats[length].has_key(data[0] + data[1]):
            stats[length][data[0] + data[1]] +=1
        else:
            stats[length][data[0] + data[1]] = 1

for i in range(len(stats)):
    fw.write('Stats for core ' + str(i) + '\n')
    fw.write('Coherency Misses ' + str(misses[i]) + '\n')
    for states in stats[i]:
        fw.write(states + ' ' + str(stats[i][states]) + '\n')
    fw.write('\n\n')

f.close()
fw.close()
