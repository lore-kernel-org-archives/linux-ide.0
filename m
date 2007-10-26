From: Marcin Juszkiewicz <openembedded@haerwu.biz>
Subject: Re: Re-enabling Serial ATA ports possible?
Date: Fri, 26 Oct 2007 11:18:44 +0200
Message-ID: <200710261118.47736.openembedded@haerwu.biz>
References: <200710171251.l9HCpCv7021811@harpo.it.uu.se> <47214F9F.50306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from v813.rev.tld.pl ([195.149.226.213]:60871 "EHLO
	smtp.host4.kei.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbXJZJSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 05:18:55 -0400
In-Reply-To: <47214F9F.50306@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Dnia pi=B1tek, 26 pa=BCdziernika 2007, Tejun Heo napisa=B3:

> Care to post full boot log and the result of "hdparm -I /dev/sr0"?

/dev/sr0:

ATAPI CD-ROM, with removable media
        Model Number:       TSSTcorpCD/DVDW SH-S183A
        Serial Number:
        Firmware Revision:  SB02
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2
             Cycle time: min=3D120ns recommended=3D120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=3D120ns  IORDY flow control=3D=
120ns
Commands/features:
        Enabled Supported:
           *    SATA-I signaling speed (1.5Gb/s)
           *    Host-initiated interface power management
           *    Phy event counters
                Device-initiated interface power management
                Asynchronous notification (eg. media change)
           *    Software settings preservation

> Also, you can trigger rescan by "echo - - - /sys/class/scsi_host/host=
X/scan".

This does not worked here - I mean it found only online drives not offl=
ine
dvd/rw drive.

Dmesg from fresh boot:

[    0.000000] Linux version 2.6.24-rc1 (root@home) (gcc version 4.2.3 =
20071014 (prerelease) (Debian 4.2.2-3)) #1 PREEMPT Wed Oct 24 11:25:46 =
CEST 2007
[    0.000000] Command line: root=3D/dev/sda1 ro quiet apic lapic
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserve=
d)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000087ee0000 (usable)
[    0.000000]  BIOS-e820: 0000000087ee0000 - 0000000087ee3000 (ACPI NV=
S)
[    0.000000]  BIOS-e820: 0000000087ee3000 - 0000000087ef0000 (ACPI da=
ta)
[    0.000000]  BIOS-e820: 0000000087ef0000 - 0000000087f00000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserve=
d)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserve=
d)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 us=
ed
[    0.000000] Entering add_active_range(0, 256, 556768) 1 entries of 2=
56 used
[    0.000000] end_pfn_map =3D 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP 000F82C0, 0014 (r0 RS480 )
[    0.000000] ACPI: RSDT 87EE3040, 0034 (r1 RS480  AWRDACPI 42302E31 A=
WRD        0)
[    0.000000] ACPI: FACP 87EE30C0, 0074 (r1 RS480  AWRDACPI 42302E31 A=
WRD        0)
[    0.000000] ACPI: DSDT 87EE3180, 3E09 (r1 RS480  AWRDACPI     1000 M=
SFT  100000E)
[    0.000000] ACPI: FACS 87EE0000, 0040
[    0.000000] ACPI: SSDT 87EE70C0, 00D6 (r1 PTLTD  POWERNOW        1  =
LTP        1)
[    0.000000] ACPI: MCFG 87EE7200, 003C (r1 RS480  AWRDACPI 42302E31 A=
WRD        0)
[    0.000000] ACPI: APIC 87EE7000, 0068 (r1 RS480  AWRDACPI 42302E31 A=
WRD        0)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 us=
ed
[    0.000000] Entering add_active_range(0, 256, 556768) 1 entries of 2=
56 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   556768
[    0.000000] On node 0 totalpages: 556671
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 862 pages reserved
[    0.000000]   DMA zone: 3081 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7556 pages used for memmap
[    0.000000]   DMA32 zone: 545116 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] ATI board detected. Disabling timer routing over 8254.
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 21 low lev=
el)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] swsusp: Registered nosave memory region: 000000000009f00=
0 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000a000=
0 - 00000000000f0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000f000=
0 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 87f0=
0000:58100000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  =
Total pages: 548197
[    0.000000] Kernel command line: root=3D/dev/sda1 ro quiet apic lapi=
c
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] TSC calibrated against PM_TIMER
[   22.016550] time.c: Detected 2001.135 MHz processor.
[   22.023062] Console: colour VGA+ 80x25
[   22.023065] console [tty0] enabled
[   22.027822] Dentry cache hash table entries: 524288 (order: 10, 4194=
304 bytes)
[   22.034549] Inode-cache hash table entries: 262144 (order: 9, 209715=
2 bytes)
[   22.036706] Checking aperture...
[   22.036711] CPU 0: aperture @ 211a000000 size 32 MB
[   22.036713] Aperture too small (32 MB)
[   22.048152] No AGP bridge found
[   22.079520] Memory: 2186240k/2227072k available (1947k kernel code, =
40168k reserved, 902k data, 164k init)
[   22.139335] Calibrating delay using timer specific routine.. 4004.67=
 BogoMIPS (lpj=3D2002338)
[   22.139391] Mount-cache hash table entries: 256
[   22.139574] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 by=
tes/line)
[   22.139576] CPU: L2 Cache: 512K (64 bytes/line)
[   22.139589] CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 02
[   22.139606] ACPI: Core revision 20070126
[   22.161976] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
[   22.172025] Using local APIC timer interrupts.
[   22.221931] APIC timer calibration result 12507109
[   22.221933] Detected 12.507 MHz APIC timer.
[   22.222068] net_namespace: 120 bytes
[   22.222492] NET: Registered protocol family 16
[   22.222613] ACPI: bus type pci registered
[   22.222678] PCI: Using configuration type 1
[   22.223662] ACPI: EC: Look up EC in DSDT
[   22.227397] ACPI: Interpreter enabled
[   22.227400] ACPI: (supports S0 S3 S4 S5)
[   22.227413] ACPI: Using IOAPIC for interrupt routing
[   22.230850] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   22.232328] PCI: Transparent bridge - 0000:00:14.4
[   22.232361] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   22.232566] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
[   22.232678] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE2._PRT]
[   22.247402] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *=
0, disabled.
[   22.247488] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *=
0, disabled.
[   22.247572] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *=
0, disabled.
[   22.247655] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *=
0, disabled.
[   22.247739] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *=
0, disabled.
[   22.247822] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11)
[   22.247905] ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 *11)
[   22.247994] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 *10 11)
[   22.248087] Linux Plug and Play Support v0.97 (c) Adam Belay
[   22.248112] pnp: PnP ACPI init
[   22.248120] ACPI: bus type pnp registered
[   22.249780] pnp: PnP ACPI: found 10 devices
[   22.249782] ACPI: ACPI bus type pnp unregistered
[   22.249958] SCSI subsystem initialized
[   22.249985] libata version 3.00 loaded.
[   22.250107] PCI: Using ACPI for IRQ routing
[   22.250110] PCI: If a device doesn't work, try "pci=3Drouteirq".  If=
 it helps, post a report
[   22.252918] DMAR:No DMAR devices found
[   22.252997] ACPI: RTC can wake from S4
[   22.253903] Time: tsc clocksource has been installed.
[   22.255927] system 00:01: ioport range 0x140-0x15f has been reserved
[   22.255931] system 00:01: ioport range 0x228-0x22f has been reserved
[   22.255933] system 00:01: ioport range 0x40b-0x40b has been reserved
[   22.255936] system 00:01: ioport range 0x4d6-0x4d6 has been reserved
[   22.255938] system 00:01: ioport range 0xc00-0xc01 has been reserved
[   22.255941] system 00:01: ioport range 0xc14-0xc14 has been reserved
[   22.255944] system 00:01: ioport range 0xc50-0xc52 has been reserved
[   22.255946] system 00:01: ioport range 0xc6c-0xc6d has been reserved
[   22.255956] system 00:08: iomem range 0xe0000000-0xefffffff could no=
t be reserved
[   22.255961] system 00:09: iomem range 0xd1000-0xd3fff has been reser=
ved
[   22.255964] system 00:09: iomem range 0xf0000-0xf7fff could not be r=
eserved
[   22.255966] system 00:09: iomem range 0xf8000-0xfbfff could not be r=
eserved
[   22.255969] system 00:09: iomem range 0xfc000-0xfffff could not be r=
eserved
[   22.256275] PCI: Bridge: 0000:00:02.0
[   22.256277]   IO window: e000-efff
[   22.256280]   MEM window: f4000000-fbffffff
[   22.256282]   PREFETCH window: d8000000-dfffffff
[   22.256286] PCI: Bridge: 0000:00:14.4
[   22.256289]   IO window: d000-dfff
[   22.256295]   MEM window: fdd00000-fddfffff
[   22.256300]   PREFETCH window: fde00000-fdefffff
[   22.256316] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   22.256346] NET: Registered protocol family 2
[   22.264967] IP route cache hash table entries: 131072 (order: 8, 104=
8576 bytes)
[   22.266429] TCP established hash table entries: 262144 (order: 10, 4=
194304 bytes)
[   22.270745] TCP bind hash table entries: 65536 (order: 7, 524288 byt=
es)
[   22.271276] TCP: Hash tables configured (established 262144 bind 655=
36)
[   22.271279] TCP reno registered
[   22.274900] io scheduler noop registered
[   22.274912] io scheduler cfq registered (default)
[   22.274917] PCI: MSI quirk detected. MSI deactivated.
[   85.966285] Switched to high resolution mode on CPU 0
[   90.998353] 0000:00:13.2 EHCI: BIOS handoff failed (BIOS bug ?) 0101=
0001
[   90.998451] Boot video device is 0000:01:00.0
[   90.998598] PCI: Setting latency timer of device 0000:00:02.0 to 64
[   90.998616] assign_interrupt_mode Found MSI capability
[   90.998620] Allocate Port Service[0000:00:02.0:pcie00]
[   90.998813] ACPI: CPU0 (power states: C1[C1] C2[C2])
[   90.999230] ACPI: Thermal Zone [THRM] (38 C)
[   91.001287] Real Time Clock Driver v1.12ac
[   91.001402] Linux agpgart interface v0.102
[   91.001434] console [netcon0] enabled
[   91.001515] netconsole: network logging started
[   91.001641] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, lo=
w) -> IRQ 16
[   91.001789] scsi0 : pata_atiixp
[   91.001846] scsi1 : pata_atiixp
[   91.001956] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf400=
 irq 14
[   91.001958] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf408=
 irq 15
[   91.222810] ata1.00: ATA-6: ST3120026A, 3.06, max UDMA/100
[   91.222812] ata1.00: 234441648 sectors, multi 16: LBA48
[   91.228757] ata1.00: configured for UDMA/100
[   91.391030] scsi 0:0:0:0: Direct-Access     ATA      ST3120026A     =
  3.06 PQ: 0 ANSI: 5
[   91.391119] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (1=
20034 MB)
[   91.391130] sd 0:0:0:0: [sda] Write Protect is off
[   91.391132] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   91.391146] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[   91.391184] sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (1=
20034 MB)
[   91.391192] sd 0:0:0:0: [sda] Write Protect is off
[   91.391194] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   91.391207] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[   91.391210]  sda: sda1 sda2 sda3 sda4
[   91.411713] sd 0:0:0:0: [sda] Attached SCSI disk
[   91.411770] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   91.411851] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   91.411853] PNP: PS/2 appears to have AUX port disabled, if this is =
incorrect please boot with i8042.nopnp
[   91.412157] serio: i8042 KBD port at 0x60,0x64 irq 1
[   91.412226] mice: PS/2 mouse device common for all mice
[   91.412295] rtc_cmos: probe of 00:03 failed with error -16
[   91.412322] device-mapper: uevent: version 1.0.3
[   91.412358] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initiali=
sed: dm-devel@redhat.com
[   91.412425] cpuidle: using governor ladder
[   91.434492] input: AT Translated Set 2 keyboard as /devices/platform=
/i8042/serio0/input/input0
[   92.411693] cpuidle: using governor menu
[   92.411756] TCP cubic registered
[   92.411764] NET: Registered protocol family 1
[   92.411779] NET: Registered protocol family 17
[   92.411785] powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3200+ p=
rocessors (1 cpu cores) (version 2.00.00)
[   92.411821] powernow-k8:    0 : fid 0xc (2000 MHz), vid 0x6
[   92.411823] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x8
[   92.411826] powernow-k8:    2 : fid 0x2 (1000 MHz), vid 0x12
[   92.412636] Marking TSC unstable due to TSC halts in idle
[   92.413615] Time: acpi_pm clocksource has been installed.
[   92.425695] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[   92.442147] kjournald starting.  Commit interval 5 seconds
[   92.442156] EXT3-fs: mounted filesystem with ordered data mode.
[   92.442162] VFS: Mounted root (ext3 filesystem) readonly.
[   92.442179] Freeing unused kernel memory: 164k freed
[   93.579133] Clocksource tsc unstable (delta =3D -78977590 ns)
[   94.307695] nvidia: module license 'NVIDIA' taints kernel.
[   94.346470] sata_sil 0000:00:11.0: version 2.3
[   94.346515] ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 23 (level, lo=
w) -> IRQ 23
[   94.347601] scsi2 : sata_sil
[   94.348188] scsi3 : sata_sil
[   94.348248] ata3: SATA max UDMA/100 mmio m512@0xfe02f000 tf 0xfe02f0=
80 irq 23
[   94.348252] ata4: SATA max UDMA/100 mmio m512@0xfe02f000 tf 0xfe02f0=
c0 irq 23
[   94.357055] usbcore: registered new interface driver usbfs
[   94.357073] usbcore: registered new interface driver hub
[   94.357189] usbcore: registered new device driver usb
[   94.384166] Linux video capture interface: v2.00
[   94.401781] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ=
 sharing enabled
[   94.409058] input: PC Speaker as /devices/platform/pcspkr/input/inpu=
t1
[   94.428032] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller =
(OHCI) Driver
[   94.456907] bttv: driver version 0.9.17 loaded
[   94.456910] bttv: using 8 buffers with 2080k (520 pages) each for ca=
pture
[   94.500004] ata3: SATA link down (SStatus 0 SControl 310)
[   94.651320] ata4: SATA link down (SStatus 0 SControl 310)
[   94.651389] ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, lo=
w) -> IRQ 22
[   94.651508] scsi4 : sata_sil
[   94.651690] scsi5 : sata_sil
[   94.651754] ata5: SATA max UDMA/100 mmio m512@0xfe02e000 tf 0xfe02e0=
80 irq 22
[   94.651757] ata6: SATA max UDMA/100 mmio m512@0xfe02e000 tf 0xfe02e0=
c0 irq 22
[   94.878049] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   94.897699] ata5.00: ATA-7: ST3320620NS, 3.AEG, max UDMA/133
[   94.897702] ata5.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 0=
/32)
[   94.935132] ata5.00: configured for UDMA/100
[   95.161696] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   95.238830] ata6.00: ATAPI: TSSTcorpCD/DVDW SH-S183A, SB02, max UDMA=
/33
[   95.238833] ata6.00: applying bridge limits
[   95.317234] ata6.00: configured for UDMA/33
[   95.322542] scsi 4:0:0:0: Direct-Access     ATA      ST3320620NS    =
  3.AE PQ: 0 ANSI: 5
[   95.322603] sd 4:0:0:0: [sdb] 625142448 512-byte hardware sectors (3=
20073 MB)
[   95.322613] sd 4:0:0:0: [sdb] Write Protect is off
[   95.322615] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   95.322628] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[   95.322661] sd 4:0:0:0: [sdb] 625142448 512-byte hardware sectors (3=
20073 MB)
[   95.322669] sd 4:0:0:0: [sdb] Write Protect is off
[   95.322672] sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   95.322684] sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enab=
led, doesn't support DPO or FUA
[   95.322688]  sdb: unknown partition table
[   95.329315] sd 4:0:0:0: [sdb] Attached SCSI disk
[   95.329343] sd 4:0:0:0: Attached scsi generic sg1 type 0
[   95.329840] scsi 5:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183=
A SB02 PQ: 0 ANSI: 5
[   95.329895] scsi 5:0:0:0: Attached scsi generic sg2 type 5
[   95.330006] piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
[   95.330779] r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
[   95.330799] ACPI: PCI Interrupt 0000:02:0a.0[A] -> GSI 21 (level, lo=
w) -> IRQ 21
[   95.331040] eth0: RTL8169sb/8110sb at 0xffffc20000018000, 00:01:29:d=
6:23:c7, XID 10000000 IRQ 21
[   95.331386] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 19 (level, lo=
w) -> IRQ 19
[   95.331506] ohci_hcd 0000:00:13.0: OHCI Host Controller
[   95.331628] ohci_hcd 0000:00:13.0: new USB bus registered, assigned =
bus number 1
[   95.331645] ohci_hcd 0000:00:13.0: irq 19, io mem 0xfe02d000
[   95.359055] usb usb1: configuration #1 chosen from 1 choice
[   95.359079] hub 1-0:1.0: USB hub found
[   95.359089] hub 1-0:1.0: 4 ports detected
[   95.409453] ACPI: PCI Interrupt 0000:00:13.1[A] -> GSI 19 (level, lo=
w) -> IRQ 19
[   95.409538] ohci_hcd 0000:00:13.1: OHCI Host Controller
[   95.409573] ohci_hcd 0000:00:13.1: new USB bus registered, assigned =
bus number 2
[   95.409587] ohci_hcd 0000:00:13.1: irq 19, io mem 0xfe02c000
[   95.430027] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/fo=
rm2 cdda tray
[   95.430031] Uniform CD-ROM driver Revision: 3.20
[   95.430072] sr 5:0:0:0: Attached scsi CD-ROM sr0
[   95.436952] usb usb2: configuration #1 chosen from 1 choice
[   95.436977] hub 2-0:1.0: USB hub found
[   95.436987] hub 2-0:1.0: 4 ports detected
[   95.487431] ACPI: PCI Interrupt 0000:00:13.2[A] -> GSI 19 (level, lo=
w) -> IRQ 19
[   95.487514] ehci_hcd 0000:00:13.2: EHCI Host Controller
[   95.487550] ehci_hcd 0000:00:13.2: new USB bus registered, assigned =
bus number 3
[   95.487595] ehci_hcd 0000:00:13.2: irq 19, io mem 0xfe02b000
[   95.541225] usb 1-1: new low speed USB device using ohci_hcd and add=
ress 2
[   95.541268] ehci_hcd 0000:00:13.2: USB 2.0 started, EHCI 1.00, drive=
r 10 Dec 2004
[   95.541360] usb usb3: configuration #1 chosen from 1 choice
[   95.541382] hub 3-0:1.0: USB hub found
[   95.541389] hub 3-0:1.0: 8 ports detected
[   95.591795] ACPI: PCI Interrupt 0000:00:14.5[B] -> GSI 17 (level, lo=
w) -> IRQ 17
[   95.598758] ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 18 (level, lo=
w) -> IRQ 18
[   95.598766] PCI: Setting latency timer of device 0000:01:00.0 to 64
[   95.598890] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  100.14.1=
9  Wed Sep 12 14:08:38 PDT 2007
[   95.599943] bttv: Bt8xx card found (0).
[   95.599961] ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 16 (level, lo=
w) -> IRQ 16
[   95.599971] bttv0: Bt878 (rev 17) at 0000:02:05.0, irq: 16, latency:=
 64, mmio: 0xfdeff000
[   95.599979] bttv0: using: Prolink Pixelview PV-BT878P+ (Rev.4C,8E) [=
card=3D70,insmod option]
[   95.600005] bttv0: gpio: en=3D00000000, out=3D00000000 in=3D00ffc0ff=
 [init]
[   95.600804] bttv0: tuner type=3D25
[   95.600807] bttv0: i2c: checking for MSP34xx @ 0x80... not found
[   95.601125] bttv0: i2c: checking for TDA9875 @ 0xb0... not found
[   95.601448] bttv0: i2c: checking for TDA7432 @ 0x8a... not found
[   95.658632] tuner 1-0061: chip found @ 0xc2 (bt878 #0 [sw])
[   95.658654] tuner-simple 1-0061: type set to 25 (LG PAL_I+FM (TAPC-I=
001D))
[   95.658657] tuner 1-0061: type set to LG PAL_I+FM (TAPC-I
[   95.658660] tuner-simple 1-0061: type set to 25 (LG PAL_I+FM (TAPC-I=
001D))
[   95.658662] tuner 1-0061: type set to LG PAL_I+FM (TAPC-I
[   95.669825] bttv0: registered device video0
[   95.669844] bttv0: registered device vbi0
[   95.669864] bttv0: PLL: 28636363 =3D> 35468950 .. ok
[   95.680955] input: bttv IR (card=3D70) as /devices/pci0000:00/0000:0=
0:14.4/0000:02:05.0/input/input2
[   95.684130] ACPI: PCI Interrupt 0000:02:06.0[A] -> GSI 17 (level, lo=
w) -> IRQ 17
[   95.684152] parport0: PC-style at 0xdd00 [PCSPP,TRISTATE,EPP]
[   95.725132] 0000:02:06.0: ttyS0 at I/O 0xdf00 (irq =3D 17) is a 1655=
0A
[   95.725226] 0000:02:06.0: ttyS1 at I/O 0xde00 (irq =3D 17) is a 1655=
0A
[   95.958208] usb 3-2: new high speed USB device using ehci_hcd and ad=
dress 3
[   96.015426] usb 3-2: configuration #1 chosen from 1 choice
[   96.015539] hub 3-2:1.0: USB hub found
[   96.015718] hub 3-2:1.0: 4 ports detected
[   96.180635] Adding 2000084k swap on /dev/sda3.  Priority:-1 extents:=
1 across:2000084k
[   96.277811] usb 3-6: new high speed USB device using ehci_hcd and ad=
dress 5
[   96.335946] usb 3-6: configuration #1 chosen from 1 choice
[   96.356209] EXT3 FS on sda1, internal journal
[   96.374927] Initializing USB Mass Storage driver...
[   96.466600] usb 2-2: new full speed USB device using ohci_hcd and ad=
dress 2
[   96.583977] usb 2-2: configuration #1 chosen from 1 choice
[   96.591520] scsi6 : SCSI emulation for USB Mass Storage devices
[   96.591592] usbcore: registered new interface driver usb-storage
[   96.591595] USB Mass Storage support registered.
[   96.591614] usb-storage: device found at 5
[   96.591615] usb-storage: waiting for device to settle before scannin=
g
[   96.637966] Bluetooth: Core ver 2.11
[   96.638013] NET: Registered protocol family 31
[   96.638015] Bluetooth: HCI device and connection manager initialized
[   96.638018] Bluetooth: HCI socket layer initialized
[   96.650447] Bluetooth: HCI USB driver ver 2.9
[   96.716772] usb 1-1: new low speed USB device using ohci_hcd and add=
ress 3
[   96.810527] usb 1-1: configuration #1 chosen from 1 choice
[   96.904602] usb 3-2.3: new full speed USB device using ehci_hcd and =
address 6
[   96.950179] usb 3-2.3: configuration #1 chosen from 2 choices
[   96.951538] usbcore: registered new interface driver hci_usb
[   96.952486] usbcore: registered new interface driver hiddev
[   96.955493] input: CHESEN PS2 to USB Converter as /devices/pci0000:0=
0/0000:00:13.0/usb1/1-1/1-1:1.0/input/input3
[   96.961784] input,hidraw0: USB HID v1.10 Keyboard [CHESEN PS2 to USB=
 Converter] on usb-0000:00:13.0-1
[   96.968562] input: CHESEN PS2 to USB Converter as /devices/pci0000:0=
0/0000:00:13.0/usb1/1-1/1-1:1.1/input/input4
[   96.974415] input,hidraw1: USB HID v1.10 Mouse [CHESEN PS2 to USB Co=
nverter] on usb-0000:00:13.0-1
[   96.974431] usbcore: registered new interface driver usbhid
[   96.974434] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   97.077645] usb0: register 'cdc_ether' at usb-0000:00:13.2-2.3, CDC =
Ethernet Device, 56:f8:5d:88:a8:65
[   97.077660] usbcore: registered new interface driver cdc_ether
[   97.204977] kjournald starting.  Commit interval 5 seconds
[   97.204983] EXT3-fs warning: maximal mount count reached, running e2=
fsck is recommended
[   97.208726] EXT3 FS on dm-0, internal journal
[   97.208730] EXT3-fs: mounted filesystem with journal data mode.
[   97.892826] r8169: eth0: link up
[   97.939941] r8169: eth0: link up
[   98.171981] ip_tables: (C) 2000-2006 Netfilter Core Team
[   98.179596] nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
[   98.539078] NET: Registered protocol family 10
[   98.539350] lo: Disabled Privacy Extensions
[   98.932847] RPC: Registered udp transport module.
[   98.932850] RPC: Registered tcp transport module.
[   99.088468] usb-storage: device scan complete
[   99.088895] scsi 6:0:0:0: Direct-Access     Generic  USB SD Reader  =
  1.00 PQ: 0 ANSI: 0
[   99.089269] scsi 6:0:0:1: Direct-Access     Generic  USB CF Reader  =
  1.01 PQ: 0 ANSI: 0
[   99.089651] scsi 6:0:0:2: Direct-Access     Generic  USB SM Reader  =
  1.02 PQ: 0 ANSI: 0
[   99.089972] scsi 6:0:0:3: Direct-Access     Generic  USB MS Reader  =
  1.03 PQ: 0 ANSI: 0
[   99.090679] sd 6:0:0:0: [sdc] Attached SCSI removable disk
[   99.090713] sd 6:0:0:0: Attached scsi generic sg3 type 0
[   99.091239] sd 6:0:0:1: [sdd] Attached SCSI removable disk
[   99.091269] sd 6:0:0:1: Attached scsi generic sg4 type 0
[   99.091800] sd 6:0:0:2: [sde] Attached SCSI removable disk
[   99.091831] sd 6:0:0:2: Attached scsi generic sg5 type 0
[   99.092371] sd 6:0:0:3: [sdf] Attached SCSI removable disk
[   99.092398] sd 6:0:0:3: Attached scsi generic sg6 type 0
[  101.565518] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  102.094392] tun: Universal TUN/TAP device driver, 1.6
[  102.094396] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  102.095854] tun0: Disabled Privacy Extensions
[  103.272406] Bluetooth: L2CAP ver 2.9
[  103.272409] Bluetooth: L2CAP socket layer initialized
[  103.289892] Bluetooth: RFCOMM socket layer initialized
[  103.289989] Bluetooth: RFCOMM TTY layer initialized
[  103.289992] Bluetooth: RFCOMM ver 1.8
[  103.654834] eth0: no IPv6 routers present
[  104.015912] usb0: no IPv6 routers present


--=20
JID: hrw-jabber.org
OpenEmbedded developer/consultant

    42? 7 and a half million years and all you can come up with is 42?!


