import codecs
i = 0;
with open('/Users/CASH/NetBeansProjects/timeWSR_CF/dataset/dataset1'
          '/wslistcopy.txt','r', errors='ignore') as f:
    with codecs.open(
            "/Users/CASH/NetBeansProjects/timeWSR_CF/dataset/dataset1/wslistcopy1.txt",
            "w", "utf-8-sig") as temp:

        for line in f:
            i += 1
            a =line.replace('"', '')
            print(a)
            temp.write(a)
