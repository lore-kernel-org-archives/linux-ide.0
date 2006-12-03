From: Wayne Sherman <Wayne@SystemDesignWorks.com>
Subject: Re: AHCI support on Intel chipsets (confusion?)
Date: Sun, 03 Dec 2006 11:39:32 -0800
Message-ID: <457327F4.9040403@SystemDesignWorks.com>
References: <45715381.80206@SystemDesignWorks.com> <4572D27B.3000909@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010508010206030309030902"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ev1s-69-57-152-63.ev1servers.net ([69.57.152.63]:15301 "EHLO
	server.monsterhosting.org") by vger.kernel.org with ESMTP
	id S1760037AbWLCTjg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 14:39:36 -0500
In-Reply-To: <4572D27B.3000909@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010508010206030309030902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tejun,

Please see attached files.  The SATA chipset is identified as 0x8086 : 
0x27c0.  My _plain_ ICH7 is reported as:

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) 
Serial ATA Storage Controllers cc=IDE (rev 01) (prog-if 8f [Master SecP 
SecO PriP PriO])
	Subsystem: Giga-byte Technology Unknown device b002
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 177
	I/O ports at d400 [size=8]
	I/O ports at d800 [size=4]
	I/O ports at dc00 [size=8]
	I/O ports at e000 [size=4]
	I/O ports at e400 [size=16]
	Capabilities: [70] Power Management version 2

The kernel source indicates both 0x27c0 (in ata_piix.c) and 0x27c1 (in 
ahci.c) are both ICH7.  The identifier naming also indicates that both 
do AHCI.  I don't think this is correct.

According the Intel's Specification Update for the ICH7 family:
(http://www.intel.com/design/chipsets/datashts/307013.htm - 30701417.pdf 
pg 11 is interesting for id purposes, but pg 22 contains the DIDs.)

	0x27c0 is Desktop Non-AHCI and Non-RAID Mode
	0x27c1 is Desktop AHCI Mode

Also Intel states:
	ICH7MDH - RAID only
	ICH7M - AHCI only
	ICH7R - RAID and AHCI
	ICH7DH - RAID and AHCI
	ICH7 - NO RAID, NO AHCI

( from http://www.intel.com/support/chipsets/imst/sb/CS-012304.htm )
(The main datasheet 30701302.pdf provides same info on pg 52)

The docs indicate that the Device IDs can change.  They represent the 
mode, not specifically the device.  But when we compare these sources we 
can conclude:

  - 0x27c0 is an ICH7 or, an ICH7DH or ICH7R (in non-AHCI/RAID mode)
  - 0x27c1 is not an ICH7 (Base)
  - 0x27c1 is an ICH7DH or ICH7R in AHCI mode

I would like to submit that the code comments in ahci.c be modified:

   { PCI_VDEVICE(INTEL, 0x27c1), board_ahci }, /* ICH7DH/ICH7R */

and in ata_piix.c:

/* 82801GB/GR/GH (ICH7/DH/R non-AHCI/non-RAID Mode, identical to ICH6)*/
   { 0x8086, 0x27c0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich6_sata_ahci },

Since 0x27c0 is *NOT* AHCI compatible, it seems to me that the 
driver_data member (ich6_sata_ahci) is incorrect.  What do you think?

Thanks,

Wayne


Tejun Heo wrote:
> Wayne Sherman wrote:
>> So, does the kernel source code incorrectly indicate some of these
>> chipsets are AHCI compatible?
> 
> Not really.  If the controller has PCI ID of 0x27c1, it's an ahci
> controller.  Care to post full dmesg and the result of 'lspci -nn'?
> 

--------------010508010206030309030902
Content-Type: text/plain;
 name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg.txt"

Linux version 2.6.18-1.2239.fc5 (brewbuilder@hs20-bc1-7.build.redhat.com) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 Fri Nov 10 13:04:06 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001fef3000 (ACPI NVS)
 BIOS-e820: 000000001fef3000 - 000000001ff00000 (ACPI data)
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
510MB LOWMEM available.
found SMP MP-table at 000f4e20
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 130800
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126704 pages, LIFO batch:31
DMI 2.3 present.
IO/L-APIC allowed because system is MP or new enough
ACPI: RSDP (v000 GBT                                   ) @ 0x000f6770
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fef3040
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fef30c0
ACPI: MCFG (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fef6c00
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x1fef6b40
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 20000000 (gap: 1ff00000:d0100000)
Detected 2660.213 MHz processor.
Built 1 zonelists.  Total pages: 130800
Kernel command line: ro root=LABEL=/ 3 selinux=0
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c075a000 soft=c0759000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 513296k/523200k available (2040k kernel code, 9356k reserved, 798k data, 220k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5322.87 BogoMIPS (lpj=2661435)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000651d 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000651d 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: bfebf3ff 20100000 00000000 00000180 0000651d 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
CPU0: Thermal monitoring enabled
CPU: Intel(R) Celeron(R) CPU 2.66GHz stepping 09
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 954k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:09: ioport range 0x400-0x4bf could not be reserved
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1e.0
  IO window: a000-afff
  MEM window: e0000000-e1ffffff
  PREFETCH window: 20000000-200fffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1165041279.524:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 481F17AAEB289250
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Processor [CPU0] (supports 2 throttling states)
ACPI: Getting cpuindex for acpiid 0x1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945G Chipset.
agpgart: Detected 764K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 169
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide0...
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S1<6>Time: tsc clocksource has been installed.
 S4 S5)
Freeing unused kernel memory: 220k freed
Write protecting the kernel read-only data: 377k
input: AT Translated Set 2 keyboard as /class/input/input0
SCSI subsystem initialized
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xD400 ctl 0xD802 bmdma 0xE400 irq 177
ata2: SATA max UDMA/133 cmd 0xDC00 ctl 0xE002 bmdma 0xE408 irq 177
scsi0 : ata_piix
ata1.00: ATA-6, max UDMA/133, 78125000 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ata_piix
ata2.00: ATA-7, max UDMA/133, 156247887 sectors: LBA 
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/133
  Vendor: ATA       Model: ST340014AS        Rev: 8.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 78125000 512-byte hdwr sectors (40000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78125000 512-byte hdwr sectors (40000 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: Maxtor 6Y080M0    Rev: YAR5
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 156247887 512-byte hdwr sectors (79999 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 156247887 512-byte hdwr sectors (79999 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1
sd 1:0:0:0: Attached scsi disk sdb
input: PC Speaker as /class/input/input1
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 177
intel_rng: FWH not detected
ACPI: PCI Interrupt 0000:01:01.0[A] -> GSI 19 (level, low) -> IRQ 177
skge 1.6 addr 0xe1000000 irq 177 chip Yukon-Lite rev 9
skge eth0: addr 00:15:e9:bd:28:3d
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 21 (level, low) -> IRQ 185
skge 1.6 addr 0xe1004000 irq 185 chip Yukon-Lite rev 9
skge eth1: addr 00:16:e6:1f:8a:8b
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 193, io base 0x0000b000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 177, io base 0x0000b400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 169, io base 0x0000b800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 201
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 201, io base 0x0000bc00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 193, io mem 0xe20c0000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
floppy0: no floppy controllers found
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (4087 buckets, 32696 max) - 228 bytes per conntrack
skge eth0: enabling interface
skge eth0: Link is up at 100 Mbps, full duplex, flow control tx and rx

--------------010508010206030309030902
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 0600: 8086:2770 (rev 02)
00:02.0 0300: 8086:2772 (rev 02)
00:1d.0 0c03: 8086:27c8 (rev 01)
00:1d.1 0c03: 8086:27c9 (rev 01)
00:1d.2 0c03: 8086:27ca (rev 01)
00:1d.3 0c03: 8086:27cb (rev 01)
00:1d.7 0c03: 8086:27cc (rev 01)
00:1e.0 0604: 8086:244e (rev e1)
00:1f.0 0601: 8086:27b8 (rev 01)
00:1f.1 0101: 8086:27df (rev 01)
00:1f.2 0101: 8086:27c0 (rev 01)
00:1f.3 0c05: 8086:27da (rev 01)
01:01.0 0200: 1186:4b01 (rev 11)
01:05.0 0200: 11ab:4320 (rev 13)

--------------010508010206030309030902
Content-Type: text/plain;
 name="lspci-full.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-full.txt"

00:00.0 Host bridge: Intel Corporation 945G/P Memory Controller Hub (rev 02)
	Subsystem: Giga-byte Technology Unknown device 5000
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation 945G Integrated Graphics Controller (rev 02) (prog-if 00 [VGA])
	Subsystem: Giga-byte Technology Unknown device d000
	Flags: bus master, fast devsel, latency 0, IRQ 12
	Memory at e2000000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at c000 [size=8]
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Memory at e2080000 (32-bit, non-prefetchable) [size=256K]
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable-
	Capabilities: [d0] Power Management version 2

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology Unknown device 5004
	Flags: bus master, medium devsel, latency 0, IRQ 193
	I/O ports at b000 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology Unknown device 5004
	Flags: bus master, medium devsel, latency 0, IRQ 177
	I/O ports at b400 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology Unknown device 5004
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at b800 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology Unknown device 5004
	Flags: bus master, medium devsel, latency 0, IRQ 201
	I/O ports at bc00 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology Unknown device 5006
	Flags: bus master, medium devsel, latency 0, IRQ 193
	Memory at e20c0000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: 0000000020000000-0000000020000000
	Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
	Subsystem: Giga-byte Technology Unknown device 5001
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology Unknown device b001
	Flags: bus master, medium devsel, latency 0, IRQ 169
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at f000 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial ATA Storage Controllers cc=IDE (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Giga-byte Technology Unknown device b002
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 177
	I/O ports at d400 [size=8]
	I/O ports at d800 [size=4]
	I/O ports at dc00 [size=8]
	I/O ports at e000 [size=4]
	I/O ports at e400 [size=16]
	Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
	Subsystem: Giga-byte Technology Unknown device 5001
	Flags: medium devsel, IRQ 177
	I/O ports at 0500 [size=32]

01:01.0 Ethernet controller: D-Link System Inc Unknown device 4b01 (rev 11)
	Subsystem: D-Link System Inc Unknown device 4b01
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 177
	Memory at e1000000 (32-bit, non-prefetchable) [size=16K]
	I/O ports at a000 [size=256]
	[virtual] Expansion ROM at 20000000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data

01:05.0 Ethernet controller: Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 13)
	Subsystem: Giga-byte Technology Marvell 88E8001 Gigabit Ethernet Controller (Gigabyte)
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 185
	Memory at e1004000 (32-bit, non-prefetchable) [size=16K]
	I/O ports at a400 [size=256]
	[virtual] Expansion ROM at 20020000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data


--------------010508010206030309030902--
