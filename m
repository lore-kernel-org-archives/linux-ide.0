From: Rusty Conover <rconover@infogears.com>
Subject: Re: Resets on sil3124 & sil3726 PMP
Date: Wed, 15 Aug 2007 07:58:40 -0600
Message-ID: <EA70552E-75C2-451D-BF58-A73482FBB14D@infogears.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.infogears.com ([69.51.90.143]:57489 "EHLO
	mail.infogears.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbXHOOC4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 10:02:56 -0400
Received: from mail.infogears.com (localhost.localdomain [127.0.0.1])
	by mail.infogears.com (Postfix) with ESMTP id 2CC883098054
	for <linux-ide@vger.kernel.org>; Wed, 15 Aug 2007 08:02:47 -0600 (MDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello Tejun,

Thanks for your reply.


> * Please post kernel log including boot messages and errors.
>

I've included the full log at the bottom of this message.

> * Please post the result of 'hdparm -I /dev/sdX' where sdX is the
> offending device.
>
> * Are the errors localized to ata3.04 or are other drives affected  
> too?
>


Its interesting because its not consistent, I've seen exceptions in  
this recent log with:

ata5.00 - ATA bus error
ata5.03 - media error (hdparm below for sdg), timeout
ata5.04 - timeout
ata3.00 - timeout


/dev/sdg:

ATA device, with non-removable media
         Model Number:       WDC WD5000AAKS-00TMA0
         Serial Number:      WD-WCAPW2723414
         Firmware Revision:  12.01C01
Standards:
         Supported: 7 6 5 4
         Likely used: 7
Configuration:
         Logical         max     current
         cylinders       16383   16383
         heads           16      16
         sectors/track   63      63
         --
         CHS current addressable sectors:   16514064
         LBA    user addressable sectors:  268435455
         LBA48  user addressable sectors:  976773168
         device size with M = 1024*1024:      476940 MBytes
         device size with M = 1000*1000:      500107 MBytes (500 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         Queue depth: 32
         Standby timer values: spec'd by Standard, with device  
specific minimum
         R/W multiple sector transfer: Max = 16  Current = 0
         Recommended acoustic management value: 128, current value: 254
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5  
udma6
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=120ns  IORDY flow  
control=120ns
Commands/features:
         Enabled Supported:
            *    SMART feature set
                 Security Mode feature set
            *    Power Management feature set
            *    Write cache
            *    Look-ahead
            *    Host Protected Area feature set
            *    WRITE_BUFFER command
            *    READ_BUFFER command
            *    NOP cmd
            *    DOWNLOAD_MICROCODE
                 Power-Up In Standby feature set
            *    SET_FEATURES required to spinup after power up
                 SET_MAX security extension
                 Automatic Acoustic Management feature set
            *    48-bit Address feature set
            *    Device Configuration Overlay feature set
            *    Mandatory FLUSH_CACHE
            *    FLUSH_CACHE_EXT
            *    SMART error logging
            *    SMART self-test
            *    General Purpose Logging feature set
            *    64-bit World wide name
            *    Segmented DOWNLOAD_MICROCODE
            *    SATA-I signaling speed (1.5Gb/s)
            *    SATA-II signaling speed (3.0Gb/s)
            *    Native Command Queueing (NCQ)
            *    Host-initiated interface power management
            *    Phy event counters
                 DMA Setup Auto-Activate optimization
            *    Software settings preservation
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
         not     frozen
         not     expired: security count
         not     supported: enhanced erase
         122min for SECURITY ERASE UNIT.
Checksum: correct


> * If you keep the machine running, libata will fall back to 1.5Gbps
> after several such errors.  Do the errors go away after falling  
> back to
> 1.5Gbps?

No, they don't ever stop, they just keep happening.


Apparently there was some corruption on the disk, since today when I  
resumed testing I did start to get ext3 fs errors.

EXT3-fs error (device md4): htree_dirblock_to_tree: bad entry in  
directory #411871: rec_len % 4 != 0 - offset=132632, inode=775910615,  
rec_len=48861, name_len=23
init_special_inode: bogus i_mode (34713)
init_special_inode: bogus i_mode (35137)
init_special_inode: bogus i_mode (33105)
init_special_inode: bogus i_mode (131474)
init_special_inode: bogus i_mode (30130)
init_special_inode: bogus i_mode (150646)
init_special_inode: bogus i_mode (115201)
init_special_inode: bogus i_mode (151271)
EXT3-fs error (device md4): htree_dirblock_to_tree: bad entry in  
directory #411871: rec_len % 4 != 0 - offset=132632, inode=775910615,  
rec_len=48861, name_len=23


I have the drives setup like this in RAID10:

[root@site-11 mnt]# cat /proc/mdstat
Personalities : [raid1] [raid6] [raid5] [raid4] [raid0]
md4 : active raid1 md2[0] md3[1]
       1465151744 blocks [2/2] [UU]

md3 : active raid0 sdg1[0] sdd1[2] sdh1[1]
       1465151808 blocks 64k chunks

md2 : active raid0 sdc1[0] sdf1[2] sde1[1]
       1465151808 blocks 64k chunks

md1 : active raid1 sdb2[1] sda2[0]
       8385856 blocks [2/2] [UU]

md0 : active raid1 sdb1[1] sda1[0]
       235801920 blocks [2/2] [UU]

unused devices: <none>

md1 and md0, and sdb1 and sda1 are using ata_piix and really aren't  
showing any problems.

After I noticed the ext3 errors, I started a fsck on the disk and it  
started triggering the errors that reset the adaptor.

Thanks for your help,

Rusty


Linux version 2.6.22.1 (root@site-11) (gcc version 4.1.1 20070105  
(Red Hat 4.1.1-51)) #1 SMP Tue Aug 14 10:41:53 MDT 2007
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009bc00 (usable)
BIOS-e820: 000000000009bc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 00000000dfee0000 (usable)
BIOS-e820: 00000000dfee0000 - 00000000dfee9000 (ACPI data)
BIOS-e820: 00000000dfee9000 - 00000000dff00000 (ACPI NVS)
BIOS-e820: 00000000dff00000 - 00000000e0000000 (reserved)
BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
3712MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f5ec0
NX (Execute Disable) protection: active
Entering add_active_range(0, 0, 1179648) 0 entries of 256 used
Zone PFN ranges:
   DMA             0 ->     4096
   Normal       4096 ->   229376
   HighMem    229376 ->  1179648
early_node_map[1] active PFN ranges
     0:        0 ->  1179648
On node 0 totalpages: 1179648
   DMA zone: 32 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 4064 pages, LIFO batch:0
   Normal zone: 1760 pages used for memmap
   Normal zone: 223520 pages, LIFO batch:31
   HighMem zone: 7424 pages used for memmap
   HighMem zone: 942848 pages, LIFO batch:31
DMI present.
Using APIC driver default
ACPI: RSDP 000F5E40, 0014 (r0 PTLTD )
ACPI: RSDT DFEE253E, 0040 (r1 PTLTD    RSDT    6040000  LTP        0)
ACPI: FACP DFEE8E19, 0074 (r1 INTEL            6040000 PTL         3)
ACPI: DSDT DFEE396A, 54AF (r1  INTEL GLENWOOD  6040000 MSFT  100000E)
ACPI: FACS DFEE9FC0, 0040
ACPI: MCFG DFEE8E8D, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
ACPI: HPET DFEE8EC9, 0038 (r1 PTLTD  HPETTBL   6040000  LTP        1)
ACPI: APIC DFEE8F01, 0074 (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: BOOT DFEE8F75, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: ASF! DFEE8F9D, 0063 (r32   CETP     CETP  6040000 PTL         1)
ACPI: SSDT DFEE257E, 13EC (r1  PmRef    CpuPm     3000 INTL 20050228)
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
ACPI: HPET id: 0xffffffff base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at e1000000 (gap: e0000000:10000000)
Built 1 zonelists.  Total pages: 1170432
Kernel command line: ro root=/dev/md0 rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec10000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c07be000 soft=c079e000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2660.095 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 4147908k/4718592k available (2206k kernel code, 43960k  
reserved, 1190k data, 264k init, 3275648k highmem)
virtual kernel memory layout:
     fixmap  : 0xffc56000 - 0xfffff000   (3748 kB)
     pkmap   : 0xffa00000 - 0xffc00000   (2048 kB)
     vmalloc : 0xf8800000 - 0xff9fe000   ( 113 MB)
     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
       .init : 0xc0757000 - 0xc0799000   ( 264 kB)
       .data : 0xc06279e1 - 0xc07514c4   (1190 kB)
       .text : 0xc0400000 - 0xc06279e1   (2206 kB)
Checking if this processor honours the WP bit even in supervisor  
mode... Ok.
SLUB: Genslabs=22, HWalign=64, Order=0-1, MinObjects=4, CPUs=2, Nodes=1
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Calibrating delay using timer specific routine.. 5322.87 BogoMIPS  
(lpj=2661435)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000  
00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940  
0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
CPU0: Intel(R) Core(TM)2 CPU          6700  @ 2.66GHz stepping 06
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c07bf000 soft=c079f000
Initializing CPU#1
Calibrating delay using timer specific routine.. 5319.97 BogoMIPS  
(lpj=2659988)
CPU: After generic identify, caps: bfebfbff 20100000 00000000  
00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 4096K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940  
0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU          6700  @ 2.66GHz stepping 06
Total of 2 processors activated (10642.84 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
migration_cost=55
PM: Adding info for No Bus:platform
Time: 12:45:33  Date: 07/15/107
NET: Registered protocol family 16
PM: Adding info for No Bus:vtcon0
ACPI: bus type pci registered
PCI: Using MMCONFIG
PCI: No mmconfig possible on device 0f:00
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PM: Adding info for acpi:acpi_system:00
PM: Adding info for acpi:button_power:00
PM: Adding info for acpi:ACPI0007:00
PM: Adding info for acpi:ACPI0007:01
PM: Adding info for acpi:ACPI0007:02
PM: Adding info for acpi:ACPI0007:03
PM: Adding info for acpi:ACPI0007:04
PM: Adding info for acpi:ACPI0007:05
PM: Adding info for acpi:ACPI0007:06
PM: Adding info for acpi:ACPI0007:07
PM: Adding info for acpi:device:00
PM: Adding info for acpi:PNP0A03:00
PM: Adding info for acpi:device:01
PM: Adding info for acpi:device:02
PM: Adding info for acpi:device:03
PM: Adding info for acpi:device:04
PM: Adding info for acpi:device:05
PM: Adding info for acpi:device:06
PM: Adding info for acpi:device:07
PM: Adding info for acpi:PNP0C02:00
PM: Adding info for acpi:PNP0200:00
PM: Adding info for acpi:PNP0C04:00
PM: Adding info for acpi:PNP0000:00
PM: Adding info for acpi:PNP0B00:00
PM: Adding info for acpi:PNP0800:00
PM: Adding info for acpi:PNP0100:00
PM: Adding info for acpi:PNP0103:00
PM: Adding info for acpi:PNP0C0F:00
PM: Adding info for acpi:PNP0C0F:01
PM: Adding info for acpi:PNP0C0F:02
PM: Adding info for acpi:PNP0C0F:03
PM: Adding info for acpi:PNP0C0F:04
PM: Adding info for acpi:PNP0C0F:05
PM: Adding info for acpi:PNP0C0F:06
PM: Adding info for acpi:PNP0C0F:07
PM: Adding info for acpi:INT0800:00
PM: Adding info for acpi:PNP0A05:00
PM: Adding info for acpi:PNP0303:00
PM: Adding info for acpi:PNP0501:00
PM: Adding info for acpi:PNP0501:01
PM: Adding info for acpi:PNP0700:00
PM: Adding info for acpi:device:08
PM: Adding info for acpi:device:09
PM: Adding info for acpi:device:0a
PM: Adding info for acpi:device:0b
PM: Adding info for acpi:device:0c
PM: Adding info for acpi:device:0d
PM: Adding info for acpi:device:0e
PM: Adding info for acpi:device:0f
PM: Adding info for acpi:device:10
PM: Adding info for acpi:device:11
PM: Adding info for acpi:device:12
PM: Adding info for acpi:device:13
PM: Adding info for acpi:device:14
PM: Adding info for acpi:device:15
PM: Adding info for acpi:device:16
PM: Adding info for acpi:PNP0C0C:00
PM: Adding info for acpi:device:17
PM: Adding info for acpi:device:18
PM: Adding info for acpi:device:19
PM: Adding info for acpi:device:1a
PM: Adding info for acpi:device:1b
PM: Adding info for acpi:thermal:00
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PCI quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH6 GPIO
PCI: PXH quirk detected, disabling MSI for SHPC device
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.DEV1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP1.PXHA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.EXP6._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1c.0
PM: Adding info for pci:0000:00:1c.4
PM: Adding info for pci:0000:00:1c.5
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.3
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.2
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:09:00.0
PM: Adding info for pci:0000:09:00.1
PM: Adding info for pci:0000:0a:01.0
PM: Adding info for pci:0000:0d:00.0
PM: Adding info for pci:0000:0e:00.0
PM: Adding info for pci:0000:0f:00.0
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 10 11 14 15) *7
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 10 11 14 15) *12
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 10 11 14 15) *5
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
ACPI: bus type pnp registered
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
pnp: PnP ACPI: found 12 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post  
a report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
ACPI: RTC can wake from S4
pnp: 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
pnp: 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
pnp: 00:01: iomem range 0xfed18000-0xfed1bfff has been reserved
pnp: 00:01: iomem range 0xf0000000-0xf3ffffff could not be reserved
PM: Adding info for No Bus:mem
PM: Adding info for No Bus:kmem
PM: Adding info for No Bus:null
PM: Adding info for No Bus:port
PM: Adding info for No Bus:zero
PM: Adding info for No Bus:full
PM: Adding info for No Bus:random
PM: Adding info for No Bus:urandom
PM: Adding info for No Bus:kmsg
PM: Adding info for No Bus:oldmem
Time: tsc clocksource has been installed.
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:09:00.0
   IO window: 4000-4fff
   MEM window: e0200000-e02fffff
   PREFETCH window: e1000000-e10fffff
PCI: Bridge: 0000:00:1c.0
   IO window: 4000-4fff
   MEM window: e0100000-e02fffff
   PREFETCH window: e1000000-e10fffff
PCI: Bridge: 0000:00:1c.4
   IO window: 5000-5fff
   MEM window: e0300000-e03fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.5
   IO window: 6000-6fff
   MEM window: e0400000-e04fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
   IO window: 7000-7fff
   MEM window: e0500000-e05fffff
   PREFETCH window: e8000000-efffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Setting latency timer of device 0000:09:00.0 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.4 to 64
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.5 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
Freeing initrd memory: 1616k freed
Simple Boot Flag at 0x38 set to 0x1
apm: BIOS not found.
PM: Adding info for platform:pcspkr
PM: Adding info for No Bus:snapshot
audit: initializing netlink socket (disabled)
audit(1187181932.388:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:0f:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
PM: Adding info for pci_express:0000:00:01.0:pcie00
Allocate Port Service[0000:00:01.0:pcie03]
PM: Adding info for pci_express:0000:00:01.0:pcie03
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
PM: Adding info for pci_express:0000:00:1c.0:pcie00
Allocate Port Service[0000:00:1c.0:pcie02]
PM: Adding info for pci_express:0000:00:1c.0:pcie02
Allocate Port Service[0000:00:1c.0:pcie03]
PM: Adding info for pci_express:0000:00:1c.0:pcie03
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
PM: Adding info for pci_express:0000:00:1c.4:pcie00
Allocate Port Service[0000:00:1c.4:pcie02]
PM: Adding info for pci_express:0000:00:1c.4:pcie02
Allocate Port Service[0000:00:1c.4:pcie03]
PM: Adding info for pci_express:0000:00:1c.4:pcie03
PCI: Setting latency timer of device 0000:00:1c.5 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.5:pcie00]
PM: Adding info for pci_express:0000:00:1c.5:pcie00
Allocate Port Service[0000:00:1c.5:pcie02]
PM: Adding info for pci_express:0000:00:1c.5:pcie02
Allocate Port Service[0000:00:1c.5:pcie03]
PM: Adding info for pci_express:0000:00:1c.5:pcie03
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
PM: Adding info for platform:vesafb.0
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device  
is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device  
is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device  
is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device  
is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device  
is not present [20070126]
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device  
is not present [20070126]
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PM: Adding info for No Bus:tty
PM: Adding info for No Bus:console
PM: Adding info for No Bus:ptmx
PM: Adding info for No Bus:tty0
PM: Adding info for No Bus:vcs
PM: Adding info for No Bus:vcsa
PM: Adding info for No Bus:tty1
PM: Adding info for No Bus:tty2
PM: Adding info for No Bus:tty3
PM: Adding info for No Bus:tty4
PM: Adding info for No Bus:tty5
PM: Adding info for No Bus:tty6
PM: Adding info for No Bus:tty7
PM: Adding info for No Bus:tty8
PM: Adding info for No Bus:tty9
PM: Adding info for No Bus:tty10
PM: Adding info for No Bus:tty11
PM: Adding info for No Bus:tty12
PM: Adding info for No Bus:tty13
PM: Adding info for No Bus:tty14
PM: Adding info for No Bus:tty15
PM: Adding info for No Bus:tty16
PM: Adding info for No Bus:tty17
PM: Adding info for No Bus:tty18
PM: Adding info for No Bus:tty19
PM: Adding info for No Bus:tty20
PM: Adding info for No Bus:tty21
PM: Adding info for No Bus:tty22
PM: Adding info for No Bus:tty23
PM: Adding info for No Bus:tty24
PM: Adding info for No Bus:tty25
PM: Adding info for No Bus:tty26
PM: Adding info for No Bus:tty27
PM: Adding info for No Bus:tty28
PM: Adding info for No Bus:tty29
PM: Adding info for No Bus:tty30
PM: Adding info for No Bus:tty31
PM: Adding info for No Bus:tty32
PM: Adding info for No Bus:tty33
PM: Adding info for No Bus:tty34
PM: Adding info for No Bus:tty35
PM: Adding info for No Bus:tty36
PM: Adding info for No Bus:tty37
PM: Adding info for No Bus:tty38
PM: Adding info for No Bus:tty39
PM: Adding info for No Bus:tty40
PM: Adding info for No Bus:tty41
PM: Adding info for No Bus:tty42
PM: Adding info for No Bus:tty43
PM: Adding info for No Bus:tty44
PM: Adding info for No Bus:tty45
PM: Adding info for No Bus:tty46
PM: Adding info for No Bus:tty47
PM: Adding info for No Bus:tty48
PM: Adding info for No Bus:tty49
PM: Adding info for No Bus:tty50
PM: Adding info for No Bus:tty51
PM: Adding info for No Bus:tty52
PM: Adding info for No Bus:tty53
PM: Adding info for No Bus:tty54
PM: Adding info for No Bus:tty55
PM: Adding info for No Bus:tty56
PM: Adding info for No Bus:tty57
PM: Adding info for No Bus:tty58
PM: Adding info for No Bus:tty59
PM: Adding info for No Bus:tty60
PM: Adding info for No Bus:tty61
PM: Adding info for No Bus:tty62
PM: Adding info for No Bus:tty63
PM: Adding info for No Bus:hpet
hpet_resources: 0xfed00000 is busy
Generic RTC Driver v1.07
PM: Adding info for No Bus:rtc
PM: Adding info for No Bus:nvram
Non-volatile memory driver v1.2
Linux agpgart interface v0.102 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
PM: Adding info for platform:serial8250
PM: Adding info for No Bus:ttyS0
PM: Adding info for No Bus:ttyS1
PM: Adding info for No Bus:ttyS2
PM: Adding info for No Bus:ttyS3
PM: Removing info for No Bus:ttyS0
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PM: Adding info for No Bus:ttyS0
PM: Removing info for No Bus:ttyS1
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PM: Adding info for No Bus:ttyS1
PM: Adding info for No Bus:isa
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
PM: Adding info for No Bus:lo
input: Macintosh mouse button emulation as /class/input/input0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with  
idebus=xx
ICH7: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH7: chipset revision 1
ICH7: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x30a0-0x30a7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x30a8-0x30af, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: CD-224E-N, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide0
hda: selected mode 0x42
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
Probing IDE interface ide1...
Probing IDE interface ide1...
ide-floppy driver 0.99.newide
PNP: PS/2 Controller [PNP0303:KBC0] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
PM: Adding info for platform:i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
PM: Adding info for serio:serio0
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input1
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
   Magic number: 3:646:784
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
Freeing unused kernel memory: 264k freed
Write protecting the kernel read-only data: 915k
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 19, io base 0x00003000
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
PM: Adding info for No Bus:usbdev1.1
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 20, io base 0x00003020
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
PM: Adding info for No Bus:usbdev2.1
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
PM: Adding info for usb:usb3
PM: Adding info for No Bus:usbdev3.1_ep00
usb usb3: configuration #1 chosen from 1 choice
PM: Adding info for usb:3-0:1.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev3.1_ep81
PM: Adding info for No Bus:usbdev3.1
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003060
PM: Adding info for usb:usb4
PM: Adding info for No Bus:usbdev4.1_ep00
usb usb4: configuration #1 chosen from 1 choice
PM: Adding info for usb:4-0:1.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev4.1_ep81
PM: Adding info for No Bus:usbdev4.1
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 19, io mem 0xe0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PM: Adding info for usb:usb5
PM: Adding info for No Bus:usbdev5.1_ep00
usb usb5: configuration #1 chosen from 1 choice
PM: Adding info for usb:5-0:1.0
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
PM: Adding info for No Bus:usbdev5.1_ep81
PM: Adding info for No Bus:usbdev5.1
md: raid1 personality registered for level 1
raid5: automatically using best checksumming function: pIII_sse
    pIII_sse  :  9680.000 MB/sec
raid5: using function: pIII_sse (9680.000 MB/sec)
raid6: int32x1    996 MB/s
raid6: int32x2   1066 MB/s
raid6: int32x4    925 MB/s
raid6: int32x8    886 MB/s
raid6: mmxx1     3460 MB/s
raid6: mmxx2     3632 MB/s
raid6: sse1x1    1527 MB/s
raid6: sse1x2    2488 MB/s
raid6: sse2x1    3246 MB/s
raid6: sse2x2    3242 MB/s
raid6: using algorithm sse2x1 (3246 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
SCSI subsystem initialized
libata version 3.00 loaded.
ata_piix 0000:00:1f.2: version 2.11
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ata_piix
PM: Adding info for No Bus:host0
scsi1 : ata_piix
PM: Adding info for No Bus:host1
ata1: SATA max UDMA/133 cmd 0x000130e8 ctl 0x000130de bmdma  
0x000130b0 irq 20
ata2: SATA max UDMA/133 cmd 0x000130e0 ctl 0x000130da bmdma  
0x000130b8 irq 20
ata1.00: ATA-7: WDC WD2500KS-00MJB0, 02.01C03, max UDMA/133
ata1.00: 488397168 sectors, multi 16: LBA48
ata1.00: configured for UDMA/133
ata2.00: ATA-7: WDC WD2500KS-00MJB0, 02.01C03, max UDMA/133
ata2.00: 488397168 sectors, multi 16: LBA48
ata2.00: configured for UDMA/133
PM: Adding info for No Bus:target0:0:0
scsi 0:0:0:0: Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0  
ANSI: 5
PM: Adding info for scsi:0:0:0:0
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 0:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sda: sda1 sda2
sd 0:0:0:0: [sda] Attached SCSI disk
PM: Adding info for No Bus:target1:0:0
scsi 1:0:0:0: Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0  
ANSI: 5
PM: Adding info for scsi:1:0:0:0
sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 1:0:0:0: [sdb] 488397168 512-byte hardware sectors (250059 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sdb: sdb1 sdb2
sd 1:0:0:0: [sdb] Attached SCSI disk
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
audit(1187181937.388:2): selinux=0 auid=4294967295
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
ACPI: PCI Interrupt 0000:0d:00.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:0d:00.0 to 64
e1000: 0000:0d:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)  
00:30:48:8e:d9:9c
PM: Adding info for No Bus:eth0
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
ACPI: PCI Interrupt 0000:0e:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:0e:00.0 to 64
PM: Adding info for No Bus:rtc0
rtc_cmos 00:04: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one month, y3k
e1000: 0000:0e:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)  
00:30:48:8e:d9:9d
iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (21-Jan-2007)
PM: Adding info for platform:iTCO_wdt
iTCO_wdt: Found a ICH7 or ICH7R TCO device (Version=2, TCOBASE=0x1060)
PM: Adding info for No Bus:watchdog
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
PM: Adding info for No Bus:eth1
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
sata_sil24 0000:0a:01.0: version 1.0
ACPI: PCI Interrupt 0000:0a:01.0[A] -> GSI 24 (level, low) -> IRQ 21
sata_sil24 0000:0a:01.0: Applying completion IRQ loss on PCI-X errata  
fix
scsi2 : sata_sil24
PM: Adding info for No Bus:host2
scsi3 : sata_sil24
PM: Adding info for No Bus:host3
scsi4 : sata_sil24
PM: Adding info for No Bus:host4
scsi5 : sata_sil24
PM: Adding info for No Bus:host5
ata3: SATA max UDMA/100 cmd 0xf8930000 ctl 0x00000000 bmdma  
0x00000000 irq 21
ata4: SATA max UDMA/100 cmd 0xf8932000 ctl 0x00000000 bmdma  
0x00000000 irq 21
ata5: SATA max UDMA/100 cmd 0xf8934000 ctl 0x00000000 bmdma  
0x00000000 irq 21
ata6: SATA max UDMA/100 cmd 0xf8936000 ctl 0x00000000 bmdma  
0x00000000 irq 21
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 20
PM: Adding info for No Bus:i2c-0
hda: ATAPI 24X CD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
intel_rng: FWH not detected
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata3.00: hard resetting link
ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.01: hard resetting link
ata3.01: SATA link down (SStatus 0 SControl 300)
ata3.02: hard resetting link
ata3.02: SATA link down (SStatus 0 SControl 300)
ata3.03: hard resetting link
ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.04: hard resetting link
ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.05: hard resetting link
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7: WDC WD5000AAKS-22TMA0, 12.01C01, max UDMA/133
ata3.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata3.00: configured for UDMA/100
ata3.03: ATA-7: WDC WD5000AAKS-22TMA0, 12.01C01, max UDMA/133
ata3.03: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata3.03: configured for UDMA/100
ata3.04: ATA-7: WDC WD5000AAKS-22TMA0, 12.01C01, max UDMA/133
ata3.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata3.04: configured for UDMA/100
ata3: EH complete
ata4: SATA link down (SStatus 0 SControl 0)
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata5.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
ata5.00: hard resetting link
ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.01: hard resetting link
ata5.01: SATA link down (SStatus 0 SControl 300)
ata5.02: hard resetting link
ata5.02: SATA link down (SStatus 0 SControl 300)
ata5.03: hard resetting link
ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.04: hard resetting link
ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.05: hard resetting link
ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: ATA-7: WDC WD5000AAKS-22TMA0, 12.01C01, max UDMA/133
ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata5.00: configured for UDMA/100
ata5.03: ATA-7: WDC WD5000AAKS-00TMA0, 12.01C01, max UDMA/133
ata5.03: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata5.03: configured for UDMA/100
ata5.04: ATA-7: WDC WD5000AAKS-22TMA0, 12.01C01, max UDMA/133
ata5.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
ata5.04: configured for UDMA/100
ata5: EH complete
ata6: SATA link down (SStatus 0 SControl 0)
PM: Adding info for No Bus:target2:0:0
scsi 2:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-2 12.0 PQ: 0  
ANSI: 5
PM: Adding info for scsi:2:0:0:0
sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sdc: sdc1
sd 2:0:0:0: [sdc] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg2 type 0
PM: Adding info for No Bus:target2:3:0
scsi 2:3:0:0: Direct-Access     ATA      WDC WD5000AAKS-2 12.0 PQ: 0  
ANSI: 5
PM: Adding info for scsi:2:3:0:0
sd 2:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 2:3:0:0: [sdd] Write Protect is off
sd 2:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 2:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 2:3:0:0: [sdd] Write Protect is off
sd 2:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sdd: sdd1
sd 2:3:0:0: [sdd] Attached SCSI disk
sd 2:3:0:0: Attached scsi generic sg3 type 0
PM: Adding info for No Bus:target2:4:0
scsi 2:4:0:0: Direct-Access     ATA      WDC WD5000AAKS-2 12.0 PQ: 0  
ANSI: 5
PM: Adding info for scsi:2:4:0:0
sd 2:4:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 2:4:0:0: [sde] Write Protect is off
sd 2:4:0:0: [sde] Mode Sense: 00 3a 00 00
sd 2:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 2:4:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 2:4:0:0: [sde] Write Protect is off
sd 2:4:0:0: [sde] Mode Sense: 00 3a 00 00
sd 2:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sde: sde1
sd 2:4:0:0: [sde] Attached SCSI disk
sd 2:4:0:0: Attached scsi generic sg4 type 0
PM: Adding info for No Bus:target4:0:0
scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-2 12.0 PQ: 0  
ANSI: 5
PM: Adding info for scsi:4:0:0:0
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sdf: sdf1
sd 4:0:0:0: [sdf] Attached SCSI disk
sd 4:0:0:0: Attached scsi generic sg5 type 0
PM: Adding info for No Bus:target4:3:0
scsi 4:3:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 12.0 PQ: 0  
ANSI: 5
PM: Adding info for scsi:4:3:0:0
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sdg: sdg1
sd 4:3:0:0: [sdg] Attached SCSI disk
sd 4:3:0:0: Attached scsi generic sg6 type 0
PM: Adding info for No Bus:target4:4:0
scsi 4:4:0:0: Direct-Access     ATA      WDC WD5000AAKS-2 12.0 PQ: 0  
ANSI: 5
PM: Adding info for scsi:4:4:0:0
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sdh: sdh1
sd 4:4:0:0: [sdh] Attached SCSI disk
sd 4:4:0:0: Attached scsi generic sg7 type 0
FDC 0 is a post-1991 82077
PM: Adding info for platform:parport_pc.956
PM: Removing info for platform:parport_pc.956
PM: Adding info for platform:parport_pc.888
PM: Removing info for platform:parport_pc.888
PM: Adding info for platform:parport_pc.632
PM: Removing info for platform:parport_pc.632
lp: driver loaded but no devices found
sonypi: Sony Programmable I/O Controller Driver v1.26.
No dock devices found.
input: Power Button (FF) as /class/input/input2
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input3
ACPI: Power Button (CM) [PWRB]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
PM: Adding info for No Bus:device-mapper
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm- 
devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
EXT3 FS on md0, internal journal
Adding 8385848k swap on /dev/md1.  Priority:-1 extents:1 across:8385848k
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex,  
Flow Control: RX/TX
PM: Removing info for No Bus:vcs1
PM: Removing info for No Bus:vcsa1
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Removing info for No Bus:vcs3
PM: Removing info for No Bus:vcsa3
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Removing info for No Bus:vcs4
PM: Removing info for No Bus:vcsa4
PM: Adding info for No Bus:vcs4
PM: Adding info for No Bus:vcsa4
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Removing info for No Bus:vcs5
PM: Removing info for No Bus:vcsa5
PM: Adding info for No Bus:vcs5
PM: Adding info for No Bus:vcsa5
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
PM: Removing info for No Bus:vcs6
PM: Removing info for No Bus:vcsa6
PM: Adding info for No Bus:vcs6
PM: Adding info for No Bus:vcsa6
eth0: no IPv6 routers present
md: md2 stopped.
md: md2 stopped.
md: md2 stopped.
md: bind<sde1>
md: bind<sdf1>
md: bind<sdc1>
md: raid0 personality registered for level 0
md2: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdc1
raid0:   comparing sdc1(488383936) with sdc1(488383936)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdf1
raid0:   comparing sdf1(488383936) with sdc1(488383936)
raid0:   EQUAL
raid0: looking at sde1
raid0:   comparing sde1(488383936) with sdc1(488383936)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 1465151808 blocks.
raid0 : conf->hash_spacing is 1465151808 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: md3 stopped.
md: bind<sdh1>
md: bind<sdd1>
md: bind<sdg1>
md3: setting max_sectors to 128, segment boundary to 32767
raid0: looking at sdg1
raid0:   comparing sdg1(488383936) with sdg1(488383936)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at sdd1
raid0:   comparing sdd1(488383936) with sdg1(488383936)
raid0:   EQUAL
raid0: looking at sdh1
raid0:   comparing sdh1(488383936) with sdg1(488383936)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 1465151808 blocks.
raid0 : conf->hash_spacing is 1465151808 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 4 bytes for hash.
md: md4 stopped.
md: bind<md3>
md: bind<md2>
raid1: raid set md4 active with 2 out of 2 mirrors
kjournald starting.  Commit interval 5 seconds
ata5.00: exception Emask 0x0 SAct 0x1 SErr 0x400000 action 0x2
ata5.00: irq_stat 0x00020002, device error via SDB FIS
ata5.00: cmd 61/08:00:3f:4b:38/00:00:3a:00:00/40 tag 0 cdb 0x0 data  
4096 out
          res 41/84:01:46:4b:38/7e:00:3a:00:00/40 Emask 0x410 (ATA  
bus error) <F>
ata5.00: soft resetting link
ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.00: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
EXT3 FS on md4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
device eth0 entered promiscuous mode
audit(1187183411.992:3): dev=eth0 prom=256 old_prom=0 auid=4294967295
device eth0 left promiscuous mode
audit(1187183416.991:4): dev=eth0 prom=0 old_prom=256 auid=4294967295
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00020002, device error via SDB FIS
ata5.03: cmd 60/08:00:7f:61:21/00:00:00:00:00/40 tag 0 cdb 0x0 data  
4096 in
          res 41/40:00:84:61:21/00:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:00:7f:61:21/00:00:00:00:00/40 tag 0 cdb 0x0 data  
4096 in
          res 41/40:00:84:61:21/51:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x8 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:18:7f:61:21/00:00:00:00:00/40 tag 3 cdb 0x0 data  
4096 in
          res 41/40:00:84:61:21/00:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:00:7f:61:21/00:00:00:00:00/40 tag 0 cdb 0x0 data  
4096 in
          res 41/40:00:84:61:21/00:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:00:7f:61:21/00:00:00:00:00/40 tag 0 cdb 0x0 data  
4096 in
          res 41/40:00:84:61:21/00:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:00:7f:61:21/00:00:00:00:00/40 tag 0 cdb 0x0 data  
4096 in
          res 41/40:00:84:61:21/00:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:00:07:2e:22/00:00:00:00:00/40 tag 0 cdb 0x0 data  
4096 in
          res 41/40:00:0a:2e:22/6d:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:00:07:2e:22/00:00:00:00:00/40 tag 0 cdb 0x0 data  
4096 in
          res 41/40:00:0a:2e:22/00:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x20 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:28:07:2e:22/00:00:00:00:00/40 tag 5 cdb 0x0 data  
4096 in
          res 41/40:00:0a:2e:22/6e:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:00:07:2e:22/00:00:00:00:00/40 tag 0 cdb 0x0 data  
4096 in
          res 41/40:00:0a:2e:22/00:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x8 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:18:07:2e:22/00:00:00:00:00/40 tag 3 cdb 0x0 data  
4096 in
          res 41/40:00:0a:2e:22/00:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x0
ata5.03: irq_stat 0x00060002, device error via SDB FIS
ata5.03: cmd 60/08:00:07:2e:22/00:00:00:00:00/40 tag 0 cdb 0x0 data  
4096 in
          res 41/40:00:0a:2e:22/00:00:00:00:00/40 Emask 0x409 (media  
error) <F>
ata5.03: configured for UDMA/100
ata5: EH complete
EXT3-fs error (device md4): htree_dirblock_to_tree: bad entry in  
directory #411871: rec_len % 4 != 0 - offset=132632, inode=775910615,  
rec_len=48861, name_len=23
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
init_special_inode: bogus i_mode (34713)
init_special_inode: bogus i_mode (35137)
init_special_inode: bogus i_mode (33105)
init_special_inode: bogus i_mode (131474)
init_special_inode: bogus i_mode (30130)
init_special_inode: bogus i_mode (150646)
init_special_inode: bogus i_mode (115201)
init_special_inode: bogus i_mode (151271)
EXT3-fs error (device md4): htree_dirblock_to_tree: bad entry in  
directory #411871: rec_len % 4 != 0 - offset=132632, inode=775910615,  
rec_len=48861, name_len=23
ata5.03: exception Emask 0x0 SAct 0x1 SErr 0x0 action 0x2 frozen
ata5.03: cmd 60/80:00:3f:02:10/00:00:00:00:00/40 tag 0 cdb 0x0 data  
65536 in
          res 40/00:00:0a:2e:22/00:00:00:00:00/40 Emask 0x4 (timeout)
ata5.15: hard resetting link
ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata5.00: hard resetting link
ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.01: hard resetting link
ata5.01: SATA link down (SStatus 0 SControl 300)
ata5.02: hard resetting link
ata5.02: SATA link down (SStatus 0 SControl 300)
ata5.03: hard resetting link
ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.04: hard resetting link
ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.05: hard resetting link
ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: configured for UDMA/100
ata5.03: configured for UDMA/100
ata5.04: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.04: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 frozen
ata5.04: cmd 60/80:08:cf:56:0d/00:00:00:00:00/40 tag 1 cdb 0x0 data  
65536 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.15: hard resetting link
ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata5.00: hard resetting link
ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.01: hard resetting link
ata5.01: SATA link down (SStatus 0 SControl 300)
ata5.02: hard resetting link
ata5.02: SATA link down (SStatus 0 SControl 300)
ata5.03: hard resetting link
ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.04: hard resetting link
ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.05: hard resetting link
ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: configured for UDMA/100
ata5.03: configured for UDMA/100
ata5.04: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.04: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 frozen
ata5.04: cmd 60/d0:08:bf:ab:0e/00:00:00:00:00/40 tag 1 cdb 0x0 data  
106496 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.15: hard resetting link
ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata5.00: hard resetting link
ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.01: hard resetting link
ata5.01: SATA link down (SStatus 0 SControl 300)
ata5.02: hard resetting link
ata5.02: SATA link down (SStatus 0 SControl 300)
ata5.03: hard resetting link
ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.04: hard resetting link
ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.05: hard resetting link
ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: configured for UDMA/100
ata5.03: configured for UDMA/100
ata5.04: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata3.04: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 frozen
ata3.04: cmd 60/d0:08:bf:ab:3a/00:00:00:00:00/40 tag 1 cdb 0x0 data  
106496 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.15: hard resetting link
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.00: hard resetting link
ata3.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.01: hard resetting link
ata3.01: SATA link down (SStatus 0 SControl 300)
ata3.02: hard resetting link
ata3.02: SATA link down (SStatus 0 SControl 300)
ata3.03: hard resetting link
ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.04: hard resetting link
ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.05: hard resetting link
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/100
ata3.03: configured for UDMA/100
ata3.04: configured for UDMA/100
ata3: EH complete
sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 2:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 2:3:0:0: [sdd] Write Protect is off
sd 2:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 2:4:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 2:4:0:0: [sde] Write Protect is off
sd 2:4:0:0: [sde] Mode Sense: 00 3a 00 00
sd 2:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 2:0:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 2:0:0:0: [sdc] Write Protect is off
sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 2:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 2:3:0:0: [sdd] Write Protect is off
sd 2:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 2:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 2:4:0:0: [sde] 976773168 512-byte hardware sectors (500108 MB)
sd 2:4:0:0: [sde] Write Protect is off
sd 2:4:0:0: [sde] Mode Sense: 00 3a 00 00
sd 2:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.04: exception Emask 0x0 SAct 0x4 SErr 0x0 action 0x2 frozen
ata5.04: cmd 60/08:10:47:00:60/00:00:00:00:00/40 tag 2 cdb 0x0 data  
4096 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.15: hard resetting link
ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata5.00: hard resetting link
ata5.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.01: hard resetting link
ata5.01: SATA link down (SStatus 0 SControl 300)
ata5.02: hard resetting link
ata5.02: SATA link down (SStatus 0 SControl 300)
ata5.03: hard resetting link
ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.04: hard resetting link
ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.05: hard resetting link
ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: configured for UDMA/100
ata5.03: configured for UDMA/100
ata5.04: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
ata5.04: NCQ disabled due to excessive errors
ata5.04: exception Emask 0x0 SAct 0x2 SErr 0x0 action 0x2 frozen
ata5.04: cmd 60/d8:08:bf:0d:6c/00:00:00:00:00/40 tag 1 cdb 0x0 data  
110592 in
          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata5.15: hard resetting link
ata5.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata5.00: hard resetting link
ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.01: hard resetting link
ata5.01: SATA link down (SStatus 0 SControl 300)
ata5.02: hard resetting link
ata5.02: SATA link down (SStatus 0 SControl 300)
ata5.03: hard resetting link
ata5.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.04: hard resetting link
ata5.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata5.05: hard resetting link
ata5.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata5.00: configured for UDMA/100
ata5.03: configured for UDMA/100
ata5.04: configured for UDMA/100
ata5: EH complete
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:0:0:0: [sdf] 976773168 512-byte hardware sectors (500108 MB)
sd 4:0:0:0: [sdf] Write Protect is off
sd 4:0:0:0: [sdf] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:3:0:0: [sdg] 976773168 512-byte hardware sectors (500108 MB)
sd 4:3:0:0: [sdg] Write Protect is off
sd 4:3:0:0: [sdg] Mode Sense: 00 3a 00 00
sd 4:3:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA
sd 4:4:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
sd 4:4:0:0: [sdh] Write Protect is off
sd 4:4:0:0: [sdh] Mode Sense: 00 3a 00 00
sd 4:4:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't  
support DPO or FUA

