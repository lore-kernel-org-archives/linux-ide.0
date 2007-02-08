From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Problems (and confusions) with Intel ICH7 SATA controller
Date: Thu, 08 Feb 2007 17:22:31 +0100
Message-ID: <1170951751.31971.18.camel@lapnavab35.informatik.tu-muenchen.de>
References: <1170536373.7892.5.camel@localhost>  <45C956CA.80709@gmail.com>
	 <1170928530.31971.1.camel@lapnavab35.informatik.tu-muenchen.de>
	 <45CB27C6.9090309@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-3ohZkb6QP7Zd8Bb1/Aa0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from charlie109.server4you.de ([85.25.2.70]:57703 "EHLO
	butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423128AbXBHQWg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Feb 2007 11:22:36 -0500
In-Reply-To: <45CB27C6.9090309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org


--=-3ohZkb6QP7Zd8Bb1/Aa0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> > That would be 2.6.18. I've also tried 2.6.19, but it had the same
> > problems and the ipw3945 wireless driver didn't work there, so I kept
> > 2.6.18 for the time being.
> I see.  Please post '/var/log/boot.msg', the result of 'dmesg' and 
> 'lspci -nn'.  Let's see which drivers you're using.
I attached the dmesg and lspci output. My Gentoo doesn't have a boot.msg, 
unfortunately, but wouldn't that contain the same data as dmesg anyway?

In any case, thanks - I hope you (or someone else) can make some sense
out of this.

Yours, Florian

--=-3ohZkb6QP7Zd8Bb1/Aa0
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=utf8
Content-Transfer-Encoding: 7bit

Linux version 2.6.18-gentoo (root@livecd) (gcc version 4.1.1 (Gentoo 4.1.1)) #3 PREEMPT Sat Oct 28 21:23:24 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fe90000 (usable)
 BIOS-e820: 000000001fe90000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
510MB LOWMEM available.
found SMP MP-table at 000f5bd0
On node 0 totalpages: 130704
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126608 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f5a30
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1fe96518
ACPI: FADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1fe9edfc
ACPI: MADT (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1fe9ee70
ACPI: HPET (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1fe9eed8
ACPI: MCFG (v001 INTEL  CALISTGA 0x06040000 LOHR 0x0000005a) @ 0x1fe9ef10
ACPI: TCPA (v001 PTLTD  CALISTGA 0x06040000  PTL 0x00000001) @ 0x1fe9ef4c
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x1fe9ef7e
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1fe9efd8
ACPI: SSDT (v001 SataRe  SataPri 0x00001000 INTL 0x20050624) @ 0x1fe97534
ACPI: SSDT (v001 SataRe  SataSec 0x00001000 INTL 0x20050624) @ 0x1fe96ea2
ACPI: SSDT (v001  PmRef  Cpu0Ist 0x00003000 INTL 0x20050624) @ 0x1fe96c76
ACPI: SSDT (v001  PmRef  Cpu0Cst 0x00003001 INTL 0x20050624) @ 0x1fe96a62
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x1fe9656c
ACPI: DSDT (v001 INTEL  CALISTGA 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: 2 duplicate APIC table ignored.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:14 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfec28000] gsi_base[24])
IOAPIC[1]: apic_id 2, version 255, address 0xfec28000, GSI 24-279
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
Detected 1862.395 MHz processor.
Built 1 zonelists.  Total pages: 130704
Kernel command line: root=/dev/sda4
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec28000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 515256k/522816k available (1651k kernel code, 7008k reserved, 541k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000 (virtual 0xe0800000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Calibrating delay using timer specific routine.. 3728.18 BogoMIPS (lpj=1864090)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
CPU: After vendor identify, caps: afe9fbff 00100000 00000000 00000000 0000c189 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00000940 0000c189 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Genuine Intel(R) CPU           T1350  @ 1.86GHz stepping 08
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #0b (-#0e) is hidden behind transparent bridge #0a (-#0a) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKD] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs *10 11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 10 *11)
ACPI: Embedded Controller [EC0] (gpe 23) interrupt mode.
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: dc000000-dc0fffff
  PREFETCH window: c8000000-cfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: 3000-3fff
  MEM window: d8000000-d9ffffff
  PREFETCH window: d2000000-d3ffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 4000-4fff
  MEM window: da000000-dbffffff
  PREFETCH window: d4000000-d5ffffff
PCI: Bus 11, cardbus bridge: 0000:0a:09.0
  IO window: 00005400-000054ff
  IO window: 00005800-000058ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 5000-5fff
  MEM window: dc100000-dc1fffff
  PREFETCH window: 30000000-31ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Enabling device 0000:00:1e.0 (0104 -> 0107)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:0a:09.0[A] -> GSI 22 (level, low) -> IRQ 19
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered (default)
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
libata version 2.00 loaded.
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ IDE IDE P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
scsi0 : ata_piix
input: AT Translated Set 2 keyboard as /class/input/input0
ata1.00: ATA-6, max UDMA/100, 117210240 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 16
ata1.01: ATAPI, max UDMA/33
ata1.00: configured for UDMA/33
ata1.01: configured for UDMA/33
  Vendor: ATA       Model: TOSHIBA MK6034GA  Rev: AC10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: MATSHITA  Model: DVD-RAM UJ-850S   Rev: 1.50
  Type:   CD-ROM                             ANSI SCSI revision: 05
ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
scsi1 : ata_piix
ATA: abnormal status 0x7F on port 0x177
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 117210240 512-byte hdwr sectors (60012 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:1:0: Attached scsi CD-ROM sr0
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI: (supports S0 S3 S4 S5<6>Time: tsc clocksource has been installed.
)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 21, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 20, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xdc404000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 20
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
8139cp 0000:0a:07.0: This (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
8139cp 0000:0a:07.0: Try the "8139too" driver instead.
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt 0000:0a:07.0[A] -> GSI 23 (level, low) -> IRQ 21
eth0: RealTek RTL8139 at 0x5000, 00:16:d3:46:7c:21, IRQ 21
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, 1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.1.0mpr
ipw3945: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:03:00.0 to 64
ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
Synaptics Touchpad, model: 1, fw: 6.2, id: 0x1a0b1, caps: 0xa04713/0x204000
input: SynPS/2 Synaptics TouchPad as /class/input/input1
EXT3 FS on sda4, internal journal
ACPI: AC Adapter [ADP1] (off-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Getting cpuindex for acpiid 0x1
Time: hpet clocksource has been installed.
ACPI: Thermal Zone [TZS0] (30 C)
ACPI: Thermal Zone [TZS1] (27 C)
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 431 MBytes.
[fglrx] module loaded - fglrx 8.32.5 [Dec 12 2006] on minor 0
Adding 987988k swap on /dev/sda3.  Priority:-1 extents:1 across:987988k
Real Time Clock Driver v1.12ac
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[fglrx] total      GART = 130023424
[fglrx] free       GART = 114032640
[fglrx] max single GART = 114032640
[fglrx] total      LFB  = 134086656
[fglrx] free       LFB  = 119697408
[fglrx] max single LFB  = 119697408
[fglrx] total      Inv  = 0
[fglrx] free       Inv  = 0
[fglrx] max single Inv  = 0
[fglrx] total      TIM  = 0
eth0: link down
ieee80211_crypt: registered algorithm 'WEP'

--=-3ohZkb6QP7Zd8Bb1/Aa0
Content-Disposition: attachment; filename=lspci
Content-Type: text/plain; name=lspci; charset=utf8
Content-Transfer-Encoding: 7bit

00:00.0 0600: 8086:27a0 (rev 03)
00:01.0 0604: 8086:27a1 (rev 03)
00:1b.0 0403: 8086:27d8 (rev 02)
00:1c.0 0604: 8086:27d0 (rev 02)
00:1c.1 0604: 8086:27d2 (rev 02)
00:1c.2 0604: 8086:27d4 (rev 02)
00:1d.0 0c03: 8086:27c8 (rev 02)
00:1d.1 0c03: 8086:27c9 (rev 02)
00:1d.2 0c03: 8086:27ca (rev 02)
00:1d.3 0c03: 8086:27cb (rev 02)
00:1d.7 0c03: 8086:27cc (rev 02)
00:1e.0 0604: 8086:2448 (rev e2)
00:1f.0 0601: 8086:27b9 (rev 02)
00:1f.2 0101: 8086:27c4 (rev 02)
00:1f.3 0c05: 8086:27da (rev 02)
01:00.0 0300: 1002:7149
03:00.0 0280: 8086:4222 (rev 02)
0a:01.0 0805: 1180:0822 (rev 19)
0a:01.1 0880: 1180:0843 (rev 01)
0a:01.2 0880: 1180:0592 (rev 0a)
0a:01.3 0880: 1180:0852 (rev 05)
0a:07.0 0200: 10ec:8139 (rev 10)
0a:09.0 0607: 1524:1410 (rev 01)

--=-3ohZkb6QP7Zd8Bb1/Aa0--

