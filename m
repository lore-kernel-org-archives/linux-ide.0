From: Landry Breuil <landry@rhaalovely.net>
Subject: sata_via: write errors on SATA drive connected to VT6421
Date: Tue, 3 Feb 2009 14:30:08 +0100
Message-ID: <20090203133008.GN19493@dawn.rhaalovely.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="veXX9dWIonWZEC6h"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dawn.rhaalovely.net ([212.85.158.28]:21528 "EHLO
	dawn.rhaalovely.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825AbZBCNhy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Feb 2009 08:37:54 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

i encounter a very similar problem as reported in
http://marc.info/?l=linux-kernel&m=118764381013943&w=2, but with a SATA
disk. Trying to transfer 250Gb (mostly small files) from a SATA disk
(ata1/sda) to another (ata2/sdb), both plugged on the VT6421 card, after
some dozens of seconds the controler bails out and degrades write performance
(UDMA133->UDMA100->UDMA33...)

kernel: ata2.00: limiting speed to UDMA/33:PIO4
kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
kernel: ata2.00: cmd 35/00:00:07:c6:f4/00:04:07:00:00/e0 tag 0 dma 524288 out
kernel:          res 40/00:b0:27:1d:dc/84:00:07:00:00/e0 Emask 0x16 (ATA bus error)
kernel: ata2.00: status: { DRDY }
kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
kernel: ata2: device not ready (errno=-16), forcing hardreset
kernel: ata2: hard resetting link
kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)

Reading big datas is okay so far. Creating a 2.5Gb file on the same disk
with dd if=/dev/zero is okay too. dd'ing a 500Mb file 10 times in a loop
from sda to sdb works too.

Kernel is 2.6.24 from Debian etch'n'half, but also appeared with 2.6.18
from Debian etch. AFAIR they don't apply patches on sata_via driver,
according to linux-patch-debian-2.6.24 package.

So my questions:
- is it likely to be the drive ? it's brand new
- shall i try swapping cards in pci slots / disks on sata slots ?
- shall i bug debian first ?
- shall i try with latest available kernel from kernel.org ?

Attached lspci -vv and var/log/kern.log showing logs from both 2.6.18
and 2.6.24.

Thanks for any pointers/help.

Landry Breuil

--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
	Subsystem: ASUSTeK Computer Inc. A7V8X motherboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: <access denied>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: ee000000-efdfffff
	Prefetchable memory behind bridge: eff00000-f7ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <access denied>

00:0b.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID Controller (rev 50)
	Subsystem: VIA Technologies, Inc. VT6421 IDE RAID Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at d800 [size=16]
	Region 1: I/O ports at d400 [size=16]
	Region 2: I/O ports at d000 [size=16]
	Region 3: I/O ports at b800 [size=16]
	Region 4: I/O ports at b400 [size=32]
	Region 5: I/O ports at b000 [size=256]
	[virtual] Expansion ROM at 50000000 [disabled] [size=64K]
	Capabilities: <access denied>

00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at a800 [size=32]
	Capabilities: <access denied>

00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 16
	Region 4: I/O ports at a400 [size=32]
	Capabilities: <access denied>

00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 32 bytes
	Interrupt: pin C routed to IRQ 16
	Region 4: I/O ports at a000 [size=32]
	Capabilities: <access denied>

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard rev 1.01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin D routed to IRQ 16
	Region 0: Memory at ed800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <access denied>

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <access denied>

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. A7V8X-X motherboard rev. 1.01
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 255
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
	Region 4: I/O ports at 9800 [size=16]
	Capabilities: <access denied>

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
	Subsystem: ASUSTeK Computer Inc. A7V8X-X Motherboard
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 19
	Region 0: I/O ports at e000 [size=256]
	Capabilities: <access denied>

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
	Subsystem: ASUSTeK Computer Inc. A7V8X-X Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 9400 [size=256]
	Region 1: Memory at ed000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <access denied>

01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 4000 AGP 8x] (rev c1) (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd. Unknown device 9363
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at effe0000 [disabled] [size=128K]
	Capabilities: <access denied>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kern.log"

Feb  2 11:15:33 polegeom kernel: Kernel logging (proc) stopped.
Feb  2 11:15:33 polegeom kernel: Kernel log daemon terminating.
Feb  2 11:40:27 polegeom kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
Feb  2 11:40:27 polegeom kernel: Linux version 2.6.18-6-486 (Debian 2.6.18.dfsg.1-23etch1) (dannf@debian.org) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 Fri Dec 12 16:18:30 UTC 2008
Feb  2 11:40:27 polegeom kernel: BIOS-provided physical RAM map:
Feb  2 11:40:27 polegeom kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb  2 11:40:27 polegeom kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb  2 11:40:27 polegeom kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Feb  2 11:40:27 polegeom kernel:  BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
Feb  2 11:40:27 polegeom kernel:  BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
Feb  2 11:40:27 polegeom kernel:  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
Feb  2 11:40:27 polegeom kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Feb  2 11:40:27 polegeom kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Feb  2 11:40:27 polegeom kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Feb  2 11:40:27 polegeom kernel: Warning only 896MB will be used.
Feb  2 11:40:27 polegeom kernel: Use a HIGHMEM enabled kernel.
Feb  2 11:40:27 polegeom kernel: 896MB LOWMEM available.
Feb  2 11:40:27 polegeom kernel: On node 0 totalpages: 229376
Feb  2 11:40:27 polegeom kernel:   DMA zone: 4096 pages, LIFO batch:0
Feb  2 11:40:27 polegeom kernel:   Normal zone: 225280 pages, LIFO batch:31
Feb  2 11:40:27 polegeom kernel: DMI 2.3 present.
Feb  2 11:40:27 polegeom kernel: ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5f50
Feb  2 11:40:27 polegeom kernel: ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc000
Feb  2 11:40:27 polegeom kernel: ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc0b2
Feb  2 11:40:27 polegeom kernel: ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc030
Feb  2 11:40:27 polegeom kernel: ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc058
Feb  2 11:40:27 polegeom kernel: ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT 0x0100000b) @ 0x00000000
Feb  2 11:40:27 polegeom kernel: ACPI: PM-Timer IO Port: 0xe408
Feb  2 11:40:27 polegeom kernel: ACPI: Local APIC address 0xfee00000
Feb  2 11:40:27 polegeom kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Feb  2 11:40:27 polegeom kernel: Processor #0 6:10 APIC version 16
Feb  2 11:40:27 polegeom kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Feb  2 11:40:27 polegeom kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Feb  2 11:40:27 polegeom kernel: IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
Feb  2 11:40:27 polegeom kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
Feb  2 11:40:27 polegeom kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Feb  2 11:40:27 polegeom kernel: ACPI: IRQ0 used by override.
Feb  2 11:40:27 polegeom kernel: ACPI: IRQ2 used by override.
Feb  2 11:40:27 polegeom kernel: ACPI: IRQ9 used by override.
Feb  2 11:40:27 polegeom kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb  2 11:40:27 polegeom kernel: Using ACPI (MADT) for SMP configuration information
Feb  2 11:40:27 polegeom kernel: Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Feb  2 11:40:27 polegeom kernel: Detected 1916.544 MHz processor.
Feb  2 11:40:27 polegeom kernel: Built 1 zonelists.  Total pages: 229376
Feb  2 11:40:27 polegeom kernel: Kernel command line: root=/dev/hdb1 ro 
Feb  2 11:40:27 polegeom kernel: mapped APIC to ffffd000 (fee00000)
Feb  2 11:40:27 polegeom kernel: mapped IOAPIC to ffffc000 (fec00000)
Feb  2 11:40:27 polegeom kernel: Enabling fast FPU save and restore... done.
Feb  2 11:40:27 polegeom kernel: Enabling unmasked SIMD FPU exception support... done.
Feb  2 11:40:27 polegeom kernel: Initializing CPU#0
Feb  2 11:40:27 polegeom kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Feb  2 11:40:27 polegeom kernel: Console: colour VGA+ 80x25
Feb  2 11:40:27 polegeom kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb  2 11:40:27 polegeom kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb  2 11:40:27 polegeom kernel: Memory: 902096k/917504k available (1501k kernel code, 14816k reserved, 601k data, 256k init, 0k highmem)
Feb  2 11:40:27 polegeom kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb  2 11:40:27 polegeom kernel: Calibrating delay using timer specific routine.. 3836.28 BogoMIPS (lpj=7672566)
Feb  2 11:40:27 polegeom kernel: Security Framework v1.0.0 initialized
Feb  2 11:40:27 polegeom kernel: SELinux:  Disabled at boot.
Feb  2 11:40:27 polegeom kernel: Capability LSM initialized
Feb  2 11:40:27 polegeom kernel: Mount-cache hash table entries: 512
Feb  2 11:40:27 polegeom kernel: CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
Feb  2 11:40:27 polegeom kernel: CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
Feb  2 11:40:27 polegeom kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb  2 11:40:27 polegeom kernel: CPU: L2 Cache: 512K (64 bytes/line)
Feb  2 11:40:27 polegeom kernel: CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000
Feb  2 11:40:27 polegeom kernel: Compat vDSO mapped to ffffe000.
Feb  2 11:40:27 polegeom kernel: CPU: AMD Athlon(TM) XP 2600+ stepping 00
Feb  2 11:40:27 polegeom kernel: Checking 'hlt' instruction... OK.
Feb  2 11:40:27 polegeom kernel: ACPI: Core revision 20060707
Feb  2 11:40:27 polegeom kernel: ENABLING IO-APIC IRQs
Feb  2 11:40:27 polegeom kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Feb  2 11:40:27 polegeom kernel: checking if image is initramfs... it is
Feb  2 11:40:27 polegeom kernel: Freeing initrd memory: 4232k freed
Feb  2 11:40:27 polegeom kernel: NET: Registered protocol family 16
Feb  2 11:40:27 polegeom kernel: EISA bus registered
Feb  2 11:40:27 polegeom kernel: ACPI: bus type pci registered
Feb  2 11:40:27 polegeom kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1990, last bus=1
Feb  2 11:40:27 polegeom kernel: PCI: Using configuration type 1
Feb  2 11:40:27 polegeom kernel: Setting up standard PCI resources
Feb  2 11:40:27 polegeom kernel: ACPI: Interpreter enabled
Feb  2 11:40:27 polegeom kernel: ACPI: Using IOAPIC for interrupt routing
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12)
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12)
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb  2 11:40:27 polegeom kernel: PCI: Probing PCI hardware (bus 00)
Feb  2 11:40:27 polegeom kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Feb  2 11:40:27 polegeom kernel: PCI quirk: region e400-e47f claimed by vt8235 PM
Feb  2 11:40:27 polegeom kernel: PCI quirk: region e800-e80f claimed by vt8235 SMB
Feb  2 11:40:27 polegeom kernel: Boot video device is 0000:01:00.0
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Feb  2 11:40:27 polegeom kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb  2 11:40:27 polegeom kernel: pnp: PnP ACPI init
Feb  2 11:40:27 polegeom kernel: pnp: PnP ACPI: found 16 devices
Feb  2 11:40:27 polegeom kernel: PnPBIOS: Disabled by ACPI PNP
Feb  2 11:40:27 polegeom kernel: PCI: Using ACPI for IRQ routing
Feb  2 11:40:27 polegeom kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Feb  2 11:40:27 polegeom kernel: pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
Feb  2 11:40:27 polegeom kernel: pnp: 00:02: ioport range 0xe800-0xe81f could not be reserved
Feb  2 11:40:27 polegeom kernel: pnp: 00:0f: ioport range 0x290-0x297 has been reserved
Feb  2 11:40:27 polegeom kernel: pnp: 00:0f: ioport range 0x370-0x375 has been reserved
Feb  2 11:40:27 polegeom kernel: PCI: Bridge: 0000:00:01.0
Feb  2 11:40:27 polegeom kernel:   IO window: disabled.
Feb  2 11:40:27 polegeom kernel:   MEM window: ee000000-efdfffff
Feb  2 11:40:27 polegeom kernel:   PREFETCH window: eff00000-f7ffffff
Feb  2 11:40:27 polegeom kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Feb  2 11:40:27 polegeom kernel: NET: Registered protocol family 2
Feb  2 11:40:27 polegeom kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb  2 11:40:27 polegeom kernel: TCP established hash table entries: 131072 (order: 7, 524288 bytes)
Feb  2 11:40:27 polegeom kernel: TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
Feb  2 11:40:27 polegeom kernel: TCP: Hash tables configured (established 131072 bind 65536)
Feb  2 11:40:27 polegeom kernel: TCP reno registered
Feb  2 11:40:27 polegeom kernel: Simple Boot Flag at 0x3a set to 0x1
Feb  2 11:40:27 polegeom kernel: audit: initializing netlink socket (disabled)
Feb  2 11:40:27 polegeom kernel: audit(1233571214.788:1): initialized
Feb  2 11:40:27 polegeom kernel: VFS: Disk quotas dquot_6.5.1
Feb  2 11:40:27 polegeom kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Feb  2 11:40:27 polegeom kernel: Initializing Cryptographic API
Feb  2 11:40:27 polegeom kernel: io scheduler noop registered
Feb  2 11:40:27 polegeom kernel: io scheduler anticipatory registered
Feb  2 11:40:27 polegeom kernel: io scheduler deadline registered
Feb  2 11:40:27 polegeom kernel: io scheduler cfq registered (default)
Feb  2 11:40:27 polegeom kernel: isapnp: Scanning for PnP cards...
Feb  2 11:40:27 polegeom kernel: isapnp: No Plug & Play device found
Feb  2 11:40:27 polegeom kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Feb  2 11:40:27 polegeom kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  2 11:40:27 polegeom kernel: 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  2 11:40:27 polegeom kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Feb  2 11:40:27 polegeom kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Feb  2 11:40:27 polegeom kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  2 11:40:27 polegeom kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  2 11:40:27 polegeom kernel: mice: PS/2 mouse device common for all mice
Feb  2 11:40:27 polegeom kernel: EISA: Probing bus 0 at eisa.0
Feb  2 11:40:27 polegeom kernel: EISA: Detected 0 cards.
Feb  2 11:40:27 polegeom kernel: TCP bic registered
Feb  2 11:40:27 polegeom kernel: NET: Registered protocol family 1
Feb  2 11:40:27 polegeom kernel: NET: Registered protocol family 17
Feb  2 11:40:27 polegeom kernel: NET: Registered protocol family 8
Feb  2 11:40:27 polegeom kernel: NET: Registered protocol family 20
Feb  2 11:40:27 polegeom kernel: Using IPI Shortcut mode
Feb  2 11:40:27 polegeom kernel: ACPI: (supports S0 S1 S4 S5)
Feb  2 11:40:27 polegeom kernel: Time: tsc clocksource has been installed.
Feb  2 11:40:27 polegeom kernel: Freeing unused kernel memory: 256k freed
Feb  2 11:40:27 polegeom kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Feb  2 11:40:27 polegeom kernel: SCSI subsystem initialized
Feb  2 11:40:27 polegeom kernel: usbcore: registered new driver usbfs
Feb  2 11:40:27 polegeom kernel: usbcore: registered new driver hub
Feb  2 11:40:27 polegeom kernel: USB Universal Host Controller Interface driver v3.0
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 169
Feb  2 11:40:27 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:10.0, from 0 to 9
Feb  2 11:40:27 polegeom kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Feb  2 11:40:27 polegeom kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
Feb  2 11:40:27 polegeom kernel: uhci_hcd 0000:00:10.0: irq 169, io base 0x0000a800
Feb  2 11:40:27 polegeom kernel: usb usb1: configuration #1 chosen from 1 choice
Feb  2 11:40:27 polegeom kernel: hub 1-0:1.0: USB hub found
Feb  2 11:40:27 polegeom kernel: hub 1-0:1.0: 2 ports detected
Feb  2 11:40:27 polegeom kernel: libata version 2.00 loaded.
Feb  2 11:40:27 polegeom kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb  2 11:40:27 polegeom kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb  2 11:40:27 polegeom kernel: via-rhine.c:v1.10-LK1.4.1 July-24-2006 Written by Donald Becker
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 169
Feb  2 11:40:27 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:10.1, from 0 to 9
Feb  2 11:40:27 polegeom kernel: uhci_hcd 0000:00:10.1: UHCI Host Controller
Feb  2 11:40:27 polegeom kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
Feb  2 11:40:27 polegeom kernel: uhci_hcd 0000:00:10.1: irq 169, io base 0x0000a400
Feb  2 11:40:27 polegeom kernel: usb usb2: configuration #1 chosen from 1 choice
Feb  2 11:40:27 polegeom kernel: hub 2-0:1.0: USB hub found
Feb  2 11:40:27 polegeom kernel: hub 2-0:1.0: 2 ports detected
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 169
Feb  2 11:40:27 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:10.2, from 0 to 9
Feb  2 11:40:27 polegeom kernel: uhci_hcd 0000:00:10.2: UHCI Host Controller
Feb  2 11:40:27 polegeom kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
Feb  2 11:40:27 polegeom kernel: uhci_hcd 0000:00:10.2: irq 169, io base 0x0000a000
Feb  2 11:40:27 polegeom kernel: usb usb3: configuration #1 chosen from 1 choice
Feb  2 11:40:27 polegeom kernel: hub 3-0:1.0: USB hub found
Feb  2 11:40:27 polegeom kernel: hub 3-0:1.0: 2 ports detected
Feb  2 11:40:27 polegeom kernel: sata_via 0000:00:0b.0: version 2.0
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 177
Feb  2 11:40:27 polegeom kernel: sata_via 0000:00:0b.0: routed to hard irq line 3
Feb  2 11:40:27 polegeom kernel: ata1: SATA max UDMA/133 cmd 0xD800 ctl 0xD80A bmdma 0xB400 irq 177
Feb  2 11:40:27 polegeom kernel: ata2: SATA max UDMA/133 cmd 0xD400 ctl 0xD40A bmdma 0xB408 irq 177
Feb  2 11:40:27 polegeom kernel: scsi0 : sata_via
Feb  2 11:40:27 polegeom kernel: usb 2-1: new full speed USB device using uhci_hcd and address 2
Feb  2 11:40:27 polegeom kernel: usb 2-1: configuration #1 chosen from 1 choice
Feb  2 11:40:27 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 11:40:27 polegeom kernel: ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
Feb  2 11:40:27 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 11:40:27 polegeom kernel: scsi1 : sata_via
Feb  2 11:40:27 polegeom kernel: Initializing USB Mass Storage driver...
Feb  2 11:40:27 polegeom kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Feb  2 11:40:27 polegeom kernel: usbcore: registered new driver usb-storage
Feb  2 11:40:27 polegeom kernel: USB Mass Storage support registered.
Feb  2 11:40:27 polegeom kernel: usb-storage: device found at 2
Feb  2 11:40:27 polegeom kernel: usb-storage: waiting for device to settle before scanning
Feb  2 11:40:27 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 11:40:27 polegeom kernel: ata2.00: ATA-8, max UDMA7, 976773168 sectors: LBA48 NCQ (depth 0/32)
Feb  2 11:40:27 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 11:40:27 polegeom kernel:   Vendor: ATA       Model: ST3250824AS       Rev: 3.AA
Feb  2 11:40:27 polegeom kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Feb  2 11:40:27 polegeom kernel:   Vendor: ATA       Model: SAMSUNG HD501LJ   Rev: CR10
Feb  2 11:40:27 polegeom kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 169
Feb  2 11:40:27 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:10.3, from 0 to 9
Feb  2 11:40:27 polegeom kernel: ehci_hcd 0000:00:10.3: EHCI Host Controller
Feb  2 11:40:27 polegeom kernel: ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
Feb  2 11:40:27 polegeom kernel: ehci_hcd 0000:00:10.3: irq 169, io mem 0xed800000
Feb  2 11:40:27 polegeom kernel: ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Feb  2 11:40:27 polegeom kernel: usb usb4: configuration #1 chosen from 1 choice
Feb  2 11:40:27 polegeom kernel: hub 4-0:1.0: USB hub found
Feb  2 11:40:27 polegeom kernel: hub 4-0:1.0: 6 ports detected
Feb  2 11:40:27 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 11:40:27 polegeom kernel: sda: Write Protect is off
Feb  2 11:40:27 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 11:40:27 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 11:40:27 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 11:40:27 polegeom kernel: sda: Write Protect is off
Feb  2 11:40:27 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 11:40:27 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 11:40:27 polegeom kernel:  sda: [LDM] sda1
Feb  2 11:40:27 polegeom kernel: sd 0:0:0:0: Attached scsi disk sda
Feb  2 11:40:27 polegeom kernel: VP_IDE: IDE controller at PCI slot 0000:00:11.1
Feb  2 11:40:27 polegeom kernel: ACPI: Unable to derive IRQ for device 0000:00:11.1
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
Feb  2 11:40:27 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 15
Feb  2 11:40:27 polegeom kernel: VP_IDE: chipset revision 6
Feb  2 11:40:27 polegeom kernel: VP_IDE: not 100%% native mode: will probe irqs later
Feb  2 11:40:27 polegeom kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Feb  2 11:40:27 polegeom kernel:     ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:pio, hdb:DMA
Feb  2 11:40:27 polegeom kernel:     ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
Feb  2 11:40:27 polegeom kernel: Probing IDE interface ide0...
Feb  2 11:40:27 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 11:40:27 polegeom kernel: sdb: Write Protect is off
Feb  2 11:40:27 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 11:40:27 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 11:40:27 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 11:40:27 polegeom kernel: sdb: Write Protect is off
Feb  2 11:40:27 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 11:40:27 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 11:40:27 polegeom kernel:  sdb: unknown partition table
Feb  2 11:40:27 polegeom kernel: sd 1:0:0:0: Attached scsi disk sdb
Feb  2 11:40:27 polegeom kernel: usb 4-3: new high speed USB device using ehci_hcd and address 2
Feb  2 11:40:27 polegeom kernel: hdb: ST380215A, ATA DISK drive
Feb  2 11:40:27 polegeom kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  2 11:40:27 polegeom kernel: Probing IDE interface ide1...
Feb  2 11:40:27 polegeom kernel: usb 4-3: configuration #1 chosen from 1 choice
Feb  2 11:40:27 polegeom kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Feb  2 11:40:27 polegeom kernel: usb-storage: device found at 2
Feb  2 11:40:27 polegeom kernel: usb-storage: waiting for device to settle before scanning
Feb  2 11:40:27 polegeom kernel: usb 2-1: USB disconnect, address 2
Feb  2 11:40:27 polegeom kernel: hdc: SONY DVD-ROM DDU1612, ATAPI CD/DVD-ROM drive
Feb  2 11:40:27 polegeom kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 185
Feb  2 11:40:27 polegeom kernel: eth0: VIA Rhine II at 0x19400, 00:0e:a6:6a:1c:1f, IRQ 185.
Feb  2 11:40:27 polegeom kernel: eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link c5e1.
Feb  2 11:40:27 polegeom kernel: hdb: max request size: 512KiB
Feb  2 11:40:27 polegeom kernel: hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
Feb  2 11:40:27 polegeom kernel: hdb: cache flushes supported
Feb  2 11:40:27 polegeom kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 >
Feb  2 11:40:27 polegeom kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Feb  2 11:40:27 polegeom kernel: Uniform CD-ROM driver Revision: 3.20
Feb  2 11:40:27 polegeom kernel: Attempting manual resume
Feb  2 11:40:27 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 11:40:27 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 11:40:27 polegeom kernel: Linux agpgart interface v0.101 (c) Dave Jones
Feb  2 11:40:27 polegeom kernel: agpgart: Detected VIA KT400/KT400A/KT600 chipset
Feb  2 11:40:27 polegeom kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Feb  2 11:40:27 polegeom kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Feb  2 11:40:27 polegeom kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Feb  2 11:40:27 polegeom kernel: Real Time Clock Driver v1.12ac
Feb  2 11:40:27 polegeom kernel: input: PC Speaker as /class/input/input1
Feb  2 11:40:27 polegeom kernel: parport: PnPBIOS parport detected.
Feb  2 11:40:27 polegeom kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Feb  2 11:40:27 polegeom kernel: Floppy drive(s): fd0 is 1.44M
Feb  2 11:40:27 polegeom kernel: FDC 0 is a post-1991 82077
Feb  2 11:40:27 polegeom kernel: input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
Feb  2 11:40:27 polegeom kernel: irda_init()
Feb  2 11:40:27 polegeom kernel: NET: Registered protocol family 23
Feb  2 11:40:27 polegeom kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 193
Feb  2 11:40:27 polegeom kernel: PCI: Setting latency timer of device 0000:00:11.5 to 64
Feb  2 11:40:27 polegeom kernel: ts: Compaq touchscreen protocol output
Feb  2 11:40:27 polegeom kernel: codec_read: codec 0 is not valid [0x107e5370]
Feb  2 11:40:27 polegeom last message repeated 3 times
Feb  2 11:40:27 polegeom kernel: Adding 7992k swap on /dev/hdb6.  Priority:-1 extents:1 across:7992k
Feb  2 11:40:27 polegeom kernel: EXT3 FS on hdb1, internal journal
Feb  2 11:40:27 polegeom kernel:   Vendor: SAMSUNG   Model: HD753LJ           Rev:     
Feb  2 11:40:27 polegeom kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb  2 11:40:27 polegeom kernel: SCSI device sdc: 1465149168 512-byte hdwr sectors (750156 MB)
Feb  2 11:40:27 polegeom kernel: sdc: Write Protect is off
Feb  2 11:40:27 polegeom kernel: sdc: Mode Sense: 38 00 00 00
Feb  2 11:40:27 polegeom kernel: sdc: assuming drive cache: write through
Feb  2 11:40:27 polegeom kernel: SCSI device sdc: 1465149168 512-byte hdwr sectors (750156 MB)
Feb  2 11:40:27 polegeom kernel: sdc: Write Protect is off
Feb  2 11:40:27 polegeom kernel: sdc: Mode Sense: 38 00 00 00
Feb  2 11:40:27 polegeom kernel: sdc: assuming drive cache: write through
Feb  2 11:40:27 polegeom kernel:  sdc:<6>loop: loaded (max 8 devices)
Feb  2 11:40:27 polegeom kernel: device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
Feb  2 11:40:27 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 11:40:27 polegeom kernel: EXT3 FS on hdb3, internal journal
Feb  2 11:40:27 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 11:40:27 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 11:40:27 polegeom kernel: EXT3 FS on hdb2, internal journal
Feb  2 11:40:27 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 11:40:27 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 11:40:27 polegeom kernel: EXT3 FS on hdb5, internal journal
Feb  2 11:40:27 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 11:40:27 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 11:40:27 polegeom kernel: EXT3 FS on hdb7, internal journal
Feb  2 11:40:27 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 11:40:27 polegeom kernel: eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
Feb  2 11:40:31 polegeom kernel:  sdc1
Feb  2 11:40:31 polegeom kernel: sd 3:0:0:0: Attached scsi disk sdc
Feb  2 11:40:31 polegeom kernel: usb-storage: device scan complete
Feb  2 11:40:34 polegeom kernel: NET: Registered protocol family 10
Feb  2 11:40:34 polegeom kernel: lo: Disabled Privacy Extensions
Feb  2 11:40:34 polegeom kernel: IPv6 over IPv4 tunneling driver
Feb  2 11:40:35 polegeom kernel: ACPI: Power Button (FF) [PWRF]
Feb  2 11:40:35 polegeom kernel: ACPI: Power Button (CM) [PWRB]
Feb  2 11:40:45 polegeom kernel: eth0: no IPv6 routers present
Feb  2 12:29:49 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:49 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:49 polegeom kernel: ata1: soft resetting port
Feb  2 12:29:49 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:49 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:29:49 polegeom kernel: ata1: EH complete
Feb  2 12:29:49 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:49 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:50 polegeom kernel: ata1: soft resetting port
Feb  2 12:29:50 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:50 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:29:50 polegeom kernel: ata1: EH complete
Feb  2 12:29:50 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:50 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:50 polegeom kernel: ata1: soft resetting port
Feb  2 12:29:50 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:50 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:29:50 polegeom kernel: ata1: EH complete
Feb  2 12:29:50 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:50 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:51 polegeom kernel: ata1: soft resetting port
Feb  2 12:29:51 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:51 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:29:51 polegeom kernel: ata1: EH complete
Feb  2 12:29:51 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:51 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:51 polegeom kernel: ata1: soft resetting port
Feb  2 12:29:51 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:51 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:29:51 polegeom kernel: ata1: EH complete
Feb  2 12:29:51 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:51 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:52 polegeom kernel: ata1: soft resetting port
Feb  2 12:29:52 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:52 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:29:52 polegeom kernel: ata1: EH complete
Feb  2 12:29:52 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 12:29:52 polegeom kernel: sda: Write Protect is off
Feb  2 12:29:52 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 12:29:52 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 12:29:52 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 12:29:52 polegeom kernel: sda: Write Protect is off
Feb  2 12:29:52 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 12:29:52 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 12:29:52 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:52 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:52 polegeom kernel: ata2: soft resetting port
Feb  2 12:29:52 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:52 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:29:52 polegeom kernel: ata2: EH complete
Feb  2 12:29:52 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:52 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:53 polegeom kernel: ata2: soft resetting port
Feb  2 12:29:53 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:53 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:29:53 polegeom kernel: ata2: EH complete
Feb  2 12:29:53 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:53 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:53 polegeom kernel: ata2: soft resetting port
Feb  2 12:29:53 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:53 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:29:53 polegeom kernel: ata2: EH complete
Feb  2 12:29:53 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:53 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:54 polegeom kernel: ata2: soft resetting port
Feb  2 12:29:54 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:54 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:29:54 polegeom kernel: ata2: EH complete
Feb  2 12:29:54 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:54 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:54 polegeom kernel: ata2: soft resetting port
Feb  2 12:29:54 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:54 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:29:54 polegeom kernel: ata2: EH complete
Feb  2 12:29:54 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:29:54 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:29:55 polegeom kernel: ata2: soft resetting port
Feb  2 12:29:55 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:29:55 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:29:55 polegeom kernel: ata2: EH complete
Feb  2 12:29:55 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 12:29:55 polegeom kernel: sdb: Write Protect is off
Feb  2 12:29:55 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 12:29:55 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 12:29:55 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 12:29:55 polegeom kernel: sdb: Write Protect is off
Feb  2 12:29:55 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 12:29:55 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 12:30:09 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:09 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:09 polegeom kernel: ata1: soft resetting port
Feb  2 12:30:09 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:09 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:30:09 polegeom kernel: ata1: EH complete
Feb  2 12:30:09 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:09 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:09 polegeom kernel: ata1: soft resetting port
Feb  2 12:30:10 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:10 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:30:10 polegeom kernel: ata1: EH complete
Feb  2 12:30:10 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:10 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:10 polegeom kernel: ata1: soft resetting port
Feb  2 12:30:10 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:10 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:30:10 polegeom kernel: ata1: EH complete
Feb  2 12:30:10 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:10 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:10 polegeom kernel: ata1: soft resetting port
Feb  2 12:30:11 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:11 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:30:11 polegeom kernel: ata1: EH complete
Feb  2 12:30:11 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:11 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:11 polegeom kernel: ata1: soft resetting port
Feb  2 12:30:11 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:11 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:30:11 polegeom kernel: ata1: EH complete
Feb  2 12:30:11 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:11 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:11 polegeom kernel: ata1: soft resetting port
Feb  2 12:30:11 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:11 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 12:30:11 polegeom kernel: ata1: EH complete
Feb  2 12:30:11 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 12:30:11 polegeom kernel: sda: Write Protect is off
Feb  2 12:30:11 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 12:30:11 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 12:30:11 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 12:30:11 polegeom kernel: sda: Write Protect is off
Feb  2 12:30:11 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 12:30:11 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 12:30:20 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:20 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:20 polegeom kernel: ata2: soft resetting port
Feb  2 12:30:20 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:20 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:30:20 polegeom kernel: ata2: EH complete
Feb  2 12:30:20 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:20 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:21 polegeom kernel: ata2: soft resetting port
Feb  2 12:30:21 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:21 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:30:21 polegeom kernel: ata2: EH complete
Feb  2 12:30:21 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:21 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:21 polegeom kernel: ata2: soft resetting port
Feb  2 12:30:21 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:21 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:30:21 polegeom kernel: ata2: EH complete
Feb  2 12:30:21 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:21 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:22 polegeom kernel: ata2: soft resetting port
Feb  2 12:30:22 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:22 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:30:22 polegeom kernel: ata2: EH complete
Feb  2 12:30:22 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:22 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:22 polegeom kernel: ata2: soft resetting port
Feb  2 12:30:22 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:22 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:30:22 polegeom kernel: ata2: EH complete
Feb  2 12:30:22 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:30:22 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:30:23 polegeom kernel: ata2: soft resetting port
Feb  2 12:30:23 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:30:23 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:30:23 polegeom kernel: ata2: EH complete
Feb  2 12:30:23 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 12:30:23 polegeom kernel: sdb: Write Protect is off
Feb  2 12:30:23 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 12:30:23 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 12:30:23 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 12:30:23 polegeom kernel: sdb: Write Protect is off
Feb  2 12:30:23 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 12:30:23 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 12:34:29 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:29 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:30 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:30 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:30 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:30 polegeom kernel: ata2: EH complete
Feb  2 12:34:30 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:30 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:30 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:30 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:30 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:30 polegeom kernel: ata2: EH complete
Feb  2 12:34:30 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:30 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:31 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:31 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:31 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:31 polegeom kernel: ata2: EH complete
Feb  2 12:34:31 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:31 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:31 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:31 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:31 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:31 polegeom kernel: ata2: EH complete
Feb  2 12:34:31 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:31 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:32 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:32 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:32 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:32 polegeom kernel: ata2: EH complete
Feb  2 12:34:32 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:32 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:32 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:32 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:32 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:32 polegeom kernel: ata2: EH complete
Feb  2 12:34:32 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 12:34:32 polegeom kernel: sdb: Write Protect is off
Feb  2 12:34:32 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 12:34:32 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 12:34:32 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 12:34:32 polegeom kernel: sdb: Write Protect is off
Feb  2 12:34:32 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 12:34:32 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 12:34:39 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:39 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:39 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:40 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:40 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:40 polegeom kernel: ata2: EH complete
Feb  2 12:34:40 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:40 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:40 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:40 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:40 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:40 polegeom kernel: ata2: EH complete
Feb  2 12:34:40 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:40 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:40 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:41 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:41 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:41 polegeom kernel: ata2: EH complete
Feb  2 12:34:41 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:41 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:41 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:41 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:41 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:41 polegeom kernel: ata2: EH complete
Feb  2 12:34:41 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:41 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:41 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:42 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:42 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:42 polegeom kernel: ata2: EH complete
Feb  2 12:34:42 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 12:34:42 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 12:34:42 polegeom kernel: ata2: soft resetting port
Feb  2 12:34:42 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 12:34:42 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 12:34:42 polegeom kernel: ata2: EH complete
Feb  2 12:34:42 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 12:34:42 polegeom kernel: sdb: Write Protect is off
Feb  2 12:34:42 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 12:34:42 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 12:34:42 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 12:34:42 polegeom kernel: sdb: Write Protect is off
Feb  2 12:34:42 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 12:34:42 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 13:47:27 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 13:47:27 polegeom kernel: sdb: Write Protect is off
Feb  2 13:47:27 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 13:47:27 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 13:47:27 polegeom kernel:  sdb: unknown partition table
Feb  2 13:50:04 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 13:50:04 polegeom kernel: sdb: Write Protect is off
Feb  2 13:50:04 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 13:50:04 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 13:50:04 polegeom kernel:  sdb: sdb1
Feb  2 13:53:32 polegeom kernel: SCSI device sdc: 1465149168 512-byte hdwr sectors (750156 MB)
Feb  2 13:53:32 polegeom kernel: sdc: Write Protect is off
Feb  2 13:53:32 polegeom kernel: sdc: Mode Sense: 38 00 00 00
Feb  2 13:53:32 polegeom kernel: sdc: assuming drive cache: write through
Feb  2 13:53:32 polegeom kernel:  sdc: sdc1
Feb  2 14:59:55 polegeom kernel: NTFS driver 2.1.27 [Flags: R/W MODULE].
Feb  2 14:59:55 polegeom kernel: NTFS volume version 3.1.
Feb  2 15:12:21 polegeom kernel: NTFS-fs error (device sda1): parse_options(): Unrecognized mount option user.
Feb  2 15:12:57 polegeom kernel: NTFS volume version 3.1.
Feb  2 15:33:23 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 15:33:23 polegeom kernel: EXT3 FS on dm-0, internal journal
Feb  2 15:33:23 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 15:33:40 polegeom kernel: NTFS volume version 3.1.
Feb  2 15:37:31 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 15:37:31 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c2c.
Feb  2 15:37:31 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 15:37:31 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c59.
Feb  2 15:37:31 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 15:37:31 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c2e.
Feb  2 15:37:31 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 15:37:31 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c2f.
Feb  2 15:37:42 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 15:37:42 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x7743.
Feb  2 15:38:45 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 15:38:45 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x15b5c.
Feb  2 15:46:45 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 15:46:45 polegeom kernel: EXT3 FS on dm-0, internal journal
Feb  2 15:46:45 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 15:49:35 polegeom kernel: NTFS volume version 3.1.
Feb  2 15:50:59 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 15:50:59 polegeom kernel: ata2.00: (BMDMA stat 0x1)
Feb  2 15:50:59 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x16 stat 0x40 err 0x0 (ATA bus error)
Feb  2 15:51:06 polegeom kernel: ata2: port is slow to respond, please be patient
Feb  2 15:51:29 polegeom kernel: ata2: port failed to respond (30 secs)
Feb  2 15:51:29 polegeom kernel: ata2: soft resetting port
Feb  2 15:51:30 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:51:30 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 15:51:30 polegeom kernel: ata2: EH complete
Feb  2 15:51:30 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:51:30 polegeom kernel: sdb: Write Protect is off
Feb  2 15:51:30 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:51:30 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 15:51:30 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 15:51:30 polegeom kernel: ata2.00: (BMDMA stat 0x0)
Feb  2 15:51:30 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x12 stat 0x51 err 0x84 (ATA bus error)
Feb  2 15:51:31 polegeom kernel: ata2: soft resetting port
Feb  2 15:51:32 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:51:32 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 15:51:32 polegeom kernel: ata2: EH complete
Feb  2 15:51:32 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:51:32 polegeom kernel: sdb: Write Protect is off
Feb  2 15:51:32 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:51:32 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 15:52:03 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 15:52:03 polegeom kernel: ata2.00: (BMDMA stat 0x1)
Feb  2 15:52:03 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x16 stat 0x40 err 0x0 (ATA bus error)
Feb  2 15:52:10 polegeom kernel: ata2: port is slow to respond, please be patient
Feb  2 15:52:33 polegeom kernel: ata2: port failed to respond (30 secs)
Feb  2 15:52:33 polegeom kernel: ata2: soft resetting port
Feb  2 15:52:33 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:52:33 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 15:52:33 polegeom kernel: ata2: EH complete
Feb  2 15:52:33 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:52:33 polegeom kernel: sdb: Write Protect is off
Feb  2 15:52:33 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:52:33 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 15:53:04 polegeom kernel: ata2.00: limiting speed to UDMA/100
Feb  2 15:53:35 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 15:53:35 polegeom kernel: ata2.00: (BMDMA stat 0x1)
Feb  2 15:53:35 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x16 stat 0x40 err 0x0 (ATA bus error)
Feb  2 15:53:35 polegeom kernel: ata2: port is slow to respond, please be patient
Feb  2 15:53:35 polegeom kernel: ata2: port failed to respond (30 secs)
Feb  2 15:53:35 polegeom kernel: ata2: soft resetting port
Feb  2 15:53:35 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:53:35 polegeom kernel: ata2.00: configured for UDMA/100
Feb  2 15:53:35 polegeom kernel: ata2: EH complete
Feb  2 15:53:35 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:53:35 polegeom kernel: sdb: Write Protect is off
Feb  2 15:53:35 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:53:35 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 15:53:36 polegeom kernel: ata2.00: limiting speed to UDMA/66
Feb  2 15:53:36 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 15:53:36 polegeom kernel: ata2.00: (BMDMA stat 0x0)
Feb  2 15:53:36 polegeom kernel: ata2.00: tag 0 cmd 0xca Emask 0x12 stat 0x51 err 0x84 (ATA bus error)
Feb  2 15:53:36 polegeom kernel: ata2: soft resetting port
Feb  2 15:53:36 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:53:36 polegeom kernel: ata2.00: configured for UDMA/66
Feb  2 15:53:36 polegeom kernel: ata2: EH complete
Feb  2 15:53:36 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:53:36 polegeom kernel: sdb: Write Protect is off
Feb  2 15:53:36 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:53:36 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 15:53:37 polegeom kernel: ata2.00: limiting speed to UDMA/44
Feb  2 15:53:37 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 15:53:37 polegeom kernel: ata2.00: (BMDMA stat 0x0)
Feb  2 15:53:37 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x12 stat 0x51 err 0x84 (ATA bus error)
Feb  2 15:53:37 polegeom kernel: ata2: soft resetting port
Feb  2 15:53:37 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:53:37 polegeom kernel: ata2.00: configured for UDMA/44
Feb  2 15:53:37 polegeom kernel: ata2: EH complete
Feb  2 15:53:37 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:53:37 polegeom kernel: sdb: Write Protect is off
Feb  2 15:53:37 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:53:37 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 15:54:34 polegeom kernel: ata2.00: limiting speed to UDMA/33
Feb  2 15:55:05 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 15:55:05 polegeom kernel: ata2.00: (BMDMA stat 0x1)
Feb  2 15:55:05 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x16 stat 0x40 err 0x0 (ATA bus error)
Feb  2 15:55:05 polegeom kernel: ata2: port is slow to respond, please be patient
Feb  2 15:55:05 polegeom kernel: ata2: port failed to respond (30 secs)
Feb  2 15:55:05 polegeom kernel: ata2: soft resetting port
Feb  2 15:55:05 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:55:05 polegeom kernel: ata2.00: configured for UDMA/33
Feb  2 15:55:05 polegeom kernel: ata2: EH complete
Feb  2 15:55:05 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:55:05 polegeom kernel: sdb: Write Protect is off
Feb  2 15:55:05 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:55:05 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 15:55:05 polegeom kernel: ata2.00: limiting speed to UDMA/25
Feb  2 15:55:05 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 15:55:05 polegeom kernel: ata2.00: (BMDMA stat 0x0)
Feb  2 15:55:05 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x12 stat 0x51 err 0x84 (ATA bus error)
Feb  2 15:55:06 polegeom kernel: ata2: soft resetting port
Feb  2 15:55:06 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:55:06 polegeom kernel: ata2.00: configured for UDMA/25
Feb  2 15:55:06 polegeom kernel: ata2: EH complete
Feb  2 15:55:06 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:55:06 polegeom kernel: sdb: Write Protect is off
Feb  2 15:55:06 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:55:06 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 15:55:38 polegeom kernel: ata2.00: limiting speed to UDMA/16
Feb  2 15:56:09 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 15:56:09 polegeom kernel: ata2.00: (BMDMA stat 0x1)
Feb  2 15:56:09 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x16 stat 0x40 err 0x0 (ATA bus error)
Feb  2 15:56:09 polegeom kernel: ata2: port is slow to respond, please be patient
Feb  2 15:56:09 polegeom kernel: ata2: port failed to respond (30 secs)
Feb  2 15:56:09 polegeom kernel: ata2: soft resetting port
Feb  2 15:56:09 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:56:09 polegeom kernel: ata2.00: configured for UDMA/16
Feb  2 15:56:09 polegeom kernel: ata2: EH complete
Feb  2 15:56:09 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:56:09 polegeom kernel: sdb: Write Protect is off
Feb  2 15:56:09 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:56:09 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 15:56:40 polegeom kernel: ata2.00: limiting speed to PIO4
Feb  2 15:57:13 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 15:57:13 polegeom kernel: ata2.00: (BMDMA stat 0x1)
Feb  2 15:57:13 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x16 stat 0x40 err 0x0 (ATA bus error)
Feb  2 15:57:13 polegeom kernel: ata2: port is slow to respond, please be patient
Feb  2 15:57:13 polegeom kernel: ata2: port failed to respond (30 secs)
Feb  2 15:57:13 polegeom kernel: ata2: soft resetting port
Feb  2 15:57:13 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 15:57:13 polegeom kernel: ata2.00: configured for PIO4
Feb  2 15:57:13 polegeom kernel: ata2: EH complete
Feb  2 15:57:13 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 15:57:13 polegeom kernel: sdb: Write Protect is off
Feb  2 15:57:13 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 15:57:13 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 16:49:13 polegeom kernel: Kernel logging (proc) stopped.
Feb  2 16:49:13 polegeom kernel: Kernel log daemon terminating.
Feb  2 16:49:53 polegeom kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
Feb  2 16:49:53 polegeom kernel: Linux version 2.6.18-6-486 (Debian 2.6.18.dfsg.1-23etch1) (dannf@debian.org) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 Fri Dec 12 16:18:30 UTC 2008
Feb  2 16:49:53 polegeom kernel: BIOS-provided physical RAM map:
Feb  2 16:49:53 polegeom kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb  2 16:49:53 polegeom kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb  2 16:49:53 polegeom kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Feb  2 16:49:53 polegeom kernel:  BIOS-e820: 0000000000100000 - 000000003fffc000 (usable)
Feb  2 16:49:53 polegeom kernel:  BIOS-e820: 000000003fffc000 - 000000003ffff000 (ACPI data)
Feb  2 16:49:53 polegeom kernel:  BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
Feb  2 16:49:53 polegeom kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Feb  2 16:49:53 polegeom kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Feb  2 16:49:53 polegeom kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Feb  2 16:49:53 polegeom kernel: Warning only 896MB will be used.
Feb  2 16:49:53 polegeom kernel: Use a HIGHMEM enabled kernel.
Feb  2 16:49:53 polegeom kernel: 896MB LOWMEM available.
Feb  2 16:49:53 polegeom kernel: On node 0 totalpages: 229376
Feb  2 16:49:53 polegeom kernel:   DMA zone: 4096 pages, LIFO batch:0
Feb  2 16:49:53 polegeom kernel:   Normal zone: 225280 pages, LIFO batch:31
Feb  2 16:49:53 polegeom kernel: DMI 2.3 present.
Feb  2 16:49:53 polegeom kernel: ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5f50
Feb  2 16:49:53 polegeom kernel: ACPI: RSDT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc000
Feb  2 16:49:53 polegeom kernel: ACPI: FADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc0b2
Feb  2 16:49:53 polegeom kernel: ACPI: BOOT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc030
Feb  2 16:49:53 polegeom kernel: ACPI: MADT (v001 ASUS   A7V8X-X  0x42302e31 MSFT 0x31313031) @ 0x3fffc058
Feb  2 16:49:53 polegeom kernel: ACPI: DSDT (v001   ASUS A7V8X-X  0x00001000 MSFT 0x0100000b) @ 0x00000000
Feb  2 16:49:53 polegeom kernel: ACPI: PM-Timer IO Port: 0xe408
Feb  2 16:49:53 polegeom kernel: ACPI: Local APIC address 0xfee00000
Feb  2 16:49:53 polegeom kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Feb  2 16:49:53 polegeom kernel: Processor #0 6:10 APIC version 16
Feb  2 16:49:53 polegeom kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Feb  2 16:49:53 polegeom kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Feb  2 16:49:53 polegeom kernel: IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
Feb  2 16:49:53 polegeom kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
Feb  2 16:49:53 polegeom kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Feb  2 16:49:53 polegeom kernel: ACPI: IRQ0 used by override.
Feb  2 16:49:53 polegeom kernel: ACPI: IRQ2 used by override.
Feb  2 16:49:53 polegeom kernel: ACPI: IRQ9 used by override.
Feb  2 16:49:53 polegeom kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb  2 16:49:53 polegeom kernel: Using ACPI (MADT) for SMP configuration information
Feb  2 16:49:53 polegeom kernel: Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Feb  2 16:49:53 polegeom kernel: Detected 1916.544 MHz processor.
Feb  2 16:49:53 polegeom kernel: Built 1 zonelists.  Total pages: 229376
Feb  2 16:49:53 polegeom kernel: Kernel command line: root=/dev/hdb1 ro 
Feb  2 16:49:53 polegeom kernel: mapped APIC to ffffd000 (fee00000)
Feb  2 16:49:53 polegeom kernel: mapped IOAPIC to ffffc000 (fec00000)
Feb  2 16:49:53 polegeom kernel: Enabling fast FPU save and restore... done.
Feb  2 16:49:53 polegeom kernel: Enabling unmasked SIMD FPU exception support... done.
Feb  2 16:49:53 polegeom kernel: Initializing CPU#0
Feb  2 16:49:53 polegeom kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Feb  2 16:49:53 polegeom kernel: Console: colour VGA+ 80x25
Feb  2 16:49:53 polegeom kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb  2 16:49:53 polegeom kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb  2 16:49:53 polegeom kernel: Memory: 902096k/917504k available (1501k kernel code, 14816k reserved, 601k data, 256k init, 0k highmem)
Feb  2 16:49:53 polegeom kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb  2 16:49:53 polegeom kernel: Calibrating delay using timer specific routine.. 3836.29 BogoMIPS (lpj=7672597)
Feb  2 16:49:53 polegeom kernel: Security Framework v1.0.0 initialized
Feb  2 16:49:53 polegeom kernel: SELinux:  Disabled at boot.
Feb  2 16:49:53 polegeom kernel: Capability LSM initialized
Feb  2 16:49:53 polegeom kernel: Mount-cache hash table entries: 512
Feb  2 16:49:53 polegeom kernel: CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
Feb  2 16:49:53 polegeom kernel: CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
Feb  2 16:49:53 polegeom kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb  2 16:49:53 polegeom kernel: CPU: L2 Cache: 512K (64 bytes/line)
Feb  2 16:49:53 polegeom kernel: CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000
Feb  2 16:49:53 polegeom kernel: Compat vDSO mapped to ffffe000.
Feb  2 16:49:53 polegeom kernel: CPU: AMD Athlon(TM) XP 2600+ stepping 00
Feb  2 16:49:53 polegeom kernel: Checking 'hlt' instruction... OK.
Feb  2 16:49:53 polegeom kernel: ACPI: Core revision 20060707
Feb  2 16:49:53 polegeom kernel: ENABLING IO-APIC IRQs
Feb  2 16:49:53 polegeom kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Feb  2 16:49:53 polegeom kernel: checking if image is initramfs... it is
Feb  2 16:49:53 polegeom kernel: Freeing initrd memory: 4232k freed
Feb  2 16:49:53 polegeom kernel: NET: Registered protocol family 16
Feb  2 16:49:53 polegeom kernel: EISA bus registered
Feb  2 16:49:53 polegeom kernel: ACPI: bus type pci registered
Feb  2 16:49:53 polegeom kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1990, last bus=1
Feb  2 16:49:53 polegeom kernel: PCI: Using configuration type 1
Feb  2 16:49:53 polegeom kernel: Setting up standard PCI resources
Feb  2 16:49:53 polegeom kernel: ACPI: Interpreter enabled
Feb  2 16:49:53 polegeom kernel: ACPI: Using IOAPIC for interrupt routing
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12)
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12)
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb  2 16:49:53 polegeom kernel: PCI: Probing PCI hardware (bus 00)
Feb  2 16:49:53 polegeom kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Feb  2 16:49:53 polegeom kernel: PCI quirk: region e400-e47f claimed by vt8235 PM
Feb  2 16:49:53 polegeom kernel: PCI quirk: region e800-e80f claimed by vt8235 SMB
Feb  2 16:49:53 polegeom kernel: Boot video device is 0000:01:00.0
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Feb  2 16:49:53 polegeom kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb  2 16:49:53 polegeom kernel: pnp: PnP ACPI init
Feb  2 16:49:53 polegeom kernel: pnp: PnP ACPI: found 16 devices
Feb  2 16:49:53 polegeom kernel: PnPBIOS: Disabled by ACPI PNP
Feb  2 16:49:53 polegeom kernel: PCI: Using ACPI for IRQ routing
Feb  2 16:49:53 polegeom kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Feb  2 16:49:53 polegeom kernel: pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
Feb  2 16:49:53 polegeom kernel: pnp: 00:02: ioport range 0xe800-0xe81f could not be reserved
Feb  2 16:49:53 polegeom kernel: pnp: 00:0f: ioport range 0x290-0x297 has been reserved
Feb  2 16:49:53 polegeom kernel: pnp: 00:0f: ioport range 0x370-0x375 has been reserved
Feb  2 16:49:53 polegeom kernel: PCI: Bridge: 0000:00:01.0
Feb  2 16:49:53 polegeom kernel:   IO window: disabled.
Feb  2 16:49:53 polegeom kernel:   MEM window: ee000000-efdfffff
Feb  2 16:49:53 polegeom kernel:   PREFETCH window: eff00000-f7ffffff
Feb  2 16:49:53 polegeom kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Feb  2 16:49:53 polegeom kernel: NET: Registered protocol family 2
Feb  2 16:49:53 polegeom kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb  2 16:49:53 polegeom kernel: TCP established hash table entries: 131072 (order: 7, 524288 bytes)
Feb  2 16:49:53 polegeom kernel: TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
Feb  2 16:49:53 polegeom kernel: TCP: Hash tables configured (established 131072 bind 65536)
Feb  2 16:49:53 polegeom kernel: TCP reno registered
Feb  2 16:49:53 polegeom kernel: Simple Boot Flag at 0x3a set to 0x1
Feb  2 16:49:53 polegeom kernel: audit: initializing netlink socket (disabled)
Feb  2 16:49:53 polegeom kernel: audit(1233589775.788:1): initialized
Feb  2 16:49:53 polegeom kernel: VFS: Disk quotas dquot_6.5.1
Feb  2 16:49:53 polegeom kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Feb  2 16:49:53 polegeom kernel: Initializing Cryptographic API
Feb  2 16:49:53 polegeom kernel: io scheduler noop registered
Feb  2 16:49:53 polegeom kernel: io scheduler anticipatory registered
Feb  2 16:49:53 polegeom kernel: io scheduler deadline registered
Feb  2 16:49:53 polegeom kernel: io scheduler cfq registered (default)
Feb  2 16:49:53 polegeom kernel: isapnp: Scanning for PnP cards...
Feb  2 16:49:53 polegeom kernel: isapnp: No Plug & Play device found
Feb  2 16:49:53 polegeom kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Feb  2 16:49:53 polegeom kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  2 16:49:53 polegeom kernel: 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  2 16:49:53 polegeom kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Feb  2 16:49:53 polegeom kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Feb  2 16:49:53 polegeom kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  2 16:49:53 polegeom kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  2 16:49:53 polegeom kernel: mice: PS/2 mouse device common for all mice
Feb  2 16:49:53 polegeom kernel: EISA: Probing bus 0 at eisa.0
Feb  2 16:49:53 polegeom kernel: EISA: Detected 0 cards.
Feb  2 16:49:53 polegeom kernel: TCP bic registered
Feb  2 16:49:53 polegeom kernel: NET: Registered protocol family 1
Feb  2 16:49:53 polegeom kernel: NET: Registered protocol family 17
Feb  2 16:49:53 polegeom kernel: NET: Registered protocol family 8
Feb  2 16:49:53 polegeom kernel: NET: Registered protocol family 20
Feb  2 16:49:53 polegeom kernel: Using IPI Shortcut mode
Feb  2 16:49:53 polegeom kernel: ACPI: (supports S0 S1 S4 S5)
Feb  2 16:49:53 polegeom kernel: Time: tsc clocksource has been installed.
Feb  2 16:49:53 polegeom kernel: Freeing unused kernel memory: 256k freed
Feb  2 16:49:53 polegeom kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Feb  2 16:49:53 polegeom kernel: SCSI subsystem initialized
Feb  2 16:49:53 polegeom kernel: usbcore: registered new driver usbfs
Feb  2 16:49:53 polegeom kernel: usbcore: registered new driver hub
Feb  2 16:49:53 polegeom kernel: USB Universal Host Controller Interface driver v3.0
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 169
Feb  2 16:49:53 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:10.0, from 0 to 9
Feb  2 16:49:53 polegeom kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Feb  2 16:49:53 polegeom kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
Feb  2 16:49:53 polegeom kernel: uhci_hcd 0000:00:10.0: irq 169, io base 0x0000a800
Feb  2 16:49:53 polegeom kernel: usb usb1: configuration #1 chosen from 1 choice
Feb  2 16:49:53 polegeom kernel: hub 1-0:1.0: USB hub found
Feb  2 16:49:53 polegeom kernel: hub 1-0:1.0: 2 ports detected
Feb  2 16:49:53 polegeom kernel: libata version 2.00 loaded.
Feb  2 16:49:53 polegeom kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb  2 16:49:53 polegeom kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb  2 16:49:53 polegeom kernel: via-rhine.c:v1.10-LK1.4.1 July-24-2006 Written by Donald Becker
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 169
Feb  2 16:49:53 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:10.1, from 0 to 9
Feb  2 16:49:53 polegeom kernel: uhci_hcd 0000:00:10.1: UHCI Host Controller
Feb  2 16:49:53 polegeom kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
Feb  2 16:49:53 polegeom kernel: uhci_hcd 0000:00:10.1: irq 169, io base 0x0000a400
Feb  2 16:49:53 polegeom kernel: usb usb2: configuration #1 chosen from 1 choice
Feb  2 16:49:53 polegeom kernel: hub 2-0:1.0: USB hub found
Feb  2 16:49:53 polegeom kernel: hub 2-0:1.0: 2 ports detected
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 169
Feb  2 16:49:53 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:10.2, from 0 to 9
Feb  2 16:49:53 polegeom kernel: uhci_hcd 0000:00:10.2: UHCI Host Controller
Feb  2 16:49:53 polegeom kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
Feb  2 16:49:53 polegeom kernel: uhci_hcd 0000:00:10.2: irq 169, io base 0x0000a000
Feb  2 16:49:53 polegeom kernel: usb usb3: configuration #1 chosen from 1 choice
Feb  2 16:49:53 polegeom kernel: hub 3-0:1.0: USB hub found
Feb  2 16:49:53 polegeom kernel: hub 3-0:1.0: 2 ports detected
Feb  2 16:49:53 polegeom kernel: sata_via 0000:00:0b.0: version 2.0
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 177
Feb  2 16:49:53 polegeom kernel: sata_via 0000:00:0b.0: routed to hard irq line 3
Feb  2 16:49:53 polegeom kernel: ata1: SATA max UDMA/133 cmd 0xD800 ctl 0xD80A bmdma 0xB400 irq 177
Feb  2 16:49:53 polegeom kernel: ata2: SATA max UDMA/133 cmd 0xD400 ctl 0xD40A bmdma 0xB408 irq 177
Feb  2 16:49:53 polegeom kernel: scsi0 : sata_via
Feb  2 16:49:53 polegeom kernel: usb 2-1: new full speed USB device using uhci_hcd and address 2
Feb  2 16:49:53 polegeom kernel: usb 2-1: configuration #1 chosen from 1 choice
Feb  2 16:49:53 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:49:53 polegeom kernel: ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
Feb  2 16:49:53 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 16:49:53 polegeom kernel: scsi1 : sata_via
Feb  2 16:49:53 polegeom kernel: Initializing USB Mass Storage driver...
Feb  2 16:49:53 polegeom kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Feb  2 16:49:53 polegeom kernel: usbcore: registered new driver usb-storage
Feb  2 16:49:53 polegeom kernel: USB Mass Storage support registered.
Feb  2 16:49:53 polegeom kernel: usb-storage: device found at 2
Feb  2 16:49:53 polegeom kernel: usb-storage: waiting for device to settle before scanning
Feb  2 16:49:53 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:49:53 polegeom kernel: ata2.00: ATA-8, max UDMA7, 976773168 sectors: LBA48 NCQ (depth 0/32)
Feb  2 16:49:53 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 16:49:53 polegeom kernel:   Vendor: ATA       Model: ST3250824AS       Rev: 3.AA
Feb  2 16:49:53 polegeom kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Feb  2 16:49:53 polegeom kernel:   Vendor: ATA       Model: SAMSUNG HD501LJ   Rev: CR10
Feb  2 16:49:53 polegeom kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 169
Feb  2 16:49:53 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:10.3, from 0 to 9
Feb  2 16:49:53 polegeom kernel: ehci_hcd 0000:00:10.3: EHCI Host Controller
Feb  2 16:49:53 polegeom kernel: ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
Feb  2 16:49:53 polegeom kernel: ehci_hcd 0000:00:10.3: irq 169, io mem 0xed800000
Feb  2 16:49:53 polegeom kernel: ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Feb  2 16:49:53 polegeom kernel: usb usb4: configuration #1 chosen from 1 choice
Feb  2 16:49:53 polegeom kernel: hub 4-0:1.0: USB hub found
Feb  2 16:49:53 polegeom kernel: hub 4-0:1.0: 6 ports detected
Feb  2 16:49:53 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 16:49:53 polegeom kernel: sda: Write Protect is off
Feb  2 16:49:53 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 16:49:53 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 16:49:53 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 16:49:53 polegeom kernel: sda: Write Protect is off
Feb  2 16:49:53 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 16:49:53 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 16:49:53 polegeom kernel:  sda: [LDM] sda1
Feb  2 16:49:53 polegeom kernel: sd 0:0:0:0: Attached scsi disk sda
Feb  2 16:49:53 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 16:49:53 polegeom kernel: sdb: Write Protect is off
Feb  2 16:49:53 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 16:49:53 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 16:49:53 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 16:49:53 polegeom kernel: sdb: Write Protect is off
Feb  2 16:49:53 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 16:49:53 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 16:49:53 polegeom kernel:  sdb:<6>VP_IDE: IDE controller at PCI slot 0000:00:11.1
Feb  2 16:49:53 polegeom kernel: ACPI: Unable to derive IRQ for device 0000:00:11.1
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt 0000:00:11.1[A]: no GSI
Feb  2 16:49:53 polegeom kernel: PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 15
Feb  2 16:49:53 polegeom kernel: VP_IDE: chipset revision 6
Feb  2 16:49:53 polegeom kernel: VP_IDE: not 100%% native mode: will probe irqs later
Feb  2 16:49:53 polegeom kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Feb  2 16:49:53 polegeom kernel:     ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:pio, hdb:DMA
Feb  2 16:49:53 polegeom kernel:     ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
Feb  2 16:49:53 polegeom kernel: Probing IDE interface ide0...
Feb  2 16:49:53 polegeom kernel:  sdb1
Feb  2 16:49:53 polegeom kernel: sd 1:0:0:0: Attached scsi disk sdb
Feb  2 16:49:53 polegeom kernel: usb 4-3: new high speed USB device using ehci_hcd and address 2
Feb  2 16:49:53 polegeom kernel: usb 4-3: configuration #1 chosen from 1 choice
Feb  2 16:49:53 polegeom kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Feb  2 16:49:53 polegeom kernel: usb-storage: device found at 2
Feb  2 16:49:53 polegeom kernel: usb-storage: waiting for device to settle before scanning
Feb  2 16:49:53 polegeom kernel: usb 2-1: USB disconnect, address 2
Feb  2 16:49:53 polegeom kernel: hdb: ST380215A, ATA DISK drive
Feb  2 16:49:53 polegeom kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  2 16:49:53 polegeom kernel: Probing IDE interface ide1...
Feb  2 16:49:53 polegeom kernel: hdc: SONY DVD-ROM DDU1612, ATAPI CD/DVD-ROM drive
Feb  2 16:49:53 polegeom kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 185
Feb  2 16:49:53 polegeom kernel: eth0: VIA Rhine II at 0x19400, 00:0e:a6:6a:1c:1f, IRQ 185.
Feb  2 16:49:53 polegeom kernel: eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link c5e1.
Feb  2 16:49:53 polegeom kernel: hdb: max request size: 512KiB
Feb  2 16:49:53 polegeom kernel: hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
Feb  2 16:49:53 polegeom kernel: hdb: cache flushes supported
Feb  2 16:49:53 polegeom kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 >
Feb  2 16:49:53 polegeom kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Feb  2 16:49:53 polegeom kernel: Uniform CD-ROM driver Revision: 3.20
Feb  2 16:49:53 polegeom kernel: Attempting manual resume
Feb  2 16:49:53 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 16:49:53 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 16:49:53 polegeom kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Feb  2 16:49:53 polegeom kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Feb  2 16:49:53 polegeom kernel: input: PC Speaker as /class/input/input1
Feb  2 16:49:53 polegeom kernel: Linux agpgart interface v0.101 (c) Dave Jones
Feb  2 16:49:53 polegeom kernel: agpgart: Detected VIA KT400/KT400A/KT600 chipset
Feb  2 16:49:53 polegeom kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Feb  2 16:49:53 polegeom kernel: Real Time Clock Driver v1.12ac
Feb  2 16:49:53 polegeom kernel: Floppy drive(s): fd0 is 1.44M
Feb  2 16:49:53 polegeom kernel: FDC 0 is a post-1991 82077
Feb  2 16:49:53 polegeom kernel: parport: PnPBIOS parport detected.
Feb  2 16:49:53 polegeom kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Feb  2 16:49:53 polegeom kernel: irda_init()
Feb  2 16:49:53 polegeom kernel: NET: Registered protocol family 23
Feb  2 16:49:53 polegeom kernel: input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
Feb  2 16:49:53 polegeom kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 193
Feb  2 16:49:53 polegeom kernel: PCI: Setting latency timer of device 0000:00:11.5 to 64
Feb  2 16:49:53 polegeom kernel: ts: Compaq touchscreen protocol output
Feb  2 16:49:53 polegeom kernel:   Vendor: SAMSUNG   Model: HD753LJ           Rev:     
Feb  2 16:49:53 polegeom kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Feb  2 16:49:53 polegeom kernel: SCSI device sdc: 1465149168 512-byte hdwr sectors (750156 MB)
Feb  2 16:49:53 polegeom kernel: sdc: Write Protect is off
Feb  2 16:49:53 polegeom kernel: sdc: Mode Sense: 38 00 00 00
Feb  2 16:49:53 polegeom kernel: sdc: assuming drive cache: write through
Feb  2 16:49:53 polegeom kernel: SCSI device sdc: 1465149168 512-byte hdwr sectors (750156 MB)
Feb  2 16:49:53 polegeom kernel: sdc: Write Protect is off
Feb  2 16:49:53 polegeom kernel: sdc: Mode Sense: 38 00 00 00
Feb  2 16:49:53 polegeom kernel: sdc: assuming drive cache: write through
Feb  2 16:49:53 polegeom kernel:  sdc:<3>codec_read: codec 0 is not valid [0x107e5370]
Feb  2 16:49:53 polegeom kernel: codec_read: codec 0 is not valid [0x107e5370]
Feb  2 16:49:53 polegeom last message repeated 2 times
Feb  2 16:49:53 polegeom kernel: Adding 7992k swap on /dev/hdb6.  Priority:-1 extents:1 across:7992k
Feb  2 16:49:53 polegeom kernel: EXT3 FS on hdb1, internal journal
Feb  2 16:49:53 polegeom kernel: loop: loaded (max 8 devices)
Feb  2 16:49:53 polegeom kernel: device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
Feb  2 16:49:53 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 16:49:53 polegeom kernel: EXT3 FS on hdb3, internal journal
Feb  2 16:49:53 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 16:49:53 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 16:49:53 polegeom kernel: EXT3 FS on hdb2, internal journal
Feb  2 16:49:53 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 16:49:53 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 16:49:53 polegeom kernel: EXT3 FS on hdb5, internal journal
Feb  2 16:49:53 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 16:49:53 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 16:49:53 polegeom kernel: EXT3 FS on hdb7, internal journal
Feb  2 16:49:53 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 16:49:53 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 16:49:53 polegeom kernel: EXT3 FS on dm-0, internal journal
Feb  2 16:49:53 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 16:49:53 polegeom kernel: eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
Feb  2 16:49:53 polegeom kernel:  sdc1
Feb  2 16:49:53 polegeom kernel: sd 3:0:0:0: Attached scsi disk sdc
Feb  2 16:49:53 polegeom kernel: usb-storage: device scan complete
Feb  2 16:50:00 polegeom kernel: NET: Registered protocol family 10
Feb  2 16:50:00 polegeom kernel: lo: Disabled Privacy Extensions
Feb  2 16:50:00 polegeom kernel: IPv6 over IPv4 tunneling driver
Feb  2 16:50:00 polegeom kernel: ACPI: Power Button (FF) [PWRF]
Feb  2 16:50:00 polegeom kernel: ACPI: Power Button (CM) [PWRB]
Feb  2 16:50:05 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:05 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:05 polegeom kernel: ata1: soft resetting port
Feb  2 16:50:05 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:05 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 16:50:05 polegeom kernel: ata1: EH complete
Feb  2 16:50:05 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:05 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:06 polegeom kernel: ata1: soft resetting port
Feb  2 16:50:06 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:06 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 16:50:06 polegeom kernel: ata1: EH complete
Feb  2 16:50:06 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:06 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:06 polegeom kernel: ata1: soft resetting port
Feb  2 16:50:06 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:06 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 16:50:06 polegeom kernel: ata1: EH complete
Feb  2 16:50:06 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:06 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:07 polegeom kernel: ata1: soft resetting port
Feb  2 16:50:07 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:07 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 16:50:07 polegeom kernel: ata1: EH complete
Feb  2 16:50:07 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:07 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:07 polegeom kernel: ata1: soft resetting port
Feb  2 16:50:07 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:07 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 16:50:07 polegeom kernel: ata1: EH complete
Feb  2 16:50:07 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:07 polegeom kernel: ata1.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:08 polegeom kernel: ata1: soft resetting port
Feb  2 16:50:08 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:08 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 16:50:08 polegeom kernel: ata1: EH complete
Feb  2 16:50:08 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 16:50:08 polegeom kernel: sda: Write Protect is off
Feb  2 16:50:08 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 16:50:08 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 16:50:08 polegeom kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
Feb  2 16:50:08 polegeom kernel: sda: Write Protect is off
Feb  2 16:50:08 polegeom kernel: sda: Mode Sense: 00 3a 00 00
Feb  2 16:50:08 polegeom kernel: SCSI device sda: drive cache: write back
Feb  2 16:50:08 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:08 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:08 polegeom kernel: ata2: soft resetting port
Feb  2 16:50:08 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:08 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 16:50:08 polegeom kernel: ata2: EH complete
Feb  2 16:50:08 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:08 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:09 polegeom kernel: ata2: soft resetting port
Feb  2 16:50:09 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:09 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 16:50:09 polegeom kernel: ata2: EH complete
Feb  2 16:50:09 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:09 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:09 polegeom kernel: ata2: soft resetting port
Feb  2 16:50:09 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:09 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 16:50:09 polegeom kernel: ata2: EH complete
Feb  2 16:50:09 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:09 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:10 polegeom kernel: ata2: soft resetting port
Feb  2 16:50:10 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:10 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 16:50:10 polegeom kernel: ata2: EH complete
Feb  2 16:50:10 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:10 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:10 polegeom kernel: ata2: soft resetting port
Feb  2 16:50:10 polegeom kernel: eth0: no IPv6 routers present
Feb  2 16:50:10 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:10 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 16:50:10 polegeom kernel: ata2: EH complete
Feb  2 16:50:10 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 16:50:10 polegeom kernel: ata2.00: tag 0 cmd 0xb0 Emask 0x2 stat 0x50 err 0x0 (HSM violation)
Feb  2 16:50:11 polegeom kernel: ata2: soft resetting port
Feb  2 16:50:11 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 16:50:11 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 16:50:11 polegeom kernel: ata2: EH complete
Feb  2 16:50:11 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 16:50:11 polegeom kernel: sdb: Write Protect is off
Feb  2 16:50:11 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 16:50:11 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 16:50:11 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 16:50:11 polegeom kernel: sdb: Write Protect is off
Feb  2 16:50:11 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 16:50:11 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 16:51:17 polegeom kernel: NTFS driver 2.1.27 [Flags: R/W MODULE].
Feb  2 16:51:17 polegeom kernel: NTFS volume version 3.1.
Feb  2 16:51:58 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 16:51:58 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c2c.
Feb  2 16:51:58 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 16:51:58 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c59.
Feb  2 16:51:58 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 16:51:58 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c2e.
Feb  2 16:51:58 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 16:51:58 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c2f.
Feb  2 17:05:29 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 17:05:30 polegeom kernel: ata2.00: (BMDMA stat 0x0)
Feb  2 17:05:30 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x12 stat 0x51 err 0x84 (ATA bus error)
Feb  2 17:05:30 polegeom kernel: ata2: soft resetting port
Feb  2 17:05:30 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:05:30 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:05:30 polegeom kernel: ata2: EH complete
Feb  2 17:05:30 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 17:05:30 polegeom kernel: sdb: Write Protect is off
Feb  2 17:05:30 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 17:05:30 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 17:06:05 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 17:06:36 polegeom kernel: ata2.00: (BMDMA stat 0x1)
Feb  2 17:06:36 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x16 stat 0x40 err 0x0 (ATA bus error)
Feb  2 17:06:36 polegeom kernel: ata2: port is slow to respond, please be patient
Feb  2 17:06:36 polegeom kernel: ata2: port failed to respond (30 secs)
Feb  2 17:06:36 polegeom kernel: ata2: soft resetting port
Feb  2 17:06:36 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:06:36 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:06:36 polegeom kernel: ata2: EH complete
Feb  2 17:06:36 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 17:06:36 polegeom kernel: sdb: Write Protect is off
Feb  2 17:06:36 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 17:06:36 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 17:06:36 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 17:06:36 polegeom kernel: ata2.00: (BMDMA stat 0x0)
Feb  2 17:06:36 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x12 stat 0x51 err 0x84 (ATA bus error)
Feb  2 17:06:36 polegeom kernel: ata2: soft resetting port
Feb  2 17:06:36 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:06:36 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:06:36 polegeom kernel: ata2: EH complete
Feb  2 17:06:36 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 17:06:36 polegeom kernel: sdb: Write Protect is off
Feb  2 17:06:36 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 17:06:36 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 17:07:06 polegeom kernel: ata2.00: limiting speed to UDMA/100
Feb  2 17:07:06 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 17:07:06 polegeom kernel: ata2.00: (BMDMA stat 0x1)
Feb  2 17:07:06 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x16 stat 0x40 err 0x0 (ATA bus error)
Feb  2 17:07:14 polegeom kernel: ata2: port is slow to respond, please be patient
Feb  2 17:07:37 polegeom kernel: ata2: port failed to respond (30 secs)
Feb  2 17:07:37 polegeom kernel: ata2: soft resetting port
Feb  2 17:07:37 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:07:37 polegeom kernel: ata2.00: configured for UDMA/100
Feb  2 17:07:37 polegeom kernel: ata2: EH complete
Feb  2 17:07:37 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 17:07:37 polegeom kernel: sdb: Write Protect is off
Feb  2 17:07:37 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 17:07:37 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 17:07:37 polegeom kernel: ata2.00: limiting speed to UDMA/66
Feb  2 17:07:37 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 17:07:37 polegeom kernel: ata2.00: (BMDMA stat 0x0)
Feb  2 17:07:37 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x12 stat 0x51 err 0x84 (ATA bus error)
Feb  2 17:07:38 polegeom kernel: ata2: soft resetting port
Feb  2 17:07:38 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:07:38 polegeom kernel: ata2.00: configured for UDMA/66
Feb  2 17:07:38 polegeom kernel: ata2: EH complete
Feb  2 17:07:38 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 17:07:38 polegeom kernel: sdb: Write Protect is off
Feb  2 17:07:38 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 17:07:38 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 17:08:09 polegeom kernel: ata2.00: limiting speed to UDMA/44
Feb  2 17:08:09 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 17:08:09 polegeom kernel: ata2.00: (BMDMA stat 0x1)
Feb  2 17:08:09 polegeom kernel: ata2.00: tag 0 cmd 0x35 Emask 0x16 stat 0x40 err 0x0 (ATA bus error)
Feb  2 17:08:16 polegeom kernel: ata2: port is slow to respond, please be patient
Feb  2 17:08:39 polegeom kernel: ata2: port failed to respond (30 secs)
Feb  2 17:08:39 polegeom kernel: ata2: soft resetting port
Feb  2 17:08:40 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:08:40 polegeom kernel: ata2.00: configured for UDMA/44
Feb  2 17:08:40 polegeom kernel: ata2: EH complete
Feb  2 17:08:40 polegeom kernel: SCSI device sdb: 976773168 512-byte hdwr sectors (500108 MB)
Feb  2 17:08:40 polegeom kernel: sdb: Write Protect is off
Feb  2 17:08:40 polegeom kernel: sdb: Mode Sense: 00 3a 00 00
Feb  2 17:08:40 polegeom kernel: SCSI device sdb: drive cache: write back
Feb  2 17:17:24 polegeom kernel: Kernel logging (proc) stopped.
Feb  2 17:17:24 polegeom kernel: Kernel log daemon terminating.
Feb  2 17:18:02 polegeom kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
Feb  2 17:18:02 polegeom kernel: SUS A7V8X-X      1000 MSFT  100000B)
Feb  2 17:18:02 polegeom kernel: ACPI: FACS 3FFFF000, 0040
Feb  2 17:18:02 polegeom kernel: ACPI: BOOT 3FFFC030, 0028 (r1 ASUS   A7V8X-X  42302E31 MSFT 31313031)
Feb  2 17:18:02 polegeom kernel: ACPI: APIC 3FFFC058, 005A (r1 ASUS   A7V8X-X  42302E31 MSFT 31313031)
Feb  2 17:18:02 polegeom kernel: ACPI: PM-Timer IO Port: 0xe408
Feb  2 17:18:02 polegeom kernel: ACPI: Local APIC address 0xfee00000
Feb  2 17:18:02 polegeom kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Feb  2 17:18:02 polegeom kernel: Processor #0 6:10 APIC version 16
Feb  2 17:18:02 polegeom kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Feb  2 17:18:02 polegeom kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Feb  2 17:18:02 polegeom kernel: IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
Feb  2 17:18:02 polegeom kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
Feb  2 17:18:02 polegeom kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Feb  2 17:18:02 polegeom kernel: ACPI: IRQ0 used by override.
Feb  2 17:18:02 polegeom kernel: ACPI: IRQ2 used by override.
Feb  2 17:18:02 polegeom kernel: ACPI: IRQ9 used by override.
Feb  2 17:18:02 polegeom kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb  2 17:18:02 polegeom kernel: Using ACPI (MADT) for SMP configuration information
Feb  2 17:18:02 polegeom kernel: Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Feb  2 17:18:02 polegeom kernel: swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
Feb  2 17:18:02 polegeom kernel: swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000f0000
Feb  2 17:18:02 polegeom kernel: swsusp: Registered nosave memory region: 00000000000f0000 - 0000000000100000
Feb  2 17:18:02 polegeom kernel: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 227584
Feb  2 17:18:02 polegeom kernel: Kernel command line: root=/dev/hdb1 ro 
Feb  2 17:18:02 polegeom kernel: mapped APIC to ffffb000 (fee00000)
Feb  2 17:18:02 polegeom kernel: mapped IOAPIC to ffffa000 (fec00000)
Feb  2 17:18:02 polegeom kernel: Enabling fast FPU save and restore... done.
Feb  2 17:18:02 polegeom kernel: Enabling unmasked SIMD FPU exception support... done.
Feb  2 17:18:02 polegeom kernel: Initializing CPU#0
Feb  2 17:18:02 polegeom kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Feb  2 17:18:02 polegeom kernel: Detected 1916.544 MHz processor.
Feb  2 17:18:02 polegeom kernel: Console: colour VGA+ 80x25
Feb  2 17:18:02 polegeom kernel: console [tty0] enabled
Feb  2 17:18:02 polegeom kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb  2 17:18:02 polegeom kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb  2 17:18:02 polegeom kernel: Memory: 900744k/917504k available (1753k kernel code, 16212k reserved, 721k data, 324k init, 0k highmem)
Feb  2 17:18:02 polegeom kernel: virtual kernel memory layout:
Feb  2 17:18:02 polegeom kernel:     fixmap  : 0xfffb3000 - 0xfffff000   ( 304 kB)
Feb  2 17:18:02 polegeom kernel:     vmalloc : 0xf8800000 - 0xfffb1000   ( 119 MB)
Feb  2 17:18:02 polegeom kernel:     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
Feb  2 17:18:02 polegeom kernel:       .init : 0xc036e000 - 0xc03bf000   ( 324 kB)
Feb  2 17:18:02 polegeom kernel:       .data : 0xc02b6735 - 0xc036ade4   ( 721 kB)
Feb  2 17:18:02 polegeom kernel:       .text : 0xc0100000 - 0xc02b6735   (1753 kB)
Feb  2 17:18:02 polegeom kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb  2 17:18:02 polegeom kernel: Calibrating delay using timer specific routine.. 3836.46 BogoMIPS (lpj=7672937)
Feb  2 17:18:02 polegeom kernel: Security Framework initialized
Feb  2 17:18:02 polegeom kernel: SELinux:  Disabled at boot.
Feb  2 17:18:02 polegeom kernel: Capability LSM initialized
Feb  2 17:18:02 polegeom kernel: Mount-cache hash table entries: 512
Feb  2 17:18:02 polegeom kernel: Initializing cgroup subsys ns
Feb  2 17:18:02 polegeom kernel: Initializing cgroup subsys cpuacct
Feb  2 17:18:02 polegeom kernel: CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000 00000000
Feb  2 17:18:02 polegeom kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb  2 17:18:02 polegeom kernel: CPU: L2 Cache: 512K (64 bytes/line)
Feb  2 17:18:02 polegeom kernel: CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000 00000000
Feb  2 17:18:02 polegeom kernel: Compat vDSO mapped to ffffe000.
Feb  2 17:18:02 polegeom kernel: CPU: AMD Athlon(TM) XP 2600+ stepping 00
Feb  2 17:18:02 polegeom kernel: Checking 'hlt' instruction... OK.
Feb  2 17:18:02 polegeom kernel: Freeing SMP alternatives: 0k freed
Feb  2 17:18:02 polegeom kernel: ACPI: Core revision 20070126
Feb  2 17:18:02 polegeom kernel: ENABLING IO-APIC IRQs
Feb  2 17:18:02 polegeom kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Feb  2 17:18:02 polegeom kernel: net_namespace: 64 bytes
Feb  2 17:18:02 polegeom kernel: Booting paravirtualized kernel on bare hardware
Feb  2 17:18:02 polegeom kernel: NET: Registered protocol family 16
Feb  2 17:18:02 polegeom kernel: EISA bus registered
Feb  2 17:18:02 polegeom kernel: ACPI: bus type pci registered
Feb  2 17:18:02 polegeom kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1990, last bus=1
Feb  2 17:18:02 polegeom kernel: PCI: Using configuration type 1
Feb  2 17:18:02 polegeom kernel: Setting up standard PCI resources
Feb  2 17:18:02 polegeom kernel: ACPI: EC: Look up EC in DSDT
Feb  2 17:18:02 polegeom kernel: ACPI: Interpreter enabled
Feb  2 17:18:02 polegeom kernel: ACPI: (supports S0 S1 S4 S5)
Feb  2 17:18:02 polegeom kernel: ACPI: Using IOAPIC for interrupt routing
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb  2 17:18:02 polegeom kernel: PCI quirk: region e400-e47f claimed by vt8235 PM
Feb  2 17:18:02 polegeom kernel: PCI quirk: region e800-e80f claimed by vt8235 SMB
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12)
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12)
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Feb  2 17:18:02 polegeom kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb  2 17:18:02 polegeom kernel: pnp: PnP ACPI init
Feb  2 17:18:02 polegeom kernel: ACPI: bus type pnp registered
Feb  2 17:18:02 polegeom kernel: pnp: PnP ACPI: found 16 devices
Feb  2 17:18:02 polegeom kernel: ACPI: ACPI bus type pnp unregistered
Feb  2 17:18:02 polegeom kernel: PnPBIOS: Disabled by ACPI PNP
Feb  2 17:18:02 polegeom kernel: PCI: Using ACPI for IRQ routing
Feb  2 17:18:02 polegeom kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Feb  2 17:18:02 polegeom kernel: NET: Registered protocol family 8
Feb  2 17:18:02 polegeom kernel: NET: Registered protocol family 20
Feb  2 17:18:02 polegeom kernel: ACPI: RTC can wake from S4
Feb  2 17:18:02 polegeom kernel: Time: tsc clocksource has been installed.
Feb  2 17:18:02 polegeom kernel: system 00:00: iomem range 0x0-0x9ffff could not be reserved
Feb  2 17:18:02 polegeom kernel: system 00:00: iomem range 0xf0000-0xfffff could not be reserved
Feb  2 17:18:02 polegeom kernel: system 00:00: iomem range 0x100000-0x3fffffff could not be reserved
Feb  2 17:18:02 polegeom kernel: system 00:00: iomem range 0xfec00000-0xfec000ff could not be reserved
Feb  2 17:18:02 polegeom kernel: system 00:00: iomem range 0xfee00000-0xfee00fff could not be reserved
Feb  2 17:18:02 polegeom kernel: system 00:02: ioport range 0xe400-0xe47f has been reserved
Feb  2 17:18:02 polegeom kernel: system 00:02: ioport range 0xe800-0xe81f could not be reserved
Feb  2 17:18:02 polegeom kernel: system 00:02: iomem range 0xfff80000-0xffffffff could not be reserved
Feb  2 17:18:02 polegeom kernel: system 00:02: iomem range 0xffb80000-0xffbfffff has been reserved
Feb  2 17:18:02 polegeom kernel: system 00:03: ioport range 0x4d0-0x4d1 has been reserved
Feb  2 17:18:02 polegeom kernel: system 00:0f: ioport range 0x290-0x297 has been reserved
Feb  2 17:18:02 polegeom kernel: system 00:0f: ioport range 0x370-0x375 has been reserved
Feb  2 17:18:02 polegeom kernel: PCI: Bridge: 0000:00:01.0
Feb  2 17:18:02 polegeom kernel:   IO window: disabled.
Feb  2 17:18:02 polegeom kernel:   MEM window: ee000000-efdfffff
Feb  2 17:18:02 polegeom kernel:   PREFETCH window: eff00000-f7ffffff
Feb  2 17:18:02 polegeom kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Feb  2 17:18:02 polegeom kernel: NET: Registered protocol family 2
Feb  2 17:18:02 polegeom kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb  2 17:18:02 polegeom kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Feb  2 17:18:02 polegeom kernel: TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
Feb  2 17:18:02 polegeom kernel: TCP: Hash tables configured (established 131072 bind 65536)
Feb  2 17:18:02 polegeom kernel: TCP reno registered
Feb  2 17:18:02 polegeom kernel: checking if image is initramfs... it is
Feb  2 17:18:02 polegeom kernel: Switched to high resolution mode on CPU 0
Feb  2 17:18:02 polegeom kernel: Freeing initrd memory: 5179k freed
Feb  2 17:18:02 polegeom kernel: Simple Boot Flag at 0x3a set to 0x1
Feb  2 17:18:02 polegeom kernel: audit: initializing netlink socket (disabled)
Feb  2 17:18:02 polegeom kernel: audit(1233591466.732:1): initialized
Feb  2 17:18:02 polegeom kernel: Total HugeTLB memory allocated, 0
Feb  2 17:18:02 polegeom kernel: VFS: Disk quotas dquot_6.5.1
Feb  2 17:18:02 polegeom kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Feb  2 17:18:02 polegeom kernel: io scheduler noop registered
Feb  2 17:18:02 polegeom kernel: io scheduler anticipatory registered
Feb  2 17:18:02 polegeom kernel: io scheduler deadline registered
Feb  2 17:18:02 polegeom kernel: io scheduler cfq registered (default)
Feb  2 17:18:02 polegeom kernel: PCI: VIA PCI bridge detected. Disabling DAC.
Feb  2 17:18:02 polegeom kernel: Boot video device is 0000:01:00.0
Feb  2 17:18:02 polegeom kernel: isapnp: Scanning for PnP cards...
Feb  2 17:18:02 polegeom kernel: isapnp: No Plug & Play device found
Feb  2 17:18:02 polegeom kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Feb  2 17:18:02 polegeom kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  2 17:18:02 polegeom kernel: 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  2 17:18:02 polegeom kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Feb  2 17:18:02 polegeom kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Feb  2 17:18:02 polegeom kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  2 17:18:02 polegeom kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  2 17:18:02 polegeom kernel: mice: PS/2 mouse device common for all mice
Feb  2 17:18:02 polegeom kernel: EISA: Probing bus 0 at eisa.0
Feb  2 17:18:02 polegeom kernel: EISA: Detected 0 cards.
Feb  2 17:18:02 polegeom kernel: cpuidle: using governor ladder
Feb  2 17:18:02 polegeom kernel: cpuidle: using governor menu
Feb  2 17:18:02 polegeom kernel: TCP bic registered
Feb  2 17:18:02 polegeom kernel: NET: Registered protocol family 1
Feb  2 17:18:02 polegeom kernel: NET: Registered protocol family 17
Feb  2 17:18:02 polegeom kernel: Using IPI Shortcut mode
Feb  2 17:18:02 polegeom kernel: registered taskstats version 1
Feb  2 17:18:02 polegeom kernel: Freeing unused kernel memory: 324k freed
Feb  2 17:18:02 polegeom kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Feb  2 17:18:02 polegeom kernel: SCSI subsystem initialized
Feb  2 17:18:02 polegeom kernel: usbcore: registered new interface driver usbfs
Feb  2 17:18:02 polegeom kernel: usbcore: registered new interface driver hub
Feb  2 17:18:02 polegeom kernel: usbcore: registered new device driver usb
Feb  2 17:18:02 polegeom kernel: USB Universal Host Controller Interface driver v3.0
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 16
Feb  2 17:18:02 polegeom kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Feb  2 17:18:02 polegeom kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
Feb  2 17:18:02 polegeom kernel: uhci_hcd 0000:00:10.0: irq 16, io base 0x0000a800
Feb  2 17:18:02 polegeom kernel: usb usb1: configuration #1 chosen from 1 choice
Feb  2 17:18:02 polegeom kernel: hub 1-0:1.0: USB hub found
Feb  2 17:18:02 polegeom kernel: hub 1-0:1.0: 2 ports detected
Feb  2 17:18:02 polegeom kernel: libata version 3.00 loaded.
Feb  2 17:18:02 polegeom kernel: via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 16
Feb  2 17:18:02 polegeom kernel: uhci_hcd 0000:00:10.1: UHCI Host Controller
Feb  2 17:18:02 polegeom kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
Feb  2 17:18:02 polegeom kernel: uhci_hcd 0000:00:10.1: irq 16, io base 0x0000a400
Feb  2 17:18:02 polegeom kernel: usb usb2: configuration #1 chosen from 1 choice
Feb  2 17:18:02 polegeom kernel: hub 2-0:1.0: USB hub found
Feb  2 17:18:02 polegeom kernel: hub 2-0:1.0: 2 ports detected
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 16
Feb  2 17:18:02 polegeom kernel: uhci_hcd 0000:00:10.2: UHCI Host Controller
Feb  2 17:18:02 polegeom kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
Feb  2 17:18:02 polegeom kernel: uhci_hcd 0000:00:10.2: irq 16, io base 0x0000a000
Feb  2 17:18:02 polegeom kernel: usb usb3: configuration #1 chosen from 1 choice
Feb  2 17:18:02 polegeom kernel: hub 3-0:1.0: USB hub found
Feb  2 17:18:02 polegeom kernel: hub 3-0:1.0: 2 ports detected
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 16
Feb  2 17:18:02 polegeom kernel: ehci_hcd 0000:00:10.3: EHCI Host Controller
Feb  2 17:18:02 polegeom kernel: ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
Feb  2 17:18:02 polegeom kernel: ehci_hcd 0000:00:10.3: irq 16, io mem 0xed800000
Feb  2 17:18:02 polegeom kernel: ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Feb  2 17:18:02 polegeom kernel: usb usb4: configuration #1 chosen from 1 choice
Feb  2 17:18:02 polegeom kernel: hub 4-0:1.0: USB hub found
Feb  2 17:18:02 polegeom kernel: hub 4-0:1.0: 6 ports detected
Feb  2 17:18:02 polegeom kernel: sata_via 0000:00:0b.0: version 2.3
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 17
Feb  2 17:18:02 polegeom kernel: sata_via 0000:00:0b.0: routed to hard irq line 3
Feb  2 17:18:02 polegeom kernel: scsi0 : sata_via
Feb  2 17:18:02 polegeom kernel: scsi1 : sata_via
Feb  2 17:18:02 polegeom kernel: scsi2 : sata_via
Feb  2 17:18:02 polegeom kernel: ata1: SATA max UDMA/133 port i16@0xd800 bmdma 0xb400 irq 17
Feb  2 17:18:02 polegeom kernel: ata2: SATA max UDMA/133 port i16@0xd400 bmdma 0xb408 irq 17
Feb  2 17:18:02 polegeom kernel: ata3: PATA max UDMA/133 port i16@0xd000 bmdma 0xb410 irq 17
Feb  2 17:18:02 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:02 polegeom kernel: ata1.00: ATA-7: ST3250824AS, 3.AAH, max UDMA/133
Feb  2 17:18:02 polegeom kernel: ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Feb  2 17:18:02 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 17:18:02 polegeom kernel: usb 4-3: new high speed USB device using ehci_hcd and address 2
Feb  2 17:18:02 polegeom kernel: usb 4-3: configuration #1 chosen from 1 choice
Feb  2 17:18:02 polegeom kernel: Initializing USB Mass Storage driver...
Feb  2 17:18:02 polegeom kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Feb  2 17:18:02 polegeom kernel: usbcore: registered new interface driver usb-storage
Feb  2 17:18:02 polegeom kernel: USB Mass Storage support registered.
Feb  2 17:18:02 polegeom kernel: usb-storage: device found at 2
Feb  2 17:18:02 polegeom kernel: usb-storage: waiting for device to settle before scanning
Feb  2 17:18:02 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:02 polegeom kernel: ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-13, max UDMA7
Feb  2 17:18:02 polegeom kernel: ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Feb  2 17:18:02 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:18:02 polegeom kernel: scsi 0:0:0:0: Direct-Access     ATA      ST3250824AS      3.AA PQ: 0 ANSI: 5
Feb  2 17:18:02 polegeom kernel: scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 18
Feb  2 17:18:02 polegeom kernel: eth0: VIA Rhine II at 0x19400, 00:0e:a6:6a:1c:1f, IRQ 18.
Feb  2 17:18:02 polegeom kernel: eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link c5e1.
Feb  2 17:18:02 polegeom kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb  2 17:18:02 polegeom kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb  2 17:18:02 polegeom kernel: VP_IDE: IDE controller (0x1106:0x0571 rev 0x06) at  PCI slot 0000:00:11.1
Feb  2 17:18:02 polegeom kernel: ACPI: Unable to derive IRQ for device 0000:00:11.1
Feb  2 17:18:02 polegeom kernel: VP_IDE: not 100%% native mode: will probe irqs later
Feb  2 17:18:02 polegeom kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Feb  2 17:18:02 polegeom kernel:     ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:pio, hdb:DMA
Feb  2 17:18:02 polegeom kernel:     ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
Feb  2 17:18:02 polegeom kernel: Probing IDE interface ide0...
Feb  2 17:18:02 polegeom kernel: Driver 'sd' needs updating - please use bus_type methods
Feb  2 17:18:02 polegeom kernel: sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
Feb  2 17:18:02 polegeom kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb  2 17:18:02 polegeom kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb  2 17:18:02 polegeom kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 17:18:02 polegeom kernel: sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
Feb  2 17:18:02 polegeom kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb  2 17:18:02 polegeom kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb  2 17:18:02 polegeom kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 17:18:02 polegeom kernel:  sda: [LDM] sda1
Feb  2 17:18:02 polegeom kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Feb  2 17:18:02 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 17:18:02 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 17:18:02 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 17:18:02 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 17:18:02 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 17:18:02 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 17:18:02 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 17:18:02 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 17:18:02 polegeom kernel:  sdb: sdb1
Feb  2 17:18:02 polegeom kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
Feb  2 17:18:02 polegeom kernel: hdb: ST380215A, ATA DISK drive
Feb  2 17:18:02 polegeom kernel: hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
Feb  2 17:18:02 polegeom kernel: hdb: UDMA/100 mode selected
Feb  2 17:18:02 polegeom kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  2 17:18:02 polegeom kernel: Probing IDE interface ide1...
Feb  2 17:18:02 polegeom kernel: hdc: SONY DVD-ROM DDU1612, ATAPI CD/DVD-ROM drive
Feb  2 17:18:02 polegeom kernel: hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
Feb  2 17:18:02 polegeom kernel: hdc: UDMA/33 mode selected
Feb  2 17:18:02 polegeom kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  2 17:18:02 polegeom kernel: hdb: max request size: 512KiB
Feb  2 17:18:02 polegeom kernel: hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63
Feb  2 17:18:02 polegeom kernel: hdb: cache flushes supported
Feb  2 17:18:02 polegeom kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 >
Feb  2 17:18:02 polegeom kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
Feb  2 17:18:02 polegeom kernel: Uniform CD-ROM driver Revision: 3.20
Feb  2 17:18:02 polegeom kernel: device-mapper: uevent: version 1.0.3
Feb  2 17:18:02 polegeom kernel: device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
Feb  2 17:18:02 polegeom kernel: Attempting manual resume
Feb  2 17:18:02 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 17:18:02 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 17:18:02 polegeom kernel: Linux agpgart interface v0.102
Feb  2 17:18:02 polegeom kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Feb  2 17:18:02 polegeom kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Feb  2 17:18:02 polegeom kernel: agpgart: Detected VIA KT400/KT400A/KT600 chipset
Feb  2 17:18:02 polegeom kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Feb  2 17:18:02 polegeom kernel: input: Power Button (FF) as /class/input/input1
Feb  2 17:18:02 polegeom kernel: ACPI: Power Button (FF) [PWRF]
Feb  2 17:18:02 polegeom kernel: input: Power Button (CM) as /class/input/input2
Feb  2 17:18:02 polegeom kernel: ACPI: Power Button (CM) [PWRB]
Feb  2 17:18:02 polegeom kernel: usb-storage: device scan complete
Feb  2 17:18:02 polegeom kernel: scsi 3:0:0:0: Direct-Access     SAMSUNG  HD753LJ               PQ: 0 ANSI: 2
Feb  2 17:18:02 polegeom kernel: sd 3:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
Feb  2 17:18:02 polegeom kernel: sd 3:0:0:0: [sdc] Write Protect is off
Feb  2 17:18:02 polegeom kernel: sd 3:0:0:0: [sdc] Mode Sense: 38 00 00 00
Feb  2 17:18:02 polegeom kernel: sd 3:0:0:0: [sdc] Assuming drive cache: write through
Feb  2 17:18:02 polegeom kernel: sd 3:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
Feb  2 17:18:02 polegeom kernel: sd 3:0:0:0: [sdc] Write Protect is off
Feb  2 17:18:02 polegeom kernel: sd 3:0:0:0: [sdc] Mode Sense: 38 00 00 00
Feb  2 17:18:02 polegeom kernel: sd 3:0:0:0: [sdc] Assuming drive cache: write through
Feb  2 17:18:02 polegeom kernel:  sdc:<7>irda_init()
Feb  2 17:18:02 polegeom kernel: NET: Registered protocol family 23
Feb  2 17:18:02 polegeom kernel: Real Time Clock Driver v1.12ac
Feb  2 17:18:02 polegeom kernel: input: PC Speaker as /class/input/input3
Feb  2 17:18:02 polegeom kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 19
Feb  2 17:18:02 polegeom kernel: PCI: Setting latency timer of device 0000:00:11.5 to 64
Feb  2 17:18:02 polegeom kernel: Floppy drive(s): fd0 is 1.44M
Feb  2 17:18:02 polegeom kernel: FDC 0 is a post-1991 82077
Feb  2 17:18:02 polegeom kernel: input: ImExPS/2 Generic Explorer Mouse as /class/input/input4
Feb  2 17:18:02 polegeom kernel: parport_pc 00:09: reported by Plug and Play ACPI
Feb  2 17:18:02 polegeom kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
Feb  2 17:18:02 polegeom kernel: codec_read: codec 0 is not valid [0x107e5370]
Feb  2 17:18:02 polegeom last message repeated 3 times
Feb  2 17:18:02 polegeom kernel: Adding 7992k swap on /dev/hdb6.  Priority:-1 extents:1 across:7992k
Feb  2 17:18:02 polegeom kernel: EXT3 FS on hdb1, internal journal
Feb  2 17:18:02 polegeom kernel: loop: module loaded
Feb  2 17:18:02 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 17:18:02 polegeom kernel: EXT3 FS on hdb3, internal journal
Feb  2 17:18:02 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 17:18:02 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 17:18:02 polegeom kernel: EXT3 FS on hdb2, internal journal
Feb  2 17:18:02 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 17:18:02 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 17:18:02 polegeom kernel: EXT3 FS on hdb5, internal journal
Feb  2 17:18:02 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 17:18:02 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 17:18:02 polegeom kernel: EXT3 FS on hdb7, internal journal
Feb  2 17:18:02 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 17:18:02 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  2 17:18:02 polegeom kernel: EXT3 FS on dm-0, internal journal
Feb  2 17:18:02 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  2 17:18:02 polegeom kernel: eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
Feb  2 17:18:04 polegeom kernel:  sdc1
Feb  2 17:18:04 polegeom kernel: sd 3:0:0:0: [sdc] Attached SCSI disk
Feb  2 17:18:09 polegeom kernel: NET: Registered protocol family 10
Feb  2 17:18:09 polegeom kernel: lo: Disabled Privacy Extensions
Feb  2 17:18:13 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:13 polegeom kernel: ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:13 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:13 polegeom kernel: ata1.00: status: { DRDY }
Feb  2 17:18:13 polegeom kernel: ata1: soft resetting link
Feb  2 17:18:13 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:13 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 17:18:13 polegeom kernel: ata1: EH complete
Feb  2 17:18:13 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:13 polegeom kernel: ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:13 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:13 polegeom kernel: ata1.00: status: { DRDY }
Feb  2 17:18:14 polegeom kernel: ata1: soft resetting link
Feb  2 17:18:14 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:14 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 17:18:14 polegeom kernel: ata1: EH complete
Feb  2 17:18:14 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:14 polegeom kernel: ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:14 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:14 polegeom kernel: ata1.00: status: { DRDY }
Feb  2 17:18:14 polegeom kernel: ata1: soft resetting link
Feb  2 17:18:14 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:15 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 17:18:15 polegeom kernel: ata1: EH complete
Feb  2 17:18:15 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:15 polegeom kernel: ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:15 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:15 polegeom kernel: ata1.00: status: { DRDY }
Feb  2 17:18:15 polegeom kernel: ata1: soft resetting link
Feb  2 17:18:15 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:15 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 17:18:15 polegeom kernel: ata1: EH complete
Feb  2 17:18:15 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:15 polegeom kernel: ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:15 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:15 polegeom kernel: ata1.00: status: { DRDY }
Feb  2 17:18:16 polegeom kernel: ata1: soft resetting link
Feb  2 17:18:16 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:16 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 17:18:16 polegeom kernel: ata1: EH complete
Feb  2 17:18:16 polegeom kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:16 polegeom kernel: ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:16 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:16 polegeom kernel: ata1.00: status: { DRDY }
Feb  2 17:18:16 polegeom kernel: ata1: soft resetting link
Feb  2 17:18:16 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:16 polegeom kernel: ata1.00: configured for UDMA/133
Feb  2 17:18:16 polegeom kernel: ata1: EH complete
Feb  2 17:18:16 polegeom kernel: sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
Feb  2 17:18:16 polegeom kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb  2 17:18:16 polegeom kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb  2 17:18:16 polegeom kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 17:18:16 polegeom kernel: sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
Feb  2 17:18:16 polegeom kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb  2 17:18:16 polegeom kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb  2 17:18:16 polegeom kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 17:18:17 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:17 polegeom kernel: ata2.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:17 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:17 polegeom kernel: ata2.00: status: { DRDY }
Feb  2 17:18:17 polegeom kernel: ata2: soft resetting link
Feb  2 17:18:17 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:17 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:18:17 polegeom kernel: ata2: EH complete
Feb  2 17:18:17 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:17 polegeom kernel: ata2.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:17 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:17 polegeom kernel: ata2.00: status: { DRDY }
Feb  2 17:18:17 polegeom kernel: ata2: soft resetting link
Feb  2 17:18:17 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:18 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:18:18 polegeom kernel: ata2: EH complete
Feb  2 17:18:18 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:18 polegeom kernel: ata2.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:18 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:18 polegeom kernel: ata2.00: status: { DRDY }
Feb  2 17:18:18 polegeom kernel: ata2: soft resetting link
Feb  2 17:18:18 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:18 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:18:18 polegeom kernel: ata2: EH complete
Feb  2 17:18:18 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:18 polegeom kernel: ata2.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:18 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:18 polegeom kernel: ata2.00: status: { DRDY }
Feb  2 17:18:18 polegeom kernel: ata2: soft resetting link
Feb  2 17:18:18 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:19 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:18:19 polegeom kernel: ata2: EH complete
Feb  2 17:18:19 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:19 polegeom kernel: ata2.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:19 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:19 polegeom kernel: ata2.00: status: { DRDY }
Feb  2 17:18:19 polegeom kernel: ata2: soft resetting link
Feb  2 17:18:19 polegeom kernel: eth0: no IPv6 routers present
Feb  2 17:18:19 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:19 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:18:19 polegeom kernel: ata2: EH complete
Feb  2 17:18:19 polegeom kernel: ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Feb  2 17:18:19 polegeom kernel: ata2.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 pio 123392 in
Feb  2 17:18:19 polegeom kernel:          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM violation)
Feb  2 17:18:19 polegeom kernel: ata2.00: status: { DRDY }
Feb  2 17:18:19 polegeom kernel: ata2: soft resetting link
Feb  2 17:18:19 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:18:20 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:18:20 polegeom kernel: ata2: EH complete
Feb  2 17:18:20 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 17:18:20 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 17:18:20 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 17:18:20 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 17:18:20 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 17:18:20 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 17:18:20 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 17:18:20 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 17:23:01 polegeom kernel: NTFS driver 2.1.29 [Flags: R/W MODULE].
Feb  2 17:23:01 polegeom kernel: NTFS volume version 3.1.
Feb  2 17:45:52 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 17:45:52 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x15b5c.
Feb  2 17:46:48 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 17:46:48 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c2c.
Feb  2 17:46:48 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 17:46:48 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c59.
Feb  2 17:46:48 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 17:46:48 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c2e.
Feb  2 17:46:48 polegeom kernel: NTFS-fs error (device sda1): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.  You might want to try to use the mount option nls=utf8.
Feb  2 17:46:48 polegeom kernel: NTFS-fs warning (device sda1): ntfs_filldir(): Skipping unrepresentable inode 0x28c2f.
Feb  2 17:48:05 polegeom kernel: NTFS volume version 3.1.
Feb  2 17:59:57 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 17:59:57 polegeom kernel: ata2.00: BMDMA stat 0x5
Feb  2 17:59:57 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  2 17:59:57 polegeom kernel: ata2.00: cmd 35/00:00:27:ef:95/00:04:06:00:00/e0 tag 0 dma 524288 out
Feb  2 17:59:57 polegeom kernel:          res 51/84:70:b7:f2:95/84:00:06:00:00/e0 Emask 0x12 (ATA bus error)
Feb  2 17:59:57 polegeom kernel: ata2.00: status: { DRDY ERR }
Feb  2 17:59:57 polegeom kernel: ata2.00: error: { ICRC ABRT }
Feb  2 17:59:57 polegeom kernel: ata2: soft resetting link
Feb  2 17:59:57 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 17:59:57 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 17:59:57 polegeom kernel: ata2: EH complete
Feb  2 17:59:57 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 17:59:57 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 17:59:57 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 17:59:57 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 18:01:52 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 18:01:52 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  2 18:01:52 polegeom kernel: ata2.00: cmd 35/00:00:1f:db:a7/00:04:06:00:00/e0 tag 0 dma 524288 out
Feb  2 18:01:52 polegeom kernel:          res 40/00:70:b7:f2:95/84:00:06:00:00/e0 Emask 0x16 (ATA bus error)
Feb  2 18:01:52 polegeom kernel: ata2.00: status: { DRDY }
Feb  2 18:01:57 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  2 18:02:02 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  2 18:02:02 polegeom kernel: ata2: hard resetting link
Feb  2 18:02:02 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 18:02:02 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 18:02:02 polegeom kernel: ata2: EH complete
Feb  2 18:02:02 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 18:02:02 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 18:02:02 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 18:02:02 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 18:04:46 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 18:04:46 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  2 18:04:46 polegeom kernel: ata2.00: cmd 35/00:00:ef:09:c5/00:04:20:00:00/e0 tag 0 dma 524288 out
Feb  2 18:04:46 polegeom kernel:          res 40/00:70:b7:f2:95/84:00:06:00:00/e0 Emask 0x16 (ATA bus error)
Feb  2 18:04:46 polegeom kernel: ata2.00: status: { DRDY }
Feb  2 18:04:52 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  2 18:04:56 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  2 18:04:56 polegeom kernel: ata2: hard resetting link
Feb  2 18:04:57 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 18:04:57 polegeom kernel: ata2.00: configured for UDMA/133
Feb  2 18:04:57 polegeom kernel: ata2: EH complete
Feb  2 18:04:57 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 18:04:57 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 18:04:57 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 18:04:57 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 18:08:12 polegeom kernel: ata2.00: limiting speed to UDMA/100:PIO4
Feb  2 18:08:12 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  2 18:08:12 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  2 18:08:12 polegeom kernel: ata2.00: cmd 35/00:00:17:33:3f/00:04:22:00:00/e0 tag 0 dma 524288 out
Feb  2 18:08:12 polegeom kernel:          res 40/00:70:b7:f2:95/84:00:06:00:00/e0 Emask 0x16 (ATA bus error)
Feb  2 18:08:12 polegeom kernel: ata2.00: status: { DRDY }
Feb  2 18:08:18 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  2 18:08:22 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  2 18:08:22 polegeom kernel: ata2: hard resetting link
Feb  2 18:08:23 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 18:08:23 polegeom kernel: ata2.00: configured for UDMA/100
Feb  2 18:08:23 polegeom kernel: ata2: EH complete
Feb  2 18:08:23 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 18:08:23 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 18:08:23 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 18:08:23 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 18:08:39 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 18:08:39 polegeom kernel: ata2.00: BMDMA stat 0x5
Feb  2 18:08:39 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  2 18:08:39 polegeom kernel: ata2.00: cmd 35/00:00:6f:cd:57/00:04:22:00:00/e0 tag 0 dma 524288 out
Feb  2 18:08:39 polegeom kernel:          res 51/84:b0:bf:ce:57/84:02:22:00:00/e0 Emask 0x12 (ATA bus error)
Feb  2 18:08:39 polegeom kernel: ata2.00: status: { DRDY ERR }
Feb  2 18:08:39 polegeom kernel: ata2.00: error: { ICRC ABRT }
Feb  2 18:08:39 polegeom kernel: ata2: soft resetting link
Feb  2 18:08:39 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 18:08:39 polegeom kernel: ata2.00: configured for UDMA/100
Feb  2 18:08:39 polegeom kernel: ata2: EH complete
Feb  2 18:08:39 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 18:08:39 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 18:08:39 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 18:08:39 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  2 18:32:35 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  2 18:32:35 polegeom kernel: ata2.00: BMDMA stat 0x5
Feb  2 18:32:35 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  2 18:32:35 polegeom kernel: ata2.00: cmd 35/00:00:87:cd:b1/00:04:07:00:00/e0 tag 0 dma 524288 out
Feb  2 18:32:35 polegeom kernel:          res 51/84:20:67:ce:b1/84:03:07:00:00/e0 Emask 0x12 (ATA bus error)
Feb  2 18:32:35 polegeom kernel: ata2.00: status: { DRDY ERR }
Feb  2 18:32:35 polegeom kernel: ata2.00: error: { ICRC ABRT }
Feb  2 18:32:35 polegeom kernel: ata2: soft resetting link
Feb  2 18:32:35 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  2 18:32:35 polegeom kernel: ata2.00: configured for UDMA/100
Feb  2 18:32:35 polegeom kernel: ata2: EH complete
Feb  2 18:32:35 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  2 18:32:35 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  2 18:32:35 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  2 18:32:36 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:03:59 polegeom kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
Feb  3 09:03:59 polegeom kernel: bus_irq 0 global_irq 2 dfl edge)
Feb  3 09:03:59 polegeom kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Feb  3 09:03:59 polegeom kernel: ACPI: IRQ0 used by override.
Feb  3 09:03:59 polegeom kernel: ACPI: IRQ2 used by override.
Feb  3 09:03:59 polegeom kernel: ACPI: IRQ9 used by override.
Feb  3 09:03:59 polegeom kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb  3 09:03:59 polegeom kernel: Using ACPI (MADT) for SMP configuration information
Feb  3 09:03:59 polegeom kernel: Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Feb  3 09:03:59 polegeom kernel: swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
Feb  3 09:03:59 polegeom kernel: swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000f0000
Feb  3 09:03:59 polegeom kernel: swsusp: Registered nosave memory region: 00000000000f0000 - 0000000000100000
Feb  3 09:03:59 polegeom kernel: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 227584
Feb  3 09:03:59 polegeom kernel: Kernel command line: root=/dev/hdb1 ro 
Feb  3 09:03:59 polegeom kernel: mapped APIC to ffffb000 (fee00000)
Feb  3 09:03:59 polegeom kernel: mapped IOAPIC to ffffa000 (fec00000)
Feb  3 09:03:59 polegeom kernel: Enabling fast FPU save and restore... done.
Feb  3 09:03:59 polegeom kernel: Enabling unmasked SIMD FPU exception support... done.
Feb  3 09:03:59 polegeom kernel: Initializing CPU#0
Feb  3 09:03:59 polegeom kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Feb  3 09:03:59 polegeom kernel: Detected 1916.544 MHz processor.
Feb  3 09:03:59 polegeom kernel: Console: colour VGA+ 80x25
Feb  3 09:03:59 polegeom kernel: console [tty0] enabled
Feb  3 09:03:59 polegeom kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb  3 09:03:59 polegeom kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb  3 09:03:59 polegeom kernel: Memory: 900744k/917504k available (1753k kernel code, 16212k reserved, 721k data, 324k init, 0k highmem)
Feb  3 09:03:59 polegeom kernel: virtual kernel memory layout:
Feb  3 09:03:59 polegeom kernel:     fixmap  : 0xfffb3000 - 0xfffff000   ( 304 kB)
Feb  3 09:03:59 polegeom kernel:     vmalloc : 0xf8800000 - 0xfffb1000   ( 119 MB)
Feb  3 09:03:59 polegeom kernel:     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
Feb  3 09:03:59 polegeom kernel:       .init : 0xc036e000 - 0xc03bf000   ( 324 kB)
Feb  3 09:03:59 polegeom kernel:       .data : 0xc02b6735 - 0xc036ade4   ( 721 kB)
Feb  3 09:03:59 polegeom kernel:       .text : 0xc0100000 - 0xc02b6735   (1753 kB)
Feb  3 09:03:59 polegeom kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb  3 09:03:59 polegeom kernel: Calibrating delay using timer specific routine.. 3836.46 BogoMIPS (lpj=7672938)
Feb  3 09:03:59 polegeom kernel: Security Framework initialized
Feb  3 09:03:59 polegeom kernel: SELinux:  Disabled at boot.
Feb  3 09:03:59 polegeom kernel: Capability LSM initialized
Feb  3 09:03:59 polegeom kernel: Mount-cache hash table entries: 512
Feb  3 09:03:59 polegeom kernel: Initializing cgroup subsys ns
Feb  3 09:03:59 polegeom kernel: Initializing cgroup subsys cpuacct
Feb  3 09:03:59 polegeom kernel: CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000 00000000
Feb  3 09:03:59 polegeom kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb  3 09:03:59 polegeom kernel: CPU: L2 Cache: 512K (64 bytes/line)
Feb  3 09:03:59 polegeom kernel: CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000 00000000
Feb  3 09:03:59 polegeom kernel: Compat vDSO mapped to ffffe000.
Feb  3 09:03:59 polegeom kernel: CPU: AMD Athlon(TM) XP 2600+ stepping 00
Feb  3 09:03:59 polegeom kernel: Checking 'hlt' instruction... OK.
Feb  3 09:03:59 polegeom kernel: Freeing SMP alternatives: 0k freed
Feb  3 09:03:59 polegeom kernel: ACPI: Core revision 20070126
Feb  3 09:03:59 polegeom kernel: ENABLING IO-APIC IRQs
Feb  3 09:03:59 polegeom kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Feb  3 09:03:59 polegeom kernel: net_namespace: 64 bytes
Feb  3 09:03:59 polegeom kernel: Booting paravirtualized kernel on bare hardware
Feb  3 09:03:59 polegeom kernel: NET: Registered protocol family 16
Feb  3 09:03:59 polegeom kernel: EISA bus registered
Feb  3 09:03:59 polegeom kernel: ACPI: bus type pci registered
Feb  3 09:03:59 polegeom kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1990, last bus=1
Feb  3 09:03:59 polegeom kernel: PCI: Using configuration type 1
Feb  3 09:03:59 polegeom kernel: Setting up standard PCI resources
Feb  3 09:03:59 polegeom kernel: ACPI: EC: Look up EC in DSDT
Feb  3 09:03:59 polegeom kernel: ACPI: Interpreter enabled
Feb  3 09:03:59 polegeom kernel: ACPI: (supports S0 S1 S4 S5)
Feb  3 09:03:59 polegeom kernel: ACPI: Using IOAPIC for interrupt routing
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb  3 09:03:59 polegeom kernel: PCI quirk: region e400-e47f claimed by vt8235 PM
Feb  3 09:03:59 polegeom kernel: PCI quirk: region e800-e80f claimed by vt8235 SMB
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12)
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12)
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Feb  3 09:03:59 polegeom kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb  3 09:03:59 polegeom kernel: pnp: PnP ACPI init
Feb  3 09:03:59 polegeom kernel: ACPI: bus type pnp registered
Feb  3 09:03:59 polegeom kernel: pnp: PnP ACPI: found 16 devices
Feb  3 09:03:59 polegeom kernel: ACPI: ACPI bus type pnp unregistered
Feb  3 09:03:59 polegeom kernel: PnPBIOS: Disabled by ACPI PNP
Feb  3 09:03:59 polegeom kernel: PCI: Using ACPI for IRQ routing
Feb  3 09:03:59 polegeom kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Feb  3 09:03:59 polegeom kernel: NET: Registered protocol family 8
Feb  3 09:03:59 polegeom kernel: NET: Registered protocol family 20
Feb  3 09:03:59 polegeom kernel: ACPI: RTC can wake from S4
Feb  3 09:03:59 polegeom kernel: Time: tsc clocksource has been installed.
Feb  3 09:03:59 polegeom kernel: system 00:00: iomem range 0x0-0x9ffff could not be reserved
Feb  3 09:03:59 polegeom kernel: system 00:00: iomem range 0xf0000-0xfffff could not be reserved
Feb  3 09:03:59 polegeom kernel: system 00:00: iomem range 0x100000-0x3fffffff could not be reserved
Feb  3 09:03:59 polegeom kernel: system 00:00: iomem range 0xfec00000-0xfec000ff could not be reserved
Feb  3 09:03:59 polegeom kernel: system 00:00: iomem range 0xfee00000-0xfee00fff could not be reserved
Feb  3 09:03:59 polegeom kernel: system 00:02: ioport range 0xe400-0xe47f has been reserved
Feb  3 09:03:59 polegeom kernel: system 00:02: ioport range 0xe800-0xe81f could not be reserved
Feb  3 09:03:59 polegeom kernel: system 00:02: iomem range 0xfff80000-0xffffffff could not be reserved
Feb  3 09:03:59 polegeom kernel: system 00:02: iomem range 0xffb80000-0xffbfffff has been reserved
Feb  3 09:03:59 polegeom kernel: system 00:03: ioport range 0x4d0-0x4d1 has been reserved
Feb  3 09:03:59 polegeom kernel: system 00:0f: ioport range 0x290-0x297 has been reserved
Feb  3 09:03:59 polegeom kernel: system 00:0f: ioport range 0x370-0x375 has been reserved
Feb  3 09:03:59 polegeom kernel: PCI: Bridge: 0000:00:01.0
Feb  3 09:03:59 polegeom kernel:   IO window: disabled.
Feb  3 09:03:59 polegeom kernel:   MEM window: ee000000-efdfffff
Feb  3 09:03:59 polegeom kernel:   PREFETCH window: eff00000-f7ffffff
Feb  3 09:03:59 polegeom kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Feb  3 09:03:59 polegeom kernel: NET: Registered protocol family 2
Feb  3 09:03:59 polegeom kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb  3 09:03:59 polegeom kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Feb  3 09:03:59 polegeom kernel: TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
Feb  3 09:03:59 polegeom kernel: TCP: Hash tables configured (established 131072 bind 65536)
Feb  3 09:03:59 polegeom kernel: TCP reno registered
Feb  3 09:03:59 polegeom kernel: checking if image is initramfs... it is
Feb  3 09:03:59 polegeom kernel: Switched to high resolution mode on CPU 0
Feb  3 09:03:59 polegeom kernel: Freeing initrd memory: 5179k freed
Feb  3 09:03:59 polegeom kernel: Simple Boot Flag at 0x3a set to 0x1
Feb  3 09:03:59 polegeom kernel: audit: initializing netlink socket (disabled)
Feb  3 09:03:59 polegeom kernel: audit(1233648199.732:1): initialized
Feb  3 09:03:59 polegeom kernel: Total HugeTLB memory allocated, 0
Feb  3 09:03:59 polegeom kernel: VFS: Disk quotas dquot_6.5.1
Feb  3 09:03:59 polegeom kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Feb  3 09:03:59 polegeom kernel: io scheduler noop registered
Feb  3 09:03:59 polegeom kernel: io scheduler anticipatory registered
Feb  3 09:03:59 polegeom kernel: io scheduler deadline registered
Feb  3 09:03:59 polegeom kernel: io scheduler cfq registered (default)
Feb  3 09:03:59 polegeom kernel: PCI: VIA PCI bridge detected. Disabling DAC.
Feb  3 09:03:59 polegeom kernel: Boot video device is 0000:01:00.0
Feb  3 09:03:59 polegeom kernel: isapnp: Scanning for PnP cards...
Feb  3 09:03:59 polegeom kernel: isapnp: No Plug & Play device found
Feb  3 09:03:59 polegeom kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Feb  3 09:03:59 polegeom kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  3 09:03:59 polegeom kernel: 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  3 09:03:59 polegeom kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Feb  3 09:03:59 polegeom kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Feb  3 09:03:59 polegeom kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  3 09:03:59 polegeom kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  3 09:03:59 polegeom kernel: mice: PS/2 mouse device common for all mice
Feb  3 09:03:59 polegeom kernel: EISA: Probing bus 0 at eisa.0
Feb  3 09:03:59 polegeom kernel: EISA: Detected 0 cards.
Feb  3 09:03:59 polegeom kernel: cpuidle: using governor ladder
Feb  3 09:03:59 polegeom kernel: cpuidle: using governor menu
Feb  3 09:03:59 polegeom kernel: TCP bic registered
Feb  3 09:03:59 polegeom kernel: NET: Registered protocol family 1
Feb  3 09:03:59 polegeom kernel: NET: Registered protocol family 17
Feb  3 09:03:59 polegeom kernel: Using IPI Shortcut mode
Feb  3 09:03:59 polegeom kernel: registered taskstats version 1
Feb  3 09:03:59 polegeom kernel: Freeing unused kernel memory: 324k freed
Feb  3 09:03:59 polegeom kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Feb  3 09:03:59 polegeom kernel: SCSI subsystem initialized
Feb  3 09:03:59 polegeom kernel: usbcore: registered new interface driver usbfs
Feb  3 09:03:59 polegeom kernel: usbcore: registered new interface driver hub
Feb  3 09:03:59 polegeom kernel: usbcore: registered new device driver usb
Feb  3 09:03:59 polegeom kernel: USB Universal Host Controller Interface driver v3.0
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 16
Feb  3 09:03:59 polegeom kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Feb  3 09:03:59 polegeom kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
Feb  3 09:03:59 polegeom kernel: uhci_hcd 0000:00:10.0: irq 16, io base 0x0000a800
Feb  3 09:03:59 polegeom kernel: usb usb1: configuration #1 chosen from 1 choice
Feb  3 09:03:59 polegeom kernel: hub 1-0:1.0: USB hub found
Feb  3 09:03:59 polegeom kernel: hub 1-0:1.0: 2 ports detected
Feb  3 09:03:59 polegeom kernel: libata version 3.00 loaded.
Feb  3 09:03:59 polegeom kernel: via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 16
Feb  3 09:03:59 polegeom kernel: uhci_hcd 0000:00:10.1: UHCI Host Controller
Feb  3 09:03:59 polegeom kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
Feb  3 09:03:59 polegeom kernel: uhci_hcd 0000:00:10.1: irq 16, io base 0x0000a400
Feb  3 09:03:59 polegeom kernel: usb usb2: configuration #1 chosen from 1 choice
Feb  3 09:03:59 polegeom kernel: hub 2-0:1.0: USB hub found
Feb  3 09:03:59 polegeom kernel: hub 2-0:1.0: 2 ports detected
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 16
Feb  3 09:03:59 polegeom kernel: uhci_hcd 0000:00:10.2: UHCI Host Controller
Feb  3 09:03:59 polegeom kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
Feb  3 09:03:59 polegeom kernel: uhci_hcd 0000:00:10.2: irq 16, io base 0x0000a000
Feb  3 09:03:59 polegeom kernel: usb usb3: configuration #1 chosen from 1 choice
Feb  3 09:03:59 polegeom kernel: hub 3-0:1.0: USB hub found
Feb  3 09:03:59 polegeom kernel: hub 3-0:1.0: 2 ports detected
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 16
Feb  3 09:03:59 polegeom kernel: ehci_hcd 0000:00:10.3: EHCI Host Controller
Feb  3 09:03:59 polegeom kernel: ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
Feb  3 09:03:59 polegeom kernel: ehci_hcd 0000:00:10.3: irq 16, io mem 0xed800000
Feb  3 09:03:59 polegeom kernel: ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Feb  3 09:03:59 polegeom kernel: usb usb4: configuration #1 chosen from 1 choice
Feb  3 09:03:59 polegeom kernel: hub 4-0:1.0: USB hub found
Feb  3 09:03:59 polegeom kernel: hub 4-0:1.0: 6 ports detected
Feb  3 09:03:59 polegeom kernel: sata_via 0000:00:0b.0: version 2.3
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 17
Feb  3 09:03:59 polegeom kernel: sata_via 0000:00:0b.0: routed to hard irq line 3
Feb  3 09:03:59 polegeom kernel: scsi0 : sata_via
Feb  3 09:03:59 polegeom kernel: scsi1 : sata_via
Feb  3 09:03:59 polegeom kernel: scsi2 : sata_via
Feb  3 09:03:59 polegeom kernel: ata1: SATA max UDMA/133 port i16@0xd800 bmdma 0xb400 irq 17
Feb  3 09:03:59 polegeom kernel: ata2: SATA max UDMA/133 port i16@0xd400 bmdma 0xb408 irq 17
Feb  3 09:03:59 polegeom kernel: ata3: PATA max UDMA/133 port i16@0xd000 bmdma 0xb410 irq 17
Feb  3 09:03:59 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:03:59 polegeom kernel: ata1.00: ATA-7: ST3250824AS, 3.AAH, max UDMA/133
Feb  3 09:03:59 polegeom kernel: ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Feb  3 09:03:59 polegeom kernel: ata1.00: configured for UDMA/133
Feb  3 09:03:59 polegeom kernel: usb 4-3: new high speed USB device using ehci_hcd and address 2
Feb  3 09:03:59 polegeom kernel: usb 4-3: configuration #1 chosen from 1 choice
Feb  3 09:03:59 polegeom kernel: Initializing USB Mass Storage driver...
Feb  3 09:03:59 polegeom kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Feb  3 09:03:59 polegeom kernel: usbcore: registered new interface driver usb-storage
Feb  3 09:03:59 polegeom kernel: USB Mass Storage support registered.
Feb  3 09:03:59 polegeom kernel: usb-storage: device found at 2
Feb  3 09:03:59 polegeom kernel: usb-storage: waiting for device to settle before scanning
Feb  3 09:03:59 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:03:59 polegeom kernel: ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-13, max UDMA7
Feb  3 09:03:59 polegeom kernel: ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Feb  3 09:03:59 polegeom kernel: ata2.00: configured for UDMA/133
Feb  3 09:03:59 polegeom kernel: scsi 0:0:0:0: Direct-Access     ATA      ST3250824AS      3.AA PQ: 0 ANSI: 5
Feb  3 09:03:59 polegeom kernel: scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 18
Feb  3 09:03:59 polegeom kernel: eth0: VIA Rhine II at 0x19400, 00:0e:a6:6a:1c:1f, IRQ 18.
Feb  3 09:03:59 polegeom kernel: eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link c5e1.
Feb  3 09:03:59 polegeom kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb  3 09:03:59 polegeom kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb  3 09:03:59 polegeom kernel: VP_IDE: IDE controller (0x1106:0x0571 rev 0x06) at  PCI slot 0000:00:11.1
Feb  3 09:03:59 polegeom kernel: ACPI: Unable to derive IRQ for device 0000:00:11.1
Feb  3 09:03:59 polegeom kernel: VP_IDE: not 100%% native mode: will probe irqs later
Feb  3 09:03:59 polegeom kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Feb  3 09:03:59 polegeom kernel:     ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:pio, hdb:DMA
Feb  3 09:03:59 polegeom kernel:     ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
Feb  3 09:03:59 polegeom kernel: Probing IDE interface ide0...
Feb  3 09:03:59 polegeom kernel: Driver 'sd' needs updating - please use bus_type methods
Feb  3 09:03:59 polegeom kernel: sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
Feb  3 09:03:59 polegeom kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb  3 09:03:59 polegeom kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb  3 09:03:59 polegeom kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:03:59 polegeom kernel: sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
Feb  3 09:03:59 polegeom kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb  3 09:03:59 polegeom kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb  3 09:03:59 polegeom kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:03:59 polegeom kernel:  sda: [LDM] sda1
Feb  3 09:03:59 polegeom kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Feb  3 09:03:59 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:03:59 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:03:59 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:03:59 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:03:59 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:03:59 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:03:59 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:03:59 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:03:59 polegeom kernel:  sdb: sdb1
Feb  3 09:03:59 polegeom kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
Feb  3 09:03:59 polegeom kernel: hdb: ST380215A, ATA DISK drive
Feb  3 09:03:59 polegeom kernel: hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
Feb  3 09:03:59 polegeom kernel: hdb: UDMA/100 mode selected
Feb  3 09:03:59 polegeom kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  3 09:03:59 polegeom kernel: Probing IDE interface ide1...
Feb  3 09:03:59 polegeom kernel: hdc: SONY DVD-ROM DDU1612, ATAPI CD/DVD-ROM drive
Feb  3 09:03:59 polegeom kernel: hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
Feb  3 09:03:59 polegeom kernel: hdc: UDMA/33 mode selected
Feb  3 09:03:59 polegeom kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  3 09:03:59 polegeom kernel: hdb: max request size: 512KiB
Feb  3 09:03:59 polegeom kernel: hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63
Feb  3 09:03:59 polegeom kernel: hdb: cache flushes supported
Feb  3 09:03:59 polegeom kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 >
Feb  3 09:03:59 polegeom kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
Feb  3 09:03:59 polegeom kernel: Uniform CD-ROM driver Revision: 3.20
Feb  3 09:03:59 polegeom kernel: device-mapper: uevent: version 1.0.3
Feb  3 09:03:59 polegeom kernel: device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
Feb  3 09:03:59 polegeom kernel: Attempting manual resume
Feb  3 09:03:59 polegeom kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Feb  3 09:03:59 polegeom kernel: EXT3-fs: write access will be enabled during recovery.
Feb  3 09:03:59 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 09:03:59 polegeom kernel: EXT3-fs: hdb1: orphan cleanup on readonly fs
Feb  3 09:03:59 polegeom kernel: ext3_orphan_cleanup: deleting unreferenced inode 179405
Feb  3 09:03:59 polegeom kernel: ext3_orphan_cleanup: deleting unreferenced inode 179404
Feb  3 09:03:59 polegeom kernel: ext3_orphan_cleanup: deleting unreferenced inode 179403
Feb  3 09:03:59 polegeom kernel: ext3_orphan_cleanup: deleting unreferenced inode 179402
Feb  3 09:03:59 polegeom kernel: ext3_orphan_cleanup: deleting unreferenced inode 179401
Feb  3 09:03:59 polegeom kernel: EXT3-fs: hdb1: 5 orphan inodes deleted
Feb  3 09:03:59 polegeom kernel: EXT3-fs: recovery complete.
Feb  3 09:03:59 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 09:03:59 polegeom kernel: usb-storage: device scan complete
Feb  3 09:03:59 polegeom kernel: scsi 3:0:0:0: Direct-Access     SAMSUNG  HD753LJ               PQ: 0 ANSI: 2
Feb  3 09:03:59 polegeom kernel: sd 3:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
Feb  3 09:03:59 polegeom kernel: sd 3:0:0:0: [sdc] Write Protect is off
Feb  3 09:03:59 polegeom kernel: sd 3:0:0:0: [sdc] Mode Sense: 38 00 00 00
Feb  3 09:03:59 polegeom kernel: sd 3:0:0:0: [sdc] Assuming drive cache: write through
Feb  3 09:03:59 polegeom kernel: sd 3:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
Feb  3 09:03:59 polegeom kernel: sd 3:0:0:0: [sdc] Write Protect is off
Feb  3 09:03:59 polegeom kernel: sd 3:0:0:0: [sdc] Mode Sense: 38 00 00 00
Feb  3 09:03:59 polegeom kernel: sd 3:0:0:0: [sdc] Assuming drive cache: write through
Feb  3 09:03:59 polegeom kernel:  sdc:<6>pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Feb  3 09:03:59 polegeom kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Feb  3 09:03:59 polegeom kernel: Linux agpgart interface v0.102
Feb  3 09:03:59 polegeom kernel: agpgart: Detected VIA KT400/KT400A/KT600 chipset
Feb  3 09:03:59 polegeom kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Feb  3 09:03:59 polegeom kernel: input: Power Button (FF) as /class/input/input1
Feb  3 09:03:59 polegeom kernel: ACPI: Power Button (FF) [PWRF]
Feb  3 09:03:59 polegeom kernel: input: Power Button (CM) as /class/input/input2
Feb  3 09:03:59 polegeom kernel: ACPI: Power Button (CM) [PWRB]
Feb  3 09:03:59 polegeom kernel: irda_init()
Feb  3 09:03:59 polegeom kernel: NET: Registered protocol family 23
Feb  3 09:03:59 polegeom kernel: Real Time Clock Driver v1.12ac
Feb  3 09:03:59 polegeom kernel: input: PC Speaker as /class/input/input3
Feb  3 09:03:59 polegeom kernel: Floppy drive(s): fd0 is 1.44M
Feb  3 09:03:59 polegeom kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 19
Feb  3 09:03:59 polegeom kernel: PCI: Setting latency timer of device 0000:00:11.5 to 64
Feb  3 09:03:59 polegeom kernel: FDC 0 is a post-1991 82077
Feb  3 09:03:59 polegeom kernel: input: ImExPS/2 Generic Explorer Mouse as /class/input/input4
Feb  3 09:03:59 polegeom kernel: parport_pc 00:09: reported by Plug and Play ACPI
Feb  3 09:03:59 polegeom kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
Feb  3 09:03:59 polegeom kernel: codec_read: codec 0 is not valid [0x107e5370]
Feb  3 09:03:59 polegeom last message repeated 3 times
Feb  3 09:03:59 polegeom kernel: Adding 7992k swap on /dev/hdb6.  Priority:-1 extents:1 across:7992k
Feb  3 09:03:59 polegeom kernel: EXT3 FS on hdb1, internal journal
Feb  3 09:03:59 polegeom kernel: loop: module loaded
Feb  3 09:03:59 polegeom kernel:  sdc1
Feb  3 09:03:59 polegeom kernel: sd 3:0:0:0: [sdc] Attached SCSI disk
Feb  3 09:03:59 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 09:03:59 polegeom kernel: EXT3 FS on hdb3, internal journal
Feb  3 09:03:59 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 09:03:59 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 09:03:59 polegeom kernel: EXT3 FS on hdb2, internal journal
Feb  3 09:03:59 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 09:03:59 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 09:03:59 polegeom kernel: EXT3 FS on hdb5, internal journal
Feb  3 09:03:59 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 09:03:59 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 09:03:59 polegeom kernel: EXT3 FS on hdb7, internal journal
Feb  3 09:03:59 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 09:03:59 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 09:03:59 polegeom kernel: EXT3 FS on dm-0, internal journal
Feb  3 09:03:59 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 09:03:59 polegeom kernel: eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
Feb  3 09:04:06 polegeom kernel: NET: Registered protocol family 10
Feb  3 09:04:06 polegeom kernel: lo: Disabled Privacy Extensions
Feb  3 09:04:16 polegeom kernel: eth0: no IPv6 routers present
Feb  3 09:07:08 polegeom kernel: NTFS driver 2.1.29 [Flags: R/W MODULE].
Feb  3 09:07:08 polegeom kernel: NTFS volume version 3.1.
Feb  3 09:07:08 polegeom kernel: NTFS-fs error (device sda1): load_system_files(): Volume is dirty.  Mounting read-only.  Run chkdsk and mount in Windows.
Feb  3 09:10:13 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  3 09:10:13 polegeom kernel: ata2.00: BMDMA stat 0x5
Feb  3 09:10:13 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  3 09:10:13 polegeom kernel: ata2.00: cmd 35/00:00:37:dd:b0/00:04:07:00:00/e0 tag 0 dma 524288 out
Feb  3 09:10:13 polegeom kernel:          res 51/84:5f:d8:de:b0/84:02:07:00:00/e0 Emask 0x12 (ATA bus error)
Feb  3 09:10:13 polegeom kernel: ata2.00: status: { DRDY ERR }
Feb  3 09:10:13 polegeom kernel: ata2.00: error: { ICRC ABRT }
Feb  3 09:10:14 polegeom kernel: ata2: soft resetting link
Feb  3 09:10:14 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:10:14 polegeom kernel: ata2.00: configured for UDMA/133
Feb  3 09:10:14 polegeom kernel: ata2: EH complete
Feb  3 09:10:14 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:10:14 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:10:14 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:10:14 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:11:09 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  3 09:11:09 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  3 09:11:09 polegeom kernel: ata2.00: cmd 35/00:00:0f:9a:c1/00:04:07:00:00/e0 tag 0 dma 524288 out
Feb  3 09:11:09 polegeom kernel:          res 40/00:5f:d8:de:b0/84:02:07:00:00/e0 Emask 0x16 (ATA bus error)
Feb  3 09:11:09 polegeom kernel: ata2.00: status: { DRDY }
Feb  3 09:11:14 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  3 09:11:19 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  3 09:11:19 polegeom kernel: ata2: hard resetting link
Feb  3 09:11:20 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:11:20 polegeom kernel: ata2.00: configured for UDMA/133
Feb  3 09:11:20 polegeom kernel: ata2: EH complete
Feb  3 09:11:20 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:11:20 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:11:20 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:11:20 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:12:02 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  3 09:12:02 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  3 09:12:02 polegeom kernel: ata2.00: cmd 35/00:00:f7:ec:c7/00:04:07:00:00/e0 tag 0 dma 524288 out
Feb  3 09:12:02 polegeom kernel:          res 40/00:5f:d8:de:b0/84:02:07:00:00/e0 Emask 0x16 (ATA bus error)
Feb  3 09:12:02 polegeom kernel: ata2.00: status: { DRDY }
Feb  3 09:12:07 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  3 09:12:12 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  3 09:12:12 polegeom kernel: ata2: hard resetting link
Feb  3 09:12:12 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:12:12 polegeom kernel: ata2.00: configured for UDMA/133
Feb  3 09:12:12 polegeom kernel: ata2: EH complete
Feb  3 09:12:12 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:12:12 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:12:12 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:12:12 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:12:52 polegeom kernel: ata2.00: limiting speed to UDMA/100:PIO4
Feb  3 09:12:52 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2
Feb  3 09:12:52 polegeom kernel: ata2.00: BMDMA stat 0x5
Feb  3 09:12:52 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  3 09:12:52 polegeom kernel: ata2.00: cmd 35/00:00:d7:19:dc/00:04:07:00:00/e0 tag 0 dma 524288 out
Feb  3 09:12:52 polegeom kernel:          res 51/84:b0:27:1d:dc/84:00:07:00:00/e0 Emask 0x12 (ATA bus error)
Feb  3 09:12:52 polegeom kernel: ata2.00: status: { DRDY ERR }
Feb  3 09:12:52 polegeom kernel: ata2.00: error: { ICRC ABRT }
Feb  3 09:12:52 polegeom kernel: ata2: soft resetting link
Feb  3 09:12:53 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:12:53 polegeom kernel: ata2.00: configured for UDMA/100
Feb  3 09:12:53 polegeom kernel: ata2: EH complete
Feb  3 09:12:53 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:12:53 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:12:53 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:12:53 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:13:37 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  3 09:13:37 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  3 09:13:37 polegeom kernel: ata2.00: cmd 35/00:a0:2f:9a:e3/00:01:07:00:00/e0 tag 0 dma 212992 out
Feb  3 09:13:37 polegeom kernel:          res 40/00:b0:27:1d:dc/84:00:07:00:00/e0 Emask 0x16 (ATA bus error)
Feb  3 09:13:37 polegeom kernel: ata2.00: status: { DRDY }
Feb  3 09:13:43 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  3 09:13:47 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  3 09:13:47 polegeom kernel: ata2: hard resetting link
Feb  3 09:13:48 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:13:48 polegeom kernel: ata2.00: configured for UDMA/100
Feb  3 09:13:48 polegeom kernel: ata2: EH complete
Feb  3 09:13:48 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:13:48 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:13:48 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:13:48 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:14:40 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  3 09:14:40 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  3 09:14:40 polegeom kernel: ata2.00: cmd 35/00:00:47:c3:f2/00:04:07:00:00/e0 tag 0 dma 524288 out
Feb  3 09:14:40 polegeom kernel:          res 40/00:b0:27:1d:dc/84:00:07:00:00/e0 Emask 0x16 (ATA bus error)
Feb  3 09:14:40 polegeom kernel: ata2.00: status: { DRDY }
Feb  3 09:14:45 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  3 09:14:50 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  3 09:14:50 polegeom kernel: ata2: hard resetting link
Feb  3 09:14:50 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:14:50 polegeom kernel: ata2.00: configured for UDMA/100
Feb  3 09:14:50 polegeom kernel: ata2: EH complete
Feb  3 09:14:50 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:14:50 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:14:50 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:14:50 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:15:21 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  3 09:15:21 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  3 09:15:21 polegeom kernel: ata2.00: cmd 35/00:00:57:66:f2/00:04:07:00:00/e0 tag 0 dma 524288 out
Feb  3 09:15:21 polegeom kernel:          res 40/00:b0:27:1d:dc/84:00:07:00:00/e0 Emask 0x16 (ATA bus error)
Feb  3 09:15:21 polegeom kernel: ata2.00: status: { DRDY }
Feb  3 09:15:26 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  3 09:15:31 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  3 09:15:31 polegeom kernel: ata2: hard resetting link
Feb  3 09:15:32 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:15:32 polegeom kernel: ata2.00: configured for UDMA/100
Feb  3 09:15:32 polegeom kernel: ata2: EH complete
Feb  3 09:15:32 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:15:32 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:15:32 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:15:32 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:16:03 polegeom kernel: ata2.00: limiting speed to UDMA/33:PIO4
Feb  3 09:16:03 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  3 09:16:03 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  3 09:16:03 polegeom kernel: ata2.00: cmd 35/00:00:07:c6:f4/00:04:07:00:00/e0 tag 0 dma 524288 out
Feb  3 09:16:03 polegeom kernel:          res 40/00:b0:27:1d:dc/84:00:07:00:00/e0 Emask 0x16 (ATA bus error)
Feb  3 09:16:03 polegeom kernel: ata2.00: status: { DRDY }
Feb  3 09:16:09 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  3 09:16:13 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  3 09:16:13 polegeom kernel: ata2: hard resetting link
Feb  3 09:16:14 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:16:14 polegeom kernel: ata2.00: configured for UDMA/33
Feb  3 09:16:14 polegeom kernel: ata2: EH complete
Feb  3 09:16:14 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:16:14 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:16:14 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:16:14 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 09:16:59 polegeom kernel: ata2.00: exception Emask 0x12 SAct 0x0 SErr 0x1400500 action 0x2 frozen
Feb  3 09:16:59 polegeom kernel: ata2: SError: { UnrecovData Proto Handshk TrStaTrns }
Feb  3 09:16:59 polegeom kernel: ata2.00: cmd 35/00:00:c7:c6:fb/00:04:07:00:00/e0 tag 0 dma 524288 out
Feb  3 09:16:59 polegeom kernel:          res 40/00:b0:27:1d:dc/84:00:07:00:00/e0 Emask 0x16 (ATA bus error)
Feb  3 09:16:59 polegeom kernel: ata2.00: status: { DRDY }
Feb  3 09:17:04 polegeom kernel: ata2: port is slow to respond, please be patient (Status 0xd0)
Feb  3 09:17:09 polegeom kernel: ata2: device not ready (errno=-16), forcing hardreset
Feb  3 09:17:09 polegeom kernel: ata2: hard resetting link
Feb  3 09:17:10 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 09:17:10 polegeom kernel: ata2.00: configured for UDMA/33
Feb  3 09:17:10 polegeom kernel: ata2: EH complete
Feb  3 09:17:10 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 09:17:10 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 09:17:10 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 09:17:10 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 14:13:26 polegeom kernel: Kernel logging (proc) stopped.
Feb  3 14:13:26 polegeom kernel: Kernel log daemon terminating.
Feb  3 14:14:19 polegeom kernel: klogd 1.4.1#18, log source = /proc/kmsg started.
Feb  3 14:14:19 polegeom kernel: 
Feb  3 14:14:19 polegeom kernel: ACPI: Local APIC address 0xfee00000
Feb  3 14:14:19 polegeom kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Feb  3 14:14:19 polegeom kernel: Processor #0 6:10 APIC version 16
Feb  3 14:14:19 polegeom kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Feb  3 14:14:19 polegeom kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Feb  3 14:14:19 polegeom kernel: IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
Feb  3 14:14:19 polegeom kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
Feb  3 14:14:19 polegeom kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Feb  3 14:14:19 polegeom kernel: ACPI: IRQ0 used by override.
Feb  3 14:14:19 polegeom kernel: ACPI: IRQ2 used by override.
Feb  3 14:14:19 polegeom kernel: ACPI: IRQ9 used by override.
Feb  3 14:14:19 polegeom kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb  3 14:14:19 polegeom kernel: Using ACPI (MADT) for SMP configuration information
Feb  3 14:14:19 polegeom kernel: Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Feb  3 14:14:19 polegeom kernel: swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
Feb  3 14:14:19 polegeom kernel: swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000f0000
Feb  3 14:14:19 polegeom kernel: swsusp: Registered nosave memory region: 00000000000f0000 - 0000000000100000
Feb  3 14:14:19 polegeom kernel: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 227584
Feb  3 14:14:19 polegeom kernel: Kernel command line: root=/dev/hdb1 ro 
Feb  3 14:14:19 polegeom kernel: mapped APIC to ffffb000 (fee00000)
Feb  3 14:14:19 polegeom kernel: mapped IOAPIC to ffffa000 (fec00000)
Feb  3 14:14:19 polegeom kernel: Enabling fast FPU save and restore... done.
Feb  3 14:14:19 polegeom kernel: Enabling unmasked SIMD FPU exception support... done.
Feb  3 14:14:19 polegeom kernel: Initializing CPU#0
Feb  3 14:14:19 polegeom kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Feb  3 14:14:19 polegeom kernel: Detected 1916.544 MHz processor.
Feb  3 14:14:19 polegeom kernel: Console: colour VGA+ 80x25
Feb  3 14:14:19 polegeom kernel: console [tty0] enabled
Feb  3 14:14:19 polegeom kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb  3 14:14:19 polegeom kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb  3 14:14:19 polegeom kernel: Memory: 900744k/917504k available (1753k kernel code, 16212k reserved, 721k data, 324k init, 0k highmem)
Feb  3 14:14:19 polegeom kernel: virtual kernel memory layout:
Feb  3 14:14:19 polegeom kernel:     fixmap  : 0xfffb3000 - 0xfffff000   ( 304 kB)
Feb  3 14:14:19 polegeom kernel:     vmalloc : 0xf8800000 - 0xfffb1000   ( 119 MB)
Feb  3 14:14:19 polegeom kernel:     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
Feb  3 14:14:19 polegeom kernel:       .init : 0xc036e000 - 0xc03bf000   ( 324 kB)
Feb  3 14:14:19 polegeom kernel:       .data : 0xc02b6735 - 0xc036ade4   ( 721 kB)
Feb  3 14:14:19 polegeom kernel:       .text : 0xc0100000 - 0xc02b6735   (1753 kB)
Feb  3 14:14:19 polegeom kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb  3 14:14:19 polegeom kernel: Calibrating delay using timer specific routine.. 3836.48 BogoMIPS (lpj=7672976)
Feb  3 14:14:19 polegeom kernel: Security Framework initialized
Feb  3 14:14:19 polegeom kernel: SELinux:  Disabled at boot.
Feb  3 14:14:19 polegeom kernel: Capability LSM initialized
Feb  3 14:14:19 polegeom kernel: Mount-cache hash table entries: 512
Feb  3 14:14:19 polegeom kernel: Initializing cgroup subsys ns
Feb  3 14:14:19 polegeom kernel: Initializing cgroup subsys cpuacct
Feb  3 14:14:19 polegeom kernel: CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000 00000000
Feb  3 14:14:19 polegeom kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Feb  3 14:14:19 polegeom kernel: CPU: L2 Cache: 512K (64 bytes/line)
Feb  3 14:14:19 polegeom kernel: CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000 00000000
Feb  3 14:14:19 polegeom kernel: Compat vDSO mapped to ffffe000.
Feb  3 14:14:19 polegeom kernel: CPU: AMD Athlon(TM) XP 2600+ stepping 00
Feb  3 14:14:19 polegeom kernel: Checking 'hlt' instruction... OK.
Feb  3 14:14:19 polegeom kernel: Freeing SMP alternatives: 0k freed
Feb  3 14:14:19 polegeom kernel: ACPI: Core revision 20070126
Feb  3 14:14:19 polegeom kernel: ENABLING IO-APIC IRQs
Feb  3 14:14:19 polegeom kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Feb  3 14:14:19 polegeom kernel: net_namespace: 64 bytes
Feb  3 14:14:19 polegeom kernel: Booting paravirtualized kernel on bare hardware
Feb  3 14:14:19 polegeom kernel: NET: Registered protocol family 16
Feb  3 14:14:19 polegeom kernel: EISA bus registered
Feb  3 14:14:19 polegeom kernel: ACPI: bus type pci registered
Feb  3 14:14:19 polegeom kernel: PCI: PCI BIOS revision 2.10 entry at 0xf1990, last bus=1
Feb  3 14:14:19 polegeom kernel: PCI: Using configuration type 1
Feb  3 14:14:19 polegeom kernel: Setting up standard PCI resources
Feb  3 14:14:19 polegeom kernel: ACPI: EC: Look up EC in DSDT
Feb  3 14:14:19 polegeom kernel: ACPI: Interpreter enabled
Feb  3 14:14:19 polegeom kernel: ACPI: (supports S0 S1 S4 S5)
Feb  3 14:14:19 polegeom kernel: ACPI: Using IOAPIC for interrupt routing
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb  3 14:14:19 polegeom kernel: PCI quirk: region e400-e47f claimed by vt8235 PM
Feb  3 14:14:19 polegeom kernel: PCI quirk: region e800-e80f claimed by vt8235 SMB
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 9 10 11 12)
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 *5 6 7 9 10 11 12)
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12)
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Feb  3 14:14:19 polegeom kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb  3 14:14:19 polegeom kernel: pnp: PnP ACPI init
Feb  3 14:14:19 polegeom kernel: ACPI: bus type pnp registered
Feb  3 14:14:19 polegeom kernel: pnp: PnP ACPI: found 16 devices
Feb  3 14:14:19 polegeom kernel: ACPI: ACPI bus type pnp unregistered
Feb  3 14:14:19 polegeom kernel: PnPBIOS: Disabled by ACPI PNP
Feb  3 14:14:19 polegeom kernel: PCI: Using ACPI for IRQ routing
Feb  3 14:14:19 polegeom kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Feb  3 14:14:19 polegeom kernel: NET: Registered protocol family 8
Feb  3 14:14:19 polegeom kernel: NET: Registered protocol family 20
Feb  3 14:14:19 polegeom kernel: ACPI: RTC can wake from S4
Feb  3 14:14:19 polegeom kernel: Time: tsc clocksource has been installed.
Feb  3 14:14:19 polegeom kernel: system 00:00: iomem range 0x0-0x9ffff could not be reserved
Feb  3 14:14:19 polegeom kernel: system 00:00: iomem range 0xf0000-0xfffff could not be reserved
Feb  3 14:14:19 polegeom kernel: system 00:00: iomem range 0x100000-0x3fffffff could not be reserved
Feb  3 14:14:19 polegeom kernel: system 00:00: iomem range 0xfec00000-0xfec000ff could not be reserved
Feb  3 14:14:19 polegeom kernel: system 00:00: iomem range 0xfee00000-0xfee00fff could not be reserved
Feb  3 14:14:19 polegeom kernel: system 00:02: ioport range 0xe400-0xe47f has been reserved
Feb  3 14:14:19 polegeom kernel: system 00:02: ioport range 0xe800-0xe81f could not be reserved
Feb  3 14:14:19 polegeom kernel: system 00:02: iomem range 0xfff80000-0xffffffff could not be reserved
Feb  3 14:14:19 polegeom kernel: system 00:02: iomem range 0xffb80000-0xffbfffff has been reserved
Feb  3 14:14:19 polegeom kernel: system 00:03: ioport range 0x4d0-0x4d1 has been reserved
Feb  3 14:14:19 polegeom kernel: system 00:0f: ioport range 0x290-0x297 has been reserved
Feb  3 14:14:19 polegeom kernel: system 00:0f: ioport range 0x370-0x375 has been reserved
Feb  3 14:14:19 polegeom kernel: PCI: Bridge: 0000:00:01.0
Feb  3 14:14:19 polegeom kernel:   IO window: disabled.
Feb  3 14:14:19 polegeom kernel:   MEM window: ee000000-efdfffff
Feb  3 14:14:19 polegeom kernel:   PREFETCH window: eff00000-f7ffffff
Feb  3 14:14:19 polegeom kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
Feb  3 14:14:19 polegeom kernel: NET: Registered protocol family 2
Feb  3 14:14:19 polegeom kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb  3 14:14:19 polegeom kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Feb  3 14:14:19 polegeom kernel: TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
Feb  3 14:14:19 polegeom kernel: TCP: Hash tables configured (established 131072 bind 65536)
Feb  3 14:14:19 polegeom kernel: TCP reno registered
Feb  3 14:14:19 polegeom kernel: checking if image is initramfs... it is
Feb  3 14:14:19 polegeom kernel: Switched to high resolution mode on CPU 0
Feb  3 14:14:19 polegeom kernel: Freeing initrd memory: 5179k freed
Feb  3 14:14:19 polegeom kernel: Simple Boot Flag at 0x3a set to 0x1
Feb  3 14:14:19 polegeom kernel: audit: initializing netlink socket (disabled)
Feb  3 14:14:19 polegeom kernel: audit(1233666828.732:1): initialized
Feb  3 14:14:19 polegeom kernel: Total HugeTLB memory allocated, 0
Feb  3 14:14:19 polegeom kernel: VFS: Disk quotas dquot_6.5.1
Feb  3 14:14:19 polegeom kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Feb  3 14:14:19 polegeom kernel: io scheduler noop registered
Feb  3 14:14:19 polegeom kernel: io scheduler anticipatory registered
Feb  3 14:14:19 polegeom kernel: io scheduler deadline registered
Feb  3 14:14:19 polegeom kernel: io scheduler cfq registered (default)
Feb  3 14:14:19 polegeom kernel: PCI: VIA PCI bridge detected. Disabling DAC.
Feb  3 14:14:19 polegeom kernel: Boot video device is 0000:01:00.0
Feb  3 14:14:19 polegeom kernel: isapnp: Scanning for PnP cards...
Feb  3 14:14:19 polegeom kernel: isapnp: No Plug & Play device found
Feb  3 14:14:19 polegeom kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Feb  3 14:14:19 polegeom kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  3 14:14:19 polegeom kernel: 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  3 14:14:19 polegeom kernel: RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Feb  3 14:14:19 polegeom kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
Feb  3 14:14:19 polegeom kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  3 14:14:19 polegeom kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  3 14:14:19 polegeom kernel: mice: PS/2 mouse device common for all mice
Feb  3 14:14:19 polegeom kernel: EISA: Probing bus 0 at eisa.0
Feb  3 14:14:19 polegeom kernel: EISA: Detected 0 cards.
Feb  3 14:14:19 polegeom kernel: cpuidle: using governor ladder
Feb  3 14:14:19 polegeom kernel: cpuidle: using governor menu
Feb  3 14:14:19 polegeom kernel: TCP bic registered
Feb  3 14:14:19 polegeom kernel: NET: Registered protocol family 1
Feb  3 14:14:19 polegeom kernel: NET: Registered protocol family 17
Feb  3 14:14:19 polegeom kernel: Using IPI Shortcut mode
Feb  3 14:14:19 polegeom kernel: registered taskstats version 1
Feb  3 14:14:19 polegeom kernel: Freeing unused kernel memory: 324k freed
Feb  3 14:14:19 polegeom kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Feb  3 14:14:19 polegeom kernel: SCSI subsystem initialized
Feb  3 14:14:19 polegeom kernel: usbcore: registered new interface driver usbfs
Feb  3 14:14:19 polegeom kernel: usbcore: registered new interface driver hub
Feb  3 14:14:19 polegeom kernel: usbcore: registered new device driver usb
Feb  3 14:14:19 polegeom kernel: USB Universal Host Controller Interface driver v3.0
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 16
Feb  3 14:14:19 polegeom kernel: uhci_hcd 0000:00:10.0: UHCI Host Controller
Feb  3 14:14:19 polegeom kernel: uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
Feb  3 14:14:19 polegeom kernel: uhci_hcd 0000:00:10.0: irq 16, io base 0x0000a800
Feb  3 14:14:19 polegeom kernel: usb usb1: configuration #1 chosen from 1 choice
Feb  3 14:14:19 polegeom kernel: hub 1-0:1.0: USB hub found
Feb  3 14:14:19 polegeom kernel: hub 1-0:1.0: 2 ports detected
Feb  3 14:14:19 polegeom kernel: libata version 3.00 loaded.
Feb  3 14:14:19 polegeom kernel: via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 21 (level, low) -> IRQ 16
Feb  3 14:14:19 polegeom kernel: uhci_hcd 0000:00:10.1: UHCI Host Controller
Feb  3 14:14:19 polegeom kernel: uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
Feb  3 14:14:19 polegeom kernel: uhci_hcd 0000:00:10.1: irq 16, io base 0x0000a400
Feb  3 14:14:19 polegeom kernel: usb usb2: configuration #1 chosen from 1 choice
Feb  3 14:14:19 polegeom kernel: hub 2-0:1.0: USB hub found
Feb  3 14:14:19 polegeom kernel: hub 2-0:1.0: 2 ports detected
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.2[C] -> GSI 21 (level, low) -> IRQ 16
Feb  3 14:14:19 polegeom kernel: uhci_hcd 0000:00:10.2: UHCI Host Controller
Feb  3 14:14:19 polegeom kernel: uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
Feb  3 14:14:19 polegeom kernel: uhci_hcd 0000:00:10.2: irq 16, io base 0x0000a000
Feb  3 14:14:19 polegeom kernel: usb usb3: configuration #1 chosen from 1 choice
Feb  3 14:14:19 polegeom kernel: hub 3-0:1.0: USB hub found
Feb  3 14:14:19 polegeom kernel: hub 3-0:1.0: 2 ports detected
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 16
Feb  3 14:14:19 polegeom kernel: ehci_hcd 0000:00:10.3: EHCI Host Controller
Feb  3 14:14:19 polegeom kernel: ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
Feb  3 14:14:19 polegeom kernel: ehci_hcd 0000:00:10.3: irq 16, io mem 0xed800000
Feb  3 14:14:19 polegeom kernel: ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Feb  3 14:14:19 polegeom kernel: usb usb4: configuration #1 chosen from 1 choice
Feb  3 14:14:19 polegeom kernel: hub 4-0:1.0: USB hub found
Feb  3 14:14:19 polegeom kernel: hub 4-0:1.0: 6 ports detected
Feb  3 14:14:19 polegeom kernel: sata_via 0000:00:0b.0: version 2.3
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 19 (level, low) -> IRQ 17
Feb  3 14:14:19 polegeom kernel: sata_via 0000:00:0b.0: routed to hard irq line 3
Feb  3 14:14:19 polegeom kernel: scsi0 : sata_via
Feb  3 14:14:19 polegeom kernel: scsi1 : sata_via
Feb  3 14:14:19 polegeom kernel: scsi2 : sata_via
Feb  3 14:14:19 polegeom kernel: ata1: SATA max UDMA/133 port i16@0xd800 bmdma 0xb400 irq 17
Feb  3 14:14:19 polegeom kernel: ata2: SATA max UDMA/133 port i16@0xd400 bmdma 0xb408 irq 17
Feb  3 14:14:19 polegeom kernel: ata3: PATA max UDMA/133 port i16@0xd000 bmdma 0xb410 irq 17
Feb  3 14:14:19 polegeom kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 14:14:19 polegeom kernel: ata1.00: ATA-7: ST3250824AS, 3.AAH, max UDMA/133
Feb  3 14:14:19 polegeom kernel: ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Feb  3 14:14:19 polegeom kernel: ata1.00: configured for UDMA/133
Feb  3 14:14:19 polegeom kernel: usb 4-3: new high speed USB device using ehci_hcd and address 2
Feb  3 14:14:19 polegeom kernel: usb 4-3: configuration #1 chosen from 1 choice
Feb  3 14:14:19 polegeom kernel: Initializing USB Mass Storage driver...
Feb  3 14:14:19 polegeom kernel: scsi3 : SCSI emulation for USB Mass Storage devices
Feb  3 14:14:19 polegeom kernel: usbcore: registered new interface driver usb-storage
Feb  3 14:14:19 polegeom kernel: USB Mass Storage support registered.
Feb  3 14:14:19 polegeom kernel: usb-storage: device found at 2
Feb  3 14:14:19 polegeom kernel: usb-storage: waiting for device to settle before scanning
Feb  3 14:14:19 polegeom kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
Feb  3 14:14:19 polegeom kernel: ata2.00: ATA-8: SAMSUNG HD501LJ, CR100-13, max UDMA7
Feb  3 14:14:19 polegeom kernel: ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
Feb  3 14:14:19 polegeom kernel: ata2.00: configured for UDMA/133
Feb  3 14:14:19 polegeom kernel: scsi 0:0:0:0: Direct-Access     ATA      ST3250824AS      3.AA PQ: 0 ANSI: 5
Feb  3 14:14:19 polegeom kernel: scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG HD501LJ  CR10 PQ: 0 ANSI: 5
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 18
Feb  3 14:14:19 polegeom kernel: eth0: VIA Rhine II at 0x19400, 00:0e:a6:6a:1c:1f, IRQ 18.
Feb  3 14:14:19 polegeom kernel: eth0: MII PHY found at address 1, status 0x786d advertising 01e1 Link c5e1.
Feb  3 14:14:19 polegeom kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb  3 14:14:19 polegeom kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb  3 14:14:19 polegeom kernel: VP_IDE: IDE controller (0x1106:0x0571 rev 0x06) at  PCI slot 0000:00:11.1
Feb  3 14:14:19 polegeom kernel: ACPI: Unable to derive IRQ for device 0000:00:11.1
Feb  3 14:14:19 polegeom kernel: VP_IDE: not 100%% native mode: will probe irqs later
Feb  3 14:14:19 polegeom kernel: VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
Feb  3 14:14:19 polegeom kernel:     ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:pio, hdb:DMA
Feb  3 14:14:19 polegeom kernel:     ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:pio
Feb  3 14:14:19 polegeom kernel: Probing IDE interface ide0...
Feb  3 14:14:19 polegeom kernel: Driver 'sd' needs updating - please use bus_type methods
Feb  3 14:14:19 polegeom kernel: sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
Feb  3 14:14:19 polegeom kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb  3 14:14:19 polegeom kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb  3 14:14:19 polegeom kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 14:14:19 polegeom kernel: sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
Feb  3 14:14:19 polegeom kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb  3 14:14:19 polegeom kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb  3 14:14:19 polegeom kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 14:14:19 polegeom kernel:  sda: [LDM] sda1
Feb  3 14:14:19 polegeom kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Feb  3 14:14:19 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 14:14:19 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 14:14:19 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 14:14:19 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 14:14:19 polegeom kernel: sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
Feb  3 14:14:19 polegeom kernel: sd 1:0:0:0: [sdb] Write Protect is off
Feb  3 14:14:19 polegeom kernel: sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Feb  3 14:14:19 polegeom kernel: sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb  3 14:14:19 polegeom kernel:  sdb: sdb1
Feb  3 14:14:19 polegeom kernel: sd 1:0:0:0: [sdb] Attached SCSI disk
Feb  3 14:14:19 polegeom kernel: hdb: ST380215A, ATA DISK drive
Feb  3 14:14:19 polegeom kernel: hdb: host max PIO5 wanted PIO255(auto-tune) selected PIO4
Feb  3 14:14:19 polegeom kernel: hdb: UDMA/100 mode selected
Feb  3 14:14:19 polegeom kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  3 14:14:19 polegeom kernel: Probing IDE interface ide1...
Feb  3 14:14:19 polegeom kernel: hdc: SONY DVD-ROM DDU1612, ATAPI CD/DVD-ROM drive
Feb  3 14:14:19 polegeom kernel: hdc: host max PIO5 wanted PIO255(auto-tune) selected PIO4
Feb  3 14:14:19 polegeom kernel: hdc: UDMA/33 mode selected
Feb  3 14:14:19 polegeom kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb  3 14:14:19 polegeom kernel: hdb: max request size: 512KiB
Feb  3 14:14:19 polegeom kernel: hdb: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=16383/255/63
Feb  3 14:14:19 polegeom kernel: hdb: cache flushes supported
Feb  3 14:14:19 polegeom kernel:  hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 >
Feb  3 14:14:19 polegeom kernel: hdc: ATAPI 40X DVD-ROM drive, 512kB Cache
Feb  3 14:14:19 polegeom kernel: Uniform CD-ROM driver Revision: 3.20
Feb  3 14:14:19 polegeom kernel: device-mapper: uevent: version 1.0.3
Feb  3 14:14:19 polegeom kernel: device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
Feb  3 14:14:19 polegeom kernel: Attempting manual resume
Feb  3 14:14:19 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 14:14:19 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 14:14:19 polegeom kernel: Linux agpgart interface v0.102
Feb  3 14:14:19 polegeom kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Feb  3 14:14:19 polegeom kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Feb  3 14:14:19 polegeom kernel: agpgart: Detected VIA KT400/KT400A/KT600 chipset
Feb  3 14:14:19 polegeom kernel: agpgart: AGP aperture is 64M @ 0xf8000000
Feb  3 14:14:19 polegeom kernel: input: Power Button (FF) as /class/input/input1
Feb  3 14:14:19 polegeom kernel: ACPI: Power Button (FF) [PWRF]
Feb  3 14:14:19 polegeom kernel: input: Power Button (CM) as /class/input/input2
Feb  3 14:14:19 polegeom kernel: usb-storage: device scan complete
Feb  3 14:14:19 polegeom kernel: scsi 3:0:0:0: Direct-Access     SAMSUNG  HD753LJ               PQ: 0 ANSI: 2
Feb  3 14:14:19 polegeom kernel: sd 3:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
Feb  3 14:14:19 polegeom kernel: sd 3:0:0:0: [sdc] Write Protect is off
Feb  3 14:14:19 polegeom kernel: sd 3:0:0:0: [sdc] Mode Sense: 38 00 00 00
Feb  3 14:14:19 polegeom kernel: sd 3:0:0:0: [sdc] Assuming drive cache: write through
Feb  3 14:14:19 polegeom kernel: sd 3:0:0:0: [sdc] 1465149168 512-byte hardware sectors (750156 MB)
Feb  3 14:14:19 polegeom kernel: sd 3:0:0:0: [sdc] Write Protect is off
Feb  3 14:14:19 polegeom kernel: sd 3:0:0:0: [sdc] Mode Sense: 38 00 00 00
Feb  3 14:14:19 polegeom kernel: sd 3:0:0:0: [sdc] Assuming drive cache: write through
Feb  3 14:14:19 polegeom kernel:  sdc:<6>ACPI: Power Button (CM) [PWRB]
Feb  3 14:14:19 polegeom kernel: irda_init()
Feb  3 14:14:19 polegeom kernel: NET: Registered protocol family 23
Feb  3 14:14:19 polegeom kernel: Real Time Clock Driver v1.12ac
Feb  3 14:14:19 polegeom kernel: input: PC Speaker as /class/input/input3
Feb  3 14:14:19 polegeom kernel: ACPI: PCI Interrupt 0000:00:11.5[C] -> GSI 22 (level, low) -> IRQ 19
Feb  3 14:14:19 polegeom kernel: PCI: Setting latency timer of device 0000:00:11.5 to 64
Feb  3 14:14:19 polegeom kernel: Floppy drive(s): fd0 is 1.44M
Feb  3 14:14:19 polegeom kernel: FDC 0 is a post-1991 82077
Feb  3 14:14:19 polegeom kernel: input: ImExPS/2 Generic Explorer Mouse as /class/input/input4
Feb  3 14:14:19 polegeom kernel: parport_pc 00:09: reported by Plug and Play ACPI
Feb  3 14:14:19 polegeom kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
Feb  3 14:14:19 polegeom kernel: codec_read: codec 0 is not valid [0x107e5370]
Feb  3 14:14:19 polegeom last message repeated 3 times
Feb  3 14:14:19 polegeom kernel: Adding 7992k swap on /dev/hdb6.  Priority:-1 extents:1 across:7992k
Feb  3 14:14:19 polegeom kernel: EXT3 FS on hdb1, internal journal
Feb  3 14:14:19 polegeom kernel: loop: module loaded
Feb  3 14:14:19 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 14:14:19 polegeom kernel: EXT3 FS on hdb3, internal journal
Feb  3 14:14:19 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 14:14:19 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 14:14:19 polegeom kernel: EXT3 FS on hdb2, internal journal
Feb  3 14:14:19 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 14:14:19 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 14:14:19 polegeom kernel: EXT3 FS on hdb5, internal journal
Feb  3 14:14:19 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 14:14:19 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 14:14:19 polegeom kernel: EXT3 FS on hdb7, internal journal
Feb  3 14:14:19 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 14:14:19 polegeom kernel: NTFS driver 2.1.29 [Flags: R/W MODULE].
Feb  3 14:14:19 polegeom kernel: NTFS volume version 3.1.
Feb  3 14:14:19 polegeom kernel: NTFS-fs error (device sda1): load_system_files(): Volume is dirty.  Mounting read-only.  Run chkdsk and mount in Windows.
Feb  3 14:14:19 polegeom kernel: kjournald starting.  Commit interval 5 seconds
Feb  3 14:14:19 polegeom kernel: EXT3 FS on dm-0, internal journal
Feb  3 14:14:19 polegeom kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb  3 14:14:19 polegeom kernel:  sdc1
Feb  3 14:14:19 polegeom kernel: sd 3:0:0:0: [sdc] Attached SCSI disk
Feb  3 14:14:19 polegeom kernel: eth0: link up, 100Mbps, full-duplex, lpa 0xC5E1
Feb  3 14:14:26 polegeom kernel: NET: Registered protocol family 10
Feb  3 14:14:26 polegeom kernel: lo: Disabled Privacy Extensions
Feb  3 14:14:36 polegeom kernel: eth0: no IPv6 routers present

--veXX9dWIonWZEC6h--
