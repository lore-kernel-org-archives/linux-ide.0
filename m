From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: bug: AHCI: Serial ATA to CompactFlash adapter loops endlessly
Date: Tue, 19 Dec 2006 21:13:09 -0500
Message-ID: <20061220021309.GY1104@kvack.org>
References: <20061117211135.GO7299@kvack.org> <45842390.1000102@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kanga.kvack.org ([66.96.29.28]:56541 "EHLO kanga.kvack.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964776AbWLTCU0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Dec 2006 21:20:26 -0500
Content-Disposition: inline
In-Reply-To: <45842390.1000102@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

On Sat, Dec 16, 2006 at 11:49:20AM -0500, Jeff Garzik wrote:
> Did you ever figure anything out in this direction?
> 
> As you saw on IRC, I might start poking at a SATA<->CF adapter in my 
> quest to build a near-silent x86 machine.

What I've found out is the following: I have several different 
compact flash cards in my collection.  The one closest to working 
in these adapters is a GXT 2GB 140X card.  It is recognized by the 
BIOS, hdparm -t on the device works, and even putting an ext2 
filesystem on the card can be done.  However, as soon as any large 
reads off the filesystem are performed, the card ceases reading 
after an initial spurt of about 500 blocks.  The logs below are 
from such a test (the card is ata4.00, /dev/sdc).

The other card is a RiData Pro 1GB 150X, which only seems to work 
in PIO mode.  The BIOS on the system I'm testing right now hangs 
when it tries to probe that card.  That said, it works fine using 
vfat, albeit at 3.5MB/s vs the expected 20MB/s.

Got any ideas for things to try?

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.

....messages....
Dec 19 20:18:04 tower kernel: klogd 1.4.1, log source = /proc/kmsg started.
Dec 19 20:18:04 tower kernel: Linux version 2.6.20-rc1 (bcrl@tower.kvack.org) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #13 SMP Tue Dec 19 18:26:54 EST 2006
Dec 19 20:18:04 tower kernel: Command line: ro root=/dev/md1
Dec 19 20:18:04 tower kernel: BIOS-provided physical RAM map:
Dec 19 20:18:04 tower kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Dec 19 20:18:04 tower kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Dec 19 20:18:04 tower kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
Dec 19 20:18:04 tower kernel:  BIOS-e820: 0000000000100000 - 00000000bf7a0000 (usable)
Dec 19 20:18:04 tower kernel:  BIOS-e820: 00000000bf7a0000 - 00000000bf7ae000 (ACPI data)
Dec 19 20:18:04 tower kernel:  BIOS-e820: 00000000bf7ae000 - 00000000bf7e0000 (ACPI NVS)
Dec 19 20:18:04 tower kernel:  BIOS-e820: 00000000bf7e0000 - 00000000bf800000 (reserved)
Dec 19 20:18:04 tower kernel:  BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
Dec 19 20:18:04 tower kernel: end_pfn_map = 1048576
Dec 19 20:18:04 tower kernel: DMI 2.4 present.
Dec 19 20:18:04 tower kernel: Zone PFN ranges:
Dec 19 20:18:04 tower kernel:   DMA             0 ->     4096
Dec 19 20:18:04 tower kernel:   DMA32        4096 ->  1048576
Dec 19 20:18:04 tower kernel:   Normal    1048576 ->  1048576
Dec 19 20:18:04 tower kernel: early_node_map[2] active PFN ranges
Dec 19 20:18:04 tower kernel:     0:        0 ->      159
Dec 19 20:18:04 tower kernel:     0:      256 ->   784288
Dec 19 20:18:04 tower mcstransd: mcstransd starting
Dec 19 20:18:04 tower mcstransd: mcstransd initialized
Dec 19 20:18:05 tower rpc.statd[2312]: Version 1.0.10 Starting
Dec 19 20:18:05 tower kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Dec 19 20:18:05 tower kernel: Processor #0 (Bootup-CPU)
Dec 19 20:18:05 tower kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Dec 19 20:18:05 tower kernel: Processor #1
Dec 19 20:18:05 tower kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
Dec 19 20:18:05 tower kernel: ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
Dec 19 20:18:05 tower kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Dec 19 20:18:05 tower kernel: IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
Dec 19 20:18:05 tower kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Dec 19 20:18:05 tower kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Dec 19 20:18:05 tower kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Dec 19 20:18:05 tower kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Dec 19 20:18:05 tower rpc.statd[2312]: statd running as root. chown /var/lib/nfs/statd/sm to choose different user 
Dec 19 20:18:05 tower kernel: Setting APIC routing to flat
Dec 19 20:18:05 tower kernel: Using ACPI (MADT) for SMP configuration information
Dec 19 20:18:05 tower kernel: Nosave address range: 000000000009f000 - 00000000000a0000
Dec 19 20:18:05 tower kernel: Nosave address range: 00000000000a0000 - 00000000000e4000
Dec 19 20:18:05 tower kernel: Nosave address range: 00000000000e4000 - 0000000000100000
Dec 19 20:18:05 tower kernel: Allocating PCI resources starting at c0000000 (gap: bf800000:40380000)
Dec 19 20:18:05 tower kernel: PERCPU: Allocating 33152 bytes of per cpu data
Dec 19 20:18:06 tower kernel: Built 1 zonelists.  Total pages: 771830
Dec 19 20:18:06 tower kernel: Kernel command line: ro root=/dev/md1
Dec 19 20:18:06 tower kernel: Initializing CPU#0
Dec 19 20:18:06 tower kernel: PID hash table entries: 4096 (order: 12, 32768 bytes)
Dec 19 20:18:06 tower kernel: Console: colour VGA+ 80x25
Dec 19 20:18:06 tower kernel: Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Dec 19 20:18:06 tower kernel: Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Dec 19 20:18:06 tower kernel: Memory: 3079136k/3137152k available (3936k kernel code, 57120k reserved, 1740k data, 276k init)
Dec 19 20:18:06 tower kernel: Calibrating delay using timer specific routine.. 4793.11 BogoMIPS (lpj=23965588)
Dec 19 20:18:06 tower kernel: Security Framework v1.0.0 initialized
Dec 19 20:18:06 tower kernel: SELinux:  Initializing.
Dec 19 20:18:06 tower kernel: SELinux:  Starting in permissive mode
Dec 19 20:18:06 tower kernel: selinux_register_security:  Registering secondary module capability
Dec 19 20:18:06 tower kernel: Capability LSM initialized as secondary
Dec 19 20:18:06 tower kernel: Failure registering Root Plug module with the kernel
Dec 19 20:18:06 tower kernel: selinux_register_security:  There is already a secondary security module registered.
Dec 19 20:18:06 tower kernel: Failure registering Root Plug  module with primary security module.
Dec 19 20:18:06 tower kernel: Mount-cache hash table entries: 256
Dec 19 20:18:06 tower kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Dec 19 20:18:06 tower kernel: CPU: L2 cache: 4096K
Dec 19 20:18:06 tower kernel: using mwait in idle threads.
Dec 19 20:18:06 tower kernel: CPU: Physical Processor ID: 0
Dec 19 20:18:06 tower kernel: CPU: Processor Core ID: 0
Dec 19 20:18:06 tower hcid[2409]: Bluetooth HCI daemon
Dec 19 20:18:06 tower sdpd[2413]: init_server: opening L2CAP socket: Address family not supported by protocol 
Dec 19 20:18:07 tower kernel: CPU0: Thermal monitoring enabled (TM2)
Dec 19 20:18:07 tower hcid[2409]: Can't open HCI socket: Address family not supported by protocol (97)
Dec 19 20:18:07 tower sdpd[2413]: main: Server initialization failed 
Dec 19 20:18:07 tower kernel: Freeing SMP alternatives: 40k freed
Dec 19 20:18:07 tower kernel: ACPI: Core revision 20060707
Dec 19 20:18:07 tower kernel: Using local APIC timer interrupts.
Dec 19 20:18:07 tower kernel: result 16625235
Dec 19 20:18:07 tower kernel: Detected 16.625 MHz APIC timer.
Dec 19 20:18:07 tower kernel: Booting processor 1/2 APIC 0x1
Dec 19 20:18:07 tower kernel: Initializing CPU#1
Dec 19 20:18:07 tower kernel: Calibrating delay using timer specific routine.. 4788.06 BogoMIPS (lpj=23940318)
Dec 19 20:18:07 tower pcscd: pcscdaemon.c:464:main() pcsc-lite 1.3.1 daemon ready.
Dec 19 20:18:07 tower kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Dec 19 20:18:07 tower kernel: CPU: L2 cache: 4096K
Dec 19 20:18:07 tower kernel: CPU: Physical Processor ID: 0
Dec 19 20:18:07 tower kernel: CPU: Processor Core ID: 1
Dec 19 20:18:07 tower kernel: CPU1: Thermal monitoring enabled (TM2)
Dec 19 20:18:07 tower kernel: Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz stepping 06
Dec 19 20:18:07 tower kernel: Brought up 2 CPUs
Dec 19 20:18:07 tower kernel: testing NMI watchdog ... OK.
Dec 19 20:18:07 tower kernel: time.c: Using 1.193182 MHz WALL PIT GTOD PIT/TSC timer.
Dec 19 20:18:07 tower kernel: time.c: Detected 2394.036 MHz processor.
Dec 19 20:18:07 tower kernel: migration_cost=30
Dec 19 20:18:07 tower kernel: NET: Registered protocol family 16
Dec 19 20:18:07 tower kernel: ACPI: bus type pci registered
Dec 19 20:18:07 tower kernel: PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
Dec 19 20:18:07 tower kernel: PCI: Not using MMCONFIG.
Dec 19 20:18:07 tower kernel: PCI: Using configuration type 1
Dec 19 20:18:07 tower kernel: ACPI: Interpreter enabled
Dec 19 20:18:07 tower kernel: ACPI: Using IOAPIC for interrupt routing
Dec 19 20:18:07 tower kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Dec 19 20:18:07 tower kernel: PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
Dec 19 20:18:07 tower kernel: PCI quirk: region 0480-04bf claimed by ICH6 GPIO
Dec 19 20:18:07 tower kernel: PCI: Transparent bridge - 0000:00:1e.0
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12 14 15)
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 12 14 15)
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 10 11 12 14 15)
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 7 10 11 12 14 15)
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
Dec 19 20:18:08 tower hpiod: 1.6.10 accepting connections at 2208... 
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
Dec 19 20:18:08 tower kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Dec 19 20:18:08 tower kernel: pnp: PnP ACPI init
Dec 19 20:18:08 tower kernel: pnp: PnP ACPI: found 14 devices
Dec 19 20:18:08 tower kernel: SCSI subsystem initialized
Dec 19 20:18:08 tower kernel: usbcore: registered new interface driver usbfs
Dec 19 20:18:08 tower kernel: usbcore: registered new interface driver hub
Dec 19 20:18:08 tower kernel: usbcore: registered new device driver usb
Dec 19 20:18:08 tower kernel: PCI: Using ACPI for IRQ routing
Dec 19 20:18:08 tower kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Dec 19 20:18:08 tower kernel: pnp: 00:07: ioport range 0x290-0x297 has been reserved
Dec 19 20:18:08 tower kernel: PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
Dec 19 20:18:08 tower kernel: PCI: Bridge: 0000:00:1c.0
Dec 19 20:18:08 tower kernel:   IO window: e000-efff
Dec 19 20:18:08 tower kernel:   MEM window: disabled.
Dec 19 20:18:08 tower kernel:   PREFETCH window: disabled.
Dec 19 20:18:08 tower kernel: PCI: Bridge: 0000:00:1c.1
Dec 19 20:18:08 tower kernel:   IO window: d000-dfff
Dec 19 20:18:08 tower kernel:   MEM window: cff00000-cfffffff
Dec 19 20:18:08 tower kernel:   PREFETCH window: disabled.
Dec 19 20:18:08 tower kernel: PCI: Bridge: 0000:00:1e.0
Dec 19 20:18:08 tower kernel:   IO window: b000-cfff
Dec 19 20:18:08 tower kernel:   MEM window: cfe00000-cfefffff
Dec 19 20:18:08 tower kernel:   PREFETCH window: c0000000-c00fffff
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
Dec 19 20:18:08 tower kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
Dec 19 20:18:08 tower kernel: NET: Registered protocol family 2
Dec 19 20:18:08 tower kernel: IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
Dec 19 20:18:08 tower kernel: TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Dec 19 20:18:08 tower kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Dec 19 20:18:08 tower kernel: TCP: Hash tables configured (established 262144 bind 65536)
Dec 19 20:18:08 tower kernel: TCP reno registered
Dec 19 20:18:08 tower kernel: checking if image is initramfs... it is
Dec 19 20:18:08 tower kernel: Freeing initrd memory: 1240k freed
Dec 19 20:18:08 tower kernel: IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
Dec 19 20:18:08 tower kernel: audit: initializing netlink socket (disabled)
Dec 19 20:18:08 tower kernel: audit(1166577459.870:1): initialized
Dec 19 20:18:08 tower kernel: Total HugeTLB memory allocated, 0
Dec 19 20:18:08 tower kernel: SELinux:  Registering netfilter hooks
Dec 19 20:18:08 tower kernel: io scheduler noop registered
Dec 19 20:18:08 tower kernel: io scheduler deadline registered (default)
Dec 19 20:18:08 tower kernel: io scheduler cfq registered
Dec 19 20:18:08 tower kernel: assign_interrupt_mode Found MSI capability
Dec 19 20:18:08 tower kernel: assign_interrupt_mode Found MSI capability
Dec 19 20:18:09 tower kernel: ACPI: Power Button (FF) [PWRF]
Dec 19 20:18:09 tower kernel: ACPI: Power Button (CM) [PWRB]
Dec 19 20:18:09 tower kernel: ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU1PM] [20060707]
Dec 19 20:18:09 tower kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
Dec 19 20:18:09 tower kernel: ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU2PM] [20060707]
Dec 19 20:18:09 tower kernel: ACPI: Processor [CPU2] (supports 8 throttling states)
Dec 19 20:18:09 tower kernel: ACPI: Getting cpuindex for acpiid 0x3
Dec 19 20:18:09 tower kernel: ACPI: Getting cpuindex for acpiid 0x4
Dec 19 20:18:09 tower kernel: ibm_acpi: ec object not found
Dec 19 20:18:09 tower kernel: lp: driver loaded but no devices found
Dec 19 20:18:09 tower kernel: Real Time Clock Driver v1.12ac
Dec 19 20:18:09 tower kernel: Non-volatile memory driver v1.2
Dec 19 20:18:09 tower kernel: Linux agpgart interface v0.101 (c) Dave Jones
Dec 19 20:18:09 tower kernel: agpgart: Detected an Intel 945G Chipset.
Dec 19 20:18:09 tower kernel: agpgart: Detected 7932K stolen memory.
Dec 19 20:18:09 tower kernel: agpgart: AGP aperture is 256M @ 0xd0000000
Dec 19 20:18:09 tower kernel: [drm] Initialized drm 1.1.0 20060810
Dec 19 20:18:09 tower kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Dec 19 20:18:09 tower kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 19 20:18:09 tower kernel: 00:0a: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Dec 19 20:18:09 tower kernel: parport: PnPBIOS parport detected.
Dec 19 20:18:09 tower kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
Dec 19 20:18:09 tower kernel: parport0: Legacy device
Dec 19 20:18:09 tower kernel: lp0: using parport0 (interrupt-driven).
Dec 19 20:18:09 tower kernel: lp0: console ready
Dec 19 20:18:09 tower kernel: floppy0: no floppy controllers found
Dec 19 20:18:09 tower kernel: RAMDISK driver initialized: 1 RAM disks of 4096K size 4096 blocksize
Dec 19 20:18:09 tower kernel: loop: loaded (max 8 devices)
Dec 19 20:18:09 tower kernel: Intel(R) PRO/1000 Network Driver - version 7.3.15-k2-NAPI
Dec 19 20:18:09 tower kernel: Copyright (c) 1999-2006 Intel Corporation.
Dec 19 20:18:09 tower kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
Dec 19 20:18:09 tower kernel: e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:17:31:54:45:b3
Dec 19 20:18:09 tower kernel: e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
Dec 19 20:18:09 tower kernel: pcnet32.c:v1.33 27.Jun.2006 tsbogend@alpha.franken.de
Dec 19 20:18:09 tower kernel: e100: Intel(R) PRO/100 Network Driver, 3.5.17-k2-NAPI
Dec 19 20:18:09 tower kernel: e100: Copyright(c) 1999-2006 Intel Corporation
Dec 19 20:18:09 tower kernel: PPP generic driver version 2.4.2
Dec 19 20:18:09 tower kernel: PPP Deflate Compression module registered
Dec 19 20:18:09 tower kernel: PPP BSD Compression module registered
Dec 19 20:18:09 tower kernel: PPP MPPE Compression module registered
Dec 19 20:18:09 tower kernel: NET: Registered protocol family 24
Dec 19 20:18:09 tower kernel: dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
Dec 19 20:18:09 tower kernel: winbond-840.c:v1.01-e (2.4 port) Sep-11-2006  Donald Becker <becker@scyld.com>
Dec 19 20:18:09 tower kernel:   http://www.scyld.com/network/drivers.html
Dec 19 20:18:09 tower kernel: uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
Dec 19 20:18:10 tower kernel: Loading iSCSI transport class v2.0-724.<7>ata_piix 0000:00:1f.1: version 2.00ac7
Dec 19 20:18:10 tower kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
Dec 19 20:18:10 tower kernel: ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
Dec 19 20:18:10 tower kernel: ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xFFA8 irq 15
Dec 19 20:18:10 tower kernel: scsi0 : ata_piix
Dec 19 20:18:10 tower kernel: scsi1 : ata_piix
Dec 19 20:18:10 tower kernel: ATA: abnormal status 0x7F on port 0x177
Dec 19 20:18:10 tower kernel: ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
Dec 19 20:18:10 tower kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 17
Dec 19 20:18:10 tower kernel: ata3: SATA max UDMA/133 cmd 0xA800 ctl 0xA402 bmdma 0x9400 irq 17
Dec 19 20:18:10 tower kernel: ata4: SATA max UDMA/133 cmd 0xA000 ctl 0x9802 bmdma 0x9408 irq 17
Dec 19 20:18:10 tower kernel: scsi2 : ata_piix
Dec 19 20:18:10 tower kernel: ata3.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48 
Dec 19 20:18:10 tower kernel: ata3.00: ata3: dev 0 multi count 16
Dec 19 20:18:10 tower kernel: ata3.01: ATA-6, max UDMA/100, 625142448 sectors: LBA48 
Dec 19 20:18:10 tower kernel: ata3.01: ata3: dev 1 multi count 16
Dec 19 20:18:10 tower kernel: ata3.00: configured for UDMA/100
Dec 19 20:18:10 tower kernel: ata3.01: configured for UDMA/100
Dec 19 20:18:10 tower kernel: scsi3 : ata_piix
Dec 19 20:18:10 tower kernel: ata4.00: CFA, max UDMA/33, 4030464 sectors: LBA 
Dec 19 20:18:10 tower kernel: ata4.00: ata4: dev 0 multi count 0
Dec 19 20:18:10 tower kernel: ata4.01: ATA-0, max PIO4, 2030112 sectors: LBA 
Dec 19 20:18:10 tower kernel: ata4.01: ata4: dev 1 multi count 0
Dec 19 20:18:10 tower kernel: ata4.01: applying bridge limits
Dec 19 20:18:10 tower kernel: ata4.00: configured for UDMA/33
Dec 19 20:18:10 tower kernel: ata4.01: configured for PIO4
Dec 19 20:18:10 tower kernel: scsi 2:0:0:0: Direct-Access     ATA      WDC WD3200SD-01K 08.0 PQ: 0 ANSI: 5
Dec 19 20:18:10 tower kernel: SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
Dec 19 20:18:10 tower kernel: sda: Write Protect is off
Dec 19 20:18:10 tower kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:18:10 tower kernel: SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
Dec 19 20:18:10 tower kernel: sda: Write Protect is off
Dec 19 20:18:10 tower kernel: SCSI device sda: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:18:10 tower kernel:  sda: sda1 sda2 sda3
Dec 19 20:18:10 tower kernel: sd 2:0:0:0: Attached scsi disk sda
Dec 19 20:18:10 tower kernel: sd 2:0:0:0: Attached scsi generic sg0 type 0
Dec 19 20:18:10 tower kernel: scsi 2:0:1:0: Direct-Access     ATA      WDC WD3200SD-01K 08.0 PQ: 0 ANSI: 5
Dec 19 20:18:10 tower kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
Dec 19 20:18:10 tower kernel: sdb: Write Protect is off
Dec 19 20:18:11 tower kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:18:11 tower kernel: SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
Dec 19 20:18:11 tower kernel: sdb: Write Protect is off
Dec 19 20:18:11 tower kernel: SCSI device sdb: write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:18:11 tower kernel:  sdb: sdb1 sdb2 sdb3
Dec 19 20:18:11 tower kernel: sd 2:0:1:0: Attached scsi disk sdb
Dec 19 20:18:11 tower kernel: sd 2:0:1:0: Attached scsi generic sg1 type 0
Dec 19 20:18:11 tower kernel: scsi 3:0:0:0: Direct-Access     ATA      CF Card          Ver1 PQ: 0 ANSI: 5
Dec 19 20:18:11 tower kernel: SCSI device sdc: 4030464 512-byte hdwr sectors (2064 MB)
Dec 19 20:18:11 tower kernel: sdc: Write Protect is off
Dec 19 20:18:11 tower kernel: SCSI device sdc: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:18:11 tower kernel: SCSI device sdc: 4030464 512-byte hdwr sectors (2064 MB)
Dec 19 20:18:11 tower kernel: sdc: Write Protect is off
Dec 19 20:18:11 tower kernel: SCSI device sdc: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:18:11 tower kernel:  sdc: sdc1
Dec 19 20:18:11 tower kernel: sd 3:0:0:0: Attached scsi removable disk sdc
Dec 19 20:18:11 tower kernel: sd 3:0:0:0: Attached scsi generic sg2 type 0
Dec 19 20:18:11 tower kernel: scsi 3:0:1:0: Direct-Access     ATA                       2006 PQ: 0 ANSI: 5
Dec 19 20:18:11 tower kernel: SCSI device sdd: 2030112 512-byte hdwr sectors (1039 MB)
Dec 19 20:18:11 tower kernel: sdd: Write Protect is off
Dec 19 20:18:11 tower kernel: SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:18:11 tower kernel: SCSI device sdd: 2030112 512-byte hdwr sectors (1039 MB)
Dec 19 20:18:11 tower kernel: sdd: Write Protect is off
Dec 19 20:18:11 tower kernel: SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:18:11 tower kernel:  sdd: sdd1
Dec 19 20:18:11 tower kernel: sd 3:0:1:0: Attached scsi disk sdd
Dec 19 20:18:11 tower kernel: sd 3:0:1:0: Attached scsi generic sg3 type 0
Dec 19 20:18:11 tower kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
Dec 19 20:18:11 tower kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Dec 19 20:18:11 tower kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Dec 19 20:18:11 tower kernel: ehci_hcd 0000:00:1d.7: debug port 1
Dec 19 20:18:11 tower kernel: ehci_hcd 0000:00:1d.7: irq 20, io mem 0xcfdffc00
Dec 19 20:18:11 tower kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Dec 19 20:18:11 tower gpm[2647]: *** info [startup.c(95)]: 
Dec 19 20:18:11 tower kernel: USB Universal Host Controller Interface driver v3.0
Dec 19 20:18:11 tower gpm[2647]: Started gpm successfully. Entered daemon mode.
Dec 19 20:18:11 tower kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
Dec 19 20:18:11 tower kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Dec 19 20:18:11 tower kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Dec 19 20:18:11 tower kernel: uhci_hcd 0000:00:1d.0: irq 20, io base 0x00008000
Dec 19 20:18:11 tower kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
Dec 19 20:18:11 tower kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Dec 19 20:18:11 tower kernel: usb usb1: configuration #1 chosen from 1 choice
Dec 19 20:18:11 tower kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Dec 19 20:18:11 tower kernel: uhci_hcd 0000:00:1d.1: irq 17, io base 0x00008400
Dec 19 20:18:11 tower kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
Dec 19 20:18:11 tower kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Dec 19 20:18:11 tower kernel: hub 1-0:1.0: USB hub found
Dec 19 20:18:12 tower kernel: hub 1-0:1.0: 8 ports detected
Dec 19 20:18:12 tower kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Dec 19 20:18:12 tower kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0x00008800
Dec 19 20:18:12 tower kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
Dec 19 20:18:12 tower kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Dec 19 20:18:12 tower kernel: usb usb2: configuration #1 chosen from 1 choice
Dec 19 20:18:12 tower kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Dec 19 20:18:12 tower kernel: uhci_hcd 0000:00:1d.3: irq 19, io base 0x00009000
Dec 19 20:18:12 tower kernel: usb usb3: configuration #1 chosen from 1 choice
Dec 19 20:18:12 tower kernel: hub 2-0:1.0: USB hub found
Dec 19 20:18:12 tower kernel: hub 2-0:1.0: 2 ports detected
Dec 19 20:18:12 tower kernel: usbcore: registered new interface driver usblp
Dec 19 20:18:12 tower kernel: drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Dec 19 20:18:12 tower kernel: Initializing USB Mass Storage driver...
Dec 19 20:18:12 tower kernel: usb usb4: configuration #1 chosen from 1 choice
Dec 19 20:18:12 tower kernel: hub 3-0:1.0: USB hub found
Dec 19 20:18:12 tower kernel: hub 3-0:1.0: 2 ports detected
Dec 19 20:18:12 tower kernel: usbcore: registered new interface driver usb-storage
Dec 19 20:18:12 tower kernel: USB Mass Storage support registered.
Dec 19 20:18:12 tower kernel: usb usb5: configuration #1 chosen from 1 choice
Dec 19 20:18:12 tower kernel: hub 4-0:1.0: USB hub found
Dec 19 20:18:12 tower kernel: hub 4-0:1.0: 2 ports detected
Dec 19 20:18:12 tower kernel: usbcore: registered new interface driver usbhid
Dec 19 20:18:12 tower kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Dec 19 20:18:12 tower kernel: hub 5-0:1.0: USB hub found
Dec 19 20:18:12 tower kernel: hub 5-0:1.0: 2 ports detected
Dec 19 20:18:12 tower kernel: PNP: No PS/2 controller found. Probing ports directly.
Dec 19 20:18:12 tower kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Dec 19 20:18:12 tower kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Dec 19 20:18:12 tower kernel: mice: PS/2 mouse device common for all mice
Dec 19 20:18:12 tower kernel: md: linear personality registered for level -1
Dec 19 20:18:12 tower kernel: md: raid0 personality registered for level 0
Dec 19 20:18:12 tower kernel: md: raid1 personality registered for level 1
Dec 19 20:18:12 tower kernel: md: raid10 personality registered for level 10
Dec 19 20:18:12 tower kernel: raid6: int64x1   1955 MB/s
Dec 19 20:18:12 tower kernel: raid6: int64x2   2736 MB/s
Dec 19 20:18:12 tower kernel: raid6: int64x4   2430 MB/s
Dec 19 20:18:12 tower kernel: raid6: int64x8   2055 MB/s
Dec 19 20:18:12 tower kernel: raid6: sse2x1    3791 MB/s
Dec 19 20:18:12 tower kernel: usb 2-1: new full speed USB device using uhci_hcd and address 2
Dec 19 20:18:12 tower kernel: raid6: sse2x2    4291 MB/s
Dec 19 20:18:12 tower kernel: usb 2-1: configuration #1 chosen from 1 choice
Dec 19 20:18:12 tower kernel: hub 2-1:1.0: USB hub found
Dec 19 20:18:12 tower kernel: hub 2-1:1.0: 2 ports detected
Dec 19 20:18:12 tower kernel: raid6: sse2x4    7064 MB/s
Dec 19 20:18:12 tower kernel: raid6: using algorithm sse2x4 (7064 MB/s)
Dec 19 20:18:12 tower kernel: md: raid6 personality registered for level 6
Dec 19 20:18:12 tower kernel: md: raid5 personality registered for level 5
Dec 19 20:18:12 tower kernel: md: raid4 personality registered for level 4
Dec 19 20:18:12 tower kernel: raid5: automatically using best checksumming function: generic_sse
Dec 19 20:18:12 tower kernel:    generic_sse:  8779.600 MB/sec
Dec 19 20:18:12 tower kernel: raid5: using function: generic_sse (8779.600 MB/sec)
Dec 19 20:18:12 tower kernel: md: multipath personality registered for level -4
Dec 19 20:18:13 tower kernel: md: faulty personality registered for level -5
Dec 19 20:18:13 tower kernel: device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
Dec 19 20:18:13 tower kernel: device-mapper: multipath: version 1.0.5 loaded
Dec 19 20:18:13 tower kernel: device-mapper: multipath round-robin: version 1.0.0 loaded
Dec 19 20:18:13 tower kernel: device-mapper: multipath emc: version 0.0.3 loaded
Dec 19 20:18:13 tower kernel: EDAC MC: Ver: 2.0.1 Dec 19 2006
Dec 19 20:18:13 tower kernel: sdhci: Secure Digital Host Controller Interface driver, 0.12
Dec 19 20:18:13 tower kernel: sdhci: Copyright(c) Pierre Ossman
Dec 19 20:18:13 tower kernel: wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.6
Dec 19 20:18:13 tower kernel: wbsd: Copyright(c) Pierre Ossman
Dec 19 20:18:13 tower kernel: Advanced Linux Sound Architecture Driver Version 1.0.13 (Tue Nov 28 14:07:24 2006 UTC).
Dec 19 20:18:13 tower kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
Dec 19 20:18:13 tower kernel: usb 2-1.1: new full speed USB device using uhci_hcd and address 3
Dec 19 20:18:13 tower kernel: usb 2-1.1: configuration #1 chosen from 1 choice
Dec 19 20:18:13 tower kernel: hub 2-1.1:1.0: USB hub found
Dec 19 20:18:13 tower kernel: hub 2-1.1:1.0: 3 ports detected
Dec 19 20:18:13 tower kernel: hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
Dec 19 20:18:13 tower kernel: usb 2-1.1.1: new full speed USB device using uhci_hcd and address 4
Dec 19 20:18:13 tower kernel: ALSA device list:
Dec 19 20:18:13 tower kernel:   #0: HDA Intel at 0xcfdf8000 irq 19
Dec 19 20:18:13 tower kernel: oprofile: using NMI interrupt.
Dec 19 20:18:13 tower kernel: nf_conntrack version 0.5.0 (8192 buckets, 65536 max)
Dec 19 20:18:13 tower kernel: IPv4 over IPv4 tunneling driver
Dec 19 20:18:13 tower kernel: GRE over IPv4 tunneling driver
Dec 19 20:18:13 tower kernel: usb 2-1.1.1: configuration #1 chosen from 1 choice
Dec 19 20:18:13 tower kernel: input: Logitech USB Gaming Mouse as /class/input/input0
Dec 19 20:18:13 tower kernel: input: USB HID v1.11 Mouse [Logitech USB Gaming Mouse] on usb-0000:00:1d.0-1.1.1
Dec 19 20:18:13 tower kernel: HID device not claimed by input or hiddev
Dec 19 20:18:13 tower kernel: TCP bic registered
Dec 19 20:18:13 tower kernel: NET: Registered protocol family 1
Dec 19 20:18:13 tower kernel: NET: Registered protocol family 17
Dec 19 20:18:13 tower kernel: usb 2-1.1.2: new full speed USB device using uhci_hcd and address 5
Dec 19 20:18:13 tower kernel: usb 2-1.1.2: configuration #1 chosen from 1 choice
Dec 19 20:18:13 tower kernel: hub 2-1.1.2:1.0: USB hub found
Dec 19 20:18:13 tower kernel: hub 2-1.1.2:1.0: 3 ports detected
Dec 19 20:18:13 tower kernel: Bridge firewalling registered
Dec 19 20:18:13 tower kernel: 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
Dec 19 20:18:14 tower kernel: All bugs added by David S. Miller <davem@redhat.com>
Dec 19 20:18:14 tower kernel: drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Dec 19 20:18:14 tower kernel: Freeing unused kernel memory: 276k freed
Dec 19 20:18:14 tower kernel: usb 2-1.1.3: new low speed USB device using uhci_hcd and address 6
Dec 19 20:18:14 tower kernel: md: Autodetecting RAID arrays.
Dec 19 20:18:14 tower kernel: usb 2-1.1.3: configuration #1 chosen from 1 choice
Dec 19 20:18:14 tower kernel: HID device not claimed by input or hiddev
Dec 19 20:18:14 tower kernel: md: autorun ...
Dec 19 20:18:14 tower kernel: md: considering sdb3 ...
Dec 19 20:18:14 tower kernel: md:  adding sdb3 ...
Dec 19 20:18:14 tower kernel: md: sdb2 has different UUID to sdb3
Dec 19 20:18:14 tower kernel: md: sdb1 has different UUID to sdb3
Dec 19 20:18:14 tower kernel: md:  adding sda3 ...
Dec 19 20:18:14 tower kernel: md: sda2 has different UUID to sdb3
Dec 19 20:18:14 tower kernel: md: sda1 has different UUID to sdb3
Dec 19 20:18:14 tower kernel: md: created md1
Dec 19 20:18:14 tower kernel: md: bind<sda3>
Dec 19 20:18:14 tower kernel: md: bind<sdb3>
Dec 19 20:18:14 tower kernel: md: running: <sdb3><sda3>
Dec 19 20:18:14 tower kernel: md: md1: raid array is not clean -- starting background reconstruction
Dec 19 20:18:14 tower kernel: raid1: raid set md1 active with 2 out of 2 mirrors
Dec 19 20:18:14 tower kernel: md: considering sdb2 ...
Dec 19 20:18:14 tower kernel: md: resync of RAID array md1
Dec 19 20:18:14 tower kernel: md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
Dec 19 20:18:14 tower kernel: md: using maximum available idle IO bandwidth (but not more than 200000 KB/sec) for resync.
Dec 19 20:18:14 tower kernel: md: using 128k window, over a total of 307451904 blocks.
Dec 19 20:18:14 tower kernel: md:  adding sdb2 ...
Dec 19 20:18:14 tower kernel: md: sdb1 has different UUID to sdb2
Dec 19 20:18:14 tower kernel: md:  adding sda2 ...
Dec 19 20:18:14 tower kernel: md: sda1 has different UUID to sdb2
Dec 19 20:18:14 tower kernel: md: created md2
Dec 19 20:18:14 tower kernel: md: bind<sda2>
Dec 19 20:18:14 tower kernel: md: bind<sdb2>
Dec 19 20:18:14 tower kernel: md: running: <sdb2><sda2>
Dec 19 20:18:14 tower kernel: raid1: raid set md2 active with 2 out of 2 mirrors
Dec 19 20:18:14 tower kernel: md: considering sdb1 ...
Dec 19 20:18:14 tower kernel: md:  adding sdb1 ...
Dec 19 20:18:14 tower kernel: md:  adding sda1 ...
Dec 19 20:18:14 tower kernel: md: created md0
Dec 19 20:18:14 tower kernel: md: bind<sda1>
Dec 19 20:18:14 tower kernel: md: bind<sdb1>
Dec 19 20:18:14 tower kernel: md: running: <sdb1><sda1>
Dec 19 20:18:14 tower kernel: raid1: raid set md0 active with 2 out of 2 mirrors
Dec 19 20:18:14 tower kernel: md: ... autorun DONE.
Dec 19 20:18:14 tower kernel: md: Autodetecting RAID arrays.
Dec 19 20:18:15 tower kernel: md: autorun ...
Dec 19 20:18:15 tower kernel: md: ... autorun DONE.
Dec 19 20:18:15 tower kernel: usb 2-1.1.2.1: new low speed USB device using uhci_hcd and address 7
Dec 19 20:18:15 tower kernel: usb 2-1.1.2.1: configuration #1 chosen from 1 choice
Dec 19 20:18:15 tower kernel: input: LOGITECH USB Keyboard as /class/input/input1
Dec 19 20:18:15 tower kernel: input: USB HID v1.10 Keyboard [LOGITECH USB Keyboard] on usb-0000:00:1d.0-1.1.2.1
Dec 19 20:18:15 tower kernel: input: LOGITECH USB Keyboard as /class/input/input2
Dec 19 20:18:15 tower kernel: input: USB HID v1.10 Device [LOGITECH USB Keyboard] on usb-0000:00:1d.0-1.1.2.1
Dec 19 20:18:15 tower kernel: kjournald starting.  Commit interval 5 seconds
Dec 19 20:18:15 tower kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 19 20:18:15 tower kernel: audit(1166577467.840:2): enforcing=1 old_enforcing=0 auid=4294967295
Dec 19 20:18:15 tower kernel: security:  3 users, 6 roles, 1580 types, 170 bools, 1 sens, 1024 cats
Dec 19 20:18:15 tower kernel: security:  59 classes, 630400 rules
Dec 19 20:18:15 tower kernel: security:  class dccp_socket not defined in policy
Dec 19 20:18:15 tower kernel: security:  permission dccp_recv in class node not defined in policy
Dec 19 20:18:15 tower kernel: security:  permission dccp_send in class node not defined in policy
Dec 19 20:18:15 tower kernel: security:  permission dccp_recv in class netif not defined in policy
Dec 19 20:18:15 tower kernel: security:  permission dccp_send in class netif not defined in policy
Dec 19 20:18:15 tower kernel: SELinux:  Completing initialization.
Dec 19 20:18:15 tower kernel: SELinux:  Setting up existing superblocks.
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev md1, type ext3), uses xattr
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev devpts, type devpts), uses transition SIDs
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev proc, type proc), uses genfs_contexts
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
Dec 19 20:18:15 tower kernel: SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
Dec 19 20:18:15 tower kernel: audit(1166577469.700:3): policy loaded auid=4294967295
Dec 19 20:18:15 tower kernel: md: Autodetecting RAID arrays.
Dec 19 20:18:15 tower kernel: md: autorun ...
Dec 19 20:18:15 tower kernel: md: ... autorun DONE.
Dec 19 20:18:15 tower kernel: EXT3 FS on md1, internal journal
Dec 19 20:18:15 tower kernel: kjournald starting.  Commit interval 5 seconds
Dec 19 20:18:15 tower kernel: EXT3 FS on md0, internal journal
Dec 19 20:18:16 tower kernel: EXT3-fs: mounted filesystem with ordered data mode.
Dec 19 20:18:16 tower kernel: SELinux: initialized (dev md0, type ext3), uses xattr
Dec 19 20:18:16 tower kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Dec 19 20:18:16 tower kernel: Adding 4096440k swap on /dev/md2.  Priority:-1 extents:1 across:4096440k
Dec 19 20:18:16 tower kernel: SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
Dec 19 20:18:16 tower kernel: e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
Dec 19 20:18:16 tower kernel: SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Dec 19 20:18:16 tower kernel: audit(1166577496.008:4): avc:  denied  { search } for  pid=2242 comm="irqbalance" name="net" dev=proc ino=4026531863 scontext=system_u:system_r:irqbalance_t:s0 tcontext=system_u:object_r:proc_net_t:s0 tclass=dir
Dec 19 20:18:16 tower avahi-daemon[2766]: Found user 'avahi' (UID 70) and group 'avahi' (GID 70).
Dec 19 20:18:16 tower avahi-daemon[2766]: Successfully dropped root privileges.
Dec 19 20:18:16 tower avahi-daemon[2766]: avahi-daemon 0.6.15 starting up.
Dec 19 20:18:16 tower avahi-daemon[2766]: WARNING: No NSS support for mDNS detected, consider installing nss-mdns!
Dec 19 20:18:16 tower avahi-daemon[2766]: Successfully called chroot().
Dec 19 20:18:16 tower avahi-daemon[2766]: Successfully dropped remaining capabilities.
Dec 19 20:18:16 tower avahi-daemon[2766]: Loading service file /services/sftp-ssh.service.
Dec 19 20:18:16 tower avahi-daemon[2766]: socket() failed: Address family not supported by protocol
Dec 19 20:18:16 tower avahi-daemon[2766]: Failed to create IPv6 socket, proceeding in IPv4 only mode
Dec 19 20:18:16 tower avahi-daemon[2766]: socket() failed: Address family not supported by protocol
Dec 19 20:18:16 tower avahi-daemon[2766]: New relevant interface eth0.IPv4 for mDNS.
Dec 19 20:18:16 tower avahi-daemon[2766]: Joining mDNS multicast group on interface eth0.IPv4 with address 192.168.0.202.
Dec 19 20:18:16 tower avahi-daemon[2766]: Network interface enumeration completed.
Dec 19 20:18:16 tower avahi-daemon[2766]: Registering new address record for 192.168.0.202 on eth0.
Dec 19 20:18:17 tower avahi-daemon[2766]: Registering HINFO record with values 'X86_64'/'LINUX'.
Dec 19 20:18:17 tower avahi-daemon[2766]: Server startup complete. Host name is tower.local. Local service cookie is 2868420649.
Dec 19 20:18:18 tower smartd[2852]: smartd version 5.36 [x86_64-redhat-linux-gnu] Copyright (C) 2002-6 Bruce Allen 
Dec 19 20:18:18 tower smartd[2852]: Home page is http://smartmontools.sourceforge.net/  
Dec 19 20:18:18 tower smartd[2852]: Opened configuration file /etc/smartd.conf 
Dec 19 20:18:18 tower smartd[2852]: Configuration file /etc/smartd.conf parsed. 
Dec 19 20:18:18 tower smartd[2852]: Device: /dev/sda, opened 
Dec 19 20:18:18 tower smartd[2852]: Device: /dev/sda, found in smartd database. 
Dec 19 20:18:18 tower smartd[2852]: Device: /dev/sda, is SMART capable. Adding to "monitor" list. 
Dec 19 20:18:18 tower smartd[2852]: Device: /dev/sdb, opened 
Dec 19 20:18:18 tower smartd[2852]: Device: /dev/sdb, found in smartd database. 
Dec 19 20:18:18 tower avahi-daemon[2766]: Service "SFTP File Transfer on tower" (/services/sftp-ssh.service) successfully established.
Dec 19 20:18:19 tower smartd[2852]: Device: /dev/sdb, is SMART capable. Adding to "monitor" list. 
Dec 19 20:18:19 tower smartd[2852]: Monitoring 2 ATA and 0 SCSI devices 
Dec 19 20:18:19 tower smartd[2854]: smartd has fork()ed into background mode. New PID=2854. 
Dec 19 20:21:02 tower kernel: SELinux: initialized (dev sdc1, type ext2), uses xattr
Dec 19 20:22:18 tower kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Dec 19 20:22:18 tower kernel: ata4.00: cmd c8/00:00:27:c2:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 in
Dec 19 20:22:18 tower kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 19 20:22:25 tower kernel: ata4: port is slow to respond, please be patient (Status 0xd0)
Dec 19 20:22:48 tower kernel: ata4: port failed to respond (30 secs, Status 0xd0)
Dec 19 20:22:48 tower kernel: ata4: soft resetting port
Dec 19 20:22:48 tower kernel: ata4.00: configured for UDMA/33
Dec 19 20:22:48 tower kernel: ata4.01: configured for PIO4
Dec 19 20:22:48 tower kernel: ata4: EH complete
Dec 19 20:22:48 tower kernel: SCSI device sdc: 4030464 512-byte hdwr sectors (2064 MB)
Dec 19 20:23:01 tower kernel: audit(1166577781.062:5): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:6): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:7): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:8): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:9): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:10): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:11): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:12): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:13): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:14): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:01 tower kernel: audit(1166577781.062:15): avc:  denied  { read } for  pid=3029 comm="pam_console_app" name="/" dev=sdc1 ino=2 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c1023 tcontext=system_u:object_r:file_t:s0 tclass=dir
Dec 19 20:23:48 tower kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Dec 19 20:23:48 tower kernel: ata4.00: cmd c8/00:00:27:c4:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 in
Dec 19 20:23:48 tower kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 19 20:23:55 tower kernel: ata4: port is slow to respond, please be patient (Status 0xd0)
Dec 19 20:24:18 tower kernel: ata4: port failed to respond (30 secs, Status 0xd0)
Dec 19 20:24:18 tower kernel: ata4: soft resetting port
Dec 19 20:24:18 tower kernel: ata4.00: configured for UDMA/33
Dec 19 20:24:18 tower kernel: ata4.01: configured for PIO4
Dec 19 20:24:18 tower kernel: ata4: EH complete
Dec 19 20:24:18 tower kernel: sdc: Write Protect is off
Dec 19 20:24:18 tower kernel: SCSI device sdc: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:24:18 tower kernel: SCSI device sdd: 2030112 512-byte hdwr sectors (1039 MB)
Dec 19 20:24:18 tower kernel: sdd: Write Protect is off
Dec 19 20:24:18 tower kernel: SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:24:18 tower kernel: SCSI device sdc: 4030464 512-byte hdwr sectors (2064 MB)
Dec 19 20:25:18 tower kernel: ata4.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Dec 19 20:25:18 tower kernel: ata4.00: cmd c8/00:00:27:cd:02/00:00:00:00:00/e0 tag 0 cdb 0x0 data 131072 in
Dec 19 20:25:18 tower kernel:          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Dec 19 20:25:25 tower kernel: ata4: port is slow to respond, please be patient (Status 0xd0)
Dec 19 20:25:48 tower kernel: ata4: port failed to respond (30 secs, Status 0xd0)
Dec 19 20:25:48 tower kernel: ata4: soft resetting port
Dec 19 20:25:49 tower kernel: ATA: abnormal status 0xD0 on port 0xA007
Dec 19 20:25:49 tower last message repeated 6 times
Dec 19 20:26:19 tower kernel: ata4.00: qc timeout (cmd 0xec)
Dec 19 20:26:19 tower kernel: ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Dec 19 20:26:19 tower kernel: ata4.00: revalidation failed (errno=-5)
Dec 19 20:26:19 tower kernel: ata4: failed to recover some devices, retrying in 5 secs
Dec 19 20:26:31 tower kernel: ata4: port is slow to respond, please be patient (Status 0xd0)
Dec 19 20:26:54 tower kernel: ata4: port failed to respond (30 secs, Status 0xd0)
Dec 19 20:26:54 tower kernel: ata4: soft resetting port
Dec 19 20:26:54 tower kernel: ATA: abnormal status 0xD0 on port 0xA007
Dec 19 20:26:54 tower last message repeated 6 times
Dec 19 20:27:24 tower kernel: ata4.00: qc timeout (cmd 0xec)
Dec 19 20:27:24 tower kernel: ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Dec 19 20:27:24 tower kernel: ata4.00: revalidation failed (errno=-5)
Dec 19 20:27:24 tower kernel: ata4: failed to recover some devices, retrying in 5 secs
Dec 19 20:27:36 tower kernel: ata4: port is slow to respond, please be patient (Status 0xd0)
Dec 19 20:27:59 tower kernel: ata4: port failed to respond (30 secs, Status 0xd0)
Dec 19 20:27:59 tower kernel: ata4: soft resetting port
Dec 19 20:27:59 tower kernel: ATA: abnormal status 0xD0 on port 0xA007
Dec 19 20:27:59 tower last message repeated 6 times
Dec 19 20:28:29 tower kernel: ata4.00: qc timeout (cmd 0xec)
Dec 19 20:28:29 tower kernel: ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Dec 19 20:28:29 tower kernel: ata4.00: revalidation failed (errno=-5)
Dec 19 20:28:29 tower kernel: ata4.00: disabled
Dec 19 20:28:29 tower kernel: ata4: failed to recover some devices, retrying in 5 secs
Dec 19 20:28:34 tower kernel: ATA: abnormal status 0xD0 on port 0xA007
Dec 19 20:28:34 tower kernel: ata4.01: failed to IDENTIFY (I/O error, err_mask=0x40)
Dec 19 20:28:34 tower kernel: ata4.01: revalidation failed (errno=-5)
Dec 19 20:28:34 tower kernel: ata4: failed to recover some devices, retrying in 5 secs
Dec 19 20:28:39 tower kernel: ata4: soft resetting port
Dec 19 20:28:39 tower kernel: ATA: abnormal status 0xD0 on port 0xA007
Dec 19 20:28:39 tower kernel: ATA: abnormal status 0xD0 on port 0xA007
Dec 19 20:28:39 tower kernel: ata4.01: configured for PIO4
Dec 19 20:28:39 tower kernel: ata4: EH complete
Dec 19 20:28:39 tower kernel: sd 3:0:0:0: SCSI error: return code = 0x00040000
Dec 19 20:28:39 tower kernel: end_request: I/O error, dev sdc, sector 183591
Dec 19 20:28:39 tower kernel: Buffer I/O error on device sdc1, logical block 126
Dec 19 20:28:39 tower kernel: lost page write due to I/O error on sdc1
Dec 19 20:28:39 tower kernel: sd 3:0:0:0: SCSI error: return code = 0x00040000
Dec 19 20:28:39 tower kernel: end_request: I/O error, dev sdc, sector 183847
Dec 19 20:28:39 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:39 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:39 tower kernel: sdc : sense not available. 
Dec 19 20:28:39 tower kernel: sdc: Write Protect is off
Dec 19 20:28:39 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:39 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:39 tower kernel: sdc: Write Protect is off
Dec 19 20:28:39 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:39 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:39 tower kernel: SCSI device sdd: 2030112 512-byte hdwr sectors (1039 MB)
Dec 19 20:28:39 tower kernel: sdd: Write Protect is off
Dec 19 20:28:39 tower kernel: SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:28:39 tower kernel: SCSI device sdd: 2030112 512-byte hdwr sectors (1039 MB)
Dec 19 20:28:39 tower kernel: sdd: Write Protect is off
Dec 19 20:28:39 tower kernel: SCSI device sdd: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
Dec 19 20:28:41 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:41 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:41 tower kernel: sdc : sense not available. 
Dec 19 20:28:41 tower kernel: sdc: Write Protect is off
Dec 19 20:28:41 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:41 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:43 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:43 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:43 tower kernel: sdc : sense not available. 
Dec 19 20:28:43 tower kernel: sdc: Write Protect is off
Dec 19 20:28:43 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:43 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:44 tower kernel: Buffer I/O error on device sdc1, logical block 126
Dec 19 20:28:44 tower kernel: lost page write due to I/O error on sdc1
Dec 19 20:28:45 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:45 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:45 tower kernel: sdc : sense not available. 
Dec 19 20:28:45 tower kernel: sdc: Write Protect is off
Dec 19 20:28:45 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:45 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:47 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:47 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:47 tower kernel: sdc : sense not available. 
Dec 19 20:28:47 tower kernel: sdc: Write Protect is off
Dec 19 20:28:47 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:47 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:49 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:49 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:49 tower kernel: sdc : sense not available. 
Dec 19 20:28:49 tower kernel: sdc: Write Protect is off
Dec 19 20:28:49 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:49 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:51 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:51 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:51 tower kernel: sdc : sense not available. 
Dec 19 20:28:51 tower kernel: sdc: Write Protect is off
Dec 19 20:28:51 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:51 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:53 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:53 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:53 tower kernel: sdc : sense not available. 
Dec 19 20:28:53 tower kernel: sdc: Write Protect is off
Dec 19 20:28:53 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:53 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:56 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:56 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:56 tower kernel: sdc : sense not available. 
Dec 19 20:28:56 tower kernel: sdc: Write Protect is off
Dec 19 20:28:56 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:56 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:28:58 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:28:58 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:28:58 tower kernel: sdc : sense not available. 
Dec 19 20:28:58 tower kernel: sdc: Write Protect is off
Dec 19 20:28:58 tower kernel: sdc: asking for cache data failed
Dec 19 20:28:58 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:00 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:00 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:00 tower kernel: sdc : sense not available. 
Dec 19 20:29:00 tower kernel: sdc: Write Protect is off
Dec 19 20:29:00 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:00 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:02 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:02 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:02 tower kernel: sdc : sense not available. 
Dec 19 20:29:02 tower kernel: sdc: Write Protect is off
Dec 19 20:29:02 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:02 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:04 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:04 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:04 tower kernel: sdc : sense not available. 
Dec 19 20:29:04 tower kernel: sdc: Write Protect is off
Dec 19 20:29:04 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:04 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:06 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:06 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:06 tower kernel: sdc : sense not available. 
Dec 19 20:29:06 tower kernel: sdc: Write Protect is off
Dec 19 20:29:06 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:06 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:08 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:08 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:08 tower kernel: sdc : sense not available. 
Dec 19 20:29:08 tower kernel: sdc: Write Protect is off
Dec 19 20:29:08 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:08 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:10 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:10 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:10 tower kernel: sdc : sense not available. 
Dec 19 20:29:10 tower kernel: sdc: Write Protect is off
Dec 19 20:29:10 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:10 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:12 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:12 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:12 tower kernel: sdc : sense not available. 
Dec 19 20:29:12 tower kernel: sdc: Write Protect is off
Dec 19 20:29:12 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:12 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:14 tower kernel: Buffer I/O error on device sdc1, logical block 0
Dec 19 20:29:14 tower kernel: lost page write due to I/O error on sdc1
Dec 19 20:29:14 tower kernel: EXT2-fs error (device sdc1): ext2_get_inode: unable to read inode block - inode=12, block=126
Dec 19 20:29:14 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:14 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:14 tower kernel: sdc : sense not available. 
Dec 19 20:29:14 tower kernel: sdc: Write Protect is off
Dec 19 20:29:14 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:14 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:16 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:16 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:16 tower kernel: sdc : sense not available. 
Dec 19 20:29:16 tower kernel: sdc: Write Protect is off
Dec 19 20:29:16 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:16 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:18 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:18 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:18 tower kernel: sdc : sense not available. 
Dec 19 20:29:18 tower kernel: sdc: Write Protect is off
Dec 19 20:29:18 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:18 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:20 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:20 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:20 tower kernel: sdc : sense not available. 
Dec 19 20:29:20 tower kernel: sdc: Write Protect is off
Dec 19 20:29:20 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:20 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:20 tower kernel: Buffer I/O error on device sdc1, logical block 0
Dec 19 20:29:20 tower kernel: lost page write due to I/O error on sdc1
Dec 19 20:29:22 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:22 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:22 tower kernel: sdc : sense not available. 
Dec 19 20:29:22 tower kernel: sdc: Write Protect is off
Dec 19 20:29:22 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:22 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:22 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:22 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:22 tower kernel: sdc : sense not available. 
Dec 19 20:29:22 tower kernel: sdc: Write Protect is off
Dec 19 20:29:22 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:22 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:24 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:24 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:24 tower kernel: sdc : sense not available. 
Dec 19 20:29:24 tower kernel: sdc: Write Protect is off
Dec 19 20:29:24 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:24 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:24 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:24 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:24 tower kernel: sdc : sense not available. 
Dec 19 20:29:24 tower kernel: sdc: Write Protect is off
Dec 19 20:29:24 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:24 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:26 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:26 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:26 tower kernel: sdc : sense not available. 
Dec 19 20:29:26 tower kernel: sdc: Write Protect is off
Dec 19 20:29:26 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:26 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:26 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:26 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:26 tower kernel: sdc : sense not available. 
Dec 19 20:29:26 tower kernel: sdc: Write Protect is off
Dec 19 20:29:26 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:26 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:28 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:28 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:28 tower kernel: sdc : sense not available. 
Dec 19 20:29:28 tower kernel: sdc: Write Protect is off
Dec 19 20:29:28 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:28 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:28 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:28 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:28 tower kernel: sdc : sense not available. 
Dec 19 20:29:28 tower kernel: sdc: Write Protect is off
Dec 19 20:29:28 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:28 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:30 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:30 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:30 tower kernel: sdc : sense not available. 
Dec 19 20:29:30 tower kernel: sdc: Write Protect is off
Dec 19 20:29:30 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:30 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:30 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:30 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:30 tower kernel: sdc : sense not available. 
Dec 19 20:29:30 tower kernel: sdc: Write Protect is off
Dec 19 20:29:30 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:30 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:32 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:32 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:32 tower kernel: sdc : sense not available. 
Dec 19 20:29:32 tower kernel: sdc: Write Protect is off
Dec 19 20:29:32 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:32 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:32 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:32 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:32 tower kernel: sdc : sense not available. 
Dec 19 20:29:32 tower kernel: sdc: Write Protect is off
Dec 19 20:29:32 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:32 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:34 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:34 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:34 tower kernel: sdc : sense not available. 
Dec 19 20:29:34 tower kernel: sdc: Write Protect is off
Dec 19 20:29:34 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:34 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:34 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:34 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:34 tower kernel: sdc : sense not available. 
Dec 19 20:29:34 tower kernel: sdc: Write Protect is off
Dec 19 20:29:34 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:34 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:36 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:36 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:36 tower kernel: sdc : sense not available. 
Dec 19 20:29:36 tower kernel: sdc: Write Protect is off
Dec 19 20:29:36 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:36 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:36 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:36 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:36 tower kernel: sdc : sense not available. 
Dec 19 20:29:36 tower kernel: sdc: Write Protect is off
Dec 19 20:29:36 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:36 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:38 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:38 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:38 tower kernel: sdc : sense not available. 
Dec 19 20:29:38 tower kernel: sdc: Write Protect is off
Dec 19 20:29:38 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:38 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:38 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:38 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:38 tower kernel: sdc : sense not available. 
Dec 19 20:29:38 tower kernel: sdc: Write Protect is off
Dec 19 20:29:38 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:38 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:40 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:40 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:40 tower kernel: sdc : sense not available. 
Dec 19 20:29:40 tower kernel: sdc: Write Protect is off
Dec 19 20:29:40 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:40 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:40 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:40 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:40 tower kernel: sdc : sense not available. 
Dec 19 20:29:40 tower kernel: sdc: Write Protect is off
Dec 19 20:29:40 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:40 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:42 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:42 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:42 tower kernel: sdc : sense not available. 
Dec 19 20:29:42 tower kernel: sdc: Write Protect is off
Dec 19 20:29:42 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:42 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:42 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:42 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:42 tower kernel: sdc : sense not available. 
Dec 19 20:29:42 tower kernel: sdc: Write Protect is off
Dec 19 20:29:42 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:42 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:44 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:44 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:44 tower kernel: sdc : sense not available. 
Dec 19 20:29:44 tower kernel: sdc: Write Protect is off
Dec 19 20:29:44 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:44 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:44 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:44 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:44 tower kernel: sdc : sense not available. 
Dec 19 20:29:44 tower kernel: sdc: Write Protect is off
Dec 19 20:29:44 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:44 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:46 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:46 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:46 tower kernel: sdc : sense not available. 
Dec 19 20:29:46 tower kernel: sdc: Write Protect is off
Dec 19 20:29:46 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:46 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:46 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:46 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:46 tower kernel: sdc : sense not available. 
Dec 19 20:29:46 tower kernel: sdc: Write Protect is off
Dec 19 20:29:46 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:46 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:48 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:48 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:48 tower kernel: sdc : sense not available. 
Dec 19 20:29:48 tower kernel: sdc: Write Protect is off
Dec 19 20:29:48 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:48 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:48 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:48 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:48 tower kernel: sdc : sense not available. 
Dec 19 20:29:48 tower kernel: sdc: Write Protect is off
Dec 19 20:29:48 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:48 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:50 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:50 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:50 tower kernel: sdc : sense not available. 
Dec 19 20:29:50 tower kernel: sdc: Write Protect is off
Dec 19 20:29:50 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:50 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:50 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:50 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:50 tower kernel: sdc : sense not available. 
Dec 19 20:29:50 tower kernel: sdc: Write Protect is off
Dec 19 20:29:50 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:50 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:52 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:52 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:52 tower kernel: sdc : sense not available. 
Dec 19 20:29:52 tower kernel: sdc: Write Protect is off
Dec 19 20:29:52 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:52 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:52 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:52 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:52 tower kernel: sdc : sense not available. 
Dec 19 20:29:52 tower kernel: sdc: Write Protect is off
Dec 19 20:29:52 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:52 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:54 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:54 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:54 tower kernel: sdc : sense not available. 
Dec 19 20:29:54 tower kernel: sdc: Write Protect is off
Dec 19 20:29:54 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:54 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:54 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:54 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:54 tower kernel: sdc : sense not available. 
Dec 19 20:29:54 tower kernel: sdc: Write Protect is off
Dec 19 20:29:54 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:54 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:56 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:56 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:56 tower kernel: sdc : sense not available. 
Dec 19 20:29:56 tower kernel: sdc: Write Protect is off
Dec 19 20:29:56 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:56 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:56 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:56 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:56 tower kernel: sdc : sense not available. 
Dec 19 20:29:56 tower kernel: sdc: Write Protect is off
Dec 19 20:29:56 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:56 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:58 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:58 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:58 tower kernel: sdc : sense not available. 
Dec 19 20:29:58 tower kernel: sdc: Write Protect is off
Dec 19 20:29:58 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:58 tower kernel: sdc: assuming drive cache: write through
Dec 19 20:29:58 tower kernel: sdc : READ CAPACITY failed.
Dec 19 20:29:58 tower kernel: sdc : status=0, message=00, host=4, driver=00 
Dec 19 20:29:58 tower kernel: sdc : sense not available. 
Dec 19 20:29:58 tower kernel: sdc: Write Protect is off
Dec 19 20:29:58 tower kernel: sdc: asking for cache data failed
Dec 19 20:29:58 tower kernel: sdc: assuming drive cache: write through
.....
