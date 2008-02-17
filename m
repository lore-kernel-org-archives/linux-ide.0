From: "Paul Fleischer" <paul@xpg.dk>
Subject: DMA being disabled during heavy HD activity
Date: Sun, 17 Feb 2008 12:23:18 +0100
Message-ID: <ab2fc2a60802170323o341fe1d8lfb91de8339f11e6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:12133 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbYBQLXW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Feb 2008 06:23:22 -0500
Received: by an-out-0708.google.com with SMTP id d31so294348and.103
        for <linux-ide@vger.kernel.org>; Sun, 17 Feb 2008 03:23:18 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I am experiencing some strange behaviour. When I have heavy HDD
activity (running MythTV, for instance), I get 17 of these:

[   90.004956] hda: dma_intr: bad DMA status (dma_stat=76)
[   90.004963] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   90.004966] ide: failed opcode was: unknown

Followed by the IDE subsystem giving up on DMA:

[   97.732622] hda: DMA disabled
[   97.732629] hdb: DMA disabled
[   97.809464] ide0: reset: success

I'm running with an Asus M2A-VM mainboard with an ATI SB600 chipset.
The harddrive is an plain old PATA drive, attached as master with a
cdrom drive as slave.

I'm running the Ubuntu Hardy development kernel, 2.6.24-9, although
same problem occurs with 2.6.22-14 (again Ubuntu kernel).
I have looked in the linux-ide mlist archives but haven't been able to
find anything related.

Thank you for your time,

Paul

Output from hdparm -I /dev/hda (after DMA has been disabled):
/dev/hda:

ATA device, with non-removable media
        Model Number:       Maxtor 6Y080P0
        Serial Number:      Y33ZYEKE
        Firmware Revision:  YAR41BW0
Standards:
        Used: ATA/ATAPI-7 T13 1532D revision 0
        Supported: 7 6 5 4
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  160086528
        device size with M = 1024*1024:       78167 MBytes
        device size with M = 1000*1000:       81964 MBytes (81 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 0
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
                SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_VERIFY command
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    NOP cmd
           *    DOWNLOAD_MICROCODE
                Advanced Power Management feature set
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

Output from hdparm /dev/hda after DMA has been disabled:
/dev/hda:
 multcount     =  0 (off)
 IO_support    =  0 (default 16-bit)
 unmaskirq     =  0 (off)
 using_dma     =  0 (off)
 keepsettings  =  0 (off)
 readonly      =  0 (off)
 readahead     = 256 (on)
 geometry      = 65535/16/63, sectors = 160086528, start = 0

Output from lspci -v:
00:00.0 Host bridge: ATI Technologies Inc RS690 Host Bridge
        Subsystem: ASUSTeK Computer Inc. Unknown device 826d
        Flags: bus master, 66MHz, medium devsel, latency 64

00:01.0 PCI bridge: ATI Technologies Inc RS690 PCI to PCI Bridge
(Internal gfx) (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fde00000-fdffffff
        Prefetchable memory behind bridge: 00000000f0000000-00000000f7ffffff
        Capabilities: [44] HyperTransport: MSI Mapping
        Capabilities: [b0] Subsystem: ATI Technologies Inc RS690 PCI
to PCI Bridge (Internal gfx)

00:07.0 PCI bridge: ATI Technologies Inc RS690 PCI to PCI Bridge (PCI
Express Port 3) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fdb00000-fdbfffff
        Prefetchable memory behind bridge: 00000000fda00000-00000000fdafffff
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Root Port (Slot-) IRQ 0
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit-
Queue=0/0 Enable+
        Capabilities: [b0] Subsystem: ASUSTeK Computer Inc. Unknown device 826d
        Capabilities: [b8] HyperTransport: MSI Mapping

00:13.0 USB Controller: ATI Technologies Inc SB600 USB (OHCI0)
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 17
        Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]

00:13.1 USB Controller: ATI Technologies Inc SB600 USB (OHCI1)
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
        Memory at fe02e000 (32-bit, non-prefetchable) [size=4K]

00:13.2 USB Controller: ATI Technologies Inc SB600 USB (OHCI2)
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 19
        Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]

00:13.3 USB Controller: ATI Technologies Inc SB600 USB (OHCI3)
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 18
        Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]

00:13.4 USB Controller: ATI Technologies Inc SB600 USB (OHCI4)
(prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 19
        Memory at fe02b000 (32-bit, non-prefetchable) [size=4K]

00:13.5 USB Controller: ATI Technologies Inc SB600 USB Controller
(EHCI) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
        Memory at fe02a000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [c0] Power Management version 2
        Capabilities: [e4] Debug port

00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 14)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Flags: bus master, VGA palette snoop, stepping, fast
Back2Back, 66MHz, user-definable features, ?? devsel, latency 0
        I/O ports at 0b00 [size=16]
        Capabilities: [b0] HyperTransport: MSI Mapping

00:14.1 IDE interface: ATI Technologies Inc SB600 IDE (prog-if 8a
[Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 17
        I/O ports at 01f0 [size=8]
        I/O ports at 03f4 [size=1]
        I/O ports at 0170 [size=8]
        I/O ports at 0374 [size=1]
        I/O ports at f800 [size=16]

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia
        Subsystem: ASUSTeK Computer Inc. Unknown device 8249
        Flags: bus master, slow devsel, latency 64, IRQ 17
        Memory at fe024000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2

00:14.3 ISA bridge: ATI Technologies Inc SB600 PCI to LPC Bridge
        Subsystem: ASUSTeK Computer Inc. Unknown device 81ef
        Flags: bus master, 66MHz, medium devsel, latency 0

00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge
(prog-if 01 [Subtractive decode])
        Flags: bus master, VGA palette snoop, 66MHz, medium devsel, latency 64
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fdd00000-fddfffff
        Prefetchable memory behind bridge: fdc00000-fdcfffff

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] HyperTransport Technology Configuration
        Flags: fast devsel
        Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Address Map
        Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] DRAM Controller
        Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8
[Athlon64/Opteron] Miscellaneous Control
        Flags: fast devsel
        Capabilities: [f0] #0f [0010]

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon X1200
Series (prog-if 00 [VGA])
        Subsystem: ASUSTeK Computer Inc. Unknown device 826d
        Flags: bus master, fast devsel, latency 64, IRQ 19
        Memory at f0000000 (64-bit, prefetchable) [size=128M]
        Memory at fdff0000 (64-bit, non-prefetchable) [size=64K]
        I/O ports at ec00 [size=256]
        Memory at fde00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [50] Power Management version 2
        Capabilities: [80] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81aa
        Flags: bus master, fast devsel, latency 0, IRQ 222
        I/O ports at dc00 [size=256]
        Memory at fdbff000 (64-bit, non-prefetchable) [size=4K]
        [virtual] Expansion ROM at fda00000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
        Capabilities: [48] Vital Product Data
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Queue=0/1 Enable+
        Capabilities: [60] Express Endpoint IRQ 0
        Capabilities: [84] Vendor Specific Information

03:05.0 Multimedia controller: Philips Semiconductors
SAA7134/SAA7135HL Video Broadcast Decoder (rev 01)
        Subsystem: Avermedia Technologies Inc AverMedia M156 / Medion 2819
        Flags: bus master, medium devsel, latency 64, IRQ 21
        Memory at fddff000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [40] Power Management version 1

03:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host
Controller (rev c0) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc. Unknown device 81fe
        Flags: bus master, medium devsel, latency 64, IRQ 20
        Memory at fddfe000 (32-bit, non-prefetchable) [size=2K]
        I/O ports at cc00 [size=128]
        Capabilities: [50] Power Management version 2

Full dmesg output:
[    0.000000] Linux version 2.6.24-9-generic (root@paul-desktop) (gcc
version 4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP
Sat Feb 16 10:28:55 CET 2008 (Ubuntu 2.6.24-9.15-generic)
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
[    0.000000]  BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 0000000077ee0000 (usable)
[    0.000000]  BIOS-e820: 0000000077ee0000 - 0000000077ee3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 0000000077ee3000 - 0000000077ef0000 (ACPI data)
[    0.000000]  BIOS-e820: 0000000077ef0000 - 0000000077f00000 (reserved)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] 1022MB HIGHMEM available.
[    0.000000] 896MB LOWMEM available.
[    0.000000] found SMP MP-table at 000f6600
[    0.000000] Entering add_active_range(0, 0, 491232) 0 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   Normal       4096 ->   229376
[    0.000000]   HighMem    229376 ->   491232
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->   491232
[    0.000000] On node 0 totalpages: 491232
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 4064 pages, LIFO batch:0
[    0.000000]   Normal zone: 1760 pages used for memmap
[    0.000000]   Normal zone: 223520 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2045 pages used for memmap
[    0.000000]   HighMem zone: 259811 pages, LIFO batch:31
[    0.000000]   Movable zone: 0 pages used for memmap
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP signature @ 0xC00F82B0 checksum 0
[    0.000000] ACPI: RSDP 000F82B0, 0024 (r2 ATI   )
[    0.000000] ACPI: XSDT 77EE3100, 0044 (r1 ATI    ASUSACPI 42302E31
AWRD        0)
[    0.000000] ACPI: FACP 77EE8500, 00F4 (r3 ATI    ASUSACPI 42302E31
AWRD        0)
[    0.000000] ACPI: DSDT 77EE3280, 5213 (r1 ATI    ASUSACPI     1000
MSFT  3000000)
[    0.000000] ACPI: FACS 77EE0000, 0040
[    0.000000] ACPI: SSDT 77EE8740, 0206 (r1 PTLTD  POWERNOW        1
LTP        1)
[    0.000000] ACPI: MCFG 77EE8A40, 003C (r1 ATI    ASUSACPI 42302E31
AWRD        0)
[    0.000000] ACPI: APIC 77EE8640, 0084 (r1 ATI    ASUSACPI 42302E31
AWRD        0)
[    0.000000] ATI board detected. Disabling timer routing over 8254.
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:11 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1 15:11 APIC version 16
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 4, version 33, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 78000000 (gap:
77f00000:68100000)
[    0.000000] swsusp: Registered nosave memory region:
000000000009f000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region:
00000000000a0000 - 00000000000f0000
[    0.000000] swsusp: Registered nosave memory region:
00000000000f0000 - 0000000000100000
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 487395
[    0.000000] Kernel command line:
root=UUID=ec3acfb8-70b8-4401-8585-b42d8094eff2 ro quiet splash vga=773
[    0.000000] mapped APIC to ffffb000 (fee00000)
[    0.000000] mapped IOAPIC to ffffa000 (fec00000)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
[    0.000000] Detected 2200.036 MHz processor.
[   16.030637] Console: colour dummy device 80x25
[   16.030640] console [tty0] enabled
[   16.030940] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[   16.031256] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[   16.099176] Memory: 1936320k/1964928k available (2161k kernel code,
27340k reserved, 998k data, 364k init, 1047424k highmem)
[   16.099183] virtual kernel memory layout:
[   16.099184]     fixmap  : 0xfff4b000 - 0xfffff000   ( 720 kB)
[   16.099185]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[   16.099186]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
[   16.099187]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
[   16.099188]       .init : 0xc041b000 - 0xc0476000   ( 364 kB)
[   16.099189]       .data : 0xc031c4d8 - 0xc0415dc4   ( 998 kB)
[   16.099190]       .text : 0xc0100000 - 0xc031c4d8   (2161 kB)
[   16.099192] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[   16.099222] SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4,
CPUs=2, Nodes=1
[   16.179165] Calibrating delay using timer specific routine..
4403.47 BogoMIPS (lpj=8806957)
[   16.179188] Security Framework initialized
[   16.179193] SELinux:  Disabled at boot.
[   16.179206] AppArmor: AppArmor initialized
[   16.179209] Failure registering capabilities with primary security module.
[   16.179216] Mount-cache hash table entries: 512
[   16.179316] CPU: After generic identify, caps: 178bfbff ebd3fbff
00000000 00000000 00002001 00000000 0000011f 00000000
[   16.179324] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   16.179326] CPU: L2 Cache: 512K (64 bytes/line)
[   16.179328] CPU 0(2) -> Core 0
[   16.179330] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000
00000410 00002001 00000000 0000011f 00000000
[   16.179338] Compat vDSO mapped to ffffe000.
[   16.179347] Checking 'hlt' instruction... OK.
[   16.195385] SMP alternatives: switching to UP code
[   16.196398] Early unpacking initramfs... done
[   16.461129] ACPI: Core revision 20070126
[   16.461187] ACPI: Looking for DSDT in initramfs... error, file
/DSDT.aml not found.
[   16.477263] CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 02
[   16.477280] SMP alternatives: switching to SMP code
[   16.477638] Booting processor 1/1 eip 3000
[   16.488123] Initializing CPU#1
[   16.567289] Calibrating delay using timer specific routine..
4400.18 BogoMIPS (lpj=8800367)
[   16.567295] CPU: After generic identify, caps: 178bfbff ebd3fbff
00000000 00000000 00002001 00000000 0000011f 00000000
[   16.567301] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   16.567303] CPU: L2 Cache: 512K (64 bytes/line)
[   16.567305] CPU 1(2) -> Core 1
[   16.567306] CPU: After all inits, caps: 178bfbff ebd3fbff 00000000
00000410 00002001 00000000 0000011f 00000000
[   16.566937] CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 02
[   16.566950] Total of 2 processors activated (8803.66 BogoMIPS).
[   16.567235] ENABLING IO-APIC IRQs
[   16.567453] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
[   16.714748] Brought up 2 CPUs
[   16.714797] CPU0 attaching sched-domain:
[   16.714799]  domain 0: span 03
[   16.714800]   groups: 01 02
[   16.714803] CPU1 attaching sched-domain:
[   16.714804]  domain 0: span 03
[   16.714805]   groups: 02 01
[   16.714970] net_namespace: 64 bytes
[   16.714976] Booting paravirtualized kernel on bare hardware
[   16.715381] Time: 11:01:25  Date: 02/17/08
[   16.715421] NET: Registered protocol family 16
[   16.715565] EISA bus registered
[   16.715568] ACPI: bus type pci registered
[   16.748516] PCI: PCI BIOS revision 3.00 entry at 0xf1e40, last bus=3
[   16.748518] PCI: Using configuration type 1
[   16.748520] Setting up standard PCI resources
[   16.751428] ACPI: EC: Look up EC in DSDT
[   16.755402] ACPI: Interpreter enabled
[   16.755404] ACPI: (supports S0 S1 S3 S4 S5)
[   16.755417] ACPI: Using IOAPIC for interrupt routing
[   16.759194] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   16.760989] PCI: Transparent bridge - 0000:00:14.4
[   16.761013] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   16.761166] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
[   16.761268] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
[   16.761328] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
[   16.780751] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
[   16.780834] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
[   16.780917] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
[   16.780997] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
[   16.781078] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
[   16.781158] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
[   16.781240] ACPI: PCI Interrupt Link [LNK0] (IRQs *3 4 5 6 7 10 11)
[   16.781320] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11)
*0, disabled.
[   16.781417] Linux Plug and Play Support v0.97 (c) Adam Belay
[   16.781439] pnp: PnP ACPI init
[   16.781445] ACPI: bus type pnp registered
[   16.783530] pnpacpi: exceeded the max number of mem resources: 12
[   16.783573] pnp: PnP ACPI: found 11 devices
[   16.783574] ACPI: ACPI bus type pnp unregistered
[   16.783577] PnPBIOS: Disabled by ACPI PNP
[   16.783736] PCI: Using ACPI for IRQ routing
[   16.783739] PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
[   16.862528] NET: Registered protocol family 8
[   16.862530] NET: Registered protocol family 20
[   16.862583] AppArmor: AppArmor Filesystem Enabled
[   16.874538] system 00:01: ioport range 0x4100-0x411f has been reserved
[   16.874540] system 00:01: ioport range 0x228-0x22f has been reserved
[   16.874542] system 00:01: ioport range 0x40b-0x40b has been reserved
[   16.874544] system 00:01: ioport range 0x4d6-0x4d6 has been reserved
[   16.874547] system 00:01: ioport range 0xc00-0xc01 has been reserved
[   16.874549] system 00:01: ioport range 0xc14-0xc14 has been reserved
[   16.874551] system 00:01: ioport range 0xc50-0xc52 has been reserved
[   16.874553] system 00:01: ioport range 0xc6c-0xc6d has been reserved
[   16.874555] system 00:01: ioport range 0xc6f-0xc6f has been reserved
[   16.874558] system 00:01: ioport range 0xcd0-0xcd1 has been reserved
[   16.874560] system 00:01: ioport range 0xcd2-0xcd3 has been reserved
[   16.874562] system 00:01: ioport range 0xcd4-0xcdf has been reserved
[   16.874564] system 00:01: ioport range 0x4000-0x40fe has been reserved
[   16.874569] system 00:01: ioport range 0x4210-0x4217 has been reserved
[   16.874571] system 00:01: ioport range 0xb00-0xb0f has been reserved
[   16.874573] system 00:01: ioport range 0xb10-0xb1f has been reserved
[   16.874579] system 00:06: ioport range 0x4d0-0x4d1 has been reserved
[   16.874581] system 00:06: ioport range 0x220-0x225 has been reserved
[   16.874588] system 00:09: iomem range 0xe0000000-0xefffffff could
not be reserved
[   16.874593] system 00:0a: iomem range 0xcd600-0xcffff has been reserved
[   16.874595] system 00:0a: iomem range 0xf0000-0xf7fff could not be reserved
[   16.874597] system 00:0a: iomem range 0xf8000-0xfbfff could not be reserved
[   16.874600] system 00:0a: iomem range 0xfc000-0xfffff could not be reserved
[   16.874602] system 00:0a: iomem range 0x77ef0000-0x77feffff could
not be reserved
[   16.874605] system 00:0a: iomem range 0xfed00000-0xfed000ff could
not be reserved
[   16.874608] system 00:0a: iomem range 0x77ee0000-0x77efffff could
not be reserved
[   16.874610] system 00:0a: iomem range 0xffff0000-0xffffffff could
not be reserved
[   16.874612] system 00:0a: iomem range 0x0-0x9ffff could not be reserved
[   16.874615] system 00:0a: iomem range 0x100000-0x77edffff could not
be reserved
[   16.874617] system 00:0a: iomem range 0x77ff0000-0x7ffeffff has been reserved
[   16.874620] system 00:0a: iomem range 0xfec00000-0xfec00fff could
not be reserved
[   16.904900] PCI: Bridge: 0000:00:01.0
[   16.904902]   IO window: e000-efff
[   16.904905]   MEM window: fde00000-fdffffff
[   16.904908]   PREFETCH window: f0000000-f7ffffff
[   16.904912] PCI: Bridge: 0000:00:07.0
[   16.904914]   IO window: d000-dfff
[   16.904916]   MEM window: fdb00000-fdbfffff
[   16.904918]   PREFETCH window: fda00000-fdafffff
[   16.904921] PCI: Bridge: 0000:00:14.4
[   16.904924]   IO window: c000-cfff
[   16.904929]   MEM window: fdd00000-fddfffff
[   16.904933]   PREFETCH window: fdc00000-fdcfffff
[   16.904952] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   16.904967] NET: Registered protocol family 2
[   16.906480] Time: acpi_pm clocksource has been installed.
[   16.906495] Switched to high resolution mode on CPU 0
[   16.907075] Switched to high resolution mode on CPU 1
[   16.942471] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
[   16.942711] TCP established hash table entries: 131072 (order: 8,
1048576 bytes)
[   16.943329] TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
[   16.943609] TCP: Hash tables configured (established 131072 bind 65536)
[   16.943611] TCP reno registered
[   16.954519] checking if image is initramfs... it is
[   17.469256] Freeing initrd memory: 7027k freed
[   17.470468] audit: initializing netlink socket (disabled)
[   17.470481] audit(1203246085.256:1): initialized
[   17.470643] highmem bounce pool size: 64 pages
[   17.472237] VFS: Disk quotas dquot_6.5.1
[   17.472298] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   17.472398] io scheduler noop registered
[   17.472400] io scheduler anticipatory registered
[   17.472401] io scheduler deadline registered
[   17.472410] io scheduler cfq registered (default)
[   17.730145] Boot video device is 0000:01:05.0
[   17.730246] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   17.730264] assign_interrupt_mode Found MSI capability
[   17.730282] Allocate Port Service[0000:00:07.0:pcie00]
[   17.730472] isapnp: Scanning for PnP cards...
[   18.084019] isapnp: No Plug & Play device found
[   18.108710] Real Time Clock Driver v1.12ac
[   18.108798] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
IRQ sharing enabled
[   18.108927] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   18.109458] 00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   18.110138] RAMDISK driver initialized: 16 RAM disks of 65536K size
1024 blocksize
[   18.110193] input: Macintosh mouse button emulation as
/devices/virtual/input/input0
[   18.110315] PNP: No PS/2 controller found. Probing ports directly.
[   18.110645] serio: i8042 KBD port at 0x60,0x64 irq 1
[   18.110650] serio: i8042 AUX port at 0x60,0x64 irq 12
[   18.130747] mice: PS/2 mouse device common for all mice
[   18.130851] EISA: Probing bus 0 at eisa.0
[   18.130869] Cannot allocate resource for EISA slot 4
[   18.130885] EISA: Detected 0 cards.
[   18.130888] cpuidle: using governor ladder
[   18.130890] cpuidle: using governor menu
[   18.130956] NET: Registered protocol family 1
[   18.130975] Using IPI No-Shortcut mode
[   18.131002] registered taskstats version 1
[   18.131088]   Magic number: 12:378:24
[   18.131419] Freeing unused kernel memory: 364k freed
[   19.375397] fuse init (API version 7.9)
[   19.380033] ACPI: Fan [FAN] (on)
[   19.384783] ACPI Exception (processor_core-0816): AE_NOT_FOUND,
Processor Device is not present [20070126]
[   19.384794] ACPI Exception (processor_core-0816): AE_NOT_FOUND,
Processor Device is not present [20070126]
[   19.385791] ACPI: Expecting a [Reference] package element, found
type DFA0C2E0
[   19.385795] ACPI: Invalid passive threshold
[   19.386006] ACPI: Thermal Zone [THRM] (40 C)
[   19.720905] r8169 Gigabit Ethernet driver 2.2LK loaded
[   19.720935] ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level,
low) -> IRQ 16
[   19.720954] PCI: Setting latency timer of device 0000:02:00.0 to 64
[   19.721211] eth0: RTL8168b/8111b at 0xf8842000, 00:1e:8c:12:05:72,
XID 38000000 IRQ 222
[   19.760503] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   19.760508] ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
[   19.763365] SB600_PATA: IDE controller (0x1002:0x438c rev 0x00) at
PCI slot 0000:00:14.1
[   19.763383] ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level,
low) -> IRQ 17
[   19.763392] SB600_PATA: not 100% native mode: will probe irqs later
[   19.763400]     ide0: BM-DMA at 0xf800-0xf807, BIOS settings:
hda:pio, hdb:pio
[   19.763409] Probing IDE interface ide0...
[   19.780028] usbcore: registered new interface driver usbfs
[   19.780047] usbcore: registered new interface driver hub
[   19.780117] usbcore: registered new device driver usb
[   19.782342] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller
(OHCI) Driver
[   20.219281] hdb: PLEXTOR CD-R PX-W8432T, ATAPI CD/DVD-ROM drive
[   20.554923] hda: Maxtor 6Y080P0, ATA DISK drive
[   20.554935] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   20.555065] hda: UDMA/100 mode selected
[   20.555195] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[   20.555277] hdb: MWDMA2 mode selected
[   20.555422] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   20.566452] ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level,
low) -> IRQ 17
[   20.566466] ohci_hcd 0000:00:13.0: OHCI Host Controller
[   20.566709] ohci_hcd 0000:00:13.0: new USB bus registered, assigned
bus number 1
[   20.566728] ohci_hcd 0000:00:13.0: irq 17, io mem 0xfe02f000
[   20.626595] usb usb1: configuration #1 chosen from 1 choice
[   20.626614] hub 1-0:1.0: USB hub found
[   20.626622] hub 1-0:1.0: 2 ports detected
[   20.730466] ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level,
low) -> IRQ 18
[   20.730477] ohci_hcd 0000:00:13.1: OHCI Host Controller
[   20.730498] ohci_hcd 0000:00:13.1: new USB bus registered, assigned
bus number 2
[   20.730514] ohci_hcd 0000:00:13.1: irq 18, io mem 0xfe02e000
[   20.790408] usb usb2: configuration #1 chosen from 1 choice
[   20.790425] hub 2-0:1.0: USB hub found
[   20.790432] hub 2-0:1.0: 2 ports detected
[   20.894285] ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level,
low) -> IRQ 19
[   20.894295] ohci_hcd 0000:00:13.2: OHCI Host Controller
[   20.894313] ohci_hcd 0000:00:13.2: new USB bus registered, assigned
bus number 3
[   20.894329] ohci_hcd 0000:00:13.2: irq 19, io mem 0xfe02d000
[   20.954226] usb usb3: configuration #1 chosen from 1 choice
[   20.954242] hub 3-0:1.0: USB hub found
[   20.954248] hub 3-0:1.0: 2 ports detected
[   21.058102] ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level,
low) -> IRQ 18
[   21.058111] ohci_hcd 0000:00:13.3: OHCI Host Controller
[   21.058126] ohci_hcd 0000:00:13.3: new USB bus registered, assigned
bus number 4
[   21.058136] ohci_hcd 0000:00:13.3: irq 18, io mem 0xfe02c000
[   21.118048] usb usb4: configuration #1 chosen from 1 choice
[   21.118065] hub 4-0:1.0: USB hub found
[   21.118072] hub 4-0:1.0: 2 ports detected
[   21.221927] ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level,
low) -> IRQ 19
[   21.221937] ohci_hcd 0000:00:13.4: OHCI Host Controller
[   21.221955] ohci_hcd 0000:00:13.4: new USB bus registered, assigned
bus number 5
[   21.221967] ohci_hcd 0000:00:13.4: irq 19, io mem 0xfe02b000
[   21.281876] usb usb5: configuration #1 chosen from 1 choice
[   21.281894] hub 5-0:1.0: USB hub found
[   21.281901] hub 5-0:1.0: 2 ports detected
[   21.385877] ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level,
low) -> IRQ 16
[   21.385888] ehci_hcd 0000:00:13.5: EHCI Host Controller
[   21.385907] ehci_hcd 0000:00:13.5: new USB bus registered, assigned
bus number 6
[   21.385942] ehci_hcd 0000:00:13.5: debug port 1
[   21.385958] ehci_hcd 0000:00:13.5: irq 16, io mem 0xfe02a000
[   21.397693] ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00,
driver 10 Dec 2004
[   21.397799] usb usb6: configuration #1 chosen from 1 choice
[   21.397820] hub 6-0:1.0: USB hub found
[   21.397825] hub 6-0:1.0: 10 ports detected
[   21.501944] ACPI: PCI Interrupt 0000:03:07.0[A] -> GSI 22 (level,
low) -> IRQ 20
[   21.554651] ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[20]
MMIO=[fddfe000-fddfe7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
[   21.560360] SCSI subsystem initialized
[   21.566135] libata version 3.00 loaded.
[   21.583577] hdb: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache
[   21.583583] Uniform CD-ROM driver Revision: 3.20
[   21.587758] hda: max request size: 128KiB
[   21.587990] hda: 160086528 sectors (81964 MB) w/7936KiB Cache,
CHS=65535/16/63
[   21.588137] hda: cache flushes supported
[   21.588164]  hda: hda1 hda2 < hda5 >
[   21.796658] Attempting manual resume
[   21.796662] swsusp: Resume From Partition 3:5
[   21.796664] PM: Checking swsusp image.
[   21.796902] PM: Resume from disk failed.
[   21.834958] kjournald starting.  Commit interval 5 seconds
[   21.834967] EXT3-fs: mounted filesystem with ordered data mode.
[   22.836815] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d80001843b8c]
[   27.413637] input: PC Speaker as /devices/platform/pcspkr/input/input1
[   27.538841] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   27.604820] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   27.701841] Linux agpgart interface v0.102
[   27.741702] parport_pc 00:08: reported by Plug and Play ACPI
[   27.741735] parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
[   27.812693] input: Power Button (FF) as /devices/virtual/input/input2
[   27.862897] ACPI: Power Button (FF) [PWRF]
[   27.862960] input: Power Button (CM) as /devices/virtual/input/input3
[   27.893068] piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
[   27.926787] ACPI: Power Button (CM) [PWRB]
[   27.968639] Linux video capture interface: v2.00
[   28.295017] saa7130/34: v4l2 driver version 0.2.14 loaded
[   28.295086] ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 20 (level,
low) -> IRQ 21
[   28.295094] saa7134[0]: found at 0000:03:05.0, rev: 1, irq: 21,
latency: 64, mmio: 0xfddff000
[   28.295101] saa7134[0]: subsystem: 1461:a70b, board: AverMedia M156
/ Medion 2819 [card=22,autodetected]
[   28.295111] saa7134[0]: board init: gpio is 588
[   28.295168] input: saa7134 IR (AverMedia M156 / Me as
/devices/pci0000:00/0000:00:14.4/0000:03:05.0/input/input4
[   28.479700] saa7134[0]: i2c eeprom 00: 61 14 0b a7 ff ff ff ff ff
ff ff ff ff ff ff ff
[   28.479708] saa7134[0]: i2c eeprom 10: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   28.479715] saa7134[0]: i2c eeprom 20: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   28.479721] saa7134[0]: i2c eeprom 30: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   28.479727] saa7134[0]: i2c eeprom 40: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   28.479733] saa7134[0]: i2c eeprom 50: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   28.479739] saa7134[0]: i2c eeprom 60: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   28.479745] saa7134[0]: i2c eeprom 70: ff ff ff ff ff ff ff ff ff
ff ff ff ff ff ff ff
[   28.719446] tuner 1-0043: chip found @ 0x86 (saa7134[0])
[   28.719475] tda9887 1-0043: tda988[5/6/7] found @ 0x43 (tuner)
[   28.719478] tuner 1-0043: type set to tda9887
[   28.727448] tuner 1-0061: chip found @ 0xc2 (saa7134[0])
[   28.727463] tuner-simple 1-0061: type set to 38 (Philips PAL/SECAM
multi (FM1216ME MK3))
[   28.727465] tuner 1-0061: type set to Philips PAL/SECAM m
[   28.727467] tuner-simple 1-0061: type set to 38 (Philips PAL/SECAM
multi (FM1216ME MK3))
[   28.727470] tuner 1-0061: type set to Philips PAL/SECAM m
[   28.734986] ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level,
low) -> IRQ 17
[   28.735645] saa7134[0]: registered device video0 [v4l2]
[   28.735664] saa7134[0]: registered device vbi0
[   28.735680] saa7134[0]: registered device radio0
[   28.772114] saa7134 ALSA driver for DMA sound loaded
[   28.772133] saa7134[0]/alsa: saa7134[0] at 0xfddff000 irq 21
registered as card -2
[   30.535136] lp0: using parport0 (interrupt-driven).
[   30.609508] Adding 3301316k swap on /dev/hda5.  Priority:-1
extents:1 across:3301316k
[   30.840721] EXT3 FS on hda1, internal journal
[   31.535151] audit(1203246100.097:2): operation="profile_load"
info="failed to unpack profile" name="/usr/lib/cups/backend/cups-pdf"
pid=4194
[   31.978721] No dock devices found.
[   31.997180] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[   32.382556] powernow-k8: Found 1 AMD Athlon(tm) 64 X2 Dual Core
Processor 4200+ processors (2 cpu cores) (version 2.20.00)
[   32.382057] powernow-k8:    0 : fid 0xe (2200 MHz), vid 0xc
[   32.382061] powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xe
[   32.382063] powernow-k8:    2 : fid 0xa (1800 MHz), vid 0x10
[   32.382064] powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
[   33.588202] NET: Registered protocol family 10
[   33.588899] lo: Disabled Privacy Extensions
[   33.604464] r8169: eth0: link up
[   33.604475] r8169: eth0: link up
[   36.044028] apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
[   36.044034] apm: disabled - APM is not SMP safe.
[   39.702252] Clocksource tsc unstable (delta = -90359443 ns)
[   41.273653] NET: Registered protocol family 17
[   41.369101] fglrx: module license 'Proprietary. (C) 2002 - ATI
Technologies, Starnberg, GERMANY' taints kernel.
[   41.388211] [fglrx] Maximum main memory to use for locked dma
buffers: 1777 MBytes.
[   41.388241] [fglrx] ASYNCIO init succeed!
[   41.388518] [fglrx] PAT is enabled successfully!
[   41.388533] [fglrx] module loaded - fglrx 8.45.4 [Jan 16 2008] on minor 0
[   41.420991] ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 18 (level,
low) -> IRQ 19
[   41.811177] [fglrx] GART Table is not in FRAME_BUFFER range
[   41.811186] [fglrx] Reserve Block - 0 offset =  0X7ffc000 length = 0X4000
[   41.811188] [fglrx] Reserve Block - 1 offset =  0X0 length = 0X1000000
[   41.939765] [fglrx] interrupt source 20008000 successfully enabled
[   41.939770] [fglrx] enable ID = 0x00000008
[   41.939776] [fglrx] Receive enable interrupt message with
irqEnableMask: 20008000
[   41.939828] [fglrx] interrupt source 10000000 successfully enabled
[   41.939830] [fglrx] enable ID = 0x00000009
[   41.939833] [fglrx] Receive enable interrupt message with
irqEnableMask: 10000000
[   46.872609] UDF-fs: No VRS found
[   46.948177] ISO 9660 Extensions: Microsoft Joliet Level 3
[   46.986111] ISO 9660 Extensions: RRIP_1991A
[   48.316135] eth0: no IPv6 routers present
[   89.234691] hda-intel: Invalid position buffer, using LPIB read
method instead.
[   90.004956] hda: dma_intr: bad DMA status (dma_stat=76)
[   90.004963] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   90.004966] ide: failed opcode was: unknown
[   90.625009] hda: dma_intr: bad DMA status (dma_stat=76)
[   90.625015] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   90.625018] ide: failed opcode was: unknown
[   91.248376] hda: dma_intr: bad DMA status (dma_stat=76)
[   91.248382] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   91.248385] ide: failed opcode was: unknown
[   91.266960] hda: dma_intr: bad DMA status (dma_stat=76)
[   91.266967] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   91.266970] ide: failed opcode was: unknown
[   92.374776] hda: dma_intr: bad DMA status (dma_stat=76)
[   92.374782] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   92.374785] ide: failed opcode was: unknown
[   92.379103] hda: dma_intr: bad DMA status (dma_stat=76)
[   92.379108] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   92.379111] ide: failed opcode was: unknown
[   93.305409] hda: dma_intr: bad DMA status (dma_stat=76)
[   93.305416] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   93.305419] ide: failed opcode was: unknown
[   94.578349] hda: dma_intr: bad DMA status (dma_stat=76)
[   94.578356] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   94.578360] ide: failed opcode was: unknown
[   94.583414] hda: dma_intr: bad DMA status (dma_stat=76)
[   94.583416] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   94.583419] ide: failed opcode was: unknown
[   95.727660] hda: dma_intr: bad DMA status (dma_stat=76)
[   95.727668] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   95.727671] ide: failed opcode was: unknown
[   96.650132] hda: dma_intr: bad DMA status (dma_stat=76)
[   96.650138] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   96.650141] ide: failed opcode was: unknown
[   96.651473] hda: dma_intr: bad DMA status (dma_stat=76)
[   96.651476] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   96.651478] ide: failed opcode was: unknown
[   96.684017] hda: dma_intr: bad DMA status (dma_stat=76)
[   96.684023] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   96.684026] ide: failed opcode was: unknown
[   97.681720] hda: dma_intr: bad DMA status (dma_stat=76)
[   97.681727] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   97.681730] ide: failed opcode was: unknown
[   97.682947] hda: dma_intr: bad DMA status (dma_stat=76)
[   97.682953] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   97.682956] ide: failed opcode was: unknown
[   97.731408] hda: dma_intr: bad DMA status (dma_stat=76)
[   97.731414] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   97.731417] ide: failed opcode was: unknown
[   97.732613] hda: dma_intr: bad DMA status (dma_stat=76)
[   97.732616] hda: dma_intr: status=0x50 { DriveReady SeekComplete }
[   97.732618] ide: failed opcode was: unknown
[   97.732622] hda: DMA disabled
[   97.732629] hdb: DMA disabled
[   97.809464] ide0: reset: success
[  151.281458] [fglrx:firegl_free_mutex] *ERROR* mutex id 0x00000005
not found in mutex list
