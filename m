From: bwkeck@gmail.com (Brian Keck)
Subject: slow resume from s2ram
Date: Wed, 06 Feb 2008 00:09:31 +1100
Message-ID: <20080205130931.56F31E2B10@vilya.x>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound.icp-qv1-irony-out4.iinet.net.au ([203.59.1.150]:49169
	"EHLO outbound.icp-qv1-irony-out4.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751921AbYBENTZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Feb 2008 08:19:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Hello,

I can't get my otherwise lovely debian/sid Vaio TX17 to resume promptly
from suspend-to-ram.

Until recently it resumed at all maybe 1 in 4 times from
's2ram -f -p' in X, always taking several minutes, apparently 
due to the hard disk (1.8" Toshiba HDD1544/MK6006GAH).   

Last week I tried 2 things:

  * added /etc/modprobe.d/libata with
    options libata noacpi=0

  * built a kernel + initrd from debian linux-source-2.6.24 with
    CONFIG_BLK_DEV_IDEACPI=y

This boots OK, with ...

   $ cat /sys/module/libata/parameters/noacpi
   0

But the only improvement is that, from X, it resumes every time (maybe
10 times so far).  It still takes about 90 seconds (the disc light is on
for the 1st 30 seconds, then after another 60 seconds it comes on again
& the display comes back).

This is with the s2ram from debian/sid current uswsusp.
Oddly, s2ram has always worked best from X.

dmesg below ... presumably the delay is connected to the lines ...
  hda: lost interrupt
  hda: dma_timer_expiry: dma status == 0x21

Any ideas?

Thanks,
Brian Keck

----------------------------------------------------------------------

Linux version 2.6.24 (2.6.24-1) (bkeck@vilya.x) (gcc version 4.2.1 (Debian 4.2.1-5)) #2 SMP Fri Feb 1 20:28:43 EST 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003f690000 (usable)
 BIOS-e820: 000000003f690000 - 000000003f69d000 (ACPI data)
 BIOS-e820: 000000003f69d000 - 000000003f700000 (ACPI NVS)
 BIOS-e820: 000000003f700000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0006000 (reserved)
 BIOS-e820: 00000000f0008000 - 00000000f000c000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
118MB HIGHMEM available.
896MB LOWMEM available.
Entering add_active_range(0, 0, 259728) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   259728
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->   259728
On node 0 totalpages: 259728
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 237 pages used for memmap
  HighMem zone: 30115 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
DMI 2.3 present.
ACPI: RSDP 000F6790, 0014 (r0 PTLTD )
ACPI: RSDT 3F697E7C, 0044 (r1   Sony       V1 20050805 PTL         0)
ACPI: FACP 3F69CE78, 0084 (r2   Sony       V1 20050805 PTL        50)
ACPI: DSDT 3F69896F, 4509 (r1   Sony       V1 20050805 PTL   100000E)
ACPI: FACS 3F6ADFC0, 0040
ACPI: APIC 3F69CEFC, 0068 (r1   Sony       V1 20050805 PTL        50)
ACPI: BOOT 3F69CFD8, 0028 (r1   Sony       V1 20050805 PTL         1)
ACPI: MCFG 3F69CF9C, 003C (r1   Sony       V1 20050805 PTL        5F)
ACPI: SSDT 3F69873D, 022E (r1   Sony       V1 20050805 PTL  20030224)
ACPI: SSDT 3F6982F8, 0235 (r1   Sony       V1 20050805 PTL  20030224)
ACPI: SSDT 3F6980D9, 021F (r1   Sony       V1 20050805 PTL  20030224)
ACPI: SSDT 3F697EC0, 0219 (r1   Sony       V1 20050805 PTL  20030224)
ACPI: DMI detected: Sony
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:13 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 257699
Kernel command line: root=/dev/hda2 ro
mapped APIC to ffffb000 (fee00000)
mapped IOAPIC to ffffa000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1197.028 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1020860k/1038912k available (1692k kernel code, 17256k reserved, 671k data, 216k init, 121408k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0355000 - 0xc038b000   ( 216 kB)
      .data : 0xc02a71d8 - 0xc034f130   ( 671 kB)
      .text : 0xc0100000 - 0xc02a71d8   (1692 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2396.97 BogoMIPS (lpj=4793954)
Security Framework initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9fbff 00100000 00000000 00000000 00000180 00000000 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9fbff 00100000 00000000 00002040 00000180 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 11k freed
ACPI: Core revision 20070126
CPU0: Intel(R) Pentium(R) M processor 1.20GHz stepping 08
Total of 1 processors activated (2396.97 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 01
  groups: 01
net_namespace: 64 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: EC: non-query interrupt received, switching to interrupt mode
ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
ACPI: EC: driver started in interrupt mode
ACPI: PCI Root Bridge [PCI0] (0000:00)
Force enabled HPET at base address 0xfed00000
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs *10)
ACPI: PCI Interrupt Link [LNKE] (IRQs *10)
ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *3
ACPI: PCI Interrupt Link [LNKG] (IRQs *10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 8
NET: Registered protocol family 20
hpet clockevent registered
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Time: tsc clocksource has been installed.
system 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
system 00:01: iomem range 0xf0000000-0xf0003fff could not be reserved
system 00:01: iomem range 0xf0004000-0xf0004fff could not be reserved
system 00:01: iomem range 0xf0005000-0xf0005fff could not be reserved
system 00:01: iomem range 0xf0008000-0xf000bfff could not be reserved
system 00:01: iomem range 0xfed20000-0xfed8ffff could not be reserved
system 00:05: ioport range 0x680-0x68f has been reserved
system 00:05: ioport range 0x800-0x80f has been reserved
system 00:05: ioport range 0x1000-0x107f has been reserved
system 00:05: ioport range 0x1180-0x11bf has been reserved
system 00:05: ioport range 0xfe00-0xfe01 has been reserved
system 00:05: iomem range 0xd000c000-0xd000ffff has been reserved
PCI: Bus 7, cardbus bridge: 0000:06:05.0
  IO window: 00002400-000024ff
  IO window: 00002800-000028ff
  PREFETCH window: 54000000-57ffffff
  MEM window: 58000000-5bffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: b0100000-b01fffff
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:06:05.0[A] -> GSI 21 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Switched to high resolution mode on CPU 0
Freeing initrd memory: 5355k freed
Simple Boot Flag at 0x49 set to 0x1
audit: initializing netlink socket (disabled)
audit(1201966804.000:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
PCI: Firmware left 0000:06:08.0 e100 interrupts enabled, disabling
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
Freeing unused kernel memory: 216k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
Marking TSC unstable due to: possible TSC halt in C2.
ACPI: Thermal Zone [ATF0] (80 C)
Time: hpet clocksource has been installed.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 17, io base 0x00001820
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 18, io base 0x00001840
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 21 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 16, io base 0x00001860
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 17, io base 0x00001880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xb0004000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
Clocksource tsc unstable (delta = -113935905 ns)
ACPI: PCI Interrupt 0000:06:05.2[C] -> GSI 20 (level, low) -> IRQ 20
firewire_ohci: Added fw-ohci device 0000:06:05.2, OHCI version 1.10
ACPI: PCI Interrupt 0000:06:08.0[A] -> GSI 20 (level, low) -> IRQ 20
e100: eth0: e100_probe: addr 0xb0107000, irq 20, MAC addr 00:01:4a:99:86:1d
ICH6: IDE controller (0x8086:0x266f rev 0x03) at  PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[B] -> GSI 18 (level, low) -> IRQ 21
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1810-0x1817, BIOS settings: hda:DMA, hdb:DMA
ICH6: IDE port disabled
Probing IDE interface ide0...
firewire_core: created new fw device fw0 (0 config rom retries, S400)
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
hdb: MATSHITAUJ-832D, ATAPI CD/DVD-ROM drive
hda: TOSHIBA MK6006GAH, ATA DISK drive
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: UDMA/100 mode selected
hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA/33 mode selected
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
SCSI subsystem initialized
libata version 3.00 loaded.
hda: max request size: 512KiB
hda: 117210240 sectors (60011 MB), CHS=16383/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4
hdb: ATAPI 31X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
iTCO_wdt: failed to reset NO_REBOOT flag, reboot disabled by hardware
iTCO_wdt: No card detected
Real Time Clock Driver v1.12ac
input: PC Speaker as /class/input/input1
Linux agpgart interface v0.102
agpgart: Detected an Intel 915GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xc0000000
intel_rng: FWH not detected
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
input: PS/2 Mouse as /class/input/input2
input: AlpsPS/2 ALPS GlidePoint as /class/input/input3
input: Lid Switch as /class/input/input4
ACPI: Lid Switch [LID0]
input: Power Button (CM) as /class/input/input5
ACPI: Power Button (CM) [PWRB]
Yenta: CardBus bridge found at 0000:06:05.0 [104d:81e2]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:06:05.0, mfunc 0x01af1b22, devctl 0x64
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#06) from #07 to #0a
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0xb0100000 - 0xb01fffff
ACPI: PCI Interrupt 0000:06:05.3[B] -> GSI 23 (level, low) -> IRQ 19
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.2kmq
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:06:0b.0[A] -> GSI 22 (level, low) -> IRQ 22
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1b.0 to 64
sony-laptop: Sony Programmable IO Control Driver v0.5.
sony-laptop: detected Type3 model
input: Sony Vaio Keys as /class/input/input6
input: Sony Vaio Jogdial as /class/input/input7
sony-laptop: Sony Notebook Control Driver v0.5.
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
cs: IO port probe 0x100-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0xa00-0xaff: clean.
ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)
EXT3 FS on hda2, internal journal
Probing IDE interface ide1...
eeprom 0-0057: Vaio EEPROM detected, enabling privacy protection
device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
ieee80211_crypt: registered algorithm 'WEP'
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
lp: driver loaded but no devices found
ppdev: user-space parallel port driver
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
wlan0: no IPv6 routers present
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 23
[drm] Initialized i915 1.6.0 20060119 on minor 0
Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.00 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s)
ACPI handle has no context!
wlan0: Going into suspend...
ACPI: PCI interrupt for device 0000:06:0b.0 disabled
Trying to free already-free IRQ 20
ACPI: PCI interrupt for device 0000:06:08.0 disabled
ACPI: PCI interrupt for device 0000:06:05.3 disabled
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
ACPI: PCI interrupt for device 0000:00:1d.3 disabled
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
ACPI: PCI interrupt for device 0000:00:1b.0 disabled
Disabling non-boot CPUs ...
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
Force enabled HPET at resume
sony-laptop: unable to restore brightness level<7>PM: Writing back config space on device 0000:00:02.0 at offset f (was 100, writing 10a)
PM: Writing back config space on device 0000:00:02.0 at offset 6 (was d0000008, writing c0000008)
PM: Writing back config space on device 0000:00:02.0 at offset 5 (was de01, writing 1801)
PM: Writing back config space on device 0000:00:02.0 at offset 4 (was cff80000, writing b0080000)
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 23
PM: Writing back config space on device 0000:00:1b.0 at offset 3 (was 0, writing 10)
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb1: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb2: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 21 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb3: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.3 to 64
usb usb4: root hub lost power or was reset
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PM: Writing back config space on device 0000:00:1e.0 at offset f (was 40000, writing 400ff)
PM: Writing back config space on device 0000:00:1e.0 at offset 9 (was 10001, writing 1fff1)
PM: Writing back config space on device 0000:00:1e.0 at offset 8 (was 0, writing b010b010)
PM: Writing back config space on device 0000:00:1e.0 at offset 7 (was 22800000, writing 22802020)
PM: Writing back config space on device 0000:00:1e.0 at offset 1 (was 100004, writing 100007)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:00:1f.1[B] -> GSI 18 (level, low) -> IRQ 21
PM: Writing back config space on device 0000:06:05.0 at offset f (was 34001ff, writing 5c00103)
PM: Writing back config space on device 0000:06:05.0 at offset e (was 0, writing 28fc)
PM: Writing back config space on device 0000:06:05.0 at offset d (was 0, writing 2800)
PM: Writing back config space on device 0000:06:05.0 at offset c (was 0, writing 24fc)
PM: Writing back config space on device 0000:06:05.0 at offset b (was 0, writing 2400)
PM: Writing back config space on device 0000:06:05.0 at offset a (was 0, writing 5bfff000)
PM: Writing back config space on device 0000:06:05.0 at offset 9 (was 0, writing 58000000)
PM: Writing back config space on device 0000:06:05.0 at offset 8 (was 0, writing 57fff000)
PM: Writing back config space on device 0000:06:05.0 at offset 7 (was 0, writing 54000000)
PM: Writing back config space on device 0000:06:05.0 at offset 6 (was 0, writing b00a0706)
PM: Writing back config space on device 0000:06:05.0 at offset 4 (was 0, writing b0109000)
PM: Writing back config space on device 0000:06:05.0 at offset 3 (was 820000, writing 82a808)
PM: Writing back config space on device 0000:06:05.0 at offset 1 (was 2100000, writing 2100007)
PM: Writing back config space on device 0000:06:05.2 at offset f (was 4030300, writing 403030a)
PM: Writing back config space on device 0000:06:05.2 at offset 5 (was 0, writing b0100000)
PM: Writing back config space on device 0000:06:05.2 at offset 4 (was 0, writing b0106000)
PM: Writing back config space on device 0000:06:05.2 at offset 3 (was 800000, writing 802010)
PM: Writing back config space on device 0000:06:05.2 at offset 1 (was 2100000, writing 2100016)
PM: Writing back config space on device 0000:06:05.3 at offset f (was 40702ff, writing 407020a)
PM: Writing back config space on device 0000:06:05.3 at offset 4 (was 0, writing b0104000)
PM: Writing back config space on device 0000:06:05.3 at offset 3 (was 800000, writing 803910)
PM: Writing back config space on device 0000:06:05.3 at offset 1 (was 2100000, writing 2100006)
ACPI: PCI Interrupt 0000:06:05.3[B] -> GSI 23 (level, low) -> IRQ 19
PM: Writing back config space on device 0000:06:08.0 at offset f (was 38080100, writing 3808010a)
PM: Writing back config space on device 0000:06:08.0 at offset 5 (was 1, writing 2001)
PM: Writing back config space on device 0000:06:08.0 at offset 4 (was 0, writing b0107000)
PM: Writing back config space on device 0000:06:08.0 at offset 3 (was 0, writing 4210)
PM: Writing back config space on device 0000:06:08.0 at offset 1 (was 2900000, writing 2900017)
wlan0: Coming out of suspend...
PCI: Enabling device 0000:06:0b.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:06:0b.0[A] -> GSI 22 (level, low) -> IRQ 22
PM: Writing back config space on device 0000:06:0b.0 at offset f (was 18030100, writing 1803010a)
PM: Writing back config space on device 0000:06:0b.0 at offset 4 (was 0, writing b0108000)
PM: Writing back config space on device 0000:06:0b.0 at offset 3 (was 0, writing 2010)
PM: Writing back config space on device 0000:06:0b.0 at offset 1 (was 2900002, writing 2900016)
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hda: lost interrupt
hda: UDMA/100 mode selected
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: status error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
hda: status error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
hda: lost interrupt
hda: status error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: no DRQ after issuing MULTWRITE_EXT
hda: status error: status=0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hdb: DMA disabled
hda: no DRQ after issuing MULTWRITE_EXT
ide0: reset: success
hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
hdb: UDMA/33 mode selected
Restarting tasks ... <6>usb 3-1: USB disconnect, address 2
done.
usb 3-1: new full speed USB device using uhci_hcd and address 3
usb 3-1: configuration #1 chosen from 1 choice
ADDRCONF(NETDEV_UP): wlan0: link is not ready
ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
wlan0: no IPv6 routers present
