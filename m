From: the4hoffmans@earthlink.net
Subject: Re: Issue with AHCI driver
Date: Tue, 5 Aug 2008 17:28:30 -0400 (EDT)
Message-ID: <12918703.1217971710650.JavaMail.root@mswamui-bichon.atl.sa.earthlink.net>
Reply-To: the4hoffmans@earthlink.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary=---------------------------113371545712287
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:45710 "EHLO
	elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756186AbYHEV2l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Aug 2008 17:28:41 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com

-----------------------------113371545712287
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Here's a file with more data...

-----Original Message-----
>From: Tejun Heo <tj@kernel.org>
>Sent: Aug 4, 2008 7:10 PM
>To: the4hoffmans@earthlink.net
>Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, blward@micron.com
>Subject: Re: Issue with AHCI driver
>
>the4hoffmans@earthlink.net wrote:
>> Jeff,
>> 
>> I changed line 53 of libata.h from "#undef ATA_DEBUG" to "#define
>> ATA_DEBUG" and we got a bunch of compiler errors.  Was that not what
>> you wanted?  Should I change ATA_VERBOSE_DEBUG instead?
>
>Can you post boot log w/o ATA_DEBUG?  And the result of lspci -nnvvv?
>
>-- 
>tejun

-----------------------------113371545712287
Content-Disposition: attachment; filename="dmesg.output"
Content-Type: application/octet-stream; name=dmesg.output
Content-Transfer-Encoding: 7bit

Linux version 2.6.19-0R7 (testuser@mdc204t1-lnx) (gcc version 4.1.2 20071124 (Red Hat 4.1.2-42)) #1 SMP Wed Aug 6 15:23:15 CDT 2008
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff80000 (usable)
 BIOS-e820: 000000007ff80000 - 000000007ff8e000 (ACPI data)
 BIOS-e820: 000000007ff8e000 - 000000007ffe0000 (ACPI NVS)
 BIOS-e820: 000000007ffe0000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Entering add_active_range(0, 0, 524160) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   524160
early_node_map[1] active PFN ranges
    0:        0 ->   524160
On node 0 totalpages: 524160
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2303 pages used for memmap
  HighMem zone: 292481 pages, LIFO batch:31
DMI 2.4 present.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000fbb80
ACPI: RSDT (v001 A_M_I_ OEMRSDT  0x12000710 MSFT 0x00000097) @ 0x7ff80000
ACPI: FADT (v002 A_M_I_ OEMFACP  0x12000710 MSFT 0x00000097) @ 0x7ff80200
ACPI: MADT (v001 A_M_I_ OEMAPIC  0x12000710 MSFT 0x00000097) @ 0x7ff80390
ACPI: MCFG (v001 A_M_I_ OEMMCFG  0x12000710 MSFT 0x00000097) @ 0x7ff80400
ACPI: OEMB (v001 A_M_I_ AMI_OEM  0x12000710 MSFT 0x00000097) @ 0x7ff8e040
ACPI: HPET (v001 A_M_I_ OEMHPET  0x12000710 MSFT 0x00000097) @ 0x7ff89690
ACPI: OSFR (v001 A_M_I_ OEMOSFR  0x12000710 MSFT 0x00000097) @ 0x7ff896d0
ACPI: DSDT (v001  A0812 A0812001 0x00000001 INTL 0x20060113) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ee00000)
Detected 2333.356 MHz processor.
Built 1 zonelists.  Total pages: 520065
Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2071652k/2096640k available (2000k kernel code, 23700k reserved, 701k data, 236k init, 1179136k highmem)
virtual kernel memory layout:
    fixmap  : 0xffc57000 - 0xfffff000   (3744 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc12a9000 - 0xc12e4000   ( 236 kB)
      .data : 0xc11f4184 - 0xc12a36f4   ( 701 kB)
      .text : 0xc1000000 - 0xc11f4184   (2000 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
hpet0: 4 64-bit timers, 14318180 Hz
Using HPET for base-timer
Calibrating delay using timer specific routine.. 4669.04 BogoMIPS (lpj=2334524)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3fd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000940 0000e3fd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
CPU0: Intel(R) Core(TM)2 Duo CPU     E6550  @ 2.33GHz stepping 0b
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4666.57 BogoMIPS (lpj=2333285)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3fd 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000940 0000e3fd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 Duo CPU     E6550  @ 2.33GHz stepping 0b
Total of 2 processors activated (9335.61 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=21
checking if image is initramfs... it is
Freeing initrd memory: 3019k freed
DEV: registering device: ID = 'platform'
PM: Adding info for No Bus:platform
bus type 'platform' registered
Registering sysdev class '<NULL>'
NET: Registered protocol family 16
device class 'pci_bus': registering
bus type 'pci' registered
device class 'tty': registering
device class 'vtconsole': registering
CLASS: registering class device: ID = 'vtcon0'
class_uevent - name = vtcon0
class_device_create_uevent called for vtcon0
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=4
PCI: Using configuration type 1
Setting up standard PCI resources
Registering sys device 'cpu0'
Registering sys device 'cpu1'
device class 'graphics': registering
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
bus type 'acpi' registered
DEV: registering device: ID = 'acpi'
PM: Adding info for acpi:acpi
bus acpi: add device acpi
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
DEV: registering device: ID = 'pci0000:00'
PM: Adding info for No Bus:pci0000:00
CLASS: registering class device: ID = '0000:00'
class_uevent - name = 0000:00
CLASS: registering class device: ID = '0000:01'
class_uevent - name = 0000:01
Boot video device is 0000:01:00.0
CLASS: registering class device: ID = '0000:03'
class_uevent - name = 0000:03
CLASS: registering class device: ID = '0000:02'
class_uevent - name = 0000:02
CLASS: registering class device: ID = '0000:04'
class_uevent - name = 0000:04
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
DEV: registering device: ID = '0000:00:00.0'
PM: Adding info for pci:0000:00:00.0
bus pci: add device 0000:00:00.0
DEV: registering device: ID = '0000:00:01.0'
PM: Adding info for pci:0000:00:01.0
bus pci: add device 0000:00:01.0
DEV: registering device: ID = '0000:00:1a.0'
PM: Adding info for pci:0000:00:1a.0
bus pci: add device 0000:00:1a.0
DEV: registering device: ID = '0000:00:1a.1'
PM: Adding info for pci:0000:00:1a.1
bus pci: add device 0000:00:1a.1
DEV: registering device: ID = '0000:00:1a.2'
PM: Adding info for pci:0000:00:1a.2
bus pci: add device 0000:00:1a.2
DEV: registering device: ID = '0000:00:1a.7'
PM: Adding info for pci:0000:00:1a.7
bus pci: add device 0000:00:1a.7
DEV: registering device: ID = '0000:00:1c.0'
PM: Adding info for pci:0000:00:1c.0
bus pci: add device 0000:00:1c.0
DEV: registering device: ID = '0000:00:1c.4'
PM: Adding info for pci:0000:00:1c.4
bus pci: add device 0000:00:1c.4
DEV: registering device: ID = '0000:00:1d.0'
PM: Adding info for pci:0000:00:1d.0
bus pci: add device 0000:00:1d.0
DEV: registering device: ID = '0000:00:1d.1'
PM: Adding info for pci:0000:00:1d.1
bus pci: add device 0000:00:1d.1
DEV: registering device: ID = '0000:00:1d.2'
PM: Adding info for pci:0000:00:1d.2
bus pci: add device 0000:00:1d.2
DEV: registering device: ID = '0000:00:1d.7'
PM: Adding info for pci:0000:00:1d.7
bus pci: add device 0000:00:1d.7
DEV: registering device: ID = '0000:00:1e.0'
PM: Adding info for pci:0000:00:1e.0
bus pci: add device 0000:00:1e.0
DEV: registering device: ID = '0000:00:1f.0'
PM: Adding info for pci:0000:00:1f.0
bus pci: add device 0000:00:1f.0
DEV: registering device: ID = '0000:00:1f.3'
PM: Adding info for pci:0000:00:1f.3
bus pci: add device 0000:00:1f.3
DEV: registering device: ID = '0000:01:00.0'
PM: Adding info for pci:0000:01:00.0
bus pci: add device 0000:01:00.0
DEV: registering device: ID = '0000:03:00.0'
PM: Adding info for pci:0000:03:00.0
bus pci: add device 0000:03:00.0
DEV: registering device: ID = '0000:02:00.0'
PM: Adding info for pci:0000:02:00.0
bus pci: add device 0000:02:00.0
DEV: registering device: ID = '0000:02:00.1'
PM: Adding info for pci:0000:02:00.1
bus pci: add device 0000:02:00.1
DEV: registering device: ID = '0000:04:01.0'
PM: Adding info for pci:0000:04:01.0
bus pci: add device 0000:04:01.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
bus type 'pnp' registered
device class 'misc': registering
bus type 'spi' registered
device class 'spi_master': registering
bus type 'usb' registered
device class 'usb_host': registering
bus usb: add driver usbfs
usbcore: registered new interface driver usbfs
device class 'usb_device': registering
bus usb: add driver hub
usbcore: registered new interface driver hub
bus usb: add driver usb
usbcore: registered new device driver usb
bus type 'serio' registered
device class 'input': registering
device class 'dma': registering
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
device class 'net': registering
pnp: the driver 'system' has been registered
bus pnp: add driver system
device class 'mem': registering
CLASS: registering class device: ID = 'mem'
class_uevent - name = mem
class_device_create_uevent called for mem
CLASS: registering class device: ID = 'kmem'
class_uevent - name = kmem
class_device_create_uevent called for kmem
CLASS: registering class device: ID = 'null'
class_uevent - name = null
class_device_create_uevent called for null
CLASS: registering class device: ID = 'port'
class_uevent - name = port
class_device_create_uevent called for port
CLASS: registering class device: ID = 'zero'
class_uevent - name = zero
class_device_create_uevent called for zero
CLASS: registering class device: ID = 'full'
class_uevent - name = full
class_device_create_uevent called for full
CLASS: registering class device: ID = 'random'
class_uevent - name = random
class_device_create_uevent called for random
CLASS: registering class device: ID = 'urandom'
class_uevent - name = urandom
class_device_create_uevent called for urandom
CLASS: registering class device: ID = 'kmsg'
class_uevent - name = kmsg
class_device_create_uevent called for kmsg
CLASS: registering class device: ID = 'oldmem'
class_uevent - name = oldmem
class_device_create_uevent called for oldmem
device class 'firmware': registering
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: fc000000-fe7fffff
  PREFETCH window: c0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: d000-dfff
  MEM window: fe900000-feafffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
  IO window: c000-cfff
  MEM window: fe800000-fe8fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: e000-efff
  MEM window: feb00000-febfffff
  PREFETCH window: 88000000-880fffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.4 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Registering sysdev class '<NULL>'
Registering sys device 'timer0'
Registering platform device 'pcspkr'. Parent at platform
DEV: registering device: ID = 'pcspkr'
PM: Adding info for platform:pcspkr
bus platform: add device pcspkr
Registering sysdev class '<NULL>'
Registering sys device 'i82590'
Registering sysdev class '<NULL>'
Registering sys device 'i82370'
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
Registering sysdev class '<NULL>'
Registering sys device 'lapic0'
Registering sysdev class '<NULL>'
Registering sys device 'ioapic0'
Registering sysdev class '<NULL>'
Registering sys device 'timekeeping0'
Registering sysdev class '<NULL>'
Registering sys device 'clocksource0'
audit: initializing netlink socket (disabled)
audit(1218056932.751:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
bus type 'pci_express' registered
bus pci: add driver pcieport-driver
pci: Matched Device 0000:00:01.0 with Driver pcieport-driver
pci: Probing driver pcieport-driver with device 0000:00:01.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
DEV: registering device: ID = '0000:00:01.0:pcie00'
PM: Adding info for pci_express:0000:00:01.0:pcie00
bus pci_express: add device 0000:00:01.0:pcie00
bound device '0000:00:01.0' to driver 'pcieport-driver'
pci: Bound Device 0000:00:01.0 to Driver pcieport-driver
pci: Matched Device 0000:00:1c.0 with Driver pcieport-driver
pci: Probing driver pcieport-driver with device 0000:00:1c.0
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
DEV: registering device: ID = '0000:00:1c.0:pcie00'
PM: Adding info for pci_express:0000:00:1c.0:pcie00
bus pci_express: add device 0000:00:1c.0:pcie00
Allocate Port Service[0000:00:1c.0:pcie02]
DEV: registering device: ID = '0000:00:1c.0:pcie02'
PM: Adding info for pci_express:0000:00:1c.0:pcie02
bus pci_express: add device 0000:00:1c.0:pcie02
bound device '0000:00:1c.0' to driver 'pcieport-driver'
pci: Bound Device 0000:00:1c.0 to Driver pcieport-driver
pci: Matched Device 0000:00:1c.4 with Driver pcieport-driver
pci: Probing driver pcieport-driver with device 0000:00:1c.4
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
DEV: registering device: ID = '0000:00:1c.4:pcie00'
PM: Adding info for pci_express:0000:00:1c.4:pcie00
bus pci_express: add device 0000:00:1c.4:pcie00
Allocate Port Service[0000:00:1c.4:pcie02]
DEV: registering device: ID = '0000:00:1c.4:pcie02'
PM: Adding info for pci_express:0000:00:1c.4:pcie02
bus pci_express: add device 0000:00:1c.4:pcie02
bound device '0000:00:1c.4' to driver 'pcieport-driver'
pci: Bound Device 0000:00:1c.4 to Driver pcieport-driver
bus pci_express: add driver aer
CLASS: registering class device: ID = 'fbcon'
class_uevent - name = fbcon
class_device_create_uevent called for fbcon
bus platform: add driver vesafb
Registering platform device 'vesafb.0'. Parent at platform
DEV: registering device: ID = 'vesafb.0'
PM: Adding info for platform:vesafb.0
bus platform: add device vesafb.0
platform: Matched Device vesafb.0 with Driver vesafb
platform: Probing driver vesafb with device vesafb.0
Registering sysdev class '<NULL>'
Registering sys device 'irqrouter0'
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU1PM] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [  CPU2PM] [20060707]
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x3
ACPI Exception (acpi_processor-0681): AE_NOT_FOUND, Processor Device is not present [20060707]
ACPI: Getting cpuindex for acpiid 0x4
CLASS: registering class device: ID = 'tty'
class_uevent - name = tty
class_device_create_uevent called for tty
CLASS: registering class device: ID = 'console'
class_uevent - name = console
class_device_create_uevent called for console
CLASS: registering class device: ID = 'ptmx'
class_uevent - name = ptmx
class_device_create_uevent called for ptmx
CLASS: registering class device: ID = 'tty0'
class_uevent - name = tty0
class_device_create_uevent called for tty0
device class 'vc': registering
CLASS: registering class device: ID = 'vcs'
class_uevent - name = vcs
class_device_create_uevent called for vcs
CLASS: registering class device: ID = 'vcsa'
class_uevent - name = vcsa
class_device_create_uevent called for vcsa
CLASS: registering class device: ID = 'tty1'
class_uevent - name = tty1
class_device_create_uevent called for tty1
CLASS: registering class device: ID = 'tty2'
class_uevent - name = tty2
class_device_create_uevent called for tty2
CLASS: registering class device: ID = 'tty3'
class_uevent - name = tty3
class_device_create_uevent called for tty3
CLASS: registering class device: ID = 'tty4'
class_uevent - name = tty4
class_device_create_uevent called for tty4
CLASS: registering class device: ID = 'tty5'
class_uevent - name = tty5
class_device_create_uevent called for tty5
CLASS: registering class device: ID = 'tty6'
class_uevent - name = tty6
class_device_create_uevent called for tty6
CLASS: registering class device: ID = 'tty7'
class_uevent - name = tty7
class_device_create_uevent called for tty7
CLASS: registering class device: ID = 'tty8'
class_uevent - name = tty8
class_device_create_uevent called for tty8
CLASS: registering class device: ID = 'tty9'
class_uevent - name = tty9
class_device_create_uevent called for tty9
CLASS: registering class device: ID = 'tty10'
class_uevent - name = tty10
class_device_create_uevent called for tty10
CLASS: registering class device: ID = 'tty11'
class_uevent - name = tty11
class_device_create_uevent called for tty11
CLASS: registering class device: ID = 'tty12'
class_uevent - name = tty12
class_device_create_uevent called for tty12
CLASS: registering class device: ID = 'tty13'
class_uevent - name = tty13
class_device_create_uevent called for tty13
CLASS: registering class device: ID = 'tty14'
class_uevent - name = tty14
class_device_create_uevent called for tty14
CLASS: registering class device: ID = 'tty15'
class_uevent - name = tty15
class_device_create_uevent called for tty15
CLASS: registering class device: ID = 'tty16'
class_uevent - name = tty16
class_device_create_uevent called for tty16
CLASS: registering class device: ID = 'tty17'
class_uevent - name = tty17
class_device_create_uevent called for tty17
CLASS: registering class device: ID = 'tty18'
class_uevent - name = tty18
class_device_create_uevent called for tty18
CLASS: registering class device: ID = 'tty19'
class_uevent - name = tty19
class_device_create_uevent called for tty19
CLASS: registering class device: ID = 'tty20'
class_uevent - name = tty20
class_device_create_uevent called for tty20
CLASS: registering class device: ID = 'tty21'
class_uevent - name = tty21
class_device_create_uevent called for tty21
CLASS: registering class device: ID = 'tty22'
class_uevent - name = tty22
class_device_create_uevent called for tty22
CLASS: registering class device: ID = 'tty23'
class_uevent - name = tty23
class_device_create_uevent called for tty23
CLASS: registering class device: ID = 'tty24'
class_uevent - name = tty24
class_device_create_uevent called for tty24
CLASS: registering class device: ID = 'tty25'
class_uevent - name = tty25
class_device_create_uevent called for tty25
CLASS: registering class device: ID = 'tty26'
class_uevent - name = tty26
class_device_create_uevent called for tty26
CLASS: registering class device: ID = 'tty27'
class_uevent - name = tty27
class_device_create_uevent called for tty27
CLASS: registering class device: ID = 'tty28'
class_uevent - name = tty28
class_device_create_uevent called for tty28
CLASS: registering class device: ID = 'tty29'
class_uevent - name = tty29
class_device_create_uevent called for tty29
CLASS: registering class device: ID = 'tty30'
class_uevent - name = tty30
class_device_create_uevent called for tty30
CLASS: registering class device: ID = 'tty31'
class_uevent - name = tty31
class_device_create_uevent called for tty31
CLASS: registering class device: ID = 'tty32'
class_uevent - name = tty32
class_device_create_uevent called for tty32
CLASS: registering class device: ID = 'tty33'
class_uevent - name = tty33
class_device_create_uevent called for tty33
CLASS: registering class device: ID = 'tty34'
class_uevent - name = tty34
class_device_create_uevent called for tty34
CLASS: registering class device: ID = 'tty35'
class_uevent - name = tty35
class_device_create_uevent called for tty35
CLASS: registering class device: ID = 'tty36'
class_uevent - name = tty36
class_device_create_uevent called for tty36
CLASS: registering class device: ID = 'tty37'
class_uevent - name = tty37
class_device_create_uevent called for tty37
CLASS: registering class device: ID = 'tty38'
class_uevent - name = tty38
class_device_create_uevent called for tty38
CLASS: registering class device: ID = 'tty39'
class_uevent - name = tty39
class_device_create_uevent called for tty39
CLASS: registering class device: ID = 'tty40'
class_uevent - name = tty40
class_device_create_uevent called for tty40
CLASS: registering class device: ID = 'tty41'
class_uevent - name = tty41
class_device_create_uevent called for tty41
CLASS: registering class device: ID = 'tty42'
class_uevent - name = tty42
class_device_create_uevent called for tty42
CLASS: registering class device: ID = 'tty43'
class_uevent - name = tty43
class_device_create_uevent called for tty43
CLASS: registering class device: ID = 'tty44'
class_uevent - name = tty44
class_device_create_uevent called for tty44
CLASS: registering class device: ID = 'tty45'
class_uevent - name = tty45
class_device_create_uevent called for tty45
CLASS: registering class device: ID = 'tty46'
class_uevent - name = tty46
class_device_create_uevent called for tty46
CLASS: registering class device: ID = 'tty47'
class_uevent - name = tty47
class_device_create_uevent called for tty47
CLASS: registering class device: ID = 'tty48'
class_uevent - name = tty48
class_device_create_uevent called for tty48
CLASS: registering class device: ID = 'tty49'
class_uevent - name = tty49
class_device_create_uevent called for tty49
CLASS: registering class device: ID = 'tty50'
class_uevent - name = tty50
class_device_create_uevent called for tty50
CLASS: registering class device: ID = 'tty51'
class_uevent - name = tty51
class_device_create_uevent called for tty51
CLASS: registering class device: ID = 'tty52'
class_uevent - name = tty52
class_device_create_uevent called for tty52
CLASS: registering class device: ID = 'tty53'
class_uevent - name = tty53
class_device_create_uevent called for tty53
CLASS: registering class device: ID = 'tty54'
class_uevent - name = tty54
class_device_create_uevent called for tty54
CLASS: registering class device: ID = 'tty55'
class_uevent - name = tty55
class_device_create_uevent called for tty55
CLASS: registering class device: ID = 'tty56'
class_uevent - name = tty56
class_device_create_uevent called for tty56
CLASS: registering class device: ID = 'tty57'
class_uevent - name = tty57
class_device_create_uevent called for tty57
CLASS: registering class device: ID = 'tty58'
class_uevent - name = tty58
class_device_create_uevent called for tty58
CLASS: registering class device: ID = 'tty59'
class_uevent - name = tty59
class_device_create_uevent called for tty59
CLASS: registering class device: ID = 'tty60'
class_uevent - name = tty60
class_device_create_uevent called for tty60
CLASS: registering class device: ID = 'tty61'
class_uevent - name = tty61
class_device_create_uevent called for tty61
CLASS: registering class device: ID = 'tty62'
class_uevent - name = tty62
class_device_create_uevent called for tty62
CLASS: registering class device: ID = 'tty63'
class_uevent - name = tty63
class_device_create_uevent called for tty63
CLASS: registering class device: ID = 'hpet'
class_uevent - name = hpet
class_device_create_uevent called for hpet
hpet_resources: 0xfed00000 is busy
Linux agpgart interface v0.101 (c) Dave Jones
bus pci: add driver agpgart-ali
bus pci: add driver agpgart-ati
bus pci: add driver agpgart-intel
bus pci: add driver agpgart-nvidia
bus pci: add driver agpgart-sis
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Registering platform device 'serial8250'. Parent at platform
DEV: registering device: ID = 'serial8250'
PM: Adding info for platform:serial8250
bus platform: add device serial8250
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
CLASS: registering class device: ID = 'ttyS0'
class_uevent - name = ttyS0
class_device_create_uevent called for ttyS0
CLASS: registering class device: ID = 'ttyS1'
class_uevent - name = ttyS1
class_device_create_uevent called for ttyS1
CLASS: registering class device: ID = 'ttyS2'
class_uevent - name = ttyS2
class_device_create_uevent called for ttyS2
CLASS: registering class device: ID = 'ttyS3'
class_uevent - name = ttyS3
class_device_create_uevent called for ttyS3
bus platform: add driver serial8250
platform: Matched Device serial8250 with Driver serial8250
platform: Probing driver serial8250 with device serial8250
bound device 'serial8250' to driver 'serial8250'
platform: Bound Device serial8250 to Driver serial8250
pnp: the driver 'serial' has been registered
bus pnp: add driver serial
bus pci: add driver serial
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
CLASS: registering class device: ID = 'lo'
class_uevent - name = lo
netconsole: not configured, aborting
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
bus type 'ide' registered
JMB363: IDE controller at PCI slot 0000:02:00.1
PCI: Enabling device 0000:02:00.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:02:00.1[B] -> GSI 17 (level, low) -> IRQ 17
JMB363: chipset revision 3
JMB363: 100% native mode on irq 17
PCI: Setting latency timer of device 0000:02:00.1 to 64
    ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:DMA, hdf:DMA
    ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: IC35L020AVVN07-0, ATA DISK drive
DEV: registering device: ID = 'ide2'
PM: Adding info for No Bus:ide2
hdf: ATAPI DVD D DH16D2P, ATAPI CD/DVD-ROM drive
ide2 at 0xcc00-0xcc07,0xc882 on irq 17
DEV: registering device: ID = '2.0'
PM: Adding info for ide:2.0
bus ide: add device 2.0
DEV: registering device: ID = '2.1'
PM: Adding info for ide:2.1
bus ide: add device 2.1
Probing IDE interface ide3...
bus pci: add driver AEC62xx_IDE
bus pci: add driver ALI15x3_IDE
bus pci: add driver CMD64x_IDE
bus pci: add driver RZ1000_IDE
bus pci: add driver PCI_IDE
pci: Matched Device 0000:02:00.0 with Driver PCI_IDE
pci: Probing driver PCI_IDE with device 0000:02:00.0
pci: Matched Device 0000:02:00.1 with Driver PCI_IDE
pci: Probing driver PCI_IDE with device 0000:02:00.1
bound device '0000:02:00.1' to driver 'PCI_IDE'
pci: Bound Device 0000:02:00.1 to Driver PCI_IDE
Probing IDE interface ide0...
Probing IDE interface ide1...
Probing IDE interface ide3...
bus usb: add driver hiddev
usbcore: registered new interface driver hiddev
bus usb: add driver usbhid
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
bus usb: add driver mdc800
usbcore: registered new interface driver mdc800
drivers/usb/image/mdc800.c: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
pnp: the driver 'i8042 kbd' has been registered
bus pnp: add driver i8042 kbd
pnp: the driver 'i8042 aux' has been registered
bus pnp: add driver i8042 aux
bus pnp: remove driver i8042 kbd
pnp: the driver 'i8042 kbd' has been unregistered
bus pnp: remove driver i8042 aux
pnp: the driver 'i8042 aux' has been unregistered
PNP: No PS/2 controller found. Probing ports directly.
bus platform: add driver i8042
Registering platform device 'i8042'. Parent at platform
DEV: registering device: ID = 'i8042'
PM: Adding info for platform:i8042
bus platform: add device i8042
platform: Matched Device i8042 with Driver i8042
platform: Probing driver i8042 with device i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
bound device 'i8042' to driver 'i8042'
platform: Bound Device i8042 to Driver i8042
CLASS: registering class device: ID = 'mice'
class_uevent - name = mice
class_device_create_uevent called for mice
DEV: registering device: ID = 'serio0'
PM: Adding info for serio:serio0
bus serio: add device serio0
CLASS: registering class device: ID = 'psaux'
class_uevent - name = psaux
class_device_create_uevent called for psaux
DEV: registering device: ID = 'serio1'
PM: Adding info for serio:serio1
bus serio: add device serio1
mice: PS/2 mouse device common for all mice
bus serio: add driver atkbd
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
Registering sysdev class '<NULL>'
Registering sys device 'acpi0'
serio: Matched Device serio0 with Driver atkbd
serio: Probing driver atkbd with device serio0
Freeing unused kernel memory: 236k freed
Write protecting the kernel read-only data: 325k
Time: tsc clocksource has been installed.
CLASS: registering class device: ID = 'vcs1'
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
CLASS: registering class device: ID = 'vcsa1'
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
CLASS: registering class device: ID = 'input0'
class_uevent - name = input0
input: AT Translated Set 2 keyboard as /class/input/input0
CLASS: registering class device: ID = 'event0'
class_uevent - name = event0
class_device_create_uevent called for event0
bound device 'serio0' to driver 'atkbd'
serio: Bound Device serio0 to Driver atkbd
serio: Matched Device serio1 with Driver atkbd
serio: Probing driver atkbd with device serio1
device class '': release.
bus serio: add driver psmouse
serio: Matched Device serio1 with Driver psmouse
serio: Probing driver psmouse with device serio1
device class '': release.
bus pci: add driver ehci_hcd
pci: Matched Device 0000:00:1a.7 with Driver ehci_hcd
pci: Probing driver ehci_hcd with device 0000:00:1a.7
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
CLASS: registering class device: ID = 'usb_host1'
class_uevent - name = usb_host1
class_device_create_uevent called for usb_host1
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xfbfffc00
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
DEV: registering device: ID = 'usb1'
PM: Adding info for usb:usb1
bus usb: add device usb1
usb: Matched Device usb1 with Driver usb
usb: Probing driver usb with device usb1
device class 'usb_endpoint': registering
DEV: registering device: ID = 'usbdev1.1_ep00'
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
DEV: registering device: ID = '1-0:1.0'
PM: Adding info for usb:1-0:1.0
bus usb: add device 1-0:1.0
usb: Matched Device 1-0:1.0 with Driver hub
usb: Probing driver hub with device 1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
bound device '1-0:1.0' to driver 'hub'
usb: Bound Device 1-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev1.1_ep81'
PM: Adding info for No Bus:usbdev1.1_ep81
CLASS: registering class device: ID = 'usbdev1.1'
class_uevent - name = usbdev1.1
class_device_create_uevent called for usbdev1.1
bound device 'usb1' to driver 'usb'
usb: Bound Device usb1 to Driver usb
bound device '0000:00:1a.7' to driver 'ehci_hcd'
pci: Bound Device 0000:00:1a.7 to Driver ehci_hcd
pci: Matched Device 0000:00:1d.7 with Driver ehci_hcd
pci: Probing driver ehci_hcd with device 0000:00:1d.7
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
CLASS: registering class device: ID = 'usb_host2'
class_uevent - name = usb_host2
class_device_create_uevent called for usb_host2
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xfbfff800
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
DEV: registering device: ID = 'usb2'
PM: Adding info for usb:usb2
bus usb: add device usb2
usb: Matched Device usb2 with Driver usb
usb: Probing driver usb with device usb2
DEV: registering device: ID = 'usbdev2.1_ep00'
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
DEV: registering device: ID = '2-0:1.0'
PM: Adding info for usb:2-0:1.0
bus usb: add device 2-0:1.0
usb: Matched Device 2-0:1.0 with Driver hub
usb: Probing driver hub with device 2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
bound device '2-0:1.0' to driver 'hub'
usb: Bound Device 2-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev2.1_ep81'
PM: Adding info for No Bus:usbdev2.1_ep81
CLASS: registering class device: ID = 'usbdev2.1'
class_uevent - name = usbdev2.1
class_device_create_uevent called for usbdev2.1
bound device 'usb2' to driver 'usb'
usb: Bound Device usb2 to Driver usb
bound device '0000:00:1d.7' to driver 'ehci_hcd'
pci: Bound Device 0000:00:1d.7 to Driver ehci_hcd
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
bus pci: add driver ohci_hcd
USB Universal Host Controller Interface driver v3.0
bus pci: add driver uhci_hcd
pci: Matched Device 0000:00:1a.0 with Driver uhci_hcd
pci: Probing driver uhci_hcd with device 0000:00:1a.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
CLASS: registering class device: ID = 'usb_host3'
class_uevent - name = usb_host3
class_device_create_uevent called for usb_host3
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000b800
DEV: registering device: ID = 'usb3'
PM: Adding info for usb:usb3
bus usb: add device usb3
usb: Matched Device usb3 with Driver usb
usb: Probing driver usb with device usb3
DEV: registering device: ID = 'usbdev3.1_ep00'
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
DEV: registering device: ID = '3-0:1.0'
PM: Adding info for usb:3-0:1.0
bus usb: add device 3-0:1.0
usb: Matched Device 3-0:1.0 with Driver hub
usb: Probing driver hub with device 3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
bound device '3-0:1.0' to driver 'hub'
usb: Bound Device 3-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev3.1_ep81'
PM: Adding info for No Bus:usbdev3.1_ep81
CLASS: registering class device: ID = 'usbdev3.1'
class_uevent - name = usbdev3.1
class_device_create_uevent called for usbdev3.1
bound device 'usb3' to driver 'usb'
usb: Bound Device usb3 to Driver usb
bound device '0000:00:1a.0' to driver 'uhci_hcd'
pci: Bound Device 0000:00:1a.0 to Driver uhci_hcd
pci: Matched Device 0000:00:1a.1 with Driver uhci_hcd
pci: Probing driver uhci_hcd with device 0000:00:1a.1
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
CLASS: registering class device: ID = 'usb_host4'
class_uevent - name = usb_host4
class_device_create_uevent called for usb_host4
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 20, io base 0x0000b880
DEV: registering device: ID = 'usb4'
PM: Adding info for usb:usb4
bus usb: add device usb4
usb: Matched Device usb4 with Driver usb
usb: Probing driver usb with device usb4
DEV: registering device: ID = 'usbdev4.1_ep00'
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
DEV: registering device: ID = '4-0:1.0'
PM: Adding info for usb:4-0:1.0
bus usb: add device 4-0:1.0
usb: Matched Device 4-0:1.0 with Driver hub
usb: Probing driver hub with device 4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
bound device '4-0:1.0' to driver 'hub'
usb: Bound Device 4-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev4.1_ep81'
PM: Adding info for No Bus:usbdev4.1_ep81
CLASS: registering class device: ID = 'usbdev4.1'
class_uevent - name = usbdev4.1
class_device_create_uevent called for usbdev4.1
bound device 'usb4' to driver 'usb'
usb: Bound Device usb4 to Driver usb
bound device '0000:00:1a.1' to driver 'uhci_hcd'
pci: Bound Device 0000:00:1a.1 to Driver uhci_hcd
pci: Matched Device 0000:00:1a.2 with Driver uhci_hcd
pci: Probing driver uhci_hcd with device 0000:00:1a.2
ACPI: PCI Interrupt 0000:00:1a.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.2 to 64
uhci_hcd 0000:00:1a.2: UHCI Host Controller
CLASS: registering class device: ID = 'usb_host5'
class_uevent - name = usb_host5
class_device_create_uevent called for usb_host5
uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000bc00
DEV: registering device: ID = 'usb5'
PM: Adding info for usb:usb5
bus usb: add device usb5
usb: Matched Device usb5 with Driver usb
usb: Probing driver usb with device usb5
DEV: registering device: ID = 'usbdev5.1_ep00'
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
DEV: registering device: ID = '5-0:1.0'
PM: Adding info for usb:5-0:1.0
bus usb: add device 5-0:1.0
usb: Matched Device 5-0:1.0 with Driver hub
usb: Probing driver hub with device 5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
bound device '5-0:1.0' to driver 'hub'
usb: Bound Device 5-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev5.1_ep81'
PM: Adding info for No Bus:usbdev5.1_ep81
CLASS: registering class device: ID = 'usbdev5.1'
class_uevent - name = usbdev5.1
class_device_create_uevent called for usbdev5.1
bound device 'usb5' to driver 'usb'
usb: Bound Device usb5 to Driver usb
bound device '0000:00:1a.2' to driver 'uhci_hcd'
pci: Bound Device 0000:00:1a.2 to Driver uhci_hcd
pci: Matched Device 0000:00:1d.0 with Driver uhci_hcd
pci: Probing driver uhci_hcd with device 0000:00:1d.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
CLASS: registering class device: ID = 'usb_host6'
class_uevent - name = usb_host6
class_device_create_uevent called for usb_host6
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.0: irq 19, io base 0x0000b080
DEV: registering device: ID = 'usb6'
PM: Adding info for usb:usb6
bus usb: add device usb6
usb: Matched Device usb6 with Driver usb
usb: Probing driver usb with device usb6
DEV: registering device: ID = 'usbdev6.1_ep00'
PM: Adding info for No Bus:usbdev6.1_ep00
usb usb6: configuration #1 chosen from 1 choice
DEV: registering device: ID = '6-0:1.0'
PM: Adding info for usb:6-0:1.0
bus usb: add device 6-0:1.0
usb: Matched Device 6-0:1.0 with Driver hub
usb: Probing driver hub with device 6-0:1.0
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
bound device '6-0:1.0' to driver 'hub'
usb: Bound Device 6-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev6.1_ep81'
PM: Adding info for No Bus:usbdev6.1_ep81
CLASS: registering class device: ID = 'usbdev6.1'
class_uevent - name = usbdev6.1
class_device_create_uevent called for usbdev6.1
bound device 'usb6' to driver 'usb'
usb: Bound Device usb6 to Driver usb
bound device '0000:00:1d.0' to driver 'uhci_hcd'
pci: Bound Device 0000:00:1d.0 to Driver uhci_hcd
pci: Matched Device 0000:00:1d.1 with Driver uhci_hcd
pci: Probing driver uhci_hcd with device 0000:00:1d.1
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
CLASS: registering class device: ID = 'usb_host7'
class_uevent - name = usb_host7
class_device_create_uevent called for usb_host7
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.1: irq 21, io base 0x0000b400
DEV: registering device: ID = 'usb7'
PM: Adding info for usb:usb7
bus usb: add device usb7
usb: Matched Device usb7 with Driver usb
usb: Probing driver usb with device usb7
DEV: registering device: ID = 'usbdev7.1_ep00'
PM: Adding info for No Bus:usbdev7.1_ep00
usb usb7: configuration #1 chosen from 1 choice
DEV: registering device: ID = '7-0:1.0'
PM: Adding info for usb:7-0:1.0
bus usb: add device 7-0:1.0
usb: Matched Device 7-0:1.0 with Driver hub
usb: Probing driver hub with device 7-0:1.0
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
bound device '7-0:1.0' to driver 'hub'
usb: Bound Device 7-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev7.1_ep81'
PM: Adding info for No Bus:usbdev7.1_ep81
CLASS: registering class device: ID = 'usbdev7.1'
class_uevent - name = usbdev7.1
class_device_create_uevent called for usbdev7.1
bound device 'usb7' to driver 'usb'
usb: Bound Device usb7 to Driver usb
bound device '0000:00:1d.1' to driver 'uhci_hcd'
pci: Bound Device 0000:00:1d.1 to Driver uhci_hcd
pci: Matched Device 0000:00:1d.2 with Driver uhci_hcd
pci: Probing driver uhci_hcd with device 0000:00:1d.2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
CLASS: registering class device: ID = 'usb_host8'
class_uevent - name = usb_host8
class_device_create_uevent called for usb_host8
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000b480
DEV: registering device: ID = 'usb8'
PM: Adding info for usb:usb8
bus usb: add device usb8
usb: Matched Device usb8 with Driver usb
usb: Probing driver usb with device usb8
DEV: registering device: ID = 'usbdev8.1_ep00'
PM: Adding info for No Bus:usbdev8.1_ep00
usb usb8: configuration #1 chosen from 1 choice
DEV: registering device: ID = '8-0:1.0'
PM: Adding info for usb:8-0:1.0
bus usb: add device 8-0:1.0
usb: Matched Device 8-0:1.0 with Driver hub
usb: Probing driver hub with device 8-0:1.0
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
bound device '8-0:1.0' to driver 'hub'
usb: Bound Device 8-0:1.0 to Driver hub
DEV: registering device: ID = 'usbdev8.1_ep81'
PM: Adding info for No Bus:usbdev8.1_ep81
CLASS: registering class device: ID = 'usbdev8.1'
class_uevent - name = usbdev8.1
class_device_create_uevent called for usbdev8.1
bound device 'usb8' to driver 'usb'
usb: Bound Device usb8 to Driver usb
bound device '0000:00:1d.2' to driver 'uhci_hcd'
pci: Bound Device 0000:00:1d.2 to Driver uhci_hcd
bus ide: add driver ide-disk
ide: Matched Device 2.0 with Driver ide-disk
ide: Probing driver ide-disk with device 2.0
hde: max request size: 128KiB
hde: 40188960 sectors (20576 MB) w/1863KiB Cache, CHS=39870/16/63
hde: cache flushes supported
 hde: hde1 hde2
bound device '2.0' to driver 'ide-disk'
ide: Bound Device 2.0 to Driver ide-disk
ide: Matched Device 2.1 with Driver ide-disk
ide: Probing driver ide-disk with device 2.1
device class 'scsi_host': registering
bus type 'scsi' registered
device class 'scsi_device': registering
SCSI subsystem initialized
device class 'scsi_disk': registering
bus scsi: add driver sd
libata version 2.00 loaded.
bus pci: add driver ahci
pci: Matched Device 0000:02:00.0 with Driver ahci
pci: Probing driver ahci with device 0000:02:00.0
ahci 0000:02:00.0: version 2.0
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
usb 8-2: new low speed USB device using uhci_hcd and address 2
DEV: registering device: ID = '8-2'
PM: Adding info for usb:8-2
bus usb: add device 8-2
usb: Matched Device 8-2 with Driver usb
usb: Probing driver usb with device 8-2
DEV: registering device: ID = 'usbdev8.2_ep00'
PM: Adding info for No Bus:usbdev8.2_ep00
usb 8-2: configuration #1 chosen from 1 choice
DEV: registering device: ID = '8-2:1.0'
PM: Adding info for usb:8-2:1.0
bus usb: add device 8-2:1.0
usb: Matched Device 8-2:1.0 with Driver usbhid
usb: Probing driver usbhid with device 8-2:1.0
CLASS: registering class device: ID = 'input1'
class_uevent - name = input1
input: KYE Systems Genius USB Mouse as /class/input/input1
CLASS: registering class device: ID = 'mouse0'
class_uevent - name = mouse0
class_device_create_uevent called for mouse0
CLASS: registering class device: ID = 'event1'
class_uevent - name = event1
class_device_create_uevent called for event1
input: USB HID v1.00 Mouse [KYE Systems Genius USB Mouse] on usb-0000:00:1d.2-2
bound device '8-2:1.0' to driver 'usbhid'
usb: Bound Device 8-2:1.0 to Driver usbhid
DEV: registering device: ID = 'usbdev8.2_ep81'
PM: Adding info for No Bus:usbdev8.2_ep81
CLASS: registering class device: ID = 'usbdev8.2'
class_uevent - name = usbdev8.2
class_device_create_uevent called for usbdev8.2
bound device '8-2' to driver 'usb'
usb: Bound Device 8-2 to Driver usb
PCI: Setting latency timer of device 0000:02:00.0 to 64
ahci 0000:02:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
ahci 0000:02:00.0: flags: 64bit ncq pm led clo pmp pio slum part 
ata1: SATA max UDMA/133 cmd 0xF884C100 ctl 0x0 bmdma 0x0 irq 16
ata2: SATA max UDMA/133 cmd 0xF884C180 ctl 0x0 bmdma 0x0 irq 16
scsi0 : ahci
DEV: registering device: ID = 'host0'
PM: Adding info for No Bus:host0
CLASS: registering class device: ID = 'host0'
class_uevent - name = host0
ata1: SATA link down (SStatus 0 SControl 300)
scsi1 : ahci
DEV: registering device: ID = 'host1'
PM: Adding info for No Bus:host1
CLASS: registering class device: ID = 'host1'
class_uevent - name = host1
ata2: SATA link down (SStatus 0 SControl 300)
bound device '0000:02:00.0' to driver 'ahci'
pci: Bound Device 0000:02:00.0 to Driver ahci
CLASS: registering class device: ID = 'device-mapper'
class_uevent - name = device-mapper
class_device_create_uevent called for device-mapper
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
CLASS: Unregistering class device. ID = 'vcs1'
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
device class 'vcs1': release.
class_device_create_release called for vcs1
CLASS: Unregistering class device. ID = 'vcsa1'
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
device class 'vcsa1': release.
class_device_create_release called for vcsa1
CLASS: registering class device: ID = 'vcs1'
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
CLASS: registering class device: ID = 'vcsa1'
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
CLASS: Unregistering class device. ID = 'vcs1'
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
device class 'vcs1': release.
class_device_create_release called for vcs1
CLASS: Unregistering class device. ID = 'vcsa1'
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
device class 'vcsa1': release.
class_device_create_release called for vcsa1
CLASS: registering class device: ID = 'vcs1'
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
CLASS: registering class device: ID = 'vcsa1'
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
CLASS: registering class device: ID = 'rtc'
class_uevent - name = rtc
class_device_create_uevent called for rtc
Real Time Clock Driver v1.12ac
class_uevent - name = oldmem
class_device_create_uevent called for oldmem
class_uevent - name = kmsg
class_device_create_uevent called for kmsg
class_uevent - name = urandom
class_device_create_uevent called for urandom
class_uevent - name = random
class_device_create_uevent called for random
class_uevent - name = full
class_device_create_uevent called for full
class_uevent - name = zero
class_device_create_uevent called for zero
class_uevent - name = port
class_device_create_uevent called for port
class_uevent - name = null
class_device_create_uevent called for null
class_uevent - name = kmem
class_device_create_uevent called for kmem
class_uevent - name = mem
class_device_create_uevent called for mem
class_uevent - name = ttyS3
class_device_create_uevent called for ttyS3
class_uevent - name = ttyS2
class_device_create_uevent called for ttyS2
class_uevent - name = ttyS1
class_device_create_uevent called for ttyS1
class_uevent - name = ttyS0
class_device_create_uevent called for ttyS0
class_uevent - name = tty63
class_device_create_uevent called for tty63
class_uevent - name = tty62
class_device_create_uevent called for tty62
class_uevent - name = tty61
class_device_create_uevent called for tty61
class_uevent - name = tty60
class_device_create_uevent called for tty60
class_uevent - name = tty59
class_device_create_uevent called for tty59
class_uevent - name = tty58
class_device_create_uevent called for tty58
class_uevent - name = tty57
class_device_create_uevent called for tty57
class_uevent - name = tty56
class_device_create_uevent called for tty56
class_uevent - name = tty55
class_device_create_uevent called for tty55
class_uevent - name = tty54
class_device_create_uevent called for tty54
class_uevent - name = tty53
class_device_create_uevent called for tty53
class_uevent - name = tty52
class_device_create_uevent called for tty52
class_uevent - name = tty51
class_device_create_uevent called for tty51
class_uevent - name = tty50
class_device_create_uevent called for tty50
class_uevent - name = tty49
class_device_create_uevent called for tty49
class_uevent - name = tty48
class_device_create_uevent called for tty48
class_uevent - name = tty47
class_device_create_uevent called for tty47
class_uevent - name = tty46
class_device_create_uevent called for tty46
class_uevent - name = tty45
class_device_create_uevent called for tty45
class_uevent - name = tty44
class_device_create_uevent called for tty44
class_uevent - name = tty43
class_device_create_uevent called for tty43
class_uevent - name = tty42
class_device_create_uevent called for tty42
class_uevent - name = tty41
class_device_create_uevent called for tty41
class_uevent - name = tty40
class_device_create_uevent called for tty40
class_uevent - name = tty39
class_device_create_uevent called for tty39
class_uevent - name = tty38
class_device_create_uevent called for tty38
class_uevent - name = tty37
class_device_create_uevent called for tty37
class_uevent - name = tty36
class_device_create_uevent called for tty36
class_uevent - name = tty35
class_device_create_uevent called for tty35
class_uevent - name = tty34
class_device_create_uevent called for tty34
class_uevent - name = tty33
class_device_create_uevent called for tty33
class_uevent - name = tty32
class_device_create_uevent called for tty32
class_uevent - name = tty31
class_device_create_uevent called for tty31
class_uevent - name = tty30
class_device_create_uevent called for tty30
class_uevent - name = tty29
class_device_create_uevent called for tty29
class_uevent - name = tty28
class_device_create_uevent called for tty28
class_uevent - name = tty27
class_device_create_uevent called for tty27
class_uevent - name = tty26
class_device_create_uevent called for tty26
class_uevent - name = tty25
class_device_create_uevent called for tty25
class_uevent - name = tty24
class_device_create_uevent called for tty24
class_uevent - name = tty23
class_device_create_uevent called for tty23
class_uevent - name = tty22
class_device_create_uevent called for tty22
class_uevent - name = tty21
class_device_create_uevent called for tty21
class_uevent - name = tty20
class_device_create_uevent called for tty20
class_uevent - name = tty19
class_device_create_uevent called for tty19
class_uevent - name = tty18
class_device_create_uevent called for tty18
class_uevent - name = tty17
class_device_create_uevent called for tty17
class_uevent - name = tty16
class_device_create_uevent called for tty16
class_uevent - name = tty15
class_device_create_uevent called for tty15
class_uevent - name = tty14
class_device_create_uevent called for tty14
class_uevent - name = tty13
class_device_create_uevent called for tty13
class_uevent - name = tty12
class_device_create_uevent called for tty12
class_uevent - name = tty11
class_device_create_uevent called for tty11
class_uevent - name = tty10
class_device_create_uevent called for tty10
class_uevent - name = tty9
class_device_create_uevent called for tty9
class_uevent - name = tty8
class_device_create_uevent called for tty8
class_uevent - name = tty7
class_device_create_uevent called for tty7
class_uevent - name = tty6
class_device_create_uevent called for tty6
class_uevent - name = tty5
class_device_create_uevent called for tty5
class_uevent - name = tty4
class_device_create_uevent called for tty4
class_uevent - name = tty3
class_device_create_uevent called for tty3
class_uevent - name = tty2
class_device_create_uevent called for tty2
class_uevent - name = tty1
class_device_create_uevent called for tty1
class_uevent - name = tty0
class_device_create_uevent called for tty0
class_uevent - name = ptmx
class_device_create_uevent called for ptmx
class_uevent - name = console
class_device_create_uevent called for console
class_uevent - name = tty
class_device_create_uevent called for tty
class_uevent - name = host1
class_uevent - name = host0
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
class_uevent - name = vcsa
class_device_create_uevent called for vcsa
class_uevent - name = vcs
class_device_create_uevent called for vcs
class_uevent - name = lo
class_uevent - name = event1
class_device_create_uevent called for event1
class_uevent - name = mouse0
class_device_create_uevent called for mouse0
class_uevent - name = input1
class_uevent - name = event0
class_device_create_uevent called for event0
class_uevent - name = input0
class_uevent - name = mice
class_device_create_uevent called for mice
class_uevent - name = usbdev8.2
class_device_create_uevent called for usbdev8.2
class_uevent - name = usbdev8.1
class_device_create_uevent called for usbdev8.1
class_uevent - name = usbdev7.1
class_device_create_uevent called for usbdev7.1
class_uevent - name = usbdev6.1
class_device_create_uevent called for usbdev6.1
class_uevent - name = usbdev5.1
class_device_create_uevent called for usbdev5.1
class_uevent - name = usbdev4.1
class_device_create_uevent called for usbdev4.1
class_uevent - name = usbdev3.1
class_device_create_uevent called for usbdev3.1
class_uevent - name = usbdev2.1
class_device_create_uevent called for usbdev2.1
class_uevent - name = usbdev1.1
class_device_create_uevent called for usbdev1.1
class_uevent - name = usb_host8
class_device_create_uevent called for usb_host8
class_uevent - name = usb_host7
class_device_create_uevent called for usb_host7
class_uevent - name = usb_host6
class_device_create_uevent called for usb_host6
class_uevent - name = usb_host5
class_device_create_uevent called for usb_host5
class_uevent - name = usb_host4
class_device_create_uevent called for usb_host4
class_uevent - name = usb_host3
class_device_create_uevent called for usb_host3
class_uevent - name = usb_host2
class_device_create_uevent called for usb_host2
class_uevent - name = usb_host1
class_device_create_uevent called for usb_host1
class_uevent - name = rtc
class_device_create_uevent called for rtc
class_uevent - name = device-mapper
class_device_create_uevent called for device-mapper
class_uevent - name = psaux
class_device_create_uevent called for psaux
class_uevent - name = hpet
class_device_create_uevent called for hpet
class_uevent - name = fbcon
class_device_create_uevent called for fbcon
class_uevent - name = vtcon0
class_device_create_uevent called for vtcon0
class_uevent - name = 0000:04
class_uevent - name = 0000:02
class_uevent - name = 0000:03
class_uevent - name = 0000:01
class_uevent - name = 0000:00
bus ide: add driver ide-cdrom
ide: Matched Device 2.1 with Driver ide-cdrom
ide: Probing driver ide-cdrom with device 2.1
bus serio: add driver serio_raw
bus pci: add driver 3c59x
pci: Matched Device 0000:04:01.0 with Driver 3c59x
pci: Probing driver 3c59x with device 0000:04:01.0
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 17 (level, low) -> IRQ 17
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:04:01.0: 3Com PCI 3c905B Cyclone 100baseTx at f891ac00.
CLASS: registering class device: ID = 'eth0'
class_uevent - name = eth0
bound device '0000:04:01.0' to driver '3c59x'
pci: Bound Device 0000:04:01.0 to Driver 3c59x
bus platform: add driver pcspkr
platform: Matched Device pcspkr with Driver pcspkr
platform: Probing driver pcspkr with device pcspkr
CLASS: registering class device: ID = 'input2'
class_uevent - name = input2
input: PC Speaker as /class/input/input2
CLASS: registering class device: ID = 'event2'
class_uevent - name = event2
class_device_create_uevent called for event2
bound device 'pcspkr' to driver 'pcspkr'
platform: Bound Device pcspkr to Driver pcspkr
bus pci: add driver ata_generic
bus pci: add driver JMicron IDE
bus pci: add driver pata_jmicron
hdf: ATAPI 48X DVD-ROM drive, 198kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
bound device '2.1' to driver 'ide-cdrom'
ide: Bound Device 2.1 to Driver ide-cdrom
CLASS: registering class device: ID = 'nvram'
class_uevent - name = nvram
class_device_create_uevent called for nvram
Non-volatile memory driver v1.2
CLASS: registering class device: ID = 'vcs8'
class_uevent - name = vcs8
class_device_create_uevent called for vcs8
CLASS: registering class device: ID = 'vcsa8'
class_uevent - name = vcsa8
class_device_create_uevent called for vcsa8
CLASS: Unregistering class device. ID = 'vcs8'
class_uevent - name = vcs8
class_device_create_uevent called for vcs8
device class 'vcs8': release.
class_device_create_release called for vcs8
CLASS: Unregistering class device. ID = 'vcsa8'
class_uevent - name = vcsa8
class_device_create_uevent called for vcsa8
device class 'vcsa8': release.
class_device_create_release called for vcsa8
CLASS: registering class device: ID = 'vcs8'
class_uevent - name = vcs8
class_device_create_uevent called for vcs8
CLASS: registering class device: ID = 'vcsa8'
class_uevent - name = vcsa8
class_device_create_uevent called for vcsa8
CLASS: Unregistering class device. ID = 'vcs8'
class_uevent - name = vcs8
class_device_create_uevent called for vcs8
device class 'vcs8': release.
class_device_create_release called for vcs8
CLASS: Unregistering class device. ID = 'vcsa8'
class_uevent - name = vcsa8
class_device_create_uevent called for vcsa8
device class 'vcsa8': release.
class_device_create_release called for vcsa8
CLASS: registering class device: ID = 'vcs8'
class_uevent - name = vcs8
class_device_create_uevent called for vcs8
CLASS: registering class device: ID = 'vcsa8'
class_uevent - name = vcsa8
class_device_create_uevent called for vcsa8
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 2031608k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:2031608k
CLASS: Unregistering class device. ID = 'vcs1'
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
device class 'vcs1': release.
class_device_create_release called for vcs1
CLASS: Unregistering class device. ID = 'vcsa1'
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
device class 'vcsa1': release.
class_device_create_release called for vcsa1
CLASS: registering class device: ID = 'microcode'
class_uevent - name = microcode
class_device_create_uevent called for microcode
Registering platform device 'microcode'. Parent at platform
DEV: registering device: ID = 'microcode'
PM: Adding info for platform:microcode
bus platform: add device microcode
CLASS: registering class device: ID = 'microcode'
class_uevent - name = microcode
class->uevent() returned -19
class_uevent - name = microcode
CLASS: Unregistering class device. ID = 'microcode'
class_uevent - name = microcode
device class 'microcode': release.
CLASS: registering class device: ID = 'microcode'
class_uevent - name = microcode
class->uevent() returned -19
class_uevent - name = microcode
CLASS: Unregistering class device. ID = 'microcode'
class_uevent - name = microcode
device class 'microcode': release.
IA-32 Microcode Update Driver: v1.14a <tigran@veritas.com>
CLASS: Unregistering class device. ID = 'microcode'
class_uevent - name = microcode
class_device_create_uevent called for microcode
device class 'microcode': release.
class_device_create_release called for microcode
bus platform: remove device microcode
PM: Removing info for platform:microcode
class_uevent - name = oldmem
class_device_create_uevent called for oldmem
class_uevent - name = kmsg
class_device_create_uevent called for kmsg
class_uevent - name = urandom
class_device_create_uevent called for urandom
class_uevent - name = random
class_device_create_uevent called for random
class_uevent - name = full
class_device_create_uevent called for full
class_uevent - name = zero
class_device_create_uevent called for zero
class_uevent - name = port
class_device_create_uevent called for port
class_uevent - name = null
class_device_create_uevent called for null
class_uevent - name = kmem
class_device_create_uevent called for kmem
class_uevent - name = mem
class_device_create_uevent called for mem
class_uevent - name = ttyS3
class_device_create_uevent called for ttyS3
class_uevent - name = ttyS2
class_device_create_uevent called for ttyS2
class_uevent - name = ttyS1
class_device_create_uevent called for ttyS1
class_uevent - name = ttyS0
class_device_create_uevent called for ttyS0
class_uevent - name = tty63
class_device_create_uevent called for tty63
class_uevent - name = tty62
class_device_create_uevent called for tty62
class_uevent - name = tty61
class_device_create_uevent called for tty61
class_uevent - name = tty60
class_device_create_uevent called for tty60
class_uevent - name = tty59
class_device_create_uevent called for tty59
class_uevent - name = tty58
class_device_create_uevent called for tty58
class_uevent - name = tty57
class_device_create_uevent called for tty57
class_uevent - name = tty56
class_device_create_uevent called for tty56
class_uevent - name = tty55
class_device_create_uevent called for tty55
class_uevent - name = tty54
class_device_create_uevent called for tty54
class_uevent - name = tty53
class_device_create_uevent called for tty53
class_uevent - name = tty52
class_device_create_uevent called for tty52
class_uevent - name = tty51
class_device_create_uevent called for tty51
class_uevent - name = tty50
class_device_create_uevent called for tty50
class_uevent - name = tty49
class_device_create_uevent called for tty49
class_uevent - name = tty48
class_device_create_uevent called for tty48
class_uevent - name = tty47
class_device_create_uevent called for tty47
class_uevent - name = tty46
class_device_create_uevent called for tty46
class_uevent - name = tty45
class_device_create_uevent called for tty45
class_uevent - name = tty44
class_device_create_uevent called for tty44
class_uevent - name = tty43
class_device_create_uevent called for tty43
class_uevent - name = tty42
class_device_create_uevent called for tty42
class_uevent - name = tty41
class_device_create_uevent called for tty41
class_uevent - name = tty40
class_device_create_uevent called for tty40
class_uevent - name = tty39
class_device_create_uevent called for tty39
class_uevent - name = tty38
class_device_create_uevent called for tty38
class_uevent - name = tty37
class_device_create_uevent called for tty37
class_uevent - name = tty36
class_device_create_uevent called for tty36
class_uevent - name = tty35
class_device_create_uevent called for tty35
class_uevent - name = tty34
class_device_create_uevent called for tty34
class_uevent - name = tty33
class_device_create_uevent called for tty33
class_uevent - name = tty32
class_device_create_uevent called for tty32
class_uevent - name = tty31
class_device_create_uevent called for tty31
class_uevent - name = tty30
class_device_create_uevent called for tty30
class_uevent - name = tty29
class_device_create_uevent called for tty29
class_uevent - name = tty28
class_device_create_uevent called for tty28
class_uevent - name = tty27
class_device_create_uevent called for tty27
class_uevent - name = tty26
class_device_create_uevent called for tty26
class_uevent - name = tty25
class_device_create_uevent called for tty25
class_uevent - name = tty24
class_device_create_uevent called for tty24
class_uevent - name = tty23
class_device_create_uevent called for tty23
class_uevent - name = tty22
class_device_create_uevent called for tty22
class_uevent - name = tty21
class_device_create_uevent called for tty21
class_uevent - name = tty20
class_device_create_uevent called for tty20
class_uevent - name = tty19
class_device_create_uevent called for tty19
class_uevent - name = tty18
class_device_create_uevent called for tty18
class_uevent - name = tty17
class_device_create_uevent called for tty17
class_uevent - name = tty16
class_device_create_uevent called for tty16
class_uevent - name = tty15
class_device_create_uevent called for tty15
class_uevent - name = tty14
class_device_create_uevent called for tty14
class_uevent - name = tty13
class_device_create_uevent called for tty13
class_uevent - name = tty12
class_device_create_uevent called for tty12
class_uevent - name = tty11
class_device_create_uevent called for tty11
class_uevent - name = tty10
class_device_create_uevent called for tty10
class_uevent - name = tty9
class_device_create_uevent called for tty9
class_uevent - name = tty8
class_device_create_uevent called for tty8
class_uevent - name = tty7
class_device_create_uevent called for tty7
class_uevent - name = tty6
class_device_create_uevent called for tty6
class_uevent - name = tty5
class_device_create_uevent called for tty5
class_uevent - name = tty4
class_device_create_uevent called for tty4
class_uevent - name = tty3
class_device_create_uevent called for tty3
class_uevent - name = tty2
class_device_create_uevent called for tty2
class_uevent - name = tty1
class_device_create_uevent called for tty1
class_uevent - name = tty0
class_device_create_uevent called for tty0
class_uevent - name = ptmx
class_device_create_uevent called for ptmx
class_uevent - name = console
class_device_create_uevent called for console
class_uevent - name = tty
class_device_create_uevent called for tty
class_uevent - name = host1
class_uevent - name = host0
class_uevent - name = vcsa8
class_device_create_uevent called for vcsa8
class_uevent - name = vcs8
class_device_create_uevent called for vcs8
class_uevent - name = vcsa
class_device_create_uevent called for vcsa
class_uevent - name = vcs
class_device_create_uevent called for vcs
class_uevent - name = eth0
class_uevent - name = lo
class_uevent - name = event2
class_device_create_uevent called for event2
class_uevent - name = input2
class_uevent - name = event1
class_device_create_uevent called for event1
class_uevent - name = mouse0
class_device_create_uevent called for mouse0
class_uevent - name = input1
class_uevent - name = event0
class_device_create_uevent called for event0
class_uevent - name = input0
class_uevent - name = mice
class_device_create_uevent called for mice
class_uevent - name = usbdev8.2
class_device_create_uevent called for usbdev8.2
class_uevent - name = usbdev8.1
class_device_create_uevent called for usbdev8.1
class_uevent - name = usbdev7.1
class_device_create_uevent called for usbdev7.1
class_uevent - name = usbdev6.1
class_device_create_uevent called for usbdev6.1
class_uevent - name = usbdev5.1
class_device_create_uevent called for usbdev5.1
class_uevent - name = usbdev4.1
class_device_create_uevent called for usbdev4.1
class_uevent - name = usbdev3.1
class_device_create_uevent called for usbdev3.1
class_uevent - name = usbdev2.1
class_device_create_uevent called for usbdev2.1
class_uevent - name = usbdev1.1
class_device_create_uevent called for usbdev1.1
class_uevent - name = usb_host8
class_device_create_uevent called for usb_host8
class_uevent - name = usb_host7
class_device_create_uevent called for usb_host7
class_uevent - name = usb_host6
class_device_create_uevent called for usb_host6
class_uevent - name = usb_host5
class_device_create_uevent called for usb_host5
class_uevent - name = usb_host4
class_device_create_uevent called for usb_host4
class_uevent - name = usb_host3
class_device_create_uevent called for usb_host3
class_uevent - name = usb_host2
class_device_create_uevent called for usb_host2
class_uevent - name = usb_host1
class_device_create_uevent called for usb_host1
class_uevent - name = nvram
class_device_create_uevent called for nvram
class_uevent - name = rtc
class_device_create_uevent called for rtc
class_uevent - name = device-mapper
class_device_create_uevent called for device-mapper
class_uevent - name = psaux
class_device_create_uevent called for psaux
class_uevent - name = hpet
class_device_create_uevent called for hpet
class_uevent - name = fbcon
class_device_create_uevent called for fbcon
class_uevent - name = vtcon0
class_device_create_uevent called for vtcon0
class_uevent - name = 0000:04
class_uevent - name = 0000:02
class_uevent - name = 0000:03
class_uevent - name = 0000:01
class_uevent - name = 0000:00
eth0:  setting full-duplex.
audit(1218056971.328:2): audit_pid=7531 old=0 by auid=4294967295
bus type 'i2c' registered
bus i2c: add driver i2c_adapter
device class 'i2c-adapter': registering
i2c /dev entries driver
device class 'i2c-dev': registering
bus i2c: add driver dev_driver
CLASS: registering class device: ID = 'vcs1'
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
CLASS: registering class device: ID = 'vcsa1'
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
CLASS: Unregistering class device. ID = 'vcs1'
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
device class 'vcs1': release.
class_device_create_release called for vcs1
CLASS: Unregistering class device. ID = 'vcsa1'
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
device class 'vcsa1': release.
class_device_create_release called for vcsa1
CLASS: registering class device: ID = 'vcs1'
class_uevent - name = vcs1
class_device_create_uevent called for vcs1
CLASS: registering class device: ID = 'vcsa1'
class_uevent - name = vcsa1
class_device_create_uevent called for vcsa1
CLASS: registering class device: ID = 'vcs3'
class_uevent - name = vcs3
class_device_create_uevent called for vcs3
CLASS: registering class device: ID = 'vcsa3'
class_uevent - name = vcsa3
class_device_create_uevent called for vcsa3
CLASS: Unregistering class device. ID = 'vcs3'
class_uevent - name = vcs3
class_device_create_uevent called for vcs3
device class 'vcs3': release.
class_device_create_release called for vcs3
CLASS: Unregistering class device. ID = 'vcsa3'
class_uevent - name = vcsa3
class_device_create_uevent called for vcsa3
device class 'vcsa3': release.
class_device_create_release called for vcsa3
CLASS: registering class device: ID = 'vcs3'
class_uevent - name = vcs3
class_device_create_uevent called for vcs3
CLASS: registering class device: ID = 'vcsa3'
class_uevent - name = vcsa3
class_device_create_uevent called for vcsa3
CLASS: registering class device: ID = 'vcs4'
class_uevent - name = vcs4
class_device_create_uevent called for vcs4
CLASS: registering class device: ID = 'vcsa4'
class_uevent - name = vcsa4
class_device_create_uevent called for vcsa4
CLASS: registering class device: ID = 'vcs2'
class_uevent - name = vcs2
class_device_create_uevent called for vcs2
CLASS: registering class device: ID = 'vcsa2'
class_uevent - name = vcsa2
class_device_create_uevent called for vcsa2
CLASS: Unregistering class device. ID = 'vcs4'
class_uevent - name = vcs4
class_device_create_uevent called for vcs4
device class 'vcs4': release.
class_device_create_release called for vcs4
CLASS: Unregistering class device. ID = 'vcsa4'
class_uevent - name = vcsa4
class_device_create_uevent called for vcsa4
device class 'vcsa4': release.
class_device_create_release called for vcsa4
CLASS: registering class device: ID = 'vcs4'
class_uevent - name = vcs4
class_device_create_uevent called for vcs4
CLASS: registering class device: ID = 'vcsa4'
class_uevent - name = vcsa4
class_device_create_uevent called for vcsa4
CLASS: Unregistering class device. ID = 'vcs2'
class_uevent - name = vcs2
class_device_create_uevent called for vcs2
device class 'vcs2': release.
class_device_create_release called for vcs2
CLASS: Unregistering class device. ID = 'vcsa2'
class_uevent - name = vcsa2
class_device_create_uevent called for vcsa2
device class 'vcsa2': release.
class_device_create_release called for vcsa2
CLASS: registering class device: ID = 'vcs2'
class_uevent - name = vcs2
class_device_create_uevent called for vcs2
CLASS: registering class device: ID = 'vcsa2'
class_uevent - name = vcsa2
class_device_create_uevent called for vcsa2
CLASS: registering class device: ID = 'vcs5'
class_uevent - name = vcs5
class_device_create_uevent called for vcs5
CLASS: registering class device: ID = 'vcsa5'
class_uevent - name = vcsa5
class_device_create_uevent called for vcsa5
CLASS: Unregistering class device. ID = 'vcs5'
class_uevent - name = vcs5
class_device_create_uevent called for vcs5
device class 'vcs5': release.
class_device_create_release called for vcs5
CLASS: Unregistering class device. ID = 'vcsa5'
class_uevent - name = vcsa5
class_device_create_uevent called for vcsa5
device class 'vcsa5': release.
class_device_create_release called for vcsa5
CLASS: registering class device: ID = 'vcs5'
class_uevent - name = vcs5
class_device_create_uevent called for vcs5
CLASS: registering class device: ID = 'vcsa5'
class_uevent - name = vcsa5
class_device_create_uevent called for vcsa5
CLASS: registering class device: ID = 'vcs6'
class_uevent - name = vcs6
class_device_create_uevent called for vcs6
CLASS: registering class device: ID = 'vcsa6'
class_uevent - name = vcsa6
class_device_create_uevent called for vcsa6
CLASS: Unregistering class device. ID = 'vcs6'
class_uevent - name = vcs6
class_device_create_uevent called for vcs6
device class 'vcs6': release.
class_device_create_release called for vcs6
CLASS: Unregistering class device. ID = 'vcsa6'
class_uevent - name = vcsa6
class_device_create_uevent called for vcsa6
device class 'vcsa6': release.
class_device_create_release called for vcsa6
CLASS: registering class device: ID = 'vcs6'
class_uevent - name = vcs6
class_device_create_uevent called for vcs6
CLASS: registering class device: ID = 'vcsa6'
class_uevent - name = vcsa6
class_device_create_uevent called for vcsa6
CLASS: Unregistering class device. ID = 'vcs8'
class_uevent - name = vcs8
class_device_create_uevent called for vcs8
device class 'vcs8': release.
class_device_create_release called for vcs8
CLASS: Unregistering class device. ID = 'vcsa8'
class_uevent - name = vcsa8
class_device_create_uevent called for vcsa8
device class 'vcsa8': release.
class_device_create_release called for vcsa8
CLASS: registering class device: ID = 'vcs7'
class_uevent - name = vcs7
class_device_create_uevent called for vcs7
CLASS: registering class device: ID = 'vcsa7'
class_uevent - name = vcsa7
class_device_create_uevent called for vcsa7
CLASS: Unregistering class device. ID = 'vcs7'
class_uevent - name = vcs7
class_device_create_uevent called for vcs7
device class 'vcs7': release.
class_device_create_release called for vcs7
CLASS: Unregistering class device. ID = 'vcsa7'
class_uevent - name = vcsa7
class_device_create_uevent called for vcsa7
device class 'vcsa7': release.
class_device_create_release called for vcsa7
CLASS: registering class device: ID = 'vcs7'
class_uevent - name = vcs7
class_device_create_uevent called for vcs7
CLASS: registering class device: ID = 'vcsa7'
class_uevent - name = vcsa7
class_device_create_uevent called for vcsa7

-----------------------------113371545712287--

