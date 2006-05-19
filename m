From: viet@mandriva.com
Subject: pdc20575 and driver 1.04
Date: Fri, 19 May 2006 18:15:43 +0200
Message-ID: <200605191815.44099.viet@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2-g19.free.fr ([212.27.42.28]:52124 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932443AbWESQPj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 May 2006 12:15:39 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

We've briefly met at Deauville while you were working with mandriva
I hope everything is fine with you - I myself have just been laid off, just about six years after joining mandrake ...

Anyway, back to business.
I have a Promise sataII TX2+ cards, with a pdc 20575.

I have just tried stock 2.6.17-rc4 and applied 2.6.17-rc4-git2-libata1.patch.bz2
I am only detecting the two sata lines.
the motherboard is smp, and has pdc20265 onboard. there are 4 drives attached to the TX2+ (two sata, two pata)

If I am not mistaken, driver version 1.04 is the latest one you have ?

Do you have any idea why it's not detecting the pata channel ?

Thanks !


my log follows :

May 19 14:03:08 anoath kernel: nfsd: last server has exited
May 19 14:03:08 anoath kernel: nfsd: unexporting all filesystems
May 19 14:03:08 anoath kernel: Kernel logging (proc) stopped.
May 19 14:03:08 anoath kernel: Kernel log daemon terminating.
May 19 14:08:36 anoath kernel: klogd 1.4.1#17, log source = /proc/kmsg started.
May 19 14:08:36 anoath kernel: Inspecting /boot/System.map-2.6.17-rc4
May 19 14:08:37 anoath kernel: Loaded 20178 symbols from /boot/System.map-2.6.17-rc4.
May 19 14:08:37 anoath kernel: Symbols match kernel version 2.6.17.
May 19 14:08:37 anoath kernel: No module symbols loaded - kernel modules not enabled. 
May 19 14:08:37 anoath kernel: Linux version 2.6.17-rc4 (root@rogue) (gcc version 4.0.3) #1 SMP Fri May 19 12:19:13 CEST 2006
May 19 14:08:37 anoath kernel: BIOS-provided physical RAM map:
May 19 14:08:37 anoath kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
May 19 14:08:37 anoath kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
May 19 14:08:37 anoath kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
May 19 14:08:37 anoath kernel:  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
May 19 14:08:37 anoath kernel:  BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
May 19 14:08:37 anoath kernel:  BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
May 19 14:08:37 anoath kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
May 19 14:08:37 anoath kernel: 1151MB HIGHMEM available.
May 19 14:08:37 anoath kernel: 896MB LOWMEM available.
May 19 14:08:37 anoath kernel: found SMP MP-table at 000f5c70
May 19 14:08:37 anoath kernel: On node 0 totalpages: 524272
May 19 14:08:37 anoath kernel:   DMA zone: 4096 pages, LIFO batch:0
May 19 14:08:37 anoath kernel:   Normal zone: 225280 pages, LIFO batch:31
May 19 14:08:37 anoath kernel:   HighMem zone: 294896 pages, LIFO batch:31
May 19 14:08:37 anoath kernel: DMI 2.2 present.
May 19 14:08:37 anoath kernel: ACPI: RSDP (v000 VIA694                                ) @ 0x000f74c0
May 19 14:08:37 anoath kernel: ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x7fff3000
May 19 14:08:37 anoath kernel: ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x7fff3040
May 19 14:08:37 anoath kernel: ACPI: MADT (v001 VIA694          0x00000000  0x00000000) @ 0x7fff5900
May 19 14:08:37 anoath kernel: ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
May 19 14:08:37 anoath kernel: ACPI: PM-Timer IO Port: 0x4008
May 19 14:08:37 anoath kernel: ACPI: Local APIC address 0xfee00000
May 19 14:08:37 anoath kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
May 19 14:08:37 anoath kernel: Processor #0 6:8 APIC version 17
May 19 14:08:37 anoath kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
May 19 14:08:37 anoath kernel: Processor #1 6:8 APIC version 17
May 19 14:08:37 anoath kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
May 19 14:08:37 anoath kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
May 19 14:08:37 anoath kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
May 19 14:08:37 anoath kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 dfl dfl)
May 19 14:08:37 anoath kernel: ACPI: IRQ0 used by override.
May 19 14:08:37 anoath kernel: ACPI: IRQ2 used by override.
May 19 14:08:37 anoath kernel: ACPI: IRQ11 used by override.
May 19 14:08:37 anoath kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
May 19 14:08:37 anoath kernel: Using ACPI (MADT) for SMP configuration information
May 19 14:08:37 anoath kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
May 19 14:08:37 anoath kernel: Built 1 zonelists
May 19 14:08:37 anoath kernel: Kernel command line: root=/dev/hda1 ro 
May 19 14:08:37 anoath kernel: mapped APIC to ffffd000 (fee00000)
May 19 14:08:37 anoath kernel: mapped IOAPIC to ffffc000 (fec00000)
May 19 14:08:37 anoath kernel: Enabling fast FPU save and restore... done.
May 19 14:08:37 anoath kernel: Enabling unmasked SIMD FPU exception support... done.
May 19 14:08:37 anoath kernel: Initializing CPU#0
May 19 14:08:37 anoath kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
May 19 14:08:37 anoath kernel: Detected 1002.467 MHz processor.
May 19 14:08:37 anoath kernel: Using pmtmr for high-res timesource
May 19 14:08:37 anoath kernel: Console: colour VGA+ 80x25
May 19 14:08:37 anoath kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
May 19 14:08:37 anoath kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
May 19 14:08:37 anoath kernel: Memory: 2075372k/2097088k available (2057k kernel code, 20488k reserved, 640k data, 216k init, 1179584k highmem)
May 19 14:08:37 anoath kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
May 19 14:08:37 anoath kernel: Calibrating delay using timer specific routine.. 2006.86 BogoMIPS (lpj=4013735)
May 19 14:08:37 anoath kernel: Mount-cache hash table entries: 512
May 19 14:08:37 anoath kernel: CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
May 19 14:08:37 anoath kernel: CPU: After vendor identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
May 19 14:08:37 anoath kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 19 14:08:37 anoath kernel: CPU: L2 cache: 256K
May 19 14:08:37 anoath kernel: CPU serial number disabled.
May 19 14:08:37 anoath kernel: CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
May 19 14:08:37 anoath kernel: Intel machine check architecture supported.
May 19 14:08:37 anoath kernel: Intel machine check reporting enabled on CPU#0.
May 19 14:08:37 anoath kernel: Checking 'hlt' instruction... OK.
May 19 14:08:37 anoath kernel: Freeing SMP alternatives: 16k freed
May 19 14:08:37 anoath kernel: CPU0: Intel Pentium III (Coppermine) stepping 0a
May 19 14:08:37 anoath kernel: Booting processor 1/1 eip 2000
May 19 14:08:37 anoath kernel: Initializing CPU#1
May 19 14:08:37 anoath kernel: Calibrating delay using timer specific routine.. 2004.76 BogoMIPS (lpj=4009526)
May 19 14:08:37 anoath kernel: CPU: After generic identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
May 19 14:08:37 anoath kernel: CPU: After vendor identify, caps: 0387fbff 00000000 00000000 00000000 00000000 00000000 00000000
May 19 14:08:37 anoath kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 19 14:08:37 anoath kernel: CPU: L2 cache: 256K
May 19 14:08:37 anoath kernel: CPU serial number disabled.
May 19 14:08:37 anoath kernel: CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
May 19 14:08:37 anoath kernel: Intel machine check architecture supported.
May 19 14:08:37 anoath kernel: Intel machine check reporting enabled on CPU#1.
May 19 14:08:37 anoath kernel: CPU1: Intel Pentium III (Coppermine) stepping 0a
May 19 14:08:37 anoath kernel: Total of 2 processors activated (4011.63 BogoMIPS).
May 19 14:08:37 anoath kernel: ENABLING IO-APIC IRQs
May 19 14:08:37 anoath kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
May 19 14:08:37 anoath kernel: checking TSC synchronization across 2 CPUs: passed.
May 19 14:08:37 anoath kernel: Brought up 2 CPUs
May 19 14:08:37 anoath kernel: migration_cost=4000
May 19 14:08:37 anoath kernel: NET: Registered protocol family 16
May 19 14:08:37 anoath kernel: ACPI: bus type pci registered
May 19 14:08:37 anoath kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=1
May 19 14:08:37 anoath kernel: Setting up standard PCI resources
May 19 14:08:37 anoath kernel: mtrr: your CPUs had inconsistent variable MTRR settings
May 19 14:08:37 anoath kernel: mtrr: probably your BIOS does not setup all CPUs.
May 19 14:08:37 anoath kernel: mtrr: corrected configuration.
May 19 14:08:37 anoath kernel: ACPI: Subsystem revision 20060127
May 19 14:08:37 anoath kernel: ACPI: Interpreter enabled
May 19 14:08:37 anoath kernel: ACPI: Using IOAPIC for interrupt routing
May 19 14:08:37 anoath kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
May 19 14:08:37 anoath kernel: PCI: Probing PCI hardware (bus 00)
May 19 14:08:37 anoath kernel: ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
May 19 14:08:37 anoath kernel: PCI quirk: region 6000-607f claimed by vt82c686 HW-mon
May 19 14:08:37 anoath kernel: PCI quirk: region 5000-500f claimed by vt82c686 SMB
May 19 14:08:37 anoath kernel: Boot video device is 0000:01:00.0
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 11 12 14 15) *9
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
May 19 14:08:37 anoath kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
May 19 14:08:37 anoath kernel: pnp: PnP ACPI init
May 19 14:08:37 anoath kernel: pnp: PnP ACPI: found 12 devices
May 19 14:08:37 anoath kernel: PnPBIOS: Disabled by ACPI PNP
May 19 14:08:37 anoath kernel: PCI: Using ACPI for IRQ routing
May 19 14:08:37 anoath kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
May 19 14:08:37 anoath kernel: PCI: Bridge: 0000:00:01.0
May 19 14:08:37 anoath kernel:   IO window: disabled.
May 19 14:08:37 anoath kernel:   MEM window: d6000000-d7ffffff
May 19 14:08:37 anoath kernel:   PREFETCH window: d4000000-d5ffffff
May 19 14:08:37 anoath kernel: PCI: Setting latency timer of device 0000:00:01.0 to 64
May 19 14:08:37 anoath kernel: NET: Registered protocol family 2
May 19 14:08:37 anoath kernel: IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
May 19 14:08:37 anoath kernel: TCP established hash table entries: 262144 (order: 9, 2097152 bytes)
May 19 14:08:37 anoath kernel: TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
May 19 14:08:37 anoath kernel: TCP: Hash tables configured (established 262144 bind 65536)
May 19 14:08:37 anoath kernel: TCP reno registered
May 19 14:08:37 anoath kernel: IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
May 19 14:08:37 anoath kernel: apm: BIOS not found.
May 19 14:08:37 anoath kernel: highmem bounce pool size: 64 pages
May 19 14:08:37 anoath kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
May 19 14:08:37 anoath kernel: Initializing Cryptographic API
May 19 14:08:37 anoath kernel: io scheduler noop registered
May 19 14:08:37 anoath kernel: io scheduler anticipatory registered (default)
May 19 14:08:37 anoath kernel: io scheduler deadline registered
May 19 14:08:37 anoath kernel: io scheduler cfq registered
May 19 14:08:37 anoath kernel: PCI: Enabling Via external APIC routing
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
May 19 14:08:37 anoath kernel: nvidiafb: PCI id - 10de0028
May 19 14:08:37 anoath kernel: nvidiafb: Actual id - 10de0028
May 19 14:08:37 anoath kernel: nvidiafb: nVidia device/chipset 10DE0028
May 19 14:08:37 anoath kernel: nvidiafb: HW is currently programmed for CRT
May 19 14:08:37 anoath kernel: nvidiafb: Using CRT on CRTC 0
May 19 14:08:37 anoath kernel: nvidiafb: MTRR set to ON
May 19 14:08:37 anoath kernel: Console: switching to colour frame buffer device 80x30
May 19 14:08:37 anoath kernel: nvidiafb: PCI nVidia NV2 framebuffer (16MB @ 0xD4000000)
May 19 14:08:37 anoath kernel: ACPI: Power Button (FF) [PWRF]
May 19 14:08:37 anoath kernel: ACPI: Power Button (CM) [PWRB]
May 19 14:08:37 anoath kernel: ACPI: Sleep Button (CM) [SLPB]
May 19 14:08:37 anoath kernel: isapnp: Scanning for PnP cards...
May 19 14:08:37 anoath kernel: isapnp: No Plug & Play device found
May 19 14:08:37 anoath kernel: Floppy drive(s): fd0 is 1.44M
May 19 14:08:37 anoath kernel: FDC 0 is a post-1991 82077
May 19 14:08:37 anoath kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
May 19 14:08:37 anoath kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
May 19 14:08:37 anoath kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 19 14:08:37 anoath kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
May 19 14:08:37 anoath kernel: VP_IDE: chipset revision 6
May 19 14:08:37 anoath kernel: VP_IDE: not 100%% native mode: will probe irqs later
May 19 14:08:37 anoath kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
May 19 14:08:37 anoath kernel:     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:DMA
May 19 14:08:37 anoath kernel:     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
May 19 14:08:37 anoath kernel: Probing IDE interface ide0...
May 19 14:08:37 anoath kernel: hda: Maxtor 6Y120P0, ATA DISK drive
May 19 14:08:37 anoath kernel: hdb: MAXTOR 6L080J4, ATA DISK drive
May 19 14:08:37 anoath kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 19 14:08:37 anoath kernel: Probing IDE interface ide1...
May 19 14:08:37 anoath kernel: Probing IDE interface ide1...
May 19 14:08:37 anoath kernel: hda: max request size: 128KiB
May 19 14:08:37 anoath kernel: hda: 240121728 sectors (122942 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
May 19 14:08:37 anoath kernel: hda: cache flushes supported
May 19 14:08:37 anoath kernel:  hda: hda1
May 19 14:08:37 anoath kernel: hdb: max request size: 128KiB
May 19 14:08:37 anoath kernel: hdb: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63, UDMA(100)
May 19 14:08:37 anoath kernel: hdb: cache flushes supported
May 19 14:08:37 anoath kernel:  hdb: hdb1
May 19 14:08:37 anoath kernel: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
May 19 14:08:37 anoath kernel: PNP: PS/2 controller doesn't have AUX irq; using default 12
May 19 14:08:37 anoath kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
May 19 14:08:37 anoath kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
May 19 14:08:37 anoath kernel: mice: PS/2 mouse device common for all mice
May 19 14:08:37 anoath kernel: TCP bic registered
May 19 14:08:37 anoath kernel: Starting balanced_irq
May 19 14:08:37 anoath kernel: Using IPI Shortcut mode
May 19 14:08:37 anoath kernel: kjournald starting.  Commit interval 5 seconds
May 19 14:08:37 anoath kernel: EXT3-fs: mounted filesystem with ordered data mode.
May 19 14:08:37 anoath kernel: VFS: Mounted root (ext3 filesystem) readonly.
May 19 14:08:37 anoath kernel: Freeing unused kernel memory: 216k freed
May 19 14:08:37 anoath kernel: input: AT Translated Set 2 keyboard as /class/input/input0
May 19 14:08:37 anoath kernel: NET: Registered protocol family 1
May 19 14:08:37 anoath kernel: Linux agpgart interface v0.101 (c) Dave Jones
May 19 14:08:37 anoath kernel: agpgart: Detected VIA Apollo Pro 133 chipset
May 19 14:08:37 anoath kernel: agpgart: AGP aperture is 64M @ 0xd0000000
May 19 14:08:37 anoath kernel: usbcore: registered new driver usbfs
May 19 14:08:37 anoath kernel: usbcore: registered new driver hub
May 19 14:08:37 anoath kernel: ieee1394: Initialized config rom entry `ip1394'
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 177
May 19 14:08:37 anoath kernel: ohci1394: fw-host0: Get PHY Reg timeout [0x00000000/0x00000000/100]
May 19 14:08:37 anoath kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[177]  MMIO=[d9106000-d91067ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
May 19 14:08:37 anoath kernel: ohci1394: fw-host0: Get PHY Reg timeout [0x00000000/0x00000000/100]
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 16 (level, low) -> IRQ 169
May 19 14:08:37 anoath kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
May 19 14:08:37 anoath kernel: 0000:00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at f887e000.
May 19 14:08:37 anoath kernel: SCSI subsystem initialized
May 19 14:08:37 anoath kernel: libata version 1.30 loaded.
May 19 14:08:37 anoath kernel: Intel(R) PRO/1000 Network Driver - version 7.0.33-k2
May 19 14:08:37 anoath kernel: Copyright (c) 1999-2005 Intel Corporation.
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 18 (level, low) -> IRQ 185
May 19 14:08:37 anoath kernel: USB Universal Host Controller Interface driver v3.0
May 19 14:08:37 anoath kernel: e1000: 0000:00:10.0: e1000_probe: (PCI:33MHz:32-bit) 00:04:23:56:32:e2
May 19 14:08:37 anoath kernel: input: PC Speaker as /class/input/input1
May 19 14:08:37 anoath kernel: e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:10.1[B] -> GSI 19 (level, low) -> IRQ 177
May 19 14:08:37 anoath kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
May 19 14:08:37 anoath kernel: e1000: 0000:00:10.1: e1000_probe: (PCI:33MHz:32-bit) 00:04:23:56:32:e3
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_ecp_read_data
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_epp_read_data
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_wait_peripheral
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_read_nibble
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_read_byte
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_wait_event
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_epp_read_addr
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_announce_port
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_write_compat
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_epp_write_data
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_interrupt
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_put_port
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_epp_write_addr
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_remove_port
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_register_port
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_ecp_write_addr
May 19 14:08:37 anoath kernel: parport_pc: Unknown symbol parport_ieee1284_ecp_write_data
May 19 14:08:37 anoath kernel: Real Time Clock Driver v1.12ac
May 19 14:08:37 anoath kernel: e1000: eth2: e1000_probe: Intel(R) PRO/1000 Network Connection
May 19 14:08:37 anoath kernel: parport_pc: VIA 686A/8231 detected
May 19 14:08:37 anoath kernel: parport_pc: probing current configuration
May 19 14:08:37 anoath kernel: parport_pc: Current parallel port base: 0x378
May 19 14:08:37 anoath kernel: parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
May 19 14:08:37 anoath kernel: uhci_hcd 0000:00:07.2: UHCI Host Controller
May 19 14:08:37 anoath kernel: uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
May 19 14:08:37 anoath kernel: uhci_hcd 0000:00:07.2: irq 10, io base 0x0000a400
May 19 14:08:37 anoath kernel: usb usb1: configuration #1 chosen from 1 choice
May 19 14:08:37 anoath kernel: hub 1-0:1.0: USB hub found
May 19 14:08:37 anoath kernel: hub 1-0:1.0: 2 ports detected
May 19 14:08:37 anoath kernel: parport_pc: VIA parallel port: io=0x378, irq=7
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:07.3[D] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
May 19 14:08:37 anoath kernel: uhci_hcd 0000:00:07.3: UHCI Host Controller
May 19 14:08:37 anoath kernel: uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
May 19 14:08:37 anoath kernel: uhci_hcd 0000:00:07.3: irq 10, io base 0x0000a800
May 19 14:08:37 anoath kernel: usb usb2: configuration #1 chosen from 1 choice
May 19 14:08:37 anoath kernel: hub 2-0:1.0: USB hub found
May 19 14:08:37 anoath kernel: hub 2-0:1.0: 2 ports detected
May 19 14:08:37 anoath kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
May 19 14:08:37 anoath kernel: ohci1394: fw-host0: Get PHY Reg timeout [0x00000000/0x00000000/100]
May 19 14:08:37 anoath kernel: PDC20265: IDE controller at PCI slot 0000:00:0c.0
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 18 (level, low) -> IRQ 185
May 19 14:08:37 anoath kernel: PDC20265: chipset revision 2
May 19 14:08:37 anoath kernel: PDC20265: ROM enabled at 0x880c0000
May 19 14:08:37 anoath kernel: PDC20265: 100%% native mode on irq 185
May 19 14:08:37 anoath kernel: PDC20265: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
May 19 14:08:37 anoath kernel:     ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:pio, hdf:pio
May 19 14:08:37 anoath kernel:     ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:pio, hdh:pio
May 19 14:08:37 anoath kernel: Probing IDE interface ide2...
May 19 14:08:37 anoath kernel: serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
May 19 14:08:37 anoath kernel: 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
May 19 14:08:37 anoath kernel: 00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
May 19 14:08:37 anoath kernel: Probing IDE interface ide3...
May 19 14:08:37 anoath kernel: usb 2-2: new full speed USB device using uhci_hcd and address 2
May 19 14:08:37 anoath kernel: sata_promise 0000:00:11.0: version 1.04
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:11.0[A] -> GSI 19 (level, low) -> IRQ 177
May 19 14:08:37 anoath kernel: ata1: SATA max UDMA/133 cmd 0xFA948200 ctl 0xFA948238 bmdma 0x0 irq 177
May 19 14:08:37 anoath kernel: ata2: SATA max UDMA/133 cmd 0xFA948280 ctl 0xFA9482B8 bmdma 0x0 irq 177
May 19 14:08:37 anoath kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 19 14:08:37 anoath kernel: ata1.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
May 19 14:08:37 anoath kernel: ata1.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
May 19 14:08:37 anoath kernel: ata1.00: configured for UDMA/133
May 19 14:08:37 anoath kernel: scsi0 : sata_promise
May 19 14:08:37 anoath kernel: ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
May 19 14:08:37 anoath kernel: ata2.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
May 19 14:08:37 anoath kernel: ata2.00: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 0/32)
May 19 14:08:37 anoath kernel: ata2.00: configured for UDMA/133
May 19 14:08:37 anoath kernel: scsi1 : sata_promise
May 19 14:08:37 anoath kernel:   Vendor: ATA       Model: ST3250824AS       Rev: 3.AA
May 19 14:08:37 anoath kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
May 19 14:08:37 anoath kernel:   Vendor: ATA       Model: ST3250824AS       Rev: 3.AA
May 19 14:08:37 anoath kernel:   Type:   Direct-Access                      ANSI SCSI revision: 05
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 17 (level, low) -> IRQ 193
May 19 14:08:37 anoath kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
May 19 14:08:37 anoath kernel: sda: Write Protect is off
May 19 14:08:37 anoath kernel: sda: Mode Sense: 00 3a 00 00
May 19 14:08:37 anoath kernel: SCSI device sda: drive cache: write back
May 19 14:08:37 anoath kernel: SCSI device sda: 488397168 512-byte hdwr sectors (250059 MB)
May 19 14:08:37 anoath kernel: sda: Write Protect is off
May 19 14:08:37 anoath kernel: sda: Mode Sense: 00 3a 00 00
May 19 14:08:37 anoath kernel: SCSI device sda: drive cache: write back
May 19 14:08:37 anoath kernel:  sda: sda1
May 19 14:08:37 anoath kernel: sd 0:0:0:0: Attached scsi disk sda
May 19 14:08:37 anoath kernel: SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
May 19 14:08:37 anoath kernel: sdb: Write Protect is off
May 19 14:08:37 anoath kernel: sdb: Mode Sense: 00 3a 00 00
May 19 14:08:37 anoath kernel: SCSI device sdb: drive cache: write back
May 19 14:08:37 anoath kernel: SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
May 19 14:08:37 anoath kernel: sdb: Write Protect is off
May 19 14:08:37 anoath kernel: sdb: Mode Sense: 00 3a 00 00
May 19 14:08:37 anoath kernel: SCSI device sdb: drive cache: write back
May 19 14:08:37 anoath kernel:  sdb: sdb1
May 19 14:08:37 anoath kernel: sd 1:0:0:0: Attached scsi disk sdb
May 19 14:08:37 anoath kernel: usb 2-2: configuration #1 chosen from 1 choice
May 19 14:08:37 anoath kernel: scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
May 19 14:08:37 anoath kernel:         <Adaptec 19160B Ultra160 SCSI adapter>
May 19 14:08:37 anoath kernel:         aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
May 19 14:08:37 anoath kernel: 
May 19 14:08:37 anoath kernel:   Vendor: COMPAQ    Model: SDT-10000         Rev: 1.09
May 19 14:08:37 anoath kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 02
May 19 14:08:37 anoath kernel:  target2:0:3: Beginning Domain Validation
May 19 14:08:37 anoath kernel:  target2:0:3: wide asynchronous
May 19 14:08:37 anoath kernel:  target2:0:3: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
May 19 14:08:37 anoath kernel:  target2:0:3: Domain Validation skipping write tests
May 19 14:08:37 anoath kernel:  target2:0:3: Ending Domain Validation
May 19 14:08:37 anoath kernel: st: Version 20050830, fixed bufsize 32768, s/g segs 256
May 19 14:08:37 anoath kernel: st 2:0:3:0: Attached scsi tape st0<4>st0: try direct i/o: yes (alignment 512 B)
May 19 14:08:37 anoath kernel: EXT3 FS on hda1, internal journal
May 19 14:08:37 anoath kernel: md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
May 19 14:08:37 anoath kernel: md: bitmap version 4.39
May 19 14:08:37 anoath kernel: md: md0 stopped.
May 19 14:08:37 anoath kernel: md: bind<sdb1>
May 19 14:08:37 anoath kernel: md: bind<sda1>
May 19 14:08:37 anoath kernel: kjournald starting.  Commit interval 5 seconds
May 19 14:08:37 anoath kernel: EXT3 FS on hdb1, internal journal
May 19 14:08:37 anoath kernel: EXT3-fs: mounted filesystem with ordered data mode.
May 19 14:08:37 anoath kernel: EXT3-fs: unable to read superblock
May 19 14:08:37 anoath kernel: ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 16 (level, low) -> IRQ 169
May 19 14:08:37 anoath kernel: eth0:  setting full-duplex.
May 19 14:08:37 anoath kernel: NET: Registered protocol family 17
May 19 14:08:37 anoath kernel: e1000: eth1: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
May 19 14:08:37 anoath kernel: Netfilter messages via NETLINK v0.30.
May 19 14:08:37 anoath kernel: ip_conntrack version 2.4 (8192 buckets, 65536 max) - 224 bytes per conntrack
May 19 14:08:37 anoath kernel: ip_tables: (C) 2000-2006 Netfilter Core Team
May 19 14:08:37 anoath kernel: lp0: using parport0 (interrupt-driven).
May 19 14:41:32 anoath kernel: ACPI: PCI Interrupt 0000:00:0f.0[A] -> GSI 17 (level, low) -> IRQ 193
May 19 14:41:32 anoath kernel: rt2500 1.1.0 CVS 2005/07/10 http://rt2x00.serialmonkey.com
May 19 14:56:38 anoath kernel: rt2500 EEPROM:  1  2  3  4  5  6  7  8  9 10 11 12 13 14  Channel
May 19 14:56:38 anoath kernel: rt2500 EEPROM:  8  8  8  8  8  8  8  8  9  9  9  9  9  9  dBm Maximum
