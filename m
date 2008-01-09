From: Thomas Evans <tom@23palmer.net>
Subject: Re: SATA PMP support in 2.6.24-rc3?
Date: Wed, 09 Jan 2008 18:52:44 -0500
Message-ID: <47855E4C.7010504@23palmer.net>
References: <39B20DF628532344BC7A2692CB6AEE070201BD83@orsmsx420.amr.corp.intel.com> <474CC423.70705@gmail.com> <474E2F5E.1010509@23palmer.net> <47836C36.4040701@gmail.com> <39B20DF628532344BC7A2692CB6AEE07022BC5E7@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020404030508030207070909"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp02.lnh.mail.rcn.net ([207.172.157.102]:1909 "EHLO
	smtp02.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211AbYAJADL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jan 2008 19:03:11 -0500
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE07022BC5E7@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020404030508030207070909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I stopped seeing this message when I started using rc4.

I upgraded to rc7 with your patch - the dmesg is attached.

The link speed seems limited to 1.5Gbps now though, which hasn't been 
the case in rc3->rc6.

...tom

>> -----Original Message-----
>> From: Tejun Heo [mailto:htejun@gmail.com]
>> Sent: Tuesday, January 08, 2008 4:28 AM
>> To: Tom Evans
>> Cc: Gaston, Jason D; linux-ide@vger.kernel.org
>> Subject: Re: SATA PMP support in 2.6.24-rc3?
>>
>> Tom Evans wrote:
>>    
>>> I'm also seeing this with 2.6.23-rc3 on my Alpha system - sata_sil24
>>>       
> and
>  
>>> a SiliconImage PMP.
>>>       
>> Gaston, Tom, can you guys please apply the attached patch on top of
>> 2.6.24-rc7 and see whether the problem goes away.
>>
>> Thanks.
>>
>> -- 
>> Tejun
>>     
>
>   


--------------020404030508030207070909
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

[4194001.852669] Linux version 2.6.24-rc7-ds20 (root@chronictown) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #7 SMP Tue Jan 8 09:56:15 EST 2008
[4194001.852669] Booting on Tsunami variation Goldrush using machine vector DP264 from SRM
[4194001.852669] Major Options: SMP LEGACY_START VERBOSE_MCHECK DISCONTIGMEM MAGIC_SYSRQ 
[4194001.852669] Command line: root=/dev/sda3 ide=reverse
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
[4194001.852669] Kernel command line: root=/dev/sda3 ide=reverse
[4194001.852669] PID hash table entries: 4096 (order: 12, 32768 bytes)
[4194001.852669] Using epoch = 1952
[4194001.856576] Console: colour VGA+ 80x25
[4194001.856576] console [tty0] enabled
[4194001.861459] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[4194001.863412] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[4194001.909310] Memory: 1027192k/1045760k available (3339k kernel code, 17936k reserved, 243k data, 192k init)
[4194001.910287] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.928841] Mount-cache hash table entries: 512
[4194001.929818] SMP starting up secondaries.
[4194001.936654] Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
[4194001.955208] Brought up 2 CPUs
[4194001.955208] SMP: Total of 2 processors activated (1998.25 BogoMIPS).
[4194001.956185] net_namespace: 120 bytes
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
[4194001.980599] NET: Registered protocol family 2
[4194001.992318] IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
[4194001.993294] TCP established hash table entries: 32768 (order: 6, 524288 bytes)
[4194001.994271] TCP bind hash table entries: 32768 (order: 6, 524288 bytes)
[4194001.995248] TCP: Hash tables configured (established 32768 bind 32768)
[4194001.996224] TCP reno registered
[4194002.001107] srm_env: version 0.0.6 loaded successfully
[4194002.003060] async_tx: api initialized (sync-only)
[4194002.003060] io scheduler noop registered
[4194002.003060] io scheduler anticipatory registered (default)
[4194002.003060] io scheduler deadline registered
[4194002.003060] isapnp: Scanning for PnP cards...
[4194002.358529] isapnp: No Plug & Play device found
[4194002.478646] rtc: Digital UNIX epoch (1952) detected
[4194002.479622] Real Time Clock Driver v1.12ac
[4194002.479622] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[4194002.479622] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4194002.480599] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4194002.482552] Floppy drive(s): fd0 is 2.88M
[4194002.498177] FDC 0 is a post-1991 82077
[4194002.500130] nbd: registered device at major 43
[4194002.504036] Loading iSCSI transport class v2.0-724.
[4194002.666146] sym0: <875> rev 0x4 at pci 0000:01:00.0 irq 27
[4194002.752083] sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194002.752083] sym0: open drain IRQ line driver, using on-chip SRAM
[4194002.752083] sym0: using LOAD/STORE-based firmware.
[4194002.753060] sym0: SCSI BUS has been reset.
[4194002.759896] scsi0 : sym-2.2.3
[4194002.921028] sym1: <875> rev 0x4 at pci 0000:01:01.0 irq 26
[4194003.007942] sym1: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
[4194003.007942] sym1: open drain IRQ line driver, using on-chip SRAM
[4194003.007942] sym1: using LOAD/STORE-based firmware.
[4194003.007942] sym1: SCSI BUS has been reset.
[4194003.015755] scsi1 : sym-2.2.3
[4194003.015755] Driver 'sd' needs updating - please use bus_type methods
[4194003.015755] Driver 'sr' needs updating - please use bus_type methods
[4194003.017708] sata_via 0001:02:08.0: version 2.3
[4194003.017708] sata_via 0001:02:08.0: routed to hard irq line 11
[4194003.017708] scsi2 : sata_via
[4194003.017708] scsi3 : sata_via
[4194003.018684] scsi4 : sata_via
[4194003.018684] ata1: SATA max UDMA/133 port i16@0x200008820 bmdma 0x200008800 irq 43
[4194003.018684] ata2: SATA max UDMA/133 port i16@0x200008830 bmdma 0x200008808 irq 43
[4194003.018684] ata3: PATA max UDMA/133 port i16@0x200008840 bmdma 0x200008810 irq 43
[4194003.323372] ata1: SATA link down (SStatus 0 SControl 310)
[4194003.638801] ata2: SATA link down (SStatus 0 SControl 310)
[4194003.819465] serio: i8042 KBD port at 0x60,0x64 irq 1
[4194003.819465] serio: i8042 AUX port at 0x60,0x64 irq 12
[4194003.819465] mice: PS/2 mouse device common for all mice
[4194004.377082] input: AT Raw Set 2 keyboard as /class/input/input0
[4194004.394660] atkbd.c: keyboard reset failed on isa0060/serio1
[4194004.424934] md: linear personality registered for level -1
[4194004.424934] md: raid0 personality registered for level 0
[4194004.424934] md: raid1 personality registered for level 1
[4194004.425910] md: raid10 personality registered for level 10
[4194004.442512] raid6: int64x1    464 MB/s
[4194004.459113] raid6: int64x2    636 MB/s
[4194004.475715] raid6: int64x4    736 MB/s
[4194004.492317] raid6: int64x8    472 MB/s
[4194004.492317] raid6: using algorithm int64x4 (736 MB/s)
[4194004.492317] md: raid6 personality registered for level 6
[4194004.492317] md: raid5 personality registered for level 5
[4194004.492317] md: raid4 personality registered for level 4
[4194004.492317] md: multipath personality registered for level -4
[4194004.492317] md: faulty personality registered for level -5
[4194004.492317] TCP cubic registered
[4194004.493293] NET: Registered protocol family 1
[4194004.493293] NET: Registered protocol family 10
[4194004.494270] lo: Disabled Privacy Extensions
[4194004.496223] NET: Registered protocol family 17
[4194004.496223] scsi: waiting for bus probes to complete ...
[4194006.295050] scsi 1:0:1:0: Direct-Access     FUJITSU  MAJ3091MP        5508 PQ: 0 ANSI: 4
[4194006.295050]  target1:0:1: tagged command queuing enabled, command queue depth 16.
[4194006.295050]  target1:0:1: Beginning Domain Validation
[4194006.295050]  target1:0:1: asynchronous
[4194006.297980]  target1:0:1: wide asynchronous
[4194006.298956]  target1:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
[4194006.300909]  target1:0:1: Domain Validation skipping write tests
[4194006.300909]  target1:0:1: Ending Domain Validation
[4194006.925909] scsi 0:0:4:0: Sequential-Access ARCHIVE  Python 04106-XXX 743B PQ: 0 ANSI: 2
[4194006.925909]  target0:0:4: Beginning Domain Validation
[4194006.930792]  target0:0:4: asynchronous
[4194006.951300]  target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[4194006.963018]  target0:0:4: Domain Validation skipping write tests
[4194006.963018]  target0:0:4: Ending Domain Validation
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
[4194010.145634] sd 1:0:1:0: [sda] Attached SCSI disk
[4194010.145634] sd 1:0:1:0: Attached scsi generic sg1 type 0
[4194010.146611] md: Autodetecting RAID arrays.
[4194010.146611] md: Scanned 0 and added 0 devices.
[4194010.146611] md: autorun ...
[4194010.146611] md: ... autorun DONE.
[4194010.159306] EXT3-fs: INFO: recovery required on readonly filesystem.
[4194010.159306] EXT3-fs: write access will be enabled during recovery.
[4194013.533328] kjournald starting.  Commit interval 5 seconds
[4194013.533328] EXT3-fs: sda3: orphan cleanup on readonly fs
[4194013.533328] ext3_orphan_cleanup: deleting unreferenced inode 467745
[4194013.588992] ext3_orphan_cleanup: deleting unreferenced inode 16444
[4194013.598757] EXT3-fs: sda3: 2 orphan inodes deleted
[4194013.598757] EXT3-fs: recovery complete.
[4194013.671023] EXT3-fs: mounted filesystem with ordered data mode.
[4194013.671999] VFS: Mounted root (ext3 filesystem) readonly.
[4194013.671999] Freeing unused kernel memory: 192k freed
[4194016.806763] Adding 1976560k swap on /dev/sda4.  Priority:-1 extents:1 across:1976560k
[4194017.171021] EXT3 FS on sda3, internal journal
[4194018.735473] sata_sil24 0000:00:07.0: version 1.1
[4194018.742309] scsi5 : sata_sil24
[4194018.755005] scsi6 : sata_sil24
[4194018.766723] scsi7 : sata_sil24
[4194018.788208] scsi8 : sata_sil24
[4194018.798950] ata4: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
[4194018.798950] ata5: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
[4194018.798950] ata6: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
[4194018.799926] ata7: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
[4194020.965941] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 10)
[4194020.965941] ata4.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9
[4194020.966917] ata4.00: hard resetting link
[4194021.274535] ata4.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4194021.274535] ata4.01: hard resetting link
[4194021.607542] ata4.01: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4194021.607542] ata4.02: hard resetting link
[4194021.927854] ata4.02: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4194021.927854] ata4.03: hard resetting link
[4194022.248167] ata4.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4194022.248167] ata4.04: hard resetting link
[4194022.581174] ata4.04: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4194022.581174] ata4.05: hard resetting link
[4194022.888791] ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 0)
[4194022.888791] ata4.06: hard resetting link
[4194023.196409] ata4.06: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[4194023.210080] ata4.00: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194023.212034] ata4.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194023.212034] ata4.00: configured for UDMA/100
[4194023.224729] ata4.01: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194023.224729] ata4.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194023.225705] ata4.01: configured for UDMA/100
[4194023.237424] ata4.02: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194023.237424] ata4.02: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194023.238401] ata4.02: configured for UDMA/100
[4194023.251096] ata4.03: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194023.251096] ata4.03: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194023.252073] ata4.03: configured for UDMA/100
[4194023.260862] ata4.04: ATA-7: WDC WD4000AAKS-00TMA0, 12.01C01, max UDMA/133
[4194023.260862] ata4.04: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
[4194023.261838] ata4.04: configured for UDMA/100
[4194023.262815] ata4.05: ATA-6: Config  Disk, PLS12052, max UDMA/133
[4194023.262815] ata4.05: 640 sectors, multi 1: LBA 
[4194023.262815] ata4.05: device is on DMA blacklist, disabling DMA
[4194023.262815] ata4.05: configured for PIO4
[4194023.262815] ata4: EH complete
[4194025.313595] ata5: SATA link down (SStatus 0 SControl 10)
[4194027.364375] ata6: SATA link down (SStatus 0 SControl 10)
[4194029.415155] ata7: SATA link down (SStatus 0 SControl 10)
[4194029.415155] scsi 5:0:0:0: Direct-Access     ATA      WDC WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194029.425898] sd 5:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
[4194029.425898] sd 5:0:0:0: [sdb] Write Protect is off
[4194029.425898] sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[4194029.426874] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194029.426874] sd 5:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
[4194029.426874] sd 5:0:0:0: [sdb] Write Protect is off
[4194029.426874] sd 5:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[4194029.426874] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194029.427851]  sdb: sdb1
[4194029.457148] sd 5:0:0:0: [sdb] Attached SCSI disk
[4194029.489374] sd 5:0:0:0: Attached scsi generic sg2 type 0
[4194029.489374] scsi 5:1:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194029.524530] sd 5:1:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[4194029.524530] sd 5:1:0:0: [sdc] Write Protect is off
[4194029.524530] sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[4194029.524530] sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194029.525507] sd 5:1:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
[4194029.525507] sd 5:1:0:0: [sdc] Write Protect is off
[4194029.525507] sd 5:1:0:0: [sdc] Mode Sense: 00 3a 00 00
[4194029.525507] sd 5:1:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194029.526483]  sdc: sdc1
[4194029.574335] sd 5:1:0:0: [sdc] Attached SCSI disk
[4194029.629999] sd 5:1:0:0: Attached scsi generic sg3 type 0
[4194029.629999] scsi 5:2:0:0: Direct-Access     ATA      WDC WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194029.687616] sd 5:2:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
[4194029.687616] sd 5:2:0:0: [sdd] Write Protect is off
[4194029.687616] sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[4194029.688593] sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194029.688593] sd 5:2:0:0: [sdd] 781422768 512-byte hardware sectors (400088 MB)
[4194029.688593] sd 5:2:0:0: [sdd] Write Protect is off
[4194029.688593] sd 5:2:0:0: [sdd] Mode Sense: 00 3a 00 00
[4194029.688593] sd 5:2:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194029.689569]  sdd: sdd1
[4194029.735468] sd 5:2:0:0: [sdd] Attached SCSI disk
[4194029.776483] sd 5:2:0:0: Attached scsi generic sg4 type 0
[4194029.776483] scsi 5:3:0:0: Direct-Access     ATA      WDC WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194029.842889] sd 5:3:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[4194029.842889] sd 5:3:0:0: [sde] Write Protect is off
[4194029.842889] sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
[4194029.842889] sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194029.843866] sd 5:3:0:0: [sde] 781422768 512-byte hardware sectors (400088 MB)
[4194029.843866] sd 5:3:0:0: [sde] Write Protect is off
[4194029.843866] sd 5:3:0:0: [sde] Mode Sense: 00 3a 00 00
[4194029.843866] sd 5:3:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194029.844843]  sde: sde1
[4194029.921014] sd 5:3:0:0: [sde] Attached SCSI disk
[4194029.995233] sd 5:3:0:0: Attached scsi generic sg5 type 0
[4194029.996210] scsi 5:4:0:0: Direct-Access     ATA      WDC WD4000AAKS-0 12.0 PQ: 0 ANSI: 5
[4194030.045038] sd 5:4:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
[4194030.046014] sd 5:4:0:0: [sdf] Write Protect is off
[4194030.046014] sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[4194030.046014] sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194030.046014] sd 5:4:0:0: [sdf] 781422768 512-byte hardware sectors (400088 MB)
[4194030.046014] sd 5:4:0:0: [sdf] Write Protect is off
[4194030.046991] sd 5:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[4194030.046991] sd 5:4:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[4194030.046991]  sdf: sdf1
[4194030.099725] sd 5:4:0:0: [sdf] Attached SCSI disk
[4194030.162225] sd 5:4:0:0: Attached scsi generic sg6 type 0
[4194030.162225] scsi 5:5:0:0: Direct-Access     ATA      Config  Disk     PLS1 PQ: 0 ANSI: 5
[4194030.210077] sd 5:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
[4194030.210077] sd 5:5:0:0: [sdg] Write Protect is off
[4194030.210077] sd 5:5:0:0: [sdg] Mode Sense: 00 3a 00 00
[4194030.210077] sd 5:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[4194030.211053] sd 5:5:0:0: [sdg] 640 512-byte hardware sectors (0 MB)
[4194030.211053] sd 5:5:0:0: [sdg] Write Protect is off
[4194030.211053] sd 5:5:0:0: [sdg] Mode Sense: 00 3a 00 00
[4194030.211053] sd 5:5:0:0: [sdg] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[4194030.212030]  sdg: unknown partition table
[4194030.246210] sd 5:5:0:0: [sdg] Attached SCSI disk
[4194030.294061] sd 5:5:0:0: Attached scsi generic sg7 type 0
[4194030.452264] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4194030.453241] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4194030.877069] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
[4194031.800896] md: md2 stopped.
[4194031.908318] md: bind<sdf1>
[4194031.909295] md: bind<sdd1>
[4194031.909295] md: bind<sdb1>
[4194031.910271] md: bind<sdc1>
[4194031.910271] md: bind<sde1>
[4194031.928826] raid5: device sde1 operational as raid disk 0
[4194031.928826] raid5: device sdc1 operational as raid disk 4
[4194031.928826] raid5: device sdb1 operational as raid disk 3
[4194031.928826] raid5: device sdd1 operational as raid disk 2
[4194031.929802] raid5: device sdf1 operational as raid disk 1
[4194031.931756] raid5: allocated 10444kB for md2
[4194031.931756] raid5: raid level 6 set md2 active with 5 out of 5 devices, algorithm 2
[4194031.931756] RAID5 conf printout:
[4194031.931756]  --- rd:5 wd:5
[4194031.931756]  disk 0, o:1, dev:sde1
[4194031.932732]  disk 1, o:1, dev:sdf1
[4194031.932732]  disk 2, o:1, dev:sdd1
[4194031.932732]  disk 3, o:1, dev:sdb1
[4194031.932732]  disk 4, o:1, dev:sdc1
[4194036.401480] kjournald starting.  Commit interval 5 seconds
[4194036.421011] EXT3 FS on md2, internal journal
[4194036.421011] EXT3-fs: mounted filesystem with ordered data mode.
[4194037.868276] VIA Networking Velocity Family Gigabit Ethernet Adapter Driver Ver. 1.14
[4194037.868276] Copyright (c) 2002, 2003 VIA Networking Technologies, Inc.
[4194037.868276] Copyright (c) 2004 Red Hat Inc.
[4194037.879995] eth0: VIA Networking Velocity Family Gigabit Ethernet Adapter
[4194037.879995] eth0: Ethernet Address: 00:13:49:12:44:DD
[4194040.295033] usbcore: registered new interface driver usbfs
[4194040.319447] usbcore: registered new interface driver hub
[4194040.355579] usbcore: registered new device driver usb
[4194040.421986] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[4194040.450306] ohci_hcd 0000:00:05.3: OHCI Host Controller
[4194040.463001] ohci_hcd 0000:00:05.3: new USB bus registered, assigned bus number 1
[4194040.463001] ohci_hcd 0000:00:05.3: irq 10, io mem 0x09aa8000
[4194040.564564] usb usb1: configuration #1 chosen from 1 choice
[4194040.586048] hub 1-0:1.0: USB hub found
[4194040.586048] hub 1-0:1.0: 2 ports detected
[4194042.026477] Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
[4194042.073352] tulip0:  EEPROM default media type Autosense.
[4194042.073352] tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
[4194042.080188] tulip0:  MII transceiver #5 config 2100 status 784b advertising 01e1.
[4194042.105579] eth1: Digital DS21140 Tulip rev 34 at MMIO 0x9804000, 00:06:2b:00:d8:05, IRQ 25.
[4194043.973742] st: Version 20070203, fixed bufsize 32768, s/g segs 256
[4194043.996203] Driver 'st' needs updating - please use bus_type methods
[4194044.119249] st 0:0:4:0: Attached scsi tape st0
[4194044.119249] st 0:0:4:0: st0: try direct i/o: yes (alignment 512 B)
[4194045.270616] Velocity is AUTO mode
[4194045.278428] ADDRCONF(NETDEV_UP): eth0: link is not ready
[4194048.337021] eth0: Link auto-negotiation speed 1000M bps full duplex
[4194048.339950] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[4194056.483501] ndbd(3075): unaligned trap at 000000012025652c: 00000001203f00b5 28 1
[4194056.483501] ndbd(3075): unaligned trap at 0000000120256538: 00000001203f00b5 2c 2
[4194056.484477] ndbd(3075): unaligned trap at 000000012025652c: 00000001203f00b5 28 1
[4194056.484477] ndbd(3075): unaligned trap at 0000000120256538: 00000001203f00b5 2c 2
[4194059.339945] eth0: no IPv6 routers present
[4194079.325286] dbus-daemon(3237): unaligned trap at 000000012003aef4: 000000011ffdd311 28 3
[4194079.325286] dbus-daemon(3237): unaligned trap at 000000012003af14: 000000011ffdd311 2c 3
[4194079.325286] dbus-daemon(3237): unaligned trap at 000000012003aef4: 000000011ffdd311 28 3
[4194079.325286] dbus-daemon(3237): unaligned trap at 000000012003af14: 000000011ffdd311 2c 3
[4194081.619230] Probing IDE interface ide0...
[4194082.149503] Probing IDE interface ide1...
[4194082.679777] Probing IDE interface ide2...
[4194083.211026] Probing IDE interface ide3...
[4194087.675868] mysqladmin(3882): unaligned trap at 000002000009d8bc: 0000000120018675 28 1
[4194087.676844] mysqladmin(3882): unaligned trap at 000002000009d8c8: 0000000120018675 2c 2
[4194087.676844] mysqladmin(3882): unaligned trap at 000002000009d8bc: 0000000120018675 28 1
[4194087.676844] mysqladmin(3882): unaligned trap at 000002000009d8c8: 0000000120018675 2c 2
[4194099.288166] device eth0 entered promiscuous mode
[4194102.358477] dbus-daemon(3237): unaligned trap at 000000012003aef4: 000000011ffdd311 28 3
[4194102.358477] dbus-daemon(3237): unaligned trap at 000000012003af14: 000000011ffdd311 2c 3
[4194102.358477] dbus-daemon(3237): unaligned trap at 000000012003aef4: 000000011ffdd311 28 3
[4194102.359454] dbus-daemon(3237): unaligned trap at 000000012003af14: 000000011ffdd311 2c 3
[4194109.419997] dbus-daemon(3237): unaligned trap at 000000012003aef4: 000000011ffdd2d1 28 3
[4194109.420974] dbus-daemon(3237): unaligned trap at 000000012003af14: 000000011ffdd2d1 2c 3
[4194109.420974] dbus-daemon(3237): unaligned trap at 000000012003aef4: 000000011ffdd2d1 28 3
[4194109.420974] dbus-daemon(3237): unaligned trap at 000000012003af14: 000000011ffdd2d1 2c 3

--------------020404030508030207070909--
