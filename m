From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: 2.6.24-rc & SB600 AHCI no go on >=4GB of RAM
Date: Tue, 13 Nov 2007 11:06:21 +1100 (EST)
Message-ID: <586940.45572.qm@web52611.mail.re2.yahoo.com>
References: <4733DB64.1090803@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2091919712-1194912381=:45572"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52611.mail.re2.yahoo.com ([206.190.48.214]:39428 "HELO
	web52611.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752232AbXKMAGX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 19:06:23 -0500
In-Reply-To: <4733DB64.1090803@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

--0-2091919712-1194912381=:45572
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tejun Heo <htejun@gmail.com> wrote:
> [...] Please post boot log.

Both the working (with mem= option) & a panicking ones attached.

Actually as you've pointed out, it may have nothing to do with ahci or sb600
as such, just that they helped in exposing the problem.

Because it started working with mem=3500M, I jumped to conclusions (as usual).

Thanks

PS: On the tip of http://www.kernel.org/hg/linux-2.6



      Feel safe with award winning spam protection on Yahoo!7 Mail.  
www.yahoo.com.au/mail 

--0-2091919712-1194912381=:45572
Content-Type: text/plain; name="2.4.24-rc2-panicky.txt"
Content-Description: 2522339933-2.4.24-rc2-panicky.txt
Content-Disposition: inline; filename="2.4.24-rc2-panicky.txt"

Linux version 2.6.24-rc2 (hari@desktop.localdomain) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-33)) #2 SMP Mon Nov 12 21:43:43 EST 2007
Command line: ro root=LABEL=/ 1 console=ttyS0,115200 console=tty0
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfee0000 (usable)
 BIOS-e820: 00000000dfee0000 - 00000000dfee3000 (ACPI NVS)
 BIOS-e820: 00000000dfee3000 - 00000000dfef0000 (ACPI data)
 BIOS-e820: 00000000dfef0000 - 00000000dff00000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
end_pfn_map = 1179648
DMI 2.4 present.
ACPI: RSDP 000F8130, 0024 (r2 ATI   )
ACPI: XSDT DFEE3100, 004C (r1 ATI    ASUSACPI 42302E31 AWRD        0)
ACPI: FACP DFEE8400, 00F4 (r3 ATI    ASUSACPI 42302E31 AWRD        0)
ACPI: DSDT DFEE3280, 5136 (r1 ATI    ASUSACPI     1000 MSFT  3000000)
ACPI: FACS DFEE0000, 0040
ACPI: SSDT DFEE8600, 02CC (r1 PTLTD  POWERNOW        1  LTP        1)
ACPI: HPET DFEE8940, 0038 (r1 ATI    ASUSACPI 42302E31 AWRD       98)
ACPI: MCFG DFEE89C0, 003C (r1 ATI    ASUSACPI 42302E31 AWRD        0)
ACPI: APIC DFEE8540, 0068 (r1 ATI    ASUSACPI 42302E31 AWRD        0)
Scanning NUMA topology in Northbridge 24
CPU has 2 num_cores
No NUMA configuration found
Faking a node at 0000000000000000-0000000120000000
Bootmem setup node 0 0000000000000000-0000000120000000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1179648
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0:        0 ->      159
    0:      256 ->   917216
    0:  1048576 ->  1179648
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x4008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Setting APIC routing to flat
ACPI: HPET id: 0x8200 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f1000000 (gap: f0000000:ec00000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 32848 bytes of per cpu data
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1030061
Policy zone: Normal
Kernel command line: ro root=LABEL=/ 1 console=ttyS0,115200 console=tty0
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
TSC calibrated against PM_TIMER
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 2799.907 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
console [ttyS0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1648 kB
 per task-struct memory footprint: 1680 bytes
Memory: 4121532k/4718592k available (2141k kernel code, 71232k reserved, 1270k data, 292k init)
SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 5604.93 BogoMIPS (lpj=11209872)
Security Framework initialized
SELinux:  Initializing.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys cpuacct
Initializing cgroup subsys ns
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
lockdep: not fixing up alternatives.
ACPI: Core revision 20070126
Using local APIC timer interrupts.
Detected 12.499 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5599.85 BogoMIPS (lpj=11199711)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 5600+ stepping 03
Brought up 2 CPUs
net_namespace: 144 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
DMAR:No DMAR devices found
ACPI: RTC can wake from S4
system 00:01: ioport range 0x4100-0x411f has been reserved
system 00:01: ioport range 0x228-0x22f has been reserved
system 00:01: ioport range 0x40b-0x40b has been reserved
system 00:01: ioport range 0x4d6-0x4d6 has been reserved
system 00:01: ioport range 0xc00-0xc01 has been reserved
system 00:01: ioport range 0xc14-0xc14 has been reserved
system 00:01: ioport range 0xc50-0xc52 has been reserved
system 00:01: ioport range 0xc6c-0xc6d has been reserved
system 00:0a: iomem range 0xe0000000-0xefffffff could not be reserved
system 00:0b: iomem range 0xf0000-0xf3fff could not be reserved
system 00:0b: iomem range 0xf4000-0xf7fff could not be reserved
system 00:0b: iomem range 0xf8000-0xfbfff could not be reserved
system 00:0b: iomem range 0xfc000-0xfffff could not be reserved
PCI: Bridge: 0000:00:02.0
Time: acpi_pm clocksource has been installed.
  IO window: d000-dfff
  MEM window: fdc00000-fdcfffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:07.0
  IO window: e000-efff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: fdf00000-fdffffff
PCI: Bridge: 0000:00:14.4
  IO window: c000-cfff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3213k freed
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1194892706.940:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler cfq registered (default)
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
hpet_acpi_add: no address or irqs in _CRS
Non-volatile memory driver v1.2
Linux agpgart interface v0.102
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
ÿserial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
usbcore: registered new interface driver libusual
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
Freeing unused kernel memory: 292k freed
ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xfe029000
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfe02e000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 17, io mem 0xfe02d000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.2: irq 18, io mem 0xfe02c000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.3: irq 17, io mem 0xfe02b000
usb 3-2: new low speed USB device using ohci_hcd and address 2
nommu_map_single: overflow 102447f68+8 of device mask ffffffff
nommu_map_single: overflow 1025100c0+64 of device mask ffffffff
nommu_map_single: overflow 1006950c0+8 of device mask ffffffff
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
nommu_map_single: overflow 1025100c0+64 of device mask ffffffff
nommu_map_single: overflow 1006950c0+8 of device mask ffffffff
nommu_map_single: overflow 1025100c0+64 of device mask ffffffff
ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 6
ohci_hcd 0000:00:13.4: irq 18, io mem 0xfe02a000
usb 3-2: device descriptor read/64, error -32
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
nommu_map_single: overflow 1006950c0+8 of device mask ffffffff
nommu_map_single: overflow 101973f40+64 of device mask ffffffff
nommu_map_single: overflow 1006950c0+8 of device mask ffffffff
nommu_map_single: overflow 101973f40+64 of device mask ffffffff
nommu_map_single: overflow 1006950c0+8 of device mask ffffffff
nommu_map_single: overflow 101973f40+64 of device mask ffffffff
USB Universal Host Controller Interface driver v3.0
SCSI subsystem initialized
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
usb 3-2: device descriptor read/64, error -32
usb 3-2: new low speed USB device using ohci_hcd and address 3
nommu_map_single: overflow 100695490+8 of device mask ffffffff
nommu_map_single: overflow 101973540+64 of device mask ffffffff
nommu_map_single: overflow 100695490+8 of device mask ffffffff
nommu_map_single: overflow 101973540+64 of device mask ffffffff
nommu_map_single: overflow 100695490+8 of device mask ffffffff
nommu_map_single: overflow 101973540+64 of device mask ffffffff
usb 3-2: device descriptor read/64, error -32
nommu_map_single: overflow 100695490+8 of device mask ffffffff
nommu_map_single: overflow 101973540+64 of device mask ffffffff
nommu_map_single: overflow 100695490+8 of device mask ffffffff
nommu_map_single: overflow 101973540+64 of device mask ffffffff
nommu_map_single: overflow 100695490+8 of device mask ffffffff
nommu_map_single: overflow 101973540+64 of device mask ffffffff
usb 3-2: device descriptor read/64, error -32
usb 3-2: new low speed USB device using ohci_hcd and address 4
nommu_map_single: overflow 100695490+8 of device mask ffffffff
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 22
ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 22
ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 22
ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 22
nommu_map_single: overflow 100695530+8 of device mask ffffffff
usb 3-2: device not accepting address 4, error -32
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
nommu_map_sg: overflow 10277645c+512 of device mask ffffffff
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
usb 3-2: new low speed USB device using ohci_hcd and address 5
nommu_map_single: overflow 100695530+8 of device mask ffffffff
nommu_map_single: overflow 100695530+8 of device mask ffffffff
usb 3-2: device not accepting address 5, error -32
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
nommu_map_sg: overflow 10277645c+512 of device mask ffffffff
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
nommu_map_sg: overflow 10277645c+512 of device mask ffffffff
ata1.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
nommu_map_sg: overflow 10277a45c+512 of device mask ffffffff
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata2: failed to recover some devices, retrying in 5 secs
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
nommu_map_sg: overflow 10277a45c+512 of device mask ffffffff
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata2: failed to recover some devices, retrying in 5 secs
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
nommu_map_sg: overflow 10277a45c+512 of device mask ffffffff
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata2: failed to recover some devices, retrying in 5 secs
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
nommu_map_sg: overflow 10277e45c+512 of device mask ffffffff
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3: failed to recover some devices, retrying in 5 secs
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
nommu_map_sg: overflow 10277e45c+512 of device mask ffffffff
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3: failed to recover some devices, retrying in 5 secs
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
nommu_map_sg: overflow 10277e45c+512 of device mask ffffffff
ata3.00: failed to IDENTIFY (I/O error, err_mask=0x40)
ata3: failed to recover some devices, retrying in 5 secs
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
scsi4 : pata_atiixp
scsi5 : pata_atiixp
ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf900 irq 14
ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf908 irq 15
Kernel panic - not syncing: Attempted to kill init!

--0-2091919712-1194912381=:45572
Content-Type: text/plain; name="2.4.24-rc2-working.txt"
Content-Description: 4258848532-2.4.24-rc2-working.txt
Content-Disposition: inline; filename="2.4.24-rc2-working.txt"

Linux version 2.6.24-rc2 (hari@desktop.localdomain) (gcc version 4.1.2 20070925 (Red Hat 4.1.2-33)) #2 SMP Mon Nov 12 21:43:43 EST 2007
Command line: ro root=LABEL=/ 1 console=ttyS0,115200 console=tty0 mem=3500M
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000dfee0000 (usable)
 BIOS-e820: 00000000dfee0000 - 00000000dfee3000 (ACPI NVS)
 BIOS-e820: 00000000dfee3000 - 00000000dfef0000 (ACPI data)
 BIOS-e820: 00000000dfef0000 - 00000000dff00000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
end_pfn_map = 1048576
DMI 2.4 present.
ACPI: RSDP 000F8130, 0024 (r2 ATI   )
ACPI: XSDT DFEE3100, 004C (r1 ATI    ASUSACPI 42302E31 AWRD        0)
ACPI: FACP DFEE8400, 00F4 (r3 ATI    ASUSACPI 42302E31 AWRD        0)
ACPI: DSDT DFEE3280, 5136 (r1 ATI    ASUSACPI     1000 MSFT  3000000)
ACPI: FACS DFEE0000, 0040
ACPI: SSDT DFEE8600, 02CC (r1 PTLTD  POWERNOW        1  LTP        1)
ACPI: HPET DFEE8940, 0038 (r1 ATI    ASUSACPI 42302E31 AWRD       98)
ACPI: MCFG DFEE89C0, 003C (r1 ATI    ASUSACPI 42302E31 AWRD        0)
ACPI: APIC DFEE8540, 0068 (r1 ATI    ASUSACPI 42302E31 AWRD        0)
Scanning NUMA topology in Northbridge 24
CPU has 2 num_cores
No NUMA configuration found
Faking a node at 0000000000000000-00000000dac00000
Bootmem setup node 0 0000000000000000-00000000dac00000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   896000
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x4008
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Setting APIC routing to flat
ACPI: HPET id: 0x8200 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f1000000 (gap: f0000000:ec00000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 32848 bytes of per cpu data
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 881652
Policy zone: DMA32
Kernel command line: ro root=LABEL=/ 1 console=ttyS0,115200 console=tty0 mem=3500M
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
TSC calibrated against PM_TIMER
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 2799.889 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
console [ttyS0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1648 kB
 per task-struct memory footprint: 1680 bytes
Memory: 3520624k/3584000k available (2141k kernel code, 62988k reserved, 1270k data, 292k init)
SLUB: Genslabs=12, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Calibrating delay using timer specific routine.. 5604.92 BogoMIPS (lpj=11209850)
Security Framework initialized
SELinux:  Initializing.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys cpuacct
Initializing cgroup subsys ns
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
lockdep: not fixing up alternatives.
ACPI: Core revision 20070126
Using local APIC timer interrupts.
Detected 12.499 MHz APIC timer.
lockdep: not fixing up alternatives.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 5599.86 BogoMIPS (lpj=11199733)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 5600+ stepping 03
Brought up 2 CPUs
net_namespace: 144 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 10 11) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
DMAR:No DMAR devices found
ACPI: RTC can wake from S4
system 00:01: ioport range 0x4100-0x411f has been reserved
system 00:01: ioport range 0x228-0x22f has been reserved
system 00:01: ioport range 0x40b-0x40b has been reserved
system 00:01: ioport range 0x4d6-0x4d6 has been reserved
system 00:01: ioport range 0xc00-0xc01 has been reserved
system 00:01: ioport range 0xc14-0xc14 has been reserved
system 00:01: ioport range 0xc50-0xc52 has been reserved
system 00:01: ioport range 0xc6c-0xc6d has been reserved
system 00:0a: iomem range 0xe0000000-0xefffffff could not be reserved
system 00:0b: iomem range 0xf0000-0xf3fff could not be reserved
system 00:0b: iomem range 0xf4000-0xf7fff could not be reserved
system 00:0b: iomem range 0xf8000-0xfbfff could not be reserved
system 00:0b: iomem range 0xfc000-0xfffff could not be reserved
PCI: Bridge: 0000:00:02.0
Time: acpi_pm clocksource has been installed.
  IO window: d000-dfff
  MEM window: fdc00000-fdcfffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:07.0
  IO window: e000-efff
  MEM window: fdb00000-fdbfffff
  PREFETCH window: fdf00000-fdffffff
PCI: Bridge: 0000:00:14.4
  IO window: c000-cfff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 9, 3670016 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3213k freed
Initializing RT-Tester: OK
audit: initializing netlink socket (disabled)
audit(1194892992.932:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler cfq registered (default)
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
hpet_acpi_add: no address or irqs in _CRS
Non-volatile memory driver v1.2
Linux agpgart interface v0.102
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing enabled
ÿserial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
usbcore: registered new interface driver libusual
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
Freeing unused kernel memory: 292k freed
ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xfe029000
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfe02e000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.1: irq 17, io mem 0xfe02d000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.2: irq 18, io mem 0xfe02c000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.3: irq 17, io mem 0xfe02b000
usb 3-2: new low speed USB device using ohci_hcd and address 2
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 6
ohci_hcd 0000:00:13.4: irq 18, io mem 0xfe02a000
usb 3-2: configuration #1 chosen from 1 choice
input: Logitech USB Receiver as /class/input/input0
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:13.1-2
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
Fixing up Logitech keyboard report descriptor
hub 6-0:1.0: 2 ports detected
input: Logitech USB Receiver as /class/input/input1
input,hiddev96: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:13.1-2
USB Universal Host Controller Interface driver v3.0
SCSI subsystem initialized
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part 
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 22
ata2: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 22
ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 22
ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 22
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: ST3250620NS, 3.AEG, max UDMA/133
ata1.00: 488397168 sectors, multi 1: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI: ASUS    DRW-1814BLT, 1.04, max UDMA/66, ATAPI AN
ata2.00: configured for UDMA/66
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.00: ATA-7: ST3250620NS, 3.AEG, max UDMA/133
ata3.00: 488397168 sectors, multi 1: LBA48 NCQ (depth 31/32)
ata3.00: configured for UDMA/133
ata4: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      ST3250620NS      3.AE PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: CD-ROM            ASUS     DRW-1814BLT      1.04 PQ: 0 ANSI: 5
scsi 2:0:0:0: Direct-Access     ATA      ST3250620NS      3.AE PQ: 0 ANSI: 5
sd 2:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 2:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3 sdb4
sd 2:0:0:0: [sdb] Attached SCSI disk
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
scsi4 : pata_atiixp
scsi5 : pata_atiixp
ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf900 irq 14
ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf908 irq 15
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1194893004.409:2): enforcing=1 old_enforcing=0 auid=4294967295
SELinux: policy loaded with handle_unknown=allow
audit(1194893004.657:3): policy loaded auid=4294967295

--0-2091919712-1194912381=:45572--
