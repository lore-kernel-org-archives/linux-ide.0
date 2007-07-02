From: Stefan Skotte <sfs@enhance-it.dk>
Subject: Re: State of Port Multiplier Support in libata?
Date: Mon, 02 Jul 2007 15:24:38 +0200
Message-ID: <4688FC96.7040604@enhance-it.dk>
References: <4684D54A.8030307@enhance-it.dk> <4688A74B.7000604@gmail.com> <4688AB51.8080801@enhance-it.dk> <4688AE9D.7060008@gmail.com> <4688C3AF.2060100@enhance-it.dk> <4688C700.6070901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from csmtp.b-one.net ([195.47.247.21]:49003 "EHLO csmtp1.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752880AbXGBNYm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 09:24:42 -0400
In-Reply-To: <4688C700.6070901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey Tejun,

Here's a few tries at testing the power on/off, unplugging disks:

============================
Here's the full log after a reboot, and me powering up the array
manually afterwards:
============================
[ 9995.743400] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa
frozen
[ 9995.743409] ata1: irq_stat 0x00b40090 <PHY RDY changed>
[ 9995.743419] ata1: hard resetting link
[ 9997.936879] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[ 9998.080620] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x9/0x9
[ 9998.208414] ata1.00: hard resetting link
[ 9998.691615] ata1.00: softreset failed (SRST command error)
[ 9998.691623] ata1.00: reset failed (errno=-5), retrying in 10 secs
[10008.191634] ata1.00: hard resetting link
[10008.802619] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[10008.818589] ata1.01: hard resetting link
[10009.381644] ata1.01: SATA link down (SStatus 0 SControl 300)
[10009.397617] ata1.02: hard resetting link
[10009.960672] ata1.02: SATA link down (SStatus 0 SControl 300)
[10009.976646] ata1.03: hard resetting link
[10010.539699] ata1.03: SATA link down (SStatus 0 SControl 300)
[10010.555671] ata1.04: hard resetting link
[10011.150673] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[10011.150682] ata1.05: hard resetting link
[10011.713728] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[10011.759634] ata1.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[10011.759641] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[10011.817827] ata1.00: configured for UDMA/100
[10011.830608] ata1.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
[10011.830615] ata1.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[10011.831615] ata1.04: configured for UDMA/100
[10011.845509] ata1: EH complete
[10011.845542] PM: Adding info for No Bus:target0:0:0
[10011.845990] scsi 0:0:0:0: Direct-Access     ATA      ST3750640AS
 3.AA PQ: 0 ANSI: 5
[10011.845998] PM: Adding info for scsi:0:0:0:0
[10011.846305] sd 0:0:0:0: [sdb] 1465149168 512-byte hardware sectors
(750156 MB)
[10011.846457] sd 0:0:0:0: [sdb] Write Protect is off
[10011.846460] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[10011.846691] sd 0:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[10011.846895] sd 0:0:0:0: [sdb] 1465149168 512-byte hardware sectors
(750156 MB)
[10011.847041] sd 0:0:0:0: [sdb] Write Protect is off
[10011.847043] sd 0:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[10011.847273] sd 0:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[10011.847277]  sdb: sdb1
[10011.865846] sd 0:0:0:0: [sdb] Attached SCSI disk
[10011.865877] sd 0:0:0:0: Attached scsi generic sg2 type 0
[10011.865896] PM: Adding info for No Bus:target0:0:4
[10011.866259] scsi 0:0:4:0: Direct-Access     ATA      WDC WD5000YS-01M
09.0 PQ: 0 ANSI: 5
[10011.866266] PM: Adding info for scsi:0:0:4:0
[10011.867096] sd 0:0:4:0: [sdc] 976773168 512-byte hardware sectors
(500108 MB)
[10011.867112] sd 0:0:4:0: [sdc] Write Protect is off
[10011.867115] sd 0:0:4:0: [sdc] Mode Sense: 00 3a 00 00
[10011.867128] sd 0:0:4:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[10011.867166] sd 0:0:4:0: [sdc] 976773168 512-byte hardware sectors
(500108 MB)
[10011.867174] sd 0:0:4:0: [sdc] Write Protect is off
[10011.867176] sd 0:0:4:0: [sdc] Mode Sense: 00 3a 00 00
[10011.867188] sd 0:0:4:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[10011.867192]  sdc: sdc1
[10011.870897] sd 0:0:4:0: [sdc] Attached SCSI disk
[10011.870931] sd 0:0:4:0: Attached scsi generic sg3 type 0
============================
Here's when I rmmod sata_sil24:
=============================
[10142.204662] ata1.00: disabled
[10142.204667] ata1.04: disabled
[10142.205101] sd 0:0:0:0: [sdb] Synchronizing SCSI cache
[10142.206502] sd 0:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[10142.206509] sd 0:0:0:0: [sdb] Stopping disk
[10142.207051] sd 0:0:0:0: [sdb] START_STOP FAILED
[10142.207054] sd 0:0:0:0: [sdb] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[10142.207223] PM: Removing info for scsi:0:0:0:0
[10142.207276] PM: Removing info for No Bus:target0:0:0
[10142.207421] sd 0:0:4:0: [sdc] Synchronizing SCSI cache
[10142.211458] sd 0:0:4:0: [sdc] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[10142.211465] sd 0:0:4:0: [sdc] Stopping disk
[10142.211777] sd 0:0:4:0: [sdc] START_STOP FAILED
[10142.211779] sd 0:0:4:0: [sdc] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[10142.211948] PM: Removing info for scsi:0:0:4:0
[10142.212008] PM: Removing info for No Bus:target0:0:4
[10142.212043] PM: Removing info for No Bus:host0
[10142.212103] ACPI: PCI interrupt for device 0000:01:00.0 disabled
=============================
Booting with array turned on:
(disks are spun up one at a time)
This also includes my slim dvdrw + seagate 500gb drive.
=============================
[   43.125831] scsi0 : sata_sil24
[   43.125837] PM: Adding info for No Bus:host0
[   43.125860] ata1: SATA max UDMA/100 cmd 0xf8878000 ctl 0x00000000
bmdma 0x00000000 irq 0
[   44.200476] PM: Adding info for ieee1394:00031d000000b79d
[   44.200536] ieee1394: Host added: ID:BUS[0-00:1023]
GUID[00031d000000b79d]
[   45.318554] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   45.462294] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x9/0x9
[   45.590089] ata1.00: hard resetting link
[   46.201068] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   46.217041] ata1.01: hard resetting link
[   46.780101] ata1.01: SATA link down (SStatus 0 SControl 300)
[   46.796074] ata1.02: hard resetting link
[   47.359134] ata1.02: SATA link down (SStatus 0 SControl 300)
[   47.375106] ata1.03: hard resetting link
[   47.938168] ata1.03: SATA link down (SStatus 0 SControl 300)
[   47.954139] ata1.04: hard resetting link
[   48.549147] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   48.549153] ata1.05: hard resetting link
[   49.112205] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   56.404253] ata1.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[   56.404259] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   56.462446] ata1.00: configured for UDMA/100
[   62.687472] ata1.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
[   62.687479] ata1.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   62.688546] ata1.04: configured for UDMA/100
[   62.701504] ata1: EH complete
[   62.701528] PM: Adding info for No Bus:target0:0:0
[   62.701659] scsi 0:0:0:0: Direct-Access     ATA      ST3750640AS
 3.AA PQ: 0 ANSI: 5
[   62.701672] PM: Adding info for scsi:0:0:0:0
[   62.701999] PM: Adding info for No Bus:target0:0:4
[   62.702047] scsi 0:0:4:0: Direct-Access     ATA      WDC WD5000YS-01M
09.0 PQ: 0 ANSI: 5
[   62.702053] PM: Adding info for scsi:0:0:4:0
[   62.704419] ata_piix 0000:00:1f.2: version 2.11
[   62.704426] ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
[   62.704446] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level,
low) -> IRQ 18
[   62.704474] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   62.704515] scsi1 : ata_piix
[   62.704522] PM: Adding info for No Bus:host1
[   62.704549] scsi2 : ata_piix
[   62.704554] PM: Adding info for No Bus:host2
[   62.704569] ata2: SATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6
bmdma 0x0001fa00 irq 14
[   62.704572] ata3: PATA max UDMA/100 cmd 0x00010170 ctl 0x00010376
bmdma 0x0001fa08 irq 15
[   62.709627] sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[   62.709637] sd 0:0:0:0: [sda] Write Protect is off
[   62.709640] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   62.709651] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   62.709695] sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[   62.709702] sd 0:0:0:0: [sda] Write Protect is off
[   62.709704] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   62.709716] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   62.709720]  sda: sda1
[   62.755054] sd 0:0:0:0: [sda] Attached SCSI disk
[   62.755485] sd 0:0:4:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[   62.755494] sd 0:0:4:0: [sdb] Write Protect is off
[   62.755496] sd 0:0:4:0: [sdb] Mode Sense: 00 3a 00 00
[   62.755508] sd 0:0:4:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   62.755540] sd 0:0:4:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[   62.755548] sd 0:0:4:0: [sdb] Write Protect is off
[   62.755550] sd 0:0:4:0: [sdb] Mode Sense: 00 3a 00 00
[   62.755561] sd 0:0:4:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   62.755564]  sdb: sdb1
[   62.761248] sd 0:0:4:0: [sdb] Attached SCSI disk
[   62.764902] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   62.764918] sd 0:0:4:0: Attached scsi generic sg1 type 0
[   62.903813] ata2.00: ATA-7: ST3500630A, 3.AAE, max UDMA/100
[   62.903820] ata2.00: 976773168 sectors, multi 16: LBA48
[   62.903825] ata2.00: applying bridge limits
[   62.970241] ata2.00: configured for UDMA/100
[   63.288941] ata3.00: ATAPI: MATSHITADVD-RAM UJ-846S, F100, max UDMA/66
[   63.288945] ata3.00: limited to UDMA/33 due to 40-wire cable
[   63.460653] ata3.00: configured for UDMA/33
[   63.460672] PM: Adding info for No Bus:target1:0:0
[   63.460738] scsi 1:0:0:0: Direct-Access     ATA      ST3500630A
 3.AA PQ: 0 ANSI: 5
[   63.460746] PM: Adding info for scsi:1:0:0:0
[   63.460978] sd 1:0:0:0: [sdc] 976773168 512-byte hardware sectors
(500108 MB)
[   63.460988] sd 1:0:0:0: [sdc] Write Protect is off
[   63.460991] sd 1:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   63.461003] sd 1:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   63.461039] sd 1:0:0:0: [sdc] 976773168 512-byte hardware sectors
(500108 MB)
[   63.461046] sd 1:0:0:0: [sdc] Write Protect is off
[   63.461048] sd 1:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   63.461060] sd 1:0:0:0: [sdc] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[   63.461062]  sdc: sdc1 sdc2 < sdc5 >
[   63.507333] sd 1:0:0:0: [sdc] Attached SCSI disk
[   63.507523] sd 1:0:0:0: Attached scsi generic sg2 type 0
[   63.507540] PM: Adding info for No Bus:target2:0:0
[   63.509120] scsi 2:0:0:0: CD-ROM            MATSHITA DVD-RAM UJ-846S
 F100 PQ: 0 ANSI: 5
[   63.509131] PM: Adding info for scsi:2:0:0:0
[   63.509595] scsi 2:0:0:0: Attached scsi generic sg3 type 5
[   63.524513] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw
xa/form2 cdda caddy
[   63.524517] Uniform CD-ROM driver Revision: 3.20
[   63.524661] sr 2:0:0:0: Attached scsi CD-ROM sr0
=============================
Array turned of without rmmod'ing sata_sil24:
=============================
[  351.223540] ata1.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  351.223550] ata1.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  351.223556] ata1.02: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  351.223562] ata1.03: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  351.223568] ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  351.223573] ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action
0x6 frozen
[  351.479090] ata1.15: failed to read PMP product ID
[  351.479096] ata1.15: retrying hardreset
[  351.479106] ata1.15: hard resetting link
[  356.566580] ata1.15: SATA link down (SStatus 1 SControl 0)
[  356.822165] ata1.15: failed to read PMP GSCR[0] (errno=-5)
[  356.822172] ata1.15: PMP revalidation failed (errno=-5)
[  356.822179] ata1.15: limiting SATA link speed to 1.5 Gbps
[  356.822184] ata1.15: retrying hardreset in 5 secs
[  361.817800] ata1.15: hard resetting link
[  366.905308] ata1.15: SATA link down (SStatus 1 SControl 10)
[  367.160893] ata1.15: failed to read PMP GSCR[0] (errno=-5)
[  367.160900] ata1.15: PMP revalidation failed (errno=-5)
[  367.160906] ata1.15: retrying hardreset in 5 secs
.. and continues to retry
=============================
Array turned on again:
=============================
(continued from above)
[  372.156532] ata1.15: hard resetting link
[  377.244059] ata1.15: SATA link down (SStatus 1 SControl 10)
[  377.499621] ata1.15: failed to read PMP GSCR[0] (errno=-5)
[  377.499628] ata1.15: PMP revalidation failed (errno=-5)
[  377.499635] ata1.15: retrying hardreset in 5 secs
[  382.495257] ata1.15: hard resetting link
[  387.582767] ata1.15: SATA link down (SStatus 1 SControl 10)
[  387.838349] ata1.15: failed to read PMP GSCR[0] (errno=-5)
[  387.838356] ata1.15: PMP revalidation failed (errno=-5)
[  387.838360] ata1.15: failed to recover PMP after 3 tries, giving up
[  387.838365] ata1.15: Port Multiplier detaching
[  387.838391] ata1.00: disabled
[  387.838398] ata1.04: disabled
[  387.838403] ata1.00: disabled
[  387.838411] ata1: EH pending after completion, repeating EH (cnt=4)
[  387.838423] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0x9
[  387.838428] ata1: irq_stat 0x01940090 <PHY RDY changed>
[  387.838437] ata1: hard resetting link
[  392.111206] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[  392.254950] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
feat 0x9/0x9
[  392.382744] ata1.00: hard resetting link
[  392.865950] ata1.00: softreset failed (SRST command error)
[  392.865958] ata1.00: reset failed (errno=-5), retrying in 10 secs
[  402.366056] ata1.00: hard resetting link
[  402.977046] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  402.993018] ata1.01: hard resetting link
[  403.556078] ata1.01: SATA link down (SStatus 0 SControl 300)
[  403.572050] ata1.02: hard resetting link
[  404.135131] ata1.02: SATA link down (SStatus 0 SControl 300)
[  404.151086] ata1.03: hard resetting link
[  404.714143] ata1.03: SATA link down (SStatus 0 SControl 300)
[  404.730118] ata1.04: hard resetting link
[  405.325123] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  405.325130] ata1.05: hard resetting link
[  405.888183] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  405.933855] ata1.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[  405.933862] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  405.992055] ata1.00: configured for UDMA/100
[  406.006812] ata1.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
[  406.006820] ata1.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  406.007809] ata1.04: configured for UDMA/100
[  406.019974] ata1: EH complete
[  406.019987] ata1.00: detaching (SCSI 0:0:0:0)
[  406.020286] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  406.020392] sd 0:0:0:0: [sda] Stopping disk
[  406.020502] PM: Removing info for scsi:0:0:0:0
[  406.020536] PM: Removing info for No Bus:target0:0:0
[  406.020546] ata1.04: detaching (SCSI 0:0:4:0)
[  406.020674] sd 0:0:4:0: [sdb] Synchronizing SCSI cache
[  406.020843] sd 0:0:4:0: [sdb] Stopping disk
[  406.464589] PM: Removing info for scsi:0:0:4:0
[  406.464678] PM: Removing info for No Bus:target0:0:4
[  406.464714] PM: Adding info for No Bus:target0:0:0
[  406.466047] scsi 0:0:0:0: Direct-Access     ATA      ST3750640AS
 3.AA PQ: 0 ANSI: 5
[  406.466063] PM: Adding info for scsi:0:0:0:0
[  406.467227] sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[  406.467240] sd 0:0:0:0: [sda] Write Protect is off
[  406.467244] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  406.467257] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  406.467300] sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[  406.467308] sd 0:0:0:0: [sda] Write Protect is off
[  406.467311] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  406.467323] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  406.467326]  sda: sda1
[  408.040630] sd 0:0:0:0: [sda] Attached SCSI disk
[  408.040695] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  408.040734] PM: Adding info for No Bus:target0:0:4
[  408.041214] scsi 0:0:4:0: Direct-Access     ATA      WDC WD5000YS-01M
09.0 PQ: 0 ANSI: 5
[  408.041221] PM: Adding info for scsi:0:0:4:0
[  408.041667] sd 0:0:4:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[  408.041677] sd 0:0:4:0: [sdb] Write Protect is off
[  408.041680] sd 0:0:4:0: [sdb] Mode Sense: 00 3a 00 00
[  408.041692] sd 0:0:4:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  408.041727] sd 0:0:4:0: [sdb] 976773168 512-byte hardware sectors
(500108 MB)
[  408.041735] sd 0:0:4:0: [sdb] Write Protect is off
[  408.041737] sd 0:0:4:0: [sdb] Mode Sense: 00 3a 00 00
[  408.041751] sd 0:0:4:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  408.041754]  sdb: sdb1
[  410.941492] sd 0:0:4:0: [sdb] Attached SCSI disk
[  410.941561] sd 0:0:4:0: Attached scsi generic sg1 type 0
=============================
Disk in bay 2 pulled out:
=============================
[  560.721523] ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x4010000
action 0xb
[  560.753469] ata1.00: hard resetting link
[  561.731833] ata1.00: SATA link down (SStatus 0 SControl 300)
[  561.747809] ata1: failed to recover some devices, retrying in 5 secs
[  566.759437] ata1.00: hard resetting link
[  567.322494] ata1.00: SATA link down (SStatus 0 SControl 300)
[  567.354441] ata1.00: limiting SATA link speed to 1.5 Gbps
[  567.354449] ata1.00: limiting speed to UDMA/100:PIO3
[  567.354454] ata1: failed to recover some devices, retrying in 5 secs
[  572.366093] ata1.00: hard resetting link
[  572.993021] ata1.00: SATA link down (SStatus 0 SControl 310)
[  573.008995] ata1.00: disabled
[  573.544093] ata1.00: hard resetting link
[  574.171053] ata1.00: SATA link down (SStatus 0 SControl 300)
[  574.187034] ata1: EH complete
[  574.187052] ata1.00: detaching (SCSI 0:0:0:0)
[  574.187323] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  574.187372] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[  574.187380] sd 0:0:0:0: [sda] Stopping disk
[  574.187399] sd 0:0:0:0: [sda] START_STOP FAILED
[  574.187401] sd 0:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET
driverbyte=DRIVER_OK,SUGGEST_OK
[  574.187407] PM: Removing info for scsi:0:0:0:0
[  574.187439] PM: Removing info for No Bus:target0:0:0
==============================
Disk in bay 2 reinserted:
==============================
[  600.263465] ata1.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000
action 0xb
[  600.295411] ata1.00: hard resetting link
[  601.193925] ata1.00: softreset failed (SRST command error)
[  601.193933] ata1.00: reset failed (errno=-5), retrying in 10 secs
[  610.278721] ata1.00: hard resetting link
[  611.305018] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  611.350966] ata1.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
[  611.350974] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  611.409167] ata1.00: configured for UDMA/100
[  611.424823] ata1: EH complete
[  611.424857] PM: Adding info for No Bus:target0:0:0
[  611.424971] scsi 0:0:0:0: Direct-Access     ATA      ST3750640AS
 3.AA PQ: 0 ANSI: 5
[  611.424985] PM: Adding info for scsi:0:0:0:0
[  611.425082] sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[  611.425102] sd 0:0:0:0: [sda] Write Protect is off
[  611.425107] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  611.425134] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  611.425198] sd 0:0:0:0: [sda] 1465149168 512-byte hardware sectors
(750156 MB)
[  611.425206] sd 0:0:0:0: [sda] Write Protect is off
[  611.425209] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  611.425221] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[  611.425225]  sda: sda1
[  611.448869] sd 0:0:0:0: [sda] Attached SCSI disk
[  611.448931] sd 0:0:0:0: Attached scsi generic sg0 type 0
===========================

I will try to connect a harddrive directly to my controller, but that
will take some further testing (I'll get back on that subject).

The pci id doesn't concern me much, as long as the array works :D

Let me know if you need more tests...

- -stefan

Tejun Heo wrote:
> Stefan Skotte wrote:
>> I've just compiled, and I'm now running the kernel with the patches applied.
>>
>> It seems to work, however I'm not sure why the SATA Link is 1.5gb/s ?
>> Both my disks are SATA-II 300.
> 
> I dunno either.  Does it come up as 3Gbps if you connect it directly to
> the controller?
> 
>> ========== dmesg ==========
>> [   90.256606] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa
>> frozen
>> [   90.256615] ata1: irq_stat 0x00b40090 <PHY RDY changed>
>> [   90.256625] ata1: hard resetting link
>> [   92.449372] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> [   92.593106] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports,
>> feat 0x9/0x9
>> [   92.720891] ata1.00: hard resetting link
>> [   93.204061] ata1.00: softreset failed (SRST command error)
>> [   93.204068] ata1.00: reset failed (errno=-5), retrying in 10 secs
> 
> I suppose you powered up the array @90sec, right?
> 
>> [  102.703482] ata1.00: hard resetting link
>> [  103.314425] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [  103.330386] ata1.01: hard resetting link
>> [  103.893414] ata1.01: SATA link down (SStatus 0 SControl 300)
>> [  103.909388] ata1.02: hard resetting link
>> [  104.472403] ata1.02: SATA link down (SStatus 0 SControl 300)
>> [  104.488388] ata1.03: hard resetting link
>> [  105.051395] ata1.03: SATA link down (SStatus 0 SControl 300)
>> [  105.067367] ata1.04: hard resetting link
>> [  105.662330] ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [  105.662336] ata1.05: hard resetting link
>> [  106.225347] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> [  106.260017] ata1.00: ATA-7: ST3750640AS, 3.AAE, max UDMA/133
>> [  106.260023] ata1.00: 1465149168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>> [  106.318220] ata1.00: configured for UDMA/100
>> [  106.333611] ata1.04: ATA-7: WDC WD5000YS-01MPB1, 09.02E09, max UDMA/133
>> [  106.333617] ata1.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
>> [  106.334621] ata1.04: configured for UDMA/100
>> [  106.349138] ata1: EH complete
> 
> Everything looks pretty good.  Care to try some hotplug / power on, off
> testings?
> 
>> Still my controller is not identified (PCI id?); dont know if thats
>> something you want to change for the final patch:
>>
>> 01:00.0 Mass storage controller: Silicon Image, Inc. Unknown device 3531
>> (rev 01)
> 
> Oh well, this has nothing to do with the kernel or the driver.  You
> should ask the pciutils maintainer.
> 


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGiPyW+vG8YFo3LPMRAqbzAJ9ZadqzwV1Ny7dglHRiy94pIAaiXQCdFf73
hQnrX3u9Ypf/CvbIPgqP1E0=
=sDoi
-----END PGP SIGNATURE-----
