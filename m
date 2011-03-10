From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 30802] exception & eSATA hard link resets
Date: Thu, 10 Mar 2011 10:21:18 GMT
Message-ID: <201103101021.p2AALIHt004628@demeter1.kernel.org>
References: <bug-30802-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter1.kernel.org ([140.211.167.39]:43185 "EHLO
	demeter1.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab1CJKVT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Mar 2011 05:21:19 -0500
Received: from demeter1.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter1.kernel.org (8.14.4/8.14.3) with ESMTP id p2AALIGL004631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Thu, 10 Mar 2011 10:21:18 GMT
In-Reply-To: <bug-30802-11633@https.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=30802





--- Comment #5 from Anonymous Emailer <anonymous@kernel-bugs.osdl.org>  2011-03-10 10:21:14 ---
Reply-To: zrubish@googlemail.com

I've checked my answer.
test:
- large files are copied to eSATA connected disk (meanwhile I've checked the
cables - moved a bit while copying was in progress and it had no impact - no
reset during that period)
- after many "hard link resets" the connection finally crashes (lost page)
- disk is switched off & on
- connection seems to be established for few seconds, but then resets (fs
has not been mounted after that - at least, I did not try to) and work with
the disk is impossible after that.


Here is the log:

Mar 10 11:08:59 think kernel: [11175.740129] ata6: hard resetting link
Mar 10 11:09:02 think kernel: [11179.079216] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:02 think kernel: [11179.085015] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:02 think kernel: [11179.109623] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:02 think kernel: [11179.113161] ata6.00: configured for UDMA/33
Mar 10 11:09:02 think kernel: [11179.129241] ata6: EH complete
Mar 10 11:09:02 think kernel: [11179.212399] ata6: hard resetting link
Mar 10 11:09:05 think kernel: [11182.537511] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:05 think kernel: [11182.542964] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:05 think kernel: [11182.565409] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:05 think kernel: [11182.569360] ata6.00: configured for UDMA/33
Mar 10 11:09:05 think kernel: [11182.587467] ata6: EH complete
Mar 10 11:09:06 think kernel: [11182.698541] ata6: hard resetting link
Mar 10 11:09:09 think kernel: [11186.025687] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:09 think kernel: [11186.032309] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:09 think kernel: [11186.036834] ata6.00: failed to read native
max address (err_mask=0x100)
Mar 10 11:09:09 think kernel: [11186.036839] ata6.00: HPA support seems
broken, skipping HPA handling
Mar 10 11:09:14 think kernel: [11191.023150] ata6: hard resetting link
Mar 10 11:09:14 think kernel: [11191.372977] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:14 think kernel: [11191.376316] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:14 think kernel: [11191.383139] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:14 think kernel: [11191.386158] ata6.00: configured for UDMA/33
Mar 10 11:09:14 think kernel: [11191.403016] ata6: EH complete
Mar 10 11:09:22 think kernel: [11199.269021] ata6: hard resetting link
Mar 10 11:09:25 think kernel: [11202.617252] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:25 think kernel: [11202.625230] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:25 think kernel: [11202.632379] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:25 think kernel: [11202.635396] ata6.00: configured for UDMA/33
Mar 10 11:09:25 think kernel: [11202.635400] ata6.00: retrying FLUSH 0xea
Emask 0x10
Mar 10 11:09:25 think kernel: [11202.647178] ata6: EH complete
Mar 10 11:09:26 think kernel: [11202.676248] ata6: hard resetting link
Mar 10 11:09:29 think kernel: [11206.055580] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:29 think kernel: [11206.059182] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:29 think kernel: [11206.067332] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:29 think kernel: [11206.071322] ata6.00: configured for UDMA/33
Mar 10 11:09:29 think kernel: [11206.085627] ata6: EH complete
Mar 10 11:09:29 think kernel: [11206.096685] ata6: hard resetting link
Mar 10 11:09:32 think kernel: [11209.483767] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:32 think kernel: [11209.487399] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:32 think kernel: [11209.495411] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:32 think kernel: [11209.499386] ata6.00: configured for UDMA/33
Mar 10 11:09:32 think kernel: [11209.513932] ata6: EH complete
Mar 10 11:09:37 think kernel: [11214.460238] ata6: hard resetting link
Mar 10 11:09:41 think kernel: [11217.839611] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:41 think kernel: [11217.843020] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:41 think kernel: [11217.850325] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:41 think kernel: [11217.853379] ata6.00: configured for UDMA/33
Mar 10 11:09:41 think kernel: [11217.869737] ata6: EH complete
Mar 10 11:09:47 think kernel: [11223.951737] ata6: hard resetting link
Mar 10 11:09:50 think kernel: [11227.274784] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:50 think kernel: [11227.279504] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:50 think kernel: [11227.286833] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:50 think kernel: [11227.290477] ata6.00: configured for UDMA/33
Mar 10 11:09:50 think kernel: [11227.304913] ata6: EH complete
Mar 10 11:09:50 think kernel: [11227.384377] ata6: hard resetting link
Mar 10 11:09:54 think kernel: [11230.763016] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:09:54 think kernel: [11230.766595] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:54 think kernel: [11230.774235] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:09:54 think kernel: [11230.777396] ata6.00: configured for UDMA/33
Mar 10 11:09:54 think kernel: [11230.793144] ata6: EH complete
Mar 10 11:10:06 think kernel: [11243.627307] ata6: hard resetting link
Mar 10 11:10:10 think kernel: [11246.954803] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:10:10 think kernel: [11246.958246] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:10:10 think kernel: [11246.965996] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:10:10 think kernel: [11246.969984] ata6.00: configured for UDMA/33
Mar 10 11:10:10 think kernel: [11246.984956] ata6: EH complete
Mar 10 11:10:26 think kernel: [11262.886673] ata6: hard resetting link
Mar 10 11:10:27 think kernel: [11264.206101] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:10:27 think kernel: [11264.251554] ata6: hard resetting link
Mar 10 11:10:28 think kernel: [11264.775815] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:10:28 think kernel: [11264.824051] ata6: hard resetting link
Mar 10 11:10:28 think kernel: [11265.345533] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:10:28 think kernel: [11265.345551] ata6.00: disabled
Mar 10 11:10:28 think kernel: [11265.345562] ata6: limiting SATA link speed
to 1.5 Gbps
Mar 10 11:10:28 think kernel: [11265.365635] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.365642] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.365650] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.365652]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.365657]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.365659] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.365662] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 93 d7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366108] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366111] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366114] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366116]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366123]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366125] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366128] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 9b d7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366152] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366155] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366158] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366160]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366167]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366171] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366174] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 a3 d7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366185] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366188] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366192] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366194]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366201]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366205] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366208] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 ab d7 00 00 08 00
Mar 10 11:10:28 think kernel: [11265.366220] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366223] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366226] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366228]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366236]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366239] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366242] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 ab df 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366255] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366257] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366261] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366262]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366270]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366274] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366277] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 af df 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366289] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366292] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366295] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366297]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366304]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366308] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366311] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 b3 df 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366323] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366326] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366329] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366331]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366339]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366342] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366345] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 b7 df 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366358] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366361] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366364] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366366]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366374]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366378] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366381] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 bb df 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366394] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366397] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366400] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366402]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366410]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366413] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366417] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 bf df 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366429] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366432] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366435] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366437]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366445]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366448] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366451] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 c3 df 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366464] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366466] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366470] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366471]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366479]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366482] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366485] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 c7 df 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366496] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366499] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366502] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366504]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366512]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366515] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366518] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 cb df 00 00 08 00
Mar 10 11:10:28 think kernel: [11265.366531] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366534] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366538] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366540]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366547]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366551] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366554] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 cb e7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366566] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366569] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366573] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366574]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366582]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366585] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366588] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 cf e7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366602] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366604] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366608] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366610]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366617]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366621] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366624] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 d3 e7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366637] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366640] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366643] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366645]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366652]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366656] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366659] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 d7 e7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366672] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366675] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366678] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366680]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366688]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366691] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366694] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 db e7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366707] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366709] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366713] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366714]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366722]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366725] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366731] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 df e7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366743] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366746] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366749] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366751]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366758]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366761] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366765] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 e3 e7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366784] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366787] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366791] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366793]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366802]         00 b1 df
Mar 10 11:10:28 think kernel: [11265.366806] e7
Mar 10 11:10:28 think kernel: [11265.366808] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366811] sd 5:0:0:0: [sdb] CDB:
Mar 10 11:10:28 think kernel: [11265.366814] Write(10)
Mar 10 11:10:28 think kernel: [11265.366817] :
Mar 10 11:10:28 think kernel: [11265.366820]  2a 00 00 b1 e7 e7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366835] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366838] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366841] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366843]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366851]         00
Mar 10 11:10:28 think kernel: [11265.366854] b1 df
Mar 10 11:10:28 think kernel: [11265.366857] e7
Mar 10 11:10:28 think kernel: [11265.366860]
Mar 10 11:10:28 think kernel: [11265.366863] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366865] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 7b 9f 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366878] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366881] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366884] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366886]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366894]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366897] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366900] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 7f 9f 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366913] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366916] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366919] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366921]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366929]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366932] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366935] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 83 9f 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366947] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366950] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366954] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366955]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366963]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.366967] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.366970] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 87 9f 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.366981] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.366984] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.366987] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.366989]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.366997]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.367000] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.367003] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 8b 9f 00 00 38 00
Mar 10 11:10:28 think kernel: [11265.367016] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.367019] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.367022] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.367024]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.367032]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.367035] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.367038] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 8b d7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.367051] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.367054] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.367057] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.367059]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.367066]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.367070] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.367073] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 8f d7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.367085] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.367088] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.367091] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.367093]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.367100]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.367103] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.367106] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 97 d7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.367120] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.367122] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.367125] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.367127]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.367135]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.367139] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.367142] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 9f d7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.367155] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_OK driverbyte=DRIVER_SENSE
Mar 10 11:10:28 think kernel: [11265.367158] sd 5:0:0:0: [sdb]  Sense Key :
Aborted Command [current] [descriptor]
Mar 10 11:10:28 think kernel: [11265.367161] Descriptor sense data with
sense descriptors (in hex):
Mar 10 11:10:28 think kernel: [11265.367163]         72 0b 00 00 00 00 00 0c
00 0a 80 00 00 00 00 00
Mar 10 11:10:28 think kernel: [11265.367171]         00 b1 df e7
Mar 10 11:10:28 think kernel: [11265.367174] sd 5:0:0:0: [sdb]  Add. Sense:
No additional sense information
Mar 10 11:10:28 think kernel: [11265.367177] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 a7 d7 00 04 00 00
Mar 10 11:10:28 think kernel: [11265.367189] ata6: EH complete
Mar 10 11:10:28 think kernel: [11265.367201] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367206] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367211] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367216] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367220] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367224] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367229] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367233] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367237] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367242] lost page write due to I/O
error on sdb1
Mar 10 11:10:28 think kernel: [11265.367723] ata6.00: detaching (SCSI
5:0:0:0)
Mar 10 11:10:28 think kernel: [11265.367787] sd 5:0:0:0: [sdb] Unhandled
error code
Mar 10 11:10:28 think kernel: [11265.367789] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK
Mar 10 11:10:28 think kernel: [11265.367793] sd 5:0:0:0: [sdb] CDB:
Write(10): 2a 00 00 b1 eb e7 00 00 08 00
Mar 10 11:10:28 think kernel: [11265.396490] ata6: limiting SATA link speed
to 1.5 Gbps
Mar 10 11:10:28 think kernel: [11265.396494] ata6: hard resetting link
Mar 10 11:10:28 think kernel: [11265.586251] xfs_force_shutdown(sdb1,0x2)
called from line 926 of file fs/xfs/xfs_log.c.  Return address =
0xffffffffa00e18fb
Mar 10 11:10:28 think kernel: [11265.586272] Filesystem "sdb1":
xfs_log_force: error 5 returned.
Mar 10 11:10:28 think kernel: [11265.586276] xfs_force_shutdown(sdb1,0x1)
called from line 1040 of file fs/xfs/linux-2.6/xfs_buf.c.  Return address =
0xffffffffa00fd8f3
Mar 10 11:10:29 think kernel: [11266.015634] sd 5:0:0:0: [sdb] Synchronizing
SCSI cache
Mar 10 11:10:30 think kernel: [11266.975886] Filesystem "sdb1":
xfs_log_force: error 5 returned.
Mar 10 11:10:30 think kernel: [11266.975933] Filesystem "sdb1":
xfs_log_force: error 5 returned.
Mar 10 11:10:31 think kernel: [11267.654423] ata6: reset failed (errno=-32),
retrying in 8 secs
Mar 10 11:10:38 think kernel: [11275.390583] ata6: hard resetting link
Mar 10 11:10:41 think kernel: [11277.939232] ata6: reset failed (errno=-32),
retrying in 8 secs
Mar 10 11:10:48 think kernel: [11285.385359] ata6: hard resetting link
Mar 10 11:10:53 think kernel: [11290.273004] ata6: SATA link up 1.5 Gbps
(SStatus 113 SControl 310)
Mar 10 11:10:53 think kernel: [11290.276690] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:10:53 think kernel: [11290.290790] ata6.00: ATA-8: WDC
WD1500HLFS-01G6U4, 04.04V06, max UDMA/133
Mar 10 11:10:53 think kernel: [11290.290796] ata6.00: 293046768 sectors,
multi 0: LBA48 NCQ (depth 31/32), AA
Mar 10 11:10:53 think kernel: [11290.294448] ata6.00: ACPI cmd
f5/00:00:00:00:00:a0 (SECURITY FREEZE LOCK) filtered out
Mar 10 11:10:53 think kernel: [11290.298463] ata6.00: configured for
UDMA/133
Mar 10 11:10:53 think kernel: [11290.312962] ata6: EH complete
Mar 10 11:10:53 think kernel: [11290.313299] sd 5:0:0:0: [sdb] Stopping disk
Mar 10 11:10:54 think kernel: [11291.041901] scsi 5:0:0:0: Direct-Access
ATA      WDC WD1500HLFS-0 04.0 PQ: 0 ANSI: 5
Mar 10 11:10:54 think kernel: [11291.042181] sd 5:0:0:0: [sdb] 293046768
512-byte logical blocks: (150 GB/139 GiB)
Mar 10 11:10:54 think kernel: [11291.042271] sd 5:0:0:0: Attached scsi
generic sg2 type 0
Mar 10 11:10:54 think kernel: [11291.042314] sd 5:0:0:0: [sdb] Write Protect
is off
Mar 10 11:10:54 think kernel: [11291.042393] sd 5:0:0:0: [sdb] Write cache:
enabled, read cache: enabled, doesn't support DPO or FUA
Mar 10 11:10:55 think kernel: [11292.308399]  sdb: sdb1 sdb2
Mar 10 11:10:55 think kernel: [11292.308947] sd 5:0:0:0: [sdb] Attached SCSI
disk
Mar 10 11:11:14 think kernel: [11311.494015] ata6: hard resetting link
Mar 10 11:11:16 think kernel: [11313.321337] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:11:16 think kernel: [11313.363772] ata6: hard resetting link
Mar 10 11:11:17 think kernel: [11313.951130] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:11:22 think kernel: [11318.948481] ata6: hard resetting link
Mar 10 11:11:23 think kernel: [11319.798058] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:11:23 think kernel: [11319.798081] ata6.00: disabled
Mar 10 11:11:23 think kernel: [11319.798097] ata6: limiting SATA link speed
to 1.5 Gbps
Mar 10 11:11:23 think kernel: [11319.817999] ata6: EH complete
Mar 10 11:11:23 think kernel: [11319.818012] ata6.00: detaching (SCSI
5:0:0:0)
Mar 10 11:11:23 think kernel: [11319.841998] ata6: limiting SATA link speed
to 1.5 Gbps
Mar 10 11:11:23 think kernel: [11319.842005] ata6: hard resetting link
Mar 10 11:11:23 think kernel: [11319.898111] sd 5:0:0:0: [sdb] Synchronizing
SCSI cache
Mar 10 11:11:24 think kernel: [11321.087430] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:11:24 think kernel: [11321.107395] ata6: EH complete
Mar 10 11:11:24 think kernel: [11321.107459] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Mar 10 11:11:24 think kernel: [11321.107466] sd 5:0:0:0: [sdb] Stopping disk
Mar 10 11:11:24 think kernel: [11321.107479] sd 5:0:0:0: [sdb] START_STOP
FAILED
Mar 10 11:11:24 think kernel: [11321.107482] sd 5:0:0:0: [sdb]  Result:
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Mar 10 11:11:24 think kernel: [11321.142143] ata6: limiting SATA link speed
to 1.5 Gbps
Mar 10 11:11:24 think kernel: [11321.142148] ata6: hard resetting link
Mar 10 11:11:25 think kernel: [11322.386749] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:11:25 think kernel: [11322.406674] ata6: EH complete
Mar 10 11:11:25 think kernel: [11322.445850] ata6: limiting SATA link speed
to 1.5 Gbps
Mar 10 11:11:25 think kernel: [11322.445855] ata6: hard resetting link
Mar 10 11:11:27 think kernel: [11323.686135] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:11:27 think kernel: [11323.706029] ata6: EH complete
Mar 10 11:11:27 think kernel: [11323.750262] ata6: limiting SATA link speed
to 1.5 Gbps
Mar 10 11:11:27 think kernel: [11323.750267] ata6: hard resetting link
Mar 10 11:11:28 think kernel: [11324.995440] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:11:28 think kernel: [11325.015357] ata6: EH complete
Mar 10 11:11:28 think kernel: [11325.062671] ata6: limiting SATA link speed
to 1.5 Gbps
Mar 10 11:11:28 think kernel: [11325.062675] ata6: hard resetting link
Mar 10 11:11:29 think kernel: [11326.124862] ata6: SATA link down (SStatus 0
SControl 310)
Mar 10 11:11:29 think kernel: [11326.144756] ata6: EH complete


2011/3/10 <bugzilla-daemon@bugzilla.kernel.org>

> https://bugzilla.kernel.org/show_bug.cgi?id=30802
>
>
> Robert Hancock <hancockrwd@gmail.com> changed:
>
>           What    |Removed                     |Added
>
> ----------------------------------------------------------------------------
>                 CC|                            |hancockrwd@gmail.com
>
>
>
>
> --- Comment #3 from Robert Hancock <hancockrwd@gmail.com>  2011-03-10
> 02:23:40 ---
> So you're getting stuff like:
>
> [20698.759685] ata6: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action
> 0xe
> frozen
> [20698.759691] ata6: irq_stat 0x00400040, connection status changed
> [20698.759697] ata6: SError: { PHYRdyChg CommWake DevExch }
> [20698.759706] ata6: hard resetting link
>
> Your controller's reporting a bunch of link state change events occurring.
> My
> first inclination is to suspect a problem with the eSATA cable or drive
> enclosure. A lot of these seem to be rather flaky as far as power and/or
> the
> solidity of the cable connections.
>
> Does it recover if you disconnect/power off and reconnect the drive?
>
> --
> Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
> ------- You are receiving this mail because: -------
> You reported the bug.
>

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug.
