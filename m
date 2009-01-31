From: "Christoph .J Thompson" <cjsthompson@gmail.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Sat, 31 Jan 2009 12:25:00 +0100
Message-ID: <20090131122500.f6817013.cjsthompson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:36267 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZAaL05 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Jan 2009 06:26:57 -0500
Received: by ey-out-2122.google.com with SMTP id 25so201021eya.37
        for <linux-ide@vger.kernel.org>; Sat, 31 Jan 2009 03:26:54 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
> Hm, looks like your CF drive is rather advanced
> and might be supporting UltraDMA (and your CF slot
> supports DMA). Care to post the output of 'hdparm -i /dev/hda'?=20

/dev/hda:                                                              =
        =20
                                                                       =
        =20
 Model=3DHMS360604D5CF00, FwRev=3DDP3OC40D, SerialNo=3DDNP450B4YHR2EA  =
              =20
 Config=3D{ HardSect NotMFM Removeable DTR>10Mbs nonMagnetic }         =
          =20
 RawCHS=3D5952/16/63, TrkSize=3D32256, SectSize=3D512, ECCbytes=3D4    =
                =20
 BuffType=3DDualPortCache, BuffSize=3D128kB, MaxMultSect=3D32, MultSect=
=3Doff          =20
 CurCHS=3D5952/16/63, CurSects=3D5999616, LBA=3Dyes, LBAsects=3D5999616=
                =20
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}=
              =20
 PIO modes:  pio0 pio1 pio2 pio3 pio4                                  =
        =20
 DMA modes:  mdma0 mdma1 mdma2                                         =
        =20
 UDMA modes: udma0 udma1 *udma2                                        =
        =20
 AdvancedPM=3Dyes: mode=3D0x60 (96) WriteCache=3Ddisabled              =
              =20
 Drive conforms to: ATA/ATAPI-4 published, ANSI INCITS 317-1998:  ATA/A=
TAPI-1,24
                                                                       =
        =20
 * signifies the current active mode

That's the output for my Hitachi Microdrive on the ALIX.2d3. It's using=
 UDMA although I'm not using the pata_cs5536 driver since this Microdri=
ve shows up as /dev/hda.

I'm having problems booting a kernel with pata_cs5536 on this box:

PC Engines ALIX.2 v0.99h
640 KB Base Memory
261120 KB Extended Memory
Waiting for HDD ...

01F0 Master 848A HMS360604D5CF00                        =20
Phys C/H/S 5952/16/63 Log C/H/S 744/128/63

LI
LILLOO  2222..88  bboooott:: =20

LLooaaddiinngg  LLiinnuuxx.............................................=
=2E....

BBIIOOSS  ddaattaa  cchheecckk  ssuucccceessssffuull

[    0.000000] BIOS EBDA/lowmem at: 00000000/000a0000
[    0.000000] Linux version 2.6.28.2alix2d3-2 (witukind@wotan) (gcc ve=
rsion 4.2.4) #4 Fri Jan 30 23:31:26 CET 2009
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserve=
d)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserve=
d)
[    0.000000] DMI not present or invalid.
[    0.000000] last_pfn =3D 0x10000 max_arch_pfn =3D 0x100000
[    0.000000] ACPI Error (tbxfroot-0218): A valid RSDP was not found [=
20080926]
[    0.000000] 256MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 10000000
[    0.000000]   low ram: 00000000 - 10000000
[    0.000000]   bootmap 00001000 - 00003000
[    0.000000] (6 early reservations) =3D=3D> bootmem [0000000000 - 001=
0000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page =3D=3D> =
[0000000000 - 0000001000]
[    0.000000]   #1 [0000200000 - 00004ab218]    TEXT DATA BSS =3D=3D> =
[0000200000 - 00004ab218]
[    0.000000]   #2 [00004ac000 - 00004af000]    INIT_PG_TABLE =3D=3D> =
[00004ac000 - 00004af000]
[    0.000000]   #3 [000009f000 - 0000100000]    BIOS reserved =3D=3D> =
[000009f000 - 0000100000]
[    0.000000]   #4 [0000007000 - 0000008000]          PGTABLE =3D=3D> =
[0000007000 - 0000008000]
[    0.000000]   #5 [0000001000 - 0000003000]          BOOTMAP =3D=3D> =
[0000001000 - 0000003000]
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x00010000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x000000a0
[    0.000000]     0: 0x00000100 -> 0x00010000
[    0.000000] Allocating PCI resources starting at 20000000 (gap: 1000=
0000:eff00000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 64928
[    0.000000] Kernel command line: BOOT_IMAGE=3DLinux ro root=3DLABEL=3D=
root console=3DttyS0,38400n8 edd=3Doff
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 497.995 MHz processor.
[    0.010000] Console: colour dummy device 80x25
[    0.010000] console [ttyS0] enabled
[    0.010000] Dentry cache hash table entries: 32768 (order: 5, 131072=
 bytes)
[    0.010000] Inode-cache hash table entries: 16384 (order: 4, 65536 b=
ytes)
[    0.010000] Memory: 256568k/262144k available (1568k kernel code, 50=
08k reserved, 752k data, 176k init, 0k highmem)
[    0.010000] virtual kernel memory layout:
[    0.010000]     fixmap  : 0xfffed000 - 0xfffff000   (  72 kB)
[    0.010000]     vmalloc : 0xd0800000 - 0xfffeb000   ( 759 MB)
[    0.010000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.010000]       .init : 0xc0448000 - 0xc0474000   ( 176 kB)
[    0.010000]       .data : 0xc03880f0 - 0xc0444334   ( 752 kB)
[    0.010000]       .text : 0xc0200000 - 0xc03880f0   (1568 kB)
[    0.010000] Checking if this processor honours the WP bit even in su=
pervisor mode...Ok.
[    0.010000] SLUB: Genslabs=3D12, HWalign=3D32, Order=3D0-3, MinObjec=
ts=3D0, CPUs=3D1, Nodes=3D1
[    0.010016] Calibrating delay loop (skipped), value calculated using=
 timer frequency.. 995.99 BogoMIPS (lpj=3D4979950)
[    0.030051] Security Framework initialized
[    0.040033] Mount-cache hash table entries: 512
[    0.050364] CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 by=
tes/line)
[    0.060011] CPU: L2 Cache: 128K (32 bytes/line)
[    0.070027] CPU: Geode(TM) Integrated Processor by AMD PCS stepping =
02
[    0.090012] Checking 'hlt' instruction... OK.
[    0.141405] Freeing SMP alternatives: 0k freed
[    0.150010] ACPI: Core revision 20080926
[    0.160110] ACPI Exception (tbxface-0627): AE_NO_ACPI_TABLES, While =
loading namespace from ACPI tables [20080926]
[    0.183426] ACPI: Unable to load the System Description Tables
[    0.190690] net_namespace: 704 bytes
[    0.200771] NET: Registered protocol family 16
[    0.210050] geode-mfgpt:  8 MFGPT timers available.
[    0.220009] geode-mfgpt:  Registered timer 0
[    0.230034] mfgpt-timer:  Registering MFGPT timer 0 as a clock event=
, using IRQ 7
[    0.241693] PCI: PCI BIOS revision 2.10 entry at 0xfced9, last bus=3D=
0
[    0.250013] PCI: Using configuration type 1 for base access
[    0.265322] ACPI: Interpreter disabled.
[    0.270927] SCSI subsystem initialized
[    0.280775] PCI: Probing PCI hardware
[    0.290653] pci 0000:00:09.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.300171] pci 0000:00:09.0: PME# disabled
[    0.310312] pci 0000:00:0a.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.320038] pci 0000:00:0a.0: PME# disabled
[    0.330141] pci 0000:00:0b.0: PME# supported from D0 D1 D2 D3hot D3c=
old
[    0.340011] pci 0000:00:0b.0: PME# disabled
[    0.350802] pci 0000:00:0f.4: PME# supported from D0 D3hot D3cold
[    0.360018] pci 0000:00:0f.4: PME# disabled
[    0.370247] pci 0000:00:0f.5: PME# supported from D0 D3hot D3cold
[    0.380016] pci 0000:00:0f.5: PME# disabled
[    0.392386] pnp: PnP ACPI: disabled
[    0.402124] bus: 00 index 0 io port: [0x00-0xffff]
[    0.416578] bus: 00 index 1 mmio: [0x000000-0xffffffff]
[    0.432357] NET: Registered protocol family 2
[    0.446189] IP route cache hash table entries: 2048 (order: 1, 8192 =
bytes)
[    0.468140] TCP established hash table entries: 8192 (order: 4, 6553=
6 bytes)
[    0.489576] TCP bind hash table entries: 8192 (order: 3, 32768 bytes=
)
[    0.509082] TCP: Hash tables configured (established 8192 bind 8192)
[    0.528204] TCP reno registered
[    0.538551] platform rtc_cmos: registered platform RTC device (no PN=
P device found)
[    0.584100] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.615490] msgmni has been set to 501
[    0.628037] alg: No test for stdrng (krng)
[    0.641030] Block layer SCSI generic (bsg) driver version 0.4 loaded=
 (major 253)
[    0.663275] io scheduler noop registered
[    0.675209] io scheduler cfq registered (default)
[    0.701838] Serial: 8250/16550 driver4 ports, IRQ sharing disabled
=FF[    1.006820] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a NS165=
50A
[    1.306617] serial8250: ttyS1 at I/O 0x2f8 (irq =3D 3) is a NS16550A
[    1.326604] Driver 'sd' needs updating - please use bus_type methods
[    1.346086] scsi0 : pata_cs5536
[    1.356079] scsi1 : pata_cs5536
[    1.365962] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xff00=
 irq 14
[    1.386924] ata2: DUMMY
[    1.570678] ata1.00: CFA: HMS360604D5CF00, DP3OC40D, max UDMA/33
[    1.588766] ata1.00: 5999616 sectors, multi 0: LBA=20
[    1.646824] ata1.00: configured for UDMA/33
[    1.659803] scsi 0:0:0:0: Direct-Access     ATA      HMS360604D5CF00=
  DP3O PQ: 0 ANSI: 5
[    1.684813] sd 0:0:0:0: [sda] 5999616 512-byte hardware sectors: (3.=
07 GB/2.86 GiB)
[    1.707902] sd 0:0:0:0: [sda] Write Protect is off
[    1.722482] sd 0:0:0:0: [sda] Write cache: disabled, read cache: ena=
bled, doesn't support DPO or FUA
[    1.750365] sd 0:0:0:0: [sda] 5999616 512-byte hardware sectors: (3.=
07 GB/2.86 GiB)
[    1.773459] sd 0:0:0:0: [sda] Write Protect is off
[    1.788001] sd 0:0:0:0: [sda] Write cache: disabled, read cache: ena=
bled, doesn't support DPO or FUA
[    1.815452]  sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 >
[    2.217848] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    2.235380] PNP: No PS/2 controller found. Probing ports directly.
[    2.254873] i8042.c: No controller found.
[    2.267240] mice: PS/2 mouse device common for all mice
[    2.283134] cpuidle: using governor ladder
[    2.295520] cpuidle: using governor menu
[    2.310323] Using IPI Shortcut mode
[    2.322395] VFS: Cannot open root device "LABEL=3Droot" or unknown-b=
lock(0,0)
[    2.343367] Please append a correct "root=3D" boot option; here are =
the available partitions:
[    2.368481] 0800         2999808 sda driver: sd
[    2.382190]   0801           96736 sda1
[    2.393810]   0802          249984 sda2
[    2.405455]   0803               1 sda3
[    2.417079]   0805          572512 sda5
[    2.428702]   0806          294304 sda6
[    2.440321]   0807          878944 sda7
[    2.451942]   0808          124960 sda8
[    2.463589]   0809          193504 sda9
[    2.475213]   080a          588640 sda10
[    2.487121] Kernel panic - not syncing: VFS: Unable to mount root fs=
 on unknown-block(0,0)

--=20
Christoph .J Thompson <cjsthompson@gmail.com>
