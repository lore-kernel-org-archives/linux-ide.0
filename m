From: Mark Hatle <fray@gate.crashing.org>
Subject: sata_nv failure on 2.4.18 (Fedora Core 6)
Date: Tue, 24 Oct 2006 23:01:11 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0610242257410.21847@gate.crashing.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39051 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422926AbWJYEBQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Oct 2006 00:01:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: benh@kernel.crashing.org, htejun@gmail.com

I was asked to send this here hopefully to help identify and fix this 
issue.

The problem is that the system appears to be running fine.. after many hours
(days?) all of a sudden the sata_nv will get the following error.  When both
drives were on the sata_nv controller, the system would be dead and I couldn't
capture a log.  I got a Silicon Images 3134 card, and put one of the drives on
that, allowing me to capture the log.

When the sata_nv error occurs, raid takes the drive offline, and the system
requires a hard power cycle to reactive the drive.

This has occured 5 times since Saturday.  The first time the system was
up more then 12 hours.. second time about the same.. 3rd, 4th and 5th times
occured within 2 hours of the system starting.

If there is any other information you need let me know!

--Mark

Machine info:

CPU: Core 2 Duo 6300
Mem: 1GB RAM
Board: ECS nForce 570 SLIT-A
Distro: Fedora Core 6 (Zod) for x86_64
Drives: two Maxtor 160GB drives - Maxtor 6G160E0
Other cards:
  * HVD SCSI sym53c8xx
  * Silicon Images 3132 SATA II (no problems, even after sata_nv goes offline)

Linux version 2.6.18-1.2798.fc6 (brewbuilder@hs20-bc1-6.build.redhat.com) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Mon Oct 16 14:39:22 EDT 2006

IDE/Raid failure information:

Oct 24 16:15:59 gate kernel: ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Oct 24 16:15:59 gate kernel: ata1.00: (BMDMA stat 0x24)
Oct 24 16:15:59 gate kernel: ata1.00: tag 0 cmd 0x35 Emask 0x4 stat 0x40 err 0x0 (timeout)
Oct 24 16:16:00 gate kernel: ata1: soft resetting port
Oct 24 16:16:00 gate kernel: ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 24 16:16:30 gate kernel: ata1.00: qc timeout (cmd 0xec)
Oct 24 16:16:30 gate kernel: ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Oct 24 16:16:30 gate kernel: ata1.00: revalidation failed (errno=-5)
Oct 24 16:16:30 gate kernel: ata1: failed to recover some devices, retrying in 5 secs
Oct 24 16:16:35 gate kernel: ata1: hard resetting port
Oct 24 16:16:42 gate kernel: ata1: port is slow to respond, please be patient
Oct 24 16:17:16 gate kernel: ata1: port failed to respond (30 secs)
Oct 24 16:17:17 gate kernel: ata1: COMRESET failed (device not ready)
Oct 24 16:17:17 gate kernel: ata1: hardreset failed, retrying in 5 secs
Oct 24 16:17:17 gate kernel: ata1: hard resetting port
Oct 24 16:17:17 gate kernel: ata1: SRST failed (status 0xFF)
Oct 24 16:17:17 gate kernel: ata1: SRST failed (err_mask=0x100)
Oct 24 16:17:17 gate kernel: ata1: follow-up softreset failed, retrying in 5 secs
Oct 24 16:17:17 gate kernel: ata1: hard resetting port
Oct 24 16:17:17 gate kernel: ata1: SRST failed (status 0xFF)
Oct 24 16:17:17 gate kernel: ata1: SRST failed (err_mask=0x100)
Oct 24 16:17:17 gate kernel: ata1: reset failed, giving up
Oct 24 16:17:17 gate kernel: ata1.00: disabled
Oct 24 16:17:17 gate kernel: ata1: EH complete
Oct 24 16:17:17 gate kernel: sd 0:0:0:0: SCSI error: return code = 0x00040000
Oct 24 16:17:17 gate kernel: end_request: I/O error, dev sda, sector 312576515
Oct 24 16:17:17 gate kernel: raid1: Disk failure on sda6, disabling device. 
Oct 24 16:17:17 gate kernel:    Operation continuing on 1 devices

dmesg:
Bootdata ok (command line is ro root=/dev/md2 rhgb quiet)
Linux version 2.6.18-1.2798.fc6 (brewbuilder@hs20-bc1-6.build.redhat.com) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Mon Oct 16 14:39:22 EDT 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
  BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7970
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff30c0
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff8580
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fff8480
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
No NUMA configuration found
Faking a node at 0000000000000000-000000003fff0000
Bootmem setup node 0 0000000000000000-000000003fff0000
On node 0 totalpages: 256623
   DMA zone: 2622 pages, LIFO batch:0
   DMA32 zone: 254001 pages, LIFO batch:31
Nvidia board detected. Ignoring ACPI timer override.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009e000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 50000000 (gap: 40000000:a0000000)
SMP: Allowing 4 CPUs, 2 hotplug CPUs
Built 1 zonelists.  Total pages: 256623
Kernel command line: ro root=/dev/md2 rhgb quiet
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1866.714 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Checking aperture...
Memory: 1023052k/1048512k available (2409k kernel code, 25068k reserved, 1722k data, 204k init)
Calibrating delay using timer specific routine.. 3736.93 BogoMIPS (lpj=7473870)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 16667085
Detected 16.667 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3733.61 BogoMIPS (lpj=7467221)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 06
Brought up 2 CPUs
testing NMI watchdog ... OK.
sizeof(vma)=176 bytes
sizeof(page)=64 bytes
sizeof(inode)=720 bytes
sizeof(dentry)=232 bytes
sizeof(ext3inode)=968 bytes
sizeof(buffer_head)=96 bytes
sizeof(skbuff)=240 bytes
sizeof(task_struct)=1936 bytes
migration_cost=37
checking if image is initramfs... it is
Freeing initrd memory: 1590k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:10.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI-GART: No AMD northbridge found.
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
pnp: 00:01: ioport range 0x4400-0x447f has been reserved
pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:01: ioport range 0x4800-0x487f has been reserved
pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
PCI: Bridge: 0000:00:02.0
   IO window: d000-dfff
   MEM window: fa000000-fcffffff
   PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:04.0
   IO window: c000-cfff
   MEM window: fdb00000-fdbfffff
   PREFETCH window: fda00000-fdafffff
PCI: Bridge: 0000:00:05.0
   IO window: b000-bfff
   MEM window: fd900000-fd9fffff
   PREFETCH window: fd800000-fd8fffff
PCI: Bridge: 0000:00:06.0
   IO window: 9000-9fff
   MEM window: fd500000-fd5fffff
   PREFETCH window: fde00000-fdefffff
PCI: Bridge: 0000:00:07.0
   IO window: e000-efff
   MEM window: fdd00000-fddfffff
   PREFETCH window: fdc00000-fdcfffff
PCI: Bridge: 0000:00:10.0
   IO window: a000-afff
   MEM window: fd700000-fd7fffff
   PREFETCH window: fd600000-fd6fffff
PCI: Setting latency timer of device 0000:00:02.0 to 64
PCI: Setting latency timer of device 0000:00:04.0 to 64
PCI: Setting latency timer of device 0000:00:05.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
PCI: Setting latency timer of device 0000:00:10.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1161717696.808:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 4D36EEF71C3A3150
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
0000:00:0b.1 EHCI: BIOS handoff failed (BIOS bug ?) 01010001
PCI: Setting latency timer of device 0000:00:02.0 to 64
pcie_portdrv_probe->Dev[007e:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:02.0:pcie00]
Allocate Port Service[0000:00:02.0:pcie03]
PCI: Setting latency timer of device 0000:00:04.0 to 64
pcie_portdrv_probe->Dev[007e:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:04.0:pcie00]
Allocate Port Service[0000:00:04.0:pcie03]
PCI: Setting latency timer of device 0000:00:05.0 to 64
pcie_portdrv_probe->Dev[007e:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:05.0:pcie00]
Allocate Port Service[0000:00:05.0:pcie03]
PCI: Setting latency timer of device 0000:00:06.0 to 64
pcie_portdrv_probe->Dev[007e:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
Allocate Port Service[0000:00:06.0:pcie03]
PCI: Setting latency timer of device 0000:00:07.0 to 64
pcie_portdrv_probe->Dev[007e:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
Allocate Port Service[0000:00:07.0:pcie03]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (on)
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x2
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x3
ACPI: Thermal Zone [THRM] (33 C)
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-MCP51: IDE controller at PCI slot 0000:00:0d.0
NFORCE-MCP51: chipset revision 161
NFORCE-MCP51: not 100% native mode: will probe irqs later
NFORCE-MCP51: 0000:00:0d.0 (rev a1) UDMA133 controller
     ide0: BM-DMA at 0xfd00-0xfd07, BIOS settings: hda:DMA, hdb:DMA
Probing IDE interface ide0...
hda: TSSTcorpCD/DVDW SH-S182M, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 204k freed
Write protecting the kernel read-only data: 462k
USB Universal Host Controller Interface driver v3.0
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 23
GSI 16 sharing vector 0xE1 and IRQ 16
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:0b.0: irq 225, io mem 0xfe02f000
input: AT Translated Set 2 keyboard as /class/input/input0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 22
GSI 17 sharing vector 0xE9 and IRQ 17
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 22 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: irq 233, io mem 0xfe02e000
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
md: raid1 personality registered for level 1
SCSI subsystem initialized
libata version 2.00 loaded.
sata_nv 0000:00:0e.0: version 2.0
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
GSI 18 sharing vector 0x32 and IRQ 18
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 21 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:0e.0 to 64
ata1: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xF800 irq 50
ata2: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xF808 irq 50
scsi0 : sata_nv
ohci_hcd 0000:00:0b.0: wakeup
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 0/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : sata_nv
usb 1-4: new low speed USB device using ohci_hcd and address 2
usb 1-4: configuration #1 chosen from 1 choice
input: Microsoft Basic Optical Mouse as /class/input/input1
input: USB HID v1.10 Mouse [Microsoft Basic Optical Mouse] on usb-0000:00:0b.0-4
ata2: SATA link down (SStatus 0 SControl 300)
ATA: abnormal status 0x7F on port 0x977
   Vendor: ATA       Model: Maxtor 6G160E0    Rev: KA10
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3 sda4 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
md: raid0 personality registered for level 0
sata_sil24 0000:02:00.0: version 0.3
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
GSI 19 sharing vector 0x3A and IRQ 19
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [APC5] -> GSI 16 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:02:00.0 to 64
ata3: SATA max UDMA/100 cmd 0xFFFFC20000020000 ctl 0x0 bmdma 0x0 irq 58
ata4: SATA max UDMA/100 cmd 0xFFFFC20000022000 ctl 0x0 bmdma 0x0 irq 58
scsi2 : sata_sil24
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_sil24
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7, max UDMA/133, 312581808 sectors: LBA48 NCQ (depth 31/32)
ata4.00: ata4: dev 0 multi count 16
ata4.00: configured for UDMA/100
   Vendor: ATA       Model: Maxtor 6G160E0    Rev: KA10
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
sd 3:0:0:0: Attached scsi disk sdb
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
GSI 20 sharing vector 0x42 and IRQ 20
ACPI: PCI Interrupt 0000:06:07.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 66
sym0: <875> rev 0x3 at pci 0000:06:07.0 irq 66
sym0: Symbios NVRAM, ID 7, Fast-20, HVD, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCSI BUS has been reset.
scsi4 : sym-2.2.3
   Vendor: STK       Model: 9714              Rev: 2000
   Type:   Medium Changer                     ANSI SCSI revision: 02
  target4:0:0: Beginning Domain Validation
scsi 4:0:0:0: phase change 6-7 6@3f1b2fa0 resid=4.
  target4:0:0: asynchronous
  target4:0:0: Ending Domain Validation
   Vendor: Quantum   Model: DLT4000           Rev: CD3C
   Type:   Sequential-Access                  ANSI SCSI revision: 02
  target4:0:1: Beginning Domain Validation
  target4:0:1: asynchronous
  target4:0:1: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
  target4:0:1: Domain Validation skipping write tests
  target4:0:1: Ending Domain Validation
   Vendor: Quantum   Model: DLT4000           Rev: CD3C
   Type:   Sequential-Access                  ANSI SCSI revision: 02
  target4:0:2: Beginning Domain Validation
  target4:0:2: asynchronous
  target4:0:2: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
  target4:0:2: Domain Validation skipping write tests
  target4:0:2: Ending Domain Validation
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb5 has different UUID to sdb6
md: sdb3 has different UUID to sdb6
md: sdb2 has different UUID to sdb6
md: sdb1 has different UUID to sdb6
md:  adding sda6 ...
md: sda5 has different UUID to sdb6
md: sda3 has different UUID to sdb6
md: sda2 has different UUID to sdb6
md: sda1 has different UUID to sdb6
md: created md4
md: bind<sda6>
md: bind<sdb6>
md: running: <sdb6><sda6>
md: kicking non-fresh sdb6 from array!
md: unbind<sdb6>
md: export_rdev(sdb6)
raid1: raid set md4 active with 1 out of 2 mirrors
md: considering sdb5 ...
md:  adding sdb5 ...
md: sdb3 has different UUID to sdb5
md: sdb2 has different UUID to sdb5
md: sdb1 has different UUID to sdb5
md:  adding sda5 ...
md: sda3 has different UUID to sdb5
md: sda2 has different UUID to sdb5
md: sda1 has different UUID to sdb5
md: created md3
md: bind<sda5>
md: bind<sdb5>
md: running: <sdb5><sda5>
md3: setting max_sectors to 512, segment boundary to 131071
raid0: looking at sdb5
raid0:   comparing sdb5(2096384) with sdb5(2096384)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sda5
raid0:   comparing sda5(2096384) with sdb5(2096384)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 4192768 blocks.
raid0 : conf->hash_spacing is 4192768 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md: sdb1 has different UUID to sdb3
md:  adding sda3 ...
md: sda2 has different UUID to sdb3
md: sda1 has different UUID to sdb3
md: created md2
md: bind<sda3>
md: bind<sdb3>
md: running: <sdb3><sda3>
md: kicking non-fresh sdb3 from array!
md: unbind<sdb3>
md: export_rdev(sdb3)
raid1: raid set md2 active with 1 out of 2 mirrors
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
md: kicking non-fresh sdb2 from array!
md: unbind<sdb2>
md: export_rdev(sdb2)
raid1: raid set md1 active with 1 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
md: kicking non-fresh sdb1 from array!
md: unbind<sdb1>
md: export_rdev(sdb1)
raid1: raid set md0 active with 1 out of 2 mirrors
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb1 ...
md:  adding sdb1 ...
md: sdb2 has different UUID to sdb1
md: sdb3 has different UUID to sdb1
md: sdb6 has different UUID to sdb1
md: md0 already running, cannot run sdb1
md: export_rdev(sdb1)
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb3 has different UUID to sdb2
md: sdb6 has different UUID to sdb2
md: md1 already running, cannot run sdb2
md: export_rdev(sdb2)
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb6 has different UUID to sdb3
md: md2 already running, cannot run sdb3
md: export_rdev(sdb3)
md: considering sdb6 ...
md:  adding sdb6 ...
md: md4 already running, cannot run sdb6
md: export_rdev(sdb6)
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1161717717.037:2): selinux=0 auid=4294967295
input: PC Speaker as /class/input/input2
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 20
GSI 21 sharing vector 0x4A and IRQ 21
ACPI: PCI Interrupt 0000:00:14.0[A] -> Link [APCH] -> GSI 20 (level, low) -> IRQ 74
PCI: Setting latency timer of device 0000:00:14.0 to 64
forcedeth: using HIGHDMA
hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 3:0:0:0: Attached scsi generic sg1 type 0
scsi 4:0:0:0: Attached scsi generic sg2 type 8
scsi 4:0:1:0: Attached scsi generic sg3 type 1
scsi 4:0:2:0: Attached scsi generic sg4 type 1
st: Version 20050830, fixed bufsize 32768, s/g segs 256
st 4:0:1:0: Attached scsi tape st0
st0: try direct i/o: yes (alignment 512 B)
st 4:0:2:0: Attached scsi tape st1
st1: try direct i/o: yes (alignment 512 B)
eth0: forcedeth.c: subsystem: 01019:2127 bound to 0000:00:14.0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
floppy0: no floppy controllers found
lp: driver loaded but no devices found
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb6 ...
md:  adding sdb6 ...
md: sdb3 has different UUID to sdb6
md: sdb2 has different UUID to sdb6
md: sdb1 has different UUID to sdb6
md: md4 already running, cannot run sdb6
md: export_rdev(sdb6)
md: considering sdb3 ...
md:  adding sdb3 ...
md: sdb2 has different UUID to sdb3
md: sdb1 has different UUID to sdb3
md: md2 already running, cannot run sdb3
md: export_rdev(sdb3)
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md: md1 already running, cannot run sdb2
md: export_rdev(sdb2)
md: considering sdb1 ...
md:  adding sdb1 ...
md: md0 already running, cannot run sdb1
md: export_rdev(sdb1)
md: ... autorun DONE.
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.4 loaded
device-mapper: table: 253:0: linear: dm-linear: Device lookup failed
device-mapper: ioctl: error adding target to table
EXT3 FS on md2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 4192760k swap on /dev/md3.  Priority:-1 extents:1 across:4192760k

lspci -vv:
00:00.0 Host bridge: nVidia Corporation Unknown device 0071 (rev a3)
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Capabilities: [40] HyperTransport: Host or Secondary Interface
 		Command: WarmRst+ DblEnd-
 		Link Control: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0
 		Link Config: MLWI=8bit MLWO=8bit LWI=8bit LWO=8bit
 		Revision ID: 0.16

00:00.1 RAM memory: nVidia Corporation Unknown device 007f (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation Unknown device 0075 (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation Unknown device 006f (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation Unknown device 00b4 (rev a1)
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0

00:01.0 RAM memory: nVidia Corporation Unknown device 0076 (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.1 RAM memory: nVidia Corporation Unknown device 0078 (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.2 RAM memory: nVidia Corporation Unknown device 0079 (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.3 RAM memory: nVidia Corporation Unknown device 007a (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.4 RAM memory: nVidia Corporation Unknown device 007b (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.5 RAM memory: nVidia Corporation Unknown device 007c (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.6 RAM memory: nVidia Corporation Unknown device 007d (rev a1)
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: nVidia Corporation Unknown device 007e (rev a2) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0, Cache Line Size: 32 bytes
 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 	I/O behind bridge: 0000d000-0000dfff
 	Memory behind bridge: fa000000-fcffffff
 	Prefetchable memory behind bridge: 00000000d0000000-00000000dff00000
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
 	Capabilities: [40] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
 		Address: 00000000fee00000  Data: 40b9
 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
 		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
 		Device: Latency L0s <512ns, L1 <4us
 		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
 		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
 		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
 		Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 0
 		Link: Latency L0s <1us, L1 <4us
 		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
 		Link: Speed 2.5Gb/s, Width x8
 		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
 		Slot: Number 1, PowerLimit 0.000000
 		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
 		Slot: AttnInd Unknown, PwrInd Unknown, Power-
 		Root: Correctable- Non-Fatal- Fatal- PME-
 	Capabilities: [100] Virtual Channel

00:04.0 PCI bridge: nVidia Corporation Unknown device 007e (rev a2) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0, Cache Line Size: 32 bytes
 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
 	I/O behind bridge: 0000c000-0000cfff
 	Memory behind bridge: fdb00000-fdbfffff
 	Prefetchable memory behind bridge: 00000000fda00000-00000000fda00000
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
 	Capabilities: [40] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
 		Address: 00000000fee00000  Data: 40c1
 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
 		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
 		Device: Latency L0s <512ns, L1 <4us
 		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
 		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
 		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
 		Link: Supported Speed 2.5Gb/s, Width x8, ASPM L0s, Port 1
 		Link: Latency L0s <1us, L1 <4us
 		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
 		Link: Speed 2.5Gb/s, Width x1
 		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
 		Slot: Number 2, PowerLimit 0.000000
 		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
 		Slot: AttnInd Unknown, PwrInd Unknown, Power-
 		Root: Correctable- Non-Fatal- Fatal- PME-
 	Capabilities: [100] Virtual Channel

00:05.0 PCI bridge: nVidia Corporation Unknown device 007e (rev a2) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0, Cache Line Size: 32 bytes
 	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
 	I/O behind bridge: 0000b000-0000bfff
 	Memory behind bridge: fd900000-fd9fffff
 	Prefetchable memory behind bridge: 00000000fd800000-00000000fd800000
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
 	Capabilities: [40] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
 		Address: 00000000fee00000  Data: 40c9
 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
 		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
 		Device: Latency L0s <512ns, L1 <4us
 		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
 		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
 		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
 		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 2
 		Link: Latency L0s <1us, L1 <4us
 		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
 		Link: Speed 2.5Gb/s, Width x4
 		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
 		Slot: Number 4, PowerLimit 0.000000
 		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
 		Slot: AttnInd Unknown, PwrInd Unknown, Power-
 		Root: Correctable- Non-Fatal- Fatal- PME-
 	Capabilities: [100] Virtual Channel

00:06.0 PCI bridge: nVidia Corporation Unknown device 007e (rev a2) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0, Cache Line Size: 32 bytes
 	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
 	I/O behind bridge: 00009000-00009fff
 	Memory behind bridge: fd500000-fd5fffff
 	Prefetchable memory behind bridge: 00000000fde00000-00000000fde00000
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
 	Capabilities: [40] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
 		Address: 00000000fee00000  Data: 40d1
 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
 		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
 		Device: Latency L0s <512ns, L1 <4us
 		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
 		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
 		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
 		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 3
 		Link: Latency L0s <1us, L1 <4us
 		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
 		Link: Speed 2.5Gb/s, Width x4
 		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
 		Slot: Number 8, PowerLimit 0.000000
 		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
 		Slot: AttnInd Unknown, PwrInd Unknown, Power-
 		Root: Correctable- Non-Fatal- Fatal- PME-
 	Capabilities: [100] Virtual Channel

00:07.0 PCI bridge: nVidia Corporation Unknown device 007e (rev a2) (prog-if 00 [Normal decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0, Cache Line Size: 32 bytes
 	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
 	I/O behind bridge: 0000e000-0000efff
 	Memory behind bridge: fdd00000-fddfffff
 	Prefetchable memory behind bridge: 00000000fdc00000-00000000fdc00000
 	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
 	Capabilities: [40] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
 		Address: 00000000fee00000  Data: 40d9
 	Capabilities: [80] Express Root Port (Slot+) IRQ 0
 		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
 		Device: Latency L0s <512ns, L1 <4us
 		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
 		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
 		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
 		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 4
 		Link: Latency L0s <1us, L1 <4us
 		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
 		Link: Speed 2.5Gb/s, Width x1
 		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- Surpise-
 		Slot: Number 16, PowerLimit 0.000000
 		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
 		Slot: AttnInd Unknown, PwrInd Unknown, Power-
 		Root: Correctable- Non-Fatal- Fatal- PME-
 	Capabilities: [100] Virtual Channel

00:09.0 RAM memory: nVidia Corporation MCP51 Host Bridge (rev a2)
 	Subsystem: Elitegroup Computer Systems Unknown device 2127
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Capabilities: [44] HyperTransport: Slave or Primary Interface
 		Command: BaseUnitID=9 UnitCnt=15 MastHost- DefDir- DUL-
 		Link Control 0: CFlE+ CST- CFE- <LkFail- Init+ EOC- TXO- <CRCErr=0 IsocEn+ LSEn+ ExtCTL- 64b-
 		Link Config 0: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
 		Link Control 1: CFlE- CST- CFE- <LkFail+ Init- EOC+ TXO+ <CRCErr=0 IsocEn- LSEn- ExtCTL- 64b-
 		Link Config 1: MLWI=8bit DwFcIn- MLWO=8bit DwFcOut- LWI=8bit DwFcInEn- LWO=8bit DwFcOutEn-
 		Revision ID: 1.03
 		Link Frequency 0: 800MHz
 		Link Error 0: <Prot- <Ovfl- <EOC- CTLTm-
 		Link Frequency Capability 0: 200MHz+ 300MHz+ 400MHz+ 500MHz+ 600MHz+ 800MHz+ 1.0GHz+ 1.2GHz- 1.4GHz- 1.6GHz- Vend-
 		Feature Capability: IsocFC+ LDTSTOP+ CRCTM- ECTLT- 64bA- UIDRD-
 		Link Frequency 1: 200MHz
 		Link Error 1: <Prot- <Ovfl- <EOC- CTLTm-
 		Link Frequency Capability 1: 200MHz- 300MHz- 400MHz- 500MHz- 600MHz- 800MHz- 1.0GHz- 1.2GHz- 1.4GHz- 1.6GHz- Vend-
 		Error Handling: PFlE+ OFlE+ PFE- OFE- EOCFE- RFE- CRCFE- SERRFE- CF- RE- PNFE- ONFE- EOCNFE- RNFE- CRCNFE- SERRNFE-
 		Prefetchable memory behind bridge Upper: 00-00
 		Bus Number: 00
 	Capabilities: [e0] HyperTransport: MSI Mapping

00:0a.0 ISA bridge: nVidia Corporation MCP51 LPC Bridge (rev a2)
 	Subsystem: Elitegroup Computer Systems Unknown device 2127
 	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0

00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)
 	Subsystem: Elitegroup Computer Systems Unknown device 2127
 	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Interrupt: pin A routed to IRQ 7
 	Region 4: I/O ports at 5000 [size=64]
 	Region 5: I/O ports at 5100 [size=64]
 	Capabilities: [44] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.2 RAM memory: nVidia Corporation MCP51 Memory Controller 0 (rev a2)
 	Subsystem: Elitegroup Computer Systems Unknown device 2127
 	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:0b.0 USB Controller: nVidia Corporation MCP51 USB Controller (rev a2) (prog-if 10 [OHCI])
 	Subsystem: Elitegroup Computer Systems Unknown device 2127
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (750ns min, 250ns max)
 	Interrupt: pin A routed to IRQ 225
 	Region 0: Memory at fe02f000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: [44] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 USB Controller: nVidia Corporation MCP51 USB Controller (rev a2) (prog-if 20 [EHCI])
 	Subsystem: Elitegroup Computer Systems Unknown device 2127
 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (750ns min, 250ns max)
 	Interrupt: pin B routed to IRQ 233
 	Region 0: Memory at fe02e000 (32-bit, non-prefetchable) [size=256]
 	Capabilities: [44] Debug port
 	Capabilities: [80] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 IDE interface: nVidia Corporation MCP51 IDE (rev a1) (prog-if 8a [Master SecP PriP])
 	Subsystem: Elitegroup Computer Systems Unknown device 2127
 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (750ns min, 250ns max)
 	Region 4: I/O ports at fd00 [size=16]
 	Capabilities: [44] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 IDE interface: nVidia Corporation MCP51 Serial ATA Controller (rev a1) (prog-if 85 [Master SecO PriO])
 	Subsystem: Elitegroup Computer Systems Unknown device 2127
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (750ns min, 250ns max)
 	Interrupt: pin A routed to IRQ 50
 	Region 0: I/O ports at 09f0 [size=8]
 	Region 1: I/O ports at 0bf0 [size=4]
 	Region 2: I/O ports at 0970 [size=8]
 	Region 3: I/O ports at 0b70 [size=4]
 	Region 4: I/O ports at f800 [size=16]
 	Region 5: Memory at fe02d000 (32-bit, non-prefetchable) [size=4K]
 	Capabilities: [44] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [b0] Message Signalled Interrupts: 64bit+ Queue=0/2 Enable-
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [cc] HyperTransport: MSI Mapping

00:10.0 PCI bridge: nVidia Corporation MCP51 PCI Bridge (rev a2) (prog-if 01 [Subtractive decode])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0
 	Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
 	I/O behind bridge: 0000a000-0000afff
 	Memory behind bridge: fd700000-fd7fffff
 	Prefetchable memory behind bridge: fd600000-fd6fffff
 	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- <SERR- <PERR-
 	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
 	Capabilities: [b8] #0d [0000]
 	Capabilities: [8c] HyperTransport: MSI Mapping

00:14.0 Bridge: nVidia Corporation MCP51 Ethernet Controller (rev a1)
 	Subsystem: Elitegroup Computer Systems Unknown device 2127
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0 (250ns min, 5000ns max)
 	Interrupt: pin A routed to IRQ 74
 	Region 0: Memory at fe02c000 (32-bit, non-prefetchable) [size=4K]
 	Region 1: I/O ports at f700 [size=8]
 	Capabilities: [44] Power Management version 2
 		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
 		Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation GeForce 7300 GS (rev a1) (prog-if 00 [VGA])
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0, Cache Line Size: 32 bytes
 	Interrupt: pin A routed to IRQ 5
 	Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
 	Region 1: Memory at d0000000 (64-bit, prefetchable) [size=256M]
 	Region 3: Memory at fb000000 (64-bit, non-prefetchable) [size=16M]
 	[virtual] Expansion ROM at fc000000 [disabled] [size=128K]
 	Capabilities: [60] Power Management version 2
 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [78] Express Endpoint IRQ 0
 		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
 		Device: Latency L0s <1us, L1 <4us
 		Device: AtnBtn- AtnInd- PwrInd-
 		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
 		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
 		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
 		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
 		Link: Latency L0s <1us, L1 <4us
 		Link: ASPM Disabled RCB 128 bytes CommClk- ExtSynch-
 		Link: Speed 2.5Gb/s, Width x8
 	Capabilities: [100] Virtual Channel
 	Capabilities: [128] Power Budgeting

02:00.0 RAID bus controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
 	Subsystem: Silicon Image, Inc. Unknown device 7132
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 0, Cache Line Size: 32 bytes
 	Interrupt: pin A routed to IRQ 58
 	Region 0: Memory at fdbff000 (64-bit, non-prefetchable) [size=128]
 	Region 2: Memory at fdbf8000 (64-bit, non-prefetchable) [size=16K]
 	Region 4: I/O ports at cf00 [size=128]
 	[virtual] Expansion ROM at fda00000 [disabled] [size=512K]
 	Capabilities: [54] Power Management version 2
 		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
 		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
 	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
 		Address: 0000000000000000  Data: 0000
 	Capabilities: [70] Express Legacy Endpoint IRQ 0
 		Device: Supported: MaxPayload 1024 bytes, PhantFunc 0, ExtTag-
 		Device: Latency L0s <64ns, L1 <1us
 		Device: AtnBtn- AtnInd- PwrInd-
 		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
 		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
 		Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
 		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
 		Link: Latency L0s unlimited, L1 unlimited
 		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
 		Link: Speed 2.5Gb/s, Width x1
 	Capabilities: [100] Advanced Error Reporting

06:07.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 03)
 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
 	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 	Latency: 144 (4250ns min, 16000ns max), Cache Line Size: 32 bytes
 	Interrupt: pin A routed to IRQ 66
 	Region 0: I/O ports at ae00 [size=256]
 	Region 1: Memory at fd7ff000 (32-bit, non-prefetchable) [size=256]
 	Region 2: Memory at fd7fe000 (32-bit, non-prefetchable) [size=4K]
 	[virtual] Expansion ROM at fd600000 [disabled] [size=64K]

/proc/modules:
autofs4 58441 2 - Live 0xffffffff8838b000
it87 58853 0 - Live 0xffffffff8837b000
hwmon_vid 35905 1 it87, Live 0xffffffff88371000
hwmon 36809 1 it87, Live 0xffffffff88367000
eeprom 41297 0 - Live 0xffffffff8835b000
i2c_isa 39489 1 it87, Live 0xffffffff88350000
sunrpc 211465 1 - Live 0xffffffff8831b000
ipv6 427553 75 - Live 0xffffffff882b1000
dm_mirror 64449 0 - Live 0xffffffff882a0000
dm_multipath 53713 0 - Live 0xffffffff88291000
dm_mod 99857 3 dm_mirror,dm_multipath, Live 0xffffffff88277000
video 53065 0 - Live 0xffffffff88269000
sbs 51473 0 - Live 0xffffffff8825b000
i2c_ec 38977 1 sbs, Live 0xffffffff88250000
button 41057 0 - Live 0xffffffff88244000
battery 44489 0 - Live 0xffffffff88238000
asus_acpi 51941 0 - Live 0xffffffff8822a000
ac 39113 0 - Live 0xffffffff8821f000
parport_pc 64233 0 - Live 0xffffffff8820e000
lp 48529 0 - Live 0xffffffff88201000
parport 77133 2 parport_pc,lp, Live 0xffffffff881ed000
st 74853 0 - Live 0xffffffff881d9000
sg 72169 0 - Live 0xffffffff881c6000
shpchp 73609 0 - Live 0xffffffff881b1000
ide_cd 76256 2 - Live 0xffffffff8819d000
cdrom 70377 1 ide_cd, Live 0xffffffff8818a000
forcedeth 77637 0 - Live 0xffffffff88174000
serio_raw 41156 0 - Live 0xffffffff88168000
i2c_nforce2 41537 0 - Live 0xffffffff8815c000
i2c_core 58177 5 it87,eeprom,i2c_isa,i2c_ec,i2c_nforce2, Live 0xffffffff8814c000
pcspkr 36673 0 - Live 0xffffffff88142000
sym53c8xx 112233 0 - Live 0xffffffff88125000
scsi_transport_spi 62529 1 sym53c8xx, Live 0xffffffff88114000
sata_sil24 50245 5 - Live 0xffffffff88106000
raid0 40897 1 - Live 0xffffffff880fb000
sata_nv 46533 5 - Live 0xffffffff880ee000
libata 143849 2 sata_sil24,sata_nv, Live 0xffffffff880c9000
sd_mod 55745 36 - Live 0xffffffff880ba000
scsi_mod 191633 6 st,sg,sym53c8xx,scsi_transport_spi,libata,sd_mod, Live 0xffffffff8808a000
raid1 57921 4 - Live 0xffffffff8807a000
ext3 177873 4 - Live 0xffffffff8804d000
jbd 100273 1 ext3, Live 0xffffffff88033000
ehci_hcd 68301 0 - Live 0xffffffff88021000
ohci_hcd 56541 0 - Live 0xffffffff88012000
uhci_hcd 59865 0 - Live 0xffffffff88002000

