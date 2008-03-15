From: Andy Sturrock <linux-kernel@sturrock.org>
Subject: Marvell 6141 support
Date: Sat, 15 Mar 2008 11:03:01 +0000
Message-ID: <1205578981.3107.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-y3tW/xKu8Q70983XwYCA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56542 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYCOLDG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 07:03:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org


--=-y3tW/xKu8Q70983XwYCA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jeff,

The patch you submitted back in May 2007 you called "Add Marvell 6141
PATA support to AHCI driver" in your mails, although the actual git
revision 63 to ahci.c you called "... (initially 6145)".  The patch
actually contains only support for the 6145 chip, not 6141.

Anyway, I tried adding:

+    { PCI_VDEVICE(MARVELL, 0x6141), board_ahci_mv },	/* 6141*/

to see whether the 6141 chip would work as well.  Initially all seems
fine, I can see the attached drives in /dev and fdisk and mkfs.ext3 seem
to work OK.  Then I tried putting the drives into a RAID 5 array using
mdadm and it all went pear-shaped - see output from dmesg etc attached.

I'm happy to have a go at fixing this myself but I've never done any
kernel programming before (I've always been an application programmer)
so I don't really know where to start.

I've attached the output from everything helpful I can think of.  Any
direction you can give me would be appreciated.

Thanks,

Andy

--=-y3tW/xKu8Q70983XwYCA
Content-Disposition: attachment; filename=dmesg.out
Content-Type: text/plain; name=dmesg.out; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Initializing cgroup subsys cpuset
Linux version 2.6.24.3-12.Marvell_6141.fc8 (andy@linux-pc-1) (gcc version 4=
.1.2 20070925 (Red Hat 4.1.2-33)) #1 SMP Sun Mar 9 15:14:01 GMT 2008
Command line: ro root=3D/dev/VolGroup00/root00 rhgb quiet
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000099000 (usable)
 BIOS-e820: 0000000000099000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff80000 (usable)
 BIOS-e820: 000000003ff80000 - 000000003ff8e000 (ACPI data)
 BIOS-e820: 000000003ff8e000 - 000000003ffe0000 (ACPI NVS)
 BIOS-e820: 000000003ffe0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 153) 0 entries of 3200 used
Entering add_active_range(0, 256, 262016) 1 entries of 3200 used
end_pfn_map =3D 1048576
DMI 2.3 present.
ACPI: RSDP 000FA740, 0014 (r0 ACPIAM)
ACPI: RSDT 3FF80000, 0034 (r1 A M I  OEMRSDT   7000610 MSFT       97)
ACPI: FACP 3FF80200, 0081 (r1 A M I  OEMFACP   7000610 MSFT       97)
ACPI: DSDT 3FF80410, 84CF (r1  A0411 A0411000        0 INTL  2002026)
ACPI: FACS 3FF8E000, 0040
ACPI: APIC 3FF80390, 0080 (r1 A M I  OEMAPIC   7000610 MSFT       97)
ACPI: OEMB 3FF8E040, 0066 (r1 A M I  AMI_OEM   7000610 MSFT       97)
ACPI: MCFG 3FF888E0, 003C (r1 A M I  OEMMCFG   7000610 MSFT       97)
No NUMA configuration found
Faking a node at 0000000000000000-000000003ff80000
Entering add_active_range(0, 0, 153) 0 entries of 3200 used
Entering add_active_range(0, 256, 262016) 1 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000003ff80000
 [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001200000 on node 0
 [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 on node 0
 [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001a00000 on node 0
 [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001e00000 on node 0
 [ffffe20000800000-ffffe200009fffff] PMD ->ffff810002200000 on node 0
 [ffffe20000a00000-ffffe20000bfffff] PMD ->ffff810002600000 on node 0
 [ffffe20000c00000-ffffe20000dfffff] PMD ->ffff810002a00000 on node 0
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      153
    0:      256 ->   262016
On node 0 totalpages: 261913
  DMA zone: 56 pages used for memmap
  DMA zone: 1331 pages reserved
  DMA zone: 2606 pages, LIFO batch:0
  DMA32 zone: 3526 pages used for memmap
  DMA32 zone: 254394 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 0000000000099000 - 00000000000a000=
0
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000e400=
0
swsusp: Registered nosave memory region: 00000000000e4000 - 000000000010000=
0
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb00000)
SMP: Allowing 4 CPUs, 2 hotplug CPUs
PERCPU: Allocating 42248 bytes of per cpu data
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 257000
Policy zone: DMA32
Kernel command line: ro root=3D/dev/VolGroup00/root00 rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
TSC calibrated against PM_TIMER
time.c: Detected 3211.354 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
Memory: 1023712k/1048064k available (2492k kernel code, 23940k reserved, 13=
90k data, 332k init)
SLUB: Genslabs=3D12, HWalign=3D64, Order=3D0-1, MinObjects=3D4, CPUs=3D4, N=
odes=3D1
Calibrating delay using timer specific routine.. 6426.14 BogoMIPS (lpj=3D32=
13073)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
APIC timer calibration result 12544335
Detected 12.544 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6422.64 BogoMIPS (lpj=3D32=
11320)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
              Intel(R) Pentium(R) D CPU 3.20GHz stepping 02
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
sizeof(vma)=3D176 bytes
sizeof(page)=3D56 bytes
sizeof(inode)=3D560 bytes
sizeof(dentry)=3D208 bytes
sizeof(ext3inode)=3D760 bytes
sizeof(buffer_head)=3D104 bytes
sizeof(skbuff)=3D224 bytes
sizeof(task_struct)=3D2224 bytes
CPU0 attaching sched-domain:
 domain 0: span 00000000,00000003
  groups: 00000000,00000001 00000000,00000002
  domain 1: span 00000000,00000003
   groups: 00000000,00000003
CPU1 attaching sched-domain:
 domain 0: span 00000000,00000003
  groups: 00000000,00000002 00000000,00000001
  domain 1: span 00000000,00000003
   groups: 00000000,00000003
net_namespace: 120 bytes
Time: 10:38:32  Date: 03/15/08
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
Force enabled HPET at base address 0xfed00000
PCI quirk: region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 0480-04bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disable=
d.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI Warning (tbutils-0217): Incorrect checksum in table [OEMB] -  BC, shou=
ld be AE [20070126]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 16 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post a r=
eport
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
DMAR:No DMAR devices found
PCI-GART: No AMD northbridge found.
hpet clockevent registered
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Time: tsc clocksource has been installed.
system 00:01: iomem range 0xfed13000-0xfed19fff has been reserved
system 00:08: ioport range 0x290-0x297 has been reserved
system 00:09: ioport range 0x4d0-0x4d1 has been reserved
system 00:09: ioport range 0x800-0x87f has been reserved
system 00:09: ioport range 0x400-0x41f has been reserved
system 00:09: ioport range 0x480-0x4bf has been reserved
system 00:09: ioport range 0x900-0x91f has been reserved
system 00:09: iomem range 0xfed1c000-0xfed1ffff has been reserved
system 00:09: iomem range 0xfed20000-0xfed3ffff has been reserved
system 00:09: iomem range 0xfed50000-0xfed8ffff has been reserved
system 00:09: iomem range 0xffb00000-0xffbfffff could not be reserved
system 00:09: iomem range 0xfff00000-0xffffffff could not be reserved
system 00:0c: iomem range 0xfec00000-0xfec00fff has been reserved
system 00:0c: iomem range 0xfee00000-0xfee00fff could not be reserved
system 00:0e: iomem range 0xf0000000-0xf3ffffff has been reserved
system 00:0f: iomem range 0x0-0x9ffff could not be reserved
system 00:0f: iomem range 0xc0000-0xdffff has been reserved
system 00:0f: iomem range 0xe0000-0xfffff could not be reserved
system 00:0f: iomem range 0x100000-0x3fffffff could not be reserved
system 00:0f: iomem range 0x0-0x0 could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: ff900000-ff9fffff
  PREFETCH window: dff00000-efefffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: dfe00000-dfefffff
PCI: Bridge: 0000:00:1c.3
  IO window: b000-bfff
  MEM window: ff800000-ff8fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: a000-afff
  MEM window: ff700000-ff7fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: 9000-9fff
  MEM window: ff600000-ff6fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: disabled.
  MEM window: ff500000-ff5fffff
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3918k freed
audit: initializing netlink socket (disabled)
audit(1205577512.572:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key 7CE4D0E2B2927D09
- User ID: Red Hat, Inc. (Kernel Module GPG key)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:06:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI Warning (tbutils-0217): Incorrect checksum in table [  q=B4] -  00, sh=
ould be 8D [20070126]
ACPI Error (tbinstal-0134): Table has invalid signature [  q=B4], must be S=
SDT, PSDT or OEMx [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU1._PDC] =
(Node ffff81003f8064e0), AE_BAD_SIGNATURE
ACPI: Processor [CPU1] (supports 8 throttling states)
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
ACPI Warning (tbutils-0217): Incorrect checksum in table [  q=B4] -  00, sh=
ould be 8D [20070126]
ACPI Error (tbinstal-0134): Table has invalid signature [  q=B4], must be S=
SDT, PSDT or OEMx [20070126]
ACPI Error (psparse-0537): Method parse/execution failed [\_PR_.CPU2._PDC] =
(Node ffff81003f8065a0), AE_BAD_SIGNATURE
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not=
 present [20070126]
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not=
 present [20070126]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.103
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
00:0d: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /devices/virtual/input/input0
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input=
/input1
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
registered taskstats version 1
  Magic number: 0:747:628
Freeing unused kernel memory: 332k freed
Write protecting the kernel read-only data: 1080k
logips2pp: Detected unknown logitech mouse model 57
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xffafbc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 20, io base 0x0000e480
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 17, io base 0x0000e800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
input: ImExPS/2 Logitech Explorer Mouse as /devices/platform/i8042/serio1/i=
nput/input2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000e880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 19, io base 0x0000ec00
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
SCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods
libata version 3.00 loaded.
ahci 0000:00:1f.2: version 3.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 23 (level, low) -> IRQ 23
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl RAID mod=
e
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part=20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xffafb800 port 0xffafb900 irq 2298
ata2: SATA max UDMA/133 abar m1024@0xffafb800 port 0xffafb980 irq 2298
ata3: SATA max UDMA/133 abar m1024@0xffafb800 port 0xffafba00 irq 2298
ata4: SATA max UDMA/133 abar m1024@0xffafb800 port 0xffafba80 irq 2298
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: HDT722525DLA380, V44OA96A, max UDMA/133
ata1.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7: HDT722525DLA380, V44OA96A, max UDMA/133
ata2.00: 488397168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata2.00: configured for UDMA/133
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: =
5
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: =
5
sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sdb: sdb1 sdb2
sd 1:0:0:0: [sdb] Attached SCSI disk
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
ahci 0000:02:00.0: controller can't do NCQ, turning off CAP_NCQ
ahci 0000:02:00.0: MV_AHCI HACK: port_map 0 -> 0
ahci 0000:02:00.0: nr_ports (5) and implemented port map (0xf) don't match,=
 using nr_ports
ahci 0000:02:00.0: forcing PORTS_IMPL to 0x1f
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 5 ports 3 Gbps 0x1f impl SATA mo=
de
ahci 0000:02:00.0: flags: 64bit stag nz only pmp slum part=20
PCI: Setting latency timer of device 0000:02:00.0 to 64
scsi4 : ahci
scsi5 : ahci
scsi6 : ahci
scsi7 : ahci
scsi8 : ahci
ata5: SATA max UDMA/133 abar m1024@0xff6ffc00 port 0xff6ffd00 irq 17
ata6: SATA max UDMA/133 abar m1024@0xff6ffc00 port 0xff6ffd80 irq 17
ata7: SATA max UDMA/133 abar m1024@0xff6ffc00 port 0xff6ffe00 irq 17
ata8: SATA max UDMA/133 abar m1024@0xff6ffc00 port 0xff6ffe80 irq 17
ata9: SATA max UDMA/133 abar m1024@0xff6ffc00 port 0xff6fff00 irq 17
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata5.00: ATA-7: HDT722525DLA380, V44OA96A, max UDMA/133
ata5.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata5.00: configured for UDMA/133
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata6.00: ATA-7: HDT722525DLA380, V44OA96A, max UDMA/133
ata6.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata6.00: configured for UDMA/133
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata7.00: ATA-7: HDT722525DLA380, V44OA96A, max UDMA/133
ata7.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata7.00: configured for UDMA/133
ata8: SATA link down (SStatus 0 SControl 0)
ata9: SATA link down (SStatus 0 SControl 0)
scsi 4:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: =
5
sd 4:0:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 4:0:0:0: [sdc] 488397168 512-byte hardware sectors (250059 MB)
sd 4:0:0:0: [sdc] Write Protect is off
sd 4:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sdc: sdc1
sd 4:0:0:0: [sdc] Attached SCSI disk
scsi 5:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: =
5
sd 5:0:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:0:0:0: [sdd] Write Protect is off
sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 5:0:0:0: [sdd] 488397168 512-byte hardware sectors (250059 MB)
sd 5:0:0:0: [sdd] Write Protect is off
sd 5:0:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 5:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sdd: sdd1
sd 5:0:0:0: [sdd] Attached SCSI disk
scsi 6:0:0:0: Direct-Access     ATA      HDT722525DLA380  V44O PQ: 0 ANSI: =
5
sd 6:0:0:0: [sde] 488397168 512-byte hardware sectors (250059 MB)
sd 6:0:0:0: [sde] Write Protect is off
sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 6:0:0:0: [sde] 488397168 512-byte hardware sectors (250059 MB)
sd 6:0:0:0: [sde] Write Protect is off
sd 6:0:0:0: [sde] Mode Sense: 00 3a 00 00
sd 6:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sde: sde1
sd 6:0:0:0: [sde] Attached SCSI disk
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redha=
t.com
ata_piix 0000:00:1f.1: version 2.12
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1f.1 to 64
scsi9 : ata_piix
scsi10 : ata_piix
ata10: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
ata11: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
ata10.00: ATAPI: SONY    DVD RW AW-G170A, 1.71, max UDMA/66
ata10.01: ATAPI: Pioneer DVD-ROM ATAPIModel DVD-105S 0111, E1.11, max UDMA/=
33
ata10.00: limited to UDMA/33 due to 40-wire cable
ata10.00: configured for UDMA/33
ata10.01: configured for UDMA/33
scsi 9:0:0:0: CD-ROM            SONY     DVD RW AW-G170A  1.71 PQ: 0 ANSI: =
5
scsi 9:0:1:0: CD-ROM            PIONEER  DVD-ROM DVD-105  1.11 PQ: 0 ANSI: =
5
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1205577527.089:2): enforcing=3D1 old_enforcing=3D0 auid=3D4294967295
SELinux:8192 avtab hash slots allocated.Num of rules:217156
SELinux:8192 avtab hash slots allocated.Num of rules:217156
security:  8 users, 12 roles, 2363 types, 114 bools, 1 sens, 1024 cats
security:  67 classes, 217156 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-3, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_cont=
exts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: policy loaded with handle_unknown=3Dallow
audit(1205577527.496:3): policy loaded auid=3D4294967295
Driver 'sr' needs updating - please use bus_type methods
input: Power Button (FF) as /devices/virtual/input/input3
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 9:0:0:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
sr 9:0:1:0: Attached scsi CD-ROM sr1
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 4:0:0:0: Attached scsi generic sg2 type 0
sd 5:0:0:0: Attached scsi generic sg3 type 0
sd 6:0:0:0: Attached scsi generic sg4 type 0
sr 9:0:0:0: Attached scsi generic sg5 type 5
sr 9:0:1:0: Attached scsi generic sg6 type 5
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /devices/virtual/input/input4
ACPI: Power Button (CM) [PWRB]
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:04:00.0 to 64
sky2 0000:04:00.0: v1.20 addr 0xff8fc000 irq 19 Yukon-EC (0xb6) rev 2
sky2 eth0: addr 00:17:31:9a:e1:e7
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:03:00.0 to 64
sky2 0000:03:00.0: v1.20 addr 0xff7fc000 irq 16 Yukon-EC (0xb6) rev 2
sky2 eth1: addr 00:17:31:9a:d8:9c
EDAC MC: Ver: 2.1.0 Mar  9 2008
EDAC i82975x: ECC disabled on both channels.
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA sound/pci/hda/hda_intel.c:732: codec_mask =3D 0x1
ALSA sound/pci/hda/hda_codec.c:2162: hda_codec: model '6stack-dig' is selec=
ted for config 1043:81d8 (Asus P5WD)
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 23 (level, low) -> IRQ 23
iTCO_vendor_support: vendor-support=3D0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.02 (26-Jul-2007)
iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=3D2, TCOBASE=3D0x0860)
iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
input: PC Speaker as /devices/platform/pcspkr/input/input5
intel_rng: FWH not detected
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 21
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
firewire_ohci: Added fw-ohci device 0000:01:03.0, OHCI version 1.10
firewire_core: created device fw0: GUID 0011d80000ab0cf4, S400
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ACPI: PCI Interrupt 0000:06:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized drm 1.1.0 20060810
PCI: Setting latency timer of device 0000:06:00.0 to 64
[drm] Initialized radeon 1.28.0 20060524 on minor 0
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on dm-3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-6, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-7, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-5, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev dm-4, type ext3), uses xattr
Adding 2031608k swap on /dev/mapper/VolGroup00-swap00.  Priority:-1 extents=
:1 across:2031608k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contex=
ts
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
warning: process `kudzu' used the deprecated sysctl system call with 1.23.
ip6_tables: (C) 2000-2006 Netfilter Core Team
nf_conntrack version 0.5.0 (8192 buckets, 32768 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
sky2 eth0: enabling interface
ADDRCONF(NETDEV_UP): eth0: link is not ready
sky2 eth0: Link is up at 100 Mbps, full duplex, flow control both
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
fuse init (API version 7.9)
SELinux: initialized (dev fusectl, type fusectl), not configured for labeli=
ng
audit(1205577550.915:4): avc:  denied  { mount } for  pid=3D2291 comm=3D"mo=
unt" name=3D"/" dev=3Dfusectl ino=3D1 scontext=3Dsystem_u:system_r:mount_t:=
s0 tcontext=3Dsystem_u:object_r:unlabeled_t:s0 tclass=3Dfilesystem
SELinux: initialized (dev fusectl, type fusectl), not configured for labeli=
ng
audit(1205577550.915:5): avc:  denied  { mount } for  pid=3D2291 comm=3D"mo=
unt" name=3D"/" dev=3Dfusectl ino=3D1 scontext=3Dsystem_u:system_r:mount_t:=
s0 tcontext=3Dsystem_u:object_r:unlabeled_t:s0 tclass=3Dfilesystem
audit(1205577551.678:6): audit_pid=3D2358 old=3D0 by auid=3D4294967295 subj=
=3Dsystem_u:system_r:auditd_t:s0
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
eth0: no IPv6 routers present
[drm] Setting GART location based on new memory map
[drm] Loading R300 Microcode
[drm] writeback test succeeded in 1 usecs
CPU0 attaching NULL sched-domain.
CPU1 attaching NULL sched-domain.
CPU0 attaching sched-domain:
 domain 0: span 00000000,00000003
  groups: 00000000,00000001 00000000,00000002
  domain 1: span 00000000,00000003
   groups: 00000000,00000003
CPU1 attaching sched-domain:
 domain 0: span 00000000,00000003
  groups: 00000000,00000002 00000000,00000001
  domain 1: span 00000000,00000003
   groups: 00000000,00000003
md: bind<sdc1>
md: bind<sdd1>
md: bind<sde1>
xor: automatically using best checksumming function: generic_sse
   generic_sse:  4888.000 MB/sec
xor: using function: generic_sse (4888.000 MB/sec)
async_tx: api initialized (async)
raid6: int64x1   1488 MB/s
raid6: int64x2   1980 MB/s
raid6: int64x4   2050 MB/s
raid6: int64x8   1929 MB/s
raid6: sse2x1    2359 MB/s
raid6: sse2x2    3042 MB/s
raid6: sse2x4    3292 MB/s
raid6: using algorithm sse2x4 (3292 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: device sdd1 operational as raid disk 1
raid5: device sdc1 operational as raid disk 0
raid5: allocated 3224kB for md0
raid5: raid level 5 set md0 active with 2 out of 3 devices, algorithm 2
RAID5 conf printout:
 --- rd:3 wd:2
 disk 0, o:1, dev:sdc1
 disk 1, o:1, dev:sdd1
RAID5 conf printout:
 --- rd:3 wd:2
 disk 0, o:1, dev:sdc1
 disk 1, o:1, dev:sdd1
 disk 2, o:1, dev:sde1
md: recovery of RAID array md0
md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
md: using maximum available idle IO bandwidth (but not more than 200000 KB/=
sec) for recovery.
md: using 128k window, over a total of 244195904 blocks.
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: cmd 35/00:00:3f:06:00/00:02:00:00:00/e0 tag 0 dma 262144 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata7.00: status: { DRDY }
ata7: hard resetting link
ata5.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata5.00: cmd 25/00:00:3f:08:00/00:04:00:00:00/e0 tag 0 dma 524288 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.00: status: { DRDY }
ata5: hard resetting link
ata6.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata6.00: cmd 25/00:00:3f:08:00/00:04:00:00:00/e0 tag 0 dma 524288 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata6.00: status: { DRDY }
ata6: hard resetting link
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata7.00: qc timeout (cmd 0xec)
ata7.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata7.00: revalidation failed (errno=3D-5)
ata7: failed to recover some devices, retrying in 5 secs
ata5.00: qc timeout (cmd 0xec)
ata5.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata5.00: revalidation failed (errno=3D-5)
ata5: failed to recover some devices, retrying in 5 secs
ata6.00: qc timeout (cmd 0xec)
ata6.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata6.00: revalidation failed (errno=3D-5)
ata6: failed to recover some devices, retrying in 5 secs
ata7: hard resetting link
ata5: hard resetting link
ata6: hard resetting link
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata7.00: qc timeout (cmd 0xec)
ata7.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata7.00: revalidation failed (errno=3D-5)
ata7: failed to recover some devices, retrying in 5 secs
ata5.00: qc timeout (cmd 0xec)
ata5.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata5.00: revalidation failed (errno=3D-5)
ata5: failed to recover some devices, retrying in 5 secs
ata6.00: qc timeout (cmd 0xec)
ata6.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata6.00: revalidation failed (errno=3D-5)
ata6: failed to recover some devices, retrying in 5 secs
ata7: hard resetting link
ata5: hard resetting link
ata6: hard resetting link
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata7.00: qc timeout (cmd 0xec)
ata7.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata7.00: revalidation failed (errno=3D-5)
ata7.00: disabled
ata5.00: qc timeout (cmd 0xec)
ata5.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata5.00: revalidation failed (errno=3D-5)
ata5.00: disabled
ata6.00: qc timeout (cmd 0xec)
ata6.00: failed to IDENTIFY (I/O error, err_mask=3D0x4)
ata6.00: revalidation failed (errno=3D-5)
ata6.00: disabled
ata7: hard resetting link
ata5: hard resetting link
ata6: hard resetting link
ata7: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata7: EH complete
sd 6:0:0:0: [sde] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK,=
SUGGEST_OK
end_request: I/O error, dev sde, sector 1599
raid5: Disk failure on sde1, disabling device. Operation continuing on 2 de=
vices
ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata5: EH complete
sd 4:0:0:0: [sdc] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK,=
SUGGEST_OK
end_request: I/O error, dev sdc, sector 2111
raid5:md0: read error not correctable (sector 2048 on sdc1).
raid5: Disk failure on sdc1, disabling device. Operation continuing on 1 de=
vices
raid5:md0: read error not correctable (sector 2056 on sdc1).
raid5:md0: read error not correctable (sector 2064 on sdc1).
raid5:md0: read error not correctable (sector 2072 on sdc1).
raid5:md0: read error not correctable (sector 2080 on sdc1).
raid5:md0: read error not correctable (sector 2088 on sdc1).
raid5:md0: read error not correctable (sector 2096 on sdc1).
raid5:md0: read error not correctable (sector 2104 on sdc1).
raid5:md0: read error not correctable (sector 2112 on sdc1).
raid5:md0: read error not correctable (sector 2120 on sdc1).
raid5:md0: read error not correctable (sector 2128 on sdc1).
raid5:md0: read error not correctable (sector 2136 on sdc1).
raid5:md0: read error not correctable (sector 2144 on sdc1).
raid5:md0: read error not correctable (sector 2152 on sdc1).
raid5:md0: read error not correctable (sector 2160 on sdc1).
raid5:md0: read error not correctable (sector 2168 on sdc1).
raid5:md0: read error not correctable (sector 2176 on sdc1).
raid5:md0: read error not correctable (sector 2184 on sdc1).
raid5:md0: read error not correctable (sector 2192 on sdc1).
raid5:md0: read error not correctable (sector 2200 on sdc1).
raid5:md0: read error not correctable (sector 2208 on sdc1).
raid5:md0: read error not correctable (sector 2216 on sdc1).
raid5:md0: read error not correctable (sector 2224 on sdc1).
raid5:md0: read error not correctable (sector 2232 on sdc1).
raid5:md0: read error not correctable (sector 2240 on sdc1).
raid5:md0: read error not correctable (sector 2248 on sdc1).
raid5:md0: read error not correctable (sector 2256 on sdc1).
raid5:md0: read error not correctable (sector 2264 on sdc1).
raid5:md0: read error not correctable (sector 2272 on sdc1).
raid5:md0: read error not correctable (sector 2280 on sdc1).
raid5:md0: read error not correctable (sector 2288 on sdc1).
raid5:md0: read error not correctable (sector 2296 on sdc1).
raid5:md0: read error not correctable (sector 2304 on sdc1).
raid5:md0: read error not correctable (sector 2312 on sdc1).
raid5:md0: read error not correctable (sector 2320 on sdc1).
raid5:md0: read error not correctable (sector 2328 on sdc1).
raid5:md0: read error not correctable (sector 2336 on sdc1).
raid5:md0: read error not correctable (sector 2344 on sdc1).
raid5:md0: read error not correctable (sector 2352 on sdc1).
raid5:md0: read error not correctable (sector 2360 on sdc1).
raid5:md0: read error not correctable (sector 2368 on sdc1).
raid5:md0: read error not correctable (sector 2376 on sdc1).
raid5:md0: read error not correctable (sector 2384 on sdc1).
raid5:md0: read error not correctable (sector 2392 on sdc1).
raid5:md0: read error not correctable (sector 2400 on sdc1).
raid5:md0: read error not correctable (sector 2408 on sdc1).
raid5:md0: read error not correctable (sector 2416 on sdc1).
raid5:md0: read error not correctable (sector 2424 on sdc1).
raid5:md0: read error not correctable (sector 2432 on sdc1).
raid5:md0: read error not correctable (sector 2440 on sdc1).
raid5:md0: read error not correctable (sector 2448 on sdc1).
raid5:md0: read error not correctable (sector 2456 on sdc1).
raid5:md0: read error not correctable (sector 2464 on sdc1).
raid5:md0: read error not correctable (sector 2472 on sdc1).
raid5:md0: read error not correctable (sector 2480 on sdc1).
raid5:md0: read error not correctable (sector 2488 on sdc1).
raid5:md0: read error not correctable (sector 2496 on sdc1).
raid5:md0: read error not correctable (sector 2504 on sdc1).
raid5:md0: read error not correctable (sector 2512 on sdc1).
raid5:md0: read error not correctable (sector 2520 on sdc1).
raid5:md0: read error not correctable (sector 2528 on sdc1).
raid5:md0: read error not correctable (sector 2536 on sdc1).
raid5:md0: read error not correctable (sector 2544 on sdc1).
raid5:md0: read error not correctable (sector 2552 on sdc1).
raid5:md0: read error not correctable (sector 2560 on sdc1).
raid5:md0: read error not correctable (sector 2568 on sdc1).
raid5:md0: read error not correctable (sector 2576 on sdc1).
raid5:md0: read error not correctable (sector 2584 on sdc1).
raid5:md0: read error not correctable (sector 2592 on sdc1).
raid5:md0: read error not correctable (sector 2600 on sdc1).
raid5:md0: read error not correctable (sector 2608 on sdc1).
raid5:md0: read error not correctable (sector 2616 on sdc1).
raid5:md0: read error not correctable (sector 2624 on sdc1).
raid5:md0: read error not correctable (sector 2632 on sdc1).
raid5:md0: read error not correctable (sector 2640 on sdc1).
raid5:md0: read error not correctable (sector 2648 on sdc1).
raid5:md0: read error not correctable (sector 2656 on sdc1).
raid5:md0: read error not correctable (sector 2664 on sdc1).
raid5:md0: read error not correctable (sector 2672 on sdc1).
raid5:md0: read error not correctable (sector 2680 on sdc1).
raid5:md0: read error not correctable (sector 2688 on sdc1).
raid5:md0: read error not correctable (sector 2696 on sdc1).
raid5:md0: read error not correctable (sector 2704 on sdc1).
raid5:md0: read error not correctable (sector 2712 on sdc1).
raid5:md0: read error not correctable (sector 2720 on sdc1).
raid5:md0: read error not correctable (sector 2728 on sdc1).
raid5:md0: read error not correctable (sector 2736 on sdc1).
raid5:md0: read error not correctable (sector 2744 on sdc1).
raid5:md0: read error not correctable (sector 2752 on sdc1).
raid5:md0: read error not correctable (sector 2760 on sdc1).
raid5:md0: read error not correctable (sector 2768 on sdc1).
raid5:md0: read error not correctable (sector 2776 on sdc1).
raid5:md0: read error not correctable (sector 2784 on sdc1).
raid5:md0: read error not correctable (sector 2792 on sdc1).
raid5:md0: read error not correctable (sector 2800 on sdc1).
raid5:md0: read error not correctable (sector 2808 on sdc1).
raid5:md0: read error not correctable (sector 2816 on sdc1).
raid5:md0: read error not correctable (sector 2824 on sdc1).
raid5:md0: read error not correctable (sector 2832 on sdc1).
raid5:md0: read error not correctable (sector 2840 on sdc1).
raid5:md0: read error not correctable (sector 2848 on sdc1).
raid5:md0: read error not correctable (sector 2856 on sdc1).
raid5:md0: read error not correctable (sector 2864 on sdc1).
raid5:md0: read error not correctable (sector 2872 on sdc1).
raid5:md0: read error not correctable (sector 2880 on sdc1).
raid5:md0: read error not correctable (sector 2888 on sdc1).
raid5:md0: read error not correctable (sector 2896 on sdc1).
raid5:md0: read error not correctable (sector 2904 on sdc1).
raid5:md0: read error not correctable (sector 2912 on sdc1).
raid5:md0: read error not correctable (sector 2920 on sdc1).
raid5:md0: read error not correctable (sector 2928 on sdc1).
raid5:md0: read error not correctable (sector 2936 on sdc1).
raid5:md0: read error not correctable (sector 2944 on sdc1).
raid5:md0: read error not correctable (sector 2952 on sdc1).
raid5:md0: read error not correctable (sector 2960 on sdc1).
raid5:md0: read error not correctable (sector 2968 on sdc1).
raid5:md0: read error not correctable (sector 2976 on sdc1).
raid5:md0: read error not correctable (sector 2984 on sdc1).
raid5:md0: read error not correctable (sector 2992 on sdc1).
raid5:md0: read error not correctable (sector 3000 on sdc1).
raid5:md0: read error not correctable (sector 3008 on sdc1).
raid5:md0: read error not correctable (sector 3016 on sdc1).
raid5:md0: read error not correctable (sector 3024 on sdc1).
raid5:md0: read error not correctable (sector 3032 on sdc1).
raid5:md0: read error not correctable (sector 3040 on sdc1).
raid5:md0: read error not correctable (sector 3048 on sdc1).
raid5:md0: read error not correctable (sector 3056 on sdc1).
raid5:md0: read error not correctable (sector 3064 on sdc1).
sd 4:0:0:0: [sdc] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK,=
SUGGEST_OK
end_request: I/O error, dev sdc, sector 3135
raid5:md0: read error not correctable (sector 3072 on sdc1).
raid5:md0: read error not correctable (sector 3080 on sdc1).
raid5:md0: read error not correctable (sector 3088 on sdc1).
raid5:md0: read error not correctable (sector 3096 on sdc1).
raid5:md0: read error not correctable (sector 3104 on sdc1).
raid5:md0: read error not correctable (sector 3112 on sdc1).
raid5:md0: read error not correctable (sector 3120 on sdc1).
raid5:md0: read error not correctable (sector 3128 on sdc1).
raid5:md0: read error not correctable (sector 3136 on sdc1).
raid5:md0: read error not correctable (sector 3144 on sdc1).
raid5:md0: read error not correctable (sector 3152 on sdc1).
raid5:md0: read error not correctable (sector 3160 on sdc1).
raid5:md0: read error not correctable (sector 3168 on sdc1).
raid5:md0: read error not correctable (sector 3176 on sdc1).
raid5:md0: read error not correctable (sector 3184 on sdc1).
raid5:md0: read error not correctable (sector 3192 on sdc1).
raid5:md0: read error not correctable (sector 3200 on sdc1).
raid5:md0: read error not correctable (sector 3208 on sdc1).
raid5:md0: read error not correctable (sector 3216 on sdc1).
raid5:md0: read error not correctable (sector 3224 on sdc1).
raid5:md0: read error not correctable (sector 3232 on sdc1).
raid5:md0: read error not correctable (sector 3240 on sdc1).
raid5:md0: read error not correctable (sector 3248 on sdc1).
raid5:md0: read error not correctable (sector 3256 on sdc1).
raid5:md0: read error not correctable (sector 3264 on sdc1).
raid5:md0: read error not correctable (sector 3272 on sdc1).
raid5:md0: read error not correctable (sector 3280 on sdc1).
raid5:md0: read error not correctable (sector 3288 on sdc1).
raid5:md0: read error not correctable (sector 3296 on sdc1).
raid5:md0: read error not correctable (sector 3304 on sdc1).
raid5:md0: read error not correctable (sector 3312 on sdc1).
raid5:md0: read error not correctable (sector 3320 on sdc1).
raid5:md0: read error not correctable (sector 3328 on sdc1).
raid5:md0: read error not correctable (sector 3336 on sdc1).
raid5:md0: read error not correctable (sector 3344 on sdc1).
raid5:md0: read error not correctable (sector 3352 on sdc1).
raid5:md0: read error not correctable (sector 3360 on sdc1).
raid5:md0: read error not correctable (sector 3368 on sdc1).
raid5:md0: read error not correctable (sector 3376 on sdc1).
raid5:md0: read error not correctable (sector 3384 on sdc1).
raid5:md0: read error not correctable (sector 3392 on sdc1).
raid5:md0: read error not correctable (sector 3400 on sdc1).
raid5:md0: read error not correctable (sector 3408 on sdc1).
raid5:md0: read error not correctable (sector 3416 on sdc1).
raid5:md0: read error not correctable (sector 3424 on sdc1).
raid5:md0: read error not correctable (sector 3432 on sdc1).
raid5:md0: read error not correctable (sector 3440 on sdc1).
raid5:md0: read error not correctable (sector 3448 on sdc1).
raid5:md0: read error not correctable (sector 3456 on sdc1).
raid5:md0: read error not correctable (sector 3464 on sdc1).
raid5:md0: read error not correctable (sector 3472 on sdc1).
raid5:md0: read error not correctable (sector 3480 on sdc1).
raid5:md0: read error not correctable (sector 3488 on sdc1).
raid5:md0: read error not correctable (sector 3496 on sdc1).
raid5:md0: read error not correctable (sector 3504 on sdc1).
raid5:md0: read error not correctable (sector 3512 on sdc1).
raid5:md0: read error not correctable (sector 3520 on sdc1).
raid5:md0: read error not correctable (sector 3528 on sdc1).
raid5:md0: read error not correctable (sector 3536 on sdc1).
raid5:md0: read error not correctable (sector 3544 on sdc1).
raid5:md0: read error not correctable (sector 3552 on sdc1).
raid5:md0: read error not correctable (sector 3560 on sdc1).
raid5:md0: read error not correctable (sector 3568 on sdc1).
raid5:md0: read error not correctable (sector 3576 on sdc1).
sd 4:0:0:0: [sdc] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK,=
SUGGEST_OK
end_request: I/O error, dev sdc, sector 63
sd 4:0:0:0: [sdc] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK,=
SUGGEST_OK
end_request: I/O error, dev sdc, sector 488391871
md: super_written gets error=3D-5, uptodate=3D0
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 113)
ata6: EH complete
sd 5:0:0:0: [sdd] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK,=
SUGGEST_OK
end_request: I/O error, dev sdd, sector 2111
raid5:md0: read error not correctable (sector 2048 on sdd1).
raid5: Disk failure on sdd1, disabling device. Operation continuing on 0 de=
vices
raid5:md0: read error not correctable (sector 2056 on sdd1).
raid5:md0: read error not correctable (sector 2064 on sdd1).
raid5:md0: read error not correctable (sector 2072 on sdd1).
raid5:md0: read error not correctable (sector 2080 on sdd1).
raid5:md0: read error not correctable (sector 2088 on sdd1).
raid5:md0: read error not correctable (sector 2096 on sdd1).
raid5:md0: read error not correctable (sector 2104 on sdd1).
raid5:md0: read error not correctable (sector 2112 on sdd1).
raid5:md0: read error not correctable (sector 2120 on sdd1).
raid5:md0: read error not correctable (sector 2128 on sdd1).
raid5:md0: read error not correctable (sector 2136 on sdd1).
raid5:md0: read error not correctable (sector 2144 on sdd1).
raid5:md0: read error not correctable (sector 2152 on sdd1).
raid5:md0: read error not correctable (sector 2160 on sdd1).
raid5:md0: read error not correctable (sector 2168 on sdd1).
raid5:md0: read error not correctable (sector 2176 on sdd1).
raid5:md0: read error not correctable (sector 2184 on sdd1).
raid5:md0: read error not correctable (sector 2192 on sdd1).
raid5:md0: read error not correctable (sector 2200 on sdd1).
raid5:md0: read error not correctable (sector 2208 on sdd1).
raid5:md0: read error not correctable (sector 2216 on sdd1).
raid5:md0: read error not correctable (sector 2224 on sdd1).
raid5:md0: read error not correctable (sector 2232 on sdd1).
raid5:md0: read error not correctable (sector 2240 on sdd1).
raid5:md0: read error not correctable (sector 2248 on sdd1).
raid5:md0: read error not correctable (sector 2256 on sdd1).
raid5:md0: read error not correctable (sector 2264 on sdd1).
raid5:md0: read error not correctable (sector 2272 on sdd1).
raid5:md0: read error not correctable (sector 2280 on sdd1).
raid5:md0: read error not correctable (sector 2288 on sdd1).
raid5:md0: read error not correctable (sector 2296 on sdd1).
raid5:md0: read error not correctable (sector 2304 on sdd1).
raid5:md0: read error not correctable (sector 2312 on sdd1).
raid5:md0: read error not correctable (sector 2320 on sdd1).
raid5:md0: read error not correctable (sector 2328 on sdd1).
raid5:md0: read error not correctable (sector 2336 on sdd1).
raid5:md0: read error not correctable (sector 2344 on sdd1).
raid5:md0: read error not correctable (sector 2352 on sdd1).
raid5:md0: read error not correctable (sector 2360 on sdd1).
raid5:md0: read error not correctable (sector 2368 on sdd1).
raid5:md0: read error not correctable (sector 2376 on sdd1).
raid5:md0: read error not correctable (sector 2384 on sdd1).
raid5:md0: read error not correctable (sector 2392 on sdd1).
raid5:md0: read error not correctable (sector 2400 on sdd1).
raid5:md0: read error not correctable (sector 2408 on sdd1).
raid5:md0: read error not correctable (sector 2416 on sdd1).
raid5:md0: read error not correctable (sector 2424 on sdd1).
raid5:md0: read error not correctable (sector 2432 on sdd1).
raid5:md0: read error not correctable (sector 2440 on sdd1).
raid5:md0: read error not correctable (sector 2448 on sdd1).
raid5:md0: read error not correctable (sector 2456 on sdd1).
raid5:md0: read error not correctable (sector 2464 on sdd1).
raid5:md0: read error not correctable (sector 2472 on sdd1).
raid5:md0: read error not correctable (sector 2480 on sdd1).
raid5:md0: read error not correctable (sector 2488 on sdd1).
raid5:md0: read error not correctable (sector 2496 on sdd1).
raid5:md0: read error not correctable (sector 2504 on sdd1).
raid5:md0: read error not correctable (sector 2512 on sdd1).
raid5:md0: read error not correctable (sector 2520 on sdd1).
raid5:md0: read error not correctable (sector 2528 on sdd1).
raid5:md0: read error not correctable (sector 2536 on sdd1).
raid5:md0: read error not correctable (sector 2544 on sdd1).
raid5:md0: read error not correctable (sector 2552 on sdd1).
raid5:md0: read error not correctable (sector 2560 on sdd1).
raid5:md0: read error not correctable (sector 2568 on sdd1).
raid5:md0: read error not correctable (sector 2576 on sdd1).
raid5:md0: read error not correctable (sector 2584 on sdd1).
raid5:md0: read error not correctable (sector 2592 on sdd1).
raid5:md0: read error not correctable (sector 2600 on sdd1).
raid5:md0: read error not correctable (sector 2608 on sdd1).
raid5:md0: read error not correctable (sector 2616 on sdd1).
raid5:md0: read error not correctable (sector 2624 on sdd1).
raid5:md0: read error not correctable (sector 2632 on sdd1).
raid5:md0: read error not correctable (sector 2640 on sdd1).
raid5:md0: read error not correctable (sector 2648 on sdd1).
raid5:md0: read error not correctable (sector 2656 on sdd1).
raid5:md0: read error not correctable (sector 2664 on sdd1).
raid5:md0: read error not correctable (sector 2672 on sdd1).
raid5:md0: read error not correctable (sector 2680 on sdd1).
raid5:md0: read error not correctable (sector 2688 on sdd1).
raid5:md0: read error not correctable (sector 2696 on sdd1).
raid5:md0: read error not correctable (sector 2704 on sdd1).
raid5:md0: read error not correctable (sector 2712 on sdd1).
raid5:md0: read error not correctable (sector 2720 on sdd1).
raid5:md0: read error not correctable (sector 2728 on sdd1).
raid5:md0: read error not correctable (sector 2736 on sdd1).
raid5:md0: read error not correctable (sector 2744 on sdd1).
raid5:md0: read error not correctable (sector 2752 on sdd1).
raid5:md0: read error not correctable (sector 2760 on sdd1).
raid5:md0: read error not correctable (sector 2768 on sdd1).
raid5:md0: read error not correctable (sector 2776 on sdd1).
raid5:md0: read error not correctable (sector 2784 on sdd1).
raid5:md0: read error not correctable (sector 2792 on sdd1).
raid5:md0: read error not correctable (sector 2800 on sdd1).
raid5:md0: read error not correctable (sector 2808 on sdd1).
raid5:md0: read error not correctable (sector 2816 on sdd1).
raid5:md0: read error not correctable (sector 2824 on sdd1).
raid5:md0: read error not correctable (sector 2832 on sdd1).
raid5:md0: read error not correctable (sector 2840 on sdd1).
raid5:md0: read error not correctable (sector 2848 on sdd1).
raid5:md0: read error not correctable (sector 2856 on sdd1).
raid5:md0: read error not correctable (sector 2864 on sdd1).
raid5:md0: read error not correctable (sector 2872 on sdd1).
raid5:md0: read error not correctable (sector 2880 on sdd1).
raid5:md0: read error not correctable (sector 2888 on sdd1).
raid5:md0: read error not correctable (sector 2896 on sdd1).
raid5:md0: read error not correctable (sector 2904 on sdd1).
raid5:md0: read error not correctable (sector 2912 on sdd1).
raid5:md0: read error not correctable (sector 2920 on sdd1).
raid5:md0: read error not correctable (sector 2928 on sdd1).
raid5:md0: read error not correctable (sector 2936 on sdd1).
raid5:md0: read error not correctable (sector 2944 on sdd1).
raid5:md0: read error not correctable (sector 2952 on sdd1).
raid5:md0: read error not correctable (sector 2960 on sdd1).
raid5:md0: read error not correctable (sector 2968 on sdd1).
raid5:md0: read error not correctable (sector 2976 on sdd1).
raid5:md0: read error not correctable (sector 2984 on sdd1).
raid5:md0: read error not correctable (sector 2992 on sdd1).
raid5:md0: read error not correctable (sector 3000 on sdd1).
raid5:md0: read error not correctable (sector 3008 on sdd1).
raid5:md0: read error not correctable (sector 3016 on sdd1).
raid5:md0: read error not correctable (sector 3024 on sdd1).
raid5:md0: read error not correctable (sector 3032 on sdd1).
raid5:md0: read error not correctable (sector 3040 on sdd1).
raid5:md0: read error not correctable (sector 3048 on sdd1).
raid5:md0: read error not correctable (sector 3056 on sdd1).
raid5:md0: read error not correctable (sector 3064 on sdd1).
sd 5:0:0:0: [sdd] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK,=
SUGGEST_OK
end_request: I/O error, dev sdd, sector 3135
raid5:md0: read error not correctable (sector 3072 on sdd1).
raid5:md0: read error not correctable (sector 3080 on sdd1).
raid5:md0: read error not correctable (sector 3088 on sdd1).
raid5:md0: read error not correctable (sector 3096 on sdd1).
raid5:md0: read error not correctable (sector 3104 on sdd1).
raid5:md0: read error not correctable (sector 3112 on sdd1).
raid5:md0: read error not correctable (sector 3120 on sdd1).
raid5:md0: read error not correctable (sector 3128 on sdd1).
raid5:md0: read error not correctable (sector 3136 on sdd1).
raid5:md0: read error not correctable (sector 3144 on sdd1).
raid5:md0: read error not correctable (sector 3152 on sdd1).
raid5:md0: read error not correctable (sector 3160 on sdd1).
raid5:md0: read error not correctable (sector 3168 on sdd1).
raid5:md0: read error not correctable (sector 3176 on sdd1).
raid5:md0: read error not correctable (sector 3184 on sdd1).
raid5:md0: read error not correctable (sector 3192 on sdd1).
raid5:md0: read error not correctable (sector 3200 on sdd1).
raid5:md0: read error not correctable (sector 3208 on sdd1).
raid5:md0: read error not correctable (sector 3216 on sdd1).
raid5:md0: read error not correctable (sector 3224 on sdd1).
raid5:md0: read error not correctable (sector 3232 on sdd1).
raid5:md0: read error not correctable (sector 3240 on sdd1).
raid5:md0: read error not correctable (sector 3248 on sdd1).
raid5:md0: read error not correctable (sector 3256 on sdd1).
raid5:md0: read error not correctable (sector 3264 on sdd1).
raid5:md0: read error not correctable (sector 3272 on sdd1).
raid5:md0: read error not correctable (sector 3280 on sdd1).
raid5:md0: read error not correctable (sector 3288 on sdd1).
raid5:md0: read error not correctable (sector 3296 on sdd1).
raid5:md0: read error not correctable (sector 3304 on sdd1).
raid5:md0: read error not correctable (sector 3312 on sdd1).
raid5:md0: read error not correctable (sector 3320 on sdd1).
raid5:md0: read error not correctable (sector 3328 on sdd1).
raid5:md0: read error not correctable (sector 3336 on sdd1).
raid5:md0: read error not correctable (sector 3344 on sdd1).
raid5:md0: read error not correctable (sector 3352 on sdd1).
raid5:md0: read error not correctable (sector 3360 on sdd1).
raid5:md0: read error not correctable (sector 3368 on sdd1).
raid5:md0: read error not correctable (sector 3376 on sdd1).
raid5:md0: read error not correctable (sector 3384 on sdd1).
raid5:md0: read error not correctable (sector 3392 on sdd1).
raid5:md0: read error not correctable (sector 3400 on sdd1).
raid5:md0: read error not correctable (sector 3408 on sdd1).
raid5:md0: read error not correctable (sector 3416 on sdd1).
raid5:md0: read error not correctable (sector 3424 on sdd1).
raid5:md0: read error not correctable (sector 3432 on sdd1).
raid5:md0: read error not correctable (sector 3440 on sdd1).
raid5:md0: read error not correctable (sector 3448 on sdd1).
raid5:md0: read error not correctable (sector 3456 on sdd1).
raid5:md0: read error not correctable (sector 3464 on sdd1).
raid5:md0: read error not correctable (sector 3472 on sdd1).
raid5:md0: read error not correctable (sector 3480 on sdd1).
raid5:md0: read error not correctable (sector 3488 on sdd1).
raid5:md0: read error not correctable (sector 3496 on sdd1).
raid5:md0: read error not correctable (sector 3504 on sdd1).
raid5:md0: read error not correctable (sector 3512 on sdd1).
raid5:md0: read error not correctable (sector 3520 on sdd1).
raid5:md0: read error not correctable (sector 3528 on sdd1).
raid5:md0: read error not correctable (sector 3536 on sdd1).
raid5:md0: read error not correctable (sector 3544 on sdd1).
raid5:md0: read error not correctable (sector 3552 on sdd1).
raid5:md0: read error not correctable (sector 3560 on sdd1).
raid5:md0: read error not correctable (sector 3568 on sdd1).
raid5:md0: read error not correctable (sector 3576 on sdd1).
sd 5:0:0:0: [sdd] Result: hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK,=
SUGGEST_OK
end_request: I/O error, dev sdd, sector 488391871
md: super_written gets error=3D-5, uptodate=3D0
md: md0: recovery done.
Buffer I/O error on device md0, logical block 3
Buffer I/O error on device md0, logical block 2
Buffer I/O error on device md0, logical block 1
Buffer I/O error on device md0, logical block 0
RAID5 conf printout:
 --- rd:3 wd:0
 disk 0, o:0, dev:sdc1
 disk 1, o:0, dev:sdd1
 disk 2, o:0, dev:sde1
Buffer I/O error on device md0, logical block 0
RAID5 conf printout:
 --- rd:3 wd:0
 disk 0, o:0, dev:sdc1
 disk 1, o:0, dev:sdd1
RAID5 conf printout:
 --- rd:3 wd:0
 disk 0, o:0, dev:sdc1
 disk 1, o:0, dev:sdd1
RAID5 conf printout:
 --- rd:3 wd:0
 disk 0, o:0, dev:sdc1
RAID5 conf printout:
 --- rd:3 wd:0
 disk 0, o:0, dev:sdc1
RAID5 conf printout:
 --- rd:3 wd:0

--=-y3tW/xKu8Q70983XwYCA
Content-Disposition: attachment; filename=lspci.out
Content-Type: text/plain; name=lspci.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corporation 82975X Memory Controller Hub (rev c0)
00:01.0 PCI bridge: Intel Corporation 82975X PCI Express Root Port (rev c0)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01)
00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 4 (rev 01)
00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 5 (rev 01)
00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express Port 6 (rev 01)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #1 (rev 01)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #2 (rev 01)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #3 (rev 01)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #4 (rev 01)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface Bridge (rev 01)
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller (rev 01)
00:1f.2 RAID bus controller: Intel Corporation 82801GR/GH (ICH7 Family) SATA RAID Controller (rev 01)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
01:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
02:00.0 SATA controller: Marvell Technology Group Ltd. 88SE614x SATA II PCI-E controller (rev 01)
03:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller (rev 20)
04:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E Gigabit Ethernet Controller (rev 20)
06:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)]
06:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]

--=-y3tW/xKu8Q70983XwYCA
Content-Disposition: attachment; filename=mdstat.out
Content-Type: text/plain; name=mdstat.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

Personalities : [raid6] [raid5] [raid4] 
md0 : active raid5 sde1[3](F) sdd1[4](F) sdc1[5](F)
      488391808 blocks level 5, 64k chunk, algorithm 2 [3/0] [___]
      
unused devices: <none>

--=-y3tW/xKu8Q70983XwYCA
Content-Disposition: attachment; filename=uname.out
Content-Type: text/plain; name=uname.out; charset=UTF-8
Content-Transfer-Encoding: 7bit

Linux linux-pc-1 2.6.24.3-12.Marvell_6141.fc8 #1 SMP Sun Mar 9 15:14:01 GMT 2008 x86_64 x86_64 x86_64 GNU/Linux

--=-y3tW/xKu8Q70983XwYCA--

