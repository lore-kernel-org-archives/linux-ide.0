From: =?ISO-8859-1?Q?Lars_Michael_Jogb=E4ck?= <lm@jogback.se>
Subject: Problems with "frozen drives" on sil3124 + sil3726
Date: Sat, 20 Oct 2007 15:19:44 +0200
Message-ID: <471A0070.2080403@jogback.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040504030103000605090009"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.jogback.se ([192.165.82.10]:37130 "EHLO jogback.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754643AbXJTOTv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Oct 2007 10:19:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040504030103000605090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tejun et. al.

I'm running a server with Linux 2.6.18.1+Debian's Xen-patches and the 
sata+pmp-patches from 
http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.18.1-20061020.tar.bz2
Unfortunately I can't upgrade to anything newer than 2.6.18 since there 
is no Xen Dom0-patches that I'm aware of to anything newer.

I have successfully for a long time together, but a couple of weeks ago 
my motherboard gave in, and I installed a new one (along with new 
processor/memory).
I'm running the very same kernel, the same sil3124-controller and the 
same sil3726-PMP-board. The only difference is that instead of a
Supermicro P4SC8 w/ Intel P4 (and PCI-X slot of 66MHz) I'm currently 
using Supermicro PDSME+ w/ E6600 (and PCI-X slot of 133MHz)
The sil3124-controller is an Addonics ADS3GX4R5-E.

The problem is that with the new motherboard I'm getting a lot of 
libata-EH messages indicating that one of the disks are "frozen". The 
messages comes a couple times per hour, but with different disks as the 
"source" of the freeze. It happened with the old motherboard aswell, but 
only once or twice a month.

Oct 12 09:44:58 cleopatra kernel: ata2.02: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 frozen
Oct 12 09:44:58 cleopatra kernel: ata2.02: tag 1 cmd 0x60 Emask 0x4 stat 0x40 err 0x0 (timeout)
Oct 12 09:44:58 cleopatra kernel: ata2.15: hard resetting port
Oct 12 09:45:00 cleopatra kernel: ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 12 09:45:00 cleopatra kernel: ata2.00: hard resetting port
Oct 12 09:45:00 cleopatra kernel: ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 12 09:45:01 cleopatra kernel: ata2.01: hard resetting port
Oct 12 09:45:03 cleopatra kernel: ata2.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 12 09:45:03 cleopatra kernel: ata2.02: hard resetting port
Oct 12 09:45:04 cleopatra kernel: ata2.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 12 09:45:04 cleopatra kernel: ata2.03: hard resetting port
Oct 12 09:45:04 cleopatra kernel: ata2.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 12 09:45:04 cleopatra kernel: ata2.04: hard resetting port
Oct 12 09:45:04 cleopatra kernel: ata2.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 12 09:45:04 cleopatra kernel: ata2.00: configured for UDMA/100
Oct 12 09:45:04 cleopatra kernel: ata2.01: configured for UDMA/100
Oct 12 09:45:04 cleopatra kernel: ata2.02: configured for UDMA/100
Oct 12 09:45:04 cleopatra kernel: ata2.03: configured for UDMA/100
Oct 12 09:45:04 cleopatra kernel: ata2.04: configured for UDMA/100
Oct 12 09:45:04 cleopatra kernel: ata2: EH complete

If I leave going, it slows down the speed of the disks remarkable.

Oct 18 06:45:59 cleopatra kernel: ata2.04: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
Oct 18 06:45:59 cleopatra kernel: ata2.04: tag 3 cmd 0xea Emask 0x4 stat 0x40 err 0x0 (timeout)
Oct 18 06:45:59 cleopatra kernel: ata2.15: hard resetting port
Oct 18 06:46:01 cleopatra kernel: ata2.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 18 06:46:02 cleopatra kernel: ata2.00: hard resetting port
Oct 18 06:46:02 cleopatra kernel: ata2.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 18 06:46:02 cleopatra kernel: ata2.01: hard resetting port
Oct 18 06:46:03 cleopatra kernel: ata2.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 18 06:46:03 cleopatra kernel: ata2.02: hard resetting port
Oct 18 06:46:03 cleopatra kernel: ata2.02: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 18 06:46:03 cleopatra kernel: ata2.03: hard resetting port
Oct 18 06:46:04 cleopatra kernel: ata2.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Oct 18 06:46:04 cleopatra kernel: ata2.04: hard resetting port
Oct 18 06:46:05 cleopatra kernel: ata2.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Oct 18 06:46:05 cleopatra kernel: ata2.00: configured for UDMA/33
Oct 18 06:46:05 cleopatra kernel: ata2.01: configured for UDMA/66
Oct 18 06:46:05 cleopatra kernel: ata2.02: configured for PIO4
Oct 18 06:46:05 cleopatra kernel: ata2.03: configured for UDMA/100
Oct 18 06:46:05 cleopatra kernel: ata2.04: configured for UDMA/100
Oct 18 06:46:05 cleopatra kernel: ata2: EH complete

I've tried to see a pattern of the disks (who all are in the same raid5 
md), but some of the disks seems to affected more often but I can't find 
a pattern.

$ sudo zgrep frozen /var/log/kern.log.?.gz | awk '{ print $6 }' | sort | 
uniq -c
     55 ata1.00:
    170 ata1.01:
      3 ata1.02:
     72 ata1.03:
    137 ata1.04:
    220 ata2.00:
    107 ata2.01:
    152 ata2.02:
    129 ata2.03:
    103 ata2.04:

I've attached the dmesg after a reboot of the server.

If there is anymore information needed to track this problem down, or if 
I should open a case in the kernel bugzilla, please let me know.

Best Regards,
/LM


--------------040504030103000605090009
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

Linux version 2.6.18-4-xen-686 (Debian 2.6.18.dfsg.1-12etch2.0.satapmp) (lm@jogback.se) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #3 SMP Sun Jul 29 00:44:21 CEST 2007
BIOS-provided physical RAM map:
 Xen: 0000000000000000 - 0000000080800000 (usable)
1328MB HIGHMEM available.
727MB LOWMEM available.
NX (Execute Disable) protection: active
On node 0 totalpages: 526336
  DMA zone: 186366 pages, LIFO batch:31
  HighMem zone: 339970 pages, LIFO batch:31
found SMP MP-table at 000f5f30
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f5f00
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0xdfee33eb
ACPI: FADT (v001 INTEL           0x06040000 PTL  0x00000003) @ 0xdfee9e70
ACPI: MCFG (v001 PTLTD    MCFG   0x06040000  LTP 0x00000000) @ 0xdfee9ee4
ACPI: HPET (v001 PTLTD  HPETTBL  0x06040000  LTP 0x00000001) @ 0xdfee9f20
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0xdfee9f58
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0xdfee9fd8
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050228) @ 0xdfee3427
ACPI: DSDT (v001  INTEL GLENWOOD 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfecc0000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfecc0000, GSI 24-47
ACPI: IOAPIC (id[0x04] address[0xfecc0400] gsi_base[48])
IOAPIC[2]: apic_id 4, version 32, address 0xfecc0400, GSI 48-71
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 3 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists.  Total pages: 526336
Kernel command line: root=/dev/md0 ro xencons=tty6
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Xen reported: 2394.010 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Software IO TLB enabled: 
 Aperture:     64 megabytes
 Kernel range: 0x00000000c2496000 - 0x00000000c6496000
vmalloc area: ee000000-f51fe000, maxmem 2d7fe000
Memory: 1993796k/2105344k available (1582k kernel code, 102244k reserved, 586k data, 148k init, 1359880k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 5987.20 BogoMIPS (lpj=11974407)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebd3f1 20100000 00000000 00000000 0000e3bd 00000000 00000001
CPU: After vendor identify, caps: bfebd3f1 20100000 00000000 00000000 0000e3bd 00000000 00000001
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: After all inits, caps: bfebd3f1 20100000 00000000 00000940 0000e3bd 00000000 00000001
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
ENABLING IO-APIC IRQs
SMP alternatives: switching to SMP code
Brought up 2 CPUs
Initializing CPU#1
migration_cost=16
checking if image is initramfs... it is
Freeing initrd memory: 12703k freed
Grant table initialized
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
Setting up standard PCI resources
Allocating PCI resources starting at e1000000 (gap: e0000000:10000000)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: PXH quirk detected, disabling MSI for SHPC device
Boot video device is 0000:14:04.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.DEV1.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.DEV1.PXHB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 10 11 14 15) *7
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
xen_mem: Initialising balloon driver.
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 8 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 9 of bridge 0000:00:1c.0
PCI: Failed to allocate mem resource #9:100000@e1800000 for 0000:01:00.2
PCI: Bridge: 0000:01:00.0
  IO window: 4000-4fff
  MEM window: e0200000-e02fffff
  PREFETCH window: e1000000-e17fffff
PCI: Bridge: 0000:01:00.2
  IO window: 5000-5fff
  MEM window: e0300000-e03fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:01.0
  IO window: 4000-5fff
  MEM window: e0100000-e03fffff
  PREFETCH window: e1000000-e17fffff
PCI: Bridge: 0000:00:1c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: 6000-6fff
  MEM window: e0400000-e04fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
  IO window: 7000-7fff
  MEM window: e0500000-e05fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 8000-8fff
  MEM window: e0600000-e06fffff
  PREFETCH window: e8000000-efffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Setting latency timer of device 0000:01:00.0 to 64
PCI: Setting latency timer of device 0000:01:00.2 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x38 set to 0x80
audit: initializing netlink socket (disabled)
audit(1192881079.660:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
Allocate Port Service[0000:00:1c.5:pcie02]
hpet_acpi_add: no address or irqs in _CRS
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
WARNING: Failed to register Xen virtual console driver as 'tty1'
Event-channel device installed.
PNP: PS/2 Controller [PNP0303:KBC0] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Using IPI No-Shortcut mode
Freeing unused kernel memory: 148k freed
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x2
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x3
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x4
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x5
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x6
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x7
input: AT Translated Set 2 keyboard as /class/input/input0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
SCSI subsystem initialized
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 18, io base 0x00003000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
3ware 9000 Storage Controller device driver for Linux v2.26.02.007.
libata version 2.00 loaded.
Intel(R) PRO/1000 Network Driver - version 7.1.9-k4-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003020
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 20, io base 0x00003040
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003060
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
sata_sil24 0000:03:01.0: version 0.4
ACPI: PCI Interrupt 0000:03:01.0[A] -> GSI 48 (level, low) -> IRQ 21
sata_sil24 0000:03:01.0: Applying completion IRQ loss on PCI-X errata fix
ata_piix 0000:00:1f.1: version 2.00ac7
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: SATA max UDMA/100 cmd 0xEE0E0000 ctl 0x0 bmdma 0x0 irq 21
ata2: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x30A0 irq 14
ata3: SATA max UDMA/100 cmd 0xEE0E2000 ctl 0x0 bmdma 0x0 irq 21
ata4: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x30A8 irq 15
scsi1 : ata_piix
ata5: SATA max UDMA/100 cmd 0xEE0E4000 ctl 0x0 bmdma 0x0 irq 21
ata6: SATA max UDMA/100 cmd 0xEE0E6000 ctl 0x0 bmdma 0x0 irq 21
scsi0 : sata_sil24
ata2.00: ATA-7, max UDMA/133, 160086528 sectors: LBA 
ata2.00: ata2: dev 0 multi count 16
ata2.01: ATA-7, max UDMA/133, 160086528 sectors: LBA 
ata2.01: ata2: dev 1 multi count 16
ata2.00: configured for UDMA/133
ata2.01: configured for UDMA/133
scsi3 : ata_piix
ATA: abnormal status 0x7F on port 0x177
  Vendor: ATA       Model: Maxtor 6L080P0    Rev: BAJ4
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6L080P0    Rev: BAJ4
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
ata1.00: hard resetting port
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.01: hard resetting port
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting port
ata1.02: softreset failed (SRST command error)
ata1.02: follow-up softreset failed, retrying in 5 secs
ata1.02: hard resetting port
ata1.02: hardreset failed (port not ready)
ata1.02: reset failed, giving up
ata1.15: hard resetting port
ata1: controller in dubious state, performing PORT_RST
ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.00: hard resetting port
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.01: hard resetting port
ata1.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: hard resetting port
ata1.02: softreset failed (SRST command error)
ata1.02: follow-up softreset failed, retrying in 5 secs
ata1.02: hard resetting port
ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.03: hard resetting port
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.04: hard resetting port
ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
ata1.01: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata1.01: ata1: dev 0 multi count 0
ata1.01: configured for UDMA/100
ata1.02: ATA-8, max UDMA7, 976773168 sectors: LBA48 NCQ (depth 31/32)
ata1.02: configured for UDMA/100
ata1.03: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata1.03: ata1: dev 0 multi count 0
ata1.03: configured for UDMA/100
ata1.04: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata1.04: ata1: dev 0 multi count 0
ata1.04: configured for UDMA/100
ata1: EH complete
scsi2 : sata_sil24
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 5 ports, feat 0x9/0x9
ata3.00: hard resetting port
ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.01: hard resetting port
ata3.01: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.02: hard resetting port
ata3.02: SATA link down (SStatus 0 SControl 300)
ata3.03: hard resetting port
ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.04: hard resetting port
ata3.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/100
ata3.01: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata3.01: ata3: dev 0 multi count 0
ata3.01: configured for UDMA/100
ata3.03: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata3.03: ata3: dev 0 multi count 0
ata3.03: configured for UDMA/100
ata3.04: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 31/32)
ata3.04: ata3: dev 0 multi count 0
ata3.04: configured for UDMA/100
ata3: EH complete
scsi4 : sata_sil24
ata5: SATA link down (SStatus 0 SControl 300)
scsi5 : sata_sil24
ata6: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD4000KD-55N  Rev: 01.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: SAMSUNG HD501LJ   Rev: CR10
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD4000KD-55N  Rev: 01.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD4000KS-00M  Rev: 07.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD4000KD-00N  Rev: 01.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 1:0:0:0: Attached scsi disk sda
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 160086528 512-byte hdwr sectors (81964 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 1:0:1:0: Attached scsi disk sdb
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 781422768 512-byte hdwr sectors (400088 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1
sd 0:0:0:0: Attached scsi disk sdc
SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 0:0:1:0: Attached scsi disk sdd
SCSI device sde: 976773168 512-byte hdwr sectors (500108 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
SCSI device sde: 976773168 512-byte hdwr sectors (500108 MB)
sde: Write Protect is off
sde: Mode Sense: 00 3a 00 00
SCSI device sde: drive cache: write back
 sde: sde1 sde2
sd 0:0:2:0: Attached scsi disk sde
SCSI device sdf: 781422768 512-byte hdwr sectors (400088 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
SCSI device sdf: 781422768 512-byte hdwr sectors (400088 MB)
sdf: Write Protect is off
sdf: Mode Sense: 00 3a 00 00
SCSI device sdf: drive cache: write back
 sdf: sdf1
sd 0:0:3:0: Attached scsi disk sdf
SCSI device sdg: 781422768 512-byte hdwr sectors (400088 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
SCSI device sdg: 781422768 512-byte hdwr sectors (400088 MB)
sdg: Write Protect is off
sdg: Mode Sense: 00 3a 00 00
SCSI device sdg: drive cache: write back
 sdg: sdg1
sd 0:0:4:0: Attached scsi disk sdg
SCSI device sdh: 781422768 512-byte hdwr sectors (400088 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
SCSI device sdh: 781422768 512-byte hdwr sectors (400088 MB)
sdh: Write Protect is off
sdh: Mode Sense: 00 3a 00 00
SCSI device sdh: drive cache: write back
 sdh: sdh1
sd 2:0:0:0: Attached scsi disk sdh
SCSI device sdi: 781422768 512-byte hdwr sectors (400088 MB)
sdi: Write Protect is off
sdi: Mode Sense: 00 3a 00 00
SCSI device sdi: drive cache: write back
SCSI device sdi: 781422768 512-byte hdwr sectors (400088 MB)
sdi: Write Protect is off
sdi: Mode Sense: 00 3a 00 00
SCSI device sdi: drive cache: write back
 sdi: sdi1
sd 2:0:1:0: Attached scsi disk sdi
SCSI device sdj: 781422768 512-byte hdwr sectors (400088 MB)
sdj: Write Protect is off
sdj: Mode Sense: 00 3a 00 00
SCSI device sdj: drive cache: write back
SCSI device sdj: 781422768 512-byte hdwr sectors (400088 MB)
sdj: Write Protect is off
sdj: Mode Sense: 00 3a 00 00
SCSI device sdj: drive cache: write back
 sdj: sdj1
sd 2:0:3:0: Attached scsi disk sdj
SCSI device sdk: 781422768 512-byte hdwr sectors (400088 MB)
sdk: Write Protect is off
sdk: Mode Sense: 00 3a 00 00
SCSI device sdk: drive cache: write back
SCSI device sdk: 781422768 512-byte hdwr sectors (400088 MB)
sdk: Write Protect is off
sdk: Mode Sense: 00 3a 00 00
SCSI device sdk: drive cache: write back
 sdk: sdk1
sd 2:0:4:0: Attached scsi disk sdk
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
ata7: SATA max UDMA/133 cmd 0xEE02A500 ctl 0x0 bmdma 0x0 irq 19
ata8: SATA max UDMA/133 cmd 0xEE02A580 ctl 0x0 bmdma 0x0 irq 19
ata9: SATA max UDMA/133 cmd 0xEE02A600 ctl 0x0 bmdma 0x0 irq 19
ata10: SATA max UDMA/133 cmd 0xEE02A680 ctl 0x0 bmdma 0x0 irq 19
scsi6 : ahci
ata7: SATA link down (SStatus 0 SControl 300)
scsi7 : ahci
ata8: SATA link down (SStatus 0 SControl 300)
scsi8 : ahci
ata9: SATA link down (SStatus 0 SControl 300)
scsi9 : ahci
ata10: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt 0000:12:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:12:00.0 to 64
e1000: 0000:12:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:8f:59:b6
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:13:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:13:00.0 to 64
e1000: 0000:13:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1) 00:30:48:8f:59:b7
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 18, io mem 0xe0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 22
3w-9xxx: scsi10: AEN: WARNING (0x04:0x0006): Incomplete unit detected:unit=0.
scsi10 : 3ware 9000 Storage Controller
3w-9xxx: scsi10: Found a 3ware 9000 Storage Controller at 0xe0200000, IRQ: 22.
3w-9xxx: scsi10: Firmware FE9X 2.08.00.009, BIOS BE9X 2.03.01.052, Ports: 12.
  Vendor: AMCC      Model: 9500S-12   DISK   Rev: 2.08
  Type:   Direct-Access                      ANSI SCSI revision: 03
sdl : very big device. try to use READ CAPACITY(16).
SCSI device sdl: 6835791872 512-byte hdwr sectors (3499925 MB)
sdl: Write Protect is off
sdl: Mode Sense: 23 00 00 00
SCSI device sdl: drive cache: write back, no read (daft)
sdl : very big device. try to use READ CAPACITY(16).
SCSI device sdl: 6835791872 512-byte hdwr sectors (3499925 MB)
sdl: Write Protect is off
sdl: Mode Sense: 23 00 00 00
SCSI device sdl: drive cache: write back, no read (daft)
 sdl: unknown partition table
sd 10:0:0:0: Attached scsi disk sdl
  Vendor: AMCC      Model: 9500S-12   DISK   Rev: 2.08
  Type:   Direct-Access                      ANSI SCSI revision: 03
SCSI device sdm: 390602752 512-byte hdwr sectors (199989 MB)
sdm: Write Protect is off
sdm: Mode Sense: 23 00 00 00
SCSI device sdm: drive cache: write back, no read (daft)
SCSI device sdm: 390602752 512-byte hdwr sectors (199989 MB)
sdm: Write Protect is off
sdm: Mode Sense: 23 00 00 00
SCSI device sdm: drive cache: write back, no read (daft)
 sdm: unknown partition table
sd 10:0:1:0: Attached scsi disk sdm
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
ide1: I/O resource 0x170-0x177 not free.
ide1: ports already in use, skipping probe
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
md: raid1 personality registered for level 1
md: md0 stopped.
md: bind<sdb1>
md: bind<sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md0: bitmap initialized from disk: read 10/10 pages, set 51 bits, status: 0
created bitmap (146 pages) for device md0
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
ReiserFS: md0: found reiserfs format "3.6" with standard journal
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: Using r5 hash to sort names
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
input: PC Speaker as /class/input/input1
Real Time Clock Driver v1.12ac
intel_rng: FWH not detected
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
i2c /dev entries driver
md: md2 stopped.
md: bind<sdb2>
md: bind<sda2>
raid1: raid set md2 active with 2 out of 2 mirrors
md2: bitmap initialized from disk: read 15/15 pages, set 0 bits, status: 0
created bitmap (239 pages) for device md2
md: md1 stopped.
md: bind<sdc1>
md: bind<sdd1>
md: bind<sdk1>
md: bind<sdf1>
md: bind<sdh1>
md: bind<sdg1>
md: bind<sde1>
md: bind<sdj1>
md: bind<sdi1>
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  2763.000 MB/sec
raid5: using function: pIII_sse (2763.000 MB/sec)
raid6: int32x1    939 MB/s
raid6: int32x2    915 MB/s
raid6: int32x4    786 MB/s
raid6: int32x8    686 MB/s
raid6: mmxx1     2918 MB/s
raid6: mmxx2     3034 MB/s
raid6: sse1x1    1842 MB/s
raid6: sse1x2    2416 MB/s
raid6: sse2x1    3440 MB/s
raid6: sse2x2    3870 MB/s
raid6: using algorithm sse2x2 (3870 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: device sdi1 operational as raid disk 0
raid5: device sdj1 operational as raid disk 9
raid5: device sde1 operational as raid disk 8
raid5: device sdg1 operational as raid disk 7
raid5: device sdh1 operational as raid disk 6
raid5: device sdf1 operational as raid disk 5
raid5: device sdk1 operational as raid disk 3
raid5: device sdd1 operational as raid disk 2
raid5: device sdc1 operational as raid disk 1
raid5: allocated 10450kB for md1
raid5: raid level 5 set md1 active with 9 out of 10 devices, algorithm 2
RAID5 conf printout:
 --- rd:10 wd:9 fd:1
 disk 0, o:1, dev:sdi1
 disk 1, o:1, dev:sdc1
 disk 2, o:1, dev:sdd1
 disk 3, o:1, dev:sdk1
 disk 5, o:1, dev:sdf1
 disk 6, o:1, dev:sdh1
 disk 7, o:1, dev:sdg1
 disk 8, o:1, dev:sde1
 disk 9, o:1, dev:sdj1
ReiserFS: dm-0: found reiserfs format "3.6" with standard journal
ReiserFS: dm-0: using ordered data mode
ReiserFS: dm-0: journal params: device dm-0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-0: checking transaction log (dm-0)
ReiserFS: dm-0: Using r5 hash to sort names
ReiserFS: dm-1: found reiserfs format "3.6" with standard journal
ReiserFS: dm-1: using ordered data mode
ReiserFS: dm-1: journal params: device dm-1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: dm-1: checking transaction log (dm-1)
ReiserFS: dm-1: Using r5 hash to sort names
SGI XFS with ACLs, security attributes, realtime, large block numbers, no debug enabled
SGI XFS Quota Management subsystem
Filesystem "dm-3": Disabling barriers, not supported by the underlying device
XFS mounting filesystem dm-3
Ending clean XFS mount for filesystem: dm-3
Adding 3903672k swap on /dev/md2.  Priority:-1 extents:1 across:3903672k
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver

--------------040504030103000605090009--
