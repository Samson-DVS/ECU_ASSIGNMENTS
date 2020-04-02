import time
import datetime
import hashlib
from hashlib import sha256

def timestamp():
    now = datetime.datetime.now()
    timestring = str(now)
    return timestring

def emptyblock():
    fileblock = open(blockchain, mode="a+")
    isFirst = True
    begin = "-----BEGIN HASH-----"
    fileblock.seek(0)
    firstline = fileblock.readline()
    if firstline.strip() == begin.strip():
        isFirst = False
    if isFirst is True:
        isFirst is False
        print("\nNo previous block identified. Starting first block.\n")
        time = timestamp()
        index = 0
        data = "first block"
        previous = "[none]"
        nonce = "[none]"
        dataBytes = data.encode()
        hash = hashlib.sha256(dataBytes)
        digest = hash.hexdigest()
        blockwrite(digest, index, time, data, previous, nonce)

def Hashledger():
    Lfile = open(ledger, mode="a+")
    Lfile.seek(0)
    hash = hashlib.sha256()
    bufferSize = 65536
    while True:
        chunk = Lfile.read(bufferSize)
        if not chunk:
            break
        hash.update(chunk.encode())
    Lfile.close()
    return hash

def indexblock():
    blockfile = open(blockchain, mode="a+")
    blockfile.seek(0)
    lines = list(blockfile)
    lines = reversed(lines)
    lines = (line.strip() for line in lines)
    lines = (line for line in lines if line)
    counter = 0
    for line in lines:
        counter += 1
        if counter == 6:
            lastIndex = int(line[8:])
            return lastIndex + 1
            break
    blockfile.close()

def blockwrite(hash, index, time, data, previous, nonce):
    header = "-----BEGIN HASH-----"
    hashFormat = "HASH  = " + str(hash)
    midder = "-----BEGIN BLOCK-----"
    indexFormat = "INDEX = " + str(index)
    timeFormat = "TIME  = " + time
    dataFormat = "DATA  = " + data
    previousFormat = "PREV  = " + previous
    nonceFormat = "NONCE = " + str(nonce)
    footer = "-----END BLOCK------"
    fileblock = open(blockchain, mode="a+")
    fileblock.write(header+"\n")
    fileblock.write(hashFormat+"\n")
    fileblock.write(midder+"\n")
    fileblock.write(indexFormat+"\n")
    fileblock.write(timeFormat+"\n")
    fileblock.write(dataFormat+"\n")
    fileblock.write(previousFormat+"\n")
    fileblock.write(nonceFormat+"\n")
    fileblock.write(footer+"\n\n")
    fileblock.close()
    # Print the new block to the terminal
    print(header)
    print(hashFormat)
    print(midder)
    print(indexFormat)
    print(timeFormat)
    print(dataFormat)
    print(previousFormat)
    print(nonceFormat)
    print(footer+"\n")

def prevhashblock():
    blockfile = open(blockchain, mode="a+")
    blockfile.seek(0)
    lines = list(blockfile)
    lines = reversed(lines)
    lines = (line.strip() for line in lines)
    lines = (line for line in lines if line)
    lines = list(lines)
    lines = lines[:7]
    lines = reversed(lines)
    lines = list(lines)
    lines = lines[1:6]
    counter = 0
    for line in lines:
        lines[counter] = line.strip()
        lines[counter] = line[8:]
        counter += 1
    hash = hashlib.sha256()
    for line in lines:
        hash.update(line.encode())
    blockfile.close()
    return hash


def blocknew():
    nonce = 0
    index = indexblock()
    time = timestamp()
    data = newdata()
    prevHash = prevhashblock()
    prevHashString = prevHash.hexdigest()
    indexString = str(index)
    indexBytes = indexString.encode()
    timeBytes = time.encode()
    dataBytes = data.encode()
    hashBytes = prevHashString.encode()
    block = indexBytes + timeBytes + dataBytes + hashBytes
    while True:
        newhash = None
        newhash = hashlib.sha256()
        newhash.update(block)
        nonceString = str(nonce)
        nonceBytes = nonceString.encode()
        newhash.update(nonceBytes)
        digest = newhash.hexdigest()
        hashdig = digest[0:14]
        zeros = "00000000000000"
        if (hashdig == zeros):
            blockwrite(digest, index, time, data, prevHashString, nonce)
            break
        if (nonce >= 50000):
            blockwrite(digest, index, time, data, prevHashString, nonce)
            break
        nonce += 1

def newdata():
    Lfile = open(ledger, mode="a+")
    Lfile.seek(0)
    lines = list(Lfile)
    lines = reversed(lines)
    lines = (line.strip() for line in lines)
    lines = (line for line in lines if line)
    for line in lines:
        newTransaction = line
        break
    return newTransaction

try:
    print("Press CTRL+C to quit any time.")
    blockchain = "blockchain.txt"
    ledger = "ledger.txt"
    lastLedger = Hashledger()
    while True:
        emptyblock()
        currentLedger = Hashledger()
        if (currentLedger.hexdigest() != lastLedger.hexdigest()):
            blocknew()
        lastLedger = currentLedger
        time.sleep(1)
except KeyboardInterrupt:
    quit()
