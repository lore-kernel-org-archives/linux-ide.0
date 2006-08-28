From: Eric Windisch <eric@grokthis.net>
Subject: Re: Libata-tj-stable patch /w sil3124 and PMP... 'device or
	resource busy'
Date: Sun, 27 Aug 2006 21:16:29 -0400
Message-ID: <1156727790.28709.1.camel@lennon>
References: <44E105A7.3030900@grokthis.net> <44E1C43E.1020302@gmail.com>
	 <44E28313.7050601@grokthis.net>  <44F16750.5080100@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-opLZfp5kwFxPlWMeJAJt"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from marley.grokthis.net ([69.93.78.26]:63644 "EHLO
	marley.grokthis.net") by vger.kernel.org with ESMTP id S932274AbWH1BPZ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 27 Aug 2006 21:15:25 -0400
In-Reply-To: <44F16750.5080100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--=-opLZfp5kwFxPlWMeJAJt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

dmesg output attached.

Thank you ;-)

-- 
Eric Windisch <eric@grokthis.net>
GrokThis.net

--=-opLZfp5kwFxPlWMeJAJt
Content-Disposition: attachment; filename=dmesg-patch-270806.txt
Content-Type: text/plain; name=dmesg-patch-270806.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit

[4294667.296000] Linux version 2.6.17.4 (root@san001) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #2 Sun Aug 27 13:58:52 EDT 2006
[4294667.296000] BIOS-provided physical RAM map:
[4294667.296000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
[4294667.296000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[4294667.296000]  BIOS-e820: 0000000000100000 - 000000000fffe000 (usable)
[4294667.296000]  BIOS-e820: 000000000fffe000 - 0000000010000000 (reserved)
[4294667.296000]  BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
[4294667.296000] 255MB LOWMEM available.
[4294667.296000] On node 0 totalpages: 65534
[4294667.296000]   DMA zone: 4096 pages, LIFO batch:0
[4294667.296000]   Normal zone: 61438 pages, LIFO batch:15
[4294667.296000] DMI 2.2 present.
[4294667.296000] ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf50
[4294667.296000] ACPI: RSDT (v001 DELL    G1      0x00000002 ASL  0x00000061) @ 0x000fdf64
[4294667.296000] ACPI: FADT (v001 DELL    G1      0x00000002 ASL  0x00000061) @ 0x000fdf8c
[4294667.296000] ACPI: DSDT (v001   OEMx    dt_ex 0x00001000 MSFT 0x01000005) @ 0x00000000
[4294667.296000] ACPI: PM-Timer IO Port: 0x808
[4294667.296000] Allocating PCI resources starting at 20000000 (gap: 10000000:efe00000)
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=/dev/mapper/SysDisk-Root ro
[4294667.296000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[4294667.296000] mapped APIC to ffffd000 (01201000)
[4294667.296000] Enabling fast FPU save and restore... done.
[4294667.296000] Initializing CPU#0
[4294667.296000] PID hash table entries: 1024 (order: 10, 4096 bytes)
[4294667.296000] Detected 399.018 MHz processor.
[4294667.296000] Using pmtmr for high-res timesource
[4294667.296000] Console: colour VGA+ 80x25
[4294668.474000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[4294668.475000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[4294668.506000] Memory: 248396k/262136k available (2798k kernel code, 13136k reserved, 888k data, 208k init, 0k highmem)
[4294668.506000] Checking if this processor honours the WP bit even in supervisor mode... Ok.
[4294668.567000] Calibrating delay using timer specific routine.. 798.57 BogoMIPS (lpj=399285)
[4294668.567000] Security Framework v1.0.0 initialized
[4294668.567000] SELinux:  Disabled at boot.
[4294668.567000] Capability LSM initialized
[4294668.567000] Mount-cache hash table entries: 512
[4294668.567000] CPU: After generic identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
[4294668.567000] CPU: After vendor identify, caps: 0183f9ff 00000000 00000000 00000000 00000000 00000000 00000000
[4294668.567000] CPU: L1 I cache: 16K, L1 D cache: 16K
[4294668.568000] CPU: L2 cache: 512K
[4294668.568000] CPU: After all inits, caps: 0183f9ff 00000000 00000000 00000040 00000000 00000000 00000000
[4294668.568000] CPU: Intel Pentium II (Deschutes) stepping 02
[4294668.568000] Checking 'hlt' instruction... OK.
[4294668.572000] SMP alternatives: switching to UP code
[4294668.572000] Freeing SMP alternatives: 0k freed
[4294668.595000] ACPI: setting ELCR to 0200 (from 1c00)
[4294668.596000] checking if image is initramfs... it is
[4294671.257000] Freeing initrd memory: 6595k freed
[4294671.258000] NET: Registered protocol family 16
[4294671.259000] ACPI: bus type pci registered
[4294671.274000] PCI: PCI BIOS revision 2.10 entry at 0xfca8e, last bus=1
[4294671.274000] Setting up standard PCI resources
[4294671.275000] ACPI: Subsystem revision 20060127
[4294671.293000] ACPI: Interpreter enabled
[4294671.293000] ACPI: Using PIC for interrupt routing
[4294671.294000] ACPI: PCI Root Bridge [PCI0] (0000:00)
[4294671.294000] PCI: Probing PCI hardware (bus 00)
[4294671.295000] ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
[4294671.301000] PCI quirk: region 0800-083f claimed by PIIX4 ACPI
[4294671.301000] PCI quirk: region 0850-085f claimed by PIIX4 SMB
[4294671.302000] Boot video device is 0000:01:00.0
[4294671.302000] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[4294671.322000] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
[4294671.324000] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
[4294671.326000] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 15)
[4294671.328000] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 *12 15)
[4294671.329000] Linux Plug and Play Support v0.97 (c) Adam Belay
[4294671.329000] pnp: PnP ACPI init
[4294671.352000] pnp: PnP ACPI: found 13 devices
[4294671.353000] SCSI subsystem initialized
[4294671.353000] usbcore: registered new driver usbfs
[4294671.353000] usbcore: registered new driver hub
[4294671.354000] PCI: Using ACPI for IRQ routing
[4294671.354000] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[4294671.365000] pnp: 00:0c: ioport range 0x800-0x85f could not be reserved
[4294671.366000] PCI: Bridge: 0000:00:01.0
[4294671.367000]   IO window: e000-efff
[4294671.367000]   MEM window: fc000000-feffffff
[4294671.367000]   PREFETCH window: f9000000-f9ffffff
[4294671.367000] NET: Registered protocol family 2
[4294671.377000] IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
[4294671.377000] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[4294671.377000] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[4294671.377000] TCP: Hash tables configured (established 8192 bind 4096)
[4294671.378000] TCP reno registered
[4294671.378000] * Found PM-Timer Bug on this chipset. Due to workarounds for a bug,
[4294671.378000] * this time source is slow.  Consider trying other time sources (clock=)
[4294671.379000] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[4294671.379000] apm: overridden by ACPI.
[4294671.383000] audit: initializing netlink socket (disabled)
[4294671.383000] audit(1156702243.382:1): initialized
[4294671.383000] VFS: Disk quotas dquot_6.5.1
[4294671.384000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[4294671.384000] Initializing Cryptographic API
[4294671.384000] io scheduler noop registered
[4294671.384000] io scheduler anticipatory registered
[4294671.384000] io scheduler deadline registered
[4294671.384000] io scheduler cfq registered (default)
[4294671.385000] Limiting direct PCI/PCI transfers.
[4294671.385000] ACPI: Power Button (FF) [PWRF]
[4294671.396000] Generic RTC Driver v1.07
[4294671.396000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
[4294671.397000] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294671.397000] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294671.399000] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[4294671.400000] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[4294671.403000] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
[4294671.404000] loop: loaded (max 8 devices)
[4294671.406000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 12
[4294671.406000] PCI: setting IRQ 12 as level-triggered
[4294671.406000] ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
[4294671.406000] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[4294671.406000] 0000:00:11.0: 3Com PCI 3c905B Cyclone 100baseTx at d0802000.
[4294671.428000] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[4294671.429000] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[4294671.429000] PIIX4: IDE controller at PCI slot 0000:00:07.1
[4294671.429000] PIIX4: chipset revision 1
[4294671.429000] PIIX4: not 100% native mode: will probe irqs later
[4294671.429000]     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
[4294671.429000]     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
[4294671.429000] Probing IDE interface ide0...
[4294671.693000] hda: WDC WD400BB-00AUA1, ATA DISK drive
[4294672.306000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[4294672.306000] Probing IDE interface ide1...
[4294672.978000] hdc: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
[4294673.284000] ide1 at 0x170-0x177,0x376 on irq 15
[4294673.285000] hda: max request size: 128KiB
[4294673.294000] hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
[4294673.294000] hda: cache flushes not supported
[4294673.294000]  hda: hda1 hda2
[4294673.299000] libata version 2.00 loaded.
[4294673.299000] sata_sil24 0000:00:0e.0: version 0.3
[4294673.300000] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
[4294673.300000] PCI: setting IRQ 10 as level-triggered
[4294673.300000] ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
[4294673.301000] ata1: SATA max UDMA/100 cmd 0xD0820000 ctl 0x0 bmdma 0x0 irq 10
[4294673.302000] ata2: SATA max UDMA/100 cmd 0xD0822000 ctl 0x0 bmdma 0x0 irq 10
[4294673.303000] ata3: SATA max UDMA/100 cmd 0xD0824000 ctl 0x0 bmdma 0x0 irq 10
[4294673.303000] ata4: SATA max UDMA/100 cmd 0xD0826000 ctl 0x0 bmdma 0x0 irq 10
[4294673.303000] scsi0 : sata_sil24
[4294673.618000] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4294673.717000] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
[4294673.794000] ata1.00: hard resetting port
[4294674.286000] ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4294674.297000] ata1.01: hard resetting port
[4294674.756000] ata1.01: SATA link down (SStatus 0 SControl 300)
[4294674.767000] ata1.02: hard resetting port
[4294675.215000] ata1.02: SATA link down (SStatus 0 SControl 300)
[4294675.226000] ata1.03: hard resetting port
[4294675.674000] ata1.03: SATA link down (SStatus 0 SControl 300)
[4294675.685000] ata1.04: hard resetting port
[4294676.144000] ata1.04: SATA link down (SStatus 0 SControl 300)
[4294676.144000] ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
[4294676.145000] ata1.00: ata1: dev 0 multi count 16
[4294676.146000] ata1.00: configured for UDMA/100
[4294676.157000] ata1: EH complete
[4294676.157000] scsi1 : sata_sil24
[4294676.482000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4294676.581000] ata2.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
[4294676.658000] ata2.00: hard resetting port
[4294677.161000] ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4294677.172000] ata2.01: hard resetting port
[4294677.631000] ata2.01: SATA link down (SStatus 0 SControl 300)
[4294677.642000] ata2.02: hard resetting port
[4294678.134000] ata2.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4294678.145000] ata2.03: hard resetting port
[4294678.604000] ata2.03: SATA link down (SStatus 0 SControl 300)
[4294678.615000] ata2.04: hard resetting port
[4294679.074000] ata2.04: SATA link down (SStatus 0 SControl 300)
[4294679.074000] ata2.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
[4294679.074000] ata2.00: ata2: dev 0 multi count 16
[4294679.076000] ata2.00: configured for UDMA/100
[4294679.076000] ata2.02: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
[4294679.076000] ata2.02: ata2: dev 0 multi count 16
[4294679.078000] ata2.02: configured for UDMA/100
[4294679.089000] ata2: EH complete
[4294679.089000] scsi2 : sata_sil24
[4294679.425000] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4294679.425000] ata3.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
[4294679.425000] ata3.00: ata3: dev 0 multi count 16
[4294679.426000] ata3.00: configured for UDMA/100
[4294679.427000] scsi3 : sata_sil24
[4294679.774000] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[4294679.774000] ata4.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth 31/32)
[4294679.774000] ata4.00: ata4: dev 0 multi count 16
[4294679.776000] ata4.00: configured for UDMA/100
[4294679.777000]   Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
[4294679.778000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294679.779000]   Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
[4294679.780000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294679.781000]   Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
[4294679.782000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294679.783000]   Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
[4294679.784000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294679.785000]   Vendor: ATA       Model: ST3320620AS       Rev: 3.AA
[4294679.786000]   Type:   Direct-Access                      ANSI SCSI revision: 05
[4294679.787000] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.787000] sda: Write Protect is off
[4294679.787000] sda: Mode Sense: 00 3a 00 00
[4294679.787000] SCSI device sda: drive cache: write back
[4294679.787000] SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.787000] sda: Write Protect is off
[4294679.787000] sda: Mode Sense: 00 3a 00 00
[4294679.787000] SCSI device sda: drive cache: write back
[4294679.787000]  sda: sda1
[4294679.803000] sd 0:0:0:0: Attached scsi disk sda
[4294679.803000] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.803000] sdb: Write Protect is off
[4294679.803000] sdb: Mode Sense: 00 3a 00 00
[4294679.803000] SCSI device sdb: drive cache: write back
[4294679.804000] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.804000] sdb: Write Protect is off
[4294679.804000] sdb: Mode Sense: 00 3a 00 00
[4294679.804000] SCSI device sdb: drive cache: write back
[4294679.804000]  sdb: sdb1
[4294679.825000] sd 1:0:0:0: Attached scsi disk sdb
[4294679.826000] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.826000] sdc: Write Protect is off
[4294679.826000] sdc: Mode Sense: 00 3a 00 00
[4294679.826000] SCSI device sdc: drive cache: write back
[4294679.826000] SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.826000] sdc: Write Protect is off
[4294679.826000] sdc: Mode Sense: 00 3a 00 00
[4294679.826000] SCSI device sdc: drive cache: write back
[4294679.826000]  sdc: sdc1
[4294679.842000] sd 1:0:2:0: Attached scsi disk sdc
[4294679.842000] SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.842000] sdd: Write Protect is off
[4294679.843000] sdd: Mode Sense: 00 3a 00 00
[4294679.843000] SCSI device sdd: drive cache: write back
[4294679.843000] SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.843000] sdd: Write Protect is off
[4294679.843000] sdd: Mode Sense: 00 3a 00 00
[4294679.843000] SCSI device sdd: drive cache: write back
[4294679.843000]  sdd: sdd1
[4294679.860000] sd 2:0:0:0: Attached scsi disk sdd
[4294679.861000] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.861000] sde: Write Protect is off
[4294679.861000] sde: Mode Sense: 00 3a 00 00
[4294679.861000] SCSI device sde: drive cache: write back
[4294679.861000] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[4294679.861000] sde: Write Protect is off
[4294679.861000] sde: Mode Sense: 00 3a 00 00
[4294679.862000] SCSI device sde: drive cache: write back
[4294679.862000]  sde: sde1
[4294679.878000] sd 3:0:0:0: Attached scsi disk sde
[4294679.879000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[4294679.879000] sd 1:0:0:0: Attached scsi generic sg1 type 0
[4294679.879000] sd 1:0:2:0: Attached scsi generic sg2 type 0
[4294679.879000] sd 2:0:0:0: Attached scsi generic sg3 type 0
[4294679.880000] sd 3:0:0:0: Attached scsi generic sg4 type 0
[4294679.880000] usbcore: registered new driver usbkbd
[4294679.880000] drivers/usb/input/usbkbd.c: :USB HID Boot Protocol keyboard driver
[4294679.880000] usbcore: registered new driver usbmouse
[4294679.880000] drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
[4294679.881000] PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[4294680.916000] serio: i8042 KBD port at 0x60,0x64 irq 1
[4294680.917000] mice: PS/2 mouse device common for all mice
[4294680.917000] md: linear personality registered for level -1
[4294680.917000] md: raid0 personality registered for level 0
[4294680.917000] md: raid1 personality registered for level 1
[4294680.917000] md: raid10 personality registered for level 10
[4294680.917000] md: raid5 personality registered for level 5
[4294680.917000] md: raid4 personality registered for level 4
[4294680.917000] raid5: measuring checksumming speed
[4294680.922000]    8regs     :   732.000 MB/sec
[4294680.927000]    8regs_prefetch:   592.000 MB/sec
[4294680.932000]    32regs    :   356.000 MB/sec
[4294680.937000]    32regs_prefetch:   332.000 MB/sec
[4294680.942000]    pII_mmx   :  1024.000 MB/sec
[4294680.947000]    p5_mmx    :  1060.000 MB/sec
[4294680.947000] raid5: using function: p5_mmx (1060.000 MB/sec)
[4294680.964000] raid6: int32x1     97 MB/s
[4294680.981000] raid6: int32x2     85 MB/s
[4294680.998000] raid6: int32x4     97 MB/s
[4294681.015000] raid6: int32x8     93 MB/s
[4294681.032000] raid6: mmxx1      226 MB/s
[4294681.049000] raid6: mmxx2      265 MB/s
[4294681.049000] raid6: using algorithm mmxx2 (265 MB/s)
[4294681.049000] md: raid6 personality registered for level 6
[4294681.049000] md: multipath personality registered for level -4
[4294681.049000] md: faulty personality registered for level -5
[4294681.049000] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[4294681.049000] md: bitmap version 4.39
[4294681.050000] device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
[4294681.050000] device-mapper: dm-multipath version 1.0.4 loaded
[4294681.050000] device-mapper: dm-round-robin version 1.0.0 loaded
[4294681.051000] TCP bic registered
[4294681.051000] NET: Registered protocol family 1
[4294681.090000] input: AT Translated Set 2 keyboard as /class/input/input0
[4294681.095000] Bridge firewalling registered
[4294681.095000] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[4294681.095000] All bugs added by David S. Miller <davem@redhat.com>
[4294681.095000] Using IPI Shortcut mode
[4294681.096000] Freeing unused kernel memory: 208k freed
[4294681.096000] Write protecting the kernel read-only data: 485k
[4294682.866000] XXX bd_claim 3:2/3:0 1@c0406572 1@c0162830
[4294682.866000]  <c01628d6> bd_claim+0xa6/0x130  <c0162830> bd_claim+0x0/0x130
[4294682.867000]  <c0163001> bd_claim_by_disk+0x91/0x1b0  <c0314615> open_dev+0x55/0xa0
[4294682.867000]  <c03153fd> dm_get_device+0x19d/0x470  <c0233fd7> vsscanf+0x4b7/0x530
[4294682.867000]  <c0315fcf> linear_ctr+0xaf/0x130  <c0314f4b> dm_table_add_target+0x17b/0x2f0
[4294682.867000]  <c0317e6f> table_load+0xff/0x220  <c0317371> ctl_ioctl+0x1c1/0x2e0
[4294682.868000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
[4294682.868000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
[4294682.868000]  <c0102c33> syscall_call+0x7/0xb 
[4294682.941000] XXX bd_claim 3:2/3:0 2@c0406572 2@c0162830
[4294682.941000]  <c01628d6> bd_claim+0xa6/0x130  <c0162830> bd_claim+0x0/0x130
[4294682.941000]  <c0163001> bd_claim_by_disk+0x91/0x1b0  <c0314615> open_dev+0x55/0xa0
[4294682.942000]  <c03153fd> dm_get_device+0x19d/0x470  <c0233fd7> vsscanf+0x4b7/0x530
[4294682.942000]  <c0315fcf> linear_ctr+0xaf/0x130  <c0314f4b> dm_table_add_target+0x17b/0x2f0
[4294682.942000]  <c0317e6f> table_load+0xff/0x220  <c0317371> ctl_ioctl+0x1c1/0x2e0
[4294682.942000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
[4294682.943000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
[4294682.943000]  <c0102c33> syscall_call+0x7/0xb 
[4294683.015000] XXX bd_claim 3:2/3:0 3@c0406572 3@c0162830
[4294683.016000]  <c01628d6> bd_claim+0xa6/0x130  <c0162830> bd_claim+0x0/0x130
[4294683.016000]  <c0163001> bd_claim_by_disk+0x91/0x1b0  <c0314615> open_dev+0x55/0xa0
[4294683.016000]  <c03153fd> dm_get_device+0x19d/0x470  <c0233fd7> vsscanf+0x4b7/0x530
[4294683.016000]  <c0315fcf> linear_ctr+0xaf/0x130  <c0314f4b> dm_table_add_target+0x17b/0x2f0
[4294683.017000]  <c0317e6f> table_load+0xff/0x220  <c0317371> ctl_ioctl+0x1c1/0x2e0
[4294683.017000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
[4294683.017000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
[4294683.017000]  <c0102c33> syscall_call+0x7/0xb 
[4294683.087000] Attempting manual resume
[4294683.115000] XXX bd_claim 253:0/253:0 2@c0442a60 2@c0442a60
[4294683.115000]  <c01628d6> bd_claim+0xa6/0x130  <c0163ae5> open_bdev_excl+0x65/0x90
[4294683.115000]  <c01623af> get_sb_bdev+0x2f/0x15a  <c01422a3> __alloc_pages+0x53/0x310
[4294683.115000]  <c01deab0> ext3_get_sb+0x30/0x40  <c01e0a60> ext3_fill_super+0x0/0x17f0
[4294683.116000]  <c0161af9> do_kern_mount+0xd9/0x190  <c0178f09> do_mount+0x3f9/0x770
[4294683.116000]  <c014a418> __handle_mm_fault+0x678/0x830  <c016b7bb> do_path_lookup+0x8b/0x200
[4294683.116000]  <c0168f3f> getname+0xdf/0x110  <c01422a3> __alloc_pages+0x53/0x310
[4294683.117000]  <c0113b30> do_page_fault+0x0/0x701  <c01427ee> __get_free_pages+0x1e/0x50
[4294683.118000]  <c0177b68> copy_mount_options+0x48/0x160  <c0179318> sys_mount+0x98/0xe0
[4294683.118000]  <c0102c33> syscall_call+0x7/0xb 
[4294683.131000] kjournald starting.  Commit interval 5 seconds
[4294683.131000] EXT3-fs: mounted filesystem with ordered data mode.
[4294689.226000] ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
[4294689.227000] eth1:  setting full-duplex.
[4294689.782000] USB Universal Host Controller Interface driver v3.0
[4294689.782000] ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 12 (level, low) -> IRQ 12
[4294689.782000] uhci_hcd 0000:00:07.2: UHCI Host Controller
[4294689.783000] uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
[4294689.783000] uhci_hcd 0000:00:07.2: irq 12, io base 0x0000dce0
[4294689.783000] usb usb1: configuration #1 chosen from 1 choice
[4294689.783000] hub 1-0:1.0: USB hub found
[4294689.783000] hub 1-0:1.0: 2 ports detected
[4294689.908000] Linux agpgart interface v0.101 (c) Dave Jones
[4294690.039000] agpgart: Detected an Intel 440BX Chipset.
[4294690.047000] agpgart: AGP aperture is 64M @ 0xf4000000
[4294690.064000] hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)
[4294690.064000] Uniform CD-ROM driver Revision: 3.20
[4294690.148000] piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
[4294690.148000] piix4_smbus 0000:00:07.3: Host SMBus controller not enabled!
[4294690.735000] NET: Registered protocol family 17
[4294693.184000] floppy0: no floppy controllers found
[4294693.477000] NET: Registered protocol family 10
[4294693.478000] lo: Disabled Privacy Extensions
[4294693.478000] IPv6 over IPv4 tunneling driver
[4294694.160000] XXX bd_claim 253:2/253:2 2@c01525b0 2@c01525b0
[4294694.160000]  <c01628d6> bd_claim+0xa6/0x130  <c01525b0> sys_swapon+0x0/0xb50
[4294694.161000]  <c01525b0> sys_swapon+0x0/0xb50  <c01528c2> sys_swapon+0x312/0xb50
[4294694.161000]  <c01525b0> sys_swapon+0x0/0xb50  <c0113c67> do_page_fault+0x137/0x701
[4294694.161000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
[4294694.175000] Adding 1048568k swap on /dev/mapper/SysDisk-Swap.  Priority:-1 extents:1 across:1048568k
[4294694.296000] XXX bd_claim 253:0 failed 2@c0442a60
[4294694.313000] EXT3 FS on dm-0, internal journal
[4294703.856000] eth1: no IPv6 routers present
[4294705.726000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.726000] device-mapper: dm-linear: Device lookup failed
[4294705.726000] device-mapper: error adding target to table
[4294705.728000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.728000] device-mapper: dm-linear: Device lookup failed
[4294705.728000] device-mapper: error adding target to table
[4294705.730000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.730000] device-mapper: dm-linear: Device lookup failed
[4294705.731000] device-mapper: error adding target to table
[4294705.733000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.733000] device-mapper: dm-linear: Device lookup failed
[4294705.733000] device-mapper: error adding target to table
[4294705.735000] XXX bd_claim 8:0/8:0 2@c0406572 2@c0406572
[4294705.735000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
[4294705.735000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
[4294705.736000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
[4294705.736000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
[4294705.736000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c013f305> __generic_file_aio_write_nolock+0x285/0x490
[4294705.737000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
[4294705.737000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
[4294705.737000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
[4294705.740000] XXX bd_claim 8:16/8:16 2@c0406572 2@c0406572
[4294705.740000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
[4294705.740000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
[4294705.740000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
[4294705.741000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
[4294705.741000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c0173b33> dput+0x93/0x140
[4294705.741000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
[4294705.742000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
[4294705.742000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
[4294705.745000] XXX bd_claim 8:32/8:32 2@c0406572 2@c0406572
[4294705.745000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
[4294705.745000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
[4294705.745000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
[4294705.746000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
[4294705.746000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c0173b33> dput+0x93/0x140
[4294705.746000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
[4294705.746000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
[4294705.747000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
[4294705.749000] XXX bd_claim 8:48/8:48 2@c0406572 2@c0406572
[4294705.749000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
[4294705.750000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
[4294705.750000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
[4294705.750000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
[4294705.751000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c0173b33> dput+0x93/0x140
[4294705.751000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
[4294705.751000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
[4294705.751000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
[4294705.754000] XXX bd_claim 8:64/8:64 2@c0406572 2@c0406572
[4294705.754000]  <c01628d6> bd_claim+0xa6/0x130  <c0163001> bd_claim_by_disk+0x91/0x1b0
[4294705.755000]  <c0314615> open_dev+0x55/0xa0  <c03153fd> dm_get_device+0x19d/0x470
[4294705.755000]  <c0233fd7> vsscanf+0x4b7/0x530  <c0315fcf> linear_ctr+0xaf/0x130
[4294705.755000]  <c0314f4b> dm_table_add_target+0x17b/0x2f0  <c0317e6f> table_load+0xff/0x220
[4294705.755000]  <c0317371> ctl_ioctl+0x1c1/0x2e0  <c0173b33> dput+0x93/0x140
[4294705.756000]  <c0317d70> table_load+0x0/0x220  <c016e176> do_ioctl+0x76/0x80
[4294705.756000]  <c016e1d2> vfs_ioctl+0x52/0x2c0  <c016e4c8> sys_ioctl+0x88/0xa0
[4294705.756000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
[4294705.759000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.759000] device-mapper: dm-linear: Device lookup failed
[4294705.759000] device-mapper: error adding target to table
[4294705.762000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.762000] device-mapper: dm-linear: Device lookup failed
[4294705.762000] device-mapper: error adding target to table
[4294705.764000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.764000] device-mapper: dm-linear: Device lookup failed
[4294705.764000] device-mapper: error adding target to table
[4294705.767000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.767000] device-mapper: dm-linear: Device lookup failed
[4294705.767000] device-mapper: error adding target to table
[4294705.769000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.769000] device-mapper: dm-linear: Device lookup failed
[4294705.769000] device-mapper: error adding target to table
[4294705.772000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.772000] device-mapper: dm-linear: Device lookup failed
[4294705.772000] device-mapper: error adding target to table
[4294705.774000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.774000] device-mapper: dm-linear: Device lookup failed
[4294705.774000] device-mapper: error adding target to table
[4294705.776000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.776000] device-mapper: dm-linear: Device lookup failed
[4294705.776000] device-mapper: error adding target to table
[4294705.779000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.779000] device-mapper: dm-linear: Device lookup failed
[4294705.779000] device-mapper: error adding target to table
[4294705.781000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.781000] device-mapper: dm-linear: Device lookup failed
[4294705.781000] device-mapper: error adding target to table
[4294705.784000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.784000] device-mapper: dm-linear: Device lookup failed
[4294705.784000] device-mapper: error adding target to table
[4294705.786000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.787000] device-mapper: dm-linear: Device lookup failed
[4294705.787000] device-mapper: error adding target to table
[4294705.790000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.790000] device-mapper: dm-linear: Device lookup failed
[4294705.790000] device-mapper: error adding target to table
[4294705.792000] XXX bd_claim 3:0 failed 3@c0162830
[4294705.792000] device-mapper: dm-linear: Device lookup failed
[4294705.792000] device-mapper: error adding target to table
[4294706.209000] XXX bd_claim 3:1/3:0 1@cee127a0 4@c0162830
[4294706.209000]  <c01628d6> bd_claim+0xa6/0x130  <c0162830> bd_claim+0x0/0x130
[4294706.210000]  <c016399c> blkdev_open+0x5c/0x80  <c015a0cb> __dentry_open+0xbb/0x220
[4294706.210000]  <c015a34c> do_filp_open+0x5c/0x70  <c0159c7b> get_unused_fd+0x5b/0xc0
[4294706.210000]  <c015a3b3> do_sys_open+0x53/0x100  <c015a4b7> sys_open+0x27/0x30
[4294706.211000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
[4294706.211000] XXX bd_release 3:1/3:0 1@cee127a0 4@c0162830
[4294706.238000] XXX bd_claim 253:1/253:1 2@cee78820 2@cee78820
[4294706.238000]  <c01628d6> bd_claim+0xa6/0x130  <c016399c> blkdev_open+0x5c/0x80
[4294706.239000]  <c015a0cb> __dentry_open+0xbb/0x220  <c015a34c> do_filp_open+0x5c/0x70
[4294706.239000]  <c0159c7b> get_unused_fd+0x5b/0xc0  <c015a3b3> do_sys_open+0x53/0x100
[4294706.239000]  <c015a4b7> sys_open+0x27/0x30  <c0102bcb> sysenter_past_esp+0x54/0x75
[4294706.239000] XXX bd_release 253:1/253:1 2@cee78820 2@cee78820
[4294706.408000] XXX bd_claim 3:1/3:0 1@c0442a60 4@c0162830
[4294706.408000]  <c01628d6> bd_claim+0xa6/0x130  <c0162830> bd_claim+0x0/0x130
[4294706.408000]  <c0163ae5> open_bdev_excl+0x65/0x90  <c01623af> get_sb_bdev+0x2f/0x15a
[4294706.409000]  <c01422a3> __alloc_pages+0x53/0x310  <c01deab0> ext3_get_sb+0x30/0x40
[4294706.409000]  <c01e0a60> ext3_fill_super+0x0/0x17f0  <c0161af9> do_kern_mount+0xd9/0x190
[4294706.409000]  <c0178f09> do_mount+0x3f9/0x770  <c014a418> __handle_mm_fault+0x678/0x830
[4294706.409000]  <c014a3f5> __handle_mm_fault+0x655/0x830  <c016b7bb> do_path_lookup+0x8b/0x200
[4294706.410000]  <c0168f3f> getname+0xdf/0x110  <c01422a3> __alloc_pages+0x53/0x310
[4294706.410000]  <c0113b30> do_page_fault+0x0/0x701  <c01427ee> __get_free_pages+0x1e/0x50
[4294706.410000]  <c0177b68> copy_mount_options+0x48/0x160  <c0179318> sys_mount+0x98/0xe0
[4294706.410000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
[4294706.421000] kjournald starting.  Commit interval 5 seconds
[4294706.423000] EXT3 FS on hda1, internal journal
[4294706.423000] EXT3-fs: mounted filesystem with ordered data mode.
[4294706.426000] XXX bd_claim 253:1/253:1 2@c0442a60 2@c0442a60
[4294706.426000]  <c01628d6> bd_claim+0xa6/0x130  <c0163ae5> open_bdev_excl+0x65/0x90
[4294706.427000]  <c01623af> get_sb_bdev+0x2f/0x15a  <c01422a3> __alloc_pages+0x53/0x310
[4294706.427000]  <c01deab0> ext3_get_sb+0x30/0x40  <c01e0a60> ext3_fill_super+0x0/0x17f0
[4294706.427000]  <c0161af9> do_kern_mount+0xd9/0x190  <c0178f09> do_mount+0x3f9/0x770
[4294706.428000]  <c01dfde4> __ext3_journal_stop+0x24/0x50  <c01d9f1c> ext3_delete_inode+0x13c/0x150
[4294706.428000]  <c0173b33> dput+0x93/0x140  <c0177913> mntput_no_expire+0x23/0x90
[4294706.428000]  <c016b7bb> do_path_lookup+0x8b/0x200  <c0168f3f> getname+0xdf/0x110
[4294706.428000]  <c01422a3> __alloc_pages+0x53/0x310  <c01427ee> __get_free_pages+0x1e/0x50
[4294706.429000]  <c0177b68> copy_mount_options+0x48/0x160  <c0179318> sys_mount+0x98/0xe0
[4294706.429000]  <c0102bcb> sysenter_past_esp+0x54/0x75 
[4294706.448000] kjournald starting.  Commit interval 5 seconds
[4294706.450000] EXT3 FS on dm-1, internal journal
[4294706.450000] EXT3-fs: mounted filesystem with ordered data mode.
[4294775.584000] XXX bd_claim 8:65 failed 0@00000000 (part of a held dev)
[4294798.498000] XXX bd_claim 8:65 failed 0@00000000 (part of a held dev)

--=-opLZfp5kwFxPlWMeJAJt--

