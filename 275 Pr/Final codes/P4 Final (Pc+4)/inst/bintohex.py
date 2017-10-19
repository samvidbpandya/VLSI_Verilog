f = open('instructionP3.txt')
for line in f:
    P = hex(int(line,2))
    print P[2:]
    
