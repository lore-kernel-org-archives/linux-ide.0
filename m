From: Marco Gatti <marco@pianoinflames.de>
Subject: Re: Bug: get EXT3-fs error Allocating block in system zone
Date: Thu, 31 Jan 2008 19:46:52 +0100
Message-ID: <47A2179C.6040009@pianoinflames.de>
References: <fa.LkmHGN+Fx6H930bfeCDU6pGdBKM@ifi.uio.no> <fa.oSqMiIX7WubypXrhZGaRKU5wNGU@ifi.uio.no> <fa.0pc9/nNmTq+eWIU9rADRn0xYGdI@ifi.uio.no> <fa.hqM73i24f6G31R5F3sKL8+3H8Ww@ifi.uio.no> <475C2C02.70001@shaw.ca> <alpine.LFD.0.9999.0712091057200.12046@woody.linux-foundation.org> <20071209190913.GB13382@kernel.dk> <475C48EE.8020701@pianoinflames.de> <20071209200440.GC13382@kernel.dk> <475C536B.5070409@pianoinflames.de> <20071209210137.GD13382@kernel.dk> <475D7F03.7050100@pianoinflames.de> <alpine.LFD.0.9999.0712101009410.28293@woody.linux-foundation.org> <475DD2EB.8030606@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from echo836.server4you.de ([85.25.140.112]:35302 "EHLO
	mail.pianoinflames.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758444AbYAaTHk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Jan 2008 14:07:40 -0500
In-Reply-To: <475DD2EB.8030606@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Greg KH <greg@kroah.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>

Robert Hancock schrieb:
> Linus Torvalds wrote:
>>
>> On Mon, 10 Dec 2007, Marco Gatti wrote:
>>> I didn't compile completly.
>>>
>>> drivers/scsi/scsi_lib.c:1565:1: error: unterminated #else
>>
>> Heh. That #else should be an #endif, of course.
>>
>> It is a bit strange that it still tries to do IO to high memory. 
>> Either the whole "64 bit capability" thing in AHCI is broken, or the 
>> bounce buffering doesn't work right. Or maybe you tried the 
>> "iommu=off" without the original patch that tried to turn off 64-bit DMA?
>>
>>         Linus
>>
> 
>  From what I can see, it appears that iommu=off disables the IOMMU but 
> doesn't actually do anything to prevent attempts to DMA above 4GB. If 
> you try to map something over 4GB it just chokes with that mask overflow 
> (in arch/x86/kernel/pci-nommu_64.c).
> 
> The iommu=off option actually seems rather useless, as it's the default 
> in the only case where it will actually work (no memory above 4GB)..
> 

Hi,

finally got a BIOS update from Fujitsu-Siemens-Computers that solved 
that problem. Now it works with 2.6.24.

if interesting I added dmesg here:

Linux version 2.6.24 (root@adira) (gcc version 4.1.1 (Gentoo 4.1.1-r3)) 
#2 SMP Thu Jan 31 19:38:52 CET 2008
Command line: root=/dev/sda3 udev
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009c800 (usable)
  BIOS-e820: 000000000009c800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000ce000 - 00000000000d0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000df5b0000 (usable)
  BIOS-e820: 00000000df5b0000 - 00000000df5c4000 (ACPI data)
  BIOS-e820: 00000000df5c4000 - 00000000df5c7000 (ACPI NVS)
  BIOS-e820: 00000000df5c7000 - 00000000e0000000 (reserved)
  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
  BIOS-e820: 0000000100000000 - 000000020e000000 (usable)
  BIOS-e820: 000000020e000000 - 0000000210000000 (reserved)
Entering add_active_range(0, 0, 156) 0 entries of 3200 used
Entering add_active_range(0, 256, 914864) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 2154496) 2 entries of 3200 used
end_pfn_map = 2162688
DMI present.
ACPI: RSDP 000F7350, 0014 (r0 PTLTD )
ACPI: RSDT DF5BEDF9, 0058 (r1 PTLTD    RSDT      60000  LTP        0)
ACPI: FACP DF5C3AF3, 0074 (r1 FSC                60000         F4240)
ACPI: DSDT DF5BEE51, 4CA2 (r1 FSC    D2587/A1    60000 MSFT  3000001)
ACPI: FACS DF5C6FC0, 0040
ACPI: TCPA DF5C3B67, 0032 (r1 Phoeni  x          60000  TL         0)
ACPI: _MAR DF5C3B99, 0030 (r1 Intel  OEMDMAR     60000 LOHR        1)
ACPI: SSDT DF5C3BC9, 007A (r1 FSC    CST_CPU0    60000  CSF        1)
ACPI: SSDT DF5C3C43, 007A (r1 FSC    CST_CPU1    60000  CSF        1)
ACPI: SSDT DF5C3CBD, 00B6 (r1 FSC    PST_CPU0    60000  CSF        1)
ACPI: SSDT DF5C3D73, 00B6 (r1 FSC    PST_CPU1    60000  CSF        1)
ACPI: SPCR DF5C3E29, 0050 (r1 PTLTD  $UCRTBL$    60000 PTL         1)
ACPI: MCFG DF5C3E79, 003C (r1 PTLTD    MCFG      60000  LTP        0)
ACPI: HPET DF5C3EB5, 0038 (r1 PTLTD  HPETTBL     60000  LTP        1)
ACPI: APIC DF5C3EED, 0068 (r1 PTLTD  	 APIC      60000  LTP        0)
ACPI: BOOT DF5C3F55, 0028 (r1 PTLTD  $SBFTBL$    60000  LTP        1)
ACPI: ASF! DF5C3F7D, 0083 (r16   CETP     CETP    60000 PTL         1)
ACPI: DMI detected: Fujitsu Siemens
No NUMA configuration found
Faking a node at 0000000000000000-000000020e000000
Entering add_active_range(0, 0, 156) 0 entries of 3200 used
Entering add_active_range(0, 256, 914864) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 2154496) 2 entries of 3200 used
Bootmem setup node 0 0000000000000000-000000020e000000
  [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001200000 on node 0
  [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001600000 on node 0
  [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001a00000 on node 0
  [ffffe20000600000-ffffe200007fffff] PMD ->ffff810001e00000 on node 0
  [ffffe20000800000-ffffe200009fffff] PMD ->ffff810002200000 on node 0
  [ffffe20000a00000-ffffe20000bfffff] PMD ->ffff810002600000 on node 0
  [ffffe20000c00000-ffffe20000dfffff] PMD ->ffff810002a00000 on node 0
  [ffffe20000e00000-ffffe20000ffffff] PMD ->ffff810002e00000 on node 0
  [ffffe20001000000-ffffe200011fffff] PMD ->ffff810003200000 on node 0
  [ffffe20001200000-ffffe200013fffff] PMD ->ffff810003600000 on node 0
  [ffffe20001400000-ffffe200015fffff] PMD ->ffff810003a00000 on node 0
  [ffffe20001600000-ffffe200017fffff] PMD ->ffff810003e00000 on node 0
  [ffffe20001800000-ffffe200019fffff] PMD ->ffff810004200000 on node 0
  [ffffe20001a00000-ffffe20001bfffff] PMD ->ffff810004600000 on node 0
  [ffffe20001c00000-ffffe20001dfffff] PMD ->ffff810004a00000 on node 0
  [ffffe20001e00000-ffffe20001ffffff] PMD ->ffff810004e00000 on node 0
  [ffffe20002000000-ffffe200021fffff] PMD ->ffff810005200000 on node 0
  [ffffe20002200000-ffffe200023fffff] PMD ->ffff810005600000 on node 0
  [ffffe20002400000-ffffe200025fffff] PMD ->ffff810005a00000 on node 0
  [ffffe20002600000-ffffe200027fffff] PMD ->ffff810005e00000 on node 0
  [ffffe20002800000-ffffe200029fffff] PMD ->ffff810006200000 on node 0
  [ffffe20002a00000-ffffe20002bfffff] PMD ->ffff810006600000 on node 0
  [ffffe20002c00000-ffffe20002dfffff] PMD ->ffff810006a00000 on node 0
  [ffffe20002e00000-ffffe20002ffffff] PMD ->ffff810006e00000 on node 0
  [ffffe20003000000-ffffe200031fffff] PMD ->ffff810007200000 on node 0
  [ffffe20003800000-ffffe200039fffff] PMD ->ffff810007600000 on node 0
  [ffffe20003a00000-ffffe20003bfffff] PMD ->ffff810007a00000 on node 0
  [ffffe20003c00000-ffffe20003dfffff] PMD ->ffff810007e00000 on node 0
  [ffffe20003e00000-ffffe20003ffffff] PMD ->ffff810008200000 on node 0
  [ffffe20004000000-ffffe200041fffff] PMD ->ffff810008600000 on node 0
  [ffffe20004200000-ffffe200043fffff] PMD ->ffff810008a00000 on node 0
  [ffffe20004400000-ffffe200045fffff] PMD ->ffff810008e00000 on node 0
  [ffffe20004600000-ffffe200047fffff] PMD ->ffff810009200000 on node 0
  [ffffe20004800000-ffffe200049fffff] PMD ->ffff810009600000 on node 0
  [ffffe20004a00000-ffffe20004bfffff] PMD ->ffff810009a00000 on node 0
  [ffffe20004c00000-ffffe20004dfffff] PMD ->ffff810009e00000 on node 0
  [ffffe20004e00000-ffffe20004ffffff] PMD ->ffff81000a200000 on node 0
  [ffffe20005000000-ffffe200051fffff] PMD ->ffff81000a600000 on node 0
  [ffffe20005200000-ffffe200053fffff] PMD ->ffff81000aa00000 on node 0
  [ffffe20005400000-ffffe200055fffff] PMD ->ffff81000ae00000 on node 0
  [ffffe20005600000-ffffe200057fffff] PMD ->ffff81000b200000 on node 0
  [ffffe20005800000-ffffe200059fffff] PMD ->ffff81000b600000 on node 0
  [ffffe20005a00000-ffffe20005bfffff] PMD ->ffff81000ba00000 on node 0
  [ffffe20005c00000-ffffe20005dfffff] PMD ->ffff81000be00000 on node 0
  [ffffe20005e00000-ffffe20005ffffff] PMD ->ffff81000c200000 on node 0
  [ffffe20006000000-ffffe200061fffff] PMD ->ffff81000c600000 on node 0
  [ffffe20006200000-ffffe200063fffff] PMD ->ffff81000ca00000 on node 0
  [ffffe20006400000-ffffe200065fffff] PMD ->ffff81000ce00000 on node 0
  [ffffe20006600000-ffffe200067fffff] PMD ->ffff81000d200000 on node 0
  [ffffe20006800000-ffffe200069fffff] PMD ->ffff81000d600000 on node 0
  [ffffe20006a00000-ffffe20006bfffff] PMD ->ffff81000da00000 on node 0
  [ffffe20006c00000-ffffe20006dfffff] PMD ->ffff81000de00000 on node 0
  [ffffe20006e00000-ffffe20006ffffff] PMD ->ffff81000e200000 on node 0
  [ffffe20007000000-ffffe200071fffff] PMD ->ffff81000e600000 on node 0
  [ffffe20007200000-ffffe200073fffff] PMD ->ffff81000ea00000 on node 0
Zone PFN ranges:
   DMA             0 ->     4096
   DMA32        4096 ->  1048576
   Normal    1048576 ->  2154496
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
     0:        0 ->      156
     0:      256 ->   914864
     0:  1048576 ->  2154496
On node 0 totalpages: 2020684
   DMA zone: 56 pages used for memmap
   DMA zone: 1802 pages reserved
   DMA zone: 2138 pages, LIFO batch:0
   DMA32 zone: 14280 pages used for memmap
   DMA32 zone: 896488 pages, LIFO batch:31
   Normal zone: 15120 pages used for memmap
   Normal zone: 1090800 pages, LIFO batch:31
   Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 000000000009c000 - 000000000009d000
swsusp: Registered nosave memory region: 000000000009d000 - 00000000000a0000
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000ce000
swsusp: Registered nosave memory region: 00000000000ce000 - 00000000000d0000
swsusp: Registered nosave memory region: 00000000000d0000 - 00000000000e0000
swsusp: Registered nosave memory region: 00000000000e0000 - 0000000000100000
swsusp: Registered nosave memory region: 00000000df5b0000 - 00000000df5c4000
swsusp: Registered nosave memory region: 00000000df5c4000 - 00000000df5c7000
swsusp: Registered nosave memory region: 00000000df5c7000 - 00000000e0000000
swsusp: Registered nosave memory region: 00000000e0000000 - 00000000f8000000
swsusp: Registered nosave memory region: 00000000f8000000 - 00000000fc000000
swsusp: Registered nosave memory region: 00000000fc000000 - 00000000fec00000
swsusp: Registered nosave memory region: 00000000fec00000 - 00000000fec10000
swsusp: Registered nosave memory region: 00000000fec10000 - 00000000fee00000
swsusp: Registered nosave memory region: 00000000fee00000 - 00000000fee01000
swsusp: Registered nosave memory region: 00000000fee01000 - 00000000ffb00000
swsusp: Registered nosave memory region: 00000000ffb00000 - 0000000100000000
Allocating PCI resources starting at e2000000 (gap: e0000000:18000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 29856 bytes of per cpu data
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 1989426
Policy zone: Normal
Kernel command line: root=/dev/sda3 udev
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
hpet clockevent registered
TSC calibrated against HPET
time.c: Detected 2327.500 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0xec31000 - 0x12c31000
Memory: 7896128k/8617984k available (3696k kernel code, 186608k 
reserved, 2520k data, 336k init)
Calibrating delay using timer specific routine.. 4658.53 BogoMIPS 
(lpj=2329269)
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM2)
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
APIC timer calibration result 20781241
Detected 20.781 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4654.98 BogoMIPS 
(lpj=2327494)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU1: Thermal monitoring enabled (TM2)
Intel(R) Core(TM)2 Duo CPU     E6550  @ 2.33GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
net_namespace: 120 bytes
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at f8000000 - f83fffff
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: Device [LPT] status [00000008]: functional but not present; 
setting present
ACPI: Device [ECP] status [00000008]: functional but not present; 
setting present
ACPI: Device [COM2] status [00000008]: functional but not present; 
setting present
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEXA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEXB._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEXC._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIH._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 7 9 10 11 12 14 15) *5
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 7 9 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI: Cannot allocate resource region 7 of bridge 0000:00:01.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.0
PCI: Cannot allocate resource region 7 of bridge 0000:00:1c.4
PCI-GART: No AMD northbridge found.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
hpet0: 4 64-bit timers, 14318180 Hz
Time: tsc clocksource has been installed.
system 00:03: ioport range 0x4d0-0x4d1 has been reserved
system 00:03: ioport range 0x1000-0x107f has been reserved
system 00:03: ioport range 0x1100-0x110f has been reserved
system 00:03: ioport range 0x1180-0x11bf has been reserved
system 00:03: ioport range 0x500-0x57f has been reserved
system 00:03: ioport range 0x800-0x80f has been reserved
system 00:03: ioport range 0x810-0x81f has been reserved
system 00:03: ioport range 0xfe00-0xfe00 has been reserved
system 00:03: ioport range 0xff00-0xff00 has been reserved
system 00:03: iomem range 0xfec00000-0xfecfffff could not be reserved
system 00:03: iomem range 0xfee00000-0xfeefffff could not be reserved
system 00:03: iomem range 0xf8000000-0xfbffffff could not be reserved
system 00:03: iomem range 0xfed19000-0xfed19fff has been reserved
system 00:03: iomem range 0xfed14000-0xfed17fff has been reserved
system 00:03: iomem range 0xfed18000-0xfed18fff has been reserved
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.4
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.4[B] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1c.4 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
Simple Boot Flag at 0x43 set to 0x1
Total HugeTLB memory allocated, 0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:00:02.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
Allocate Port Service[0000:00:1c.4:pcie03]
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input1
ACPI: Power Button (CM) [PWRB]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: CPU1 (power states: C1[C1] C2[C2])
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is 
not present [20070126]
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is 
not present [20070126]
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is 
not present [20070126]
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is 
not present [20070126]
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is 
not present [20070126]
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is 
not present [20070126]
Real Time Clock Driver v1.12ac
hpet_resources: 0xfed00000 is busy
Linux agpgart interface v0.102
agpgart: Detected an Intel Q35 Chipset.
agpgart: Detected 7164K stolen memory.
agpgart: AGP aperture is 256M @ 0xe0000000
tpm_tis 00:01: 1.2 TPM (device-id 0xB, rev-id 16)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt 0000:00:03.3[B] -> GSI 17 (level, low) -> IRQ 17
0000:00:03.3: ttyS1 at I/O 0x1c90 (irq = 17) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: module loaded
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver - 0.2.0
e1000e: Copyright (c) 1999-2007 Intel Corporation.
ACPI: PCI Interrupt 0000:00:19.0[A] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:19.0 to 64
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:19:99:13:ca:4f
0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
0000:00:19.0: eth0: MAC: 5, PHY: 6, PBA No: ffffff-0ff
sk98lin: driver has been replaced by the skge driver and is scheduled 
for removal
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
CSLIP: code copyright 1989 Regents of the University of California.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
console [netcon0] enabled
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Probing IDE interface ide0...
Probing IDE interface ide1...
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
ahci 0000:00:1f.2: version 3.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA 
mode
ahci 0000:00:1f.2: flags: 64bit ncq sntf led clo pmp pio slum part
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
scsi4 : ahci
scsi5 : ahci
ata1: SATA max UDMA/133 abar m2048@0xf03a6000 port 0xf03a6100 irq 316
ata2: SATA max UDMA/133 abar m2048@0xf03a6000 port 0xf03a6180 irq 316
ata3: SATA max UDMA/133 abar m2048@0xf03a6000 port 0xf03a6200 irq 316
ata4: SATA max UDMA/133 abar m2048@0xf03a6000 port 0xf03a6280 irq 316
ata5: SATA max UDMA/133 abar m2048@0xf03a6000 port 0xf03a6300 irq 316
ata6: SATA max UDMA/133 abar m2048@0xf03a6000 port 0xf03a6380 irq 316
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7: ST380815AS, 3.AAA, max UDMA/133
ata1.00: 156301488 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATAPI: Optiarc DVD-ROM DDU1671S, 1.81, max UDMA/33, ATAPI AN
ata2.00: applying bridge limits
ata2.00: configured for UDMA/33
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata4.00: ATA-8: WDC WD5000AAKS-65YGA0, 12.01C02, max UDMA/133
ata4.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata4.00: configured for UDMA/133
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      ST380815AS       3.AA PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            Optiarc  DVD-ROM DDU1671S 1.81 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 4x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
scsi 3:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-6 12.0 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdb: sdb1 sdb2 sdb3 sdb4
sd 3:0:0:0: [sdb] Attached SCSI disk
sd 3:0:0:0: Attached scsi generic sg2 type 0
Fusion MPT base driver 3.04.06
Copyright (c) 1999-2007 LSI Corporation
Fusion MPT SPI Host driver 3.04.06
ieee1394: raw1394: /dev/raw1394 device initialized
ACPI: PCI Interrupt 0000:00:1a.7[B] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf03a7000
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 20, io mem 0xf03a7400
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 6 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1a.0: irq 20, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1a.1: irq 18, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1a.2[C] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1a.2 to 64
uhci_hcd 0000:00:1a.2: UHCI Host Controller
uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1a.2: irq 19, io base 0x00001880
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:1d.0: irq 20, io base 0x000018a0
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:1d.1: irq 22, io base 0x000018c0
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
usb 4-2: new low speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:1d.2: irq 21, io base 0x000018e0
usb usb8: configuration #1 chosen from 1 choice
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
usb 4-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usblp
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
PNP: PS/2 Controller [PNP0303:KEYB,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
coretemp coretemp.0: Using undocumented features, absolute temperature 
might be wrong!
coretemp coretemp.1: Using undocumented features, absolute temperature 
might be wrong!
device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: 
dm-devel@redhat.com
cpuidle: using governor ladder
cpuidle: using governor menu
Marking TSC unstable due to TSC halts in idle
Time: hpet clocksource has been installed.
input: Logitech USB Receiver as /class/input/input2
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:1a.1-2
Fixing up Logitech keyboard report descriptor
input: Logitech USB Receiver as /class/input/input3
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:1a.1-2
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20 
19:16:42 2007 UTC).
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC262, trying auto-probe from BIOS...
ALSA device list:
   #0: HDA Intel at 0xf01a0000 irq 20
oprofile: using NMI interrupt.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 336k freed
EXT3 FS on sda3, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Can't find ext3 filesystem on dev sdb4.
Adding 2000084k swap on /dev/sda2.  Priority:-1 extents:1 across:2000084k
ADDRCONF(NETDEV_UP): eth0: link is not ready
0000:00:19.0: eth0: Link is Up 100 Mbps Full Duplex, Flow Control: RX
0000:00:19.0: eth0: 10/100 speed: disabling TSO
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
vmmon: module license 'unspecified' taints kernel.
/dev/vmmon[5040]: Module vmmon: registered with major=10 minor=165
/dev/vmmon[5040]: Module vmmon: initialized
/dev/vmnet: open called by PID 5068 (vmnet-bridge)
/dev/vmnet: hub 0 does not exist, allocating memory.
/dev/vmnet: port on hub 0 successfully opened
bridge-eth0: enabling the bridge
bridge-eth0: up
bridge-eth0: already up
bridge-eth0: attached
/dev/vmnet: open called by PID 5084 (vmnet-netifup)
/dev/vmnet: hub 1 does not exist, allocating memory.
/dev/vmnet: port on hub 1 successfully opened
/dev/vmnet: open called by PID 5083 (vmnet-netifup)
/dev/vmnet: hub 8 does not exist, allocating memory.
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 5082 (vmnet-natd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 5110 (vmnet-dhcpd)
/dev/vmnet: port on hub 8 successfully opened
/dev/vmnet: open called by PID 5112 (vmnet-dhcpd)
/dev/vmnet: port on hub 1 successfully opened
eth0: no IPv6 routers present
vmnet8: no IPv6 routers present
vmnet1: no IPv6 routers present
sd 3:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sdb: sdb1
ext3: No journal on filesystem on sdb1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
/dev/vmmon[5450]: Module vmmon: unloaded
bridge-eth0: down
bridge-eth0: detached

Cheers,
Marco
