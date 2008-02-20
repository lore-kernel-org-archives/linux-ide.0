From: Johann-Christoph Jacob <johann-christoph.jacob@fhtw-berlin.de>
Subject: Re: sata_sil24 not configuring drive right?
Date: Wed, 20 Feb 2008 20:19:35 +0100
Message-ID: <47BC7D47.9060608@fhtw-berlin.de>
References: <47BB8346.4070400@fhtw-berlin.de> <47BBA66C.7050900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.rz.fhtw-berlin.de ([141.45.10.102]:64571 "EHLO
	mail2.rz.fhtw-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934129AbYBTUbj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Feb 2008 15:31:39 -0500
In-Reply-To: <47BBA66C.7050900@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello again,

my problem is not with the transfer mode but with the NCQ queue_depth.
My bootlog shows:
ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 1)
but i would like it to show:
ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 31/32)
or something similar.
I was not exact enough concerning the writeability of
/sys/block/sda/device/queue_depth
The file is not read only but writing to it fails:
echo 31 > /sys/block/sda/device/queue_depth
bash: echo: write error: Invalid argument

Syslog appended after quotes (in lack of bootlog)

Greetings
Johann-Christoph Jacob


Tejun Heo wrote:
> Hello, can you please cc linux-ide@vger.kernel.org?
> 
> Johann-Christoph Jacob wrote:
>> 00:1f.2 SATA controller: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA AHCI Controller (rev 02) (prog-if 01 [AHCI 1.0])
>>         Subsystem: Fujitsu Siemens Computer GmbH Unknown device 10ad
> 
> Okay, ICH7 AHCI.
> 
>> From /var/log/kern.log:
>>
>> ahci 0000:00:1f.2: version 3.0
>> ahci 0000:00:1f.2: nr_ports (4) and implemented port map (0x5) don't match, using nr_ports
>> ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
>> ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
>> ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
>> scsi0 : ahci
>> scsi1 : ahci
>> scsi2 : ahci
>> scsi3 : ahci
>> ata1: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444500 irq 220
>> ata2: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444580 irq 220
>> ata3: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444600 irq 220
>> ata4: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444680 irq 220
>> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ata1.00: ATA-7: WDC WD1200BEVS-07LAT0, 01.06M01, max UDMA/133
>> ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 1)
> 
> Hmm.. Can you please post boot log from 2.6.24?
> 
>> ata1.00: configured for UDMA/133
> 
>> From hdparm -I /dev/sda:
>>
>> /dev/sda:
>>
>> ATA device, with non-removable media
>>         Model Number:       WDC WD1200BEVS-07LAT0                   
>>         Serial Number:      WD-WXE906801963
>>         Firmware Revision:  01.06M01
>> Standards:
>>         Supported: 7 6 5 4 
>>         Likely used: 7
>> Configuration:
>>         Logical         max     current
>>         cylinders       16383   16383
>>         heads           16      16
>>         sectors/track   63      63
>>         --
>>         CHS current addressable sectors:   16514064
>>         LBA    user addressable sectors:  234441648
>>         LBA48  user addressable sectors:  234441648
>>         device size with M = 1024*1024:      114473 MBytes
>>         device size with M = 1000*1000:      120034 MBytes (120 GB)
>> Capabilities:
>>         LBA, IORDY(can be disabled)
>>         Queue depth: 1
>>         Standby timer values: spec'd by Standard, with device specific minimum
>>         R/W multiple sector transfer: Max = 16  Current = 16
>>         Advanced power management level: unknown setting (0x00fe)
>>         Recommended acoustic management value: 128, current value: 128
>>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
> 
> Transfer mode is configured correctly.  Nothing to worry about there.
> 
> Thanks.


/var/log/syslog for current run:

Feb 20 17:23:40 amilo syslogd 1.5.0#1.1: restart.
Feb 20 17:23:40 amilo kernel: klogd 1.5.0#1.1, log source = /proc/kmsg started.
Feb 20 17:23:40 amilo kernel: Linux version 2.6.24.2 (root@amilo) (gcc version 4.2.3 20080114 (prerelease) (Debian 4.2.2-7)) #1 SMP PREEMPT Mon Feb 11 22:01:11 CET 2008
Feb 20 17:23:40 amilo kernel: BIOS-provided physical RAM map:
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 0000000000100000 - 000000007f690000 (usable)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 000000007f690000 - 000000007f700000 (ACPI NVS)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 000000007f700000 - 0000000080000000 (reserved)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Feb 20 17:23:40 amilo kernel:  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
Feb 20 17:23:40 amilo kernel: 1142MB HIGHMEM available.
Feb 20 17:23:40 amilo kernel: 896MB LOWMEM available.
Feb 20 17:23:40 amilo kernel: found SMP MP-table at 000f7640
Feb 20 17:23:40 amilo kernel: Entering add_active_range(0, 0, 521872) 0 entries of 256 used
Feb 20 17:23:40 amilo kernel: Zone PFN ranges:
Feb 20 17:23:40 amilo kernel:   DMA             0 ->     4096
Feb 20 17:23:40 amilo kernel:   Normal       4096 ->   229376
Feb 20 17:23:40 amilo kernel:   HighMem    229376 ->   521872
Feb 20 17:23:40 amilo kernel: Movable zone start PFN for each node
Feb 20 17:23:40 amilo kernel: early_node_map[1] active PFN ranges
Feb 20 17:23:40 amilo kernel:     0:        0 ->   521872
Feb 20 17:23:40 amilo kernel: On node 0 totalpages: 521872
Feb 20 17:23:40 amilo kernel:   DMA zone: 32 pages used for memmap
Feb 20 17:23:40 amilo kernel:   DMA zone: 0 pages reserved
Feb 20 17:23:40 amilo kernel:   DMA zone: 4064 pages, LIFO batch:0
Feb 20 17:23:40 amilo kernel:   Normal zone: 1760 pages used for memmap
Feb 20 17:23:40 amilo kernel:   Normal zone: 223520 pages, LIFO batch:31
Feb 20 17:23:40 amilo kernel:   HighMem zone: 2285 pages used for memmap
Feb 20 17:23:40 amilo kernel:   HighMem zone: 290211 pages, LIFO batch:31
Feb 20 17:23:40 amilo kernel:   Movable zone: 0 pages used for memmap
Feb 20 17:23:40 amilo kernel: DMI present.
Feb 20 17:23:40 amilo kernel: ACPI: RSDP 000F7500, 0014 (r0 PTLTD )
Feb 20 17:23:40 amilo kernel: ACPI: RSDT 7F691C1A, 0044 (r1 FSC    PC       20070214  LTP        0)
Feb 20 17:23:40 amilo kernel: ACPI: FACP 7F697CAA, 0074 (r1 FUJ___ DW1_____ 20070214 LOHR       5A)
Feb 20 17:23:40 amilo kernel: ACPI: DSDT 7F692626, 5684 (r1 FUJ___ DW1_____ 20070214 MSFT  100000E)
Feb 20 17:23:40 amilo kernel: ACPI: FACS 7F698FC0, 0040
Feb 20 17:23:40 amilo kernel: ACPI: APIC 7F697D1E, 0068 (r1 FUJ___ DW1_____ 20070214 LOHR       5A)
Feb 20 17:23:40 amilo kernel: ACPI: HPET 7F697D86, 0038 (r1 FUJ___ DW1_____ 20070214 LOHR       5A)
Feb 20 17:23:40 amilo kernel: ACPI: MCFG 7F697DBE, 003C (r1 FUJ___ DW1_____ 20070214 LOHR       5A)
Feb 20 17:23:40 amilo kernel: ACPI: APIC 7F697DFA, 0068 (r1 FUJ___ DW1_____ 20070214  LTP        0)
Feb 20 17:23:40 amilo kernel: ACPI: BOOT 7F697E62, 0028 (r1 FUJ___ DW1_____ 20070214  LTP        1)
Feb 20 17:23:40 amilo kernel: ACPI: SLIC 7F697E8A, 0176 (r1 FSC    PC       20070214  LTP        0)
Feb 20 17:23:40 amilo kernel: ACPI: SSDT 7F691C5E, 0500 (r1  PmRef    CpuPm     3000 INTL 20050228)
Feb 20 17:23:40 amilo kernel: ACPI: BIOS bug: multiple APIC/MADT found, using 0
Feb 20 17:23:40 amilo kernel: ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
Feb 20 17:23:40 amilo kernel: ACPI: DMI detected: Fujitsu Siemens
Feb 20 17:23:40 amilo kernel: ACPI: PM-Timer IO Port: 0x1008
Feb 20 17:23:40 amilo kernel: ACPI: Local APIC address 0xfee00000
Feb 20 17:23:40 amilo kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Feb 20 17:23:40 amilo kernel: Processor #0 6:15 APIC version 20
Feb 20 17:23:40 amilo kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Feb 20 17:23:40 amilo kernel: Processor #1 6:15 APIC version 20
Feb 20 17:23:40 amilo kernel: ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
Feb 20 17:23:40 amilo kernel: ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
Feb 20 17:23:40 amilo kernel: ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
Feb 20 17:23:40 amilo kernel: IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
Feb 20 17:23:40 amilo kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Feb 20 17:23:40 amilo kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Feb 20 17:23:40 amilo kernel: ACPI: IRQ0 used by override.
Feb 20 17:23:40 amilo kernel: ACPI: IRQ2 used by override.
Feb 20 17:23:40 amilo kernel: ACPI: IRQ9 used by override.
Feb 20 17:23:40 amilo kernel: Enabling APIC mode:  Flat.  Using 1 I/O APICs
Feb 20 17:23:40 amilo kernel: ACPI: HPET id: 0x8086a201 base: 0xfed00000
Feb 20 17:23:40 amilo kernel: Using ACPI (MADT) for SMP configuration information
Feb 20 17:23:40 amilo kernel: Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Feb 20 17:23:40 amilo kernel: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 517795
Feb 20 17:23:40 amilo kernel: Kernel command line: root=/dev/sda2 ro bootkbd=de
Feb 20 17:23:40 amilo kernel: mapped APIC to ffffb000 (fee00000)
Feb 20 17:23:40 amilo kernel: mapped IOAPIC to ffffa000 (fec00000)
Feb 20 17:23:40 amilo kernel: Enabling fast FPU save and restore... done.
Feb 20 17:23:40 amilo kernel: Enabling unmasked SIMD FPU exception support... done.
Feb 20 17:23:40 amilo kernel: Initializing CPU#0
Feb 20 17:23:40 amilo kernel: PID hash table entries: 4096 (order: 12, 16384 bytes)
Feb 20 17:23:40 amilo kernel: Detected 1995.808 MHz processor.
Feb 20 17:23:40 amilo kernel: Console: colour VGA+ 80x25
Feb 20 17:23:40 amilo kernel: console [tty0] enabled
Feb 20 17:23:40 amilo kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb 20 17:23:40 amilo kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb 20 17:23:40 amilo kernel: Memory: 2064984k/2087488k available (2673k kernel code, 21344k reserved, 868k data, 196k init, 1169984k highmem)
Feb 20 17:23:40 amilo kernel: virtual kernel memory layout:
Feb 20 17:23:40 amilo kernel:     fixmap  : 0xfff9b000 - 0xfffff000   ( 400 kB)
Feb 20 17:23:40 amilo kernel:     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
Feb 20 17:23:40 amilo kernel:     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
Feb 20 17:23:40 amilo kernel:     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
Feb 20 17:23:40 amilo kernel:       .init : 0xc057b000 - 0xc05ac000   ( 196 kB)
Feb 20 17:23:40 amilo kernel:       .data : 0xc049c79a - 0xc0575b34   ( 868 kB)
Feb 20 17:23:40 amilo kernel:       .text : 0xc0200000 - 0xc049c79a   (2673 kB)
Feb 20 17:23:40 amilo kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb 20 17:23:40 amilo kernel: SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
Feb 20 17:23:40 amilo kernel: hpet clockevent registered
Feb 20 17:23:41 amilo kernel: Calibrating delay using timer specific routine.. 3997.01 BogoMIPS (lpj=6659227)
Feb 20 17:23:41 amilo kernel: Mount-cache hash table entries: 512
Feb 20 17:23:41 amilo kernel: CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001 00000000
Feb 20 17:23:41 amilo kernel: monitor/mwait feature present.
Feb 20 17:23:41 amilo kernel: using mwait in idle threads.
Feb 20 17:23:41 amilo kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Feb 20 17:23:41 amilo kernel: CPU: L2 cache: 4096K
Feb 20 17:23:41 amilo kernel: CPU: Physical Processor ID: 0
Feb 20 17:23:41 amilo kernel: CPU: Processor Core ID: 0
Feb 20 17:23:41 amilo kernel: CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd 00000000 00000001 00000000
Feb 20 17:23:41 amilo kernel: Intel machine check architecture supported.
Feb 20 17:23:41 amilo kernel: Intel machine check reporting enabled on CPU#0.
Feb 20 17:23:41 amilo kernel: Compat vDSO mapped to ffffe000.
Feb 20 17:23:41 amilo kernel: Checking 'hlt' instruction... OK.
Feb 20 17:23:41 amilo kernel: SMP alternatives: switching to UP code
Feb 20 17:23:41 amilo kernel: ACPI: Core revision 20070126
Feb 20 17:23:41 amilo kernel: CPU0: Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz stepping 06
Feb 20 17:23:41 amilo kernel: SMP alternatives: switching to SMP code
Feb 20 17:23:41 amilo kernel: Booting processor 1/1 eip 3000
Feb 20 17:23:41 amilo kernel: Initializing CPU#1
Feb 20 17:23:41 amilo kernel: Calibrating delay using timer specific routine.. 3993.89 BogoMIPS (lpj=6652624)
Feb 20 17:23:41 amilo kernel: CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000e3bd 00000000 00000001 00000000
Feb 20 17:23:41 amilo kernel: monitor/mwait feature present.
Feb 20 17:23:41 amilo kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Feb 20 17:23:41 amilo kernel: CPU: L2 cache: 4096K
Feb 20 17:23:41 amilo kernel: CPU: Physical Processor ID: 0
Feb 20 17:23:41 amilo kernel: CPU: Processor Core ID: 1
Feb 20 17:23:41 amilo kernel: CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd 00000000 00000001 00000000
Feb 20 17:23:41 amilo kernel: Intel machine check architecture supported.
Feb 20 17:23:41 amilo kernel: Intel machine check reporting enabled on CPU#1.
Feb 20 17:23:41 amilo kernel: CPU1: Intel(R) Core(TM)2 CPU         T7200  @ 2.00GHz stepping 06
Feb 20 17:23:41 amilo kernel: Total of 2 processors activated (7990.90 BogoMIPS).
Feb 20 17:23:41 amilo kernel: ENABLING IO-APIC IRQs
Feb 20 17:23:41 amilo kernel: ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
Feb 20 17:23:41 amilo kernel: checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Feb 20 17:23:41 amilo kernel: Brought up 2 CPUs
Feb 20 17:23:41 amilo kernel: net_namespace: 64 bytes
Feb 20 17:23:41 amilo kernel: NET: Registered protocol family 16
Feb 20 17:23:41 amilo kernel: ACPI: bus type pci registered
Feb 20 17:23:41 amilo kernel: PCI: Using MMCONFIG
Feb 20 17:23:41 amilo kernel: Setting up standard PCI resources
Feb 20 17:23:41 amilo kernel: ACPI: EC: Look up EC in DSDT
Feb 20 17:23:41 amilo kernel: ACPI: BIOS _OSI(Linux) query ignored via DMI
Feb 20 17:23:41 amilo kernel: ACPI: Interpreter enabled
Feb 20 17:23:41 amilo kernel: ACPI: (supports S0 S3 S5)
Feb 20 17:23:41 amilo kernel: ACPI: Using IOAPIC for interrupt routing
Feb 20 17:23:41 amilo kernel: ACPI: EC: non-query interrupt received, switching to interrupt mode
Feb 20 17:23:41 amilo kernel: ACPI: EC: GPE = 0x17, I/O: command/status = 0x66, data = 0x62
Feb 20 17:23:41 amilo kernel: ACPI: EC: driver started in interrupt mode
Feb 20 17:23:41 amilo kernel: ACPI: PCI Root Bridge [PCI0] (0000:00)
Feb 20 17:23:41 amilo kernel: PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
Feb 20 17:23:41 amilo kernel: PCI quirk: region 1180-11bf claimed by ICH6 GPIO
Feb 20 17:23:41 amilo kernel: PCI: Transparent bridge - 0000:00:1e.0
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 *7 11 12 14 15)
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *7 10 12 14 15)
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 *10 12 14 15)
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *11 12 14 15)
Feb 20 17:23:41 amilo kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb 20 17:23:41 amilo kernel: pnp: PnP ACPI init
Feb 20 17:23:41 amilo kernel: ACPI: bus type pnp registered
Feb 20 17:23:41 amilo kernel: pnp: PnP ACPI: found 9 devices
Feb 20 17:23:41 amilo kernel: ACPI: ACPI bus type pnp unregistered
Feb 20 17:23:41 amilo kernel: SCSI subsystem initialized
Feb 20 17:23:41 amilo kernel: libata version 3.00 loaded.
Feb 20 17:23:41 amilo kernel: usbcore: registered new interface driver usbfs
Feb 20 17:23:41 amilo kernel: usbcore: registered new interface driver hub
Feb 20 17:23:41 amilo kernel: usbcore: registered new device driver usb
Feb 20 17:23:41 amilo kernel: PCI: Using ACPI for IRQ routing
Feb 20 17:23:41 amilo kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Feb 20 17:23:41 amilo kernel: hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
Feb 20 17:23:41 amilo kernel: hpet0: 3 64-bit timers, 14318180 Hz
Feb 20 17:23:41 amilo kernel: Time: tsc clocksource has been installed.
Feb 20 17:23:41 amilo kernel: system 00:01: iomem range 0xe0000000-0xefffffff could not be reserved
Feb 20 17:23:41 amilo kernel: system 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
Feb 20 17:23:41 amilo kernel: system 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
Feb 20 17:23:41 amilo kernel: system 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
Feb 20 17:23:41 amilo kernel: system 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
Feb 20 17:23:41 amilo kernel: system 00:01: iomem range 0xfed20000-0xfed3ffff could not be reserved
Feb 20 17:23:41 amilo kernel: system 00:01: iomem range 0xfed45000-0xfed8ffff could not be reserved
Feb 20 17:23:41 amilo kernel: system 00:05: ioport range 0x800-0x80f has been reserved
Feb 20 17:23:41 amilo kernel: system 00:05: ioport range 0x1000-0x107f has been reserved
Feb 20 17:23:41 amilo kernel: system 00:05: ioport range 0x1180-0x11bf has been reserved
Feb 20 17:23:41 amilo kernel: PCI: Bridge: 0000:00:1c.0
Feb 20 17:23:41 amilo kernel:   IO window: 2000-2fff
Feb 20 17:23:41 amilo kernel:   MEM window: da000000-dbffffff
Feb 20 17:23:41 amilo kernel:   PREFETCH window: d4000000-d5ffffff
Feb 20 17:23:41 amilo kernel: PCI: Bridge: 0000:00:1c.1
Feb 20 17:23:41 amilo kernel:   IO window: 3000-3fff
Feb 20 17:23:41 amilo kernel:   MEM window: d6000000-d7ffffff
Feb 20 17:23:41 amilo kernel:   PREFETCH window: d0000000-d1ffffff
Feb 20 17:23:41 amilo kernel: PCI: Bridge: 0000:00:1c.2
Feb 20 17:23:41 amilo kernel:   IO window: 4000-4fff
Feb 20 17:23:41 amilo kernel:   MEM window: d8000000-d9ffffff
Feb 20 17:23:41 amilo kernel:   PREFETCH window: d2000000-d3ffffff
Feb 20 17:23:41 amilo kernel: PCI: Bridge: 0000:00:1e.0
Feb 20 17:23:41 amilo kernel:   IO window: 5000-5fff
Feb 20 17:23:41 amilo kernel:   MEM window: dc000000-dc0fffff
Feb 20 17:23:41 amilo kernel:   PREFETCH window: disabled.
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 16
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 17
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1c.1 to 64
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1c.2 to 64
Feb 20 17:23:41 amilo kernel: PCI: Enabling device 0000:00:1e.0 (0004 -> 0007)
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1e.0 to 64
Feb 20 17:23:41 amilo kernel: NET: Registered protocol family 2
Feb 20 17:23:41 amilo kernel: IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
Feb 20 17:23:41 amilo kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
Feb 20 17:23:41 amilo kernel: TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
Feb 20 17:23:41 amilo kernel: TCP: Hash tables configured (established 131072 bind 65536)
Feb 20 17:23:41 amilo kernel: TCP reno registered
Feb 20 17:23:41 amilo kernel: Simple Boot Flag at 0x36 set to 0x80
Feb 20 17:23:41 amilo kernel: Machine check exception polling timer started.
Feb 20 17:23:41 amilo kernel: highmem bounce pool size: 64 pages
Feb 20 17:23:41 amilo kernel: NTFS driver 2.1.29 [Flags: R/O].
Feb 20 17:23:41 amilo kernel: io scheduler noop registered
Feb 20 17:23:41 amilo kernel: io scheduler cfq registered (default)
Feb 20 17:23:41 amilo kernel: Boot video device is 0000:00:02.0
Feb 20 17:23:41 amilo kernel: PCI: Firmware left 0000:07:08.0 e100 interrupts enabled, disabling
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1c.0 to 64
Feb 20 17:23:41 amilo kernel: assign_interrupt_mode Found MSI capability
Feb 20 17:23:41 amilo kernel: Allocate Port Service[0000:00:1c.0:pcie00]
Feb 20 17:23:41 amilo kernel: Allocate Port Service[0000:00:1c.0:pcie02]
Feb 20 17:23:41 amilo kernel: Allocate Port Service[0000:00:1c.0:pcie03]
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1c.1 to 64
Feb 20 17:23:41 amilo kernel: assign_interrupt_mode Found MSI capability
Feb 20 17:23:41 amilo kernel: Allocate Port Service[0000:00:1c.1:pcie00]
Feb 20 17:23:41 amilo kernel: Allocate Port Service[0000:00:1c.1:pcie02]
Feb 20 17:23:41 amilo kernel: Allocate Port Service[0000:00:1c.1:pcie03]
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1c.2 to 64
Feb 20 17:23:41 amilo kernel: assign_interrupt_mode Found MSI capability
Feb 20 17:23:41 amilo kernel: Allocate Port Service[0000:00:1c.2:pcie00]
Feb 20 17:23:41 amilo kernel: Allocate Port Service[0000:00:1c.2:pcie02]
Feb 20 17:23:41 amilo kernel: Allocate Port Service[0000:00:1c.2:pcie03]
Feb 20 17:23:41 amilo kernel: ACPI: AC Adapter [ACAD] (off-line)
Feb 20 17:23:41 amilo kernel: ACPI: Battery Slot [BAT1] (battery present)
Feb 20 17:23:41 amilo kernel: input: Power Button (FF) as /devices/virtual/input/input0
Feb 20 17:23:41 amilo kernel: ACPI: Power Button (FF) [PWRF]
Feb 20 17:23:41 amilo kernel: input: Power Button (CM) as /devices/virtual/input/input1
Feb 20 17:23:41 amilo kernel: ACPI: Power Button (CM) [PWRB]
Feb 20 17:23:41 amilo kernel: input: Sleep Button (CM) as /devices/virtual/input/input2
Feb 20 17:23:41 amilo kernel: ACPI: Sleep Button (CM) [SLPB]
Feb 20 17:23:41 amilo kernel: input: Lid Switch as /devices/virtual/input/input3
Feb 20 17:23:41 amilo kernel: ACPI: Lid Switch [LID]
Feb 20 17:23:41 amilo kernel: ACPI: SSDT 7F6923B3, 01EA (r1  PmRef  Cpu0Ist     3000 INTL 20050228)
Feb 20 17:23:41 amilo kernel: ACPI: SSDT 7F69215E, 01D0 (r1  PmRef  Cpu0Cst     3001 INTL 20050228)
Feb 20 17:23:41 amilo kernel: ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Feb 20 17:23:41 amilo kernel: ACPI: Processor [CPU0] (supports 8 throttling states)
Feb 20 17:23:41 amilo kernel: ACPI: SSDT 7F69259D, 0089 (r1  PmRef  Cpu1Ist     3000 INTL 20050228)
Feb 20 17:23:41 amilo kernel: ACPI: SSDT 7F69232E, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050228)
Feb 20 17:23:41 amilo kernel: ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
Feb 20 17:23:41 amilo kernel: ACPI: Processor [CPU1] (supports 8 throttling states)
Feb 20 17:23:41 amilo kernel: ACPI: Thermal Zone [TZ00] (35 C)
Feb 20 17:23:41 amilo kernel: Real Time Clock Driver v1.12ac
Feb 20 17:23:41 amilo kernel: hpet_resources: 0xfed00000 is busy
Feb 20 17:23:41 amilo kernel: Linux agpgart interface v0.102
Feb 20 17:23:41 amilo kernel: agpgart: Detected an Intel 945GM Chipset.
Feb 20 17:23:41 amilo kernel: agpgart: Detected 7932K stolen memory.
Feb 20 17:23:41 amilo kernel: agpgart: AGP aperture is 256M @ 0xc0000000
Feb 20 17:23:41 amilo kernel: [drm] Initialized drm 1.1.0 20060810
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 17
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:02.0 to 64
Feb 20 17:23:41 amilo kernel: [drm] Initialized i915 1.6.0 20060119 on minor 0
Feb 20 17:23:41 amilo kernel: loop: module loaded
Feb 20 17:23:41 amilo kernel: e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
Feb 20 17:23:41 amilo kernel: e100: Copyright(c) 1999-2006 Intel Corporation
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:07:08.0[A] -> GSI 20 (level, low) -> IRQ 19
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:07:08.0 to 64
Feb 20 17:23:41 amilo kernel: Switched to high resolution mode on CPU 0
Feb 20 17:23:41 amilo kernel: Switched to high resolution mode on CPU 1
Feb 20 17:23:41 amilo kernel: e100: eth0: e100_probe: addr 0xdc000000, irq 19, MAC addr 00:16:36:93:4f:c3
Feb 20 17:23:41 amilo kernel: Driver 'sd' needs updating - please use bus_type methods
Feb 20 17:23:41 amilo kernel: Driver 'sr' needs updating - please use bus_type methods
Feb 20 17:23:41 amilo kernel: ahci 0000:00:1f.2: version 3.0
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
Feb 20 17:23:41 amilo kernel: ahci 0000:00:1f.2: nr_ports (4) and implemented port map (0x5) don't match, using nr_ports
Feb 20 17:23:41 amilo kernel: ahci 0000:00:1f.2: forcing PORTS_IMPL to 0xf
Feb 20 17:23:41 amilo kernel: ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
Feb 20 17:23:41 amilo kernel: ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1f.2 to 64
Feb 20 17:23:41 amilo kernel: scsi0 : ahci
Feb 20 17:23:41 amilo kernel: scsi1 : ahci
Feb 20 17:23:41 amilo kernel: scsi2 : ahci
Feb 20 17:23:41 amilo kernel: scsi3 : ahci
Feb 20 17:23:41 amilo kernel: ata1: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444500 irq 220
Feb 20 17:23:41 amilo kernel: ata2: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444580 irq 220
Feb 20 17:23:41 amilo kernel: ata3: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444600 irq 220
Feb 20 17:23:41 amilo kernel: ata4: SATA max UDMA/133 abar m1024@0xdc444400 port 0xdc444680 irq 220
Feb 20 17:23:41 amilo kernel: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Feb 20 17:23:41 amilo kernel: ata1.00: ATA-7: WDC WD1200BEVS-07LAT0, 01.06M01, max UDMA/133
Feb 20 17:23:41 amilo kernel: ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth 1)
Feb 20 17:23:41 amilo kernel: ata1.00: configured for UDMA/133
Feb 20 17:23:41 amilo kernel: ata2: SATA link down (SStatus 0 SControl 0)
Feb 20 17:23:41 amilo kernel: ata3: SATA link down (SStatus 0 SControl 300)
Feb 20 17:23:41 amilo kernel: ata4: SATA link down (SStatus 0 SControl 0)
Feb 20 17:23:41 amilo kernel: scsi 0:0:0:0: Direct-Access     ATA      WDC WD1200BEVS-0 01.0 PQ: 0 ANSI: 5
Feb 20 17:23:41 amilo kernel: sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
Feb 20 17:23:41 amilo kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb 20 17:23:41 amilo kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb 20 17:23:41 amilo kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb 20 17:23:41 amilo kernel: sd 0:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
Feb 20 17:23:41 amilo kernel: sd 0:0:0:0: [sda] Write Protect is off
Feb 20 17:23:41 amilo kernel: sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Feb 20 17:23:41 amilo kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Feb 20 17:23:41 amilo kernel:  sda: sda1 sda2 sda3
Feb 20 17:23:41 amilo kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Feb 20 17:23:41 amilo kernel: ata_piix 0000:00:1f.1: version 2.12
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1f.1 to 64
Feb 20 17:23:41 amilo kernel: scsi4 : ata_piix
Feb 20 17:23:41 amilo kernel: scsi5 : ata_piix
Feb 20 17:23:41 amilo kernel: ata5: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x1810 irq 14
Feb 20 17:23:41 amilo kernel: ata6: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1818 irq 15
Feb 20 17:23:41 amilo kernel: ata5.00: ATAPI: Optiarc DVD RW AD-7540A, 1.42, max UDMA/33
Feb 20 17:23:41 amilo kernel: ata5.00: configured for UDMA/33
Feb 20 17:23:41 amilo kernel: ata6: port disabled. ignoring.
Feb 20 17:23:41 amilo kernel: scsi 4:0:0:0: CD-ROM            Optiarc  DVD RW AD-7540A  1.42 PQ: 0 ANSI: 5
Feb 20 17:23:41 amilo kernel: sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Feb 20 17:23:41 amilo kernel: Uniform CD-ROM driver Revision: 3.20
Feb 20 17:23:41 amilo kernel: sr 4:0:0:0: Attached scsi CD-ROM sr0
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1d.7 to 64
Feb 20 17:23:41 amilo kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Feb 20 17:23:41 amilo kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Feb 20 17:23:41 amilo kernel: ehci_hcd 0000:00:1d.7: debug port 1
Feb 20 17:23:41 amilo kernel: PCI: cache line size of 32 is not supported by device 0000:00:1d.7
Feb 20 17:23:41 amilo kernel: ehci_hcd 0000:00:1d.7: irq 21, io mem 0xdc444000
Feb 20 17:23:41 amilo kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Feb 20 17:23:41 amilo kernel: usb usb1: configuration #1 chosen from 1 choice
Feb 20 17:23:41 amilo kernel: hub 1-0:1.0: USB hub found
Feb 20 17:23:41 amilo kernel: hub 1-0:1.0: 8 ports detected
Feb 20 17:23:41 amilo kernel: USB Universal Host Controller Interface driver v3.0
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1d.0 to 64
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.0: irq 21, io base 0x00001820
Feb 20 17:23:41 amilo kernel: usb usb2: configuration #1 chosen from 1 choice
Feb 20 17:23:41 amilo kernel: hub 2-0:1.0: USB hub found
Feb 20 17:23:41 amilo kernel: hub 2-0:1.0: 2 ports detected
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1d.1 to 64
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.1: irq 20, io base 0x00001840
Feb 20 17:23:41 amilo kernel: usb usb3: configuration #1 chosen from 1 choice
Feb 20 17:23:41 amilo kernel: hub 3-0:1.0: USB hub found
Feb 20 17:23:41 amilo kernel: hub 3-0:1.0: 2 ports detected
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1d.2 to 64
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001860
Feb 20 17:23:41 amilo kernel: usb usb4: configuration #1 chosen from 1 choice
Feb 20 17:23:41 amilo kernel: hub 4-0:1.0: USB hub found
Feb 20 17:23:41 amilo kernel: hub 4-0:1.0: 2 ports detected
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 17
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1d.3 to 64
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.3: UHCI Host Controller
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
Feb 20 17:23:41 amilo kernel: uhci_hcd 0000:00:1d.3: irq 17, io base 0x00001880
Feb 20 17:23:41 amilo kernel: usb usb5: configuration #1 chosen from 1 choice
Feb 20 17:23:41 amilo kernel: hub 5-0:1.0: USB hub found
Feb 20 17:23:41 amilo kernel: hub 5-0:1.0: 2 ports detected
Feb 20 17:23:41 amilo kernel: Initializing USB Mass Storage driver...
Feb 20 17:23:41 amilo kernel: usbcore: registered new interface driver usb-storage
Feb 20 17:23:41 amilo kernel: USB Mass Storage support registered.
Feb 20 17:23:41 amilo kernel: usbcore: registered new interface driver usbserial
Feb 20 17:23:41 amilo kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core
Feb 20 17:23:41 amilo kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
Feb 20 17:23:41 amilo kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
Feb 20 17:23:41 amilo kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 5.0
Feb 20 17:23:41 amilo kernel: usbcore: registered new interface driver visor
Feb 20 17:23:41 amilo kernel: drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver
Feb 20 17:23:41 amilo kernel: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2F] at 0x60,0x64 irq 1,12
Feb 20 17:23:41 amilo kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 20 17:23:41 amilo kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Feb 20 17:23:41 amilo kernel: mice: PS/2 mouse device common for all mice
Feb 20 17:23:41 amilo kernel: input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
Feb 20 17:23:41 amilo kernel: cpuidle: using governor ladder
Feb 20 17:23:41 amilo kernel: Synaptics Touchpad, model: 1, fw: 5.10, id: 0x258eb1, caps: 0xa04713/0x0
Feb 20 17:23:41 amilo kernel: input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input5
Feb 20 17:23:41 amilo kernel: cpuidle: using governor menu
Feb 20 17:23:41 amilo kernel: usbcore: registered new interface driver usbhid
Feb 20 17:23:41 amilo kernel: drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Feb 20 17:23:41 amilo kernel: Marking TSC unstable due to: TSC halts in idle.
Feb 20 17:23:41 amilo kernel: Advanced Linux Sound Architecture Driver Version 1.0.15 (Tue Nov 20 19:16:42 2007 UTC).
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:00:1b.0 to 64
Feb 20 17:23:41 amilo kernel: Time: hpet clocksource has been installed.
Feb 20 17:23:41 amilo kernel: Clocksource tsc unstable (delta = -301584993 ns)
Feb 20 17:23:41 amilo kernel: hda_intel: azx_get_response timeout, switching to polling mode: last cmd=0x01ab0000
Feb 20 17:23:41 amilo kernel: ALSA device list:
Feb 20 17:23:41 amilo kernel:   #0: HDA Intel at 0xdc240000 irq 22
Feb 20 17:23:41 amilo kernel: TCP cubic registered
Feb 20 17:23:41 amilo kernel: NET: Registered protocol family 1
Feb 20 17:23:41 amilo kernel: NET: Registered protocol family 17
Feb 20 17:23:41 amilo kernel: Using IPI No-Shortcut mode
Feb 20 17:23:41 amilo kernel: ReiserFS: sda2: found reiserfs format "3.6" with standard journal
Feb 20 17:23:41 amilo kernel: ReiserFS: sda2: using ordered data mode
Feb 20 17:23:41 amilo kernel: ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Feb 20 17:23:41 amilo kernel: ReiserFS: sda2: checking transaction log (sda2)
Feb 20 17:23:41 amilo kernel: ReiserFS: sda2: Using r5 hash to sort names
Feb 20 17:23:41 amilo kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Feb 20 17:23:41 amilo kernel: Freeing unused kernel memory: 196k freed
Feb 20 17:23:41 amilo kernel: iwl3945: Intel(R) PRO/Wireless 3945ABG/BG Network Connection driver for Linux, 1.1.17ks
Feb 20 17:23:41 amilo kernel: iwl3945: Copyright(c) 2003-2007 Intel Corporation
Feb 20 17:23:41 amilo kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 17
Feb 20 17:23:41 amilo kernel: PCI: Setting latency timer of device 0000:01:00.0 to 64
Feb 20 17:23:41 amilo kernel: iwl3945: Detected Intel PRO/Wireless 3945ABG Network Connection
Feb 20 17:23:41 amilo kernel: iwl3945: Tunable channels: 13 802.11bg, 23 802.11a channels
Feb 20 17:23:41 amilo kernel: phy0: Selected rate control algorithm 'iwl-3945-rs'
Feb 20 17:23:41 amilo kernel: Adding 2048248k swap on /dev/sda1.  Priority:-1 extents:1 across:2048248k
Feb 20 17:23:41 amilo kernel: ReiserFS: sda3: found reiserfs format "3.6" with standard journal
Feb 20 17:23:41 amilo kernel: ReiserFS: sda3: using ordered data mode
Feb 20 17:23:41 amilo kernel: ReiserFS: sda3: journal params: device sda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Feb 20 17:23:41 amilo kernel: ReiserFS: sda3: checking transaction log (sda3)
Feb 20 17:23:41 amilo kernel: ReiserFS: sda3: Using r5 hash to sort names
Feb 20 17:23:41 amilo kernel: wlan0: Initial auth_alg=0
Feb 20 17:23:41 amilo kernel: wlan0: authenticate with AP 00:13:46:27:3d:e5
Feb 20 17:23:41 amilo kernel: wlan0: RX authentication from 00:13:46:27:3d:e5 (alg=0 transaction=2 status=0)
Feb 20 17:23:41 amilo kernel: wlan0: authenticated
Feb 20 17:23:41 amilo kernel: wlan0: associate with AP 00:13:46:27:3d:e5
Feb 20 17:23:41 amilo kernel: wlan0: RX AssocResp from 00:13:46:27:3d:e5 (capab=0x431 status=0 aid=2)
Feb 20 17:23:41 amilo kernel: wlan0: invalid aid value 2; bits 15:14 not set
Feb 20 17:23:41 amilo kernel: wlan0: associated
Feb 20 17:23:41 amilo kernel: wlan0: switched to short barker preamble (BSSID=00:13:46:27:3d:e5)
Feb 20 17:23:41 amilo pcscd: pcscdaemon.c:513:main() pcsc-lite 1.4.99 daemon ready.
Feb 20 17:23:41 amilo /usr/sbin/cron[1827]: (CRON) INFO (pidfile fd = 3)
Feb 20 17:23:41 amilo /usr/sbin/cron[1828]: (CRON) STARTUP (fork ok)
Feb 20 17:23:41 amilo /usr/sbin/cron[1828]: (CRON) INFO (Running @reboot jobs)
Feb 20 17:23:59 amilo ntpdate[1539]: no server suitable for synchronization found
Feb 20 17:43:40 amilo -- MARK --
Feb 20 18:03:40 amilo -- MARK --
Feb 20 18:17:01 amilo /USR/SBIN/CRON[2916]: (root) CMD (   cd / && run-parts --report /etc/cron.hourly)
Feb 20 18:43:40 amilo -- MARK --
