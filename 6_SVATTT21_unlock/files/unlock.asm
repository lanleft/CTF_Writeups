0x0:	POP R1
0x2:	MOV [--ADDR], R1
0x4:	POP R1
0x6:	MOV [--ADDR], R1
0x8:	POP R1
0xa:	MOV [--ADDR], R1
0xc:	POP R1
0xe:	MOV [--ADDR], R1
0x10:	POP R1
0x12:	MOV [--ADDR], R1
0x14:	POP R1
0x16:	MOV [--ADDR], R1
0x18:	MOV R4, [ADDR+1]
0x1b:	XOR R1, R1 ; =0 -> flags=1; #0 -> flags=0
0x1e:	XOR R2, R2 ; =0 -> flags=1; #0 -> flags=0
0x21:	XOR R3, R3 ; =0 -> flags=1; #0 -> flags=0
0x24:	XOR R6, R6 ; =0 -> flags=1; #0 -> flags=0
0x27:	MOV R2, 0
0x2a:	MOV R1, BYTE PTR [R4 + R2]
0x2e:	MOV R3, 67
0x31:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34:	MOV R3, 231
0x37:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a:	MOV R3, 69
0x3d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40:	MOV R3, 104
0x43:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x46:	MOV R3, 7
0x49:	ADD R1, R3
0x4c:	MOV R3, 116
0x4f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x52:	MOV R3, 112
0x55:	ADD R1, R3
0x58:	MOV R3, 6
0x5b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5e:	MOV R3, 138
0x61:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x64:	MOV R3, 64
0x67:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6a:	MOV R3, 123
0x6d:	ADD R1, R3
0x70:	MOV R3, 70
0x73:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x76:	MOV R3, 216
0x79:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7c:	MOV R3, 136
0x7f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x82:	MOV R3, 36
0x85:	ADD R1, R3
0x88:	MOV R3, 106
0x8b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8e:	MOV R3, 133
0x91:	ADD R1, R3
0x94:	MOV R3, 156
0x97:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9a:	MOV R3, 65
0x9d:	ADD R1, R3
0xa0:	MOV R3, 222
0xa3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa6:	MOV R3, 181
0xa9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xac:	MOV R3, 219
0xaf:	ADD R1, R3
0xb2:	MOV R3, 202
0xb5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb8:	MOV R3, 196
0xbb:	ADD R1, R3
0xbe:	MOV R3, 94
0xc1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc4:	MOV R3, 10
0xc7:	ADD R1, R3
0xca:	MOV R3, 213
0xcd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd0:	MOV R3, 175
0xd3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd6:	MOV R3, 177
0xd9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xdc:	MOV R3, 93
0xdf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe2:	MOV R3, 119
0xe5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe8:	MOV R3, 116
0xeb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xee:	MOV R3, 234
0xf1:	ADD R1, R3
0xf4:	MOV R3, 105
0xf7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xfa:	MOV R3, 54
0xfd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x100:	MOV R3, 11
0x103:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x106:	MOV R3, 41
0x109:	ADD R1, R3
0x10c:	MOV R3, 225
0x10f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x112:	MOV R3, 166
0x115:	ADD R1, R3
0x118:	MOV R3, 71
0x11b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11e:	MOV R3, 94
0x121:	ADD R1, R3
0x124:	MOV R3, 234
0x127:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12a:	MOV R3, 158
0x12d:	ADD R1, R3
0x130:	MOV R3, 4
0x133:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x136:	MOV R3, 228
0x139:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13c:	MOV R5, 75
0x13f:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x142:	JNZ 0x14a
0x144:	MOV R2, 1
0x147:	ADD R6, R2
0x14a:	MOV R2, 1
0x14d:	MOV R1, BYTE PTR [R4 + R2]
0x151:	MOV R3, 128
0x154:	ADD R1, R3
0x157:	MOV R3, 47
0x15a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15d:	MOV R3, 189
0x160:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x163:	MOV R3, 104
0x166:	ADD R1, R3
0x169:	MOV R3, 103
0x16c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16f:	MOV R3, 132
0x172:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x175:	MOV R3, 140
0x178:	ADD R1, R3
0x17b:	MOV R3, 194
0x17e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x181:	MOV R3, 14
0x184:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x187:	MOV R3, 63
0x18a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18d:	MOV R3, 132
0x190:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x193:	MOV R3, 127
0x196:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x199:	MOV R3, 29
0x19c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19f:	MOV R3, 59
0x1a2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a5:	MOV R3, 171
0x1a8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ab:	MOV R3, 166
0x1ae:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b1:	MOV R3, 191
0x1b4:	ADD R1, R3
0x1b7:	MOV R3, 0
0x1ba:	ADD R1, R3
0x1bd:	MOV R3, 147
0x1c0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c3:	MOV R3, 79
0x1c6:	ADD R1, R3
0x1c9:	MOV R3, 27
0x1cc:	ADD R1, R3
0x1cf:	MOV R3, 81
0x1d2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d5:	MOV R3, 26
0x1d8:	ADD R1, R3
0x1db:	MOV R3, 228
0x1de:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e1:	MOV R3, 45
0x1e4:	ADD R1, R3
0x1e7:	MOV R3, 210
0x1ea:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ed:	MOV R3, 69
0x1f0:	ADD R1, R3
0x1f3:	MOV R3, 181
0x1f6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f9:	MOV R3, 82
0x1fc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ff:	MOV R3, 107
0x202:	ADD R1, R3
0x205:	MOV R3, 28
0x208:	ADD R1, R3
0x20b:	MOV R3, 228
0x20e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x211:	MOV R3, 64
0x214:	ADD R1, R3
0x217:	MOV R3, 3
0x21a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21d:	MOV R3, 11
0x220:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x223:	MOV R3, 163
0x226:	ADD R1, R3
0x229:	MOV R3, 37
0x22c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x22f:	MOV R3, 183
0x232:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x235:	MOV R3, 152
0x238:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23b:	MOV R3, 119
0x23e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x241:	MOV R3, 248
0x244:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x247:	MOV R5, 102
0x24a:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x24d:	JNZ 0x255
0x24f:	MOV R2, 1
0x252:	ADD R6, R2
0x255:	MOV R2, 2
0x258:	MOV R1, BYTE PTR [R4 + R2]
0x25c:	MOV R3, 238
0x25f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x262:	MOV R3, 47
0x265:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x268:	MOV R3, 150
0x26b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26e:	MOV R3, 103
0x271:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x274:	MOV R3, 128
0x277:	ADD R1, R3
0x27a:	MOV R3, 12
0x27d:	ADD R1, R3
0x280:	MOV R3, 178
0x283:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x286:	MOV R3, 38
0x289:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x28c:	MOV R3, 48
0x28f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x292:	MOV R3, 33
0x295:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x298:	MOV R3, 214
0x29b:	ADD R1, R3
0x29e:	MOV R3, 70
0x2a1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a4:	MOV R3, 84
0x2a7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2aa:	MOV R3, 19
0x2ad:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b0:	MOV R3, 173
0x2b3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b6:	MOV R3, 62
0x2b9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bc:	MOV R3, 187
0x2bf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c2:	MOV R3, 19
0x2c5:	ADD R1, R3
0x2c8:	MOV R3, 182
0x2cb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ce:	MOV R3, 58
0x2d1:	ADD R1, R3
0x2d4:	MOV R3, 248
0x2d7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2da:	MOV R3, 46
0x2dd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e0:	MOV R3, 70
0x2e3:	ADD R1, R3
0x2e6:	MOV R3, 89
0x2e9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ec:	MOV R3, 239
0x2ef:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f2:	MOV R3, 169
0x2f5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f8:	MOV R3, 53
0x2fb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2fe:	MOV R3, 150
0x301:	ADD R1, R3
0x304:	MOV R3, 160
0x307:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30a:	MOV R3, 62
0x30d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x310:	MOV R3, 245
0x313:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x316:	MOV R3, 141
0x319:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31c:	MOV R3, 1
0x31f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x322:	MOV R3, 255
0x325:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x328:	MOV R3, 49
0x32b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32e:	MOV R3, 90
0x331:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x334:	MOV R3, 40
0x337:	ADD R1, R3
0x33a:	MOV R3, 93
0x33d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x340:	MOV R3, 49
0x343:	ADD R1, R3
0x346:	MOV R3, 4
0x349:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34c:	MOV R3, 174
0x34f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x352:	MOV R3, 213
0x355:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x358:	MOV R3, 165
0x35b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35e:	MOV R3, 6
0x361:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x364:	MOV R3, 25
0x367:	ADD R1, R3
0x36a:	MOV R3, 123
0x36d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x370:	MOV R3, 162
0x373:	ADD R1, R3
0x376:	MOV R3, 80
0x379:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37c:	MOV R3, 4
0x37f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x382:	MOV R3, 114
0x385:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x388:	MOV R3, 102
0x38b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38e:	MOV R3, 5
0x391:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x394:	MOV R3, 118
0x397:	ADD R1, R3
0x39a:	MOV R3, 122
0x39d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a0:	MOV R3, 77
0x3a3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a6:	MOV R3, 146
0x3a9:	ADD R1, R3
0x3ac:	MOV R3, 152
0x3af:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b2:	MOV R3, 121
0x3b5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b8:	MOV R3, 182
0x3bb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3be:	MOV R3, 154
0x3c1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c4:	MOV R3, 244
0x3c7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ca:	MOV R3, 28
0x3cd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d0:	MOV R3, 172
0x3d3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d6:	MOV R3, 133
0x3d9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3dc:	MOV R3, 150
0x3df:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e2:	MOV R3, 92
0x3e5:	ADD R1, R3
0x3e8:	MOV R3, 182
0x3eb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ee:	MOV R3, 4
0x3f1:	ADD R1, R3
0x3f4:	MOV R3, 151
0x3f7:	ADD R1, R3
0x3fa:	MOV R3, 69
0x3fd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x400:	MOV R3, 137
0x403:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x406:	MOV R3, 71
0x409:	ADD R1, R3
0x40c:	MOV R3, 102
0x40f:	ADD R1, R3
0x412:	MOV R3, 167
0x415:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x418:	MOV R3, 67
0x41b:	ADD R1, R3
0x41e:	MOV R3, 142
0x421:	ADD R1, R3
0x424:	MOV R3, 49
0x427:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x42a:	MOV R3, 1
0x42d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x430:	MOV R3, 49
0x433:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x436:	MOV R3, 45
0x439:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x43c:	MOV R3, 132
0x43f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x442:	MOV R3, 231
0x445:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x448:	MOV R3, 144
0x44b:	ADD R1, R3
0x44e:	MOV R3, 0
0x451:	ADD R1, R3
0x454:	MOV R3, 20
0x457:	ADD R1, R3
0x45a:	MOV R3, 172
0x45d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x460:	MOV R3, 72
0x463:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x466:	MOV R3, 61
0x469:	ADD R1, R3
0x46c:	MOV R3, 124
0x46f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x472:	MOV R3, 31
0x475:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x478:	MOV R3, 71
0x47b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x47e:	MOV R3, 247
0x481:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x484:	MOV R3, 111
0x487:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x48a:	MOV R3, 77
0x48d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x490:	MOV R3, 180
0x493:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x496:	MOV R3, 125
0x499:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x49c:	MOV R3, 120
0x49f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4a2:	MOV R3, 76
0x4a5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4a8:	MOV R3, 14
0x4ab:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4ae:	MOV R3, 27
0x4b1:	ADD R1, R3
0x4b4:	MOV R3, 119
0x4b7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4ba:	MOV R3, 231
0x4bd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4c0:	MOV R3, 108
0x4c3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4c6:	MOV R3, 98
0x4c9:	ADD R1, R3
0x4cc:	MOV R3, 76
0x4cf:	ADD R1, R3
0x4d2:	MOV R3, 81
0x4d5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4d8:	MOV R3, 71
0x4db:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4de:	MOV R3, 163
0x4e1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4e4:	MOV R3, 159
0x4e7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4ea:	MOV R3, 2
0x4ed:	ADD R1, R3
0x4f0:	MOV R3, 109
0x4f3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4f6:	MOV R3, 2
0x4f9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4fc:	MOV R3, 82
0x4ff:	ADD R1, R3
0x502:	MOV R3, 35
0x505:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x508:	MOV R3, 123
0x50b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x50e:	MOV R3, 2
0x511:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x514:	MOV R3, 238
0x517:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x51a:	MOV R3, 129
0x51d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x520:	MOV R3, 82
0x523:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x526:	MOV R3, 221
0x529:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x52c:	MOV R3, 34
0x52f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x532:	MOV R3, 140
0x535:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x538:	MOV R3, 83
0x53b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x53e:	MOV R3, 78
0x541:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x544:	MOV R3, 150
0x547:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x54a:	MOV R3, 147
0x54d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x550:	MOV R3, 173
0x553:	ADD R1, R3
0x556:	MOV R3, 76
0x559:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x55c:	MOV R3, 221
0x55f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x562:	MOV R3, 32
0x565:	ADD R1, R3
0x568:	MOV R3, 22
0x56b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x56e:	MOV R3, 235
0x571:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x574:	MOV R3, 159
0x577:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x57a:	MOV R3, 65
0x57d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x580:	MOV R3, 63
0x583:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x586:	MOV R3, 201
0x589:	ADD R1, R3
0x58c:	MOV R3, 74
0x58f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x592:	MOV R3, 77
0x595:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x598:	MOV R3, 166
0x59b:	ADD R1, R3
0x59e:	MOV R3, 173
0x5a1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5a4:	MOV R3, 68
0x5a7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5aa:	MOV R3, 8
0x5ad:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5b0:	MOV R3, 85
0x5b3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5b6:	MOV R3, 137
0x5b9:	ADD R1, R3
0x5bc:	MOV R3, 176
0x5bf:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5c2:	MOV R3, 116
0x5c5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5c8:	MOV R3, 109
0x5cb:	ADD R1, R3
0x5ce:	MOV R3, 54
0x5d1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5d4:	MOV R3, 233
0x5d7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5da:	MOV R3, 102
0x5dd:	ADD R1, R3
0x5e0:	MOV R3, 195
0x5e3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5e6:	MOV R3, 140
0x5e9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5ec:	MOV R3, 179
0x5ef:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5f2:	MOV R3, 22
0x5f5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x5f8:	MOV R3, 104
0x5fb:	ADD R1, R3
0x5fe:	MOV R3, 11
0x601:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x604:	MOV R3, 108
0x607:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x60a:	MOV R3, 83
0x60d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x610:	MOV R3, 7
0x613:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x616:	MOV R3, 132
0x619:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x61c:	MOV R3, 53
0x61f:	ADD R1, R3
0x622:	MOV R3, 6
0x625:	ADD R1, R3
0x628:	MOV R3, 113
0x62b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x62e:	MOV R3, 17
0x631:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x634:	MOV R3, 157
0x637:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x63a:	MOV R3, 213
0x63d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x640:	MOV R3, 134
0x643:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x646:	MOV R3, 136
0x649:	ADD R1, R3
0x64c:	MOV R3, 244
0x64f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x652:	MOV R3, 217
0x655:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x658:	MOV R3, 186
0x65b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x65e:	MOV R3, 129
0x661:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x664:	MOV R3, 111
0x667:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x66a:	MOV R3, 199
0x66d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x670:	MOV R3, 24
0x673:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x676:	MOV R3, 107
0x679:	ADD R1, R3
0x67c:	MOV R3, 98
0x67f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x682:	MOV R3, 26
0x685:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x688:	MOV R3, 48
0x68b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x68e:	MOV R3, 156
0x691:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x694:	MOV R3, 7
0x697:	ADD R1, R3
0x69a:	MOV R3, 91
0x69d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6a0:	MOV R3, 175
0x6a3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6a6:	MOV R3, 8
0x6a9:	ADD R1, R3
0x6ac:	MOV R3, 122
0x6af:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6b2:	MOV R3, 15
0x6b5:	ADD R1, R3
0x6b8:	MOV R3, 146
0x6bb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6be:	MOV R3, 16
0x6c1:	ADD R1, R3
0x6c4:	MOV R3, 29
0x6c7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6ca:	MOV R3, 196
0x6cd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6d0:	MOV R3, 191
0x6d3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6d6:	MOV R3, 164
0x6d9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6dc:	MOV R3, 50
0x6df:	ADD R1, R3
0x6e2:	MOV R3, 92
0x6e5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x6e8:	MOV R5, 98
0x6eb:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x6ee:	JNZ 0x6f6
0x6f0:	MOV R2, 1
0x6f3:	ADD R6, R2
0x6f6:	MOV R2, 3
0x6f9:	MOV R1, BYTE PTR [R4 + R2]
0x6fd:	MOV R3, 62
0x700:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x703:	MOV R3, 110
0x706:	ADD R1, R3
0x709:	MOV R3, 96
0x70c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x70f:	MOV R3, 69
0x712:	ADD R1, R3
0x715:	MOV R3, 131
0x718:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x71b:	MOV R3, 128
0x71e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x721:	MOV R3, 5
0x724:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x727:	MOV R3, 116
0x72a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x72d:	MOV R3, 135
0x730:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x733:	MOV R3, 223
0x736:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x739:	MOV R3, 140
0x73c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x73f:	MOV R3, 45
0x742:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x745:	MOV R3, 237
0x748:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x74b:	MOV R3, 26
0x74e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x751:	MOV R3, 27
0x754:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x757:	MOV R3, 236
0x75a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x75d:	MOV R3, 70
0x760:	ADD R1, R3
0x763:	MOV R3, 131
0x766:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x769:	MOV R3, 133
0x76c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x76f:	MOV R3, 251
0x772:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x775:	MOV R3, 36
0x778:	ADD R1, R3
0x77b:	MOV R3, 98
0x77e:	ADD R1, R3
0x781:	MOV R3, 43
0x784:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x787:	MOV R3, 54
0x78a:	ADD R1, R3
0x78d:	MOV R3, 197
0x790:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x793:	MOV R3, 183
0x796:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x799:	MOV R3, 101
0x79c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x79f:	MOV R3, 30
0x7a2:	ADD R1, R3
0x7a5:	MOV R3, 176
0x7a8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7ab:	MOV R3, 163
0x7ae:	ADD R1, R3
0x7b1:	MOV R3, 64
0x7b4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7b7:	MOV R3, 106
0x7ba:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7bd:	MOV R3, 171
0x7c0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7c3:	MOV R3, 77
0x7c6:	ADD R1, R3
0x7c9:	MOV R3, 194
0x7cc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7cf:	MOV R3, 125
0x7d2:	ADD R1, R3
0x7d5:	MOV R3, 127
0x7d8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7db:	MOV R3, 237
0x7de:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7e1:	MOV R3, 154
0x7e4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7e7:	MOV R3, 181
0x7ea:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7ed:	MOV R3, 10
0x7f0:	ADD R1, R3
0x7f3:	MOV R3, 25
0x7f6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x7f9:	MOV R3, 9
0x7fc:	ADD R1, R3
0x7ff:	MOV R3, 130
0x802:	ADD R1, R3
0x805:	MOV R3, 16
0x808:	ADD R1, R3
0x80b:	MOV R3, 13
0x80e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x811:	MOV R3, 39
0x814:	ADD R1, R3
0x817:	MOV R3, 114
0x81a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x81d:	MOV R3, 47
0x820:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x823:	MOV R3, 31
0x826:	ADD R1, R3
0x829:	MOV R3, 32
0x82c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x82f:	MOV R3, 173
0x832:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x835:	MOV R3, 78
0x838:	ADD R1, R3
0x83b:	MOV R3, 221
0x83e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x841:	MOV R3, 106
0x844:	ADD R1, R3
0x847:	MOV R3, 36
0x84a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x84d:	MOV R3, 127
0x850:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x853:	MOV R3, 56
0x856:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x859:	MOV R3, 249
0x85c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x85f:	MOV R3, 26
0x862:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x865:	MOV R3, 143
0x868:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x86b:	MOV R3, 50
0x86e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x871:	MOV R3, 34
0x874:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x877:	MOV R3, 104
0x87a:	ADD R1, R3
0x87d:	MOV R3, 19
0x880:	ADD R1, R3
0x883:	MOV R3, 200
0x886:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x889:	MOV R3, 192
0x88c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x88f:	MOV R3, 95
0x892:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x895:	MOV R3, 118
0x898:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x89b:	MOV R3, 49
0x89e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8a1:	MOV R3, 83
0x8a4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8a7:	MOV R3, 70
0x8aa:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8ad:	MOV R3, 48
0x8b0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8b3:	MOV R3, 152
0x8b6:	ADD R1, R3
0x8b9:	MOV R3, 71
0x8bc:	ADD R1, R3
0x8bf:	MOV R3, 75
0x8c2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8c5:	MOV R3, 111
0x8c8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8cb:	MOV R3, 21
0x8ce:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8d1:	MOV R3, 24
0x8d4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8d7:	MOV R3, 122
0x8da:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8dd:	MOV R3, 72
0x8e0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8e3:	MOV R3, 189
0x8e6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8e9:	MOV R3, 7
0x8ec:	ADD R1, R3
0x8ef:	MOV R3, 195
0x8f2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8f5:	MOV R3, 8
0x8f8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x8fb:	MOV R3, 63
0x8fe:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x901:	MOV R3, 32
0x904:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x907:	MOV R3, 25
0x90a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x90d:	MOV R3, 46
0x910:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x913:	MOV R3, 145
0x916:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x919:	MOV R3, 134
0x91c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x91f:	MOV R3, 57
0x922:	ADD R1, R3
0x925:	MOV R3, 19
0x928:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x92b:	MOV R3, 6
0x92e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x931:	MOV R3, 43
0x934:	ADD R1, R3
0x937:	MOV R3, 111
0x93a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x93d:	MOV R3, 190
0x940:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x943:	MOV R3, 80
0x946:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x949:	MOV R3, 247
0x94c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x94f:	MOV R3, 50
0x952:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x955:	MOV R3, 33
0x958:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x95b:	MOV R3, 69
0x95e:	ADD R1, R3
0x961:	MOV R3, 161
0x964:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x967:	MOV R3, 41
0x96a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x96d:	MOV R3, 81
0x970:	ADD R1, R3
0x973:	MOV R3, 163
0x976:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x979:	MOV R3, 18
0x97c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x97f:	MOV R3, 117
0x982:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x985:	MOV R3, 47
0x988:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x98b:	MOV R3, 29
0x98e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x991:	MOV R3, 92
0x994:	ADD R1, R3
0x997:	MOV R3, 141
0x99a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x99d:	MOV R3, 195
0x9a0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9a3:	MOV R3, 9
0x9a6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9a9:	MOV R3, 30
0x9ac:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9af:	MOV R3, 12
0x9b2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9b5:	MOV R3, 105
0x9b8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9bb:	MOV R3, 208
0x9be:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9c1:	MOV R3, 47
0x9c4:	ADD R1, R3
0x9c7:	MOV R3, 40
0x9ca:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9cd:	MOV R3, 230
0x9d0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9d3:	MOV R3, 61
0x9d6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9d9:	MOV R3, 130
0x9dc:	ADD R1, R3
0x9df:	MOV R3, 24
0x9e2:	ADD R1, R3
0x9e5:	MOV R3, 63
0x9e8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9eb:	MOV R3, 53
0x9ee:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9f1:	MOV R3, 23
0x9f4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9f7:	MOV R3, 174
0x9fa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x9fd:	MOV R3, 129
0xa00:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa03:	MOV R3, 158
0xa06:	ADD R1, R3
0xa09:	MOV R3, 17
0xa0c:	ADD R1, R3
0xa0f:	MOV R3, 35
0xa12:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa15:	MOV R3, 103
0xa18:	ADD R1, R3
0xa1b:	MOV R3, 19
0xa1e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa21:	MOV R3, 152
0xa24:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa27:	MOV R3, 7
0xa2a:	ADD R1, R3
0xa2d:	MOV R3, 120
0xa30:	ADD R1, R3
0xa33:	MOV R3, 196
0xa36:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa39:	MOV R3, 191
0xa3c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa3f:	MOV R3, 124
0xa42:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa45:	MOV R3, 30
0xa48:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa4b:	MOV R3, 17
0xa4e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa51:	MOV R3, 35
0xa54:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa57:	MOV R3, 91
0xa5a:	ADD R1, R3
0xa5d:	MOV R3, 10
0xa60:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa63:	MOV R3, 18
0xa66:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa69:	MOV R3, 26
0xa6c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa6f:	MOV R3, 15
0xa72:	ADD R1, R3
0xa75:	MOV R3, 27
0xa78:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa7b:	MOV R3, 92
0xa7e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa81:	MOV R3, 223
0xa84:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa87:	MOV R3, 128
0xa8a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa8d:	MOV R3, 218
0xa90:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa93:	MOV R3, 202
0xa96:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa99:	MOV R3, 202
0xa9c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xa9f:	MOV R3, 150
0xaa2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xaa5:	MOV R3, 108
0xaa8:	ADD R1, R3
0xaab:	MOV R3, 1
0xaae:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xab1:	MOV R3, 94
0xab4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xab7:	MOV R3, 183
0xaba:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xabd:	MOV R3, 169
0xac0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xac3:	MOV R3, 94
0xac6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xac9:	MOV R3, 237
0xacc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xacf:	MOV R3, 55
0xad2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xad5:	MOV R3, 236
0xad8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xadb:	MOV R3, 59
0xade:	ADD R1, R3
0xae1:	MOV R3, 58
0xae4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xae7:	MOV R3, 219
0xaea:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xaed:	MOV R3, 61
0xaf0:	ADD R1, R3
0xaf3:	MOV R3, 56
0xaf6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xaf9:	MOV R3, 40
0xafc:	ADD R1, R3
0xaff:	MOV R3, 46
0xb02:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb05:	MOV R3, 68
0xb08:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb0b:	MOV R3, 206
0xb0e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb11:	MOV R3, 16
0xb14:	ADD R1, R3
0xb17:	MOV R3, 68
0xb1a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb1d:	MOV R3, 1
0xb20:	ADD R1, R3
0xb23:	MOV R3, 15
0xb26:	ADD R1, R3
0xb29:	MOV R3, 3
0xb2c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb2f:	MOV R3, 100
0xb32:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb35:	MOV R3, 44
0xb38:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb3b:	MOV R3, 14
0xb3e:	ADD R1, R3
0xb41:	MOV R3, 106
0xb44:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb47:	MOV R3, 118
0xb4a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb4d:	MOV R3, 53
0xb50:	ADD R1, R3
0xb53:	MOV R3, 242
0xb56:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb59:	MOV R3, 120
0xb5c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb5f:	MOV R3, 5
0xb62:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb65:	MOV R3, 218
0xb68:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb6b:	MOV R3, 73
0xb6e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb71:	MOV R3, 38
0xb74:	ADD R1, R3
0xb77:	MOV R3, 229
0xb7a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb7d:	MOV R3, 82
0xb80:	ADD R1, R3
0xb83:	MOV R3, 67
0xb86:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb89:	MOV R3, 218
0xb8c:	ADD R1, R3
0xb8f:	MOV R3, 78
0xb92:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb95:	MOV R3, 114
0xb98:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xb9b:	MOV R3, 41
0xb9e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xba1:	MOV R3, 50
0xba4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xba7:	MOV R3, 112
0xbaa:	ADD R1, R3
0xbad:	MOV R3, 37
0xbb0:	ADD R1, R3
0xbb3:	MOV R3, 169
0xbb6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xbb9:	MOV R3, 85
0xbbc:	ADD R1, R3
0xbbf:	MOV R3, 74
0xbc2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xbc5:	MOV R3, 40
0xbc8:	ADD R1, R3
0xbcb:	MOV R3, 87
0xbce:	ADD R1, R3
0xbd1:	MOV R3, 59
0xbd4:	ADD R1, R3
0xbd7:	MOV R3, 138
0xbda:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xbdd:	MOV R3, 35
0xbe0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xbe3:	MOV R3, 110
0xbe6:	ADD R1, R3
0xbe9:	MOV R3, 106
0xbec:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xbef:	MOV R3, 87
0xbf2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xbf5:	MOV R3, 100
0xbf8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xbfb:	MOV R3, 25
0xbfe:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc01:	MOV R3, 30
0xc04:	ADD R1, R3
0xc07:	MOV R3, 74
0xc0a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc0d:	MOV R3, 32
0xc10:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc13:	MOV R3, 7
0xc16:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc19:	MOV R3, 163
0xc1c:	ADD R1, R3
0xc1f:	MOV R3, 147
0xc22:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc25:	MOV R3, 141
0xc28:	ADD R1, R3
0xc2b:	MOV R3, 35
0xc2e:	ADD R1, R3
0xc31:	MOV R3, 186
0xc34:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc37:	MOV R3, 132
0xc3a:	ADD R1, R3
0xc3d:	MOV R3, 208
0xc40:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc43:	MOV R3, 5
0xc46:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc49:	MOV R3, 89
0xc4c:	ADD R1, R3
0xc4f:	MOV R3, 64
0xc52:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc55:	MOV R3, 46
0xc58:	ADD R1, R3
0xc5b:	MOV R3, 240
0xc5e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc61:	MOV R3, 241
0xc64:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc67:	MOV R3, 181
0xc6a:	ADD R1, R3
0xc6d:	MOV R3, 76
0xc70:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc73:	MOV R3, 31
0xc76:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc79:	MOV R3, 4
0xc7c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc7f:	MOV R3, 37
0xc82:	ADD R1, R3
0xc85:	MOV R3, 42
0xc88:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc8b:	MOV R3, 23
0xc8e:	ADD R1, R3
0xc91:	MOV R3, 38
0xc94:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc97:	MOV R3, 193
0xc9a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xc9d:	MOV R3, 90
0xca0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xca3:	MOV R3, 184
0xca6:	ADD R1, R3
0xca9:	MOV R3, 81
0xcac:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xcaf:	MOV R3, 147
0xcb2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xcb5:	MOV R3, 176
0xcb8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xcbb:	MOV R3, 248
0xcbe:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xcc1:	MOV R3, 66
0xcc4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xcc7:	MOV R3, 34
0xcca:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xccd:	MOV R3, 5
0xcd0:	ADD R1, R3
0xcd3:	MOV R3, 45
0xcd6:	ADD R1, R3
0xcd9:	MOV R3, 29
0xcdc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xcdf:	MOV R3, 21
0xce2:	ADD R1, R3
0xce5:	MOV R3, 104
0xce8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xceb:	MOV R3, 157
0xcee:	ADD R1, R3
0xcf1:	MOV R3, 26
0xcf4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xcf7:	MOV R3, 61
0xcfa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xcfd:	MOV R3, 211
0xd00:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd03:	MOV R3, 129
0xd06:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd09:	MOV R3, 61
0xd0c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd0f:	MOV R3, 72
0xd12:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd15:	MOV R3, 95
0xd18:	ADD R1, R3
0xd1b:	MOV R3, 6
0xd1e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd21:	MOV R3, 101
0xd24:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd27:	MOV R3, 46
0xd2a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd2d:	MOV R3, 72
0xd30:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd33:	MOV R3, 194
0xd36:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd39:	MOV R3, 31
0xd3c:	ADD R1, R3
0xd3f:	MOV R3, 157
0xd42:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd45:	MOV R3, 54
0xd48:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd4b:	MOV R3, 148
0xd4e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd51:	MOV R3, 109
0xd54:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd57:	MOV R3, 109
0xd5a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd5d:	MOV R3, 27
0xd60:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd63:	MOV R3, 28
0xd66:	ADD R1, R3
0xd69:	MOV R3, 109
0xd6c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd6f:	MOV R3, 210
0xd72:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd75:	MOV R3, 105
0xd78:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd7b:	MOV R3, 194
0xd7e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd81:	MOV R3, 66
0xd84:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd87:	MOV R3, 6
0xd8a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd8d:	MOV R3, 183
0xd90:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd93:	MOV R3, 97
0xd96:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd99:	MOV R3, 198
0xd9c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xd9f:	MOV R3, 101
0xda2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xda5:	MOV R3, 95
0xda8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xdab:	MOV R3, 123
0xdae:	ADD R1, R3
0xdb1:	MOV R3, 85
0xdb4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xdb7:	MOV R3, 60
0xdba:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xdbd:	MOV R3, 123
0xdc0:	ADD R1, R3
0xdc3:	MOV R3, 47
0xdc6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xdc9:	MOV R3, 30
0xdcc:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xdcf:	MOV R3, 81
0xdd2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xdd5:	MOV R3, 78
0xdd8:	ADD R1, R3
0xddb:	MOV R3, 217
0xdde:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xde1:	MOV R3, 206
0xde4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xde7:	MOV R3, 185
0xdea:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xded:	MOV R3, 52
0xdf0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xdf3:	MOV R3, 135
0xdf6:	ADD R1, R3
0xdf9:	MOV R3, 86
0xdfc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xdff:	MOV R3, 39
0xe02:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe05:	MOV R3, 9
0xe08:	ADD R1, R3
0xe0b:	MOV R3, 90
0xe0e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe11:	MOV R3, 144
0xe14:	ADD R1, R3
0xe17:	MOV R3, 33
0xe1a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe1d:	MOV R3, 27
0xe20:	ADD R1, R3
0xe23:	MOV R3, 210
0xe26:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe29:	MOV R3, 138
0xe2c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe2f:	MOV R3, 118
0xe32:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe35:	MOV R3, 82
0xe38:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe3b:	MOV R3, 86
0xe3e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe41:	MOV R3, 53
0xe44:	ADD R1, R3
0xe47:	MOV R3, 168
0xe4a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe4d:	MOV R5, 85
0xe50:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0xe53:	JNZ 0xe5b
0xe55:	MOV R2, 1
0xe58:	ADD R6, R2
0xe5b:	MOV R2, 4
0xe5e:	MOV R1, BYTE PTR [R4 + R2]
0xe62:	MOV R3, 235
0xe65:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe68:	MOV R3, 159
0xe6b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe6e:	MOV R3, 8
0xe71:	ADD R1, R3
0xe74:	MOV R3, 6
0xe77:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe7a:	MOV R3, 2
0xe7d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe80:	MOV R3, 14
0xe83:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe86:	MOV R3, 49
0xe89:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe8c:	MOV R3, 51
0xe8f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe92:	MOV R3, 97
0xe95:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe98:	MOV R3, 20
0xe9b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xe9e:	MOV R3, 77
0xea1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xea4:	MOV R3, 235
0xea7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xeaa:	MOV R3, 84
0xead:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xeb0:	MOV R3, 237
0xeb3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xeb6:	MOV R3, 136
0xeb9:	ADD R1, R3
0xebc:	MOV R3, 5
0xebf:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xec2:	MOV R3, 155
0xec5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xec8:	MOV R3, 213
0xecb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xece:	MOV R3, 85
0xed1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xed4:	MOV R3, 183
0xed7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xeda:	MOV R3, 202
0xedd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xee0:	MOV R3, 120
0xee3:	ADD R1, R3
0xee6:	MOV R3, 100
0xee9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xeec:	MOV R3, 247
0xeef:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xef2:	MOV R3, 78
0xef5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xef8:	MOV R3, 169
0xefb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xefe:	MOV R3, 148
0xf01:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf04:	MOV R5, 74
0xf07:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0xf0a:	JNZ 0xf12
0xf0c:	MOV R2, 1
0xf0f:	ADD R6, R2
0xf12:	MOV R2, 5
0xf15:	MOV R1, BYTE PTR [R4 + R2]
0xf19:	MOV R3, 175
0xf1c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf1f:	MOV R3, 237
0xf22:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf25:	MOV R3, 137
0xf28:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf2b:	MOV R3, 16
0xf2e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf31:	MOV R3, 92
0xf34:	ADD R1, R3
0xf37:	MOV R3, 224
0xf3a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf3d:	MOV R3, 214
0xf40:	ADD R1, R3
0xf43:	MOV R3, 223
0xf46:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf49:	MOV R3, 5
0xf4c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf4f:	MOV R3, 242
0xf52:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf55:	MOV R3, 211
0xf58:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf5b:	MOV R3, 227
0xf5e:	ADD R1, R3
0xf61:	MOV R3, 152
0xf64:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf67:	MOV R3, 182
0xf6a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf6d:	MOV R3, 2
0xf70:	ADD R1, R3
0xf73:	MOV R3, 22
0xf76:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf79:	MOV R3, 140
0xf7c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf7f:	MOV R3, 19
0xf82:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf85:	MOV R3, 35
0xf88:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf8b:	MOV R3, 101
0xf8e:	ADD R1, R3
0xf91:	MOV R3, 59
0xf94:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf97:	MOV R3, 60
0xf9a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xf9d:	MOV R3, 107
0xfa0:	ADD R1, R3
0xfa3:	MOV R3, 79
0xfa6:	ADD R1, R3
0xfa9:	MOV R3, 35
0xfac:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xfaf:	MOV R3, 127
0xfb2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xfb5:	MOV R3, 20
0xfb8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xfbb:	MOV R3, 127
0xfbe:	ADD R1, R3
0xfc1:	MOV R3, 67
0xfc4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xfc7:	MOV R3, 48
0xfca:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xfcd:	MOV R3, 245
0xfd0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xfd3:	MOV R3, 85
0xfd6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xfd9:	MOV R3, 62
0xfdc:	ADD R1, R3
0xfdf:	MOV R3, 24
0xfe2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xfe5:	MOV R3, 146
0xfe8:	ADD R1, R3
0xfeb:	MOV R3, 101
0xfee:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xff1:	MOV R3, 181
0xff4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xff7:	MOV R3, 149
0xffa:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0xffd:	MOV R3, 176
0x1000:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1003:	MOV R3, 22
0x1006:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1009:	MOV R3, 173
0x100c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x100f:	MOV R3, 4
0x1012:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1015:	MOV R3, 170
0x1018:	ADD R1, R3
0x101b:	MOV R3, 233
0x101e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1021:	MOV R3, 22
0x1024:	ADD R1, R3
0x1027:	MOV R3, 178
0x102a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x102d:	MOV R3, 37
0x1030:	ADD R1, R3
0x1033:	MOV R3, 239
0x1036:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1039:	MOV R3, 39
0x103c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x103f:	MOV R3, 62
0x1042:	ADD R1, R3
0x1045:	MOV R3, 17
0x1048:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x104b:	MOV R3, 80
0x104e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1051:	MOV R3, 237
0x1054:	ADD R1, R3
0x1057:	MOV R3, 214
0x105a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x105d:	MOV R3, 193
0x1060:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1063:	MOV R3, 55
0x1066:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1069:	MOV R3, 243
0x106c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x106f:	MOV R3, 158
0x1072:	ADD R1, R3
0x1075:	MOV R3, 79
0x1078:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x107b:	MOV R3, 43
0x107e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1081:	MOV R3, 191
0x1084:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1087:	MOV R3, 214
0x108a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x108d:	MOV R3, 224
0x1090:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1093:	MOV R3, 154
0x1096:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1099:	MOV R3, 187
0x109c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x109f:	MOV R3, 132
0x10a2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10a5:	MOV R3, 140
0x10a8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10ab:	MOV R3, 226
0x10ae:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10b1:	MOV R3, 116
0x10b4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10b7:	MOV R3, 110
0x10ba:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10bd:	MOV R3, 22
0x10c0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10c3:	MOV R3, 0
0x10c6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10c9:	MOV R3, 73
0x10cc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10cf:	MOV R3, 169
0x10d2:	ADD R1, R3
0x10d5:	MOV R3, 218
0x10d8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10db:	MOV R3, 241
0x10de:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10e1:	MOV R3, 118
0x10e4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10e7:	MOV R3, 37
0x10ea:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10ed:	MOV R3, 61
0x10f0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10f3:	MOV R3, 65
0x10f6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10f9:	MOV R3, 200
0x10fc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x10ff:	MOV R3, 200
0x1102:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1105:	MOV R3, 209
0x1108:	ADD R1, R3
0x110b:	MOV R3, 79
0x110e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1111:	MOV R3, 22
0x1114:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1117:	MOV R3, 30
0x111a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x111d:	MOV R3, 104
0x1120:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1123:	MOV R3, 5
0x1126:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1129:	MOV R3, 73
0x112c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x112f:	MOV R3, 69
0x1132:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1135:	MOV R3, 230
0x1138:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x113b:	MOV R3, 43
0x113e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1141:	MOV R3, 80
0x1144:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1147:	MOV R3, 123
0x114a:	ADD R1, R3
0x114d:	MOV R3, 62
0x1150:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1153:	MOV R3, 41
0x1156:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1159:	MOV R3, 120
0x115c:	ADD R1, R3
0x115f:	MOV R3, 16
0x1162:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1165:	MOV R3, 178
0x1168:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x116b:	MOV R5, 68
0x116e:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x1171:	JNZ 0x1179
0x1173:	MOV R2, 1
0x1176:	ADD R6, R2
0x1179:	MOV R2, 6
0x117c:	MOV R1, BYTE PTR [R4 + R2]
0x1180:	MOV R3, 235
0x1183:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1186:	MOV R3, 130
0x1189:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x118c:	MOV R3, 250
0x118f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1192:	MOV R3, 136
0x1195:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1198:	MOV R3, 31
0x119b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x119e:	MOV R3, 125
0x11a1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11a4:	MOV R3, 106
0x11a7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11aa:	MOV R3, 144
0x11ad:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11b0:	MOV R3, 7
0x11b3:	ADD R1, R3
0x11b6:	MOV R3, 97
0x11b9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11bc:	MOV R3, 56
0x11bf:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11c2:	MOV R3, 65
0x11c5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11c8:	MOV R3, 100
0x11cb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11ce:	MOV R3, 229
0x11d1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11d4:	MOV R3, 111
0x11d7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11da:	MOV R3, 128
0x11dd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11e0:	MOV R3, 38
0x11e3:	ADD R1, R3
0x11e6:	MOV R3, 133
0x11e9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11ec:	MOV R3, 156
0x11ef:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11f2:	MOV R3, 163
0x11f5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11f8:	MOV R3, 55
0x11fb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x11fe:	MOV R3, 44
0x1201:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1204:	MOV R3, 22
0x1207:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x120a:	MOV R3, 47
0x120d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1210:	MOV R3, 155
0x1213:	ADD R1, R3
0x1216:	MOV R3, 254
0x1219:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x121c:	MOV R3, 42
0x121f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1222:	MOV R3, 196
0x1225:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1228:	MOV R3, 146
0x122b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x122e:	MOV R3, 109
0x1231:	ADD R1, R3
0x1234:	MOV R3, 15
0x1237:	ADD R1, R3
0x123a:	MOV R3, 239
0x123d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1240:	MOV R3, 95
0x1243:	ADD R1, R3
0x1246:	MOV R3, 22
0x1249:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x124c:	MOV R3, 115
0x124f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1252:	MOV R3, 193
0x1255:	ADD R1, R3
0x1258:	MOV R3, 46
0x125b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x125e:	MOV R3, 181
0x1261:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1264:	MOV R3, 40
0x1267:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x126a:	MOV R3, 27
0x126d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1270:	MOV R3, 64
0x1273:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1276:	MOV R3, 39
0x1279:	ADD R1, R3
0x127c:	MOV R3, 187
0x127f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1282:	MOV R3, 12
0x1285:	ADD R1, R3
0x1288:	MOV R3, 26
0x128b:	ADD R1, R3
0x128e:	MOV R3, 142
0x1291:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1294:	MOV R3, 152
0x1297:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x129a:	MOV R3, 168
0x129d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12a0:	MOV R3, 22
0x12a3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12a6:	MOV R3, 16
0x12a9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12ac:	MOV R3, 164
0x12af:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12b2:	MOV R3, 46
0x12b5:	ADD R1, R3
0x12b8:	MOV R3, 152
0x12bb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12be:	MOV R3, 54
0x12c1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12c4:	MOV R3, 194
0x12c7:	ADD R1, R3
0x12ca:	MOV R3, 155
0x12cd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12d0:	MOV R3, 67
0x12d3:	ADD R1, R3
0x12d6:	MOV R3, 26
0x12d9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12dc:	MOV R3, 63
0x12df:	ADD R1, R3
0x12e2:	MOV R3, 250
0x12e5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12e8:	MOV R3, 0
0x12eb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x12ee:	MOV R3, 78
0x12f1:	ADD R1, R3
0x12f4:	MOV R3, 105
0x12f7:	ADD R1, R3
0x12fa:	MOV R3, 100
0x12fd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1300:	MOV R3, 100
0x1303:	ADD R1, R3
0x1306:	MOV R3, 128
0x1309:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x130c:	MOV R3, 81
0x130f:	ADD R1, R3
0x1312:	MOV R3, 162
0x1315:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1318:	MOV R3, 100
0x131b:	ADD R1, R3
0x131e:	MOV R3, 60
0x1321:	ADD R1, R3
0x1324:	MOV R3, 53
0x1327:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x132a:	MOV R3, 2
0x132d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1330:	MOV R3, 149
0x1333:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1336:	MOV R3, 251
0x1339:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x133c:	MOV R3, 23
0x133f:	ADD R1, R3
0x1342:	MOV R3, 70
0x1345:	ADD R1, R3
0x1348:	MOV R3, 100
0x134b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x134e:	MOV R3, 45
0x1351:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1354:	MOV R3, 194
0x1357:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x135a:	MOV R3, 180
0x135d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1360:	MOV R3, 68
0x1363:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1366:	MOV R3, 64
0x1369:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x136c:	MOV R3, 85
0x136f:	ADD R1, R3
0x1372:	MOV R3, 178
0x1375:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1378:	MOV R3, 204
0x137b:	ADD R1, R3
0x137e:	MOV R3, 146
0x1381:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1384:	MOV R3, 58
0x1387:	ADD R1, R3
0x138a:	MOV R3, 82
0x138d:	ADD R1, R3
0x1390:	MOV R3, 181
0x1393:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1396:	MOV R3, 36
0x1399:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x139c:	MOV R3, 180
0x139f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13a2:	MOV R3, 11
0x13a5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13a8:	MOV R3, 51
0x13ab:	ADD R1, R3
0x13ae:	MOV R3, 221
0x13b1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13b4:	MOV R3, 23
0x13b7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13ba:	MOV R3, 251
0x13bd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13c0:	MOV R3, 21
0x13c3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13c6:	MOV R3, 39
0x13c9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13cc:	MOV R3, 222
0x13cf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13d2:	MOV R3, 208
0x13d5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13d8:	MOV R3, 7
0x13db:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13de:	MOV R3, 75
0x13e1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13e4:	MOV R3, 106
0x13e7:	ADD R1, R3
0x13ea:	MOV R3, 175
0x13ed:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13f0:	MOV R3, 24
0x13f3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13f6:	MOV R3, 223
0x13f9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x13fc:	MOV R3, 25
0x13ff:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1402:	MOV R3, 133
0x1405:	ADD R1, R3
0x1408:	MOV R3, 169
0x140b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x140e:	MOV R3, 121
0x1411:	ADD R1, R3
0x1414:	MOV R3, 19
0x1417:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x141a:	MOV R3, 122
0x141d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1420:	MOV R3, 78
0x1423:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1426:	MOV R3, 124
0x1429:	ADD R1, R3
0x142c:	MOV R3, 204
0x142f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1432:	MOV R3, 23
0x1435:	ADD R1, R3
0x1438:	MOV R3, 189
0x143b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x143e:	MOV R3, 35
0x1441:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1444:	MOV R3, 56
0x1447:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x144a:	MOV R3, 31
0x144d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1450:	MOV R3, 8
0x1453:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1456:	MOV R3, 43
0x1459:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x145c:	MOV R3, 219
0x145f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1462:	MOV R3, 93
0x1465:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1468:	MOV R3, 41
0x146b:	ADD R1, R3
0x146e:	MOV R3, 160
0x1471:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1474:	MOV R3, 130
0x1477:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x147a:	MOV R3, 150
0x147d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1480:	MOV R3, 16
0x1483:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1486:	MOV R3, 131
0x1489:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x148c:	MOV R3, 92
0x148f:	ADD R1, R3
0x1492:	MOV R3, 63
0x1495:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1498:	MOV R3, 2
0x149b:	ADD R1, R3
0x149e:	MOV R3, 49
0x14a1:	ADD R1, R3
0x14a4:	MOV R3, 189
0x14a7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14aa:	MOV R3, 116
0x14ad:	ADD R1, R3
0x14b0:	MOV R3, 217
0x14b3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14b6:	MOV R3, 128
0x14b9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14bc:	MOV R3, 105
0x14bf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14c2:	MOV R3, 114
0x14c5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14c8:	MOV R3, 144
0x14cb:	ADD R1, R3
0x14ce:	MOV R3, 31
0x14d1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14d4:	MOV R3, 236
0x14d7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14da:	MOV R3, 225
0x14dd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14e0:	MOV R3, 38
0x14e3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14e6:	MOV R3, 101
0x14e9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14ec:	MOV R3, 95
0x14ef:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14f2:	MOV R3, 250
0x14f5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14f8:	MOV R3, 244
0x14fb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x14fe:	MOV R3, 239
0x1501:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1504:	MOV R5, 109
0x1507:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x150a:	JNZ 0x1512
0x150c:	MOV R2, 1
0x150f:	ADD R6, R2
0x1512:	MOV R2, 7
0x1515:	MOV R1, BYTE PTR [R4 + R2]
0x1519:	MOV R3, 245
0x151c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x151f:	MOV R3, 188
0x1522:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1525:	MOV R3, 139
0x1528:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x152b:	MOV R3, 82
0x152e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1531:	MOV R3, 165
0x1534:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1537:	MOV R3, 215
0x153a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x153d:	MOV R3, 17
0x1540:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1543:	MOV R3, 125
0x1546:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1549:	MOV R3, 202
0x154c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x154f:	MOV R3, 57
0x1552:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1555:	MOV R3, 73
0x1558:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x155b:	MOV R3, 177
0x155e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1561:	MOV R3, 245
0x1564:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1567:	MOV R3, 109
0x156a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x156d:	MOV R3, 45
0x1570:	ADD R1, R3
0x1573:	MOV R3, 151
0x1576:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1579:	MOV R3, 12
0x157c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x157f:	MOV R3, 150
0x1582:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1585:	MOV R3, 161
0x1588:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x158b:	MOV R3, 202
0x158e:	ADD R1, R3
0x1591:	MOV R3, 47
0x1594:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1597:	MOV R3, 25
0x159a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x159d:	MOV R3, 253
0x15a0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15a3:	MOV R3, 137
0x15a6:	ADD R1, R3
0x15a9:	MOV R3, 250
0x15ac:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15af:	MOV R3, 98
0x15b2:	ADD R1, R3
0x15b5:	MOV R3, 151
0x15b8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15bb:	MOV R3, 57
0x15be:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15c1:	MOV R3, 46
0x15c4:	ADD R1, R3
0x15c7:	MOV R3, 164
0x15ca:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15cd:	MOV R3, 143
0x15d0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15d3:	MOV R3, 6
0x15d6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15d9:	MOV R3, 50
0x15dc:	ADD R1, R3
0x15df:	MOV R3, 102
0x15e2:	ADD R1, R3
0x15e5:	MOV R3, 91
0x15e8:	ADD R1, R3
0x15eb:	MOV R3, 154
0x15ee:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15f1:	MOV R3, 14
0x15f4:	ADD R1, R3
0x15f7:	MOV R3, 51
0x15fa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x15fd:	MOV R3, 84
0x1600:	ADD R1, R3
0x1603:	MOV R3, 61
0x1606:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1609:	MOV R3, 76
0x160c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x160f:	MOV R3, 29
0x1612:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1615:	MOV R3, 68
0x1618:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x161b:	MOV R3, 11
0x161e:	ADD R1, R3
0x1621:	MOV R3, 196
0x1624:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1627:	MOV R3, 23
0x162a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x162d:	MOV R3, 105
0x1630:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1633:	MOV R3, 190
0x1636:	ADD R1, R3
0x1639:	MOV R3, 207
0x163c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x163f:	MOV R3, 94
0x1642:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1645:	MOV R3, 74
0x1648:	ADD R1, R3
0x164b:	MOV R3, 21
0x164e:	ADD R1, R3
0x1651:	MOV R3, 66
0x1654:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1657:	MOV R3, 36
0x165a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x165d:	MOV R3, 56
0x1660:	ADD R1, R3
0x1663:	MOV R3, 133
0x1666:	ADD R1, R3
0x1669:	MOV R3, 22
0x166c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x166f:	MOV R3, 6
0x1672:	ADD R1, R3
0x1675:	MOV R3, 18
0x1678:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x167b:	MOV R3, 136
0x167e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1681:	MOV R3, 60
0x1684:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1687:	MOV R3, 5
0x168a:	ADD R1, R3
0x168d:	MOV R3, 220
0x1690:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1693:	MOV R3, 186
0x1696:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1699:	MOV R3, 83
0x169c:	ADD R1, R3
0x169f:	MOV R3, 131
0x16a2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16a5:	MOV R3, 29
0x16a8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16ab:	MOV R3, 51
0x16ae:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16b1:	MOV R3, 26
0x16b4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16b7:	MOV R3, 150
0x16ba:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16bd:	MOV R3, 205
0x16c0:	ADD R1, R3
0x16c3:	MOV R3, 142
0x16c6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16c9:	MOV R3, 63
0x16cc:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16cf:	MOV R3, 158
0x16d2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16d5:	MOV R3, 95
0x16d8:	ADD R1, R3
0x16db:	MOV R3, 239
0x16de:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16e1:	MOV R3, 124
0x16e4:	ADD R1, R3
0x16e7:	MOV R3, 11
0x16ea:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16ed:	MOV R3, 126
0x16f0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16f3:	MOV R3, 90
0x16f6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16f9:	MOV R3, 125
0x16fc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x16ff:	MOV R3, 0
0x1702:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1705:	MOV R3, 212
0x1708:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x170b:	MOV R3, 221
0x170e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1711:	MOV R3, 49
0x1714:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1717:	MOV R3, 127
0x171a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x171d:	MOV R3, 75
0x1720:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1723:	MOV R3, 105
0x1726:	ADD R1, R3
0x1729:	MOV R3, 107
0x172c:	ADD R1, R3
0x172f:	MOV R3, 138
0x1732:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1735:	MOV R3, 14
0x1738:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x173b:	MOV R3, 163
0x173e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1741:	MOV R3, 148
0x1744:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1747:	MOV R3, 237
0x174a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x174d:	MOV R3, 3
0x1750:	ADD R1, R3
0x1753:	MOV R3, 96
0x1756:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1759:	MOV R3, 113
0x175c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x175f:	MOV R3, 71
0x1762:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1765:	MOV R3, 96
0x1768:	ADD R1, R3
0x176b:	MOV R3, 172
0x176e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1771:	MOV R3, 58
0x1774:	ADD R1, R3
0x1777:	MOV R3, 219
0x177a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x177d:	MOV R3, 112
0x1780:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1783:	MOV R3, 134
0x1786:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1789:	MOV R3, 231
0x178c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x178f:	MOV R3, 232
0x1792:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1795:	MOV R3, 41
0x1798:	ADD R1, R3
0x179b:	MOV R3, 37
0x179e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17a1:	MOV R3, 27
0x17a4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17a7:	MOV R3, 58
0x17aa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17ad:	MOV R3, 52
0x17b0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17b3:	MOV R3, 199
0x17b6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17b9:	MOV R3, 193
0x17bc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17bf:	MOV R3, 18
0x17c2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17c5:	MOV R3, 2
0x17c8:	ADD R1, R3
0x17cb:	MOV R3, 35
0x17ce:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17d1:	MOV R3, 48
0x17d4:	ADD R1, R3
0x17d7:	MOV R3, 171
0x17da:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17dd:	MOV R3, 44
0x17e0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17e3:	MOV R3, 223
0x17e6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17e9:	MOV R3, 91
0x17ec:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17ef:	MOV R3, 34
0x17f2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17f5:	MOV R3, 15
0x17f8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x17fb:	MOV R3, 37
0x17fe:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1801:	MOV R3, 143
0x1804:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1807:	MOV R3, 203
0x180a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x180d:	MOV R3, 83
0x1810:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1813:	MOV R3, 53
0x1816:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1819:	MOV R3, 26
0x181c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x181f:	MOV R3, 53
0x1822:	ADD R1, R3
0x1825:	MOV R3, 14
0x1828:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x182b:	MOV R3, 45
0x182e:	ADD R1, R3
0x1831:	MOV R3, 28
0x1834:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1837:	MOV R3, 184
0x183a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x183d:	MOV R3, 32
0x1840:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1843:	MOV R3, 180
0x1846:	ADD R1, R3
0x1849:	MOV R3, 194
0x184c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x184f:	MOV R3, 118
0x1852:	ADD R1, R3
0x1855:	MOV R3, 148
0x1858:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x185b:	MOV R3, 240
0x185e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1861:	MOV R3, 209
0x1864:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1867:	MOV R3, 179
0x186a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x186d:	MOV R3, 146
0x1870:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1873:	MOV R3, 24
0x1876:	ADD R1, R3
0x1879:	MOV R3, 91
0x187c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x187f:	MOV R3, 126
0x1882:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1885:	MOV R3, 150
0x1888:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x188b:	MOV R3, 107
0x188e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1891:	MOV R3, 98
0x1894:	ADD R1, R3
0x1897:	MOV R3, 123
0x189a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x189d:	MOV R3, 193
0x18a0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18a3:	MOV R3, 114
0x18a6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18a9:	MOV R3, 54
0x18ac:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18af:	MOV R3, 50
0x18b2:	ADD R1, R3
0x18b5:	MOV R3, 188
0x18b8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18bb:	MOV R3, 92
0x18be:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18c1:	MOV R3, 164
0x18c4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18c7:	MOV R3, 118
0x18ca:	ADD R1, R3
0x18cd:	MOV R3, 51
0x18d0:	ADD R1, R3
0x18d3:	MOV R3, 12
0x18d6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18d9:	MOV R3, 158
0x18dc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18df:	MOV R3, 97
0x18e2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18e5:	MOV R3, 177
0x18e8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18eb:	MOV R3, 94
0x18ee:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18f1:	MOV R3, 113
0x18f4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18f7:	MOV R3, 126
0x18fa:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x18fd:	MOV R3, 239
0x1900:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1903:	MOV R3, 151
0x1906:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1909:	MOV R3, 81
0x190c:	ADD R1, R3
0x190f:	MOV R3, 75
0x1912:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1915:	MOV R3, 207
0x1918:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x191b:	MOV R3, 20
0x191e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1921:	MOV R3, 24
0x1924:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1927:	MOV R3, 34
0x192a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x192d:	MOV R3, 67
0x1930:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1933:	MOV R3, 0
0x1936:	ADD R1, R3
0x1939:	MOV R3, 149
0x193c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x193f:	MOV R3, 79
0x1942:	ADD R1, R3
0x1945:	MOV R3, 65
0x1948:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x194b:	MOV R3, 87
0x194e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1951:	MOV R3, 86
0x1954:	ADD R1, R3
0x1957:	MOV R3, 145
0x195a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x195d:	MOV R3, 163
0x1960:	ADD R1, R3
0x1963:	MOV R3, 205
0x1966:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1969:	MOV R3, 2
0x196c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x196f:	MOV R3, 98
0x1972:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1975:	MOV R3, 216
0x1978:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x197b:	MOV R3, 41
0x197e:	ADD R1, R3
0x1981:	MOV R3, 128
0x1984:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1987:	MOV R3, 120
0x198a:	ADD R1, R3
0x198d:	MOV R3, 146
0x1990:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1993:	MOV R3, 23
0x1996:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1999:	MOV R3, 102
0x199c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x199f:	MOV R3, 147
0x19a2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19a5:	MOV R3, 10
0x19a8:	ADD R1, R3
0x19ab:	MOV R3, 120
0x19ae:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19b1:	MOV R3, 167
0x19b4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19b7:	MOV R3, 126
0x19ba:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19bd:	MOV R3, 89
0x19c0:	ADD R1, R3
0x19c3:	MOV R3, 52
0x19c6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19c9:	MOV R3, 223
0x19cc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19cf:	MOV R3, 101
0x19d2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19d5:	MOV R3, 168
0x19d8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19db:	MOV R3, 13
0x19de:	ADD R1, R3
0x19e1:	MOV R3, 31
0x19e4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19e7:	MOV R3, 105
0x19ea:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19ed:	MOV R3, 121
0x19f0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19f3:	MOV R3, 142
0x19f6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19f9:	MOV R3, 131
0x19fc:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x19ff:	MOV R3, 63
0x1a02:	ADD R1, R3
0x1a05:	MOV R3, 87
0x1a08:	ADD R1, R3
0x1a0b:	MOV R3, 51
0x1a0e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a11:	MOV R3, 43
0x1a14:	ADD R1, R3
0x1a17:	MOV R3, 194
0x1a1a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a1d:	MOV R3, 124
0x1a20:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a23:	MOV R3, 147
0x1a26:	ADD R1, R3
0x1a29:	MOV R3, 244
0x1a2c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a2f:	MOV R3, 208
0x1a32:	ADD R1, R3
0x1a35:	MOV R3, 213
0x1a38:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a3b:	MOV R3, 42
0x1a3e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a41:	MOV R3, 108
0x1a44:	ADD R1, R3
0x1a47:	MOV R3, 227
0x1a4a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a4d:	MOV R3, 94
0x1a50:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a53:	MOV R3, 21
0x1a56:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a59:	MOV R3, 150
0x1a5c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a5f:	MOV R3, 160
0x1a62:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a65:	MOV R3, 150
0x1a68:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a6b:	MOV R3, 72
0x1a6e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a71:	MOV R3, 117
0x1a74:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a77:	MOV R3, 1
0x1a7a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a7d:	MOV R3, 67
0x1a80:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a83:	MOV R3, 120
0x1a86:	ADD R1, R3
0x1a89:	MOV R3, 195
0x1a8c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a8f:	MOV R3, 86
0x1a92:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1a95:	MOV R3, 192
0x1a98:	ADD R1, R3
0x1a9b:	MOV R3, 4
0x1a9e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1aa1:	MOV R3, 219
0x1aa4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1aa7:	MOV R3, 247
0x1aaa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1aad:	MOV R3, 180
0x1ab0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ab3:	MOV R3, 109
0x1ab6:	ADD R1, R3
0x1ab9:	MOV R3, 110
0x1abc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1abf:	MOV R3, 74
0x1ac2:	ADD R1, R3
0x1ac5:	MOV R3, 163
0x1ac8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1acb:	MOV R3, 45
0x1ace:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ad1:	MOV R3, 148
0x1ad4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ad7:	MOV R3, 127
0x1ada:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1add:	MOV R3, 117
0x1ae0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ae3:	MOV R3, 106
0x1ae6:	ADD R1, R3
0x1ae9:	MOV R3, 223
0x1aec:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1aef:	MOV R3, 1
0x1af2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1af5:	MOV R3, 221
0x1af8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1afb:	MOV R3, 169
0x1afe:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b01:	MOV R3, 19
0x1b04:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b07:	MOV R3, 222
0x1b0a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b0d:	MOV R3, 109
0x1b10:	ADD R1, R3
0x1b13:	MOV R3, 88
0x1b16:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b19:	MOV R3, 4
0x1b1c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b1f:	MOV R3, 168
0x1b22:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b25:	MOV R3, 18
0x1b28:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b2b:	MOV R3, 116
0x1b2e:	ADD R1, R3
0x1b31:	MOV R3, 70
0x1b34:	ADD R1, R3
0x1b37:	MOV R3, 56
0x1b3a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b3d:	MOV R3, 56
0x1b40:	ADD R1, R3
0x1b43:	MOV R3, 116
0x1b46:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b49:	MOV R3, 114
0x1b4c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b4f:	MOV R3, 179
0x1b52:	ADD R1, R3
0x1b55:	MOV R3, 146
0x1b58:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b5b:	MOV R3, 220
0x1b5e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b61:	MOV R3, 20
0x1b64:	ADD R1, R3
0x1b67:	MOV R3, 56
0x1b6a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b6d:	MOV R3, 62
0x1b70:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b73:	MOV R3, 174
0x1b76:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b79:	MOV R3, 59
0x1b7c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b7f:	MOV R3, 27
0x1b82:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b85:	MOV R3, 76
0x1b88:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b8b:	MOV R3, 66
0x1b8e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b91:	MOV R3, 13
0x1b94:	ADD R1, R3
0x1b97:	MOV R3, 64
0x1b9a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1b9d:	MOV R3, 189
0x1ba0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ba3:	MOV R3, 199
0x1ba6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ba9:	MOV R3, 194
0x1bac:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1baf:	MOV R3, 67
0x1bb2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1bb5:	MOV R3, 174
0x1bb8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1bbb:	MOV R3, 63
0x1bbe:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1bc1:	MOV R3, 108
0x1bc4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1bc7:	MOV R3, 103
0x1bca:	ADD R1, R3
0x1bcd:	MOV R3, 21
0x1bd0:	ADD R1, R3
0x1bd3:	MOV R3, 89
0x1bd6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1bd9:	MOV R3, 146
0x1bdc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1bdf:	MOV R3, 124
0x1be2:	ADD R1, R3
0x1be5:	MOV R3, 182
0x1be8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1beb:	MOV R3, 121
0x1bee:	ADD R1, R3
0x1bf1:	MOV R3, 191
0x1bf4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1bf7:	MOV R3, 41
0x1bfa:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1bfd:	MOV R3, 35
0x1c00:	ADD R1, R3
0x1c03:	MOV R3, 152
0x1c06:	ADD R1, R3
0x1c09:	MOV R3, 165
0x1c0c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c0f:	MOV R3, 56
0x1c12:	ADD R1, R3
0x1c15:	MOV R3, 76
0x1c18:	ADD R1, R3
0x1c1b:	MOV R3, 125
0x1c1e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c21:	MOV R3, 20
0x1c24:	ADD R1, R3
0x1c27:	MOV R3, 5
0x1c2a:	ADD R1, R3
0x1c2d:	MOV R3, 113
0x1c30:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c33:	MOV R3, 112
0x1c36:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c39:	MOV R3, 145
0x1c3c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c3f:	MOV R3, 40
0x1c42:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c45:	MOV R3, 164
0x1c48:	ADD R1, R3
0x1c4b:	MOV R3, 240
0x1c4e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c51:	MOV R3, 49
0x1c54:	ADD R1, R3
0x1c57:	MOV R3, 81
0x1c5a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c5d:	MOV R3, 138
0x1c60:	ADD R1, R3
0x1c63:	MOV R3, 85
0x1c66:	ADD R1, R3
0x1c69:	MOV R3, 11
0x1c6c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c6f:	MOV R3, 174
0x1c72:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c75:	MOV R3, 37
0x1c78:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c7b:	MOV R3, 98
0x1c7e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c81:	MOV R3, 15
0x1c84:	ADD R1, R3
0x1c87:	MOV R3, 53
0x1c8a:	ADD R1, R3
0x1c8d:	MOV R3, 34
0x1c90:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c93:	MOV R3, 59
0x1c96:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1c99:	MOV R3, 41
0x1c9c:	ADD R1, R3
0x1c9f:	MOV R3, 96
0x1ca2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ca5:	MOV R3, 59
0x1ca8:	ADD R1, R3
0x1cab:	MOV R3, 160
0x1cae:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1cb1:	MOV R3, 51
0x1cb4:	ADD R1, R3
0x1cb7:	MOV R3, 72
0x1cba:	ADD R1, R3
0x1cbd:	MOV R3, 58
0x1cc0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1cc3:	MOV R3, 58
0x1cc6:	ADD R1, R3
0x1cc9:	MOV R3, 33
0x1ccc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ccf:	MOV R3, 127
0x1cd2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1cd5:	MOV R3, 84
0x1cd8:	ADD R1, R3
0x1cdb:	MOV R3, 88
0x1cde:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ce1:	MOV R3, 148
0x1ce4:	ADD R1, R3
0x1ce7:	MOV R3, 77
0x1cea:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ced:	MOV R3, 35
0x1cf0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1cf3:	MOV R3, 71
0x1cf6:	ADD R1, R3
0x1cf9:	MOV R3, 123
0x1cfc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1cff:	MOV R3, 151
0x1d02:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d05:	MOV R3, 186
0x1d08:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d0b:	MOV R3, 93
0x1d0e:	ADD R1, R3
0x1d11:	MOV R3, 20
0x1d14:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d17:	MOV R3, 174
0x1d1a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d1d:	MOV R3, 65
0x1d20:	ADD R1, R3
0x1d23:	MOV R3, 27
0x1d26:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d29:	MOV R3, 145
0x1d2c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d2f:	MOV R3, 15
0x1d32:	ADD R1, R3
0x1d35:	MOV R3, 134
0x1d38:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d3b:	MOV R3, 54
0x1d3e:	ADD R1, R3
0x1d41:	MOV R3, 84
0x1d44:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d47:	MOV R3, 7
0x1d4a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d4d:	MOV R3, 41
0x1d50:	ADD R1, R3
0x1d53:	MOV R3, 28
0x1d56:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d59:	MOV R3, 135
0x1d5c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d5f:	MOV R3, 114
0x1d62:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d65:	MOV R3, 138
0x1d68:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d6b:	MOV R3, 22
0x1d6e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d71:	MOV R3, 246
0x1d74:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d77:	MOV R3, 122
0x1d7a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d7d:	MOV R3, 44
0x1d80:	ADD R1, R3
0x1d83:	MOV R3, 11
0x1d86:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d89:	MOV R3, 107
0x1d8c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d8f:	MOV R3, 145
0x1d92:	ADD R1, R3
0x1d95:	MOV R3, 7
0x1d98:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1d9b:	MOV R3, 38
0x1d9e:	ADD R1, R3
0x1da1:	MOV R3, 189
0x1da4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1da7:	MOV R3, 71
0x1daa:	ADD R1, R3
0x1dad:	MOV R3, 220
0x1db0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1db3:	MOV R3, 41
0x1db6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1db9:	MOV R3, 50
0x1dbc:	ADD R1, R3
0x1dbf:	MOV R3, 149
0x1dc2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1dc5:	MOV R3, 155
0x1dc8:	ADD R1, R3
0x1dcb:	MOV R3, 27
0x1dce:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1dd1:	MOV R3, 7
0x1dd4:	ADD R1, R3
0x1dd7:	MOV R3, 91
0x1dda:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ddd:	MOV R3, 175
0x1de0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1de3:	MOV R3, 135
0x1de6:	ADD R1, R3
0x1de9:	MOV R3, 92
0x1dec:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1def:	MOV R3, 16
0x1df2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1df5:	MOV R3, 9
0x1df8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1dfb:	MOV R3, 230
0x1dfe:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e01:	MOV R3, 207
0x1e04:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e07:	MOV R3, 25
0x1e0a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e0d:	MOV R3, 19
0x1e10:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e13:	MOV R3, 22
0x1e16:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e19:	MOV R3, 121
0x1e1c:	ADD R1, R3
0x1e1f:	MOV R3, 182
0x1e22:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e25:	MOV R3, 44
0x1e28:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e2b:	MOV R3, 143
0x1e2e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e31:	MOV R3, 12
0x1e34:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e37:	MOV R3, 175
0x1e3a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e3d:	MOV R3, 37
0x1e40:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e43:	MOV R3, 18
0x1e46:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e49:	MOV R3, 15
0x1e4c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e4f:	MOV R3, 212
0x1e52:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e55:	MOV R3, 85
0x1e58:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e5b:	MOV R3, 252
0x1e5e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e61:	MOV R3, 233
0x1e64:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e67:	MOV R3, 12
0x1e6a:	ADD R1, R3
0x1e6d:	MOV R3, 100
0x1e70:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e73:	MOV R3, 64
0x1e76:	ADD R1, R3
0x1e79:	MOV R3, 98
0x1e7c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e7f:	MOV R3, 129
0x1e82:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e85:	MOV R3, 34
0x1e88:	ADD R1, R3
0x1e8b:	MOV R3, 109
0x1e8e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e91:	MOV R3, 205
0x1e94:	ADD R1, R3
0x1e97:	MOV R3, 88
0x1e9a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1e9d:	MOV R3, 219
0x1ea0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ea3:	MOV R3, 85
0x1ea6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ea9:	MOV R3, 67
0x1eac:	ADD R1, R3
0x1eaf:	MOV R3, 157
0x1eb2:	ADD R1, R3
0x1eb5:	MOV R3, 10
0x1eb8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ebb:	MOV R3, 62
0x1ebe:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ec1:	MOV R3, 112
0x1ec4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ec7:	MOV R3, 229
0x1eca:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ecd:	MOV R3, 51
0x1ed0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ed3:	MOV R3, 165
0x1ed6:	ADD R1, R3
0x1ed9:	MOV R3, 30
0x1edc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1edf:	MOV R3, 209
0x1ee2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ee5:	MOV R3, 53
0x1ee8:	ADD R1, R3
0x1eeb:	MOV R3, 59
0x1eee:	ADD R1, R3
0x1ef1:	MOV R3, 222
0x1ef4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ef7:	MOV R3, 222
0x1efa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1efd:	MOV R3, 188
0x1f00:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f03:	MOV R3, 85
0x1f06:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f09:	MOV R3, 24
0x1f0c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f0f:	MOV R3, 48
0x1f12:	ADD R1, R3
0x1f15:	MOV R3, 215
0x1f18:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f1b:	MOV R3, 231
0x1f1e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f21:	MOV R3, 81
0x1f24:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f27:	MOV R3, 6
0x1f2a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f2d:	MOV R3, 240
0x1f30:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f33:	MOV R3, 86
0x1f36:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f39:	MOV R3, 80
0x1f3c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f3f:	MOV R3, 225
0x1f42:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f45:	MOV R3, 81
0x1f48:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f4b:	MOV R3, 56
0x1f4e:	ADD R1, R3
0x1f51:	MOV R3, 72
0x1f54:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f57:	MOV R3, 43
0x1f5a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f5d:	MOV R3, 12
0x1f60:	ADD R1, R3
0x1f63:	MOV R3, 237
0x1f66:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f69:	MOV R3, 154
0x1f6c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f6f:	MOV R3, 137
0x1f72:	ADD R1, R3
0x1f75:	MOV R3, 192
0x1f78:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f7b:	MOV R3, 93
0x1f7e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f81:	MOV R3, 82
0x1f84:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f87:	MOV R3, 109
0x1f8a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f8d:	MOV R3, 68
0x1f90:	ADD R1, R3
0x1f93:	MOV R3, 158
0x1f96:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f99:	MOV R3, 179
0x1f9c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1f9f:	MOV R3, 237
0x1fa2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fa5:	MOV R3, 75
0x1fa8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fab:	MOV R3, 90
0x1fae:	ADD R1, R3
0x1fb1:	MOV R3, 25
0x1fb4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fb7:	MOV R3, 194
0x1fba:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fbd:	MOV R3, 207
0x1fc0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fc3:	MOV R3, 185
0x1fc6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fc9:	MOV R3, 13
0x1fcc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fcf:	MOV R3, 5
0x1fd2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fd5:	MOV R3, 71
0x1fd8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fdb:	MOV R3, 63
0x1fde:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fe1:	MOV R3, 113
0x1fe4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fe7:	MOV R3, 4
0x1fea:	ADD R1, R3
0x1fed:	MOV R3, 220
0x1ff0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ff3:	MOV R3, 164
0x1ff6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1ff9:	MOV R3, 151
0x1ffc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x1fff:	MOV R3, 35
0x2002:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2005:	MOV R3, 124
0x2008:	ADD R1, R3
0x200b:	MOV R3, 73
0x200e:	ADD R1, R3
0x2011:	MOV R3, 157
0x2014:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2017:	MOV R3, 17
0x201a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x201d:	MOV R3, 4
0x2020:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2023:	MOV R3, 34
0x2026:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2029:	MOV R3, 52
0x202c:	ADD R1, R3
0x202f:	MOV R3, 45
0x2032:	ADD R1, R3
0x2035:	MOV R3, 208
0x2038:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x203b:	MOV R3, 111
0x203e:	ADD R1, R3
0x2041:	MOV R3, 15
0x2044:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2047:	MOV R3, 41
0x204a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x204d:	MOV R3, 185
0x2050:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2053:	MOV R3, 66
0x2056:	ADD R1, R3
0x2059:	MOV R3, 161
0x205c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x205f:	MOV R3, 237
0x2062:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2065:	MOV R3, 180
0x2068:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x206b:	MOV R3, 50
0x206e:	ADD R1, R3
0x2071:	MOV R3, 83
0x2074:	ADD R1, R3
0x2077:	MOV R3, 81
0x207a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x207d:	MOV R3, 189
0x2080:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2083:	MOV R3, 85
0x2086:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2089:	MOV R3, 92
0x208c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x208f:	MOV R3, 119
0x2092:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2095:	MOV R3, 57
0x2098:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x209b:	MOV R3, 17
0x209e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20a1:	MOV R3, 196
0x20a4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20a7:	MOV R3, 177
0x20aa:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20ad:	MOV R3, 190
0x20b0:	ADD R1, R3
0x20b3:	MOV R3, 166
0x20b6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20b9:	MOV R3, 201
0x20bc:	ADD R1, R3
0x20bf:	MOV R3, 129
0x20c2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20c5:	MOV R3, 3
0x20c8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20cb:	MOV R3, 90
0x20ce:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20d1:	MOV R3, 39
0x20d4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20d7:	MOV R3, 149
0x20da:	ADD R1, R3
0x20dd:	MOV R3, 114
0x20e0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20e3:	MOV R3, 223
0x20e6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20e9:	MOV R3, 50
0x20ec:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20ef:	MOV R3, 36
0x20f2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x20f5:	MOV R3, 33
0x20f8:	ADD R1, R3
0x20fb:	MOV R3, 17
0x20fe:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2101:	MOV R3, 24
0x2104:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2107:	MOV R3, 37
0x210a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x210d:	MOV R3, 16
0x2110:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2113:	MOV R3, 49
0x2116:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2119:	MOV R3, 133
0x211c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x211f:	MOV R3, 88
0x2122:	ADD R1, R3
0x2125:	MOV R3, 7
0x2128:	ADD R1, R3
0x212b:	MOV R3, 43
0x212e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2131:	MOV R3, 84
0x2134:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2137:	MOV R3, 58
0x213a:	ADD R1, R3
0x213d:	MOV R3, 211
0x2140:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2143:	MOV R3, 82
0x2146:	ADD R1, R3
0x2149:	MOV R3, 176
0x214c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x214f:	MOV R3, 6
0x2152:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2155:	MOV R5, 112
0x2158:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x215b:	JNZ 0x2163
0x215d:	MOV R2, 1
0x2160:	ADD R6, R2
0x2163:	MOV R2, 8
0x2166:	MOV R1, BYTE PTR [R4 + R2]
0x216a:	MOV R5, 50
0x216d:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x2170:	JNZ 0x2178
0x2172:	MOV R2, 1
0x2175:	ADD R6, R2
0x2178:	MOV R2, 9
0x217b:	MOV R1, BYTE PTR [R4 + R2]
0x217f:	MOV R3, 102
0x2182:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2185:	MOV R3, 64
0x2188:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x218b:	MOV R3, 52
0x218e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2191:	MOV R3, 91
0x2194:	ADD R1, R3
0x2197:	MOV R3, 118
0x219a:	ADD R1, R3
0x219d:	MOV R3, 198
0x21a0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21a3:	MOV R3, 174
0x21a6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21a9:	MOV R3, 112
0x21ac:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21af:	MOV R3, 169
0x21b2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21b5:	MOV R3, 105
0x21b8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21bb:	MOV R3, 203
0x21be:	ADD R1, R3
0x21c1:	MOV R3, 209
0x21c4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21c7:	MOV R3, 46
0x21ca:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21cd:	MOV R3, 103
0x21d0:	ADD R1, R3
0x21d3:	MOV R3, 16
0x21d6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21d9:	MOV R3, 135
0x21dc:	ADD R1, R3
0x21df:	MOV R3, 67
0x21e2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21e5:	MOV R3, 59
0x21e8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21eb:	MOV R3, 127
0x21ee:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21f1:	MOV R3, 70
0x21f4:	ADD R1, R3
0x21f7:	MOV R3, 103
0x21fa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x21fd:	MOV R3, 230
0x2200:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2203:	MOV R3, 21
0x2206:	ADD R1, R3
0x2209:	MOV R3, 205
0x220c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x220f:	MOV R3, 188
0x2212:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2215:	MOV R3, 12
0x2218:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x221b:	MOV R3, 241
0x221e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2221:	MOV R3, 0
0x2224:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2227:	MOV R3, 71
0x222a:	ADD R1, R3
0x222d:	MOV R3, 35
0x2230:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2233:	MOV R3, 17
0x2236:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2239:	MOV R3, 82
0x223c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x223f:	MOV R3, 188
0x2242:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2245:	MOV R3, 121
0x2248:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x224b:	MOV R3, 210
0x224e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2251:	MOV R3, 84
0x2254:	ADD R1, R3
0x2257:	MOV R3, 247
0x225a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x225d:	MOV R3, 70
0x2260:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2263:	MOV R3, 40
0x2266:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2269:	MOV R3, 77
0x226c:	ADD R1, R3
0x226f:	MOV R3, 248
0x2272:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2275:	MOV R3, 91
0x2278:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x227b:	MOV R3, 96
0x227e:	ADD R1, R3
0x2281:	MOV R3, 64
0x2284:	ADD R1, R3
0x2287:	MOV R3, 222
0x228a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x228d:	MOV R3, 123
0x2290:	ADD R1, R3
0x2293:	MOV R3, 226
0x2296:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2299:	MOV R3, 35
0x229c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x229f:	MOV R3, 111
0x22a2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x22a5:	MOV R3, 222
0x22a8:	ADD R1, R3
0x22ab:	MOV R3, 134
0x22ae:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x22b1:	MOV R3, 27
0x22b4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x22b7:	MOV R5, 88
0x22ba:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x22bd:	JNZ 0x22c5
0x22bf:	MOV R2, 1
0x22c2:	ADD R6, R2
0x22c5:	MOV R2, 10
0x22c8:	MOV R1, BYTE PTR [R4 + R2]
0x22cc:	MOV R3, 83
0x22cf:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x22d2:	MOV R3, 86
0x22d5:	ADD R1, R3
0x22d8:	MOV R3, 64
0x22db:	ADD R1, R3
0x22de:	MOV R3, 247
0x22e1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x22e4:	MOV R3, 41
0x22e7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x22ea:	MOV R3, 78
0x22ed:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x22f0:	MOV R3, 202
0x22f3:	ADD R1, R3
0x22f6:	MOV R3, 211
0x22f9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x22fc:	MOV R3, 125
0x22ff:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2302:	MOV R3, 128
0x2305:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2308:	MOV R3, 10
0x230b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x230e:	MOV R3, 231
0x2311:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2314:	MOV R3, 27
0x2317:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x231a:	MOV R3, 29
0x231d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2320:	MOV R3, 91
0x2323:	ADD R1, R3
0x2326:	MOV R3, 12
0x2329:	ADD R1, R3
0x232c:	MOV R3, 75
0x232f:	ADD R1, R3
0x2332:	MOV R3, 56
0x2335:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2338:	MOV R3, 66
0x233b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x233e:	MOV R3, 54
0x2341:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2344:	MOV R3, 25
0x2347:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x234a:	MOV R3, 46
0x234d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2350:	MOV R3, 159
0x2353:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2356:	MOV R3, 7
0x2359:	ADD R1, R3
0x235c:	MOV R3, 205
0x235f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2362:	MOV R3, 103
0x2365:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2368:	MOV R3, 163
0x236b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x236e:	MOV R3, 64
0x2371:	ADD R1, R3
0x2374:	MOV R3, 28
0x2377:	ADD R1, R3
0x237a:	MOV R3, 33
0x237d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2380:	MOV R3, 48
0x2383:	ADD R1, R3
0x2386:	MOV R3, 45
0x2389:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x238c:	MOV R3, 141
0x238f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2392:	MOV R3, 194
0x2395:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2398:	MOV R3, 40
0x239b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x239e:	MOV R3, 130
0x23a1:	ADD R1, R3
0x23a4:	MOV R3, 177
0x23a7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23aa:	MOV R3, 103
0x23ad:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23b0:	MOV R3, 114
0x23b3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23b6:	MOV R3, 218
0x23b9:	ADD R1, R3
0x23bc:	MOV R3, 230
0x23bf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23c2:	MOV R3, 46
0x23c5:	ADD R1, R3
0x23c8:	MOV R3, 35
0x23cb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23ce:	MOV R3, 204
0x23d1:	ADD R1, R3
0x23d4:	MOV R3, 231
0x23d7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23da:	MOV R3, 65
0x23dd:	ADD R1, R3
0x23e0:	MOV R3, 145
0x23e3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23e6:	MOV R3, 114
0x23e9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23ec:	MOV R3, 29
0x23ef:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23f2:	MOV R3, 124
0x23f5:	ADD R1, R3
0x23f8:	MOV R3, 49
0x23fb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x23fe:	MOV R3, 4
0x2401:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2404:	MOV R3, 34
0x2407:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x240a:	MOV R3, 37
0x240d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2410:	MOV R3, 1
0x2413:	ADD R1, R3
0x2416:	MOV R3, 59
0x2419:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x241c:	MOV R3, 247
0x241f:	ADD R1, R3
0x2422:	MOV R3, 10
0x2425:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2428:	MOV R3, 143
0x242b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x242e:	MOV R3, 78
0x2431:	ADD R1, R3
0x2434:	MOV R3, 116
0x2437:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x243a:	MOV R3, 159
0x243d:	ADD R1, R3
0x2440:	MOV R3, 212
0x2443:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2446:	MOV R3, 34
0x2449:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x244c:	MOV R3, 83
0x244f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2452:	MOV R3, 163
0x2455:	ADD R1, R3
0x2458:	MOV R3, 155
0x245b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x245e:	MOV R3, 16
0x2461:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2464:	MOV R3, 63
0x2467:	ADD R1, R3
0x246a:	MOV R3, 64
0x246d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2470:	MOV R3, 209
0x2473:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2476:	MOV R3, 1
0x2479:	ADD R1, R3
0x247c:	MOV R3, 21
0x247f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2482:	MOV R3, 195
0x2485:	ADD R1, R3
0x2488:	MOV R3, 198
0x248b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x248e:	MOV R3, 225
0x2491:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2494:	MOV R3, 20
0x2497:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x249a:	MOV R3, 244
0x249d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24a0:	MOV R3, 52
0x24a3:	ADD R1, R3
0x24a6:	MOV R3, 242
0x24a9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24ac:	MOV R3, 183
0x24af:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24b2:	MOV R3, 61
0x24b5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24b8:	MOV R3, 81
0x24bb:	ADD R1, R3
0x24be:	MOV R3, 13
0x24c1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24c4:	MOV R3, 243
0x24c7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24ca:	MOV R3, 83
0x24cd:	ADD R1, R3
0x24d0:	MOV R3, 44
0x24d3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24d6:	MOV R3, 112
0x24d9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24dc:	MOV R3, 193
0x24df:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24e2:	MOV R3, 196
0x24e5:	ADD R1, R3
0x24e8:	MOV R3, 140
0x24eb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24ee:	MOV R3, 36
0x24f1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24f4:	MOV R3, 190
0x24f7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x24fa:	MOV R3, 147
0x24fd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2500:	MOV R3, 160
0x2503:	ADD R1, R3
0x2506:	MOV R3, 0
0x2509:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x250c:	MOV R3, 121
0x250f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2512:	MOV R3, 199
0x2515:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2518:	MOV R3, 67
0x251b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x251e:	MOV R3, 5
0x2521:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2524:	MOV R3, 79
0x2527:	ADD R1, R3
0x252a:	MOV R3, 142
0x252d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2530:	MOV R3, 160
0x2533:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2536:	MOV R3, 123
0x2539:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x253c:	MOV R3, 12
0x253f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2542:	MOV R3, 72
0x2545:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2548:	MOV R3, 63
0x254b:	ADD R1, R3
0x254e:	MOV R3, 178
0x2551:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2554:	MOV R3, 43
0x2557:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x255a:	MOV R3, 40
0x255d:	ADD R1, R3
0x2560:	MOV R3, 178
0x2563:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2566:	MOV R3, 151
0x2569:	ADD R1, R3
0x256c:	MOV R3, 117
0x256f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2572:	MOV R3, 67
0x2575:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2578:	MOV R3, 163
0x257b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x257e:	MOV R3, 4
0x2581:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2584:	MOV R3, 158
0x2587:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x258a:	MOV R3, 84
0x258d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2590:	MOV R3, 156
0x2593:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2596:	MOV R3, 139
0x2599:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x259c:	MOV R3, 178
0x259f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25a2:	MOV R3, 20
0x25a5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25a8:	MOV R3, 44
0x25ab:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25ae:	MOV R3, 107
0x25b1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25b4:	MOV R3, 248
0x25b7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25ba:	MOV R3, 167
0x25bd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25c0:	MOV R3, 176
0x25c3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25c6:	MOV R3, 129
0x25c9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25cc:	MOV R3, 70
0x25cf:	ADD R1, R3
0x25d2:	MOV R3, 122
0x25d5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25d8:	MOV R3, 187
0x25db:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25de:	MOV R3, 59
0x25e1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25e4:	MOV R3, 112
0x25e7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25ea:	MOV R3, 143
0x25ed:	ADD R1, R3
0x25f0:	MOV R3, 145
0x25f3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25f6:	MOV R3, 0
0x25f9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x25fc:	MOV R3, 4
0x25ff:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2602:	MOV R3, 176
0x2605:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2608:	MOV R3, 131
0x260b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x260e:	MOV R3, 238
0x2611:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2614:	MOV R3, 71
0x2617:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x261a:	MOV R3, 213
0x261d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2620:	MOV R5, 78
0x2623:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x2626:	JNZ 0x262e
0x2628:	MOV R2, 1
0x262b:	ADD R6, R2
0x262e:	MOV R2, 11
0x2631:	MOV R1, BYTE PTR [R4 + R2]
0x2635:	MOV R3, 67
0x2638:	ADD R1, R3
0x263b:	MOV R3, 26
0x263e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2641:	MOV R3, 24
0x2644:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2647:	MOV R3, 46
0x264a:	ADD R1, R3
0x264d:	MOV R3, 105
0x2650:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2653:	MOV R3, 58
0x2656:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2659:	MOV R3, 210
0x265c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x265f:	MOV R3, 254
0x2662:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2665:	MOV R3, 134
0x2668:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x266b:	MOV R3, 203
0x266e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2671:	MOV R3, 96
0x2674:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2677:	MOV R3, 66
0x267a:	ADD R1, R3
0x267d:	MOV R3, 161
0x2680:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2683:	MOV R3, 52
0x2686:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2689:	MOV R3, 67
0x268c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x268f:	MOV R3, 60
0x2692:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2695:	MOV R3, 25
0x2698:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x269b:	MOV R3, 229
0x269e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26a1:	MOV R3, 155
0x26a4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26a7:	MOV R3, 15
0x26aa:	ADD R1, R3
0x26ad:	MOV R3, 110
0x26b0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26b3:	MOV R3, 204
0x26b6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26b9:	MOV R3, 7
0x26bc:	ADD R1, R3
0x26bf:	MOV R3, 44
0x26c2:	ADD R1, R3
0x26c5:	MOV R3, 156
0x26c8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26cb:	MOV R3, 105
0x26ce:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26d1:	MOV R3, 222
0x26d4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26d7:	MOV R3, 9
0x26da:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26dd:	MOV R3, 93
0x26e0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26e3:	MOV R3, 118
0x26e6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26e9:	MOV R3, 97
0x26ec:	ADD R1, R3
0x26ef:	MOV R3, 146
0x26f2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26f5:	MOV R3, 137
0x26f8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x26fb:	MOV R3, 229
0x26fe:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2701:	MOV R3, 14
0x2704:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2707:	MOV R3, 205
0x270a:	ADD R1, R3
0x270d:	MOV R3, 47
0x2710:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2713:	MOV R3, 66
0x2716:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2719:	MOV R3, 150
0x271c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x271f:	MOV R3, 241
0x2722:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2725:	MOV R3, 24
0x2728:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x272b:	MOV R3, 62
0x272e:	ADD R1, R3
0x2731:	MOV R3, 136
0x2734:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2737:	MOV R3, 220
0x273a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x273d:	MOV R3, 39
0x2740:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2743:	MOV R3, 115
0x2746:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2749:	MOV R3, 34
0x274c:	ADD R1, R3
0x274f:	MOV R3, 125
0x2752:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2755:	MOV R3, 81
0x2758:	ADD R1, R3
0x275b:	MOV R3, 157
0x275e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2761:	MOV R3, 85
0x2764:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2767:	MOV R3, 16
0x276a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x276d:	MOV R3, 6
0x2770:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2773:	MOV R3, 54
0x2776:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2779:	MOV R3, 175
0x277c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x277f:	MOV R3, 246
0x2782:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2785:	MOV R3, 82
0x2788:	ADD R1, R3
0x278b:	MOV R3, 21
0x278e:	ADD R1, R3
0x2791:	MOV R3, 235
0x2794:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2797:	MOV R3, 52
0x279a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x279d:	MOV R3, 182
0x27a0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27a3:	MOV R3, 86
0x27a6:	ADD R1, R3
0x27a9:	MOV R3, 5
0x27ac:	ADD R1, R3
0x27af:	MOV R3, 50
0x27b2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27b5:	MOV R3, 157
0x27b8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27bb:	MOV R3, 23
0x27be:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27c1:	MOV R3, 78
0x27c4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27c7:	MOV R3, 124
0x27ca:	ADD R1, R3
0x27cd:	MOV R3, 7
0x27d0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27d3:	MOV R3, 236
0x27d6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27d9:	MOV R3, 105
0x27dc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27df:	MOV R3, 10
0x27e2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27e5:	MOV R3, 62
0x27e8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27eb:	MOV R3, 15
0x27ee:	ADD R1, R3
0x27f1:	MOV R3, 167
0x27f4:	ADD R1, R3
0x27f7:	MOV R3, 116
0x27fa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x27fd:	MOV R3, 173
0x2800:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2803:	MOV R3, 116
0x2806:	ADD R1, R3
0x2809:	MOV R3, 23
0x280c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x280f:	MOV R3, 19
0x2812:	ADD R1, R3
0x2815:	MOV R3, 116
0x2818:	ADD R1, R3
0x281b:	MOV R3, 8
0x281e:	ADD R1, R3
0x2821:	MOV R3, 72
0x2824:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2827:	MOV R3, 43
0x282a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x282d:	MOV R3, 16
0x2830:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2833:	MOV R3, 34
0x2836:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2839:	MOV R3, 125
0x283c:	ADD R1, R3
0x283f:	MOV R3, 59
0x2842:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2845:	MOV R3, 32
0x2848:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x284b:	MOV R3, 52
0x284e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2851:	MOV R3, 184
0x2854:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2857:	MOV R3, 32
0x285a:	ADD R1, R3
0x285d:	MOV R3, 167
0x2860:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2863:	MOV R3, 64
0x2866:	ADD R1, R3
0x2869:	MOV R3, 143
0x286c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x286f:	MOV R3, 245
0x2872:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2875:	MOV R3, 45
0x2878:	ADD R1, R3
0x287b:	MOV R3, 203
0x287e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2881:	MOV R3, 96
0x2884:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2887:	MOV R3, 6
0x288a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x288d:	MOV R3, 200
0x2890:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2893:	MOV R3, 191
0x2896:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2899:	MOV R3, 159
0x289c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x289f:	MOV R5, 98
0x28a2:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x28a5:	JNZ 0x28ad
0x28a7:	MOV R2, 1
0x28aa:	ADD R6, R2
0x28ad:	MOV R2, 12
0x28b0:	MOV R1, BYTE PTR [R4 + R2]
0x28b4:	MOV R3, 89
0x28b7:	ADD R1, R3
0x28ba:	MOV R3, 152
0x28bd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x28c0:	MOV R3, 74
0x28c3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x28c6:	MOV R3, 156
0x28c9:	ADD R1, R3
0x28cc:	MOV R3, 15
0x28cf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x28d2:	MOV R3, 23
0x28d5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x28d8:	MOV R3, 92
0x28db:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x28de:	MOV R3, 59
0x28e1:	ADD R1, R3
0x28e4:	MOV R3, 90
0x28e7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x28ea:	MOV R3, 27
0x28ed:	ADD R1, R3
0x28f0:	MOV R3, 93
0x28f3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x28f6:	MOV R3, 109
0x28f9:	ADD R1, R3
0x28fc:	MOV R3, 104
0x28ff:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2902:	MOV R3, 31
0x2905:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2908:	MOV R3, 93
0x290b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x290e:	MOV R3, 41
0x2911:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2914:	MOV R3, 11
0x2917:	ADD R1, R3
0x291a:	MOV R3, 106
0x291d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2920:	MOV R3, 12
0x2923:	ADD R1, R3
0x2926:	MOV R3, 246
0x2929:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x292c:	MOV R3, 29
0x292f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2932:	MOV R3, 41
0x2935:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2938:	MOV R3, 17
0x293b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x293e:	MOV R3, 37
0x2941:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2944:	MOV R3, 115
0x2947:	ADD R1, R3
0x294a:	MOV R3, 123
0x294d:	ADD R1, R3
0x2950:	MOV R3, 222
0x2953:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2956:	MOV R3, 87
0x2959:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x295c:	MOV R3, 246
0x295f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2962:	MOV R3, 13
0x2965:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2968:	MOV R3, 64
0x296b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x296e:	MOV R3, 11
0x2971:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2974:	MOV R3, 12
0x2977:	ADD R1, R3
0x297a:	MOV R3, 139
0x297d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2980:	MOV R3, 33
0x2983:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2986:	MOV R3, 223
0x2989:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x298c:	MOV R3, 133
0x298f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2992:	MOV R3, 82
0x2995:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2998:	MOV R3, 58
0x299b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x299e:	MOV R3, 184
0x29a1:	ADD R1, R3
0x29a4:	MOV R3, 200
0x29a7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29aa:	MOV R3, 241
0x29ad:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29b0:	MOV R3, 167
0x29b3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29b6:	MOV R3, 164
0x29b9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29bc:	MOV R3, 217
0x29bf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29c2:	MOV R3, 189
0x29c5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29c8:	MOV R3, 37
0x29cb:	ADD R1, R3
0x29ce:	MOV R3, 36
0x29d1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29d4:	MOV R3, 163
0x29d7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29da:	MOV R3, 56
0x29dd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29e0:	MOV R3, 86
0x29e3:	ADD R1, R3
0x29e6:	MOV R3, 139
0x29e9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29ec:	MOV R3, 202
0x29ef:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29f2:	MOV R3, 104
0x29f5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29f8:	MOV R3, 72
0x29fb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x29fe:	MOV R3, 15
0x2a01:	ADD R1, R3
0x2a04:	MOV R3, 185
0x2a07:	ADD R1, R3
0x2a0a:	MOV R3, 6
0x2a0d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a10:	MOV R3, 186
0x2a13:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a16:	MOV R3, 59
0x2a19:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a1c:	MOV R3, 89
0x2a1f:	ADD R1, R3
0x2a22:	MOV R3, 78
0x2a25:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a28:	MOV R3, 176
0x2a2b:	ADD R1, R3
0x2a2e:	MOV R3, 85
0x2a31:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a34:	MOV R3, 109
0x2a37:	ADD R1, R3
0x2a3a:	MOV R3, 86
0x2a3d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a40:	MOV R3, 6
0x2a43:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a46:	MOV R3, 5
0x2a49:	ADD R1, R3
0x2a4c:	MOV R3, 166
0x2a4f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a52:	MOV R3, 246
0x2a55:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a58:	MOV R3, 55
0x2a5b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a5e:	MOV R3, 27
0x2a61:	ADD R1, R3
0x2a64:	MOV R3, 55
0x2a67:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a6a:	MOV R3, 31
0x2a6d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a70:	MOV R3, 235
0x2a73:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a76:	MOV R3, 18
0x2a79:	ADD R1, R3
0x2a7c:	MOV R3, 21
0x2a7f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a82:	MOV R3, 12
0x2a85:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a88:	MOV R3, 32
0x2a8b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a8e:	MOV R3, 170
0x2a91:	ADD R1, R3
0x2a94:	MOV R3, 13
0x2a97:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2a9a:	MOV R3, 52
0x2a9d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2aa0:	MOV R3, 147
0x2aa3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2aa6:	MOV R3, 214
0x2aa9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2aac:	MOV R3, 115
0x2aaf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ab2:	MOV R3, 38
0x2ab5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ab8:	MOV R3, 174
0x2abb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2abe:	MOV R3, 212
0x2ac1:	ADD R1, R3
0x2ac4:	MOV R3, 62
0x2ac7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2aca:	MOV R3, 121
0x2acd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ad0:	MOV R3, 38
0x2ad3:	ADD R1, R3
0x2ad6:	MOV R3, 184
0x2ad9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2adc:	MOV R3, 148
0x2adf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ae2:	MOV R3, 10
0x2ae5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ae8:	MOV R3, 132
0x2aeb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2aee:	MOV R3, 124
0x2af1:	ADD R1, R3
0x2af4:	MOV R3, 237
0x2af7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2afa:	MOV R3, 11
0x2afd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b00:	MOV R3, 239
0x2b03:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b06:	MOV R3, 150
0x2b09:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b0c:	MOV R3, 137
0x2b0f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b12:	MOV R3, 67
0x2b15:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b18:	MOV R3, 83
0x2b1b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b1e:	MOV R3, 38
0x2b21:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b24:	MOV R3, 104
0x2b27:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b2a:	MOV R3, 80
0x2b2d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b30:	MOV R3, 192
0x2b33:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b36:	MOV R3, 65
0x2b39:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b3c:	MOV R3, 98
0x2b3f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b42:	MOV R3, 173
0x2b45:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b48:	MOV R3, 27
0x2b4b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b4e:	MOV R3, 63
0x2b51:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b54:	MOV R3, 30
0x2b57:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b5a:	MOV R3, 81
0x2b5d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b60:	MOV R3, 137
0x2b63:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b66:	MOV R3, 210
0x2b69:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b6c:	MOV R3, 144
0x2b6f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b72:	MOV R3, 224
0x2b75:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b78:	MOV R3, 132
0x2b7b:	ADD R1, R3
0x2b7e:	MOV R3, 169
0x2b81:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b84:	MOV R3, 78
0x2b87:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b8a:	MOV R3, 56
0x2b8d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b90:	MOV R3, 77
0x2b93:	ADD R1, R3
0x2b96:	MOV R3, 217
0x2b99:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2b9c:	MOV R3, 57
0x2b9f:	ADD R1, R3
0x2ba2:	MOV R3, 105
0x2ba5:	ADD R1, R3
0x2ba8:	MOV R3, 30
0x2bab:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bae:	MOV R3, 163
0x2bb1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bb4:	MOV R3, 98
0x2bb7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bba:	MOV R3, 96
0x2bbd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bc0:	MOV R3, 19
0x2bc3:	ADD R1, R3
0x2bc6:	MOV R3, 232
0x2bc9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bcc:	MOV R3, 94
0x2bcf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bd2:	MOV R3, 7
0x2bd5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bd8:	MOV R3, 224
0x2bdb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bde:	MOV R3, 111
0x2be1:	ADD R1, R3
0x2be4:	MOV R3, 196
0x2be7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bea:	MOV R3, 188
0x2bed:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bf0:	MOV R3, 169
0x2bf3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bf6:	MOV R3, 236
0x2bf9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2bfc:	MOV R3, 74
0x2bff:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c02:	MOV R3, 19
0x2c05:	ADD R1, R3
0x2c08:	MOV R3, 50
0x2c0b:	ADD R1, R3
0x2c0e:	MOV R3, 16
0x2c11:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c14:	MOV R3, 108
0x2c17:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c1a:	MOV R3, 28
0x2c1d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c20:	MOV R3, 63
0x2c23:	ADD R1, R3
0x2c26:	MOV R3, 150
0x2c29:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c2c:	MOV R3, 49
0x2c2f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c32:	MOV R3, 148
0x2c35:	ADD R1, R3
0x2c38:	MOV R3, 210
0x2c3b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c3e:	MOV R3, 122
0x2c41:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c44:	MOV R3, 144
0x2c47:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c4a:	MOV R3, 129
0x2c4d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c50:	MOV R3, 201
0x2c53:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c56:	MOV R3, 148
0x2c59:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c5c:	MOV R3, 90
0x2c5f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c62:	MOV R3, 31
0x2c65:	ADD R1, R3
0x2c68:	MOV R3, 50
0x2c6b:	ADD R1, R3
0x2c6e:	MOV R3, 30
0x2c71:	ADD R1, R3
0x2c74:	MOV R3, 37
0x2c77:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c7a:	MOV R3, 87
0x2c7d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c80:	MOV R3, 231
0x2c83:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c86:	MOV R3, 198
0x2c89:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c8c:	MOV R3, 167
0x2c8f:	ADD R1, R3
0x2c92:	MOV R3, 245
0x2c95:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c98:	MOV R3, 146
0x2c9b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2c9e:	MOV R3, 43
0x2ca1:	ADD R1, R3
0x2ca4:	MOV R3, 46
0x2ca7:	ADD R1, R3
0x2caa:	MOV R3, 4
0x2cad:	ADD R1, R3
0x2cb0:	MOV R3, 66
0x2cb3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2cb6:	MOV R3, 146
0x2cb9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2cbc:	MOV R3, 3
0x2cbf:	ADD R1, R3
0x2cc2:	MOV R3, 212
0x2cc5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2cc8:	MOV R3, 96
0x2ccb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2cce:	MOV R3, 81
0x2cd1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2cd4:	MOV R3, 30
0x2cd7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2cda:	MOV R3, 79
0x2cdd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ce0:	MOV R3, 102
0x2ce3:	ADD R1, R3
0x2ce6:	MOV R3, 98
0x2ce9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2cec:	MOV R3, 76
0x2cef:	ADD R1, R3
0x2cf2:	MOV R3, 147
0x2cf5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2cf8:	MOV R3, 243
0x2cfb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2cfe:	MOV R3, 198
0x2d01:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d04:	MOV R3, 30
0x2d07:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d0a:	MOV R3, 144
0x2d0d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d10:	MOV R3, 68
0x2d13:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d16:	MOV R3, 116
0x2d19:	ADD R1, R3
0x2d1c:	MOV R3, 7
0x2d1f:	ADD R1, R3
0x2d22:	MOV R3, 143
0x2d25:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d28:	MOV R3, 23
0x2d2b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d2e:	MOV R3, 44
0x2d31:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d34:	MOV R3, 220
0x2d37:	ADD R1, R3
0x2d3a:	MOV R3, 5
0x2d3d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d40:	MOV R3, 176
0x2d43:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d46:	MOV R3, 58
0x2d49:	ADD R1, R3
0x2d4c:	MOV R3, 35
0x2d4f:	ADD R1, R3
0x2d52:	MOV R3, 90
0x2d55:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d58:	MOV R3, 128
0x2d5b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d5e:	MOV R3, 57
0x2d61:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d64:	MOV R3, 76
0x2d67:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d6a:	MOV R3, 125
0x2d6d:	ADD R1, R3
0x2d70:	MOV R3, 45
0x2d73:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d76:	MOV R3, 49
0x2d79:	ADD R1, R3
0x2d7c:	MOV R3, 234
0x2d7f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d82:	MOV R3, 130
0x2d85:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d88:	MOV R3, 90
0x2d8b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d8e:	MOV R3, 241
0x2d91:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d94:	MOV R3, 24
0x2d97:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2d9a:	MOV R3, 34
0x2d9d:	ADD R1, R3
0x2da0:	MOV R3, 52
0x2da3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2da6:	MOV R3, 134
0x2da9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2dac:	MOV R3, 54
0x2daf:	ADD R1, R3
0x2db2:	MOV R3, 54
0x2db5:	ADD R1, R3
0x2db8:	MOV R3, 28
0x2dbb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2dbe:	MOV R3, 138
0x2dc1:	ADD R1, R3
0x2dc4:	MOV R3, 117
0x2dc7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2dca:	MOV R3, 90
0x2dcd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2dd0:	MOV R3, 25
0x2dd3:	ADD R1, R3
0x2dd6:	MOV R3, 70
0x2dd9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ddc:	MOV R3, 120
0x2ddf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2de2:	MOV R3, 177
0x2de5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2de8:	MOV R3, 4
0x2deb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2dee:	MOV R3, 169
0x2df1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2df4:	MOV R3, 129
0x2df7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2dfa:	MOV R3, 80
0x2dfd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e00:	MOV R3, 26
0x2e03:	ADD R1, R3
0x2e06:	MOV R3, 26
0x2e09:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e0c:	MOV R3, 109
0x2e0f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e12:	MOV R3, 186
0x2e15:	ADD R1, R3
0x2e18:	MOV R3, 197
0x2e1b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e1e:	MOV R3, 41
0x2e21:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e24:	MOV R3, 221
0x2e27:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e2a:	MOV R3, 148
0x2e2d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e30:	MOV R3, 172
0x2e33:	ADD R1, R3
0x2e36:	MOV R3, 63
0x2e39:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e3c:	MOV R3, 64
0x2e3f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e42:	MOV R3, 48
0x2e45:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e48:	MOV R3, 86
0x2e4b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e4e:	MOV R3, 213
0x2e51:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e54:	MOV R3, 6
0x2e57:	ADD R1, R3
0x2e5a:	MOV R3, 180
0x2e5d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e60:	MOV R3, 123
0x2e63:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e66:	MOV R3, 190
0x2e69:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e6c:	MOV R3, 38
0x2e6f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e72:	MOV R3, 64
0x2e75:	ADD R1, R3
0x2e78:	MOV R3, 28
0x2e7b:	ADD R1, R3
0x2e7e:	MOV R3, 127
0x2e81:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e84:	MOV R3, 60
0x2e87:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e8a:	MOV R3, 95
0x2e8d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e90:	MOV R3, 158
0x2e93:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e96:	MOV R3, 116
0x2e99:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2e9c:	MOV R3, 96
0x2e9f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ea2:	MOV R3, 24
0x2ea5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ea8:	MOV R3, 104
0x2eab:	ADD R1, R3
0x2eae:	MOV R3, 23
0x2eb1:	ADD R1, R3
0x2eb4:	MOV R3, 37
0x2eb7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2eba:	MOV R3, 121
0x2ebd:	ADD R1, R3
0x2ec0:	MOV R3, 209
0x2ec3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ec6:	MOV R3, 104
0x2ec9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ecc:	MOV R3, 114
0x2ecf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ed2:	MOV R3, 254
0x2ed5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ed8:	MOV R3, 11
0x2edb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ede:	MOV R3, 20
0x2ee1:	ADD R1, R3
0x2ee4:	MOV R3, 13
0x2ee7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2eea:	MOV R3, 29
0x2eed:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ef0:	MOV R3, 243
0x2ef3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ef6:	MOV R3, 163
0x2ef9:	ADD R1, R3
0x2efc:	MOV R3, 84
0x2eff:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f02:	MOV R3, 67
0x2f05:	ADD R1, R3
0x2f08:	MOV R3, 193
0x2f0b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f0e:	MOV R3, 63
0x2f11:	ADD R1, R3
0x2f14:	MOV R3, 75
0x2f17:	ADD R1, R3
0x2f1a:	MOV R3, 10
0x2f1d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f20:	MOV R3, 86
0x2f23:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f26:	MOV R3, 27
0x2f29:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f2c:	MOV R3, 11
0x2f2f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f32:	MOV R3, 114
0x2f35:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f38:	MOV R3, 177
0x2f3b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f3e:	MOV R3, 11
0x2f41:	ADD R1, R3
0x2f44:	MOV R3, 184
0x2f47:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f4a:	MOV R3, 67
0x2f4d:	ADD R1, R3
0x2f50:	MOV R3, 124
0x2f53:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f56:	MOV R3, 80
0x2f59:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f5c:	MOV R3, 89
0x2f5f:	ADD R1, R3
0x2f62:	MOV R3, 112
0x2f65:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f68:	MOV R3, 15
0x2f6b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f6e:	MOV R3, 162
0x2f71:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f74:	MOV R3, 69
0x2f77:	ADD R1, R3
0x2f7a:	MOV R3, 108
0x2f7d:	ADD R1, R3
0x2f80:	MOV R3, 237
0x2f83:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f86:	MOV R3, 97
0x2f89:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f8c:	MOV R3, 48
0x2f8f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f92:	MOV R3, 198
0x2f95:	ADD R1, R3
0x2f98:	MOV R3, 66
0x2f9b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2f9e:	MOV R3, 9
0x2fa1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2fa4:	MOV R3, 91
0x2fa7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2faa:	MOV R3, 56
0x2fad:	ADD R1, R3
0x2fb0:	MOV R3, 73
0x2fb3:	ADD R1, R3
0x2fb6:	MOV R3, 104
0x2fb9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2fbc:	MOV R3, 60
0x2fbf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2fc2:	MOV R3, 251
0x2fc5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2fc8:	MOV R3, 71
0x2fcb:	ADD R1, R3
0x2fce:	MOV R3, 169
0x2fd1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2fd4:	MOV R3, 135
0x2fd7:	ADD R1, R3
0x2fda:	MOV R3, 180
0x2fdd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2fe0:	MOV R3, 11
0x2fe3:	ADD R1, R3
0x2fe6:	MOV R3, 103
0x2fe9:	ADD R1, R3
0x2fec:	MOV R3, 58
0x2fef:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ff2:	MOV R3, 13
0x2ff5:	ADD R1, R3
0x2ff8:	MOV R3, 212
0x2ffb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x2ffe:	MOV R3, 74
0x3001:	ADD R1, R3
0x3004:	MOV R3, 71
0x3007:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x300a:	MOV R3, 18
0x300d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3010:	MOV R3, 37
0x3013:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3016:	MOV R3, 107
0x3019:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x301c:	MOV R3, 133
0x301f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3022:	MOV R3, 88
0x3025:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3028:	MOV R3, 180
0x302b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x302e:	MOV R3, 170
0x3031:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3034:	MOV R3, 92
0x3037:	ADD R1, R3
0x303a:	MOV R3, 94
0x303d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3040:	MOV R3, 126
0x3043:	ADD R1, R3
0x3046:	MOV R3, 3
0x3049:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x304c:	MOV R3, 22
0x304f:	ADD R1, R3
0x3052:	MOV R3, 7
0x3055:	ADD R1, R3
0x3058:	MOV R3, 79
0x305b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x305e:	MOV R3, 214
0x3061:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3064:	MOV R3, 80
0x3067:	ADD R1, R3
0x306a:	MOV R3, 120
0x306d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3070:	MOV R3, 98
0x3073:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3076:	MOV R3, 4
0x3079:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x307c:	MOV R3, 169
0x307f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3082:	MOV R3, 24
0x3085:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3088:	MOV R3, 19
0x308b:	ADD R1, R3
0x308e:	MOV R3, 155
0x3091:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3094:	MOV R3, 196
0x3097:	ADD R1, R3
0x309a:	MOV R3, 131
0x309d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30a0:	MOV R3, 74
0x30a3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30a6:	MOV R3, 130
0x30a9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30ac:	MOV R3, 11
0x30af:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30b2:	MOV R3, 206
0x30b5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30b8:	MOV R3, 212
0x30bb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30be:	MOV R3, 33
0x30c1:	ADD R1, R3
0x30c4:	MOV R3, 6
0x30c7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30ca:	MOV R3, 122
0x30cd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30d0:	MOV R3, 14
0x30d3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30d6:	MOV R3, 165
0x30d9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30dc:	MOV R3, 167
0x30df:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30e2:	MOV R3, 1
0x30e5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30e8:	MOV R3, 44
0x30eb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30ee:	MOV R3, 18
0x30f1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30f4:	MOV R3, 79
0x30f7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x30fa:	MOV R3, 220
0x30fd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3100:	MOV R3, 14
0x3103:	ADD R1, R3
0x3106:	MOV R3, 166
0x3109:	ADD R1, R3
0x310c:	MOV R3, 83
0x310f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3112:	MOV R3, 98
0x3115:	ADD R1, R3
0x3118:	MOV R3, 197
0x311b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x311e:	MOV R3, 232
0x3121:	ADD R1, R3
0x3124:	MOV R3, 240
0x3127:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x312a:	MOV R3, 25
0x312d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3130:	MOV R3, 168
0x3133:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3136:	MOV R3, 60
0x3139:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x313c:	MOV R3, 212
0x313f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3142:	MOV R3, 37
0x3145:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3148:	MOV R3, 190
0x314b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x314e:	MOV R3, 167
0x3151:	ADD R1, R3
0x3154:	MOV R3, 55
0x3157:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x315a:	MOV R3, 206
0x315d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3160:	MOV R3, 24
0x3163:	ADD R1, R3
0x3166:	MOV R3, 36
0x3169:	ADD R1, R3
0x316c:	MOV R3, 119
0x316f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3172:	MOV R3, 195
0x3175:	ADD R1, R3
0x3178:	MOV R3, 209
0x317b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x317e:	MOV R3, 83
0x3181:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3184:	MOV R3, 7
0x3187:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x318a:	MOV R3, 6
0x318d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3190:	MOV R3, 203
0x3193:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3196:	MOV R3, 118
0x3199:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x319c:	MOV R3, 208
0x319f:	ADD R1, R3
0x31a2:	MOV R3, 37
0x31a5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31a8:	MOV R3, 60
0x31ab:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31ae:	MOV R3, 30
0x31b1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31b4:	MOV R3, 207
0x31b7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31ba:	MOV R3, 68
0x31bd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31c0:	MOV R3, 76
0x31c3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31c6:	MOV R3, 68
0x31c9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31cc:	MOV R3, 194
0x31cf:	ADD R1, R3
0x31d2:	MOV R3, 39
0x31d5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31d8:	MOV R3, 210
0x31db:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31de:	MOV R3, 128
0x31e1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31e4:	MOV R3, 86
0x31e7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31ea:	MOV R3, 60
0x31ed:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31f0:	MOV R3, 165
0x31f3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31f6:	MOV R3, 255
0x31f9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x31fc:	MOV R3, 24
0x31ff:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3202:	MOV R3, 151
0x3205:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3208:	MOV R3, 19
0x320b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x320e:	MOV R3, 139
0x3211:	ADD R1, R3
0x3214:	MOV R3, 57
0x3217:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x321a:	MOV R3, 141
0x321d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3220:	MOV R3, 8
0x3223:	ADD R1, R3
0x3226:	MOV R3, 118
0x3229:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x322c:	MOV R3, 122
0x322f:	ADD R1, R3
0x3232:	MOV R3, 136
0x3235:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3238:	MOV R3, 254
0x323b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x323e:	MOV R3, 78
0x3241:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3244:	MOV R3, 75
0x3247:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x324a:	MOV R3, 73
0x324d:	ADD R1, R3
0x3250:	MOV R3, 94
0x3253:	ADD R1, R3
0x3256:	MOV R3, 134
0x3259:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x325c:	MOV R3, 255
0x325f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3262:	MOV R3, 57
0x3265:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3268:	MOV R3, 253
0x326b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x326e:	MOV R3, 16
0x3271:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3274:	MOV R3, 115
0x3277:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x327a:	MOV R3, 24
0x327d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3280:	MOV R3, 57
0x3283:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3286:	MOV R3, 251
0x3289:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x328c:	MOV R3, 207
0x328f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3292:	MOV R3, 144
0x3295:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3298:	MOV R3, 65
0x329b:	ADD R1, R3
0x329e:	MOV R3, 2
0x32a1:	ADD R1, R3
0x32a4:	MOV R3, 45
0x32a7:	ADD R1, R3
0x32aa:	MOV R3, 164
0x32ad:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32b0:	MOV R3, 213
0x32b3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32b6:	MOV R3, 67
0x32b9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32bc:	MOV R3, 48
0x32bf:	ADD R1, R3
0x32c2:	MOV R3, 108
0x32c5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32c8:	MOV R3, 132
0x32cb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32ce:	MOV R3, 3
0x32d1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32d4:	MOV R3, 59
0x32d7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32da:	MOV R3, 14
0x32dd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32e0:	MOV R3, 55
0x32e3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32e6:	MOV R3, 102
0x32e9:	ADD R1, R3
0x32ec:	MOV R3, 16
0x32ef:	ADD R1, R3
0x32f2:	MOV R3, 36
0x32f5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x32f8:	MOV R3, 69
0x32fb:	ADD R1, R3
0x32fe:	MOV R3, 86
0x3301:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3304:	MOV R3, 46
0x3307:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x330a:	MOV R3, 75
0x330d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3310:	MOV R3, 192
0x3313:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3316:	MOV R3, 65
0x3319:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x331c:	MOV R3, 147
0x331f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3322:	MOV R3, 129
0x3325:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3328:	MOV R3, 59
0x332b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x332e:	MOV R3, 167
0x3331:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3334:	MOV R3, 161
0x3337:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x333a:	MOV R3, 53
0x333d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3340:	MOV R3, 216
0x3343:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3346:	MOV R3, 226
0x3349:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x334c:	MOV R3, 91
0x334f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3352:	MOV R3, 83
0x3355:	ADD R1, R3
0x3358:	MOV R3, 20
0x335b:	ADD R1, R3
0x335e:	MOV R3, 137
0x3361:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3364:	MOV R3, 181
0x3367:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x336a:	MOV R3, 200
0x336d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3370:	MOV R3, 84
0x3373:	ADD R1, R3
0x3376:	MOV R3, 160
0x3379:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x337c:	MOV R3, 62
0x337f:	ADD R1, R3
0x3382:	MOV R3, 134
0x3385:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3388:	MOV R3, 47
0x338b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x338e:	MOV R3, 60
0x3391:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3394:	MOV R3, 67
0x3397:	ADD R1, R3
0x339a:	MOV R3, 86
0x339d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33a0:	MOV R3, 6
0x33a3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33a6:	MOV R3, 88
0x33a9:	ADD R1, R3
0x33ac:	MOV R3, 156
0x33af:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33b2:	MOV R3, 45
0x33b5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33b8:	MOV R3, 234
0x33bb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33be:	MOV R3, 153
0x33c1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33c4:	MOV R5, 52
0x33c7:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x33ca:	JNZ 0x33d2
0x33cc:	MOV R2, 1
0x33cf:	ADD R6, R2
0x33d2:	MOV R2, 13
0x33d5:	MOV R1, BYTE PTR [R4 + R2]
0x33d9:	MOV R3, 100
0x33dc:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33df:	MOV R3, 172
0x33e2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33e5:	MOV R3, 64
0x33e8:	ADD R1, R3
0x33eb:	MOV R3, 69
0x33ee:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33f1:	MOV R3, 231
0x33f4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x33f7:	MOV R3, 145
0x33fa:	ADD R1, R3
0x33fd:	MOV R3, 0
0x3400:	ADD R1, R3
0x3403:	MOV R3, 14
0x3406:	ADD R1, R3
0x3409:	MOV R3, 158
0x340c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x340f:	MOV R3, 121
0x3412:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3415:	MOV R3, 66
0x3418:	ADD R1, R3
0x341b:	MOV R3, 4
0x341e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3421:	MOV R3, 8
0x3424:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3427:	MOV R3, 12
0x342a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x342d:	MOV R3, 112
0x3430:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3433:	MOV R3, 130
0x3436:	ADD R1, R3
0x3439:	MOV R3, 3
0x343c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x343f:	MOV R3, 33
0x3442:	ADD R1, R3
0x3445:	MOV R3, 5
0x3448:	ADD R1, R3
0x344b:	MOV R3, 117
0x344e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3451:	MOV R3, 173
0x3454:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3457:	MOV R3, 231
0x345a:	ADD R1, R3
0x345d:	MOV R3, 96
0x3460:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3463:	MOV R3, 96
0x3466:	ADD R1, R3
0x3469:	MOV R3, 98
0x346c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x346f:	MOV R3, 90
0x3472:	ADD R1, R3
0x3475:	MOV R3, 23
0x3478:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x347b:	MOV R3, 92
0x347e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3481:	MOV R3, 123
0x3484:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3487:	MOV R3, 34
0x348a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x348d:	MOV R3, 142
0x3490:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3493:	MOV R3, 93
0x3496:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3499:	MOV R3, 177
0x349c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x349f:	MOV R3, 124
0x34a2:	ADD R1, R3
0x34a5:	MOV R3, 57
0x34a8:	ADD R1, R3
0x34ab:	MOV R3, 240
0x34ae:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34b1:	MOV R3, 137
0x34b4:	ADD R1, R3
0x34b7:	MOV R3, 95
0x34ba:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34bd:	MOV R3, 57
0x34c0:	ADD R1, R3
0x34c3:	MOV R3, 43
0x34c6:	ADD R1, R3
0x34c9:	MOV R3, 143
0x34cc:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34cf:	MOV R3, 38
0x34d2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34d5:	MOV R3, 193
0x34d8:	ADD R1, R3
0x34db:	MOV R3, 169
0x34de:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34e1:	MOV R3, 73
0x34e4:	ADD R1, R3
0x34e7:	MOV R3, 33
0x34ea:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34ed:	MOV R3, 139
0x34f0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34f3:	MOV R3, 195
0x34f6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34f9:	MOV R3, 159
0x34fc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x34ff:	MOV R3, 138
0x3502:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3505:	MOV R3, 193
0x3508:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x350b:	MOV R3, 9
0x350e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3511:	MOV R3, 55
0x3514:	ADD R1, R3
0x3517:	MOV R3, 135
0x351a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x351d:	MOV R3, 39
0x3520:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3523:	MOV R3, 64
0x3526:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3529:	MOV R3, 81
0x352c:	ADD R1, R3
0x352f:	MOV R3, 236
0x3532:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3535:	MOV R3, 147
0x3538:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x353b:	MOV R3, 155
0x353e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3541:	MOV R3, 111
0x3544:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3547:	MOV R3, 105
0x354a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x354d:	MOV R3, 173
0x3550:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3553:	MOV R3, 74
0x3556:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3559:	MOV R3, 129
0x355c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x355f:	MOV R3, 138
0x3562:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3565:	MOV R3, 164
0x3568:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x356b:	MOV R3, 255
0x356e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3571:	MOV R3, 239
0x3574:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3577:	MOV R3, 5
0x357a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x357d:	MOV R3, 7
0x3580:	ADD R1, R3
0x3583:	MOV R3, 4
0x3586:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3589:	MOV R3, 124
0x358c:	ADD R1, R3
0x358f:	MOV R3, 194
0x3592:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3595:	MOV R3, 132
0x3598:	ADD R1, R3
0x359b:	MOV R3, 238
0x359e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35a1:	MOV R3, 132
0x35a4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35a7:	MOV R3, 158
0x35aa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35ad:	MOV R3, 81
0x35b0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35b3:	MOV R3, 109
0x35b6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35b9:	MOV R3, 146
0x35bc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35bf:	MOV R3, 125
0x35c2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35c5:	MOV R3, 107
0x35c8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35cb:	MOV R3, 36
0x35ce:	ADD R1, R3
0x35d1:	MOV R3, 1
0x35d4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35d7:	MOV R3, 97
0x35da:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35dd:	MOV R3, 59
0x35e0:	ADD R1, R3
0x35e3:	MOV R3, 82
0x35e6:	ADD R1, R3
0x35e9:	MOV R3, 115
0x35ec:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x35ef:	MOV R3, 45
0x35f2:	ADD R1, R3
0x35f5:	MOV R3, 32
0x35f8:	ADD R1, R3
0x35fb:	MOV R3, 147
0x35fe:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3601:	MOV R3, 148
0x3604:	ADD R1, R3
0x3607:	MOV R3, 30
0x360a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x360d:	MOV R3, 254
0x3610:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3613:	MOV R3, 26
0x3616:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3619:	MOV R3, 32
0x361c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x361f:	MOV R3, 168
0x3622:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3625:	MOV R3, 2
0x3628:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x362b:	MOV R3, 216
0x362e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3631:	MOV R3, 173
0x3634:	ADD R1, R3
0x3637:	MOV R3, 130
0x363a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x363d:	MOV R3, 90
0x3640:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3643:	MOV R3, 120
0x3646:	ADD R1, R3
0x3649:	MOV R3, 163
0x364c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x364f:	MOV R3, 131
0x3652:	ADD R1, R3
0x3655:	MOV R3, 114
0x3658:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x365b:	MOV R3, 35
0x365e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3661:	MOV R3, 160
0x3664:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3667:	MOV R3, 254
0x366a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x366d:	MOV R3, 117
0x3670:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3673:	MOV R3, 67
0x3676:	ADD R1, R3
0x3679:	MOV R3, 32
0x367c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x367f:	MOV R3, 11
0x3682:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3685:	MOV R3, 227
0x3688:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x368b:	MOV R3, 240
0x368e:	ADD R1, R3
0x3691:	MOV R3, 233
0x3694:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3697:	MOV R3, 51
0x369a:	ADD R1, R3
0x369d:	MOV R3, 173
0x36a0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36a3:	MOV R3, 74
0x36a6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36a9:	MOV R3, 16
0x36ac:	ADD R1, R3
0x36af:	MOV R3, 32
0x36b2:	ADD R1, R3
0x36b5:	MOV R3, 105
0x36b8:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36bb:	MOV R3, 98
0x36be:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36c1:	MOV R3, 209
0x36c4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36c7:	MOV R3, 24
0x36ca:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36cd:	MOV R3, 125
0x36d0:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36d3:	MOV R3, 110
0x36d6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36d9:	MOV R3, 185
0x36dc:	ADD R1, R3
0x36df:	MOV R3, 205
0x36e2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36e5:	MOV R3, 2
0x36e8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36eb:	MOV R3, 140
0x36ee:	ADD R1, R3
0x36f1:	MOV R3, 235
0x36f4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36f7:	MOV R3, 165
0x36fa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x36fd:	MOV R3, 130
0x3700:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3703:	MOV R3, 135
0x3706:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3709:	MOV R3, 239
0x370c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x370f:	MOV R3, 134
0x3712:	ADD R1, R3
0x3715:	MOV R3, 112
0x3718:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x371b:	MOV R3, 105
0x371e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3721:	MOV R3, 43
0x3724:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3727:	MOV R3, 86
0x372a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x372d:	MOV R3, 253
0x3730:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3733:	MOV R3, 108
0x3736:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3739:	MOV R3, 74
0x373c:	ADD R1, R3
0x373f:	MOV R3, 148
0x3742:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3745:	MOV R3, 17
0x3748:	ADD R1, R3
0x374b:	MOV R3, 198
0x374e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3751:	MOV R3, 193
0x3754:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3757:	MOV R3, 76
0x375a:	ADD R1, R3
0x375d:	MOV R3, 4
0x3760:	ADD R1, R3
0x3763:	MOV R3, 101
0x3766:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3769:	MOV R3, 4
0x376c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x376f:	MOV R3, 235
0x3772:	ADD R1, R3
0x3775:	MOV R3, 107
0x3778:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x377b:	MOV R3, 156
0x377e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3781:	MOV R3, 48
0x3784:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3787:	MOV R3, 47
0x378a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x378d:	MOV R3, 127
0x3790:	ADD R1, R3
0x3793:	MOV R3, 11
0x3796:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3799:	MOV R3, 236
0x379c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x379f:	MOV R3, 143
0x37a2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37a5:	MOV R3, 165
0x37a8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37ab:	MOV R3, 251
0x37ae:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37b1:	MOV R3, 149
0x37b4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37b7:	MOV R3, 119
0x37ba:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37bd:	MOV R3, 119
0x37c0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37c3:	MOV R3, 106
0x37c6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37c9:	MOV R3, 239
0x37cc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37cf:	MOV R3, 151
0x37d2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37d5:	MOV R3, 139
0x37d8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37db:	MOV R3, 187
0x37de:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37e1:	MOV R3, 18
0x37e4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37e7:	MOV R3, 18
0x37ea:	ADD R1, R3
0x37ed:	MOV R3, 27
0x37f0:	ADD R1, R3
0x37f3:	MOV R3, 108
0x37f6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37f9:	MOV R3, 165
0x37fc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x37ff:	MOV R3, 148
0x3802:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3805:	MOV R3, 127
0x3808:	ADD R1, R3
0x380b:	MOV R3, 221
0x380e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3811:	MOV R3, 51
0x3814:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3817:	MOV R3, 236
0x381a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x381d:	MOV R3, 142
0x3820:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3823:	MOV R3, 93
0x3826:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3829:	MOV R3, 236
0x382c:	ADD R1, R3
0x382f:	MOV R3, 240
0x3832:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3835:	MOV R3, 152
0x3838:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x383b:	MOV R3, 82
0x383e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3841:	MOV R3, 17
0x3844:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3847:	MOV R3, 159
0x384a:	ADD R1, R3
0x384d:	MOV R3, 254
0x3850:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3853:	MOV R3, 175
0x3856:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3859:	MOV R3, 41
0x385c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x385f:	MOV R3, 41
0x3862:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3865:	MOV R3, 167
0x3868:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x386b:	MOV R3, 135
0x386e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3871:	MOV R3, 150
0x3874:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3877:	MOV R3, 123
0x387a:	ADD R1, R3
0x387d:	MOV R3, 251
0x3880:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3883:	MOV R3, 87
0x3886:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3889:	MOV R3, 62
0x388c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x388f:	MOV R3, 187
0x3892:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3895:	MOV R3, 80
0x3898:	ADD R1, R3
0x389b:	MOV R3, 93
0x389e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38a1:	MOV R3, 105
0x38a4:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38a7:	MOV R3, 105
0x38aa:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38ad:	MOV R3, 50
0x38b0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38b3:	MOV R3, 79
0x38b6:	ADD R1, R3
0x38b9:	MOV R3, 77
0x38bc:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38bf:	MOV R3, 70
0x38c2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38c5:	MOV R3, 6
0x38c8:	ADD R1, R3
0x38cb:	MOV R3, 63
0x38ce:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38d1:	MOV R3, 83
0x38d4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38d7:	MOV R3, 195
0x38da:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38dd:	MOV R3, 49
0x38e0:	ADD R1, R3
0x38e3:	MOV R3, 55
0x38e6:	ADD R1, R3
0x38e9:	MOV R3, 201
0x38ec:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38ef:	MOV R3, 64
0x38f2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38f5:	MOV R3, 78
0x38f8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x38fb:	MOV R3, 90
0x38fe:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3901:	MOV R3, 35
0x3904:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3907:	MOV R3, 95
0x390a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x390d:	MOV R3, 54
0x3910:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3913:	MOV R3, 68
0x3916:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3919:	MOV R3, 51
0x391c:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x391f:	MOV R3, 85
0x3922:	ADD R1, R3
0x3925:	MOV R3, 30
0x3928:	ADD R1, R3
0x392b:	MOV R3, 204
0x392e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3931:	MOV R3, 61
0x3934:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3937:	MOV R3, 52
0x393a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x393d:	MOV R3, 84
0x3940:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3943:	MOV R3, 138
0x3946:	ADD R1, R3
0x3949:	MOV R3, 39
0x394c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x394f:	MOV R3, 246
0x3952:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3955:	MOV R3, 28
0x3958:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x395b:	MOV R3, 119
0x395e:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3961:	MOV R3, 196
0x3964:	ADD R1, R3
0x3967:	MOV R3, 116
0x396a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x396d:	MOV R3, 43
0x3970:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3973:	MOV R3, 159
0x3976:	ADD R1, R3
0x3979:	MOV R3, 171
0x397c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x397f:	MOV R3, 225
0x3982:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3985:	MOV R3, 118
0x3988:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x398b:	MOV R3, 58
0x398e:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3991:	MOV R3, 132
0x3994:	ADD R1, R3
0x3997:	MOV R3, 104
0x399a:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x399d:	MOV R3, 42
0x39a0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39a3:	MOV R3, 37
0x39a6:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39a9:	MOV R3, 247
0x39ac:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39af:	MOV R3, 82
0x39b2:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39b5:	MOV R3, 119
0x39b8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39bb:	MOV R3, 147
0x39be:	ADD R1, R3
0x39c1:	MOV R3, 21
0x39c4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39c7:	MOV R3, 58
0x39ca:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39cd:	MOV R3, 14
0x39d0:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39d3:	MOV R3, 32
0x39d6:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39d9:	MOV R3, 84
0x39dc:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39df:	MOV R3, 121
0x39e2:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39e5:	MOV R3, 152
0x39e8:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39eb:	MOV R3, 120
0x39ee:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39f1:	MOV R3, 61
0x39f4:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39f7:	MOV R3, 47
0x39fa:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x39fd:	MOV R3, 4
0x3a00:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a03:	MOV R3, 116
0x3a06:	ADD R1, R3
0x3a09:	MOV R3, 4
0x3a0c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a0f:	MOV R3, 15
0x3a12:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a15:	MOV R3, 184
0x3a18:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a1b:	MOV R3, 161
0x3a1e:	ADD R1, R3
0x3a21:	MOV R3, 143
0x3a24:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a27:	MOV R3, 212
0x3a2a:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a2d:	MOV R3, 42
0x3a30:	ADD R1, R3
0x3a33:	MOV R3, 32
0x3a36:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a39:	MOV R3, 222
0x3a3c:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a3f:	MOV R3, 93
0x3a42:	ADD R1, R3
0x3a45:	MOV R3, 25
0x3a48:	ADD R1, R3
0x3a4b:	MOV R3, 12
0x3a4e:	ADD R1, R3
0x3a51:	MOV R3, 192
0x3a54:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a57:	MOV R5, 74
0x3a5a:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x3a5d:	JNZ 0x3a65
0x3a5f:	MOV R2, 1
0x3a62:	ADD R6, R2
0x3a65:	MOV R2, 14
0x3a68:	MOV R1, BYTE PTR [R4 + R2]
0x3a6c:	MOV R3, 124
0x3a6f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a72:	MOV R3, 129
0x3a75:	ADD R1, R3
0x3a78:	MOV R3, 11
0x3a7b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a7e:	MOV R3, 214
0x3a81:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a84:	MOV R3, 196
0x3a87:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a8a:	MOV R3, 132
0x3a8d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a90:	MOV R3, 227
0x3a93:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a96:	MOV R3, 218
0x3a99:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3a9c:	MOV R3, 15
0x3a9f:	ADD R1, R3
0x3aa2:	MOV R3, 46
0x3aa5:	ADD R1, R3
0x3aa8:	MOV R3, 110
0x3aab:	ADD R1, R3
0x3aae:	MOV R3, 11
0x3ab1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ab4:	MOV R3, 76
0x3ab7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3aba:	MOV R3, 42
0x3abd:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ac0:	MOV R3, 204
0x3ac3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ac6:	MOV R3, 103
0x3ac9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3acc:	MOV R3, 7
0x3acf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ad2:	MOV R3, 3
0x3ad5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ad8:	MOV R3, 137
0x3adb:	ADD R1, R3
0x3ade:	MOV R3, 128
0x3ae1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ae4:	MOV R3, 121
0x3ae7:	ADD R1, R3
0x3aea:	MOV R3, 239
0x3aed:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3af0:	MOV R3, 74
0x3af3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3af6:	MOV R3, 173
0x3af9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3afc:	MOV R3, 207
0x3aff:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b02:	MOV R3, 227
0x3b05:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b08:	MOV R3, 218
0x3b0b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b0e:	MOV R3, 98
0x3b11:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b14:	MOV R3, 97
0x3b17:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b1a:	MOV R3, 127
0x3b1d:	ADD R1, R3
0x3b20:	MOV R3, 36
0x3b23:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b26:	MOV R3, 26
0x3b29:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b2c:	MOV R3, 174
0x3b2f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b32:	MOV R3, 51
0x3b35:	ADD R1, R3
0x3b38:	MOV R3, 17
0x3b3b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b3e:	MOV R3, 86
0x3b41:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b44:	MOV R3, 131
0x3b47:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b4a:	MOV R3, 168
0x3b4d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b50:	MOV R3, 58
0x3b53:	ADD R1, R3
0x3b56:	MOV R3, 202
0x3b59:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b5c:	MOV R3, 27
0x3b5f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b62:	MOV R3, 41
0x3b65:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b68:	MOV R3, 157
0x3b6b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b6e:	MOV R3, 121
0x3b71:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b74:	MOV R3, 94
0x3b77:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b7a:	MOV R3, 212
0x3b7d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b80:	MOV R3, 221
0x3b83:	ADD R1, R3
0x3b86:	MOV R3, 127
0x3b89:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b8c:	MOV R3, 193
0x3b8f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b92:	MOV R3, 49
0x3b95:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b98:	MOV R3, 193
0x3b9b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3b9e:	MOV R3, 100
0x3ba1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ba4:	MOV R3, 90
0x3ba7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3baa:	MOV R3, 16
0x3bad:	ADD R1, R3
0x3bb0:	MOV R3, 62
0x3bb3:	ADD R1, R3
0x3bb6:	MOV R3, 77
0x3bb9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bbc:	MOV R3, 83
0x3bbf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bc2:	MOV R3, 82
0x3bc5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bc8:	MOV R3, 113
0x3bcb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bce:	MOV R3, 146
0x3bd1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bd4:	MOV R3, 117
0x3bd7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bda:	MOV R3, 18
0x3bdd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3be0:	MOV R3, 129
0x3be3:	ADD R1, R3
0x3be6:	MOV R3, 170
0x3be9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bec:	MOV R3, 32
0x3bef:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bf2:	MOV R3, 133
0x3bf5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bf8:	MOV R3, 198
0x3bfb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3bfe:	MOV R3, 21
0x3c01:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c04:	MOV R3, 106
0x3c07:	ADD R1, R3
0x3c0a:	MOV R3, 139
0x3c0d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c10:	MOV R3, 120
0x3c13:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c16:	MOV R3, 227
0x3c19:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c1c:	MOV R3, 131
0x3c1f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c22:	MOV R3, 158
0x3c25:	ADD R1, R3
0x3c28:	MOV R3, 111
0x3c2b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c2e:	MOV R3, 92
0x3c31:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c34:	MOV R3, 21
0x3c37:	ADD R1, R3
0x3c3a:	MOV R3, 58
0x3c3d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c40:	MOV R3, 14
0x3c43:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c46:	MOV R3, 180
0x3c49:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c4c:	MOV R3, 35
0x3c4f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c52:	MOV R3, 187
0x3c55:	ADD R1, R3
0x3c58:	MOV R3, 216
0x3c5b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c5e:	MOV R3, 196
0x3c61:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c64:	MOV R3, 149
0x3c67:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c6a:	MOV R3, 135
0x3c6d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c70:	MOV R3, 238
0x3c73:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c76:	MOV R3, 165
0x3c79:	ADD R1, R3
0x3c7c:	MOV R3, 201
0x3c7f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c82:	MOV R3, 33
0x3c85:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c88:	MOV R3, 141
0x3c8b:	ADD R1, R3
0x3c8e:	MOV R3, 93
0x3c91:	ADD R1, R3
0x3c94:	MOV R3, 120
0x3c97:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3c9a:	MOV R3, 15
0x3c9d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ca0:	MOV R3, 32
0x3ca3:	ADD R1, R3
0x3ca6:	MOV R3, 1
0x3ca9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3cac:	MOV R3, 31
0x3caf:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3cb2:	MOV R3, 5
0x3cb5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3cb8:	MOV R3, 7
0x3cbb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3cbe:	MOV R3, 129
0x3cc1:	ADD R1, R3
0x3cc4:	MOV R3, 116
0x3cc7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3cca:	MOV R3, 214
0x3ccd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3cd0:	MOV R3, 224
0x3cd3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3cd6:	MOV R3, 27
0x3cd9:	ADD R1, R3
0x3cdc:	MOV R3, 37
0x3cdf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ce2:	MOV R3, 79
0x3ce5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ce8:	MOV R3, 73
0x3ceb:	ADD R1, R3
0x3cee:	MOV R3, 80
0x3cf1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3cf4:	MOV R3, 230
0x3cf7:	ADD R1, R3
0x3cfa:	MOV R3, 255
0x3cfd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d00:	MOV R3, 167
0x3d03:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d06:	MOV R3, 100
0x3d09:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d0c:	MOV R3, 110
0x3d0f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d12:	MOV R3, 166
0x3d15:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d18:	MOV R3, 178
0x3d1b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d1e:	MOV R3, 119
0x3d21:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d24:	MOV R3, 98
0x3d27:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d2a:	MOV R3, 8
0x3d2d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d30:	MOV R5, 78
0x3d33:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x3d36:	JNZ 0x3d3e
0x3d38:	MOV R2, 1
0x3d3b:	ADD R6, R2
0x3d3e:	MOV R2, 15
0x3d41:	MOV R1, BYTE PTR [R4 + R2]
0x3d45:	MOV R2, 8
0x3d48:	SHL R1, R2
0x3d4b:	MOV R2, 16
0x3d4e:	MOV R3, BYTE PTR [R4 + R2]
0x3d52:	ADD R1, R3
0x3d55:	MOV R2, 8
0x3d58:	SHL R1, R2
0x3d5b:	MOV R2, 17
0x3d5e:	MOV R3, BYTE PTR [R4 + R2]
0x3d62:	ADD R1, R3
0x3d65:	MOV R2, 8
0x3d68:	SHL R1, R2
0x3d6b:	MOV R2, 18
0x3d6e:	MOV R3, BYTE PTR [R4 + R2]
0x3d72:	ADD R1, R3
0x3d75:	MOV R2, 0
0x3d78:	MOV R3, [ADDR+5]
0x3d7b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3d7e:	MOV R3, [ADDR+4]
0x3d81:	PUSH R3
0x3d83:	PUSH R1
0x3d85:	MOV R1, [ADDR+0]
0x3d88:	CALL R1
0x3d8a:	MOV R1, EAX
0x3d8c:	ADD R6, R1
0x3d8f:	MOV R2, 19
0x3d92:	MOV R1, BYTE PTR [R4 + R2]
0x3d96:	MOV R3, 129
0x3d99:	ADD R1, R3
0x3d9c:	MOV R3, 209
0x3d9f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3da2:	MOV R3, 38
0x3da5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3da8:	MOV R3, 51
0x3dab:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3dae:	MOV R3, 250
0x3db1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3db4:	MOV R3, 98
0x3db7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3dba:	MOV R3, 19
0x3dbd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3dc0:	MOV R3, 15
0x3dc3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3dc6:	MOV R3, 106
0x3dc9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3dcc:	MOV R3, 139
0x3dcf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3dd2:	MOV R3, 99
0x3dd5:	ADD R1, R3
0x3dd8:	MOV R3, 47
0x3ddb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3dde:	MOV R3, 144
0x3de1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3de4:	MOV R3, 11
0x3de7:	ADD R1, R3
0x3dea:	MOV R3, 35
0x3ded:	ADD R1, R3
0x3df0:	MOV R3, 26
0x3df3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3df6:	MOV R3, 63
0x3df9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3dfc:	MOV R3, 196
0x3dff:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e02:	MOV R3, 136
0x3e05:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e08:	MOV R3, 131
0x3e0b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e0e:	MOV R3, 111
0x3e11:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e14:	MOV R3, 151
0x3e17:	ADD R1, R3
0x3e1a:	MOV R3, 115
0x3e1d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e20:	MOV R3, 31
0x3e23:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e26:	MOV R3, 210
0x3e29:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e2c:	MOV R3, 49
0x3e2f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e32:	MOV R3, 138
0x3e35:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e38:	MOV R3, 107
0x3e3b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e3e:	MOV R3, 206
0x3e41:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e44:	MOV R3, 104
0x3e47:	ADD R1, R3
0x3e4a:	MOV R3, 56
0x3e4d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e50:	MOV R3, 142
0x3e53:	ADD R1, R3
0x3e56:	MOV R3, 177
0x3e59:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e5c:	MOV R3, 180
0x3e5f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e62:	MOV R3, 198
0x3e65:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e68:	MOV R3, 106
0x3e6b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e6e:	MOV R3, 129
0x3e71:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e74:	MOV R3, 241
0x3e77:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e7a:	MOV R3, 103
0x3e7d:	ADD R1, R3
0x3e80:	MOV R3, 208
0x3e83:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e86:	MOV R3, 75
0x3e89:	ADD R1, R3
0x3e8c:	MOV R3, 67
0x3e8f:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e92:	MOV R3, 19
0x3e95:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e98:	MOV R3, 103
0x3e9b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3e9e:	MOV R3, 180
0x3ea1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ea4:	MOV R3, 18
0x3ea7:	ADD R1, R3
0x3eaa:	MOV R3, 27
0x3ead:	ADD R1, R3
0x3eb0:	MOV R3, 70
0x3eb3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3eb6:	MOV R3, 66
0x3eb9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ebc:	MOV R3, 85
0x3ebf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ec2:	MOV R3, 79
0x3ec5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ec8:	MOV R3, 71
0x3ecb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ece:	MOV R3, 106
0x3ed1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ed4:	MOV R3, 55
0x3ed7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3eda:	MOV R3, 94
0x3edd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ee0:	MOV R3, 130
0x3ee3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ee6:	MOV R3, 85
0x3ee9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3eec:	MOV R3, 154
0x3eef:	ADD R1, R3
0x3ef2:	MOV R3, 251
0x3ef5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ef8:	MOV R3, 40
0x3efb:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3efe:	MOV R3, 252
0x3f01:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f04:	MOV R3, 168
0x3f07:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f0a:	MOV R3, 125
0x3f0d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f10:	MOV R3, 176
0x3f13:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f16:	MOV R3, 38
0x3f19:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f1c:	MOV R3, 44
0x3f1f:	ADD R1, R3
0x3f22:	MOV R3, 132
0x3f25:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f28:	MOV R3, 231
0x3f2b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f2e:	MOV R3, 44
0x3f31:	ADD R1, R3
0x3f34:	MOV R3, 49
0x3f37:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f3a:	MOV R3, 72
0x3f3d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f40:	MOV R3, 43
0x3f43:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f46:	MOV R3, 141
0x3f49:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f4c:	MOV R3, 235
0x3f4f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f52:	MOV R3, 145
0x3f55:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f58:	MOV R3, 4
0x3f5b:	ADD R1, R3
0x3f5e:	MOV R3, 81
0x3f61:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f64:	MOV R3, 18
0x3f67:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f6a:	MOV R3, 131
0x3f6d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f70:	MOV R3, 175
0x3f73:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f76:	MOV R3, 63
0x3f79:	ADD R1, R3
0x3f7c:	MOV R3, 183
0x3f7f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f82:	MOV R3, 215
0x3f85:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f88:	MOV R3, 53
0x3f8b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f8e:	MOV R3, 45
0x3f91:	ADD R1, R3
0x3f94:	MOV R3, 78
0x3f97:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3f9a:	MOV R3, 24
0x3f9d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3fa0:	MOV R3, 21
0x3fa3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3fa6:	MOV R3, 86
0x3fa9:	ADD R1, R3
0x3fac:	MOV R3, 91
0x3faf:	ADD R1, R3
0x3fb2:	MOV R3, 9
0x3fb5:	ADD R1, R3
0x3fb8:	MOV R3, 172
0x3fbb:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3fbe:	MOV R3, 33
0x3fc1:	ADD R1, R3
0x3fc4:	MOV R3, 44
0x3fc7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3fca:	MOV R3, 208
0x3fcd:	ADD R1, R3
0x3fd0:	MOV R3, 95
0x3fd3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3fd6:	MOV R3, 70
0x3fd9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3fdc:	MOV R3, 0
0x3fdf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3fe2:	MOV R3, 67
0x3fe5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3fe8:	MOV R3, 187
0x3feb:	ADD R1, R3
0x3fee:	MOV R3, 156
0x3ff1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ff4:	MOV R3, 29
0x3ff7:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x3ffa:	MOV R3, 197
0x3ffd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4000:	MOV R3, 169
0x4003:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4006:	MOV R3, 80
0x4009:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x400c:	MOV R3, 217
0x400f:	ADD R1, R3
0x4012:	MOV R3, 148
0x4015:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4018:	MOV R3, 49
0x401b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x401e:	MOV R3, 171
0x4021:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4024:	MOV R3, 4
0x4027:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x402a:	MOV R3, 64
0x402d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4030:	MOV R3, 92
0x4033:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4036:	MOV R3, 135
0x4039:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x403c:	MOV R3, 200
0x403f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4042:	MOV R3, 181
0x4045:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4048:	MOV R3, 164
0x404b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x404e:	MOV R3, 255
0x4051:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4054:	MOV R3, 232
0x4057:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x405a:	MOV R3, 188
0x405d:	ADD R1, R3
0x4060:	MOV R3, 208
0x4063:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4066:	MOV R3, 62
0x4069:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x406c:	MOV R3, 21
0x406f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4072:	MOV R3, 11
0x4075:	ADD R1, R3
0x4078:	MOV R3, 177
0x407b:	ADD R1, R3
0x407e:	MOV R3, 126
0x4081:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4084:	MOV R3, 85
0x4087:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x408a:	MOV R3, 130
0x408d:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4090:	MOV R3, 28
0x4093:	ADD R1, R3
0x4096:	MOV R3, 22
0x4099:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x409c:	MOV R3, 142
0x409f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40a2:	MOV R3, 91
0x40a5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40a8:	MOV R3, 68
0x40ab:	ADD R1, R3
0x40ae:	MOV R3, 79
0x40b1:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40b4:	MOV R3, 158
0x40b7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40ba:	MOV R3, 60
0x40bd:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40c0:	MOV R3, 73
0x40c3:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40c6:	MOV R3, 109
0x40c9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40cc:	MOV R3, 230
0x40cf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40d2:	MOV R3, 12
0x40d5:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40d8:	MOV R3, 174
0x40db:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40de:	MOV R3, 95
0x40e1:	ADD R1, R3
0x40e4:	MOV R3, 122
0x40e7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40ea:	MOV R3, 50
0x40ed:	ADD R1, R3
0x40f0:	MOV R3, 194
0x40f3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40f6:	MOV R3, 138
0x40f9:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x40fc:	MOV R3, 112
0x40ff:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4102:	MOV R3, 94
0x4105:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4108:	MOV R3, 56
0x410b:	ADD R1, R3
0x410e:	MOV R3, 53
0x4111:	ADD R1, R3
0x4114:	MOV R3, 194
0x4117:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x411a:	MOV R3, 186
0x411d:	ADD R1, R3
0x4120:	MOV R3, 20
0x4123:	ADD R1, R3
0x4126:	MOV R3, 147
0x4129:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x412c:	MOV R3, 150
0x412f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4132:	MOV R3, 26
0x4135:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4138:	MOV R3, 162
0x413b:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x413e:	MOV R3, 119
0x4141:	ADD R1, R3
0x4144:	MOV R3, 40
0x4147:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x414a:	MOV R3, 14
0x414d:	ADD R1, R3
0x4150:	MOV R3, 221
0x4153:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4156:	MOV R3, 245
0x4159:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x415c:	MOV R3, 16
0x415f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4162:	MOV R3, 70
0x4165:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4168:	MOV R3, 253
0x416b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x416e:	MOV R3, 71
0x4171:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4174:	MOV R3, 66
0x4177:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x417a:	MOV R3, 45
0x417d:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4180:	MOV R3, 137
0x4183:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4186:	MOV R3, 119
0x4189:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x418c:	MOV R3, 201
0x418f:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4192:	MOV R3, 104
0x4195:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x4198:	MOV R3, 129
0x419b:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x419e:	MOV R3, 166
0x41a1:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x41a4:	MOV R3, 64
0x41a7:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x41aa:	MOV R3, 167
0x41ad:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x41b0:	MOV R3, 129
0x41b3:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x41b6:	MOV R3, 169
0x41b9:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x41bc:	MOV R3, 147
0x41bf:	XOR R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x41c2:	MOV R3, 97
0x41c5:	SUB R1, R3 ; =0 -> flags=1; #0 -> flags=0
0x41c8:	MOV R5, 104
0x41cb:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x41ce:	JNZ 0x41d6
0x41d0:	MOV R2, 1
0x41d3:	ADD R6, R2
0x41d6:	MOV R2, 20
0x41d9:	MOV R1, BYTE PTR [R4 + R2]
0x41dd:	XOR R5, R5 ; =0 -> flags=1; #0 -> flags=0
0x41e0:	CMP R1, R5 ; equals=1, larger=0, lessthan=2
0x41e3:	JNZ 0x41eb
0x41e5:	MOV R2, 1
0x41e8:	ADD R6, R2
0x41eb:	MOV R3, [ADDR+4]
0x41ee:	PUSH R3
0x41f0:	MOV R1, 21
0x41f3:	CMP R1, R6 ; equals=1, larger=0, lessthan=2
0x41f6:	JZ 0x41fd
0x41f8:	MOV R3, [ADDR+2]
0x41fb:	JMP 0x4200
0x41fd:	MOV R3, [ADDR+3]
0x4200:	CALL R3
