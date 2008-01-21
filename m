From: Thomas Evans <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Mon, 21 Jan 2008 11:42:51 -0500
Message-ID: <4794CB8B.1070600@gmail.com>
References: <4794459C.3090200@gmail.com> <47944913.6000603@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000907020604060506050703"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.227]:22096 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbYAUQm4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 11:42:56 -0500
Received: by wr-out-0506.google.com with SMTP id c49so623281wra.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 08:42:55 -0800 (PST)
In-Reply-To: <47944913.6000603@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------000907020604060506050703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Up to now, it sounds very much like hardware failure.
>
>   
My thoughts as well until I ran the experiments ...
>> I went so far as to try a new 3124 based card, new cable and I even
>> found a copy of the eSata PMP enclosure at a local store to swap that
>> out (gotta return it all - way expensive).
>>     
>
> What do you mean by eSata PMP enclosure?  Is it a different PMP device?
>
>   
It is an external PMP box, 5 drive bays - it is the exact same 
manufacturer and is based on the same PMP:
0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
>> I can hook the card and storage enclosure to a windows box and can see
>> the PM and the drives (and the config space).
>>     
>
> Hmmm.......
>   
Yeah - I was perplexed at this point as well ...  I even upgraded the 
BIOS in the card, just hoping ...
>> The 1 thing I did do was attempt to migrate the machine from a DS20 to a
>> DS20L.
>>     
>
> What are DS20 and DS20L?
>
>   
They are Alpha system variations - DS20L is a 1U version of a DS20 (with 
many updates).

> That's one weird story.  I don't have much idea at this point.  Can you
> try to grab failing kernel log and post it?  You can either connect a
> harddrive directly, get a system up from there and grab failing
> detection log or set up serial or netconsole.
>   
I've attached a few logs - one that references how things looked when it 
all worked.
I've logs of both the original Norco 4618 card (lspci64.2 and 
dmesg.txt.2) and with the
newer generic 3124 card (dmesg.txt.newcard lspci.newcard.2).

I'm not so good with deciphering the PCI-isms - maybe I just need a 
shorter cable now!?

...tom



--------------000907020604060506050703
Content-Type: text/plain;
 name="dmesg.works"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.works"

[4194001.852669] Linux version 2.6.24-rc8-ds20 (root@chronictown) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #9 SMP Sat Jan 19 10:47:18 EST 2008
[4194001.852669] Booting on Tsunami variation Goldrush using machine vector DP264 from SRM
[4194001.852669] Major Options: SMP LEGACY_START VERBOSE_MCHECK DISCONTIGMEM MAGIC_SYSRQ 
[4194001.852669] Command line: ro root=/dev/sda3 ide=reverse
[4194001.852669] Raw memory layout:
[4194001.852669]  memcluster  0, usage 1, start        0, end      256
[4194001.852669]  memcluster  1, usage 0, start      256, end   130976
[4194001.852669]  memcluster  2, usage 1, start   130976, end   131072
[4194001.852669] Initializing bootmem allocator on Node ID 0
[4194001.852669]  memcluster  1, usage 0, start      256, end   130976
[4194001.852669]  Detected node memory:   start      258, end   130976
[4194001.852669]  freeing pages 256:384
[4194001.852669]  freeing pages 1255:130976
[4194001.852669]  reserving pages 1255:1257
[4194001.852669] 4096K Bcache detected; load hit latency 20 cycles, load miss latency 107 cycles
[4194001.852669] Console graphics on hose 0
[4194001.852669] SMP: 2 CPUs probed -- cpu_present_map = 3
[4194001.852669] On node 0 totalpages: 130976
[4194001.852669]   DMA zone: 895 pages used for memmap
[4194001.852669]   DMA zone: 0 pages reserved
[4194001.852669]   DMA zone: 130081 pages, LIFO batch:15
[4194001.852669]   Normal zone: 0 pages used for memmap
[4194001.852669]   Movable zone: 0 pages used for memmap
[4194001.852669] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130081
[4194001.852669] Kernel command line: ro root=/dev/sda3 ide=reverse
[4194001.852669] PID hash table entries: 4096 (order: 12, 32768 bytes)
[4194001.852669] Using epoch = 1952
[4194001.855599] Console: colour VGA+ 80x25
[4194001.855599] console [tty0] enabled
[4194001.860482] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[4194001.863412] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[4194001.910287] Memory: 1027192k/1045760k available (3339k kernel code, 17936k reserved, 243k data, 192k init)
[4194001.911263] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.929818] Mount-cache hash table entries: 512
[4194001.930794] SMP starting up secondaries.
[4194001.937630] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.956185] Brought up 2 CPUs
[4194001.956185] SMP: Total of 2 processors activated (1998.25 BogoMIPS).
[4194001.957162] net_namespace: 120 bytes
[4194001.958138] xor: automatically using best checksumming function: alpha prefetch
[4194001.963021]    alpha prefetch:  2064.384 MB/sec
[4194001.963021] xor: using function: alpha prefetch (2064.384 MB/sec)
[4194001.963021] NET: Registered protocol family 16
[4194001.968880] PCI: Bridge: 0000:00:08.0
[4194001.968880]   IO window: 8000-8fff
[4194001.968880]   MEM window: 09800000-098fffff
[4194001.968880]   PREFETCH window: 09900000-099fffff
[4194001.968880] SMC37c669 Super I/O Controller found @ 0x3f0
[4194001.972787] Linux Plug and Play Support v0.97 (c) Adam Belay
[4194001.974740] SCSI subsystem initialized
[4194001.974740] libata version 3.00 loaded.
[4194001.983529] NET: Registered protocol family 2
[4194001.995248] IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
[4194001.996224] TCP established hash table entries: 32768 (order: 6, 524288 bytes)
[4194001.997201] TCP bind hash table entries: 32768 (order: 6, 524288 bytes)
[4194001.998177] TCP: Hash tables configured (established 32768 bind 32768)
[4194001.998177] TCP reno registered
[4194002.004037] srm_env: version 0.0.6 loaded successfully
[4194002.005990] async_tx: api initialized (sync-only)
[4194002.005990] io scheduler noop registered
[4194002.005990] io scheduler anticipatory registered (default)
[4194002.005990] io scheduler deadline registered
[4194002.005990] isapnp: Scanning for PnP cards...
[4194002.361458] isapnp: No Plug & Play device found
[4194002.479622] rtc: Digital UNIX epoch (1952) detected
[4194002.479622] Real Time Clock Driver v1.12ac
[4194002.479622] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[4194002.480599] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4194002.480599] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4194002.482552] Floppy drive(s): fd0 is 2.88M
[4194002.499153] FDC 0 is a post-1991 82077
[4194002.501107] nbd: registered device at major 43
[4194002.505013] Loading iSCSI transport class v2.0-724.
[4194002.667122] sym0: <875> rev 0x4 at pci 0000:01:00.0 irq 27
[4194002.754036] sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194002.754036] sym0: open drain IRQ line driver, using on-chip SRAM
[4194002.754036] sym0: using LOAD/STORE-based firmware.
[4194002.755013] sym0: SCSI BUS has been reset.
[4194002.761849] scsi0 : sym-2.2.3
[4194002.922981] sym1: <875> rev 0x4 at pci 0000:01:01.0 irq 26
[4194003.009895] sym1: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194003.009895] sym1: open drain IRQ line driver, using on-chip SRAM
[4194003.009895] sym1: using LOAD/STORE-based firmware.
[4194003.010872] sym1: SCSI BUS has been reset.
[4194003.017708] scsi1 : sym-2.2.3
[4194003.017708] Driver 'sd' needs updating - please use bus_type methods
[4194003.018684] Driver 'sr' needs updating - please use bus_type methods
[4194003.018684] sata_via 0001:02:08.0: version 2.3
[4194003.019661] sata_via 0001:02:08.0: routed to hard irq line 11
[4194003.019661] scsi2 : sata_via
[4194003.019661] scsi3 : sata_via
[4194003.020638] scsi4 : sata_via
[4194003.020638] ata1: SATA max UDMA/133 port i16@0x200008820 bmdma 0x200008800 irq 43
[4194003.020638] ata2: SATA max UDMA/133 port i16@0x200008830 bmdma 0x200008808 irq 43
[4194003.021614] ata3: PATA max UDMA/133 port i16@0x200008840 bmdma 0x200008810 irq 43
[4194003.325325] ata1: SATA link down (SStatus 0 SControl 310)
[4194003.639778] ata2: SATA link down (SStatus 0 SControl 310)
[4194003.819465] serio: i8042 KBD port at 0x60,0x64 irq 1
[4194003.819465] serio: i8042 AUX port at 0x60,0x64 irq 12
[4194003.820442] mice: PS/2 mouse device common for all mice
[4194004.379035] input: AT Raw Set 2 keyboard as /class/input/input0
[4194004.398567] atkbd.c: keyboard reset failed on isa0060/serio1
[4194004.428840] md: linear personality registered for level -1
[4194004.428840] md: raid0 personality registered for level 0
[4194004.428840] md: raid1 personality registered for level 1
[4194004.430793] md: raid10 personality registered for level 10
[4194004.447395] raid6: int64x1    464 MB/s
[4194004.463996] raid6: int64x2    640 MB/s
[4194004.480598] raid6: int64x4    748 MB/s
[4194004.497199] raid6: int64x8    472 MB/s
[4194004.497199] raid6: using algorithm int64x4 (748 MB/s)
[4194004.497199] md: raid6 personality registered for level 6
[4194004.497199] md: raid5 personality registered for level 5
[4194004.497199] md: raid4 personality registered for level 4
[4194004.497199] md: multipath personality registered for level -4
[4194004.497199] md: faulty personality registered for level -5
[4194004.497199] TCP cubic registered
[4194004.499152] NET: Registered protocol family 1
[4194004.499152] NET: Registered protocol family 10
[4194004.499152] lo: Disabled Privacy Extensions
[4194004.500129] NET: Registered protocol family 17
[4194004.501106] scsi: waiting for bus probes to complete ...
[4194006.296027] scsi 1:0:1:0: Direct-Access     FUJITSU  MAJ3091MP        5508 PQ: 0 ANSI: 4
[4194006.296027]  target1:0:1: tagged command queuing enabled, command queue depth 16.
[4194006.296027]  target1:0:1: Beginning Domain Validation
[4194006.297003]  target1:0:1: asynchronous
[4194006.298956]  target1:0:1: wide asynchronous
[4194006.300909]  target1:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
[4194006.301886]  target1:0:1: Domain Validation skipping write tests
[4194006.301886]  target1:0:1: Ending Domain Validation
[4194006.927862] scsi 0:0:4:0: Sequential-Access ARCHIVE  Python 04106-XXX 743B PQ: 0 ANSI: 2
[4194006.927862]  target0:0:4: Beginning Domain Validation
[4194006.932745]  target0:0:4: asynchronous
[4194006.953253]  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[4194006.964972]  target0:0:4: Domain Validation skipping write tests
[4194006.964972]  target0:0:4: Ending Domain Validation
[4194009.946415] scsi 0:0:4:0: Attached scsi generic sg0 type 1
[4194010.129032] sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
[4194010.131962] sd 1:0:1:0: [sda] Write Protect is off
[4194010.131962] sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
[4194010.133915] sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[4194010.134892] sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
[4194010.137821] sd 1:0:1:0: [sda] Write Protect is off
[4194010.137821] sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
[4194010.138798] sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[4194010.139775]  sda: sda1 sda2 sda3 sda4
[4194010.145634] sd 1:0:1:0: [sda] Attached SCSI disk
[4194010.146611] sd 1:0:1:0: Attached scsi generic sg1 type 0
[4194010.146611] md: Autodetecting RAID arrays.
[4194010.146611] md: Scanned 0 and added 0 devices.
[4194010.146611] md: autorun ...
[4194010.147587] md: ... autorun DONE.
[4194010.159306] EXT3-fs: INFO: recovery required on readonly filesystem.
[4194010.159306] EXT3-fs: write access will be enabled during recovery.
[4194017.255982] kjournald starting.  Commit interval 5 seconds
[4194017.255982] EXT3-fs: sda3: orphan cleanup on readonly fs
[4194017.255982] ext3_orphan_cleanup: deleting unreferenced inode 468352
[4194017.296021] ext3_orphan_cleanup: deleting unreferenced inode 54283
[4194017.311646] ext3_orphan_cleanup: deleting unreferenced inode 54282
[4194017.318482] ext3_orphan_cleanup: deleting unreferenced inode 54280
[4194017.326294] ext3_orphan_cleanup: deleting unreferenced inode 54274
[4194017.326294] ext3_orphan_cleanup: deleting unreferenced inode 54267
[4194017.328247] ext3_orphan_cleanup: deleting unreferenced inode 469943
[4194017.335083] ext3_orphan_cleanup: deleting unreferenced inode 48454
[4194017.341919] EXT3-fs: sda3: 8 orphan inodes deleted
[4194017.342896] EXT3-fs: recovery complete.
[4194017.367310] EXT3-fs: mounted filesystem with ordered data mode.
[4194017.367310] VFS: Mounted root (ext3 filesystem) readonly.
[4194017.368287] Freeing unused kernel memory: 192k freed
[4194020.466918] Adding 1976560k swap on /dev/sda4.  Priority:-1 extents:1 across:1976560k
[4194020.820433] EXT3 FS on sda3, internal journal
[4194022.225706] sata_sil24 0000:00:07.0: version 1.1
[4194022.229612] scsi5 : sata_sil24
[4194022.242307] scsi6 : sata_sil24
[4194022.263792] scsi7 : sata_sil24
[4194022.283323] scsi8 : sata_sil24
[4194022.295042] ata4: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
[4194022.295042] ata5: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
[4194022.295042] ata6: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
[4194022.295042] ata7: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
[4194024.462033] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194024.462033] ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[4194024.463009] ata4.00: hard resetting link
[4194024.770626] ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[4194024.770626] ata4.01: hard resetting link
[4194025.078243] ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[4194025.078243] ata4.02: hard resetting link
[4194025.385861] ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[4194025.385861] ata4.03: hard resetting link
[4194025.693478] ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[4194025.693478] ata4.04: hard resetting link
[4194026.001095] ata4.04: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[4194026.001095] ata4.05: hard resetting link
[4194026.308712] ata4.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194026.308712] ata4.06: hard resetting link
[4194026.616329] ata4.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[4194026.631954] ata4.00: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194026.631954] ata4.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194026.632930] ata4.00: configured for UDMA/100
[4194026.639766] ata4.01: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194026.639766] ata4.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194026.640743] ata4.01: configured for UDMA/100
[4194026.650508] ata4.02: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194026.651485] ata4.02: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194026.652461] ata4.02: configured for UDMA/100
[4194026.661251] ata4.03: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194026.661251] ata4.03: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194026.662227] ata4.03: configured for UDMA/100
[4194026.668086] ata4.04: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194026.668086] ata4.04: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194026.669063] ata4.04: configured for UDMA/100
[4194026.670040] ata4.05: ATA-6: Config  Disk, PLS12052, max UDMA/133
[4194026.670040] ata4.05: 640 sectors, multi 1: LBA 
[4194026.670040] ata4.05: device is on DMA blacklist, disabling DMA
[4194026.670040] ata4.05: configured for PIO4
[4194026.670040] ata4: EH complete
[4194028.721796] ata5: SATA link down (SStatus 0 SControl 0)
[4194030.772577] ata6: SATA link down (SStatus 0 SControl 0)
[4194032.822380] ata7: SATA link down (SStatus 0 SControl 0)
[4194032.822380] scsi 5:0:0:0: Direct-Access     ATA      WDC WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194032.833122] sd 5:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
[4194032.834099] sd 5:0:0:0: [sdb] Write Protect is off
[4194032.834099] sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[4194032.834099] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194032.834099] sd 5:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
[4194032.835075] sd 5:0:0:0: [sdb] Write Protect is off
[4194032.835075] sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[4194032.835075] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194032.835075]  sdb: sdb1
[4194032.857536] sd 5:0:0:0: [sdb] Attached SCSI disk
[4194032.884880] sd 5:0:0:0: Attached scsi generic sg2 type 0
[4194032.885857] scsi 5:1:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194032.905388] sd 5:1:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[4194032.905388] sd 5:1:0:0: [sdc] Write Protect is off
[4194032.905388] sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[4194032.905388] sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194032.906364] sd 5:1:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[4194032.906364] sd 5:1:0:0: [sdc] Write Protect is off
[4194032.906364] sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[4194032.906364] sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194032.906364]  sdc: sdc1
[4194032.943474] sd 5:1:0:0: [sdc] Attached SCSI disk
[4194032.987419] sd 5:1:0:0: Attached scsi generic sg3 type 0
[4194032.987419] scsi 5:2:0:0: Direct-Access     ATA      WDC WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194033.068474] sd 5:2:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
[4194033.068474] sd 5:2:0:0: [sdd] Write Protect is off
[4194033.068474] sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[4194033.068474] sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194033.069450] sd 5:2:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
[4194033.069450] sd 5:2:0:0: [sdd] Write Protect is off
[4194033.069450] sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[4194033.069450] sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194033.070427]  sdd: sdd1
[4194033.134880] sd 5:2:0:0: [sdd] Attached SCSI disk
[4194033.222771] sd 5:2:0:0: Attached scsi generic sg4 type 0
[4194033.223747] scsi 5:3:0:0: Direct-Access     ATA      WDC WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194033.274528] sd 5:3:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[4194033.274528] sd 5:3:0:0: [sde] Write Protect is off
[4194033.274528] sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
[4194033.274528] sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194033.275505] sd 5:3:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[4194033.275505] sd 5:3:0:0: [sde] Write Protect is off
[4194033.275505] sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
[4194033.275505] sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194033.276481]  sde: sde1
[4194033.333122] sd 5:3:0:0: [sde] Attached SCSI disk
[4194033.392692] sd 5:3:0:0: Attached scsi generic sg5 type 0
[4194033.393669] scsi 5:4:0:0: Direct-Access     ATA      WDC WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194033.449333] sd 5:4:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
[4194033.450310] sd 5:4:0:0: [sdf] Write Protect is off
[4194033.450310] sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[4194033.450310] sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194033.450310] sd 5:4:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
[4194033.451286] sd 5:4:0:0: [sdf] Write Protect is off
[4194033.451286] sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[4194033.451286] sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194033.451286]  sdf: sdf1
[4194033.516716] sd 5:4:0:0: [sdf] Attached SCSI disk
[4194033.574333] sd 5:4:0:0: Attached scsi generic sg6 type 0
[4194033.574333] scsi 5:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[4194033.627067] sd 5:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
[4194033.627067] sd 5:5:0:0: [sdg] Write Protect is off
[4194033.627067] sd 5:5:0:0: [sdg] Mode Sense: 00 3a 00 00
[4194033.627067] sd 5:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[4194033.628044] sd 5:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
[4194033.628044] sd 5:5:0:0: [sdg] Write Protect is off
[4194033.628044] sd 5:5:0:0: [sdg] Mode Sense: 00 3a 00 00
[4194033.628044] sd 5:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[4194033.629020]  sdg: unknown partition table
[4194033.669059] sd 5:5:0:0: [sdg] Attached SCSI disk
[4194033.732536] sd 5:5:0:0: Attached scsi generic sg7 type 0
[4194033.826286] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4194033.826286] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4194034.300895] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
[4194035.301871] md: md2 stopped.
[4194035.457144] md: bind<sdf1>
[4194035.457144] md: bind<sdd1>
[4194035.458121] md: bind<sdb1>
[4194035.458121] md: bind<sdc1>
[4194035.459098] md: bind<sde1>
[4194035.477652] raid5: device sde1 operational as raid disk 0
[4194035.477652] raid5: device sdc1 operational as raid disk 4
[4194035.477652] raid5: device sdb1 operational as raid disk 3
[4194035.477652] raid5: device sdd1 operational as raid disk 2
[4194035.477652] raid5: device sdf1 operational as raid disk 1
[4194035.480582] raid5: allocated 10444kB for md2
[4194035.480582] raid5: raid level 6 set md2 active with 5 out of 5 devices, algorithm 2
[4194035.480582] RAID5 conf printout:
[4194035.480582]  --- rd:5 wd:5
[4194035.480582]  disk 0, o:1, dev:sde1
[4194035.480582]  disk 1, o:1, dev:sdf1
[4194035.480582]  disk 2, o:1, dev:sdd1
[4194035.480582]  disk 3, o:1, dev:sdb1
[4194035.480582]  disk 4, o:1, dev:sdc1
[4194039.921986] kjournald starting.  Commit interval 5 seconds
[4194039.937611] EXT3 FS on md2, internal journal
[4194039.937611] EXT3-fs: mounted filesystem with ordered data mode.
[4194041.354602] VIA Networking Velocity Family Gigabit Ethernet Adapter Driver Ver. 1.14
[4194041.355579] Copyright (c) 2002, 2003 VIA Networking Technologies, Inc.
[4194041.355579] Copyright (c) 2004 Red Hat Inc.
[4194041.367298] eth0: VIA Networking Velocity Family Gigabit Ethernet Adapter
[4194041.367298] eth0: Ethernet Address: 00:13:49:12:44:DD
[4194043.787218] usbcore: registered new interface driver usbfs
[4194043.810656] usbcore: registered new interface driver hub
[4194043.827257] usbcore: registered new device driver usb
[4194043.857531] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[4194043.887804] ohci_hcd 0000:00:05.3: OHCI Host Controller
[4194043.909289] ohci_hcd 0000:00:05.3: new USB bus registered, assigned bus number 1
[4194043.909289] ohci_hcd 0000:00:05.3: irq 10, io mem 0x09aa8000
[4194044.015734] usb usb1: configuration #1 chosen from 1 choice
[4194044.027453] hub 1-0:1.0: USB hub found
[4194044.027453] hub 1-0:1.0: 2 ports detected
[4194045.468858] Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
[4194045.512803] tulip0:  EEPROM default media type Autosense.
[4194045.513780] tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
[4194045.520616] tulip0:  MII transceiver #5 config 2100 status 784b advertising 01e1.
[4194045.547960] eth1: Digital DS21140 Tulip rev 34 at MMIO 0x9804000, 00:06:2b:00:d8:05, IRQ 25.
[4194047.437607] st: Version 20070203, fixed bufsize 32768, s/g segs 256
[4194047.450302] Driver 'st' needs updating - please use bus_type methods
[4194047.591904] st 0:0:4:0: Attached scsi tape st0
[4194047.591904] st 0:0:4:0: st0: try direct i/o: yes (alignment 512 B)
[4194048.758895] Velocity is AUTO mode
[4194048.768661] ADDRCONF(NETDEV_UP): eth0: link is not ready
[4194051.797956] eth0: Link auto-negotiation speed 1000M bps full duplex
[4194051.800886] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready

--------------000907020604060506050703
Content-Type: message/delivery-status;
 name="dmesg.txt.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt.2"


[4194001.852669] Linux version 2.6.24-rc8-ds20 (root@chronictown) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #9 SMP Sat Jan 19 10:47:18 EST 2008
[4194001.852669] Booting on Tsunami variation Goldrush using machine vector DP264 from SRM
[4194001.852669] Major Options: SMP LEGACY_START VERBOSE_MCHECK DISCONTIGMEM MAGIC_SYSRQ 
[4194001.852669] Command line: ro root=/dev/sda3 ide=reverse
[4194001.852669] Raw memory layout:
[4194001.852669]  memcluster  0, usage 1, start        0, end      256
[4194001.852669]  memcluster  1, usage 0, start      256, end   130976
[4194001.852669]  memcluster  2, usage 1, start   130976, end   131072
[4194001.852669] Initializing bootmem allocator on Node ID 0
[4194001.852669]  memcluster  1, usage 0, start      256, end   130976
[4194001.852669]  Detected node memory:   start      258, end   130976
[4194001.852669]  freeing pages 256:384
[4194001.852669]  freeing pages 1255:130976
[4194001.852669]  reserving pages 1255:1257
[4194001.852669] 4096K Bcache detected; load hit latency 20 cycles, load miss latency 114 cycles
[4194001.852669] Console graphics on hose 0
[4194001.852669] SMP: 2 CPUs probed -- cpu_present_map = 3
[4194001.852669] On node 0 totalpages: 130976
[4194001.852669]   DMA zone: 895 pages used for memmap
[4194001.852669]   DMA zone: 0 pages reserved
[4194001.852669]   DMA zone: 130081 pages, LIFO batch:15
[4194001.852669]   Normal zone: 0 pages used for memmap
[4194001.852669]   Movable zone: 0 pages used for memmap
[4194001.852669] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130081
[4194001.852669] Kernel command line: ro root=/dev/sda3 ide=reverse
[4194001.852669] PID hash table entries: 4096 (order: 12, 32768 bytes)
[4194001.852669] Using epoch = 1952
[4194001.855599] Console: colour VGA+ 80x25
[4194001.855599] console [tty0] enabled
[4194001.860482] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[4194001.863412] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[4194001.908333] Memory: 1027192k/1045760k available (3339k kernel code, 17936k reserved, 243k data, 192k init)
[4194001.909310] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.927865] Mount-cache hash table entries: 512
[4194001.928841] SMP starting up secondaries.
[4194001.935677] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.954232] Brought up 2 CPUs
[4194001.954232] SMP: Total of 2 processors activated (1998.25 BogoMIPS).
[4194001.955208] net_namespace: 120 bytes
[4194001.956185] xor: automatically using best checksumming function: alpha prefetch
[4194001.962044]    alpha prefetch:  2064.384 MB/sec
[4194001.962044] xor: using function: alpha prefetch (2064.384 MB/sec)
[4194001.962044] NET: Registered protocol family 16
[4194001.966927] PCI: Bridge: 0000:00:08.0
[4194001.966927]   IO window: 8000-8fff
[4194001.966927]   MEM window: 09800000-098fffff
[4194001.967904]   PREFETCH window: 09900000-099fffff
[4194001.967904] SMC37c669 Super I/O Controller found @ 0x3f0
[4194001.971810] Linux Plug and Play Support v0.97 (c) Adam Belay
[4194001.972787] SCSI subsystem initialized
[4194001.973763] libata version 3.00 loaded.
[4194001.979623] NET: Registered protocol family 2
[4194001.991341] IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
[4194001.992318] TCP established hash table entries: 32768 (order: 6, 524288 bytes)
[4194001.993294] TCP bind hash table entries: 32768 (order: 6, 524288 bytes)
[4194001.994271] TCP: Hash tables configured (established 32768 bind 32768)
[4194001.994271] TCP reno registered
[4194001.999154] srm_env: version 0.0.6 loaded successfully
[4194002.002083] async_tx: api initialized (sync-only)
[4194002.002083] io scheduler noop registered
[4194002.002083] io scheduler anticipatory registered (default)
[4194002.002083] io scheduler deadline registered
[4194002.002083] isapnp: Scanning for PnP cards...
[4194002.357552] isapnp: No Plug & Play device found
[4194002.478646] rtc: Digital UNIX epoch (1952) detected
[4194002.478646] Real Time Clock Driver v1.12ac
[4194002.478646] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[4194002.479622] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4194002.479622] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4194002.481575] Floppy drive(s): fd0 is 2.88M
[4194002.498177] FDC 0 is a post-1991 82077
[4194002.500130] nbd: registered device at major 43
[4194002.504036] Loading iSCSI transport class v2.0-724.
[4194002.666146] sym0: <875> rev 0x4 at pci 0000:01:00.0 irq 27
[4194002.753060] sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194002.753060] sym0: open drain IRQ line driver, using on-chip SRAM
[4194002.753060] sym0: using LOAD/STORE-based firmware.
[4194002.754036] sym0: SCSI BUS has been reset.
[4194002.760872] scsi0 : sym-2.2.3
[4194002.922005] sym1: <875> rev 0x4 at pci 0000:01:01.0 irq 26
[4194003.008919] sym1: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194003.008919] sym1: open drain IRQ line driver, using on-chip SRAM
[4194003.008919] sym1: using LOAD/STORE-based firmware.
[4194003.008919] sym1: SCSI BUS has been reset.
[4194003.016731] scsi1 : sym-2.2.3
[4194003.016731] Driver 'sd' needs updating - please use bus_type methods
[4194003.016731] Driver 'sr' needs updating - please use bus_type methods
[4194003.023567] serio: i8042 KBD port at 0x60,0x64 irq 1
[4194003.023567] serio: i8042 AUX port at 0x60,0x64 irq 12
[4194003.023567] mice: PS/2 mouse device common for all mice
[4194003.583137] input: AT Raw Set 2 keyboard as /class/input/input0
[4194003.602669] atkbd.c: keyboard reset failed on isa0060/serio1
[4194003.632942] md: linear personality registered for level -1
[4194003.632942] md: raid0 personality registered for level 0
[4194003.632942] md: raid1 personality registered for level 1
[4194003.633919] md: raid10 personality registered for level 10
[4194003.650520] raid6: int64x1    468 MB/s
[4194003.667122] raid6: int64x2    640 MB/s
[4194003.683723] raid6: int64x4    744 MB/s
[4194003.700325] raid6: int64x8    472 MB/s
[4194003.700325] raid6: using algorithm int64x4 (744 MB/s)
[4194003.700325] md: raid6 personality registered for level 6
[4194003.700325] md: raid5 personality registered for level 5
[4194003.700325] md: raid4 personality registered for level 4
[4194003.700325] md: multipath personality registered for level -4
[4194003.700325] md: faulty personality registered for level -5
[4194003.700325] TCP cubic registered
[4194003.701301] NET: Registered protocol family 1
[4194003.701301] NET: Registered protocol family 10
[4194003.702278] lo: Disabled Privacy Extensions
[4194003.703254] NET: Registered protocol family 17
[4194003.704231] scsi: waiting for bus probes to complete ...
[4194006.295050] scsi 1:0:1:0: Direct-Access     FUJITSU  MAJ3091MP        5508 PQ: 0 ANSI: 4
[4194006.295050]  target1:0:1: tagged command queuing enabled, command queue depth 16.
[4194006.295050]  target1:0:1: Beginning Domain Validation
[4194006.295050]  target1:0:1: asynchronous
[4194006.297980]  target1:0:1: wide asynchronous
[4194006.298956]  target1:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
[4194006.300909]  target1:0:1: Domain Validation skipping write tests
[4194006.300909]  target1:0:1: Ending Domain Validation
[4194006.926886] scsi 0:0:4:0: Sequential-Access ARCHIVE  Python 04106-XXX 743B PQ: 0 ANSI: 2
[4194006.926886]  target0:0:4: Beginning Domain Validation
[4194006.931768]  target0:0:4: asynchronous
[4194006.952276]  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[4194006.963995]  target0:0:4: Domain Validation skipping write tests
[4194006.964972]  target0:0:4: Ending Domain Validation
[4194009.945439] scsi 0:0:4:0: Attached scsi generic sg0 type 1
[4194010.127079] sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
[4194010.130986] sd 1:0:1:0: [sda] Write Protect is off
[4194010.130986] sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
[4194010.131962] sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[4194010.132939] sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
[4194010.135868] sd 1:0:1:0: [sda] Write Protect is off
[4194010.135868] sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
[4194010.137821] sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[4194010.137821]  sda: sda1 sda2 sda3 sda4
[4194010.144657] sd 1:0:1:0: [sda] Attached SCSI disk
[4194010.144657] sd 1:0:1:0: Attached scsi generic sg1 type 0
[4194010.145634] md: Autodetecting RAID arrays.
[4194010.145634] md: Scanned 0 and added 0 devices.
[4194010.145634] md: autorun ...
[4194010.145634] md: ... autorun DONE.
[4194010.158329] EXT3-fs: INFO: recovery required on readonly filesystem.
[4194010.158329] EXT3-fs: write access will be enabled during recovery.
[4194010.738407] kjournald starting.  Commit interval 5 seconds
[4194010.738407] EXT3-fs: recovery complete.
[4194010.739384] EXT3-fs: mounted filesystem with ordered data mode.
[4194010.739384] VFS: Mounted root (ext3 filesystem) readonly.
[4194010.740360] Freeing unused kernel memory: 192k freed
[4194013.887820] Adding 1976560k swap on /dev/sda4.  Priority:-1 extents:1 across:1976560k
[4194014.225710] EXT3 FS on sda3, internal journal
[4194015.227663] sata_sil24 0000:00:07.0: version 1.1
[4194015.234499] scsi2 : sata_sil24
[4194015.246217] scsi3 : sata_sil24
[4194015.258913] scsi4 : sata_sil24
[4194015.278444] scsi5 : sata_sil24
[4194015.295045] ata1: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
[4194015.295045] ata2: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
[4194015.296022] ata3: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
[4194015.296022] ata4: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
[4194017.463013] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194017.463013] ata1.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[4194017.463990] ata1.00: hard resetting link
[4194017.463990] ata1.00: failed to write SCR 2 (Emask=0x100)
[4194017.463990] ata1.00: failed to read SCR 2 (Emask=0x40)
[4194017.463990] ata1.00: COMRESET failed (errno=-5)
[4194017.463990] ata1.00: failed to read SCR 0 (Emask=0x40)
[4194017.463990] ata1.00: reset failed, giving up
[4194017.463990] ata1.15: hard resetting link
[4194019.615356] ata1.15: softreset failed (SRST command error)
[4194019.615356] ata1.15: reset failed (errno=-5), retrying in 8 secs
[4194027.464961] ata1.15: hard resetting link
[4194029.628046] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194029.628046] ata1.00: hard resetting link
[4194029.628046] ata1.00: failed to write SCR 2 (Emask=0x100)
[4194029.628046] ata1.00: failed to read SCR 2 (Emask=0x40)
[4194029.628046] ata1.00: COMRESET failed (errno=-5)
[4194029.629022] ata1.00: failed to read SCR 0 (Emask=0x40)
[4194029.629022] ata1.00: reset failed, giving up
[4194029.629022] ata1.15: hard resetting link
[4194031.779412] ata1.15: softreset failed (SRST command error)
[4194031.779412] ata1.15: reset failed (errno=-5), retrying in 8 secs
[4194039.629994] ata1.15: hard resetting link
[4194041.793079] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194041.793079] ata1.00: hard resetting link
[4194041.793079] ata1.00: failed to write SCR 2 (Emask=0x100)
[4194041.793079] ata1.00: failed to read SCR 2 (Emask=0x40)
[4194041.793079] ata1.00: COMRESET failed (errno=-5)
[4194041.793079] ata1.00: failed to read SCR 0 (Emask=0x40)
[4194041.794055] ata1.00: reset failed, giving up
[4194041.794055] ata1.00: failed to recover link after 3 tries, disabling
[4194041.794055] ata1: failed to recover PMP, retrying in 5 secs
[4194046.796006] ata1.15: hard resetting link
[4194048.947372] ata1.15: softreset failed (SRST command error)
[4194048.947372] ata1.15: reset failed (errno=-5), retrying in 8 secs
[4194056.796977] ata1.15: hard resetting link
[4194058.959086] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194058.959086] ata1.00: failed to write SCR 2 (Emask=0x100)
[4194058.959086] ata1.00: failed to read SCR 2 (Emask=0x40)
[4194058.959086] ata1.00: failed to write SCR 1 (Emask=0x40)
[4194058.959086] ata1.00: failed to clear SError.N (errno=-5)
[4194058.959086] ata1: failed to recover PMP, retrying in 5 secs
[4194063.962013] ata1.15: hard resetting link
[4194066.113379] ata1.15: softreset failed (SRST command error)
[4194066.113379] ata1.15: reset failed (errno=-5), retrying in 8 secs
[4194073.962984] ata1.15: hard resetting link
[4194076.125092] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194076.125092] ata1.00: failed to write SCR 2 (Emask=0x100)
[4194076.125092] ata1.00: failed to read SCR 2 (Emask=0x40)
[4194076.125092] ata1.00: failed to write SCR 1 (Emask=0x40)
[4194076.125092] ata1.00: failed to clear SError.N (errno=-5)
[4194076.126069] ata1: failed to recover PMP, retrying in 5 secs
[4194081.127043] ata1.15: hard resetting link
[4194083.279386] ata1.15: softreset failed (SRST command error)
[4194083.279386] ata1.15: reset failed (errno=-5), retrying in 8 secs
[4194091.128014] ata1.15: hard resetting link
[4194093.290123] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194093.290123] ata1.00: failed to write SCR 2 (Emask=0x100)
[4194093.290123] ata1.00: failed to read SCR 2 (Emask=0x40)
[4194093.290123] ata1.00: failed to write SCR 1 (Emask=0x40)
[4194093.290123] ata1.00: failed to clear SError.N (errno=-5)
[4194093.291099] ata1: failed to recover PMP, retrying in 5 secs
[4194098.293050] ata1.15: hard resetting link
[4194100.443439] ata1.15: softreset failed (SRST command error)
[4194100.443439] ata1.15: reset failed (errno=-5), retrying in 8 secs
[4194108.294021] ata1.15: hard resetting link
[4194110.457106] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194110.457106] ata1.00: failed to write SCR 2 (Emask=0x100)
[4194110.457106] ata1.00: failed to read SCR 2 (Emask=0x40)
[4194110.457106] ata1.00: failed to write SCR 1 (Emask=0x40)
[4194110.457106] ata1.00: failed to clear SError.N (errno=-5)
[4194110.457106] ata1: failed to recover PMP after 5 tries, giving up
[4194110.458083] ata1.15: Port Multiplier detaching
[4194110.458083] ata1.00: disabled
[4194110.458083] ata1: exception Emask 0x22 SAct 0x0 SErr 0x0 action 0x6 frozen t4
[4194110.458083] ata1: irq_stat 0x00020002, PCI parity error while fetching PRB
[4194110.458083] ata1: hard resetting link
[4194112.608472] ata1: softreset failed (SRST command error)
[4194112.608472] ata1: reset failed (errno=-5), retrying in 8 secs
[4194120.459054] ata1: hard resetting link
[4194122.623115] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[4194122.623115] ata1: EH complete
[4194124.671943] ata2: SATA link down (SStatus 0 SControl 0)
[4194126.719793] ata3: SATA link down (SStatus 0 SControl 0)
[4194128.767644] ata4: SATA link down (SStatus 0 SControl 0)
[4194128.818425] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4194128.818425] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4194129.223698] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
[4194130.283268] md: md2 stopped.
--------------000907020604060506050703
Content-Type: text/plain;
 name="dmesg.txt.newcard"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt.newcard"

[4194001.852669] Linux version 2.6.24-rc8-ds20 (root@chronictown) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #9 SMP Sat Jan 19 10:47:18 EST 2008
[4194001.852669] Booting on Tsunami variation Goldrush using machine vector DP264 from SRM
[4194001.852669] Major Options: SMP LEGACY_START VERBOSE_MCHECK DISCONTIGMEM MAGIC_SYSRQ 
[4194001.852669] Command line: ro root=/dev/sda3 ide=reverse
[4194001.852669] Raw memory layout:
[4194001.852669]  memcluster  0, usage 1, start        0, end      256
[4194001.852669]  memcluster  1, usage 0, start      256, end   130976
[4194001.852669]  memcluster  2, usage 1, start   130976, end   131072
[4194001.852669] Initializing bootmem allocator on Node ID 0
[4194001.852669]  memcluster  1, usage 0, start      256, end   130976
[4194001.852669]  Detected node memory:   start      258, end   130976
[4194001.852669]  freeing pages 256:384
[4194001.852669]  freeing pages 1255:130976
[4194001.852669]  reserving pages 1255:1257
[4194001.852669] 4096K Bcache detected; load hit latency 20 cycles, load miss latency 115 cycles
[4194001.852669] Console graphics on hose 0
[4194001.852669] SMP: 2 CPUs probed -- cpu_present_map = 3
[4194001.852669] On node 0 totalpages: 130976
[4194001.852669]   DMA zone: 895 pages used for memmap
[4194001.852669]   DMA zone: 0 pages reserved
[4194001.852669]   DMA zone: 130081 pages, LIFO batch:15
[4194001.852669]   Normal zone: 0 pages used for memmap
[4194001.852669]   Movable zone: 0 pages used for memmap
[4194001.852669] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130081
[4194001.852669] Kernel command line: ro root=/dev/sda3 ide=reverse
[4194001.852669] PID hash table entries: 4096 (order: 12, 32768 bytes)
[4194001.852669] Using epoch = 1952
[4194001.856576] Console: colour VGA+ 80x25
[4194001.856576] console [tty0] enabled
[4194001.861459] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[4194001.864388] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[4194001.911263] Memory: 1027192k/1045760k available (3339k kernel code, 17936k reserved, 243k data, 192k init)
[4194001.912240] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.930794] Mount-cache hash table entries: 512
[4194001.931771] SMP starting up secondaries.
[4194001.939583] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.958138] Brought up 2 CPUs
[4194001.958138] SMP: Total of 2 processors activated (1998.25 BogoMIPS).
[4194001.959115] net_namespace: 120 bytes
[4194001.960091] xor: automatically using best checksumming function: alpha prefetch
[4194001.964974]    alpha prefetch:  2064.384 MB/sec
[4194001.964974] xor: using function: alpha prefetch (2064.384 MB/sec)
[4194001.964974] NET: Registered protocol family 16
[4194001.969857] PCI: Bridge: 0000:00:07.0
[4194001.969857]   IO window: 8000-8fff
[4194001.969857]   MEM window: 09800000-098fffff
[4194001.969857]   PREFETCH window: 09900000-099fffff
[4194001.970833] SMC37c669 Super I/O Controller found @ 0x3f0
[4194001.974740] Linux Plug and Play Support v0.97 (c) Adam Belay
[4194001.975716] SCSI subsystem initialized
[4194001.975716] libata version 3.00 loaded.
[4194001.981576] NET: Registered protocol family 2
[4194001.994271] IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
[4194001.995248] TCP established hash table entries: 32768 (order: 6, 524288 bytes)
[4194001.996224] TCP bind hash table entries: 32768 (order: 6, 524288 bytes)
[4194001.997201] TCP: Hash tables configured (established 32768 bind 32768)
[4194001.998177] TCP reno registered
[4194002.002083] srm_env: version 0.0.6 loaded successfully
[4194002.005013] async_tx: api initialized (sync-only)
[4194002.005013] io scheduler noop registered
[4194002.005013] io scheduler anticipatory registered (default)
[4194002.005013] io scheduler deadline registered
[4194002.005013] isapnp: Scanning for PnP cards...
[4194002.359505] isapnp: No Plug & Play device found
[4194002.479622] rtc: Digital UNIX epoch (1952) detected
[4194002.479622] Real Time Clock Driver v1.12ac
[4194002.479622] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[4194002.479622] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4194002.481575] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4194002.481575] Floppy drive(s): fd0 is 2.88M
[4194002.499153] FDC 0 is a post-1991 82077
[4194002.501107] nbd: registered device at major 43
[4194002.505013] Loading iSCSI transport class v2.0-724.
[4194002.667122] sym0: <875> rev 0x4 at pci 0000:01:00.0 irq 31
[4194002.754036] sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194002.754036] sym0: open drain IRQ line driver, using on-chip SRAM
[4194002.754036] sym0: using LOAD/STORE-based firmware.
[4194002.755013] sym0: SCSI BUS has been reset.
[4194002.761849] scsi0 : sym-2.2.3
[4194002.922981] sym1: <875> rev 0x4 at pci 0000:01:01.0 irq 30
[4194003.009895] sym1: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194003.009895] sym1: open drain IRQ line driver, using on-chip SRAM
[4194003.009895] sym1: using LOAD/STORE-based firmware.
[4194003.009895] sym1: SCSI BUS has been reset.
[4194003.017708] scsi1 : sym-2.2.3
[4194003.017708] Driver 'sd' needs updating - please use bus_type methods
[4194003.017708] Driver 'sr' needs updating - please use bus_type methods
[4194003.024544] serio: i8042 KBD port at 0x60,0x64 irq 1
[4194003.024544] serio: i8042 AUX port at 0x60,0x64 irq 12
[4194003.024544] mice: PS/2 mouse device common for all mice
[4194003.582161] input: AT Raw Set 2 keyboard as /class/input/input0
[4194003.601692] atkbd.c: keyboard reset failed on isa0060/serio1
[4194003.631965] md: linear personality registered for level -1
[4194003.631965] md: raid0 personality registered for level 0
[4194003.631965] md: raid1 personality registered for level 1
[4194003.632942] md: raid10 personality registered for level 10
[4194003.649544] raid6: int64x1    468 MB/s
[4194003.666145] raid6: int64x2    640 MB/s
[4194003.682747] raid6: int64x4    736 MB/s
[4194003.699348] raid6: int64x8    472 MB/s
[4194003.699348] raid6: using algorithm int64x4 (736 MB/s)
[4194003.699348] md: raid6 personality registered for level 6
[4194003.699348] md: raid5 personality registered for level 5
[4194003.699348] md: raid4 personality registered for level 4
[4194003.699348] md: multipath personality registered for level -4
[4194003.699348] md: faulty personality registered for level -5
[4194003.699348] TCP cubic registered
[4194003.700325] NET: Registered protocol family 1
[4194003.700325] NET: Registered protocol family 10
[4194003.701301] lo: Disabled Privacy Extensions
[4194003.702278] NET: Registered protocol family 17
[4194003.703254] scsi: waiting for bus probes to complete ...
[4194006.296027] scsi 1:0:1:0: Direct-Access     FUJITSU  MAJ3091MP        5508 PQ: 0 ANSI: 4
[4194006.297003]  target1:0:1: tagged command queuing enabled, command queue depth 16.
[4194006.297003]  target1:0:1: Beginning Domain Validation
[4194006.297003]  target1:0:1: asynchronous
[4194006.299933]  target1:0:1: wide asynchronous
[4194006.300909]  target1:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
[4194006.302862]  target1:0:1: Domain Validation skipping write tests
[4194006.302862]  target1:0:1: Ending Domain Validation
[4194006.927862] scsi 0:0:4:0: Sequential-Access ARCHIVE  Python 04106-XXX 743B PQ: 0 ANSI: 2
[4194006.927862]  target0:0:4: Beginning Domain Validation
[4194006.932745]  target0:0:4: asynchronous
[4194006.953253]  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[4194006.964972]  target0:0:4: Domain Validation skipping write tests
[4194006.965948]  target0:0:4: Ending Domain Validation
[4194009.947392] scsi 0:0:4:0: Attached scsi generic sg0 type 1
[4194010.129032] sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
[4194010.131962] sd 1:0:1:0: [sda] Write Protect is off
[4194010.132939] sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
[4194010.133915] sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[4194010.134892] sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
[4194010.137821] sd 1:0:1:0: [sda] Write Protect is off
[4194010.137821] sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
[4194010.139775] sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[4194010.139775]  sda: sda1 sda2 sda3 sda4
[4194010.149540] sd 1:0:1:0: [sda] Attached SCSI disk
[4194010.149540] sd 1:0:1:0: Attached scsi generic sg1 type 0
[4194010.150517] md: Autodetecting RAID arrays.
[4194010.150517] md: Scanned 0 and added 0 devices.
[4194010.150517] md: autorun ...
[4194010.150517] md: ... autorun DONE.
[4194010.169071] EXT3-fs: INFO: recovery required on readonly filesystem.
[4194010.169071] EXT3-fs: write access will be enabled during recovery.
[4194011.536258] kjournald starting.  Commit interval 5 seconds
[4194011.537235] EXT3-fs: sda3: orphan cleanup on readonly fs
[4194011.537235] ext3_orphan_cleanup: deleting unreferenced inode 16799
[4194011.537235] ext3_orphan_cleanup: deleting unreferenced inode 824393
[4194011.537235] EXT3-fs: sda3: 2 orphan inodes deleted
[4194011.537235] EXT3-fs: recovery complete.
[4194011.571414] EXT3-fs: mounted filesystem with ordered data mode.
[4194011.571414] VFS: Mounted root (ext3 filesystem) readonly.
[4194011.571414] Freeing unused kernel memory: 192k freed
[4194014.592897] Adding 1976560k swap on /dev/sda4.  Priority:-1 extents:1 across:1976560k
[4194014.928835] EXT3 FS on sda3, internal journal
[4194015.799928] sata_sil24 0000:00:08.0: version 1.1
[4194015.802858] scsi2 : sata_sil24
[4194015.827272] scsi3 : sata_sil24
[4194015.838990] scsi4 : sata_sil24
[4194015.859498] scsi5 : sata_sil24
[4194015.879029] ata1: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 27
[4194015.879029] ata2: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 27
[4194015.882936] ata3: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 27
[4194015.882936] ata4: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 27
[4194018.045044] ata1: softreset failed (SRST command error)
[4194018.045044] ata1: reset failed (errno=-5), retrying in 8 secs
[4194028.045039] ata1: softreset failed (SRST command error)
[4194028.046015] ata1: reset failed (errno=-5), retrying in 8 secs
[4194038.047963] ata1: softreset failed (SRST command error)
[4194038.047963] ata1: reset failed (errno=-5), retrying in 33 secs
[4194070.885837] ata1: limiting SATA link speed to 1.5 Gbps
[4194073.048922] ata1: softreset failed (SRST command error)
[4194073.048922] ata1: reset failed, giving up
[4194075.097749] ata2: SATA link down (SStatus 0 SControl 0)
[4194077.144623] ata3: SATA link down (SStatus 0 SControl 0)
[4194079.193450] ata4: SATA link down (SStatus 0 SControl 0)
[4194079.277434] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4194079.277434] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4194079.650481] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
[4194080.706145] md: md2 stopped.
[4194093.799888] EXT3-fs: unable to read superblock
[4194095.198325] VIA Networking Velocity Family Gigabit Ethernet Adapter Driver Ver. 1.14
[4194095.199301] Copyright (c) 2002, 2003 VIA Networking Technologies, Inc.
[4194095.199301] Copyright (c) 2004 Red Hat Inc.
[4194095.211020] eth0: VIA Networking Velocity Family Gigabit Ethernet Adapter
[4194095.211020] eth0: Ethernet Address: 00:13:49:12:44:DD
[4194097.548910] usbcore: registered new interface driver usbfs
[4194097.570394] usbcore: registered new interface driver hub
[4194097.594808] usbcore: registered new device driver usb
[4194097.631917] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[4194097.652425] ohci_hcd 0000:00:05.3: OHCI Host Controller
[4194097.670980] ohci_hcd 0000:00:05.3: new USB bus registered, assigned bus number 1
[4194097.670980] ohci_hcd 0000:00:05.3: irq 10, io mem 0x09aa8000
[4194097.765706] usb usb1: configuration #1 chosen from 1 choice
[4194097.780355] hub 1-0:1.0: USB hub found
[4194097.780355] hub 1-0:1.0: 2 ports detected
[4194099.248127] Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
[4194099.289143] tulip0:  EEPROM default media type Autosense.
[4194099.289143] tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
[4194099.295979] tulip0:  MII transceiver #5 config 2100 status 784b advertising 01e1.
[4194099.320393] eth1: Digital DS21140 Tulip rev 34 at MMIO 0x9804000, 00:06:2b:00:d8:05, IRQ 29.
[4194101.041095] st: Version 20070203, fixed bufsize 32768, s/g segs 256
[4194101.051837] Driver 'st' needs updating - please use bus_type methods
[4194101.192462] st 0:0:4:0: Attached scsi tape st0
[4194101.192462] st 0:0:4:0: st0: try direct i/o: yes (alignment 512 B)
[4194101.896564] Velocity is AUTO mode
[4194101.905353] ADDRCONF(NETDEV_UP): eth0: link is not ready
[4194104.240312] eth0: Link auto-negotiation speed 1000M bps full duplex
[4194104.243242] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[4194112.890699] ndbd(2752): unaligned trap at 000000012025652c: 00000001203f00b5 28 1
[4194112.891675] ndbd(2752): unaligned trap at 0000000120256538: 00000001203f00b5 2c 2
[4194112.891675] ndbd(2752): unaligned trap at 000000012025652c: 00000001203f00b5 28 1
[4194112.892652] ndbd(2752): unaligned trap at 0000000120256538: 00000001203f00b5 2c 2
[4194114.542065] eth0: no IPv6 routers present
[4194120.445382] dbus-daemon(2912): unaligned trap at 000000012003aef4: 000000011fcb3311 28 3
[4194120.445382] dbus-daemon(2912): unaligned trap at 000000012003af14: 000000011fcb3311 2c 3
[4194120.445382] dbus-daemon(2912): unaligned trap at 000000012003aef4: 000000011fcb3311 28 3
[4194120.445382] dbus-daemon(2912): unaligned trap at 000000012003af14: 000000011fcb3311 2c 3
[4194125.528387] Probing IDE interface ide0...
[4194126.058661] Probing IDE interface ide1...
[4194126.586981] Probing IDE interface ide2...
[4194127.115301] Probing IDE interface ide3...
[4194141.049864] device eth0 entered promiscuous mode
[4194143.890683] dbus-daemon(2912): unaligned trap at 000000012003aef4: 000000011fcb3311 28 3
[4194143.890683] dbus-daemon(2912): unaligned trap at 000000012003af14: 000000011fcb3311 2c 3
[4194143.890683] dbus-daemon(2912): unaligned trap at 000000012003aef4: 000000011fcb3311 28 3
[4194143.890683] dbus-daemon(2912): unaligned trap at 000000012003af14: 000000011fcb3311 2c 3
[4194151.797905] dbus-daemon(2912): unaligned trap at 000000012003aef4: 000000011fcb32d1 28 3
[4194151.797905] dbus-daemon(2912): unaligned trap at 000000012003af14: 000000011fcb32d1 2c 3
[4194151.797905] dbus-daemon(2912): unaligned trap at 000000012003aef4: 000000011fcb32d1 28 3
[4194151.798882] dbus-daemon(2912): unaligned trap at 000000012003af14: 000000011fcb32d1 2c 3
[4194269.804681] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xa frozen
[4194269.804681] ata2: irq_stat 0x00b40090, PHY RDY changed
[4194269.804681] ata2: hard resetting link
[4194271.968742] ata2: softreset failed (SRST command error)
[4194271.968742] ata2: reset failed (errno=-5), retrying in 8 secs
[4194279.805652] ata2: hard resetting link
[4194281.967760] ata2: softreset failed (SRST command error)
[4194281.967760] ata2: reset failed (errno=-5), retrying in 8 secs
[4194289.806624] ata2: hard resetting link
[4194291.969708] ata2: softreset failed (SRST command error)
[4194291.969708] ata2: reset failed (errno=-5), retrying in 33 secs
[4194324.807582] ata2: limiting SATA link speed to 1.5 Gbps
[4194324.807582] ata2: hard resetting link
[4194326.969690] ata2: softreset failed (SRST command error)
[4194326.969690] ata2: reset failed, giving up
[4194326.969690] ata2: EH complete

--------------000907020604060506050703
Content-Type: message/delivery-status;
 name="lspci.newcard.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.newcard.2"

0000: 00:05.0 ISA bridge: Contaq Microsystems 82c693
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000: 00:05.1 IDE interface: Contaq Microsystems 82c693 (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at 9000 [size=16]

0000: 00:05.2 IDE interface: Contaq Microsystems 82c693 (prog-if 00 [])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 15
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: Memory at 09a80000 (32-bit, non-prefetchable) [disabled] [size=64K]

0000: 00:05.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 09aa8000 (32-bit, non-prefetchable) [size=4K]

0000: 00:07.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=255
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: 09800000-098fffff
	Prefetchable memory behind bridge: 0000000009900000-00000000099fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

0000: 00:08.0 Mass storage controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 240, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 09aa9000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at 09aa0000 (64-bit, non-prefetchable) [size=32K]
	Region 4: I/O ports at 9010 [size=16]
	Expansion ROM at 09a00000 [disabled] [size=512K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=12
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
	Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000: 00:09.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at 09000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 09a90000 [disabled] [size=64K]

0000: 01:00.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 31
	Region 0: I/O ports at 8000 [size=256]
	Region 1: Memory at 09802000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 09800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 09940000 [disabled] [size=64K]

0000: 01:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 30
	Region 0: I/O ports at 8400 [size=256]
	Region 1: Memory at 09803000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 09801000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 09950000 [disabled] [size=64K]

0000: 01:02.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Subsystem: Digital Equipment Corporation Unknown device 500a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 29
	Region 0: I/O ports at 8800 [size=128]
	Region 1: Memory at 09804000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 09900000 [disabled] [size=256K]

0001: 02:09.0 Ethernet controller: VIA Technologies, Inc. VT6120/VT6121/VT6122 Gigabit Ethernet Adapter (rev 01)
	Subsystem: ZyXEL Communication Corporation Unknown device 3302
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (750ns min, 2000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 39
	Region 0: I/O ports at 200008000 [size=256]
	Region 1: Memory at 209000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------000907020604060506050703
Content-Type: message/delivery-status;
 name="lspci64.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci64.2"

0000: 00:05.0 ISA bridge: Contaq Microsystems 82c693
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000: 00:05.1 IDE interface: Contaq Microsystems 82c693 (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 14
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: I/O ports at 9000 [size=16]

0000: 00:05.2 IDE interface: Contaq Microsystems 82c693 (prog-if 00 [])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 15
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [disabled] [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [disabled] [size=1]
	Region 4: Memory at 09a80000 (32-bit, non-prefetchable) [disabled] [size=64K]

0000: 00:05.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 09aa8000 (32-bit, non-prefetchable) [size=4K]

0000: 00:07.0 Mass storage controller: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller (rev 02)
	Subsystem: Silicon Image, Inc. SiI 3124 PCI-X Serial ATA Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 240, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 31
	Region 0: Memory at 09aa9000 (64-bit, non-prefetchable) [size=128]
	Region 2: Memory at 09aa0000 (64-bit, non-prefetchable) [size=32K]
	Region 4: I/O ports at 9010 [size=16]
	Expansion ROM at 09a00000 [disabled] [size=512K]
	Capabilities: [64] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [40] PCI-X non-bridge device
		Command: DPERE- ERO+ RBC=512 OST=12
		Status: Dev=ff:1f.0 64bit+ 133MHz+ SCD- USC- DC=simple DMMRBC=2048 DMOST=12 DMCRS=128 RSCEM- 266MHz- 533MHz-
	Capabilities: [54] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000: 00:08.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=255
	I/O behind bridge: 00008000-00008fff
	Memory behind bridge: 09800000-098fffff
	Prefetchable memory behind bridge: 0000000009900000-00000000099fffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

0000: 00:09.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at 09000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at 09a90000 [disabled] [size=64K]

0000: 01:00.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at 8000 [size=256]
	Region 1: Memory at 09802000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 09800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 09940000 [disabled] [size=64K]

0000: 01:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (4250ns min, 16000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 26
	Region 0: I/O ports at 8400 [size=256]
	Region 1: Memory at 09803000 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at 09801000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 09950000 [disabled] [size=64K]

0000: 01:02.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
	Subsystem: Digital Equipment Corporation Unknown device 500a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (5000ns min, 10000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 25
	Region 0: I/O ports at 8800 [size=128]
	Region 1: Memory at 09804000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 09900000 [disabled] [size=256K]

0001: 02:09.0 Ethernet controller: VIA Technologies, Inc. VT6120/VT6121/VT6122 Gigabit Ethernet Adapter (rev 01)
	Subsystem: ZyXEL Communication Corporation Unknown device 3302
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (750ns min, 2000ns max), Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 39
	Region 0: I/O ports at 200008000 [size=256]
	Region 1: Memory at 209000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------000907020604060506050703--
