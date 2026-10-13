import base64
import json

with open(r"input.meow", "r") as f:
    data = f.read()

data = data.encode()
data = base64.b64decode(data)
data = json.loads(data)
data["mapData"][7][142] = []
data = json.dumps(data)
data = data.encode()
data = base64.b64encode(data)
data = data.decode()

with open(r"output.meow", "w") as f:
    f.write(data)
