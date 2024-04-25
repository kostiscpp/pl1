def json_numbers(J):
    if type(J) == int: return J
    if type(J) == str: return None
    ints = []
    for x in J:
        temp1 = json_numbers(x)
        temp2 = None
        if type(J) == dict:
            temp2 = json_numbers(J[x])
        if type(temp1) == int:
            ints.append(temp1)
        elif type(temp1) == list:
            ints += temp1
        if type(temp2) == int:
            ints.append(temp2)
        elif type(temp2) == list:
            ints += temp2
    if ints == []: return None
    return ints

JS = { "firstName" : "Maria", "lastName" : "Magdalena", "age" : 27, "phoneNumbers": [{"type" : "office", "number": 21023902},{"type": "mobile", "number" : 69489584}], "notes" : [{"what": 42 }, [17, "hello"], "world", [] , {}]}


print(json_numbers(JS))
