From: Ericisko <linux2@rogers.com>
Subject: Re: Pata support on Promise controller under Fedora Core 3
Date: Wed, 27 Oct 2004 13:18:26 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041027171826.17577.qmail@web88003.mail.re2.yahoo.com>
References: <003201c4bc3e$b83df940$0a01a8c0@jbsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web88003.mail.re2.yahoo.com ([206.190.37.190]:27557 "HELO
	web88003.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262535AbUJ0RS2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 13:18:28 -0400
In-Reply-To: <003201c4bc3e$b83df940$0a01a8c0@jbsys.com>
List-Id: linux-ide@vger.kernel.org
To: "James  C. Bevier" <jbev@jbsys.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

James,

you seem to have only part of the patch. First 2 ports
on Promise controller should show up as SATA, not
PATA.

You can have a look at source code on Promise web
site. Search for DualOnly, there seems to be detection
code for dual master mode. Btw. it seems that port
0x380 should be correct value but you may need to do
some controller initialization before you can use it.
I'll have a look when I get home today.

  Erik

 --- "James  C. Bevier" <jbev@jbsys.com> wrote: 
> 
> ----- Original Message ----- 
> From: "Jeff Garzik" <jgarzik@pobox.com>
> To: "Ericisko" <linux2@rogers.com>
> Cc: "James C. Bevier" <jbev@jbsys.com>;
> <linux-ide@vger.kernel.org>
> Sent: Wednesday, October 27, 2004 7:08 AM
> Subject: Re: Pata support on Promise controller
> under Fedora Core 3
> 
> 
> > Ericisko wrote:
> >> James,
> >> 
> >> you have the same controller as me (PDC20378)
> which
> >> has only 1 PATA port. PATA ports support up to 2
> >> devices per port, as opposed to SATA ports which
> >> support only 1 device per port.
> >> There is source code for 2.4 linux driver on
> Promise
> >> web site, you can have a look.
> >> Could you send your dmesg output?
> > 
> > 
> > Note that PDC2037x has a "dual master mode", where
> two PATA devices 
> > (master/slave) on the same cable can be made to
> look like two 
> > independent PATA masters, thus giving the illusion
> that there are two ports.
> > 
> > Jeff
> >
> 
> Here is the dmesg output.  The Promise controller is
> built into the ASUS mb.
> If the one port can have two drives, there must be
> some more status that
> can be read to see if two drives are present.  The
> current code does not
> seem to do anything like that.  Where can I go from
> here?
> 
> Jim> Bootdata ok (command line is ro root=/dev/hdb7)
> Linux version 2.6.9-1.643.pata (root@jbsys) (gcc
> version 3.4.2 20041017 (Red Hat 3.4.2-6)) #1 Tue Oct
> 26 13:54:53 MST 2004
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00
> (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000
> (reserved)
>  BIOS-e820: 00000000000e4000 - 0000000000100000
> (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ff30000
> (usable)
>  BIOS-e820: 000000003ff30000 - 000000003ff40000
> (ACPI data)
>  BIOS-e820: 000000003ff40000 - 000000003fff0000
> (ACPI NVS)
>  BIOS-e820: 000000003fff0000 - 0000000040000000
> (reserved)
>  BIOS-e820: 00000000fff80000 - 0000000100000000
> (reserved)
> No mptable found.
> On node 0 totalpages: 261936
>   DMA zone: 4096 pages, LIFO batch:1
>   Normal zone: 257840 pages, LIFO batch:16
>   HighMem zone: 0 pages, LIFO batch:1
> ACPI: RSDP (v000 ACPIAM                             
>   ) @ 0x00000000000fa8b0
> ACPI: RSDT (v001 A M I  OEMRSDT  0x08000403 MSFT
> 0x00000097) @ 0x000000003ff30000
> ACPI: FADT (v001 A M I  OEMFACP  0x08000403 MSFT
> 0x00000097) @ 0x000000003ff30200
> ACPI: MADT (v001 A M I  OEMAPIC  0x08000403 MSFT
> 0x00000097) @ 0x000000003ff30390
> ACPI: OEMB (v001 A M I  OEMBIOS  0x08000403 MSFT
> 0x00000097) @ 0x000000003ff40040
> ACPI: DSDT (v001  A0058 A0058002 0x00000002 MSFT
> 0x0100000d) @ 0x0000000000000000
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> Processor #0 15:4 APIC version 16
> ACPI: IOAPIC (id[0x01] address[0xfec00000]
> gsi_base[0])
> IOAPIC[0]: apic_id 1, version 3, address 0xfec00000,
> GSI 0-23
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl
> dfl)
> ACPI: IRQ0 used by override.
> ACPI: IRQ2 used by override.
> ACPI: IRQ9 used by override.
> Using ACPI (MADT) for SMP configuration information
> Checking aperture...
> CPU 0: aperture @ f8000000 size 64 MB
> Built 1 zonelists
> Kernel command line: ro root=/dev/hdb7 console=tty0
> Initializing CPU#0
> PID hash table entries: 4096 (order: 12, 131072
> bytes)
> time.c: Using 1.193182 MHz PIT timer.
> time.c: Detected 2100.101 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 262144 (order: 9,
> 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 8,
> 1048576 bytes)
> Memory: 1024012k/1047744k available (2469k kernel
> code, 23012k reserved, 1311k data, 164k init)
> Calibrating delay loop... 4128.76 BogoMIPS
> (lpj=2064384)
> Security Scaffold v1.0.0 initialized
> SELinux:  Initializing.
> SELinux:  Starting in permissive mode
> There is already a security framework initialized,
> register_security failed.
> selinux_register_security:  Registering secondary
> module capability
> Capability LSM initialized as secondary
> Mount-cache hash table entries: 256 (order: 0, 4096
> bytes)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K
> (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 08
> Using local APIC NMI watchdog using perfctr0
> Using local APIC timer interrupts.
> Detected 13.125 MHz APIC timer.
> checking if image is initramfs... it is
> NET: Registered protocol family 16
> PCI: Using configuration type 1
> mtrr: v2.0 (20020519)
> ACPI: Subsystem revision 20040816
> ACPI: Interpreter enabled
> ACPI: Using IOAPIC for interrupt routing
> ACPI: PCI Root Bridge [PCI0] (00:00)
> PCI: Probing PCI hardware (bus 00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11
> 14 15)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11
> 14 15)
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 7 10 11
> 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11
> 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11
> 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11
> 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11
> 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11
> 14 15) *0, disabled.
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> PCI: Using ACPI for IRQ routing
> ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 16
> (level, low) -> IRQ 169
> ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 18
> (level, low) -> IRQ 177
> ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17
> (level, low) -> IRQ 185
> ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 18
> (level, low) -> IRQ 177
> ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20
> (level, low) -> IRQ 193
> ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20
> (level, low) -> IRQ 193
> ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21
> (level, low) -> IRQ 201
> ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21
> (level, low) -> IRQ 201
> ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21
> (level, low) -> IRQ 201
> ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21
> (level, low) -> IRQ 201
> ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21
> (level, low) -> IRQ 201
> ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22
> (level, low) -> IRQ 209
> ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16
> (level, low) -> IRQ 169
> agpgart: Detected AGP bridge 0
> agpgart: Maximum main memory to use for agp memory:
> 941M
> agpgart: AGP aperture is 64M @ 0xf8000000
> PCI-DMA: Disabling IOMMU.
> IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24
> 13:02:28 ak Exp $
> audit: initializing netlink socket (disabled)
> audit(1098802611.202:0): initialized
> Total HugeTLB memory allocated, 0
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 512 (order 0, 4096
> bytes)
> NTFS driver 2.1.20 [Flags: R/W].
> SELinux:  Registering netfilter hooks
> Initializing Cryptographic API
> ksign: Installing public key data
> Loading keyring
> - Added public key E678DFAC3562A82
>   - key was been created 21251 seconds in future
> - User ID: Red Hat, Inc. (Kernel Module GPG key)
> PCI: Via IRQ fixup for 0000:00:10.0, from 11 to 9
> PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 9
> PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 9
> PCI: Via IRQ fixup for 0000:00:10.3, from 10 to 9
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> vesafb: probe of vesafb0 failed with error -6
> ACPI: Processor [CPU1] (supports C1)
> Real Time Clock Driver v1.12
> Linux agpgart interface v0.100 (c) Dave Jones
> serio: i8042 AUX port at 0x60,0x64 irq 12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports,
> IRQ sharing enabled
> ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
> ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> RAMDISK driver initialized: 16 RAM disks of 16384K
> size 1024 blocksize
> divert: not allocating divert_blk for non-ethernet
> device lo
> Uniform Multi-Platform E-IDE driver Revision:
> 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes;
> override with idebus=xx
> VP_IDE: IDE controller at PCI slot 0000:00:0f.1
> ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20
> (level, low) -> IRQ 193
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller
> on pci0000:00:0f.1
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings:
> hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings:
> hdc:DMA, hdd:DMA
> Probing IDE interface ide0...
> hda: Maxtor 6Y080P0, ATA DISK drive
> hdb: WDC WD300BB-32AUA1, ATA DISK drive
> Using cfq io scheduler
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> Probing IDE interface ide1...
> hdc: JLMS XJ-HD166S, ATAPI CD/DVD-ROM drive
> hdd: _NEC DVD_RW ND-2500A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> Probing IDE interface ide2...
> ide2: Wait for ready failed before probe !
> Probing IDE interface ide3...
> ide3: Wait for ready failed before probe !
> Probing IDE interface ide4...
> ide4: Wait for ready failed before probe !
> Probing IDE interface ide5...
> ide5: Wait for ready failed before probe !
> hda: max request size: 128KiB
> hda: 160086528 sectors (81964 MB) w/7936KiB Cache,
> CHS=65535/16/63, UDMA(133)
> hda: cache flushes supported
>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
> hdb: max request size: 128KiB
> hdb: 58633344 sectors (30020 MB) w/2048KiB Cache,
> CHS=58168/16/63, UDMA(100)
> hdb: cache flushes not supported
>  hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 >
> hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.20
> hdd: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB
> Cache, UDMA(33)
> ide-floppy driver 0.99.newide
> usbcore: registered new driver hiddev
> usbcore: registered new driver usbhid
> drivers/usb/input/hid-core.c: v2.0:USB HID core
> driver
> mice: PS/2 mouse device common for all mice
> input: AT Translated Set 2 keyboard on
> isa0060/serio0
> input: ImExPS/2 Logitech Explorer Mouse on
> isa0060/serio1
> md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
> NET: Registered protocol family 2
> IP: routing cache hash table of 1024 buckets,
> 56Kbytes
> TCP: Hash tables configured (established 262144 bind
> 37449)
> Initializing IPsec netlink socket
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> powernow-k8: Found 1 AMD Athlon 64 / Opteron
> processors (version 1.00.09b)
> powernow-k8: BIOS error - no PSB
> ACPI: (supports S0 S1 S3 S4 S5)
> ACPI wakeup devices: 
> PCI0 PS2K PS2M UAR2 UAR1 AC97 USB1 USB2 USB3 USB4
> EHCI PWRB SLPB 
> Freeing unused kernel memory: 164k freed
> SCSI subsystem initialized
> libata version 1.02 loaded.
> sata_via version 0.20
> ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 20
> (level, low) -> IRQ 193
> sata_via(0000:00:0f.0): routed to hard irq line 10
> ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma
> 0xD400 irq 193
> ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xD802 bmdma
> 0xD408 irq 193
> ata1: no device found (phy stat 00000000)
> scsi0 : sata_via
> ata2: no device found (phy stat 00000000)
> scsi1 : sata_via
> sata_promise version 1.00
> ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 18
> (level, low) -> IRQ 177
> sata_promise PATA port found
> ata3: PATA max UDMA/133 cmd 0xFFFFFF0000004200 ctl
> 0xFFFFFF0000004238 bmdma 0x0 irq 177
> ata4: PATA max UDMA/133 cmd 0xFFFFFF0000004280 ctl
> 0xFFFFFF00000042B8 bmdma 0x0 irq 177
> ata5: PATA max UDMA/133 cmd 0xFFFFFF0000004300 ctl
> 0xFFFFFF0000004338 bmdma 0x0 irq 177
> ATA: abnormal status 0x7F on port 0xFFFFFF000000421C
> scsi2 : sata_promise
> ATA: abnormal status 0x7F on port 0xFFFFFF000000429C
> scsi3 : sata_promise
> ata5: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003
> 85:3469 86:3c01 87:4003 88:203f
> ata5: dev 0 ATA, max UDMA/100, 312581808 sectors:
> lba48
> ata5: dev 0 configured for UDMA/100
> scsi4 : sata_promise
>   Vendor: ATA       Model: WDC WD1600JB-00E  Rev:
> 15.0
>   Type:   Direct-Access                      ANSI
> SCSI revision: 05
> SCSI device sda: 312581808 512-byte hdwr sectors
> (160042 MB)
> SCSI device sda: drive cache: write back
>  sda: sda1 sda2
> Attached scsi disk sda at scsi4, channel 0, id 0,
> lun 0
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> SELinux:  Disabled at runtime.
> SELinux:  Unregistering netfilter hooks
> inserting floppy driver for 2.6.9-1.643.pata
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17
> (level, low) -> IRQ 185
> ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 17
> (level, low) -> IRQ 185
> divert: allocating divert_blk for eth0
> sk98lin: Asus mainboard with buggy VPD? Correcting
> data.
> eth0: Yukon Gigabit Ethernet 10/100/1000Base-T
> Adapter
>       PrefPort:A  RlmtMode:Check Link State
> ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 22
> (level, low) -> IRQ 209
> PCI: Setting latency timer of device 0000:00:11.5 to
> 64
> codec_read: codec 0 is not valid [0xfe0000]
> codec_read: codec 0 is not valid [0xfe0000]
> codec_read: codec 0 is not valid [0xfe0000]
> codec_read: codec 0 is not valid [0xfe0000]
> Linux video capture interface: v1.00
> cx2388x v4l2 driver version 0.0.4 loaded
> ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 18
> (level, low) -> IRQ 177
> cx8800[0]: found at 0000:00:0d.0, rev: 5, irq: 177,
> latency: 64, mmio: 0xf6000000
> cx8800[0]: subsystem: 107d:6613, board: Leadtek
> Winfast 2000XP Expert [card=5,autodetected]
> cx8800[0]: i2c register ok
> cx8800[0]: Leadtek Winfast 2000 XP config: tuner=43,
> eeprom[0]=0x01
> tuner: Ignoring new-style parameters in presence of
> obsolete ones
> tuner: chip found at addr 0xc0 i2c-bus cx8800[0]
> tuner: type set to 43 (Philips NTSC MK3 (FM1236MK3
> or FM1236/F)) by cx8800[0]
> cx8800[0]: i2c attach [client=Philips NTSC MK3
> (FM1236MK3 or FM1236/F)]
> tda9887: Ignoring new-style parameters in presence
> of obsolete ones
> tda9885/6/7: chip found @ 0x86
> cx8800[0]: i2c attach [client=tda9887]
> cx8800[0]: registered device video0 [v4l2]
> cx8800[0]: registered device vbi0
> cx8800[0]: registered device radio0
> cx8800[0]: set_audio_standard_BTSC (status:
> known-good)
> cx8800[0]: cx88: tvaudio thread started
> ACPI: PCI interrupt 0000:00:10.4[C] -> GSI 21
> (level, low) -> IRQ 201
> ehci_hcd 0000:00:10.4: EHCI Host Controller
> ehci_hcd 0000:00:10.4: irq 201, pci mem
> ffffff0000006000
> ehci_hcd 0000:00:10.4: new USB bus registered,
> assigned bus number 1
> ehci_hcd 0000:00:10.4: USB 2.0 enabled, EHCI 1.00,
> driver 2004-May-10
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 8 ports detected
> USB Universal Host Controller Interface driver v2.2
> ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 21
> (level, low) -> IRQ 201
> uhci_hcd 0000:00:10.0: UHCI Host Controller
> uhci_hcd 0000:00:10.0: irq 201, io base
> 000000000000b400
> uhci_hcd 0000:00:10.0: new USB bus registered,
> assigned bus number 2
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 2 ports detected
> ACPI: PCI interrupt 0000:00:10.1[A] -> GSI 21
> (level, low) -> IRQ 201
> uhci_hcd 0000:00:10.1: UHCI Host Controller
> uhci_hcd 0000:00:10.1: irq 201, io base
> 000000000000b800
> uhci_hcd 0000:00:10.1: new USB bus registered,
> assigned bus number 3
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> ACPI: PCI interrupt 0000:00:10.2[B] -> GSI 21
> (level, low) -> IRQ 201
> uhci_hcd 0000:00:10.2: UHCI Host Controller
> uhci_hcd 0000:00:10.2: irq 201, io base
> 000000000000c000
> uhci_hcd 0000:00:10.2: new USB bus registered,
> assigned bus number 4
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> ACPI: PCI interrupt 0000:00:10.3[B] -> GSI 21
> (level, low) -> IRQ 201
> uhci_hcd 0000:00:10.3: UHCI Host Controller
> uhci_hcd 0000:00:10.3: irq 201, io base
> 000000000000c400
> uhci_hcd 0000:00:10.3: new USB bus registered,
> assigned bus number 5
> hub 5-0:1.0: USB hub found
> hub 5-0:1.0: 2 ports detected
> ohci1394: $Rev: 1223 $ Ben Collins
> <bcollins@debian.org>
> ACPI: PCI interrupt 0000:00:07.0[A] -> GSI 16
> (level, low) -> IRQ 169
> ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[169] 
> MMIO=[f7a00000-f7a007ff]  Max Packet=[2048]
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> cx8800[0]: AUD_STATUS: 0xf632 [mono/no pilot]
> ctl=BTSC_AUTO_STEREO
> ieee1394: Host added: ID:BUS[0-00:1023] 
> GUID[00e018000055ac35]
> ACPI: Power Button (FF) [PWRF]
> ACPI: Sleep Button (CM) [SLPB]
> EXT3 FS on hdb7, internal journal
> device-mapper: 4.1.0-ioctl (2003-12-10) initialised:
> dm@uk.sistina.com
> cdrom: open failed.
> cdrom: open failed.
> cx8800[0]: AUD_STATUS: 0xf3f2 [mono/no pilot]
> ctl=BTSC_AUTO_STEREO
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda6, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> kjournald starting.  Commit interval 5 seconds
> EXT3 FS on hda1, internal journal
> EXT3-fs: mounted filesystem with ordered data mode.
> Adding 1718912k swap on /dev/hdb6.  Priority:-1
> extents:1
> Adding 2008116k swap on /dev/hda3.  Priority:-2
> extents:1
>  
