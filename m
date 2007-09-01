From: Tom Evans <tom@23palmer.net>
Subject: Re: Port Multiplier Patch 2.6.22.1 on Alpha
Date: Fri, 31 Aug 2007 23:04:29 -0400
Message-ID: <46D8D6BD.4070703@23palmer.net>
References: <46D638A3.2030704@23palmer.net> <46D64290.2010306@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:41147 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbXIADEo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Aug 2007 23:04:44 -0400
In-Reply-To: <46D64290.2010306@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: htejun@gmail.com, linux-ide@vger.kernel.org

I have included my boot messages and an lspci, in any of the info is useful.

I do have a VIA based sata board that works well also installed - any 
potential for conflict?

...tom

-----------------
Boot Log
-----------------

[4194001.852669] Linux version 2.6.22.1-ds20 (root@chronictown) (gcc 
version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Wed Aug 29 
03:40:59 EDT 2007
[4194001.852669] Booting on Tsunami variation Goldrush using machine 
vector DP264 from SRM
[4194001.852669] Major Options: SMP LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ
[4194001.852669] Command line: ro root=/dev/sda3 ide=reverse single
[4194001.852669] memcluster 0, usage 1, start        0, end      256
[4194001.852669] memcluster 1, usage 0, start      256, end   130976
[4194001.852669] memcluster 2, usage 1, start   130976, end   131072
[4194001.852669] freeing pages 256:384
[4194001.852669] freeing pages 999:130976
[4194001.852669] reserving pages 999:1001
[4194001.852669] 4096K Bcache detected; load hit latency 20 cycles, load 
miss latency 106 cycles
[4194001.852669] Console graphics on hose 0
[4194001.852669] SMP: 2 CPUs probed -- cpu_present_map = 3
[4194001.852669] On node 0 totalpages: 130976
[4194001.852669]   DMA zone: 895 pages used for memmap
[4194001.852669]   DMA zone: 0 pages reserved
[4194001.852669]   DMA zone: 130081 pages, LIFO batch:15
[4194001.852669]   Normal zone: 0 pages used for memmap
[4194001.852669] Built 1 zonelists.  Total pages: 130081
[4194001.852669] Kernel command line: ro root=/dev/sda3 ide=reverse single
[4194001.852669] PID hash table entries: 4096 (order: 12, 32768 bytes)
[4194001.852669] Using epoch = 1952
[4194001.855599] Console: colour VGA+ 80x25
[4194001.858529] Dentry cache hash table entries: 131072 (order: 7, 
1048576 bytes)
[4194001.861459] Inode-cache hash table entries: 65536 (order: 6, 524288 
bytes)
[4194001.907357] Memory: 1029240k/1047808k available (3251k kernel code, 
15888k reserved, 225k data, 168k init)
[4194001.908333] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.926888] Mount-cache hash table entries: 512
[4194001.926888] SMP starting up secondaries.
[4194001.935677] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.954232] Brought up 2 CPUs
[4194001.954232] SMP: Total of 2 processors activated (1998.25 BogoMIPS).
[4194002.035287] migration_cost=2929
[4194002.036263] NET: Registered protocol family 16
[4194002.041146] PCI: Bridge: 0000:00:08.0
[4194002.041146]   IO window: 8000-8fff
[4194002.041146]   MEM window: 0a000000-0a0fffff
[4194002.042122]   PREFETCH window: 0a100000-0a1fffff
[4194002.042122] SMC37c669 Super I/O Controller found @ 0x3f0
[4194002.046029] Linux Plug and Play Support v0.97 (c) Adam Belay
[4194002.047005] SCSI subsystem initialized
[4194002.047005] libata version 3.00 loaded.
[4194002.048958] NET: Registered protocol family 2
[4194002.061654] IP route cache hash table entries: 8192 (order: 3, 
65536 bytes)
[4194002.061654] TCP established hash table entries: 32768 (order: 6, 
786432 bytes)
[4194002.063607] TCP bind hash table entries: 32768 (order: 6, 524288 bytes)
[4194002.065560] TCP: Hash tables configured (established 32768 bind 32768)
[4194002.065560] TCP reno registered
[4194002.069466] srm_env: version 0.0.6 loaded successfully
[4194002.071419] io scheduler noop registered
[4194002.071419] io scheduler anticipatory registered (default)
[4194002.071419] io scheduler deadline registered
[4194002.071419] isapnp: Scanning for PnP cards...
[4194002.427864] isapnp: No Plug & Play device found
[4194002.562630] rtc: Digital UNIX epoch (1952) detected
[4194002.562630] Real Time Clock Driver v1.12ac
[4194002.562630] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, 
IRQ sharing disabled
[4194002.562630] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4194002.563607] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4194002.565560] Floppy drive(s): fd0 is 2.88M
[4194002.581185] FDC 0 is a post-1991 82077
[4194002.583138] nbd: registered device at major 43
[4194002.587044] Loading iSCSI transport class v2.0-724.
[4194002.747200] sym0: <875> rev 0x4 at pci 0000:01:00.0 irq 27
[4194002.834114] sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194002.834114] sym0: open drain IRQ line driver, using on-chip SRAM
[4194002.834114] sym0: using LOAD/STORE-based firmware.
[4194002.835091] sym0: SCSI BUS has been reset.
[4194002.841927] scsi0 : sym-2.2.3
[4194003.003059] sym1: <875> rev 0x4 at pci 0000:01:01.0 irq 26
[4194003.089974] sym1: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194003.089974] sym1: open drain IRQ line driver, using on-chip SRAM
[4194003.089974] sym1: using LOAD/STORE-based firmware.
[4194003.089974] sym1: SCSI BUS has been reset.
[4194003.097786] scsi1 : sym-2.2.3
[4194003.097786] sata_via 0001:02:08.0: version 2.2
[4194003.097786] sata_via 0001:02:08.0: routed to hard irq line 11
[4194003.098763] scsi2 : sata_via
[4194003.098763] scsi3 : sata_via
[4194003.098763] scsi4 : sata_via
[4194003.099739] ata1: SATA max UDMA/133 cmd 0xfffffd03fc008830 ctl 
0xfffffd03fc00883a bmdma 0xfffffd03fc008800 irq 43
[4194003.099739] ata2: SATA max UDMA/133 cmd 0xfffffd03fc008840 ctl 
0xfffffd03fc00884a bmdma 0xfffffd03fc008808 irq 43
[4194003.099739] ata3: PATA max UDMA/133 cmd 0xfffffd03fc008850 ctl 
0xfffffd03fc00885a bmdma 0xfffffd03fc008810 irq 43
[4194003.555794] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4194003.578255] ata1.00: ATA-7: SAMSUNG SP2504C, VT100-33, max UDMA7
[4194003.578255] ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
[4194003.600715] ata1.00: configured for UDMA/133
[4194003.904426] ata2: SATA link down (SStatus 0 SControl 310)
[4194004.077278] ata3.00: ATA-7: SAMSUNG SP2514N, VF100-41, max UDMA/100
[4194004.077278] ata3.00: 488397168 sectors, multi 0: LBA48
[4194004.077278] ata3.01: ATA-7: SAMSUNG SP2514N, VF100-41, max UDMA/100
[4194004.077278] ata3.01: 488397168 sectors, multi 0: LBA48
[4194004.125129] ata3.00: configured for UDMA/100
[4194004.151496] ata3.01: configured for UDMA/100
[4194004.151496] scsi: waiting for bus probes to complete ...
[4194006.376105] scsi 1:0:1:0: Direct-Access     FUJITSU  
MAJ3091MP        5508 PQ: 0 ANSI: 4
[4194006.376105]  target1:0:1: tagged command queuing enabled, command 
queue depth 16.
[4194006.377081]  target1:0:1: Beginning Domain Validation
[4194006.377081]  target1:0:1: asynchronous
[4194006.379034]  target1:0:1: wide asynchronous
[4194006.380987]  target1:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, 
offset 16)
[4194006.381964]  target1:0:1: Domain Validation skipping write tests
[4194006.381964]  target1:0:1: Ending Domain Validation
[4194007.007940] scsi 0:0:4:0: Sequential-Access ARCHIVE  Python 
04106-XXX 743B PQ: 0 ANSI: 2
[4194007.007940]  target0:0:4: Beginning Domain Validation
[4194007.012823]  target0:0:4: asynchronous
[4194007.033331]  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[4194007.046026]  target0:0:4: Domain Validation skipping write tests
[4194007.046026]  target0:0:4: Ending Domain Validation
[4194010.026493] scsi 0:0:4:0: Attached scsi generic sg0 type 1
[4194010.209110] sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors 
(9105 MB)
[4194010.212040] sd 1:0:1:0: [sda] Write Protect is off
[4194010.212040] sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
[4194010.213993] sd 1:0:1:0: [sda] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[4194010.214970] sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors 
(9105 MB)
[4194010.217900] sd 1:0:1:0: [sda] Write Protect is off
[4194010.217900] sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
[4194010.218876] sd 1:0:1:0: [sda] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[4194010.219853]  sda: sda1 sda2 sda3 sda4
[4194010.228642] sd 1:0:1:0: [sda] Attached SCSI disk
[4194010.229618] sd 1:0:1:0: Attached scsi generic sg1 type 0
[4194010.229618] scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG 
SP2504C  VT10 PQ: 0 ANSI: 5
[4194010.230595] sd 2:0:0:0: [sdb] 488397168 512-byte hardware sectors 
(250059 MB)
[4194010.230595] sd 2:0:0:0: [sdb] Write Protect is off
[4194010.230595] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[4194010.230595] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194010.231571] sd 2:0:0:0: [sdb] 488397168 512-byte hardware sectors 
(250059 MB)
[4194010.231571] sd 2:0:0:0: [sdb] Write Protect is off
[4194010.231571] sd 2:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[4194010.231571] sd 2:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194010.231571]  sdb: sdb1
[4194010.235478] sd 2:0:0:0: [sdb] Attached SCSI disk
[4194010.236454] sd 2:0:0:0: Attached scsi generic sg2 type 0
[4194010.236454] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG 
SP2514N  VF10 PQ: 0 ANSI: 5
[4194010.237431] sd 4:0:0:0: [sdc] 488397168 512-byte hardware sectors 
(250059 MB)
[4194010.237431] sd 4:0:0:0: [sdc] Write Protect is off
[4194010.237431] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[4194010.237431] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194010.237431] sd 4:0:0:0: [sdc] 488397168 512-byte hardware sectors 
(250059 MB)
[4194010.238407] sd 4:0:0:0: [sdc] Write Protect is off
[4194010.238407] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[4194010.238407] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194010.238407]  sdc: sdc1
[4194010.249150] sd 4:0:0:0: [sdc] Attached SCSI disk
[4194010.249150] sd 4:0:0:0: Attached scsi generic sg3 type 0
[4194010.250126] scsi 4:0:1:0: Direct-Access     ATA      SAMSUNG 
SP2514N  VF10 PQ: 0 ANSI: 5
[4194010.250126] sd 4:0:1:0: [sdd] 488397168 512-byte hardware sectors 
(250059 MB)
[4194010.250126] sd 4:0:1:0: [sdd] Write Protect is off
[4194010.251103] sd 4:0:1:0: [sdd] Mode Sense: 00 3a 00 00
[4194010.251103] sd 4:0:1:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194010.251103] sd 4:0:1:0: [sdd] 488397168 512-byte hardware sectors 
(250059 MB)
[4194010.251103] sd 4:0:1:0: [sdd] Write Protect is off
[4194010.251103] sd 4:0:1:0: [sdd] Mode Sense: 00 3a 00 00
[4194010.251103] sd 4:0:1:0: [sdd] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194010.252079]  sdd: sdd1
[4194010.255985] sd 4:0:1:0: [sdd] Attached SCSI disk
[4194010.256962] sd 4:0:1:0: Attached scsi generic sg4 type 0
[4194010.261845] serio: i8042 KBD port at 0x60,0x64 irq 1
[4194010.261845] serio: i8042 AUX port at 0x60,0x64 irq 12
[4194010.262821] mice: PS/2 mouse device common for all mice
[4194010.818485] input: AT Raw Set 2 keyboard as /class/input/input0
[4194010.834110] atkbd.c: keyboard reset failed on isa0060/serio1
[4194010.864384] md: linear personality registered for level -1
[4194010.864384] md: raid0 personality registered for level 0
[4194010.864384] md: raid1 personality registered for level 1
[4194010.864384] md: raid10 personality registered for level 10
[4194010.880985] raid6: int64x1    464 MB/s
[4194010.900516] raid6: int64x2    624 MB/s
[4194010.917118] raid6: int64x4    736 MB/s
[4194010.933719] raid6: int64x8    460 MB/s
[4194010.933719] raid6: using algorithm int64x4 (736 MB/s)
[4194010.933719] md: raid6 personality registered for level 6
[4194010.933719] md: raid5 personality registered for level 5
[4194010.933719] md: raid4 personality registered for level 4
[4194010.933719] raid5: automatically using best checksumming function: 
alpha prefetch
[4194010.938602]    alpha prefetch:  2072.576 MB/sec
[4194010.938602] raid5: using function: alpha prefetch (2072.576 MB/sec)
[4194010.938602] md: multipath personality registered for level -4
[4194010.938602] md: faulty personality registered for level -5
[4194010.938602] TCP cubic registered
[4194010.938602] NET: Registered protocol family 1
[4194010.938602] NET: Registered protocol family 10
[4194010.939579] lo: Disabled Privacy Extensions
[4194010.939579] NET: Registered protocol family 17
[4194010.940555] md: Autodetecting RAID arrays.
[4194011.008915] md: autorun ...
[4194011.008915] md: considering sdd1 ...
[4194011.008915] md:  adding sdd1 ...
[4194011.008915] md:  adding sdc1 ...
[4194011.008915] md:  adding sdb1 ...
[4194011.009891] md: created md1
[4194011.009891] md: bind<sdb1>
[4194011.009891] md: bind<sdc1>
[4194011.009891] md: bind<sdd1>
[4194011.009891] md: running: <sdd1><sdc1><sdb1>
[4194011.009891] raid5: device sdd1 operational as raid disk 2
[4194011.009891] raid5: device sdc1 operational as raid disk 1
[4194011.010868] raid5: device sdb1 operational as raid disk 0
[4194011.011844] raid5: allocated 6284kB for md1
[4194011.011844] raid5: raid level 5 set md1 active with 3 out of 3 
devices, algorithm 2
[4194011.011844] RAID5 conf printout:
[4194011.011844]  --- rd:3 wd:3
[4194011.011844]  disk 0, o:1, dev:sdb1
[4194011.012821]  disk 1, o:1, dev:sdc1
[4194011.012821]  disk 2, o:1, dev:sdd1
[4194011.012821] md: ... autorun DONE.
[4194011.025516] EXT3-fs: INFO: recovery required on readonly filesystem.
[4194011.025516] EXT3-fs: write access will be enabled during recovery.
[4194013.237429] kjournald starting.  Commit interval 5 seconds
[4194013.237429] EXT3-fs: recovery complete.
[4194013.238406] EXT3-fs: mounted filesystem with ordered data mode.
[4194013.238406] VFS: Mounted root (ext3 filesystem) readonly.
[4194013.239382] Freeing unused kernel memory: 168k freed
[4194016.854615] Adding 1976560k swap on /dev/sda4.  Priority:-1 
extents:1 across:1976560k
[4194017.176880] EXT3 FS on sda3, internal journal
[4194018.601684] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4194018.601684] ide: Assuming 33MHz system bus speed for PIO modes; 
override with idebus=xx
[4194018.942504] device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) 
initialised: dm-devel@redhat.com
[4194030.097772] kjournald starting.  Commit interval 5 seconds
[4194030.111444] EXT3 FS on md1, internal journal
[4194030.111444] EXT3-fs: mounted filesystem with ordered data mode.
[4194031.476678] VIA Networking Velocity Family Gigabit Ethernet Adapter 
Driver Ver. 1.14
[4194031.476678] Copyright (c) 2002, 2003 VIA Networking Technologies, Inc.
[4194031.477654] Copyright (c) 2004 Red Hat Inc.
[4194031.489373] eth0: VIA Networking Velocity Family Gigabit Ethernet 
Adapter
[4194031.489373] eth0: Ethernet Address: 00:13:49:12:44:DD
[4194032.070427] sata_sil24 0001:02:07.0: version 1.0
[4194032.071404] scsi5 : sata_sil24
[4194032.075310] scsi6 : sata_sil24
[4194032.097771] scsi7 : sata_sil24
[4194032.115349] scsi8 : sata_sil24
[4194032.140740] ata4: SATA max UDMA/100 cmd 0xfffffd0209080000 ctl 
0x0000000000000000 bmdma 0x0000000000000000 irq 47
[4194032.140740] ata5: SATA max UDMA/100 cmd 0xfffffd0209082000 ctl 
0x0000000000000000 bmdma 0x0000000000000000 irq 47
[4194032.140740] ata6: SATA max UDMA/100 cmd 0xfffffd0209084000 ctl 
0x0000000000000000 bmdma 0x0000000000000000 irq 47
[4194032.140740] ata7: SATA max UDMA/100 cmd 0xfffffd0209086000 ctl 
0x0000000000000000 bmdma 0x0000000000000000 irq 47
[4194034.306754] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194034.408317] ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 
ports, feat 0x1/0x9
[4194034.509879] ata4.00: hard resetting link
[4194035.008902] ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[4194035.021598] ata4.01: hard resetting link
[4194035.623160] ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[4194035.635855] ata4.02: hard resetting link
[4194036.172964] ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[4194036.185660] ata4.03: hard resetting link
[4194036.710073] ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[4194036.722769] ata4.04: hard resetting link
[4194037.259878] ata4.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[4194037.259878] ata4.05: hard resetting link
[4194037.758901] ata4.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194037.758901] ata4.06: hard resetting link
[4194038.257924] ata4.06: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4194038.280385] ata4.00: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max 
UDMA/133
[4194038.280385] ata4.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[4194038.281362] ata4.00: configured for UDMA/100
[4194038.286245] ata4.01: ATA-7: SAMSUNG SP2504C, VT100-33, max UDMA7
[4194038.286245] ata4.01: 488397168 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[4194038.292104] ata4.01: configured for UDMA/100
[4194038.299916] ata4.02: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max 
UDMA/133
[4194038.299916] ata4.02: 781422768 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[4194038.300893] ata4.02: configured for UDMA/100
[4194038.329213] ata4.03: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max 
UDMA/133
[4194038.329213] ata4.03: 781422768 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[4194038.330190] ata4.03: configured for UDMA/100
[4194038.338002] ata4.04: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max 
UDMA/133
[4194038.338002] ata4.04: 781422768 sectors, multi 0: LBA48 NCQ (depth 
31/32)
[4194038.338979] ata4.04: configured for UDMA/100
[4194038.338979] ata4.05: ATA-6: Config  Disk, PLS12052, max UDMA/133
[4194038.338979] ata4.05: 640 sectors, multi 1: LBA
[4194038.338979] ata4.05: device is on DMA blacklist, disabling DMA
[4194038.338979] ata4.05: configured for PIO4
[4194038.364370] ata4: EH complete
[4194040.415150] ata5: SATA link down (SStatus 0 SControl 0)
[4194042.465930] ata6: SATA link down (SStatus 0 SControl 0)
[4194044.516710] ata7: SATA link down (SStatus 0 SControl 0)
[4194044.516710] scsi 5:0:0:0: Direct-Access     ATA      WDC 
WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194044.529405] sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors 
(400088 MB)
[4194044.529405] sd 5:0:0:0: [sde] Write Protect is off
[4194044.529405] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[4194044.529405] sd 5:0:0:0: [sde] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194044.530382] sd 5:0:0:0: [sde] 781422768 512-byte hardware sectors 
(400088 MB)
[4194044.530382] sd 5:0:0:0: [sde] Write Protect is off
[4194044.530382] sd 5:0:0:0: [sde] Mode Sense: 00 3a 00 00
[4194044.530382] sd 5:0:0:0: [sde] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194044.530382]  sde: sde1
[4194044.578234] sd 5:0:0:0: [sde] Attached SCSI disk
[4194044.593859] sd 5:0:0:0: Attached scsi generic sg5 type 0
[4194044.608507] scsi 5:1:0:0: Direct-Access     ATA      SAMSUNG 
SP2504C  VT10 PQ: 0 ANSI: 5
[4194044.656358] sd 5:1:0:0: [sdf] 488397168 512-byte hardware sectors 
(250059 MB)
[4194044.657335] sd 5:1:0:0: [sdf] Write Protect is off
[4194044.657335] sd 5:1:0:0: [sdf] Mode Sense: 00 3a 00 00
[4194044.671007] sd 5:1:0:0: [sdf] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194044.672960] sd 5:1:0:0: [sdf] 488397168 512-byte hardware sectors 
(250059 MB)
[4194044.673937] sd 5:1:0:0: [sdf] Write Protect is off
[4194044.673937] sd 5:1:0:0: [sdf] Mode Sense: 00 3a 00 00
[4194044.677843] sd 5:1:0:0: [sdf] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194044.677843]  sdf: sdf1
[4194044.707140] sd 5:1:0:0: [sdf] Attached SCSI disk
[4194044.727648] sd 5:1:0:0: Attached scsi generic sg6 type 0
[4194044.755968] scsi 5:2:0:0: Direct-Access     ATA      WDC 
WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194044.787218] sd 5:2:0:0: [sdg] 781422768 512-byte hardware sectors 
(400088 MB)
[4194044.788194] sd 5:2:0:0: [sdg] Write Protect is off
[4194044.788194] sd 5:2:0:0: [sdg] Mode Sense: 00 3a 00 00
[4194044.805772] sd 5:2:0:0: [sdg] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194044.807726] sd 5:2:0:0: [sdg] 781422768 512-byte hardware sectors 
(400088 MB)
[4194044.808702] sd 5:2:0:0: [sdg] Write Protect is off
[4194044.808702] sd 5:2:0:0: [sdg] Mode Sense: 00 3a 00 00
[4194044.816515] sd 5:2:0:0: [sdg] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194044.816515]  sdg: sdg1
[4194044.843858] sd 5:2:0:0: [sdg] Attached SCSI disk
[4194044.856554] sd 5:2:0:0: Attached scsi generic sg7 type 0
[4194044.859483] scsi 5:3:0:0: Direct-Access     ATA      WDC 
WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194044.914171] sd 5:3:0:0: [sdh] 781422768 512-byte hardware sectors 
(400088 MB)
[4194044.915147] sd 5:3:0:0: [sdh] Write Protect is off
[4194044.915147] sd 5:3:0:0: [sdh] Mode Sense: 00 3a 00 00
[4194044.917101] sd 5:3:0:0: [sdh] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194044.919054] sd 5:3:0:0: [sdh] 781422768 512-byte hardware sectors 
(400088 MB)
[4194044.947374] sd 5:3:0:0: [sdh] Write Protect is off
[4194044.947374] sd 5:3:0:0: [sdh] Mode Sense: 00 3a 00 00
[4194044.949327] sd 5:3:0:0: [sdh] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194044.949327]  sdh: sdh1
[4194044.974718] sd 5:3:0:0: [sdh] Attached SCSI disk
[4194044.997179] sd 5:3:0:0: Attached scsi generic sg8 type 0
[4194045.019640] scsi 5:4:0:0: Direct-Access     ATA      WDC 
WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194045.055772] sd 5:4:0:0: [sdi] 781422768 512-byte hardware sectors 
(400088 MB)
[4194045.056749] sd 5:4:0:0: [sdi] Write Protect is off
[4194045.056749] sd 5:4:0:0: [sdi] Mode Sense: 00 3a 00 00
[4194045.058702] sd 5:4:0:0: [sdi] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194045.060655] sd 5:4:0:0: [sdi] 781422768 512-byte hardware sectors 
(400088 MB)
[4194045.061632] sd 5:4:0:0: [sdi] Write Protect is off
[4194045.061632] sd 5:4:0:0: [sdi] Mode Sense: 00 3a 00 00
[4194045.063585] sd 5:4:0:0: [sdi] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[4194045.063585]  sdi: sdi1
[4194045.132921] sd 5:4:0:0: [sdi] Attached SCSI disk
[4194045.180772] sd 5:4:0:0: Attached scsi generic sg9 type 0
[4194045.181749] scsi 5:5:0:0: Direct-Access     ATA      Config  
Disk     PLS1 PQ: 0 ANSI: 5
[4194045.230577] sd 5:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
[4194045.231553] sd 5:5:0:0: [sdj] Write Protect is off
[4194045.231553] sd 5:5:0:0: [sdj] Mode Sense: 00 3a 00 00
[4194045.233507] sd 5:5:0:0: [sdj] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[4194045.235460] sd 5:5:0:0: [sdj] 640 512-byte hardware sectors (0 MB)
[4194045.236436] sd 5:5:0:0: [sdj] Write Protect is off
[4194045.236436] sd 5:5:0:0: [sdj] Mode Sense: 00 3a 00 00
[4194045.238389] sd 5:5:0:0: [sdj] Write cache: disabled, read cache: 
enabled, doesn't support DPO or FUA
[4194045.238389]  sdj: unknown partition table
[4194045.246202] sd 5:5:0:0: [sdj] Attached SCSI disk
[4194045.290147] sd 5:5:0:0: Attached scsi generic sg10 type 0
[4194047.348740] usbcore: registered new interface driver usbfs
[4194047.361435] usbcore: registered new interface driver hub
[4194047.376084] usbcore: registered new device driver usb
[4194047.403427] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller 
(OHCI) Driver
[4194047.416123] ohci_hcd 0000:00:05.3: OHCI Host Controller
[4194047.445420] ohci_hcd 0000:00:05.3: new USB bus registered, assigned 
bus number 1
[4194047.445420] ohci_hcd 0000:00:05.3: irq 10, io mem 0x0a240000
[4194047.526474] usb usb1: configuration #1 chosen from 1 choice
[4194047.538193] hub 1-0:1.0: USB hub found
[4194047.538193] hub 1-0:1.0: 2 ports detected
[4194050.142684] st: Version 20070203, fixed bufsize 32768, s/g segs 256
[4194050.288192] st 0:0:4:0: Attached scsi tape st0
[4194050.289168] st 0:0:4:0: st0: try direct i/o: yes (alignment 512 B)
[4194050.405379] st0: Block limits 1 - 16777215 bytes.
[4194051.690535] Velocity is AUTO mode
[4194051.699324] ADDRCONF(NETDEV_UP): eth0: link is not ready
[4194054.969830] eth0: Link auto-negotiation speed 1000M bps full duplex
[4194054.973736] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[4194065.336035] eth0: no IPv6 routers present



-----------------
lspci
-----------------

0000:00:05.0 ISA bridge: Contaq Microsystems 82c693
    Flags: bus master, medium devsel, latency 0

0000:00:05.1 IDE interface: Contaq Microsystems 82c693 (prog-if 80 [Master])
    Flags: bus master, medium devsel, latency 0, IRQ 14
    I/O ports at 01f0 [size=8]
    I/O ports at 03f4 [size=1]
    [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] 
[size=8]
    [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] 
[size=1]
    I/O ports at 9000 [size=16]

0000:00:05.2 IDE interface: Contaq Microsystems 82c693 (prog-if 00 [])
    Flags: bus master, medium devsel, latency 0, IRQ 15
    I/O ports at 01f0 [size=8]
    I/O ports at 03f4 [size=1]
    [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] 
[size=8]
    [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] 
[size=1]
    Memory at 0a220000 (32-bit, non-prefetchable) [disabled] [size=64K]

0000:00:05.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10 [OHCI])
    Flags: bus master, medium devsel, latency 248, IRQ 10
    Memory at 0a240000 (32-bit, non-prefetchable) [size=4K]

0000:00:07.0 VGA compatible controller: Texas Instruments TVP4020 
[Permedia 2] (rev 01) (prog-if 00 [VGA])
    Subsystem: Elsa AG GLoria Synergy
    Flags: bus master, medium devsel, latency 255, IRQ 31
    Memory at 0a200000 (32-bit, non-prefetchable) [size=128K]
    Memory at 09000000 (32-bit, non-prefetchable) [size=8M]
    Memory at 09800000 (32-bit, non-prefetchable) [size=8M]
    Expansion ROM at 0a230000 [disabled] [size=64K]

0000:00:08.0 PCI bridge: Digital Equipment Corporation DECchip 21152 
(rev 03) (prog-if 00 [Normal decode])
    Flags: bus master, medium devsel, latency 255
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=255
    I/O behind bridge: 00008000-00008fff
    Memory behind bridge: 0a000000-0a0fffff
    Prefetchable memory behind bridge: 000000000a100000-000000000a1fffff
    Capabilities: [dc] Power Management version 1

0000:01:00.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 
(rev 04)
    Flags: bus master, medium devsel, latency 255, IRQ 27
    I/O ports at 8000 [size=256]
    Memory at 0a002000 (32-bit, non-prefetchable) [size=256]
    Memory at 0a000000 (32-bit, non-prefetchable) [size=4K]
    Expansion ROM at 0a140000 [disabled] [size=64K]

0000:01:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 
(rev 04)
    Flags: bus master, medium devsel, latency 255, IRQ 26
    I/O ports at 8400 [size=256]
    Memory at 0a003000 (32-bit, non-prefetchable) [size=256]
    Memory at 0a001000 (32-bit, non-prefetchable) [size=4K]
    Expansion ROM at 0a150000 [disabled] [size=64K]

0000:01:02.0 Ethernet controller: Digital Equipment Corporation DECchip 
21140 [FasterNet] (rev 22)
    Subsystem: Digital Equipment Corporation Unknown device 500a
    Flags: bus master, medium devsel, latency 255, IRQ 25
    I/O ports at 8800 [size=128]
    Memory at 0a004000 (32-bit, non-prefetchable) [size=128]
    Expansion ROM at 0a100000 [disabled] [size=256K]

0001:02:07.0 Mass storage controller: Silicon Image, Inc. SiI 3124 PCI-X 
Serial ATA Controller (rev 02)
    Subsystem: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller
    Flags: bus master, stepping, 66MHz, medium devsel, latency 240, IRQ 47
    Memory at 209089000 (64-bit, non-prefetchable) [size=128]
    Memory at 209080000 (64-bit, non-prefetchable) [size=32K]
    I/O ports at 200008820 [size=16]
    Expansion ROM at 209000000 [disabled] [size=512K]
    Capabilities: [64] Power Management version 2
    Capabilities: [40] PCI-X non-bridge device
    Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+ 
Queue=0/0 Enable-

0001:02:08.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID 
Controller (rev 50)
    Subsystem: VIA Technologies, Inc. VT6421 IDE RAID Controller
    Flags: bus master, medium devsel, latency 240, IRQ 43
    I/O ports at 200008830 [size=16]
    I/O ports at 200008840 [size=16]
    I/O ports at 200008850 [size=16]
    I/O ports at 200008860 [size=16]
    I/O ports at 200008800 [size=32]
    I/O ports at 200008000 [size=256]
    Capabilities: [e0] Power Management version 2

0001:02:09.0 Ethernet controller: VIA Technologies, Inc. 
VT6120/VT6121/VT6122 Gigabit Ethernet Adapter (rev 01)
    Subsystem: ZyXEL Communication Corporation Unknown device 3302
    Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 39
    I/O ports at 200008400 [size=256]
    Memory at 209088000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [50] Power Management version 2
