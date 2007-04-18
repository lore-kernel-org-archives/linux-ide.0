From: Roger While <simrw@sim-basis.de>
Subject: Re: libata/SATA noprobe
Date: Wed, 18 Apr 2007 20:44:24 +0200
Message-ID: <6.1.1.1.2.20070418202757.02c2adf0@192.168.6.12>
References: <6.1.1.1.2.20070418164107.02c87a30@192.168.6.12>
 <462645F6.50702@rtr.ca>
 <46264749.7080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout09.sul.t-online.com ([194.25.134.84]:59205 "EHLO
	mailout09.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S2993013AbXDRSpN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 14:45:13 -0400
In-Reply-To: <46264749.7080206@gmail.com>
References: <6.1.1.1.2.20070418164107.02c87a30@192.168.6.12>
 <462645F6.50702@rtr.ca>
 <46264749.7080206@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@redhat.com>, liml@rtr.ca, Tejun Heo <htejun@gmail.com>

This is Opensuse 10.2, complete boot.msg below
(to level 5) -

I had a similar problem with an old ASUS DLS board where
I needed to do :
hda=noprobe hdb=noprobe hdc=noprobe hdd=noprobe
to stop an inacceptible boot time. (SCSI only config)
Therefor the sibject, that we had for ide the param.

It seems to me that we want something like ata2=noprobe

Yes, I can give current kernels a shot given some
time for this.

Whatever is decided here needs to be backported.

Roger


Inspecting /boot/System.map-2.6.18.2-34-default
Loaded 23895 symbols from /boot/System.map-2.6.18.2-34-default.
Symbols match kernel version 2.6.18.
No module symbols loaded - kernel modules not enabled.

klogd 1.4.1, log source = ksyslog started.
<4>Bootdata ok (command line is root=/dev/sda2 vga=normal resume=/dev/sda1 
splash=0 elevator=deadline)
<5>Linux version 2.6.18.2-34-default (geeko@buildhost) (gcc version 4.1.2 
20061115 (prerelease) (SUSE Linux)) #1 SMP Mon Nov 27 11:46:27 UTC 2006
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000007f686c00 (usable)
<4> BIOS-e820: 000000007f686c00 - 000000007f688c00 (ACPI NVS)
<4> BIOS-e820: 000000007f688c00 - 000000007f68ac00 (ACPI data)
<4> BIOS-e820: 000000007f68ac00 - 0000000080000000 (reserved)
<4> BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
<4> BIOS-e820: 00000000fec00000 - 00000000fed00400 (reserved)
<4> BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fef00000 (reserved)
<4> BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
<6>DMI 2.3 present.
<7>ACPI: RSDP (v000 DELL                                  ) @ 
0x00000000000fec00
<7>ACPI: RSDT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 
0x00000000000fcbdf
<7>ACPI: FADT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 
0x00000000000fcc1f
<7>ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 
0x00000000fffd4cf1
<7>ACPI: MADT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 
0x00000000000fcc93
<7>ACPI: BOOT (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 
0x00000000000fcd25
<7>ACPI: ASF! (v016 DELL    GX280   0x00000007 ASL  0x00000061) @ 
0x00000000000fcd4d
<7>ACPI: MCFG (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 
0x00000000000fcdb4
<7>ACPI: HPET (v001 DELL    GX280   0x00000007 ASL  0x00000061) @ 
0x00000000000fcdf2
<7>ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 
0x0000000000000000
<6>No NUMA configuration found
<6>Faking a node at 0000000000000000-000000007f686000
<6>Bootmem setup node 0 0000000000000000-000000007f686000
<7>On node 0 totalpages: 513582
<7>  DMA zone: 2894 pages, LIFO batch:0
<7>  DMA32 zone: 510688 pages, LIFO batch:31
<6>ACPI: PM-Timer IO Port: 0x808
<7>ACPI: Local APIC address 0xfee00000
<6>ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
<6>Processor #0 15:4 APIC version 20
<6>ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
<6>Processor #1 15:4 APIC version 20
<6>ACPI: LAPIC (acpi_id[0x03] lapic_id[0x06] disabled)
<6>ACPI: LAPIC (acpi_id[0x04] lapic_id[0x02] disabled)
<6>ACPI: LAPIC (acpi_id[0x05] lapic_id[0x04] disabled)
<6>ACPI: LAPIC (acpi_id[0x06] lapic_id[0x07] disabled)
<6>ACPI: LAPIC (acpi_id[0x07] lapic_id[0x03] disabled)
<6>ACPI: LAPIC (acpi_id[0x08] lapic_id[0x05] disabled)
<6>ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
<6>ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
<6>IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
<6>ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
<7>ACPI: IRQ0 used by override.
<7>ACPI: IRQ2 used by override.
<7>ACPI: IRQ9 used by override.
<6>Setting APIC routing to physical flat
<6>ACPI: HPET id: 0x8086a201 base: 0xfed00000
<6>Using ACPI (MADT) for SMP configuration information
<6>Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
<6>SMP: Allowing 8 CPUs, 6 hotplug CPUs
<4>Built 1 zonelists.  Total pages: 513582
<5>Kernel command line: root=/dev/sda2 vga=normal resume=/dev/sda1 splash=0 
elevator=deadline
<4>Initializing CPU#0
<4>PID hash table entries: 4096 (order: 12, 32768 bytes)
<6>time.c: Using 14.318180 MHz WALL HPET GTOD HPET/TSC timer.
<6>time.c: Detected 3391.745 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
<4>Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
<4>Checking aperture...
<4>Memory: 2047388k/2087448k available (1915k kernel code, 39676k reserved, 
1278k data, 188k init)
<4>Calibrating delay using timer specific routine.. 6789.92 BogoMIPS 
(lpj=13579854)
<6>Security Framework v1.0.0 initialized
<4>Mount-cache hash table entries: 256
<6>CPU: Trace cache: 12K uops, L1 D cache: 16K
<6>CPU: L2 cache: 2048K
<4>using mwait in idle threads.
<6>CPU: Physical Processor ID: 0
<6>CPU: Processor Core ID: 0
<6>CPU0: Thermal monitoring enabled (TM1)
<6>SMP alternatives: switching to UP code
<6>checking if image is initramfs... it is
<6>Freeing initrd memory: 3422k freed
<6>ACPI: Core revision 20060707
<6>Using local APIC timer interrupts.
<4>result 12469572
<6>Detected 12.469 MHz APIC timer.
<6>SMP alternatives: switching to SMP code
<6>Booting processor 1/2 APIC 0x1
<4>Initializing CPU#1
<4>Calibrating delay using timer specific routine.. 6783.26 BogoMIPS 
(lpj=13566537)
<6>CPU: Trace cache: 12K uops, L1 D cache: 16K
<6>CPU: L2 cache: 2048K
<6>CPU: Physical Processor ID: 0
<6>CPU: Processor Core ID: 0
<6>CPU1: Thermal monitoring enabled (TM1)
<4>              Intel(R) Pentium(R) 4 CPU 3.40GHz stepping 0a
<6>Brought up 2 CPUs
<6>testing NMI watchdog ... OK.
<4>migration_cost=13
<6>NET: Registered protocol family 16
<6>ACPI: bus type pci registered
<6>PCI: Using MMCONFIG at e0000000
<6>ACPI: Interpreter enabled
<6>ACPI: Using IOAPIC for interrupt routing
<6>ACPI: PCI Root Bridge [PCI0] (0000:00)
<7>PCI: Probing PCI hardware (bus 00)
<6>ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
<7>Boot video device is 0000:00:02.0
<4>PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
<4>PCI quirk: region 0880-08bf claimed by ICH6 GPIO
<6>PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
<6>PCI: Transparent bridge - 0000:00:1e.0
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI2._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI3._PRT]
<7>ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI4._PRT]
<4>ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 15)
<4>ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKC] (IRQs 3 *4 5 6 7 9 10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 15) *0, disabled.
<4>ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 *10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 *5 6 7 9 10 11 12 15)
<4>ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 9 10 11 12 15)
<6>PCI: Using ACPI for IRQ routing
<6>PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
<6>hpet0: at MMIO 0xfed00000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
<6>hpet0: 3 64-bit timers, 14318180 Hz
<6>PCI-GART: No AMD northbridge found.
<4>PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
<6>PCI: Bridge: 0000:00:01.0
<6>  IO window: disabled.
<6>  MEM window: dfd00000-dfdfffff
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:00:1c.0
<6>  IO window: disabled.
<6>  MEM window: dfc00000-dfcfffff
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:00:1c.1
<6>  IO window: disabled.
<6>  MEM window: dfb00000-dfbfffff
<6>  PREFETCH window: disabled.
<6>PCI: Bridge: 0000:00:1e.0
<6>  IO window: disabled.
<6>  MEM window: disabled.
<6>  PREFETCH window: disabled.
<6>GSI 16 sharing vector 0xA9 and IRQ 16
<6>ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
<7>PCI: Setting latency timer of device 0000:00:01.0 to 64
<6>ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<6>GSI 17 sharing vector 0xB1 and IRQ 17
<6>ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
<7>PCI: Setting latency timer of device 0000:00:1c.1 to 64
<7>PCI: Setting latency timer of device 0000:00:1e.0 to 64
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
<4>TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
<4>TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
<6>TCP: Hash tables configured (established 262144 bind 65536)
<6>TCP reno registered
<6>Simple Boot Flag at 0x7a set to 0x1
<6>audit: initializing netlink socket (disabled)
<5>audit(1176905386.476:1): initialized
<4>Total HugeTLB memory allocated, 0
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered (default)
<6>io scheduler cfq registered
<7>PCI: Setting latency timer of device 0000:00:01.0 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:01.0:pcie00]
<7>Allocate Port Service[0000:00:01.0:pcie03]
<7>PCI: Setting latency timer of device 0000:00:1c.0 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.0:pcie00]
<7>Allocate Port Service[0000:00:1c.0:pcie02]
<7>Allocate Port Service[0000:00:1c.0:pcie03]
<7>PCI: Setting latency timer of device 0000:00:1c.1 to 64
<4>assign_interrupt_mode Found MSI capability
<7>Allocate Port Service[0000:00:1c.1:pcie00]
<7>Allocate Port Service[0000:00:1c.1:pcie03]
<6>Real Time Clock Driver v1.12ac
<7>hpet_resources: 0xfed00000 is busy
<6>Non-volatile memory driver v1.2
<6>Linux agpgart interface v0.101 (c) Dave Jones
<6>Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
<4>RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
<6>serio: i8042 AUX port at 0x60,0x64 irq 12
<6>serio: i8042 KBD port at 0x60,0x64 irq 1
<6>mice: PS/2 mouse device common for all mice
<6>input: PC Speaker as /class/input/input0
<6>md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: bitmap version 4.39
<6>NET: Registered protocol family 1
<6>ACPI: (supports S0 S1 S3 S4 S5)
<6>Freeing unused kernel memory: 188k freed
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<5>SCSI subsystem initialized
<6>ICH6: IDE controller at PCI slot 0000:00:1f.1
<6>ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 16 (level, low) -> IRQ 169
<6>ICH6: chipset revision 3
<6>ICH6: not 100% native mode: will probe irqs later
<6>    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
<7>Probing IDE interface ide0...
<4>hda: PHILIPS SPD2411P, ATAPI CD/DVD-ROM drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<7>libata version 2.00 loaded.
<7>ata_piix 0000:00:1f.2: version 2.00ac7
<6>ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
<6>GSI 18 sharing vector 0xD9 and IRQ 18
<6>ACPI: PCI Interrupt 0000:00:1f.2[C] -> GSI 20 (level, low) -> IRQ 217
<7>PCI: Setting latency timer of device 0000:00:1f.2 to 64
<6>ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 217
<6>ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 217
<6>scsi0 : ata_piix
<6>ata1.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth 0/1)
<6>ata1.00: ata1: dev 0 multi count 8
<6>ata1.00: configured for UDMA/133
<6>scsi1 : ata_piix
<4>ata2: port is slow to respond, please be patient (Status 0xff)
<3>ata2: port failed to respond (30 secs, Status 0xff)
<3>ata2: SRST failed (status 0xFF)
<3>ata2: SRST failed (err_mask=0x100)
<4>ata2: softreset failed, retrying in 5 secs
<3>ata2: SRST failed (status 0xFF)
<3>ata2: SRST failed (err_mask=0x100)
<4>ata2: softreset failed, retrying in 5 secs
<3>ata2: SRST failed (status 0xFF)
<3>ata2: SRST failed (err_mask=0x100)
<3>ata2: reset failed, giving up
<5>  Vendor: ATA       Model: WDC WD2500YD-01N  Rev: 10.0
<5>  Type:   Direct-Access                      ANSI SCSI revision: 05
<5>SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
<5>sda: Write Protect is off
<7>sda: Mode Sense: 00 3a 00 00
<5>SCSI device sda: drive cache: write back
<5>SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
<5>sda: Write Protect is off
<7>sda: Mode Sense: 00 3a 00 00
<5>SCSI device sda: drive cache: write back
<6> sda: sda1 sda2
<5>sd 0:0:0:0: Attached scsi disk sda
<6>BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
<5>sd 0:0:0:0: Attached scsi generic sg0 type 0
<4>Attempting manual resume
<5>ReiserFS: sda2: found reiserfs format "3.6" with standard journal
<5>ReiserFS: sda2: using ordered data mode
<4>reiserfs: using flush barriers
<5>ReiserFS: sda2: journal params: device sda2, size 8192, journal first 
block 18, max trans len 1024, max batch 900, max commit age 30, max trans 
age 30
<5>ReiserFS: sda2: checking transaction log (sda2)
<5>ReiserFS: sda2: Using r5 hash to sort names
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<3>intel_rng: FWH not detected
<6>USB Universal Host Controller Interface driver v3.0
<6>GSI 19 sharing vector 0xE1 and IRQ 19
<6>ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 21 (level, low) -> IRQ 225
<7>PCI: Setting latency timer of device 0000:00:1d.0 to 64
<6>uhci_hcd 0000:00:1d.0: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
<6>uhci_hcd 0000:00:1d.0: irq 225, io base 0x0000ff80
<6>usb usb1: new device found, idVendor=0000, idProduct=0000
<6>usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb1: Product: UHCI Host Controller
<6>usb usb1: Manufacturer: Linux 2.6.18.2-34-default uhci_hcd
<6>usb usb1: SerialNumber: 0000:00:1d.0
<6>usb usb1: configuration #1 chosen from 1 choice
<6>hub 1-0:1.0: USB hub found
<6>hub 1-0:1.0: 2 ports detected
<6>GSI 20 sharing vector 0xE9 and IRQ 20
<6>ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 233
<7>PCI: Setting latency timer of device 0000:00:1d.1 to 64
<6>uhci_hcd 0000:00:1d.1: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
<6>uhci_hcd 0000:00:1d.1: irq 233, io base 0x0000ff60
<6>usb usb2: new device found, idVendor=0000, idProduct=0000
<6>usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb2: Product: UHCI Host Controller
<6>usb usb2: Manufacturer: Linux 2.6.18.2-34-default uhci_hcd
<6>usb usb2: SerialNumber: 0000:00:1d.1
<6>usb usb2: configuration #1 chosen from 1 choice
<6>hub 2-0:1.0: USB hub found
<6>hub 2-0:1.0: 2 ports detected
<6>GSI 21 sharing vector 0x32 and IRQ 21
<6>ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 50
<7>PCI: Setting latency timer of device 0000:00:1d.2 to 64
<6>uhci_hcd 0000:00:1d.2: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
<6>uhci_hcd 0000:00:1d.2: irq 50, io base 0x0000ff40
<6>usb usb3: new device found, idVendor=0000, idProduct=0000
<6>usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb3: Product: UHCI Host Controller
<6>usb usb3: Manufacturer: Linux 2.6.18.2-34-default uhci_hcd
<6>usb usb3: SerialNumber: 0000:00:1d.2
<6>usb usb3: configuration #1 chosen from 1 choice
<6>hub 3-0:1.0: USB hub found
<6>hub 3-0:1.0: 2 ports detected
<6>hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
<6>Uniform CD-ROM driver Revision: 3.20
<6>GSI 22 sharing vector 0x3A and IRQ 22
<6>ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 23 (level, low) -> IRQ 58
<7>PCI: Setting latency timer of device 0000:00:1d.3 to 64
<6>uhci_hcd 0000:00:1d.3: UHCI Host Controller
<6>uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
<6>uhci_hcd 0000:00:1d.3: irq 58, io base 0x0000ff20
<6>usb usb4: new device found, idVendor=0000, idProduct=0000
<6>usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb4: Product: UHCI Host Controller
<6>usb usb4: Manufacturer: Linux 2.6.18.2-34-default uhci_hcd
<6>usb usb4: SerialNumber: 0000:00:1d.3
<6>usb usb4: configuration #1 chosen from 1 choice
<6>hub 4-0:1.0: USB hub found
<6>hub 4-0:1.0: 2 ports detected
<6>agpgart: Detected an Intel 915G Chipset.
<6>agpgart: Detected 7932K stolen memory.
<6>agpgart: AGP aperture is 256M @ 0xc0000000
<6>ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 21 (level, low) -> IRQ 225
<7>PCI: Setting latency timer of device 0000:00:1d.7 to 64
<6>ehci_hcd 0000:00:1d.7: EHCI Host Controller
<6>ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
<6>ehci_hcd 0000:00:1d.7: debug port 1
<7>PCI: cache line size of 128 is not supported by device 0000:00:1d.7
<6>ehci_hcd 0000:00:1d.7: irq 225, io mem 0xffa80800
<6>ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
<6>usb usb5: new device found, idVendor=0000, idProduct=0000
<6>usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
<6>usb usb5: Product: EHCI Host Controller
<6>usb usb5: Manufacturer: Linux 2.6.18.2-34-default ehci_hcd
<6>usb usb5: SerialNumber: 0000:00:1d.7
<6>usb usb5: configuration #1 chosen from 1 choice
<6>hub 5-0:1.0: USB hub found
<6>hub 5-0:1.0: 8 ports detected
<6>usb 2-1: new low speed USB device using uhci_hcd and address 2
<6>ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 17 (level, low) -> IRQ 177
<6>ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 23 (level, low) -> IRQ 58
<7>PCI: Setting latency timer of device 0000:00:1e.2 to 64
<6>intel8x0_measure_ac97_clock: measured 54316 usecs
<6>intel8x0: clocking to 48000
<6>tg3.c:v3.65 (August 07, 2006)
<6>ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
<7>PCI: Setting latency timer of device 0000:02:00.0 to 64
<6>eth0: Tigon3 [partno(BCM95751) rev 4001 PHY(5750)] (PCI Express) 
10/100/1000BaseT Ethernet 00:12:3f:2c:76:73
<6>eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] 
TSOcap[1]
<6>eth0: dma_rwctrl[76180000] dma_mask[64-bit]
<6>usb 2-1: new low speed USB device using uhci_hcd and address 3
<6>usb 2-1: new device found, idVendor=045e, idProduct=0040
<6>usb 2-1: new device strings: Mfr=1, Product=3, SerialNumber=0
<6>usb 2-1: Product: Microsoft 3-Button Mouse with IntelliEye(TM)
<6>usb 2-1: Manufacturer: Microsoft
<6>usb 2-1: configuration #1 chosen from 1 choice
<6>Adding 1534168k swap on /dev/sda1.  Priority:-1 extents:1 across:1534168k
<6>usb 2-2: new low speed USB device using uhci_hcd and address 4
<6>usb 2-2: new device found, idVendor=046d, idProduct=c313
<6>usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=0
<6>usb 2-2: Product: USB Multimedia Keyboard
<6>usb 2-2: Manufacturer: BTC
<6>usb 2-2: configuration #1 chosen from 1 choice
<6>usbcore: registered new driver hiddev
<6>input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as 
/class/input/input1
<6>input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with 
IntelliEye(TM)] on usb-0000:00:1d.1-1
<6>input: BTC USB Multimedia Keyboard as /class/input/input2
<6>input: USB HID v1.10 Keyboard [BTC USB Multimedia Keyboard] on 
usb-0000:00:1d.1-2
<6>input: BTC USB Multimedia Keyboard as /class/input/input3
<6>input,hiddev96: USB HID v1.10 Device [BTC USB Multimedia Keyboard] on 
usb-0000:00:1d.1-2
<6>usbcore: registered new driver usbhid
<6>drivers/usb/input/hid-core.c: v2.6:USB HID core driver
<6>device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: 
dm-devel@redhat.com
<6>loop: loaded (max 8 devices)
<6>AppArmor: AppArmor initialized
<5>audit(1176905450.556:2): AppArmor initialized
<4>
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.

Boot logging started on /dev/tty1(/dev/console) at Wed Apr 18 14:09:46 2007

Trying manual resume from /dev/sda1
Creating device nodes with udev
Loading ide-core
Loading ide-disk
Loading scsi_mod
Loading sd_mod
Loading processor
Loading thermal
Loading piix
Loading libata
Loading ata_piix
Loading fan
Loading edd
Loading reiserfs
Invoking userspace resume from /dev/sda1
resume: Could not stat configuration file
resume: libgcrypt version: 1.2.3
resume: Could not read the image
Invoking in-kernel resume from /dev/sda1
Waiting for device /dev/sda2 to appear:  ok
fsck 1.39 (29-May-2006)
[/bin/fsck.reiserfs (1) -- /] fsck.reiserfs -a /dev/sda2
Reiserfs super block in block 16 on 0x802 of format 3.6 with standard journal
Blocks (total/free): 60894368/59458229 by 4096 bytes
Filesystem is clean
Replaying journal..
Reiserfs journal '/dev/sda2' in blocks [18..8211]: 0 transactions replayed
Checking internal tree..finished
fsck succeeded. Mounting root device read-write.
Mounting root /dev/sda2


>Mark Lord wrote:
> > Roger While wrote:
> >> Is there any knob/option to prevent libata
> >> probing non-existent channels ?
> >> Specifically how can I stop the kernel probing
> >> the second SATA? -
> > ..
> >> <6>ata1.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth 0/1)
> >> <6>ata1.00: ata1: dev 0 multi count 8
> >> <6>ata1.00: configured for UDMA/133
> >> <6>scsi1 : ata_piix
> >> <4>ata2: port is slow to respond, please be patient (Status 0xff)
> >> <3>ata2: port failed to respond (30 secs, Status 0xff)
> >> <3>ata2: SRST failed (status 0xFF)
> >> <3>ata2: SRST failed (err_mask=0x100)
> >> <4>ata2: softreset failed, retrying in 5 secs
> >> <3>ata2: SRST failed (status 0xFF)
> >> <3>ata2: SRST failed (err_mask=0x100)
> >> <4>ata2: softreset failed, retrying in 5 secs
> >> <3>ata2: SRST failed (status 0xFF)
> >> <3>ata2: SRST failed (err_mask=0x100)
> >> <3>ata2: reset failed, giving up
> > ..
> >
> > Ugh.  That could really slow down system startup.
> >
> > There is no parameter to avoid it,
> > just one to reduce the delay while it probes.  Not ideal.
> >
> > But it really could be more clever here, and notice the 0xff patterns,
> > and have an early exit if there's obviously nothing attached.
> >
> > Or perhaps there's some register it could read to see if the
> > port was disabled in the BIOS (I'm betting it is still "enabled",
> > but it could be good to check if we don't already).
> >
> > Maybe just do it in the ata_piix subdriver.  Tejun, Alan?
>
>We do consider 0xff as port empty these days.  Roger, which kernel
>version are you using?  Can you give a shot at 2.6.20.7?
>
>--
>tejun


