import socket
import sys

def talk(shore_id, action, name):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((f"sponda_{shore_id.lower()}", 9999))
        s.send(f"{action} {name}".encode())
        resp = s.recv(1024).decode()
        s.close()
        return resp
    except: return "ERR"

def reset():
    talk("a", "CLEANUP", "ALL")
    talk("b", "CLEANUP", "ALL")

print("\n=== PUZZLE AGGIORNATO: VIAGGIO DI COPPIA ===")
print("Scrivi il passeggero e la sponda (es: 'Capra B'). L'Uomo viaggerà con lui!")

state = {"Lupo": "A", "Capra": "A", "Cavolo": "A", "Uomo": "A"}
reset()
for char in state: talk("a", "ADD", char)

while True:
    cmd = input("\nCosa vuoi spostare in barca? > ").strip().split()
    if not cmd: continue

    char = cmd[0].capitalize()
    target = cmd[1].upper() if len(cmd) > 1 else ("B" if state["Uomo"] == "A" else "A")

    if char not in state or target not in ["A", "B"]:
        print("Mossa non valida.")
        continue

    origin = state["Uomo"]

    if state[char] != origin:
        print(f"Errore: {char} non è sulla sponda {origin} con l'Uomo!")
        continue

    talk(origin, "REMOVE", "Uomo")
    if char != "Uomo":
        talk(origin, "REMOVE", char)

    res_orig = talk(origin, "CHECK", "STATUS")

    talk(target, "ADD", "Uomo")
    res_dest = "OK"
    if char != "Uomo":
        res_dest = talk(target, "ADD", char)

    state["Uomo"] = target
    state[char] = target

    if "GAMEOVER" in res_orig or "GAMEOVER" in res_dest:
        msg = res_orig if "GAMEOVER" in res_orig else res_dest
        print(f"\n {msg.split(':')[1]}")
        reset()
        sys.exit()

    print(f" Viaggio completato. Posizioni: {state}")

    if all(pos == "B" for pos in state.values()):
        print("\n VITTORIA! Tutti portati in salvo sulla sponda B!")
        sys.exit()