From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: ata8.00: log page 10h reported inactive tag 0
Date: Wed, 17 Feb 2010 11:02:09 +0100
Message-ID: <87y6isp4da.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:56972 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab0BQKTK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Feb 2010 05:19:10 -0500
Received: from nemi.mork.no (ip6-localhost [IPv6:::1])
	by canardo.mork.no (8.14.3/8.14.3) with ESMTP id o1HA2hFf013091
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
	for <linux-ide@vger.kernel.org>; Wed, 17 Feb 2010 11:02:44 +0100
Received: from bjorn by nemi.mork.no with local (Exim 4.69)
	(envelope-from <bjorn@mork.no>)
	id 1NhgjV-0004Hp-Da
	for linux-ide@vger.kernel.org; Wed, 17 Feb 2010 11:02:13 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm trying to debug a problem I've been having a couple of times over
the last few weeks, where this machine hangs *really* hard: No console
output at all, and absolutely no response on the console - not even
using the magic SysRq key (using "break" on the serial console.  This is
tested and known to be fully functional under normal conditions).

I really have no clue where to start to locate the cause of this, but
after rebooting the last time there were a few libata error messages
which puzzle me so I might as well start here.  Understandig these
errors will be useful in itself.  And they are related to the last
pieces of hardware added (SiI 3132 controller attached to a SiI 4726
port multiplier with 3 disks), which make them more suspicious in my
eyes...

These are the messages I worry about (full dmesg is included below):

[   63.865723] ata8.00: log page 10h reported inactive tag 0
[   63.943744] ata8.00: exception Emask 0x1 SAct 0x3c SErr 0x0 action 0x0
[   64.107789] ata8.00: irq_stat 0x03060002, device error via SDB FIS
[   64.199764] ata8.00: cmd 60/08:10:00:02:00/00:00:00:00:00/40 tag 2 ncq 4=
096 in
[   64.199765]          res 60/08:10:00:02:00/00:00:00:00:00/40 Emask 0x1 (=
device error)
[   64.580730] ata8.00: status: { DRDY DF }
[   64.628731] ata8.00: cmd 60/78:18:08:02:00/00:00:00:00:00/40 tag 3 ncq 6=
1440 in
[   64.628732]          res 60/78:18:08:02:00/00:00:00:00:00/40 Emask 0x89 =
(media error)
[   64.810084] ata8.00: status: { DRDY DF }
[   64.879835] ata8.00: error: { UNC IDNF }
[   64.930935] ata8.00: cmd 60/18:20:e8:00:00/00:00:00:00:00/40 tag 4 ncq 1=
2288 in
[   64.930936]          res 56/1b:02:02:00:00/00:00:00:40:56/00 Emask 0x1 (=
device error)
[   65.204495] ata8.00: status: { DRDY }
[   65.248497] ata8.00: error: { IDNF }
[   65.292407] ata8.00: cmd 60/80:28:80:01:00/00:00:00:00:00/40 tag 5 ncq 6=
5536 in
[   65.292408]          res 56/1b:02:02:00:00/00:00:00:50:56/00 Emask 0x1 (=
device error)
[   65.590268] ata8.00: status: { DRDY }
[   65.658016] ata8.00: error: { IDNF }
[   65.725346] ata8.00: configured for UDMA/100
[   65.780607] sd 7:0:0:0: [sdd] Device not ready: Sense Key : Not Ready [c=
urrent] [descriptor]
[   65.925384] sd 7:0:0:0: [sdd] Device not ready: Add. Sense: Logical unit=
 not ready, cause not reportable
[   66.040355] end_request: I/O error, dev sdd, sector 520
[   66.103442] ata8: EH complete
[   66.137877] sd 7:0:0:0: [sdd] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   66.228486] sd 7:0:0:0: [sdd] Write Protect is off
[   66.285654] sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   66.285676] sd 7:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA


These errors appeared after power cycling the hanging machine, and may
therefore just as well be symptoms as a cause.  As you see, the error
handling is successful and all drives are working as expected.  So I
guess this might just be a harmless warning caused by an unrelated hang
and the unexpected power cycling. Anyway, here are the details of this
controller in case they are of interest:

canardo:/home/bjorn# lspci -nnvvxxxs 3:
03:00.0 RAID bus controller [0104]: Silicon Image, Inc. SiI 3132 Serial ATA=
 Raid II Controller [1095:3132] (rev 01)
        Subsystem: Silicon Image, Inc. Device [1095:7132]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
 Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <T=
Abort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at fe8ffc00 (64-bit, non-prefetchable) [size=3D128]
        Region 2: Memory at fe8f8000 (64-bit, non-prefetchable) [size=3D16K]
        Region 4: I/O ports at cc00 [size=3D128]
        [virtual] Expansion ROM at f0000000 [disabled] [size=3D512K]
        Capabilities: [54] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2=
-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D1 PME-
        Capabilities: [5c] MSI: Enable- Count=3D1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 1024 bytes, PhantFunc 0, Latency L0s <64=
ns, L1 <1us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsup=
ported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- Tr=
ansPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency=
 L0 unlimited, L1 unlimited
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- Comm=
Clk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLA=
ctive- BWMgmt- ABWMgmt-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- =
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatal=
Err-
                AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ Ch=
kEn-
        Kernel driver in use: sata_sil24
        Kernel modules: sata_sil24
00: 95 10 32 31 07 00 10 00 01 00 04 01 08 00 00 00
10: 04 fc 8f fe 00 00 00 00 04 80 8f fe 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 95 10 32 71
30: 00 00 00 00 54 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 01 5c 22 06 00 20 00 0c 05 70 80 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 00 11 00 03 00 00 00 00 20 0a 00 11 f4 03 00
80: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



Don't know how to dig up more details about the port multiplier.
Anyone?


The machine is running Debian stable, using the latest kernel from
Debian stable (2.6.26-21lenny3).  I.e. based on 2.6.26.8 with a lot of
backported bug fixes.  I realize that this may be too old to be relevant
at all, but am trying to avoid upgrading unless there are known issues
fised in later versions which might explain my problems.  In which case
I'm pretty sure that the Debian kernel team would like to know too, if
it is possible to backport those fixes



Bj=C3=B8rn



--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=dmesg
Content-Transfer-Encoding: quoted-printable

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.26-2-amd64 (Debian 2.6.26-21lenny3) (dannf=
@debian.org) (gcc version 4.1.3 20080704 (prerelease) (Debian 4.1.2-25)) #1=
 SMP Thu Feb 11 00:59:32 UTC 2010
[    0.000000] Command line: root=3D/dev/mapper/vg00-root ro console=3Dtty0=
 console=3DttyS0,9600n8
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009c800 (usable)
[    0.000000]  BIOS-e820: 000000000009c800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000dff80000 (usable)
[    0.000000]  BIOS-e820: 00000000dff80000 - 00000000dff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000dff8e000 - 00000000dffe0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000dffe0000 - 00000000e0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000220000000 (usable)
[    0.000000] Entering add_active_range(0, 0, 156) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 917376) 1 entries of 3200 =
used
[    0.000000] Entering add_active_range(0, 1048576, 2228224) 2 entries of =
3200 used
[    0.000000] max_pfn_mapped =3D 2228224
[    0.000000] init_memory_mapping
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP 000FBCD0, 0024 (r2 ACPIAM)
[    0.000000] ACPI: XSDT DFF80100, 0054 (r1 A_M_I_ OEMXSDT   6000826 MSFT =
      97)
[    0.000000] ACPI: FACP DFF80290, 00F4 (r3 A_M_I_ OEMFACP   6000826 MSFT =
      97)
[    0.000000] ACPI: DSDT DFF80440, 90AB (r1  A0871 A0871020       20 INTL =
20060113)
[    0.000000] ACPI: FACS DFF8E000, 0040
[    0.000000] ACPI: APIC DFF80390, 006C (r1 A_M_I_ OEMAPIC   6000826 MSFT =
      97)
[    0.000000] ACPI: MCFG DFF80400, 003C (r1 A_M_I_ OEMMCFG   6000826 MSFT =
      97)
[    0.000000] ACPI: OEMB DFF8E040, 0081 (r1 A_M_I_ AMI_OEM   6000826 MSFT =
      97)
[    0.000000] ACPI: HPET DFF894F0, 0038 (r1 A_M_I_ OEMHPET   6000826 MSFT =
      97)
[    0.000000] ACPI: OSFR DFF89530, 00B0 (r1 A_M_I_ OEMOSFR   6000826 MSFT =
      97)
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000220000000
[    0.000000] Entering add_active_range(0, 0, 156) 0 entries of 3200 used
[    0.000000] Entering add_active_range(0, 256, 917376) 1 entries of 3200 =
used
[    0.000000] Entering add_active_range(0, 1048576, 2228224) 2 entries of =
3200 used
[    0.000000] Bootmem setup node 0 0000000000000000-0000000220000000
[    0.000000]   NODE_DATA [0000000000012000 - 0000000000016fff]
[    0.000000]   bootmap [0000000000017000 -  000000000005afff] pages 44
[    0.000000]   early res: 0 [0-fff] BIOS data page
[    0.000000]   early res: 1 [6000-7fff] TRAMPOLINE
[    0.000000]   early res: 2 [200000-675397] TEXT DATA BSS
[    0.000000]   early res: 3 [37880000-37fef4e1] RAMDISK
[    0.000000]   early res: 4 [9c800-fffff] BIOS reserved
[    0.000000]   early res: 5 [8000-11fff] PGTABLE
[    0.000000]  [ffffe20000000000-ffffe20002dfffff] PMD -> [ffff81000120000=
0-ffff810003ffffff] on node 0
[    0.000000]  [ffffe20002e00000-ffffe200077fffff] PMD -> [ffff81000c00000=
0-ffff8100103fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  2228224
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0:        0 ->      156
[    0.000000]     0:      256 ->   917376
[    0.000000]     0:  1048576 ->  2228224
[    0.000000] On node 0 totalpages: 2096924
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1255 pages reserved
[    0.000000]   DMA zone: 2685 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 899000 pages, LIFO batch:31
[    0.000000]   Normal zone: 16128 pages used for memmap
[    0.000000]   Normal zone: 1163520 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 00000000000=
9d000
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 00000000000=
a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000=
e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 00000000001=
00000
[    0.000000] PM: Registered nosave memory: 00000000dff80000 - 00000000dff=
8e000
[    0.000000] PM: Registered nosave memory: 00000000dff8e000 - 00000000dff=
e0000
[    0.000000] PM: Registered nosave memory: 00000000dffe0000 - 00000000e00=
00000
[    0.000000] PM: Registered nosave memory: 00000000e0000000 - 00000000fee=
00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee=
01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000fff=
00000
[    0.000000] PM: Registered nosave memory: 00000000fff00000 - 00000001000=
00000
[    0.000000] Allocating PCI resources starting at e2000000 (gap: e0000000=
:1ee00000)
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 37168 bytes of per cpu data
[    0.000000] NR_CPUS: 32, nr_cpu_ids: 4
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 2065205
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=3D/dev/mapper/vg00-root ro console=
=3Dtty0 console=3DttyS0,9600n8
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] TSC calibrated against PM_TIMER
[    0.000000] time.c: Detected 2405.449 MHz processor.
[    0.004000] Console: colour VGA+ 80x25
[    0.004000] console [tty0] enabled
[    0.004000] console [ttyS0] enabled
[    0.004000] Checking aperture...
[    0.004000] Calgary: detecting Calgary via BIOS EBDA area
[    0.004000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.004000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.004000] Placing software IO TLB between 0x4000000 - 0x8000000
[    0.004000] Memory: 8192292k/8912896k available (2228k kernel code, 1954=
04k reserved, 1085k data, 392k init)
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.004000] hpet clockevent registered
[    0.083865] Calibrating delay using timer specific routine.. 4814.45 Bog=
oMIPS (lpj=3D9628904)
[    0.092005] Security Framework initialized
[    0.096006] SELinux:  Disabled at boot.
[    0.100006] Capability LSM initialized
[    0.104006] Dentry cache hash table entries: 1048576 (order: 11, 8388608=
 bytes)
[    0.111933] Inode-cache hash table entries: 524288 (order: 10, 4194304 b=
ytes)
[    0.117873] Mount-cache hash table entries: 256
[    0.124007] Initializing cgroup subsys ns
[    0.128008] Initializing cgroup subsys cpuacct
[    0.132008] Initializing cgroup subsys devices
[    0.136008] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.144009] CPU: L2 cache: 4096K
[    0.148009] CPU 0/0 -> Node 0
[    0.152009] CPU: Physical Processor ID: 0
[    0.156009] CPU: Processor Core ID: 0
[    0.160010] CPU0: Thermal monitoring enabled (TM2)
[    0.164010] using mwait in idle threads.
[    0.168010] ACPI: Core revision 20080321
[    0.228014] CPU0: Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz steppi=
ng 0b
[    0.240015] Using local APIC timer interrupts.
[    0.248015] APIC timer calibration result 16704499
[    0.248015] Detected 16.704 MHz APIC timer.
[    0.252015] Booting processor 1/1 ip 6000
[    0.264016] Initializing CPU#1
[    0.264016] Calibrating delay using timer specific routine.. 4810.89 Bog=
oMIPS (lpj=3D9621781)
[    0.264016] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.264016] CPU: L2 cache: 4096K
[    0.264016] CPU 1/1 -> Node 0
[    0.264016] CPU: Physical Processor ID: 0
[    0.264016] CPU: Processor Core ID: 1
[    0.264016] CPU1: Thermal monitoring enabled (TM2)
[    0.344021] CPU1: Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz steppi=
ng 0b
[    0.356022] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.360022] Booting processor 2/2 ip 6000
[    0.376023] Initializing CPU#2
[    0.376023] Calibrating delay using timer specific routine.. 4810.90 Bog=
oMIPS (lpj=3D9621817)
[    0.376023] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.376023] CPU: L2 cache: 4096K
[    0.376023] CPU 2/2 -> Node 0
[    0.376023] CPU: Physical Processor ID: 0
[    0.376023] CPU: Processor Core ID: 2
[    0.376023] CPU2: Thermal monitoring enabled (TM2)
[    0.454507] CPU2: Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz steppi=
ng 0b
[    0.468029] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.472029] Booting processor 3/3 ip 6000
[    0.488030] Initializing CPU#3
[    0.488030] Calibrating delay using timer specific routine.. 4810.92 Bog=
oMIPS (lpj=3D9621854)
[    0.488030] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.488030] CPU: L2 cache: 4096K
[    0.488030] CPU 3/3 -> Node 0
[    0.488030] CPU: Physical Processor ID: 0
[    0.488030] CPU: Processor Core ID: 3
[    0.488030] CPU3: Thermal monitoring enabled (TM2)
[    0.566610] CPU3: Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz steppi=
ng 0b
[    0.580031] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.584031] Brought up 4 CPUs
[    0.588032] Total of 4 processors activated (19247.17 BogoMIPS).
[    0.592032] CPU0 attaching sched-domain:
[    0.592032]  domain 0: span 0-1
[    0.592032]   groups: 0 1
[    0.592032]   domain 1: span 0-3
[    0.592032]    groups: 0-1 2-3
[    0.592032]    domain 2: span 0-3
[    0.592032]     groups: 0-3
[    0.592032] CPU1 attaching sched-domain:
[    0.592032]  domain 0: span 0-1
[    0.592032]   groups: 1 0
[    0.592032]   domain 1: span 0-3
[    0.592032]    groups: 0-1 2-3
[    0.592032]    domain 2: span 0-3
[    0.592032]     groups: 0-3
[    0.592032] CPU2 attaching sched-domain:
[    0.592032]  domain 0: span 2-3
[    0.592032]   groups: 2 3
[    0.592032]   domain 1: span 0-3
[    0.592032]    groups: 2-3 0-1
[    0.592032]    domain 2: span 0-3
[    0.592032]     groups: 0-3
[    0.592032] CPU3 attaching sched-domain:
[    0.592032]  domain 0: span 2-3
[    0.592032]   groups: 3 2
[    0.592032]   domain 1: span 0-3
[    0.592032]    groups: 2-3 0-1
[    0.592032]    domain 2: span 0-3
[    0.592032]     groups: 0-3
[    0.592032] net_namespace: 1224 bytes
[    0.596032] Booting paravirtualized kernel on bare hardware
[    0.600032] NET: Registered protocol family 16
[    0.604032] ACPI: bus type pci registered
[    0.608032] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.612032] PCI: Not using MMCONFIG.
[    0.616032] PCI: Using configuration type 1 for base access
[    0.620032] ACPI: EC: Look up EC in DSDT
[    0.634986] ACPI: Interpreter enabled
[    0.638986] ACPI: (supports S0 S1 S3 S4 S5)
[    0.658270] ACPI: Using IOAPIC for interrupt routing
[    0.663563] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 -=
 255
[    0.669971] PCI: MCFG area at e0000000 reserved in ACPI motherboard reso=
urces
[    0.687764] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.706691] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.710744] pci 0000:00:1f.0: quirk: region 0800-087f claimed by ICH6 AC=
PI/GPIO/TCO
[    0.714744] pci 0000:00:1f.0: quirk: region 0480-04bf claimed by ICH6 GP=
IO
[    0.718745] PCI: Transparent bridge - 0000:00:1e.0
[    0.722745] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.722745] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.722745] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
[    0.722745] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    0.722871] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[    0.743614] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14=
 15)
[    0.781356] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14=
 15)
[    0.817053] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14=
 15)
[    0.852119] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 *14=
 15)
[    0.891260] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 =
15) *0, disabled.
[    0.936984] ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14=
 15)
[    0.975932] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 =
*15)
[    1.016553] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14=
 15)
[    1.055305] ACPI Warning (tbutils-0217): Incorrect checksum in table [OE=
MB] - 6A, should be 69 [20080321]
[    1.067305] Linux Plug and Play Support v0.97 (c) Adam Belay
[    1.071305] pnp: PnP ACPI init
[    1.075305] ACPI: bus type pnp registered
[    1.079305] pnp 00:00: parse allocated resources
[    1.079305] pnp 00:00:   add io  0xcf8-0xcff flags 0x1
[    1.079305] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (a=
ctive)
[    1.079305] pnp 00:01: parse allocated resources
[    1.079305] pnp 00:01:   add mem 0xfed14000-0xfed19fff flags 0x1
[    1.079305] pnp 00:01: PNP0c01: calling quirk_system_pci_resources+0x0/0=
x15c
[    1.079305] pnp 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.079305] pnp 00:02: parse allocated resources
[    1.079305] pnp 00:02:   add dma 4 flags 0x4
[    1.079305] pnp 00:02:   add io  0x0-0xf flags 0x1
[    1.079305] pnp 00:02:   add io  0x81-0x83 flags 0x1
[    1.079305] pnp 00:02:   add io  0x87-0x87 flags 0x1
[    1.079305] pnp 00:02:   add io  0x89-0x8b flags 0x1
[    1.079305] pnp 00:02:   add io  0x8f-0x8f flags 0x1
[    1.079305] pnp 00:02:   add io  0xc0-0xdf flags 0x1
[    1.079305] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.079305] pnp 00:03: parse allocated resources
[    1.079305] pnp 00:03:   add io  0x70-0x71 flags 0x1
[    1.079305] pnp 00:03:   add irq 8 flags 0x1
[    1.079305] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.079305] pnp 00:04: parse allocated resources
[    1.079305] pnp 00:04:   add io  0x61-0x61 flags 0x1
[    1.079305] pnp 00:04: Plug and Play ACPI device, IDs PNP0800 (active)
[    1.079305] pnp 00:05: parse allocated resources
[    1.079305] pnp 00:05:   add io  0xf0-0xff flags 0x1
[    1.079305] pnp 00:05:   add irq 13 flags 0x1
[    1.079305] pnp 00:05: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.079305] pnp 00:06: parse allocated resources
[    1.079305] pnp 00:06:   add io  0x0-0xffffffffffffffff flags 0x10000001
[    1.079305] pnp 00:06:   add io  0x0-0xffffffffffffffff flags 0x10000001
[    1.079305] pnp 00:06:   add io  0x290-0x297 flags 0x1
[    1.079305] pnp 00:06: PNP0c02: calling quirk_system_pci_resources+0x0/0=
x15c
[    1.079305] pnp 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.079305] pnp 00:07: parse allocated resources
[    1.079305] pnp 00:07:   add io  0x10-0x1f flags 0x1
[    1.079305] pnp 00:07:   add io  0x22-0x3f flags 0x1
[    1.079305] pnp 00:07:   add io  0x44-0x4d flags 0x1
[    1.079305] pnp 00:07:   add io  0x50-0x5f flags 0x1
[    1.079305] pnp 00:07:   add io  0x62-0x63 flags 0x1
[    1.079305] pnp 00:07:   add io  0x65-0x6f flags 0x1
[    1.079305] pnp 00:07:   add io  0x72-0x7f flags 0x1
[    1.079305] pnp 00:07:   add io  0x80-0x80 flags 0x1
[    1.079305] pnp 00:07:   add io  0x84-0x86 flags 0x1
[    1.079305] pnp 00:07:   add io  0x88-0x88 flags 0x1
[    1.079305] pnp 00:07:   add io  0x8c-0x8e flags 0x1
[    1.079305] pnp 00:07:   add io  0x90-0x9f flags 0x1
[    1.079305] pnp 00:07:   add io  0xa2-0xbf flags 0x1
[    1.079305] pnp 00:07:   add io  0xe0-0xef flags 0x1
[    1.079305] pnp 00:07:   add io  0x4d0-0x4d1 flags 0x1
[    1.079305] pnp 00:07:   add io  0x800-0x87f flags 0x1
[    1.079305] pnp 00:07:   add io  0x400-0x3ff flags 0x10000001
[    1.079305] pnp 00:07:   add io  0x480-0x4bf flags 0x1
[    1.079305] pnp 00:07:   add mem 0xfed1c000-0xfed1ffff flags 0x1
[    1.079305] pnp 00:07:   add mem 0xfed20000-0xfed3ffff flags 0x1
[    1.079305] pnp 00:07:   add mem 0xfed50000-0xfed8ffff flags 0x1
[    1.079305] pnp 00:07:   add mem 0xffa00000-0xffafffff flags 0x1
[    1.079305] pnp 00:07:   add mem 0xffb00000-0xffbfffff flags 0x1
[    1.079305] pnp 00:07:   add mem 0xffe00000-0xffefffff flags 0x1
[    1.079305] pnp 00:07:   add mem 0xfff00000-0xfffffffe flags 0x1
[    1.079305] pnp 00:07: PNP0c02: calling quirk_system_pci_resources+0x0/0=
x15c
[    1.079305] pnp 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.079305] pnp 00:08: parse allocated resources
[    1.079362] pnp 00:08:   add mem 0xfed00000-0xfed003ff flags 0x0
[    1.083305] pnp 00:08: Plug and Play ACPI device, IDs PNP0103 (active)
[    1.083305] pnp 00:09: parse allocated resources
[    1.083305] pnp 00:09:   add irq 4 flags 0x1
[    1.083305] pnp 00:09:   add io  0x3f8-0x3ff flags 0x1
[    1.083305] pnp 00:09: parse resource options
[    1.083305] pnp 00:09: new independent option
[    1.083305] pnp 00:09: new dependent option (priority 0x0)
[    1.083305] pnp 00:09:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    1.083305] pnp 00:09:   irq bitmask 00000000,00000000,00000000,00000000=
,00000000,00000000,00000000,00000010 flags 0x1
[    1.083305] pnp 00:09: new dependent option (priority 0x1)
[    1.083305] pnp 00:09:   io  min 0x3f8 max 0x3f8 align 1 size 8 flags 0x1
[    1.083305] pnp 00:09:   irq bitmask 00000000,00000000,00000000,00000000=
,00000000,00000000,00000000,00001cf8 flags 0x1
[    1.083305] pnp 00:09: new dependent option (priority 0x1)
[    1.083305] pnp 00:09:   io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    1.083305] pnp 00:09:   irq bitmask 00000000,00000000,00000000,00000000=
,00000000,00000000,00000000,00001cf8 flags 0x1
[    1.083305] pnp 00:09: new dependent option (priority 0x1)
[    1.083305] pnp 00:09:   io  min 0x3e8 max 0x3e8 align 1 size 8 flags 0x1
[    1.083305] pnp 00:09:   irq bitmask 00000000,00000000,00000000,00000000=
,00000000,00000000,00000000,00001cf8 flags 0x1
[    1.083305] pnp 00:09: new dependent option (priority 0x1)
[    1.083305] pnp 00:09:   io  min 0x2e8 max 0x2e8 align 1 size 8 flags 0x1
[    1.083305] pnp 00:09:   irq bitmask 00000000,00000000,00000000,00000000=
,00000000,00000000,00000000,00001cf8 flags 0x1
[    1.083305] pnp 00:09: end dependent options
[    1.083305] pnp 00:09: Plug and Play ACPI device, IDs PNP0501 (active)
[    1.083305] pnp 00:0a: parse allocated resources
[    1.083305] pnp 00:0a:   add mem 0xfec00000-0xfec00fff flags 0x0
[    1.083305] pnp 00:0a:   add mem 0xfee00000-0xfee00fff flags 0x0
[    1.083305] pnp 00:0a: PNP0c02: calling quirk_system_pci_resources+0x0/0=
x15c
[    1.083305] pnp 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.083305] pnp 00:0b: parse allocated resources
[    1.083305] pnp 00:0b:   add io  0x60-0x60 flags 0x1
[    1.083305] pnp 00:0b:   add io  0x64-0x64 flags 0x1
[    1.083305] pnp 00:0b:   add irq 1 flags 0x1
[    1.083305] pnp 00:0b: Plug and Play ACPI device, IDs PNP0303 PNP030b (a=
ctive)
[    1.083305] pnp 00:0c: parse allocated resources
[    1.083305] pnp 00:0c:   add mem 0xe0000000-0xefffffff flags 0x0
[    1.083305] pnp 00:0c: PNP0c02: calling quirk_system_pci_resources+0x0/0=
x15c
[    1.083305] pnp 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.083305] pnp 00:0d: parse allocated resources
[    1.083305] pnp 00:0d:   add mem 0x0-0x9ffff flags 0x1
[    1.083305] pnp 00:0d:   add mem 0xc0000-0xcffff flags 0x0
[    1.083305] pnp 00:0d:   add mem 0xe0000-0xfffff flags 0x0
[    1.083305] pnp 00:0d:   add mem 0x100000-0xdfffffff flags 0x1
[    1.083305] pnp 00:0d:   add mem 0x0-0xffffffffffffffff flags 0x10000000
[    1.083305] pnp 00:0d: PNP0c01: calling quirk_system_pci_resources+0x0/0=
x15c
[    1.083305] pnp 00:0d: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.083305] pnp: PnP ACPI: found 14 devices
[    1.089632] ACPI: ACPI bus type pnp unregistered
[    1.093632] usbcore: registered new interface driver usbfs
[    1.099957] usbcore: registered new interface driver hub
[    1.103957] usbcore: registered new device driver usb
[    1.107957] PCI: Using ACPI for IRQ routing
[    1.127478] PCI-GART: No AMD northbridge found.
[    1.135021] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    1.155022] hpet0: 4 64-bit timers, 14318180 Hz
[    1.163072] ACPI: RTC can wake from S4
[    1.170021] Switched to high resolution mode on CPU 0
[    1.171036] Switched to high resolution mode on CPU 1
[    1.171192] Switched to high resolution mode on CPU 3
[    1.171190] Switched to high resolution mode on CPU 2
[    1.181988] pnp: the driver 'system' has been registered
[    1.182000] system 00:01: iomem range 0xfed14000-0xfed19fff has been res=
erved
[    1.266018] system 00:01: driver attached
[    1.266024] system 00:06: ioport range 0x290-0x297 has been reserved
[    1.349769] system 00:06: driver attached
[    1.349775] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    1.425874] system 00:07: ioport range 0x800-0x87f has been reserved
[    1.501981] system 00:07: ioport range 0x480-0x4bf has been reserved
[    1.578089] system 00:07: iomem range 0xfed1c000-0xfed1ffff has been res=
erved
[    1.664168] system 00:07: iomem range 0xfed20000-0xfed3ffff has been res=
erved
[    1.749616] system 00:07: iomem range 0xfed50000-0xfed8ffff has been res=
erved
[    1.835068] system 00:07: iomem range 0xffa00000-0xffafffff has been res=
erved
[    1.920950] system 00:07: iomem range 0xffb00000-0xffbfffff has been res=
erved
[    2.006399] system 00:07: iomem range 0xffe00000-0xffefffff has been res=
erved
[    2.092133] system 00:07: iomem range 0xfff00000-0xfffffffe could not be=
 reserved
[    2.181726] system 00:07: driver attached
[    2.181732] system 00:0a: iomem range 0xfec00000-0xfec00fff has been res=
erved
[    2.267119] system 00:0a: iomem range 0xfee00000-0xfee00fff could not be=
 reserved
[    2.357070] system 00:0a: driver attached
[    2.357076] system 00:0c: iomem range 0xe0000000-0xefffffff has been res=
erved
[    2.442477] system 00:0c: driver attached
[    2.442482] system 00:0d: iomem range 0x0-0x9ffff could not be reserved
[    2.521673] system 00:0d: iomem range 0xc0000-0xcffff has been reserved
[    2.600895] system 00:0d: iomem range 0xe0000-0xfffff could not be reser=
ved
[    2.684272] system 00:0d: iomem range 0x100000-0xdfffffff could not be r=
eserved
[    2.771858] system 00:0d: driver attached
[    2.849141] PCI: Bridge: 0000:00:1c.0
[    2.892964]   IO window: c000-cfff
[    2.933590]   MEM window: 0xfe800000-0xfe8fffff
[    2.986460]   PREFETCH window: 0x00000000f0000000-0x00000000f00fffff
[    3.062579] PCI: Bridge: 0000:00:1c.4
[    3.106488]   IO window: b000-bfff
[    3.149078]   MEM window: 0xfe700000-0xfe7fffff
[    3.201949]   PREFETCH window: 0x00000000f0100000-0x00000000f01fffff
[    3.278066] PCI: Bridge: 0000:00:1c.5
[    3.321978]   IO window: disabled.
[    3.362768]   MEM window: 0xfe600000-0xfe6fffff
[    3.417422]   PREFETCH window: disabled.
[    3.464545] PCI: Bridge: 0000:04:00.0
[    3.508471]   IO window: e000-efff
[    3.549264]   MEM window: 0xfeb00000-0xfebfffff
[    3.604307]   PREFETCH window: 0x00000000fd000000-0x00000000fdffffff
[    3.680422] PCI: Bridge: 0000:00:1e.0
[    3.724331]   IO window: d000-efff
[    3.765118]   MEM window: 0xfe900000-0xfebfffff
[    3.819328]   PREFETCH window: 0x00000000fcf00000-0x00000000fdffffff
[    3.898005] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -=
> IRQ 17
[    3.986657] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    3.986670] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -=
> IRQ 17
[    4.075433] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[    4.075447] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -=
> IRQ 16
[    4.164201] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[    4.164210] PCI: Setting latency timer of device 0000:00:1e.0 to 64
[    4.165053] NET: Registered protocol family 2
[    4.261455] IP route cache hash table entries: 262144 (order: 9, 2097152=
 bytes)
[    4.349444] TCP established hash table entries: 524288 (order: 11, 83886=
08 bytes)
[    4.441446] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    4.521924] TCP: Hash tables configured (established 524288 bind 65536)
[    4.601085] TCP reno registered
[    4.653455] NET: Registered protocol family 1
[    4.712003] checking if image is initramfs... it is
[    5.296566] Freeing initrd memory: 7613k freed
[    5.364557] audit: initializing netlink socket (disabled)
[    5.429210] type=3D2000 audit(1266355934.304:1): initialized
[    5.563751] Total HugeTLB memory allocated, 0
[    5.626628] VFS: Disk quotas dquot_6.5.1
[    5.674631] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    5.767007] msgmni has been set to 16015
[    5.818058] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 253)
[    5.906067] io scheduler noop registered
[    5.961705] io scheduler anticipatory registered
[    6.016946] io scheduler deadline registered
[    6.068164] io scheduler cfq registered (default)
[    6.124657] pci 0000:05:00.0: Boot video device
[    6.125778] PCI: Setting latency timer of device 0000:00:1c.0 to 64
[    6.125778] assign_interrupt_mode Found MSI capability
[    6.185811] Allocate Port Service[0000:00:1c.0:pcie00]
[    6.187661] Allocate Port Service[0000:00:1c.0:pcie02]
[    6.187661] Allocate Port Service[0000:00:1c.0:pcie03]
[    6.187661] PCI: Setting latency timer of device 0000:00:1c.4 to 64
[    6.187661] assign_interrupt_mode Found MSI capability
[    6.249212] Allocate Port Service[0000:00:1c.4:pcie00]
[    6.249548] Allocate Port Service[0000:00:1c.4:pcie02]
[    6.249623] Allocate Port Service[0000:00:1c.4:pcie03]
[    6.249623] PCI: Setting latency timer of device 0000:00:1c.5 to 64
[    6.249623] assign_interrupt_mode Found MSI capability
[    6.309653] Allocate Port Service[0000:00:1c.5:pcie00]
[    6.311422] Allocate Port Service[0000:00:1c.5:pcie02]
[    6.311422] Allocate Port Service[0000:00:1c.5:pcie03]
[    6.313680] hpet_resources: 0xfed00000 is busy
[    6.313680] Linux agpgart interface v0.103
[    6.404121] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sha=
ring enabled
[    6.498958] serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    6.571171] pnp: the driver 'serial' has been registered
[    6.571171] 00:09: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
[    6.638563] serial 00:09: driver attached
[    6.638970] brd: module loaded
[    6.677230] input: Macintosh mouse button emulation as /class/input/inpu=
t0
[    6.759746] pnp: the driver 'i8042 kbd' has been registered
[    6.759746] i8042 kbd 00:0b: driver attached
[    6.759746] pnp: the driver 'i8042 aux' has been registered
[    6.759746] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    6.834429] PNP: PS/2 appears to have AUX port disabled, if this is inco=
rrect please boot with i8042.nopnp
[    6.950606] serio: i8042 KBD port at 0x60,0x64 irq 1
[    7.031104] mice: PS/2 mouse device common for all mice
[    7.093840] pnp: the driver 'rtc_cmos' has been registered
[    7.093840] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    7.166854] rtc0: alarms up to one month, y3k
[    7.241983] rtc_cmos 00:03: driver attached
[    7.244573] cpuidle: using governor ladder
[    7.293622] cpuidle: using governor menu
[    7.417624] No iBFT detected.
[    7.453909] TCP cubic registered
[    7.493630] NET: Registered protocol family 17
[    7.505619] input: AT Translated Set 2 keyboard as /class/input/input1
[    7.651491] registered taskstats version 1
[    7.700696] rtc_cmos 00:03: setting system clock to 2010-02-16 21:32:28 =
UTC (1266355948)
[    7.796879] Freeing unused kernel memory: 392k freed
[    7.936077] ACPI: SSDT DFF8E0D0, 01D2 (r1    AMI   CPU1PM        1 INTL =
20060113)
[    8.078673] ACPI: ACPI0007:00 is registered as cooling_device0
[    8.162947] ACPI: SSDT DFF8E2B0, 0143 (r1    AMI   CPU2PM        1 INTL =
20060113)
[    8.259196] ACPI: ACPI0007:01 is registered as cooling_device1
[    8.329334] ACPI: SSDT DFF8E400, 0143 (r1    AMI   CPU3PM        1 INTL =
20060113)
[    8.421193] ACPI: ACPI0007:02 is registered as cooling_device2
[    8.491931] ACPI: SSDT DFF8E550, 0143 (r1    AMI   CPU4PM        1 INTL =
20060113)
[    8.585919] ACPI: ACPI0007:03 is registered as cooling_device3
[    8.835154] USB Universal Host Controller Interface driver v3.0
[    8.954303] ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -=
> IRQ 16
[    9.046732] PCI: Setting latency timer of device 0000:00:1a.0 to 64
[    9.046736] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    9.107383] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus =
number 1
[    9.196028] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000a800
[    9.266896] usb usb1: configuration #1 chosen from 1 choice
[    9.331732] hub 1-0:1.0: USB hub found
[    9.378588] hub 1-0:1.0: 2 ports detected
[    9.427375] No dock devices found.
[    9.484011] SCSI subsystem initialized
[    9.531988] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
[    9.654616] Copyright (c) 1999-2006 Intel Corporation.
[    9.720300] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    9.801704] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    9.889704] usb usb1: Product: UHCI Host Controller
[    9.948391] usb usb1: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   10.021389] usb usb1: SerialNumber: 0000:00:1a.0
[   10.077697] libata version 3.00 loaded.
[   10.079410] ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -=
> IRQ 21
[   10.185938] PCI: Setting latency timer of device 0000:00:1a.1 to 64
[   10.185941] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[   10.249990] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus =
number 2
[   10.338592] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000a880
[   10.407416] usb usb2: configuration #1 chosen from 1 choice
[   10.490229] hub 2-0:1.0: USB hub found
[   10.535237] hub 2-0:1.0: 2 ports detected
[   10.682992] usb usb2: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   10.702976] usb 1-2: new full speed USB device using uhci_hcd and addres=
s 2
[   10.983950] usb usb2: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   11.068442] usb usb2: Product: UHCI Host Controller
[   11.158868] usb usb2: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   11.231866] usb usb2: SerialNumber: 0000:00:1a.1
[   11.289893] ACPI: PCI Interrupt 0000:00:1a.2[C] -> GSI 18 (level, low) -=
> IRQ 18
[   11.378396] PCI: Setting latency timer of device 0000:00:1a.2 to 64
[   11.378398] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[   11.364449] usb 1-2: configuration #1 chosen from 1 choice
[   11.507007] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus =
number 3
[   11.877687] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000ac00
[   11.877687] usb 1-2: New USB device found, idVendor=3D1608, idProduct=3D=
0001
[   11.877687] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D5
[   11.877687] usb 1-2: Product: Edgeport/4
[   11.877687] usb 1-2: Manufacturer: Inside Out Networks
[   11.877687] usb 1-2: SerialNumber: V13408648
[   12.289075] usb usb3: configuration #1 chosen from 1 choice
[   12.657056] hub 3-0:1.0: USB hub found
[   12.703934] hub 3-0:1.0: 2 ports detected
[   12.856998] usb usb3: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   12.934535] usb usb3: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   13.022562] usb usb3: Product: UHCI Host Controller
[   13.080926] usb usb3: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   13.153925] usb usb3: SerialNumber: 0000:00:1a.2
[   13.223919] ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -=
> IRQ 18
[   13.312454] PCI: Setting latency timer of device 0000:00:1a.7 to 64
[   13.312457] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[   13.384482] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus =
number 4
[   13.513408] ehci_hcd 0000:00:1a.7: debug port 1
[   14.030410] PCI: cache line size of 32 is not supported by device 0000:0=
0:1a.7
[   14.030413] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfe5ffc00
[   14.114103] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10=
 Dec 2004
[   14.278134] usb usb4: configuration #1 chosen from 1 choice
[   14.362098] usb 1-2: USB disconnect, address 2
[   14.365037] hub 4-0:1.0: USB hub found
[   14.365041] hub 4-0:1.0: 6 ports detected
[   14.537515] usb usb4: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   14.537517] usb usb4: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   14.537519] usb usb4: Product: EHCI Host Controller
[   14.537520] usb usb4: Manufacturer: Linux 2.6.26-2-amd64 ehci_hcd
[   14.537521] usb usb4: SerialNumber: 0000:00:1a.7
[   14.923493] ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -=
> IRQ 23
[   15.333115] PCI: Setting latency timer of device 0000:00:1d.0 to 64
[   15.333117] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[   15.398238] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus =
number 5
[   15.484942] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000a080
[   15.553758] usb usb5: configuration #1 chosen from 1 choice
[   15.622585] hub 5-0:1.0: USB hub found
[   15.665460] hub 5-0:1.0: 2 ports detected
[   15.837042] usb usb5: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   15.931011] usb usb5: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   16.100514] usb usb5: Product: UHCI Host Controller
[   16.155203] usb usb5: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   16.228516] usb usb5: SerialNumber: 0000:00:1d.0
[   16.286536] ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -=
> IRQ 19
[   16.375035] PCI: Setting latency timer of device 0000:00:1d.1 to 64
[   16.375037] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[   16.461734] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus =
number 6
[   16.461734] usb 1-2: new full speed USB device using uhci_hcd and addres=
s 3
[   16.951280] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000a400
[   17.032200] usb usb6: configuration #1 chosen from 1 choice
[   17.099070] hub 6-0:1.0: USB hub found
[   17.140116] hub 6-0:1.0: 2 ports detected
[   17.191112] usb 1-2: configuration #1 chosen from 1 choice
[   17.662944] usb 1-2: New USB device found, idVendor=3D1608, idProduct=3D=
0001
[   17.673678] usb usb6: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   17.673678] usb usb6: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   17.673678] usb usb6: Product: UHCI Host Controller
[   17.673678] usb usb6: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   17.673678] usb usb6: SerialNumber: 0000:00:1d.1
[   18.504844] usb 1-2: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D5
[   18.504844] ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -=
> IRQ 18
[   18.504844] PCI: Setting latency timer of device 0000:00:1d.2 to 64
[   18.504844] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[   18.504844] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus =
number 7
[   18.504844] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000a480
[   18.504844] usb usb7: configuration #1 chosen from 1 choice
[   18.504844] hub 7-0:1.0: USB hub found
[   18.504844] hub 7-0:1.0: 2 ports detected
[   18.876853] usb usb7: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[   18.876853] usb usb7: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   18.876853] usb usb7: Product: UHCI Host Controller
[   18.876853] usb usb7: Manufacturer: Linux 2.6.26-2-amd64 uhci_hcd
[   18.876853] usb usb7: SerialNumber: 0000:00:1d.2
[   18.688835] ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -=
> IRQ 23
[   18.688835] PCI: Setting latency timer of device 0000:00:1d.7 to 64
[   18.688835] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[   18.688835] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus =
number 8
[   18.688835] ehci_hcd 0000:00:1d.7: debug port 1
[   18.688835] PCI: cache line size of 32 is not supported by device 0000:0=
0:1d.7
[   18.688835] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xfe5ff800
[   19.688884] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10=
 Dec 2004
[   19.688884] usb usb8: configuration #1 chosen from 1 choice
[   19.688884] hub 8-0:1.0: USB hub found
[   19.688884] hub 8-0:1.0: 6 ports detected
[   19.792872] usb usb8: New USB device found, idVendor=3D1d6b, idProduct=
=3D0002
[   19.792872] usb usb8: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   19.792872] usb usb8: Product: EHCI Host Controller
[   19.792872] usb usb8: Manufacturer: Linux 2.6.26-2-amd64 ehci_hcd
[   19.792872] usb usb8: SerialNumber: 0000:00:1d.7
[   21.572630] usb 1-2: Product: Edgeport/4
[   21.619110] usb 1-2: Manufacturer: Inside Out Networks
[   21.572630] ahci 0000:00:1f.2: version 3.0
[   21.576629] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 17 (level, low) -=
> IRQ 17
[   21.576629] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   21.572630] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 22 (level, low) -=
> IRQ 22
[   21.576629] atl1 0000:01:00.0: version 2.1.3
[   21.910233] usb 1-2: SerialNumber: V13408648
[   21.572630] ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 18 (level, low) -=
> IRQ 18
[   21.572630] e1000: 0000:04:02.0: e1000_probe: (PCI:33MHz:32-bit) 00:04:2=
3:9f:44:10
[   21.572630] e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connecti=
on
[   22.507588] ACPI: PCI Interrupt 0000:04:02.1[B] -> GSI 19 (level, low) -=
> IRQ 19
[   22.596811] ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 4 ports 3 Gbps 0x=
33 impl SATA mode
[   22.710347] ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp=
 pio slum part=20
[   22.857847] PCI: Setting latency timer of device 0000:00:1f.2 to 64
[   22.861843] scsi0 : ahci
[   22.890170] scsi1 : ahci
[   22.927000] scsi2 : ahci
[   23.192830] scsi3 : ahci
[   23.236666] scsi4 : ahci
[   23.267009] scsi5 : ahci
[   23.299239] ata1: SATA max UDMA/133 irq_stat 0x00000040, connection stat=
us changed irq 1276
[   23.405400] e1000: 0000:04:02.1: e1000_probe: (PCI:33MHz:32-bit) 00:04:2=
3:9f:44:11
[   23.443307] e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connecti=
on
[   23.668061] ata2: SATA max UDMA/133 irq_stat 0x00000040, connection stat=
us changed
[   23.763919] ata3: DUMMY
[   23.793260] ata4: DUMMY
[   23.825264] ata5: SATA max UDMA/133 irq_stat 0x00000040, connection stat=
us changed
[   23.914605] ata6: SATA max UDMA/133 abar m2048@0xfe5fe800 port 0xfe5feb8=
0 irq 1276
[   24.901033] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   24.985380] ata1.00: ATA-7: SAMSUNG HD103UJ, 1AA01113, max UDMA7
[   25.053470] ata1.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   25.370223] ata1.00: configured for UDMA/133
[   26.493814] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   26.738061] ata2.00: ATA-7: SAMSUNG HD103UJ, 1AA01109, max UDMA7
[   26.808373] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   26.900035] ata2.00: configured for UDMA/133
[   28.378047] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   28.570291] ata5.00: ATA-7: SAMSUNG HD103UJ, 1AA01109, max UDMA7
[   28.636603] ata5.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   28.726039] ata5.00: configured for UDMA/133
[   29.111623] ata6: SATA link down (SStatus 0 SControl 300)
[   29.279611] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1A=
A0 PQ: 0 ANSI: 5
[   29.780629] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1A=
A0 PQ: 0 ANSI: 5
[   29.917178] scsi 4:0:0:0: Direct-Access     ATA      SAMSUNG HD103UJ  1A=
A0 PQ: 0 ANSI: 5
[   30.020626] ACPI: PCI Interrupt 0000:04:00.1[A] -> <7>sata_sil24 0000:03=
:00.0: version 1.1
[   30.042170] ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -=
> IRQ 16
[   30.042170] PCI: Setting latency timer of device 0000:03:00.0 to 64
[   30.042170] scsi6 : sata_sil24
[   30.042170] scsi7 : sata_sil24
[   30.042170] ata7: SATA max UDMA/100 host m128@0xfe8ffc00 port 0xfe8f8000=
 irq 16
[   30.042170] ata8: SATA max UDMA/100 host m128@0xfe8ffc00 port 0xfe8fa000=
 irq 16
[   30.487303] GSI 16 (level, low) -> IRQ 16
[   30.533635] ACPI: PCI Interrupt 0000:04:03.0[A] -> GSI 16 (level, low) -=
> IRQ 16
[   30.690078] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=3D[16]  MMIO=3D=
[feaef800-feaeffff]  Max Packet=3D[2048]  IR/IT contexts=3D[4/8]
[   32.392330] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001e8c00010ca8=
bf]
[   33.578906] ata7: SATA link down (SStatus 0 SControl 0)
[   35.836531] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   36.997476] ata8.15: Port Multiplier 1.1, 0x1095:0x4726 r31, 7 ports, fe=
at 0x1/0x9
[   37.088700] ata8.00: hard resetting link
[   37.611588] ata8.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   37.697625] ata8.01: hard resetting link
[   38.115121] ata8.01: SATA link down (SStatus 0 SControl 320)
[   38.187252] ata8.02: hard resetting link
[   38.743249] ata8.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   38.845553] ata8.03: hard resetting link
[   39.426702] ata8.03: SATA link down (SStatus 0 SControl 320)
[   39.519888] ata8.04: hard resetting link
[   40.039930] ata8.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[   40.126486] ata8.05: hard resetting link
[   40.643584] ata8.05: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[   40.728060] ata8.06: hard resetting link
[   41.219924] ata8.06: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[   41.333582] ata8.00: HPA detected: current 3907029168, native 1844674407=
3321613488
[   41.424080] ata8.00: ATA-8: WDC WD20EADS-00S2B0, 04.05G04, max UDMA/133
[   41.504085] ata8.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 31/3=
2)
[   41.593817] ata8.00: configured for UDMA/100
[   41.650768] ata8.02: HPA detected: current 3907029168, native 1844674407=
3321613488
[   41.738777] ata8.02: ATA-8: WDC WD20EADS-00S2B0, 04.05G04, max UDMA/133
[   41.817937] ata8.02: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   41.900650] ata8.02: configured for UDMA/100
[   41.958610] ata8.04: HPA detected: current 3907029168, native 1844674407=
3321613488
[   42.046618] ata8.04: ATA-8: WDC WD20EADS-00S2B0, 04.05G04, max UDMA/133
[   42.125783] ata8.04: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   42.212594] ata8.04: configured for UDMA/100
[   42.266351] ata8.05: unsupported device, disabling
[   42.322356] ata8.05: disabled
[   42.359906] ata8: EH complete
[   42.395543] scsi 7:0:0:0: Direct-Access     ATA      WDC WD20EADS-00S 04=
.0 PQ: 0 ANSI: 5
[   42.492222] scsi 7:2:0:0: Direct-Access     ATA      WDC WD20EADS-00S 04=
.0 PQ: 0 ANSI: 5
[   42.589305] scsi 7:4:0:0: Direct-Access     ATA      WDC WD20EADS-00S 04=
.0 PQ: 0 ANSI: 5
[   42.687375] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -=
> IRQ 16
[   43.167797] Driver 'sd' needs updating - please use bus_type methods
[   43.240460] sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000=
205 MB)
[   43.366254] sd 0:0:0:0: [sda] Write Protect is off
[   43.423720] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   43.427715] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   43.535765] sd 0:0:0:0: [sda] 1953525168 512-byte hardware sectors (1000=
205 MB)
[   43.623355] sd 0:0:0:0: [sda] Write Protect is off
[   43.680043] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   43.680062] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   43.788423]  sda: sda1 sda2
[   43.958440] sd 0:0:0:0: [sda] Attached SCSI disk
[   44.043041] sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000=
205 MB)
[   44.244931] sd 1:0:0:0: [sdb] Write Protect is off
[   44.304925] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   44.304957] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   44.413343] sd 1:0:0:0: [sdb] 1953525168 512-byte hardware sectors (1000=
205 MB)
[   44.504960] sd 1:0:0:0: [sdb] Write Protect is off
[   44.508940] ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x=
3 impl SATA mode
[   44.508940] ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum =
part=20
[   44.508940] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   44.508940] scsi8 : ahci
[   44.775042] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   44.775061] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   45.020935] scsi9 : ahci
[   45.020935] ata9: SATA max UDMA/133 abar m8192@0xfe7fe000 port 0xfe7fe10=
0 irq 16
[   45.020935] ata10: SATA max UDMA/133 abar m8192@0xfe7fe000 port 0xfe7fe1=
80 irq 16
[   45.413377]  sdb:<6>ata9: SATA link down (SStatus 0 SControl 300)
[   45.489336]  sdb1 sdb2
[   45.526588] sd 1:0:0:0: [sdb] Attached SCSI disk
[   45.624921] sd 4:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000=
205 MB)
[   45.741683] sd 4:0:0:0: [sdc] Write Protect is off
[   45.799152] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   45.799173] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   45.907729] sd 4:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000=
205 MB)
[   45.973697] ata10: SATA link down (SStatus 0 SControl 300)
[   46.157693] sd 4:0:0:0: [sdc] Write Protect is off
[   46.216204] sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
[   46.216554] sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   46.325082]  sdc:<6>Uniform Multi-Platform E-IDE driver
[   46.389184] ide: Assuming 33MHz system bus speed for PIO modes; override=
 with idebus=3Dxx
[   46.389707]  sdc1
[   46.517686] sd 4:0:0:0: [sdc] Attached SCSI disk
[   46.617010] sd 7:0:0:0: [sdd] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   46.617010] JMB: IDE controller (0x197b:0x2363 rev 0x03) at  PCI slot 00=
00:02:00.1
[   46.617036] ACPI: PCI Interrupt 0000:02:00.1[B] -> GSI 17 (level, low) -=
> IRQ 17
[   46.617047] JMB: 100% native mode on irq 17
[   46.617057]     ide0: BM-DMA at 0xb400-0xb407
[   46.617070]     ide1: BM-DMA at 0xb408-0xb40f
[   46.617076] Probing IDE interface ide0...
[   47.037319] sd 7:0:0:0: [sdd] Write Protect is off
[   47.095106] sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   47.095125] sd 7:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   47.183812] Probing IDE interface ide1...
[   47.203801] sd 7:0:0:0: [sdd] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   47.291382] sd 7:0:0:0: [sdd] Write Protect is off
[   47.348726] sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   47.348744] sd 7:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   47.457100]  sdd: unknown partition table
[   47.513730] sd 7:0:0:0: [sdd] Attached SCSI disk
[   47.615436] sd 7:2:0:0: [sde] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   47.703230] sd 7:2:0:0: [sde] Write Protect is off
[   47.783769] sd 7:2:0:0: [sde] Mode Sense: 00 3a 00 00
[   47.783788] sd 7:2:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   47.915743] ide0 at 0xbc00-0xbc07,0xb882 on irq 17
[   47.915773] ide1 at 0xb800-0xb807,0xb482 on irq 17
[   48.113301] sd 7:2:0:0: [sde] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   48.201258] sd 7:2:0:0: [sde] Write Protect is off
[   48.289259] sd 7:2:0:0: [sde] Mode Sense: 00 3a 00 00
[   48.289278] sd 7:2:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   48.397637]  sde: unknown partition table
[   48.502201] sd 7:2:0:0: [sde] Attached SCSI disk
[   48.557786] sd 7:4:0:0: [sdf] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   48.645348] sd 7:4:0:0: [sdf] Write Protect is off
[   48.702054] sd 7:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[   48.702073] sd 7:4:0:0: [sdf] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   48.810465] sd 7:4:0:0: [sdf] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   48.898060] sd 7:4:0:0: [sdf] Write Protect is off
[   48.955804] sd 7:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[   48.955826] sd 7:4:0:0: [sdf] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   49.064180]  sdf: unknown partition table
[   49.146996] sd 7:4:0:0: [sdf] Attached SCSI disk
[   49.491962] md: raid1 personality registered for level 1
[   49.642405] md: md0 stopped.
[   49.732323] md: bind<sdb1>
[   49.772330] md: bind<sda1>
[   49.851780] raid1: raid set md0 active with 2 out of 2 mirrors
[   49.943361] md: md1 stopped.
[   50.039911] md: bind<sdb2>
[   50.077935] md: bind<sda2>
[   50.180221] raid1: raid set md1 active with 2 out of 2 mirrors
[   50.337085] device-mapper: uevent: version 1.0.3
[   50.469663] device-mapper: ioctl: 4.13.0-ioctl (2007-10-18) initialised:=
 dm-devel@redhat.com
[   50.778232] EXT3-fs: INFO: recovery required on readonly filesystem.
[   50.862081] EXT3-fs: write access will be enabled during recovery.
[   51.165406] kjournald starting.  Commit interval 5 seconds
[   51.180364] EXT3-fs: recovery complete.
[   51.292341] EXT3-fs: mounted filesystem with ordered data mode.
[   53.029486] udevd version 125 started
[   53.389135] usbcore: registered new interface driver usbserial
[   53.461779] usbserial: USB Serial support registered for generic
[   53.533868] usbcore: registered new interface driver usbserial_generic
[   53.613830] usbserial: USB Serial Driver core
[   53.666037] input: Power Button (FF) as /class/input/input2
[   53.790804] usbserial: USB Serial support registered for Edgeport 2 port=
 adapter
[   53.931730] usbserial: USB Serial support registered for Edgeport 4 port=
 adapter
[   54.020429] usbserial: USB Serial support registered for Edgeport 8 port=
 adapter
[   54.109141] usbserial: USB Serial support registered for EPiC device
[   54.185319] io_edgeport 1-2:1.0: Edgeport 4 port adapter converter detec=
ted
[   54.276817] usb 1-2: Inside Out Networks=C3=A7 Edgeport/4=C3=BF detected
[   54.349578] input: PC Speaker as /class/input/input3
[   54.480302] ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 18 (level, low) -=
> IRQ 18
[   54.595302] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   54.610780] ACPI: Power Button (FF) [PWRF]
[   54.610780] input: Power Button (CM) as /class/input/input4
[   54.846789] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   54.994241] ACPI: Power Button (CM) [PWRB]
[   55.140926] Error: Driver 'pcspkr' is already registered, aborting...
[   55.743521] usb 1-2: Edgeport 4 port adapter converter now attached to t=
tyUSB0
[   55.917040] usb 1-2: Edgeport 4 port adapter converter now attached to t=
tyUSB1
[   56.007801] usb 1-2: Edgeport 4 port adapter converter now attached to t=
tyUSB2
[   56.098919] usb 1-2: Edgeport 4 port adapter converter now attached to t=
tyUSB3
[   56.189523] usbcore: registered new interface driver io_edgeport
[   56.267919] io_edgeport: Edgeport USB Serial Driver v2.7
[   57.550446] EXT3 FS on dm-0, internal journal
[   58.206741] w83627ehf: Found W83627DHG chip at 0x290
[   58.339674] coretemp coretemp.0: Using relative temperature scale!
[   58.457908] coretemp coretemp.1: Using relative temperature scale!
[   58.554713] coretemp coretemp.2: Using relative temperature scale!
[   58.652174] coretemp coretemp.3: Using relative temperature scale!
[   58.765489] NET: Registered protocol family 10
[   58.823763] lo: Disabled Privacy Extensions
[   58.921844] tun: Universal TUN/TAP device driver, 1.6
[   59.014633] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   59.226987] md: md2 stopped.
[   59.368486] md: bind<sde>
[   59.410863] md: bind<sdf>
[   59.446151] md: bind<sdd>
[   59.521967] xor: automatically using best checksumming function: generic=
_sse
[   59.693956]    generic_sse:  8815.000 MB/sec
[   59.741979] xor: using function: generic_sse (8815.000 MB/sec)
[   59.878973] async_tx: api initialized (async)
[   60.010820] raid6: int64x1   2256 MB/s
[   60.138818] raid6: int64x2   3064 MB/s
[   60.250821] raid6: int64x4   2671 MB/s
[   60.366742] raid6: int64x8   1722 MB/s
[   60.478744] raid6: sse2x1    3870 MB/s
[   60.606666] raid6: sse2x2    4465 MB/s
[   60.719936] raid6: sse2x4    7263 MB/s
[   60.765347] raid6: using algorithm sse2x4 (7263 MB/s)
[   60.825881] md: raid6 personality registered for level 6
[   60.889884] md: raid5 personality registered for level 5
[   60.964804] md: raid4 personality registered for level 4
[   61.029658] raid5: device sdd operational as raid disk 0
[   61.093251] raid5: device sdf operational as raid disk 2
[   61.156911] raid5: device sde operational as raid disk 1
[   61.221562] raid5: allocated 3224kB for md2
[   61.271704] raid5: raid level 5 set md2 active with 3 out of 3 devices, =
algorithm 2
[   61.363459] RAID5 conf printout:
[   61.403313]  --- rd:3 wd:3
[   61.435705]  disk 0, o:1, dev:sdd
[   61.475385]  disk 1, o:1, dev:sde
[   61.515157]  disk 2, o:1, dev:sdf
[   61.718746] md2: bitmap initialized from disk: read 30/30 pages, set 33 =
bits
[   61.811040] created bitmap (466 pages) for device md2
[   63.865723] ata8.00: log page 10h reported inactive tag 0
[   63.943744] ata8.00: exception Emask 0x1 SAct 0x3c SErr 0x0 action 0x0
[   64.107789] ata8.00: irq_stat 0x03060002, device error via SDB FIS
[   64.199764] ata8.00: cmd 60/08:10:00:02:00/00:00:00:00:00/40 tag 2 ncq 4=
096 in
[   64.199765]          res 60/08:10:00:02:00/00:00:00:00:00/40 Emask 0x1 (=
device error)
[   64.580730] ata8.00: status: { DRDY DF }
[   64.628731] ata8.00: cmd 60/78:18:08:02:00/00:00:00:00:00/40 tag 3 ncq 6=
1440 in
[   64.628732]          res 60/78:18:08:02:00/00:00:00:00:00/40 Emask 0x89 =
(media error)
[   64.810084] ata8.00: status: { DRDY DF }
[   64.879835] ata8.00: error: { UNC IDNF }
[   64.930935] ata8.00: cmd 60/18:20:e8:00:00/00:00:00:00:00/40 tag 4 ncq 1=
2288 in
[   64.930936]          res 56/1b:02:02:00:00/00:00:00:40:56/00 Emask 0x1 (=
device error)
[   65.204495] ata8.00: status: { DRDY }
[   65.248497] ata8.00: error: { IDNF }
[   65.292407] ata8.00: cmd 60/80:28:80:01:00/00:00:00:00:00/40 tag 5 ncq 6=
5536 in
[   65.292408]          res 56/1b:02:02:00:00/00:00:00:50:56/00 Emask 0x1 (=
device error)
[   65.590268] ata8.00: status: { DRDY }
[   65.658016] ata8.00: error: { IDNF }
[   65.725346] ata8.00: configured for UDMA/100
[   65.780607] sd 7:0:0:0: [sdd] Device not ready: Sense Key : Not Ready [c=
urrent] [descriptor]
[   65.925384] sd 7:0:0:0: [sdd] Device not ready: Add. Sense: Logical unit=
 not ready, cause not reportable
[   66.040355] end_request: I/O error, dev sdd, sector 520
[   66.103442] ata8: EH complete
[   66.137877] sd 7:0:0:0: [sdd] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   66.228486] sd 7:0:0:0: [sdd] Write Protect is off
[   66.285654] sd 7:0:0:0: [sdd] Mode Sense: 00 3a 00 00
[   66.285676] sd 7:0:0:0: [sdd] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   66.397617] sd 7:2:0:0: [sde] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   66.581553] sd 7:2:0:0: [sde] Write Protect is off
[   66.647362] sd 7:2:0:0: [sde] Mode Sense: 00 3a 00 00
[   66.647381] sd 7:2:0:0: [sde] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   66.761433] sd 7:4:0:0: [sdf] 3907029168 512-byte hardware sectors (2000=
399 MB)
[   66.851987] sd 7:4:0:0: [sdf] Write Protect is off
[   66.999360] sd 7:4:0:0: [sdf] Mode Sense: 00 3a 00 00
[   66.999387] sd 7:4:0:0: [sdf] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   75.843058] fuse init (API version 7.9)
[   76.092263] kjournald starting.  Commit interval 5 seconds
[   76.146632] EXT3 FS on md0, internal journal
[   76.146632] EXT3-fs: mounted filesystem with ordered data mode.
[   76.421262] kjournald starting.  Commit interval 5 seconds
[   76.455870] EXT3 FS on dm-1, internal journal
[   76.455870] EXT3-fs: mounted filesystem with ordered data mode.
[   76.652103] kjournald starting.  Commit interval 5 seconds
[   76.727994] EXT3 FS on sdc1, internal journal
[   76.835887] EXT3-fs: mounted filesystem with ordered data mode.
[   77.079517] kjournald starting.  Commit interval 5 seconds
[   77.183492] EXT3 FS on md2, internal journal
[   77.251479] EXT3-fs: mounted filesystem with ordered data mode.
[   77.749061] Adding 16777208k swap on /dev/mapper/vg00-swap.  Priority:-1=
 extents:1 across:16777208k
[   79.276801] Bridge firewalling registered
[   79.350434] br0: Dropping NETIF_F_UFO since no NETIF_F_HW_CSUM feature.
[   79.449478] device eth1 entered promiscuous mode
[   79.518421] ADDRCONF(NETDEV_UP): eth1: link is not ready
[   79.583139] e1000: eth1: e1000_watchdog: NIC Link is Up 1000 Mbps Full D=
uplex, Flow Control: RX/TX
[   79.981853] ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   80.065502] br0: port 1(eth1) entering learning state
[   91.155084] eth1: no IPv6 routers present
[   91.171332] br0: no IPv6 routers present
[   95.834910] br0: topology change detected, propagating
[   96.087855] br0: port 1(eth1) entering forwarding state
[   97.538371] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[   97.686425] All bugs added by David S. Miller <davem@redhat.com>
[  102.863617] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[  103.071936] ip_tables: (C) 2000-2006 Netfilter Core Team
[  104.555615] PPP generic driver version 2.4.2
[  104.785742] device tap0 entered promiscuous mode
[  104.859150] br0: port 2(tap0) entering learning state
[  104.935622] device br0.90 entered promiscuous mode
[  105.035620] device br0 entered promiscuous mode
[  105.172611] IPv6 over IPv4 tunneling driver
[  105.240793] sit0: Disabled Privacy Extensions
[  105.310522] sixxs: Disabled Privacy Extensions
[  105.792843] RPC: Registered udp transport module.
[  105.881027] RPC: Registered tcp transport module.
[  106.256341] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  106.405877] PPP BSD Compression module registered
[  106.534299] PPP Deflate Compression module registered
[  106.815726] ttyS1: LSR safety check engaged!
[  106.878542] u32 classifier
[  106.911742] ttyS1: LSR safety check engaged!
[  107.027620]     Performance counters on
[  107.090258]     input device check on=20
[  107.154234]     Actions configured=20

--=-=-=--
