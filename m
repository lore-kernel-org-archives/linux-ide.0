From: Aron Rubin <arubin@atl.lmco.com>
Subject: Re: SII 3512 SATA Progress but help still needed
Date: Mon, 08 Dec 2003 15:01:14 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FD4D88A.3050708@atl.lmco.com>
References: <3FCF9B07.5020509@atl.lmco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [192.35.37.50] ([192.35.37.50]:64918 "EHLO
	enterprise.atl.lmco.com") by vger.kernel.org with ESMTP
	id S261522AbTLHUBU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 8 Dec 2003 15:01:20 -0500
Received: from atl.lmco.com (druidia [166.17.245.107])
	by enterprise.atl.lmco.com (Postfix) with ESMTP id 0B5D9C1D0F
	for <linux-ide@vger.kernel.org>; Mon,  8 Dec 2003 15:01:15 -0500 (EST)
In-Reply-To: <3FCF9B07.5020509@atl.lmco.com>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

And by "help" I meant in the form of meaningful conversation on the 
subject. Could someone reply with a "I don't know" or "I will not talk 
with the likes of you" so I know my messages are not bing accidentally 
routed into the vacuum of space.

Thank you,
Aron

Aron Rubin wrote:
> I have made much progress with the latest patches, I am able to boot 
> now. Please help me with the rest. The system is still constantly timing 
> out. See attachments below.
> 
> Aron Rubin wrote:
>  > SATA controller SII 3512 not recognized by driver. It looks like SII
>  > 3512 is almost identical to 3112 interface. I copy/paste/alterred all
>  > code in ide/pci/siimage.[ch] with "3112" in it to "3512". It seems
>  > about 95% functional. Need help with remaining 5%, related to very,
>  > very, slow controller comms during init with occational "Interrupt
>  > Lost" messages. Seems like comms are out of sync and then resync over
>  > and over. Other than that all drive info comes over.
> 
> 
> ------------------------------------------------------------------------
> 
> 422 (Red Hat Linux 3.2.3-6)) #2 Wed Dec 3 21:56:06 EST 2003
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
>  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
>  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
>  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
>  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
> Warning only 896MB will be used.
> Use a HIGHMEM enabled kernel.
> 896MB LOWMEM available.
> ACPI: have wakeup address 0xc0001000
> found SMP MP-table at 000f5000
> hm, page 000f5000 reserved twice.
> hm, page 000f0000 reserved twice.
> hm, page 000f1000 reserved twice.
> On node 0 totalpages: 229376
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 0 pages.
> ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6ab0
> ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
> ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
> ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff7b80
> ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0 Unknown CPU [15:4] APIC version 16
> ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x0] trigger[0x0] lint[0x1])
> Using ACPI for processor (LAPIC) configuration information
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
> OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
> I/O APIC #2 Version 17 at 0xFEC00000.
> Processors: 1
> xAPIC support is not present
> Enabling APIC mode: Flat.	Using 1 I/O APICs
> Kernel command line: ro root=LABEL=/ hdc=ide-scsi
> ide_setup: hdc=ide-scsi
> Initializing CPU#0
> Detected 1994.874 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3984.58 BogoMIPS
> Memory: 903796k/917504k available (1520k kernel code, 13320k reserved, 1128k data, 148k init, 0k highmem)
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096 bytes)
> Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
> Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> Intel machine check architecture supported.
> Intel machine check reporting enabled on CPU#0.
> CPU:     After generic, caps: 078bfbff e1d3fbff 00000000 00000000
> CPU:             Common caps: 078bfbff e1d3fbff 00000000 00000000
> CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support... done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> ENABLING IO-APIC IRQs
> Setting 2 in the phys_id_present_map
> ...changing IO-APIC physical APIC ID to 2 ... ok.
> init IO_APIC IRQs
>  IO-APIC (apicid-pin) 2-0, 2-5, 2-9, 2-18, 2-20, 2-21, 2-22, 2-23 not connected.
> ..TIMER: vector=0x31 pin1=2 pin2=0
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> ...trying to set up timer (IRQ0) through the 8259A ... 
> ..... (found pin 0) ...works.
> number of MP IRQ sources: 18.
> number of IO-APIC #2 registers: 24.
> testing the IO APIC.......................
> 
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00170011
> .......     : max redirection entries: 0017
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 0011
> .... register #02: 02000000
> .......     : arbitration: 02
> .... IRQ redirection table:
>  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
>  00 0FF 0F  0    0    0   0   0    1    1    31
>  01 0FF 0F  0    0    0   0   0    1    1    39
>  02 000 00  1    0    0   0   0    0    0    00
>  03 0FF 0F  0    0    0   0   0    1    1    41
>  04 0FF 0F  0    0    0   0   0    1    1    49
>  05 000 00  1    0    0   0   0    0    0    00
>  06 0FF 0F  0    0    0   0   0    1    1    51
>  07 0FF 0F  0    0    0   0   0    1    1    59
>  08 0FF 0F  0    0    0   0   0    1    1    61
>  09 000 00  1    0    0   0   0    0    0    00
>  0a 0FF 0F  0    0    0   0   0    1    1    69
>  0b 0FF 0F  0    0    0   0   0    1    1    71
>  0c 0FF 0F  0    0    0   0   0    1    1    79
>  0d 0FF 0F  0    0    0   0   0    1    1    81
>  0e 0FF 0F  0    0    0   0   0    1    1    89
>  0f 0FF 0F  0    0    0   0   0    1    1    91
>  10 0FF 0F  1    1    0   1   0    1    1    99
>  11 0FF 0F  1    1    0   1   0    1    1    A1
>  12 000 00  1    0    0   0   0    0    0    00
>  13 0FF 0F  1    1    0   1   0    1    1    A9
>  14 000 00  1    0    0   0   0    0    0    00
>  15 000 00  1    0    0   0   0    0    0    00
>  16 000 00  1    0    0   0   0    0    0    00
>  17 000 00  1    0    0   0   0    0    0    00
> IRQ to pin mappings:
> IRQ0 -> 0:0
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> IRQ16 -> 0:16
> IRQ17 -> 0:17
> IRQ19 -> 0:19
> .................................... done.
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1994.8842 MHz.
> ..... host bus clock speed is 199.4883 MHz.
> cpu: 0, clocks: 1994883, slice: 997441
> CPU0<T0:1994880,T1:997424,D:15,S:997441,C:1994883>
> mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> ACPI: Subsystem revision 20031002
> ACPI: Interpreter disabled.
> PCI: PCI BIOS revision 2.10 entry at 0xfac80, last bus=2
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Probing PCI hardware (bus 00)
> PCI: Using IRQ router default [10de/00d1] at 00:00.0
> PCI->APIC IRQ transform: (B1,I9,P0) -> 17
> PCI->APIC IRQ transform: (B1,I11,P0) -> 19
> PCI->APIC IRQ transform: (B1,I12,P0) -> 16
> PCI->APIC IRQ transform: (B1,I13,P0) -> 17
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
> Starting kswapd
> VFS: Disk quotas vdquot_6.5.1
> Journalled Block Device driver loaded
> pty: 2048 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI enabled
> ttyS0 at 0x03f8 (irq = 4) is a 16550A
> Real Time Clock Driver v1.10e
> NET4: Frame Diverter 0.46
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> NFORCE3: IDE controller at PCI slot 00:08.0
> NFORCE3: chipset revision 165
> NFORCE3: not 100% native mode: will probe irqs later
> AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
> AMD_IDE: PCI device 10de:00d5 (nVidia Corporation) (rev a5) UDMA133 controller on pci00:08.0
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> SiI3512 Serial ATA: IDE controller at PCI slot 01:0d.0
> SiI3512 Serial ATA: chipset revision 1
> SiI3512 Serial ATA: not 100% native mode: will probe irqs later
>     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
>     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
> hda: WDC AC28400R, ATA DISK drive
> blk: queue c0420380, I/O limit 4095Mb (mask 0xffffffff)
> hdc: HL-DT-ST RW/DVD GCC-4520B, ATAPI CD/DVD-ROM drive
> hde: ST380013AS, ATA DISK drive
> blk: queue c0420c38, I/O limit 4095Mb (mask 0xffffffff)
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> ide2 at 0xf880d080-0xf880d087,0xf880d08a on irq 17
> hda: attached ide-disk driver.
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }
> hda: host protected area => 1
> hda: 16514064 sectors (8455 MB) w/512KiB Cache, CHS=1027/255/63
> hde: attached ide-disk driver.
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: host protected area => 1
> hde: lost interrupt
> hde: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63
> hde: lost interrupt
> hde: lost interrupt
> Partition check:
>  hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
>  hde:<4>hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
>  hde1
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> Initializing Cryptographic API
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 8192 buckets, 64Kbytes
> TCP: Hash tables configured (established 262144 bind 65536)
> Linux IP multicast router 0.06 plus PIM-SM
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 95k freed
> VFS: Mounted root (ext2 filesystem).
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> Freeing unused kernel memory: 148k freed
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> PCI: Setting latency timer of device 00:02.0 to 64
> usb-ohci.c: USB OHCI at membase 0xf882d000, IRQ 3
> usb-ohci.c: usb-00:02.0, PCI device 10de:00d7 (nVidia Corporation)
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 3 ports detected
> PCI: Setting latency timer of device 00:02.1 to 64
> usb-ohci.c: USB OHCI at membase 0xf882f000, IRQ 3
> usb-ohci.c: usb-00:02.1, PCI device 10de:00d7 (nVidia Corporation)
> usb.c: new USB bus registered, assigned bus number 2
> hub.c: USB hub found
> hub.c: 3 ports detected
> PCI: Setting latency timer of device 00:02.2 to 64
> ehci_hcd 00:02.2: PCI device 10de:00d8 (nVidia Corporation)
> ehci_hcd 00:02.2: irq 3, pci mem f8838000
> usb.c: new USB bus registered, assigned bus number 3
> PCI: cache line size of 64 is not supported by device 00:02.2
> ehci_hcd 00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-19/2.4
> hub.c: USB hub found
> hub.c: 6 ports detected
> usb.c: registered new driver hid
> hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
> hid-core.c: USB HID support drivers
> mice: PS/2 mouse device common for all mice
> hub.c: new USB device 00:02.1-3, assigned address 2
> : USB HID v1.10 Mouse [Logitech USB Receiver] on usb2:2.0
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
> Adding Swap: 265032k swap-space (priority -1)
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> hde: dma_timer_expiry: dma status == 0x24
> hde: DMA interrupt recovery
> hde: lost interrupt
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> ohci1394: $Rev: 1010 $ Ben Collins <bcollins@debian.org>
> ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[5]  MMIO=[e3006000-e30067ff]  Max Packet=[2048]
> SCSI subsystem driver Revision: 1.00
> hdc: attached ide-scsi driver.
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: HL-DT-ST  Model: RW/DVD GCC-4520B  Rev: 1.00
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> 
> 
> ------------------------------------------------------------------------
> 
> name			value		min		max		mode
> ----			-----		---		---		----
> acoustic                0               0               254             rw
> address                 1               0               2               rw
> bios_cyl                9729            0               65535           rw
> bios_head               255             0               255             rw
> bios_sect               63              0               63              rw
> breada_readahead        8               0               255             rw
> bswap                   0               0               1               r
> current_speed           70              0               70              rw
> failures                0               0               65535           rw
> file_readahead          124             0               16384           rw
> init_speed              70              0               70              rw
> io_32bit                0               0               3               rw
> keepsettings            0               0               1               rw
> lun                     0               0               7               rw
> max_failures            1               0               65535           rw
> max_kb_per_request      15              1               255             rw
> multcount               16              0               16              rw
> nice1                   1               0               1               rw
> nowerr                  0               0               1               rw
> number                  0               0               3               rw
> pio_mode                write-only      0               255             w
> slow                    0               0               1               rw
> unmaskirq               0               0               1               rw
> using_dma               1               0               1               rw
> wcache                  0               0               1               rw
> 
> 
> ------------------------------------------------------------------------
> 
> 
> 
> Controller: 0
> SiI3512 Chipset.
> MMIO Base 0xe3005000
> MMIO-DMA Base 0xe3005000
> MMIO-DMA Base 0xe3005008


-- 

ssh aron@rubinium.org cat /dev/brain | grep ^work:

Aron Rubin                       Member, Engineering Staff
Lockheed Martin                  E-Mail: arubin@atl.lmco.com
Advanced Technology Laboratories Phone:  856.792.9865
3 Executive Campus               Fax:    856.792.9930
Cherry Hill, NJ USA 08002        Web:    http://www.atl.lmco.com

