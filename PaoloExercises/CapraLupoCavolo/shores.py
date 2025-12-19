import multiprocessing
import os
import signal
import socket
import time
import threading

active_characters = {}

def character_process(name):
    try:
        while True: time.sleep(1)
    except: pass

def kill_and_eat(victim):
    if victim in active_characters:
        pid = active_characters[victim].pid
        print(f" MANGIATO: {victim} (PID {pid}) è stato killato!")
        os.kill(pid, signal.SIGKILL)
        del active_characters[victim]
        return True
    return False

def watchdog_logic():
    """Controlla COSTANTEMENTE i processi per mangiare chi è rimasto solo"""
    while True:
        presenti = list(active_characters.keys())
        if "Uomo" not in presenti:
            if "Lupo" in presenti and "Capra" in presenti:
                if kill_and_eat("Capra"):
                    print("ALERT: Lupo e Capra erano soli!")
            elif "Capra" in presenti and "Cavolo" in presenti:
                if kill_and_eat("Cavolo"):
                    print("ALERT: Capra e Cavolo erano soli!")
        time.sleep(0.1)

def listen():
    # Avvia il thread di controllo continuo
    t = threading.Thread(target=watchdog_logic, daemon=True)
    t.start()

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind(('0.0.0.0', 9999))
    s.listen(5)
    
    while True:
        conn, _ = s.accept()
        data = conn.recv(1024).decode().strip().split()
        if not data: continue
        
        action, name = data[0], data[1]
        
        if action == "ADD":
            p = multiprocessing.Process(target=character_process, args=(name,))
            p.start()
            active_characters[name] = p
        elif action == "REMOVE" and name in active_characters:
            active_characters[name].terminate()
            active_characters[name].join() # Aspetta che il processo muoia davvero
            del active_characters[name]
        elif action == "STATUS":
            pass # Il watchdog si occupa già di tutto
        elif action == "CLEANUP":
            for n in list(active_characters.keys()):
                active_characters[n].terminate()
            active_characters.clear()

        # Rispondi con lo stato aggiornato (il watchdog potrebbe aver già killato qualcuno)
        presenti_reali = list(active_characters.keys())
        if (action != "CLEANUP" and "Uomo" not in presenti_reali and 
            (("Lupo" in presenti_reali and "Capra" in presenti_reali) or 
             ("Capra" in presenti_reali and "Cavolo" in presenti_reali))):
            conn.send(b"GAMEOVER:Qualcuno e' stato mangiato!")
        else:
            conn.send(f"OK:{presenti_reali}".encode())
        conn.close()

if __name__ == "__main__":
    listen()