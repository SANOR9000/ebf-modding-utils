import base64
import json


def open_save():
    with open(r"input.meow", "r") as f:
        data = f.read()

    data = data.encode()
    data = base64.b64decode(data)
    data = json.loads(data)
    return data


# lmao
def save_save(data):
    data = json.dumps(data)
    data = data.encode()
    data = base64.b64encode(data)
    data = data.decode()

    with open(r"output.meow", "w") as f:
        f.write(data)

data = open_save()

data["equipOwnage"][228] = True        # coincharm
data["equipOwnage"][227] = True        # luckyfish
data["equipOwnage"][204] = True        # loveblade
data["equipOwnage"][36] = True         # heartpendant
data["equipOwnage"][141] = True        # heavensvoice
data["equipOwnage"][183] = True        # slimestaff
data["equipOwnage"][98] = True         # coatofteeth
data["equipOwnage"][119] = True        # spidergown
data["equipOwnage"][56] = True         # pumpkinhead
data["equipOwnage"][77] = True         # spiderbobble
data["equipOwnage"][99] = True         # santaoutfit
data["equipOwnage"][120] = True        # santaskirt
data["equipOwnage"][57] = True         # santahat
data["equipOwnage"][78] = True         # hollyhairpin
data["spellOwnage"][179] = True        # firecrackers
data["itemQuantities"][125] = 69000    # Red Envelope
data["npcFlags"][148] = [False, True]  # sally quest
data["npcFlags"][146] = [False, True]  # bunni quest
data["npcFlags"][145] = [False, True]  # jack quest
data["npcFlags"][147] = [False, True]  # amy quest
data["npcFlags"][259] = [False, True]  # lunar quest

save_save(data)
