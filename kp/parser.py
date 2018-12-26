f1 = open("family.ged", "r")
f2 = open("answer.txt", "w")

base = {}

for line in f1.readlines():
    words = line.split(" ")
    if len(words) >= 3:
        s1 = words[1]
        s2 = words[2]
        if s2[0] == "I":
            key = words[1]
        if s1 == "GIVN":
            name = words[2]
        if s1 == "SURN":
            surn = words[2]
            value = (name[:-1], surn[:-1])
            newElem = {key:value}
            base.update(newElem)
        if s1 == "SEX":
            if s2[:-1] == "F":
                s = "female(\'%s\').\n" % (name[:-1] + " " + surn[:-1])
                f2.write(s)
            if s2[:-1] == "M":
                s = "male(\'%s\').\n" % (name[:-1] + " " + surn[:-1])
                f2.write(s)
        if s1 == "HUSB":
            husb = words[2]
            for k, (a, b) in base.items():
                if k == husb[:-1]:
                    father = a + " " + b
        if s1 == "WIFE":
            wife = words[2]
            for k, (a, b) in base.items():
                if k == wife[:-1]:
                    mother = a + " " + b
        if s1 == "CHIL":
            chil = words[2]
            for k, (a, b) in base.items():
                if k == chil[:-1]:
                    child = a + " " + b
            s = "child('%s', '%s').\n" % (child, father)
            f2.write(s)
            s = "child('%s', '%s').\n" % (child, mother)
            f2.write(s) 
f2.close()
f1.close()