From: rgheck <rgheck@bobjweil.com>
Subject: Re: ATA, SATA Disk Problems
Date: Mon, 21 Jan 2008 11:15:00 -0500
Message-ID: <4794C504.7010000@bobjweil.com>
References: <478E24EE.2060409@brown.edu> <47945394.7090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:53880
	"EHLO QMTA10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758237AbYAUQPD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 11:15:03 -0500
In-Reply-To: <47945394.7090100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: rgheck <rgheck@brown.edu>, linux-ide@vger.kernel.org

Full boot log below. This is the critical part, as far as boot is concerned:
ata7: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 
bmdma 0x000000000001fc00 irq 14
ata7.00: ATAPI: PLEXTOR CD-R   PX-W1610A, 1.05, max MWDMA2
ata7.00: configured for MWDMA2
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: BMDMA stat 0x65
ata7.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 59/44:03:00:3c:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata7: soft resetting port
ata7.00: configured for MWDMA2
ata7: EH complete
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: BMDMA stat 0x65
ata7.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 59/44:03:00:3c:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata7: soft resetting port
ata7.00: configured for MWDMA2
ata7: EH complete
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: BMDMA stat 0x65
ata7.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 59/44:03:00:3c:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata7: soft resetting port
ata7.00: configured for MWDMA2
ata7: EH complete
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: BMDMA stat 0x65
ata7.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 59/44:03:00:3c:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata7: soft resetting port
ata7.00: configured for MWDMA2
ata7: EH complete

The sorts of errors I get when using the drive I've posted before. 
They're intermittent and so can be hard to capture, but I can try to 
post them again, too.

Richard

> rgheck wrote:
>   
>> Hi, and sorry if this turns out to be a known issue. Actually, I'll be
>> thrilled if this turns out to be a known issue. But I've searched on it
>> forever, and although I've found some information, I've not found a
>> definite fix. Possibly my fault, but this is driving me nuts.
>>
>> System: Asus P5N32E MB, Intel Quad Core; on SATA: two HDs, SATA Pioneer
>> DVD-RW; on PATA: Plextor CDRW, one HD. (Can send more info of course.)
>> Kernel is 2.6.23.9 on Fedora 8.
>> [root@rghquad lyxsvn]# lsmod | grep ata
>> pata_amd               20293  2
>> pata_pdc2027x          17477  0
>> sata_nv                25157  6
>> ata_generic            14405  0
>> libata                114673  4 pata_amd,pata_pdc2027x,sata_nv,ata_generic
>> scsi_mod              145657  5 sr_mod,sg,usb_storage,libata,sd_mod
>>
>> The issue concerns locks ups and other errors that seem to be focused on
>> the optical drives. I'm getting this kind of error:
>> Jan 16 01:33:19 rghquad kernel: ata7.01: exception Emask 0x0 SAct 0x0
>> SErr 0x0 action 0x2 frozen
>> Jan 16 01:33:19 rghquad kernel: ata7.01: cmd
>> a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x0 data 0
>> Jan 16 01:33:19 rghquad kernel: ata7: soft resetting port
>> Jan 16 01:33:19 rghquad kernel: ata7.01: configured for MWDMA2
>> Jan 16 01:33:19 rghquad kernel: ata7: EH complete
>> repeatedly, sometimes with the Plextor, sometimes with the Pioneer. But
>> then things sometimes get worse:
>> Jan 16 01:36:22 rghquad kernel: sr1: CDROM (ioctl) error, command:
>> <6>ata7: EH complete
>> Jan 16 01:36:22 rghquad kernel: __journal_remove_journal_head: freeing
>> b_committed_data
>> Jan 16 01:36:22 rghquad kernel: __journal_remove_journal_head: freeing
>> b_frozen_data
>> Jan 16 01:36:22 rghquad kernel: __journal_remove_journal_head: freeing
>> b_committed_data
>> and it seems as if the whole ATA system locks up. The main drive gets
>> reset to read-only, and, well, things are not then good.
>>
>> The fact that this sometimes happens on SATA and sometimes on PATA
>> suggests its not a cable issue. (That particular case was the Plextor.)
>>
>> Is it worth trying a larger PS? I believe I have 450W in this system.
>>
>> Any help or suggestions more than welcome.
>>     
>
> * Please post full kernel log including boot messages and error messages.
>
> * If you have an extra power supply lying around, connecting some of
> SATA devices to a separate PSU (don't do it for PATA) and seeing whether
> the problem continues and on which devices is a great way to rule out
> power problem.  You can power up a PSU without connecting it to a system
> by...
>
>   http://modtown.co.uk/mt/article2.php?id=psumod
>
>   

Linux version 2.6.23.9-85.fc8 
(kojibuilder@xenbuilder4.fedora.phx.redhat.com) (gcc version 4.1.2 
20070925 (Red Hat 4.1.2-33)) #1 SMP Fri Dec 7 15:49:36 EST 2007
Command line: ro root=LABEL=/ rhgb quiet pnpacpi=off pci=nomsi,nommconf
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfef0000 (usable)
 BIOS-e820: 00000000cfef0000 - 00000000cfef3000 (ACPI NVS)
 BIOS-e820: 00000000cfef3000 - 00000000cff00000 (ACPI data)
 BIOS-e820: 00000000f0000000 - 00000000f2000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 851696) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 1245184) 2 entries of 3200 used
end_pfn_map = 1245184
DMI 2.4 present.
ACPI: RSDP 000F7B00, 0024 (r2 Nvidia)
ACPI: XSDT CFEF30C0, 0044 (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
ACPI: FACP CFEFB640, 00F4 (r3 Nvidia ASUSACPI 42302E31 AWRD        0)
ACPI: DSDT CFEF3240, 83B0 (r1 NVIDIA AWRDACPI     1000 MSFT  3000000)
ACPI: FACS CFEF0000, 0040
ACPI: HPET CFEFB880, 0038 (r1 Nvidia ASUSACPI 42302E31 AWRD       98)
ACPI: MCFG CFEFB900, 003C (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
ACPI: APIC CFEFB780, 0098 (r1 Nvidia ASUSACPI 42302E31 AWRD        0)
No NUMA configuration found
Faking a node at 0000000000000000-0000000130000000
Entering add_active_range(0, 0, 159) 0 entries of 3200 used
Entering add_active_range(0, 256, 851696) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 1245184) 2 entries of 3200 used
Bootmem setup node 0 0000000000000000-0000000130000000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1245184
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0:        0 ->      159
    0:      256 ->   851696
    0:  1048576 ->  1245184
On node 0 totalpages: 1048207
  DMA zone: 56 pages used for memmap
  DMA zone: 1319 pages reserved
  DMA zone: 2624 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 833320 pages, LIFO batch:31
  Normal zone: 2688 pages used for memmap
  Normal zone: 193920 pages, LIFO batch:31
  Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
Processor #2
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x10de8201 base: 0xfeff0000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000f0000
swsusp: Registered nosave memory region: 00000000000f0000 - 0000000000100000
swsusp: Registered nosave memory region: 00000000cfef0000 - 00000000cfef3000
swsusp: Registered nosave memory region: 00000000cfef3000 - 00000000cff00000
swsusp: Registered nosave memory region: 00000000cff00000 - 00000000f0000000
swsusp: Registered nosave memory region: 00000000f0000000 - 00000000f2000000
swsusp: Registered nosave memory region: 00000000f2000000 - 00000000fec00000
swsusp: Registered nosave memory region: 00000000fec00000 - 0000000100000000
Allocating PCI resources starting at d0000000 (gap: cff00000:20100000)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
PERCPU: Allocating 41688 bytes of per cpu data
Built 1 zonelists in Node order.  Total pages: 1029864
Policy zone: Normal
Kernel command line: ro root=LABEL=/ rhgb quiet pnpacpi=off 
pci=nomsi,nommconf
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Extended CMOS year: 2000
hpet clockevent registered
TSC calibrated against HPET
time.c: Detected 2399.978 MHz processor.
Console: colour VGA+ 80x25
console [tty0] enabled
Checking aperture...
Calgary: detecting Calgary via BIOS EBDA area
Calgary: Unable to locate Rio Grande table in EBDA - bailing!
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x4866000 - 0x8866000
Memory: 4060600k/4980736k available (2442k kernel code, 132228k 
reserved, 1381k data, 324k init)
SLUB: Genslabs=23, HWalign=64, Order=0-1, MinObjects=4, CPUs=4, Nodes=1
Calibrating delay using timer specific routine.. 4802.86 BogoMIPS 
(lpj=2401430)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mount-cache hash table entries: 256
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
APIC timer calibration result 16666516
Detected 16.666 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x2
Initializing CPU#1
Calibrating delay using timer specific routine.. 4799.89 BogoMIPS 
(lpj=2399949)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 1/2 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 2
CPU1: Thermal monitoring enabled (TM1)
Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x1
Initializing CPU#2
Calibrating delay using timer specific routine.. 4799.85 BogoMIPS 
(lpj=2399927)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 2/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU2: Thermal monitoring enabled (TM1)
Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#2]: passed.
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 4799.90 BogoMIPS 
(lpj=2399950)
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU 3/3 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 3
CPU3: Thermal monitoring enabled (TM1)
Intel(R) Core(TM)2 Quad CPU    Q6600  @ 2.40GHz stepping 0b
checking TSC synchronization [CPU#0 -> CPU#3]: passed.
Brought up 4 CPUs
sizeof(vma)=176 bytes
sizeof(page)=56 bytes
sizeof(inode)=560 bytes
sizeof(dentry)=208 bytes
sizeof(ext3inode)=760 bytes
sizeof(buffer_head)=104 bytes
sizeof(skbuff)=232 bytes
sizeof(task_struct)=2080 bytes
Time:  9:58:47  Date: 01/21/08
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: Using configuration type 1
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: probably your BIOS does not setup all CPUs.
mtrr: corrected configuration.
ACPI: EC: Look up EC in DSDT
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Transparent bridge - 0000:00:0f.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 5 *7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LNK6] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK8] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LP2P] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LMC1] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LAZA] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [LPMU] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUB2] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 5 7 9 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs *5 7 9 10 11 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 5 7 9 *10 11 14 15)
ACPI: PCI Interrupt Link [LSA2] (IRQs 5 7 9 10 *11 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs 16) *0
ACPI: PCI Interrupt Link [APC6] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC7] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC8] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [AMC1] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APMU] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [AAZA] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [ASA2] (IRQs 20 21 22 23) *0
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI-GART: No AMD northbridge found.
hpet0: at MMIO 0xfeff0000, IRQs 2, 8, 31
hpet0: 3 32-bit timers, 25000000 Hz
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:00:03.0
  IO window: d000-dfff
  MEM window: ea000000-edffffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:06.0
  IO window: b000-bfff
  MEM window: efc00000-efcfffff
  PREFETCH window: ef900000-ef9fffff
PCI: Bridge: 0000:00:07.0
  IO window: a000-afff
  MEM window: efe00000-efefffff
  PREFETCH window: efd00000-efdfffff
PCI: Bridge: 0000:00:0f.0
  IO window: c000-cfff
  MEM window: efb00000-efbfffff
  PREFETCH window: efa00000-efafffff
PCI: Bridge: 0000:00:13.0
  IO window: 9000-9fff
  MEM window: ef800000-ef8fffff
  PREFETCH window: ef700000-ef7fffff
PCI: Bridge: 0000:00:14.0
  IO window: 8000-8fff
  MEM window: ef600000-ef6fffff
  PREFETCH window: ef500000-ef5fffff
PCI: Bridge: 0000:00:15.0
  IO window: 7000-7fff
  MEM window: ef400000-ef4fffff
  PREFETCH window: ef300000-ef3fffff
PCI: Bridge: 0000:00:16.0
  IO window: 6000-6fff
  MEM window: ef200000-ef2fffff
  PREFETCH window: ef100000-ef1fffff
PCI: Bridge: 0000:00:17.0
  IO window: 5000-5fff
  MEM window: ef000000-ef0fffff
  PREFETCH window: eef00000-eeffffff
PCI: Bridge: 0000:00:18.0
  IO window: 4000-4fff
  MEM window: eee00000-eeefffff
  PREFETCH window: eed00000-eedfffff
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:06.0 to 64
PCI: Setting latency timer of device 0000:00:07.0 to 64
PCI: Setting latency timer of device 0000:00:0f.0 to 64
PCI: Setting latency timer of device 0000:00:13.0 to 64
PCI: Setting latency timer of device 0000:00:14.0 to 64
PCI: Setting latency timer of device 0000:00:15.0 to 64
PCI: Setting latency timer of device 0000:00:16.0 to 64
PCI: Setting latency timer of device 0000:00:17.0 to 64
PCI: Setting latency timer of device 0000:00:18.0 to 64
NET: Registered protocol family 2
Switched to high resolution mode on CPU 2
Switched to high resolution mode on CPU 3
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 524288 (order: 11, 12582912 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3225k freed
audit: initializing netlink socket (disabled)
audit(1200909526.715:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
ksign: Installing public key data
Loading keyring
- Added public key EFFF415CECD83B98
- User ID: Red Hat, Inc. (Kernel Module GPG key)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:01:00.0
PCI: Setting latency timer of device 0000:00:03.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:03.0:pcie00]
PCI: Setting latency timer of device 0000:00:06.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:06.0:pcie00]
PCI: Setting latency timer of device 0000:00:07.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
PCI: Setting latency timer of device 0000:00:13.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:13.0:pcie00]
PCI: Setting latency timer of device 0000:00:14.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:14.0:pcie00]
PCI: Setting latency timer of device 0000:00:15.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:15.0:pcie00]
PCI: Setting latency timer of device 0000:00:16.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:16.0:pcie00]
PCI: Setting latency timer of device 0000:00:17.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:17.0:pcie00]
PCI: Setting latency timer of device 0000:00:18.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:18.0:pcie00]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
Real Time Clock Driver v1.12ac
hpet_resources: 0xfeff0000 is busy
Non-volatile memory driver v1.2
Linux agpgart interface v0.102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
  Magic number: 8:940:980
Freeing unused kernel memory: 324k freed
Write protecting the kernel read-only data: 1020k
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0b.1[B] -> Link [APCL] -> GSI 23 (level, 
low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:0b.1 to 64
ehci_hcd 0000:00:0b.1: EHCI Host Controller
ehci_hcd 0000:00:0b.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0b.1: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:0b.1
ehci_hcd 0000:00:0b.1: irq 23, io mem 0xefffe000
ehci_hcd 0000:00:0b.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [APCF] -> GSI 22 (level, 
low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:0b.0 to 64
ohci_hcd 0000:00:0b.0: OHCI Host Controller
ohci_hcd 0000:00:0b.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0b.0: irq 22, io mem 0xeffff000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
USB Universal Host Controller Interface driver v3.0
SCSI subsystem initialized
libata version 2.21 loaded.
sata_nv 0000:00:0e.0: version 3.5
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 21 (level, 
low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:0e.0 to 64
scsi0 : sata_nv
scsi1 : sata_nv
ata1: SATA max UDMA/133 cmd 0x00000000000109f0 ctl 0x0000000000010bf2 
bmdma 0x000000000001f700 irq 21
ata2: SATA max UDMA/133 cmd 0x0000000000010970 ctl 0x0000000000010b72 
bmdma 0x000000000001f708 irq 21
usb 1-4: new high speed USB device using ehci_hcd and address 3
usb 1-4: configuration #1 chosen from 1 choice
hub 1-4:1.0: USB hub found
hub 1-4:1.0: 4 ports detected
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: WDC WD1500AHFD-00RAR5, 21.07QR5, max UDMA/133
ata1.00: 293046768 sectors, multi 1: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
usb 1-5: new high speed USB device using ehci_hcd and address 4
usb 1-5: configuration #1 chosen from 1 choice
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-8: WDC WD5000AAKS-00YGA0, 12.01C02, max UDMA/133
ata2.00: 976773168 sectors, multi 1: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
scsi 0:0:0:0: Direct-Access     ATA      WDC WD1500AHFD-0 21.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 293046768 512-byte hardware sectors (150040 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 0:0:0:0: [sda] 293046768 512-byte hardware sectors (150040 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 >
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 1:0:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sdb:<6>usb 2-1: new low speed USB device using ohci_hcd and address 2
 sdb1 sdb2
sd 1:0:0:0: [sdb] Attached SCSI disk
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0e.1[B] -> Link [APSJ] -> GSI 20 (level, 
low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:0e.1 to 64
scsi2 : sata_nv
scsi3 : sata_nv
ata3: SATA max UDMA/133 cmd 0x00000000000109e0 ctl 0x0000000000010be2 
bmdma 0x000000000001f200 irq 20
ata4: SATA max UDMA/133 cmd 0x0000000000010960 ctl 0x0000000000010b62 
bmdma 0x000000000001f208 irq 20
usb 2-1: configuration #1 chosen from 1 choice
input: Logitech USB Receiver as /class/input/input1
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:0b.0-1
Fixing up Logitech keyboard report descriptor
input: Logitech USB Receiver as /class/input/input2
input,hiddev96: USB HID v1.10 Mouse [Logitech USB Receiver] on 
usb-0000:00:0b.0-1
ata3: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
ACPI: PCI Interrupt Link [ASA2] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0e.2[C] -> Link [ASA2] -> GSI 23 (level, 
low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:0e.2 to 64
scsi4 : sata_nv
scsi5 : sata_nv
ata5: SATA max UDMA/133 cmd 0x000000000001f100 ctl 0x000000000001f002 
bmdma 0x000000000001ed00 irq 23
ata6: SATA max UDMA/133 cmd 0x000000000001ef00 ctl 0x000000000001ee02 
bmdma 0x000000000001ed08 irq 23
ata5: SATA link down (SStatus 0 SControl 300)
ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata6.00: ATAPI: PIONEER DVD-RW  DVR-212D, 1.21, max UDMA/66
ata6.00: configured for UDMA/66
scsi 5:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-212D 1.21 PQ: 0 ANSI: 5
pata_amd 0000:00:0d.0: version 0.3.9
PCI: Setting latency timer of device 0000:00:0d.0 to 64
scsi6 : pata_amd
scsi7 : pata_amd
ata7: PATA max UDMA/133 cmd 0x00000000000101f0 ctl 0x00000000000103f6 
bmdma 0x000000000001fc00 irq 14
ata8: PATA max UDMA/133 cmd 0x0000000000010170 ctl 0x0000000000010376 
bmdma 0x000000000001fc08 irq 15
ata7.00: ATAPI: PLEXTOR CD-R   PX-W1610A, 1.05, max MWDMA2
ata7.00: configured for MWDMA2
ata8: port disabled. ignoring.
scsi 6:0:0:0: CD-ROM            PLEXTOR  CD-R   PX-W1610A 1.05 PQ: 0 ANSI: 5
Initializing USB Mass Storage driver...
scsi8 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usb-storage: device scan complete
scsi 8:0:0:0: Direct-Access     USB2.0   SM/XD                 PQ: 0 
ANSI: 0 CCS
scsi 8:0:0:1: Direct-Access     USB2.0   CF/MD                 PQ: 0 
ANSI: 0 CCS
scsi 8:0:0:2: Direct-Access     USB2.0   SD/MMC                PQ: 0 
ANSI: 0 CCS
scsi 8:0:0:3: Direct-Access     USB2.0   MS/MSPRO              PQ: 0 
ANSI: 0 CCS
sd 8:0:0:0: [sdc] Attached SCSI removable disk
sd 8:0:0:1: [sdd] Attached SCSI removable disk
sd 8:0:0:2: [sde] Attached SCSI removable disk
sd 8:0:0:3: [sdf] Attached SCSI removable disk
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1200909546.140:2): selinux=0 auid=4294967295
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
scsi 5:0:0:0: Attached scsi generic sg2 type 5
scsi 6:0:0:0: Attached scsi generic sg3 type 5
sd 8:0:0:0: Attached scsi generic sg4 type 0
sd 8:0:0:1: Attached scsi generic sg5 type 0
sd 8:0:0:2: Attached scsi generic sg6 type 0
sd 8:0:0:3: Attached scsi generic sg7 type 0
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 5:0:0:0: Attached scsi CD-ROM sr0
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.60.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [APCH] -> GSI 22 (level, 
low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:11.0 to 64
forcedeth: using HIGHDMA
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [PWRB]
input: PC Speaker as /class/input/input5
eth0: forcedeth.c: subsystem: 01043:cb84 bound to 0000:00:11.0
ACPI: PCI Interrupt Link [AMC1] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [AMC1] -> GSI 21 (level, 
low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:12.0 to 64
forcedeth: using HIGHDMA
eth1: forcedeth.c: subsystem: 01043:cb84 bound to 0000:00:12.0
i2c-adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c-adapter i2c-1: nForce2 SMBus adapter at 0x1c80
ACPI: PCI Interrupt Link [AAZA] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:0f.1[B] -> Link [AAZA] -> GSI 20 (level, 
low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:0f.1 to 64
hda_codec: Unknown model for AD1988, trying auto-probe from BIOS...
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC5] -> GSI 16 (level, 
low) -> IRQ 16
PCI: Setting latency timer of device 0000:01:00.0 to 64
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:04:0b.0[A] -> Link [APC4] -> GSI 19 (level, 
low) -> IRQ 19
firewire_ohci: Added fw-ohci device 0000:04:0b.0, OHCI version 1.10
firewire_core: created new fw device fw0 (0 config rom retries, S400)
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: BMDMA stat 0x65
ata7.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 59/44:03:00:3c:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata7: soft resetting port
ata7.00: configured for MWDMA2
ata7: EH complete
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: BMDMA stat 0x65
ata7.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 59/44:03:00:3c:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata7: soft resetting port
ata7.00: configured for MWDMA2
ata7: EH complete
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: BMDMA stat 0x65
ata7.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 59/44:03:00:3c:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata7: soft resetting port
ata7.00: configured for MWDMA2
ata7: EH complete
ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata7.00: BMDMA stat 0x65
ata7.00: cmd a0/01:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x5a data 128 in
         res 59/44:03:00:3c:00/00:00:00:00:00/a0 Emask 0x2 (HSM violation)
ata7: soft resetting port
ata7.00: configured for MWDMA2
ata7: EH complete
sr1: scsi-1 drive
sr 6:0:0:0: Attached scsi CD-ROM sr1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: 
dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on sda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda9, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 8289500k swap on /dev/sda8.  Priority:-1 extents:1 across:8289500k

