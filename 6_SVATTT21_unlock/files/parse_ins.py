# from tqdm import tqdm

instructions = [
    [0x00, 0, "NOP"],
    [0x10, 2, "MOV R{}, R{}"],
    [0x11, 2, "MOV R{}, {}"],
    [0x12, 3, "MOV R{}, BYTE PTR [R{} + R{}]"],
    [0x13, 3, "MOV R{}, DWORD PTR [R{} + R{}]"],
    [0x20, 2, "XOR R{}, R{} ; =0 -> flags=1; #0 -> flags=0"],
    [0x30, 2, "SUB R{}, R{} ; =0 -> flags=1; #0 -> flags=0"],
    [0x40, 2, "ADD R{}, R{}"],
    [0x50, 1, "MOV [--ADDR], R{}"],
    [0x51, 2, "MOV R{}, [ADD++]"],
    [0x52, 2, "MOV R{}, [ADDR+{}]"],
    [0x60, 1, "JMP {}"],
    [0x61, 1, "JZ {}"],
    [0x62, 1, "JMP R{}"],
    [0x63, 1, "JNZ {}"],
    [0x67, 1, "PUSH R{}"],
    [0x68, 1, "POP R{}"],
    [0x70, 2, "CMP R{}, R{} ; equals=1, larger=0, lessthan=2"],
    [0x80, 2, "AND R{}, R{}"],
    [0x81, 2, "SHL R{}, R{}"],
    [0x82, 2, "SHR R{}, R{}"],
    [0xCA, 1, "CALL R{}"],
    [0xCB, 1, "MOV R{}, EAX"]
]

def main():
    with open("vm_opcode.bin", "rb") as vm:
        opcodes = vm.read()
        vm.close()
    
    s = ""
    pc = 0
    idx = 0
    value = [[] for _ in range(18)]
    bitmath = [[] for _ in range(18)]
    pre_text = ""
    while pc < 0x4202:
        k = 0
        for j in range(len(instructions)):
            if instructions[j][0] == int(opcodes[pc]):
                if instructions[j][0]==0x61 or instructions[j][0]==0x63 or instructions[j][0]==0x60:
                    text = hex(pc) + ":\t" + instructions[j][2].format(hex(int(opcodes[pc+1]) + pc + 1 +1) ) + "\n"
                    pc += 2
                    k = 1 
                    break
                elif instructions[j][1]==0:
                    text = hex(pc) + ":\t" + instructions[j][2] + "\n"
                    pc += 1
                    k = 1
                    break
                elif instructions[j][1]==1:
                    text = hex(pc) + ":\t" + instructions[j][2].format(int(opcodes[pc+1])) + "\n"
                    pc += 2
                    k = 1 
                    break
                elif instructions[j][1]==2:
                    text = hex(pc) + ":\t" + instructions[j][2].format(int(opcodes[pc+1]), int(opcodes[pc+2])) + "\n"
                    pc += 3
                    k = 1 
                    break
                elif instructions[j][1]==3:
                    text= hex(pc) + ":\t" + instructions[j][2].format(int(opcodes[pc+1]), int(opcodes[pc+2]),int(opcodes[pc+3])) + "\n"
                    pc += 4
                    k = 1 
                    break
        s += text
        if "MOV R3," in text:
            value[idx].append(int(opcodes[pc-1]))
        if "MOV R3," in pre_text and "SUB" in text:
            bitmath[idx].append("SUB")
        elif "MOV R3," in pre_text and "ADD" in text:
            bitmath[idx].append("ADD")
        elif "MOV R3," in pre_text and "XOR" in text:
            bitmath[idx].append("XOR")
        elif "MOV R3," in pre_text and "AND" in text:
            bitmath[idx].append("AND")

        if "CMP R1, R5" in text and "MOV R5," in pre_text:
            value[idx].append(int(opcodes[pc-1-3]))
            idx += 1
        
        if k==0:
            print (hex(int(opcodes[pc])) + " -- " + hex(pc))
            return 0
        pre_text = text
        # print (hex(pc))
    with open("unlock.asm", "w") as ul:
        ul.write(s)
        ul.close()
    print (value)
    print (bitmath)
    print ("Done")
    

if __name__=="__main__":
    main()