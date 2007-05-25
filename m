From: Bo Nygaard Bai <bai@es.aau.dk>
Subject: Re: [PATCH] ahci: disable 64bit dma on sb600
Date: Sat, 26 May 2007 00:14:50 +0200
Message-ID: <46575FDA.2040308@es.aau.dk>
References: 464DB6D7.8040206@gmail.com <46560BFF.8000802@es.aau.dk> <4656B7B1.1030707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero-fbr1.cybercity.dk ([212.242.40.5]:57887 "EHLO
	cicero-fbr1.cybercity.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbXEYXCb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 25 May 2007 19:02:31 -0400
Received: from cicero1.cybercity.dk (cicero1.cybercity.dk [212.242.40.4])
	by cicero-fbr1.cybercity.dk (Postfix) with ESMTP id 74F143DA2EA
	for <linux-ide@vger.kernel.org>; Sat, 26 May 2007 00:16:22 +0200 (CEST)
In-Reply-To: <4656B7B1.1030707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Bo Nygaard Bai wrote:
>   
>> Hello!
>>
>> Sorry to bug you on this.
>>
>> I found this thread where you and Srihari Vijayaraghavan found a solution
>> to making AHCI work on SB600/AMD960G with more than 4G RAM.
>>
>> As far as i can see the patch is included in the snapshot kernel:
>> 2.6.22-rc2-git4
>>
>> The code is there, but it does not seem to be active. I am still getting
>> the error,
>> and only when using more than 4G of RAM. Perhaps something when wrong
>> when it was merged?
>>     
>
> Or you're seeing a different error?  Please post dmesg and cc
> linux-ide@vger.kernel.org.
>
>   

Ok, here we go!

Kernel build was 2.6.22-rc2-git4. Only selected libata ide support 
(CONFIG_IDE=n)

dmesg output:

Linux version 2.6.22-rc2bai (root@server1) (gcc version 4.1.2 20061115 
(prerelease) (Debian 4.1.1-21)) #1 SMP Wed May 23 23:31:15 CEST 2007
Command line: root=/dev/mapper/server1-root ro
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000d7ee0000 (usable)
 BIOS-e820: 00000000d7ee0000 - 00000000d7ee3000 (ACPI NVS)
 BIOS-e820: 00000000d7ee3000 - 00000000d7ef0000 (ACPI data)
 BIOS-e820: 00000000d7ef0000 - 00000000d7f00000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000120000000 (usable)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 884448) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1179648) 2 entries of 256 used
end_pfn_map = 1179648
DMI 2.4 present.
ACPI: RSDP 000F81A0, 0024 (r2 ATI   )
ACPI: XSDT D7EE3100, 0044 (r1 ATI    ASUSACPI 42302E31 AWRD        0)
ACPI: FACP D7EE84C0, 00F4 (r3 ATI    ASUSACPI 42302E31 AWRD        0)
ACPI: DSDT D7EE3280, 51D4 (r1 ATI    ASUSACPI     1000 MSFT  3000000)
ACPI: FACS D7EE0000, 0040
ACPI: SSDT D7EE86C0, 01C4 (r1 PTLTD  POWERNOW        1  LTP        1)
ACPI: MCFG D7EE8980, 003C (r1 ATI    ASUSACPI 42302E31 AWRD        0)
ACPI: APIC D7EE8600, 0068 (r1 ATI    ASUSACPI 42302E31 AWRD        0)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 884448) 1 entries of 256 used
Entering add_active_range(0, 1048576, 1179648) 2 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1179648
early_node_map[3] active PFN ranges
    0:        0 ->      159
    0:      256 ->   884448
    0:  1048576 ->  1179648
On node 0 totalpages: 1015423
  DMA zone: 56 pages used for memmap
  DMA zone: 955 pages reserved
  DMA zone: 2988 pages, LIFO batch:0
  DMA32 zone: 14280 pages used for memmap
  DMA32 zone: 866072 pages, LIFO batch:31
  Normal zone: 1792 pages used for memmap
  Normal zone: 129280 pages, LIFO batch:31
ATI board detected. Disabling timer routing over 8254.
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
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
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f1000000 (gap: f0000000:ec00000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 32712 bytes of per cpu data
Built 1 zonelists.  Total pages: 998340
Kernel command line: root=/dev/mapper/server1-root ro
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 2000.008 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
CPU 0: aperture @ 8000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Your BIOS doesn't leave a aperture memory hole
Please enable the IOMMU option in the BIOS setup
This costs you 64 MB of RAM
Mapping aperture over 65536 KB of RAM @ 8000000
Memory: 3916940k/4718592k available (2174k kernel code, 144292k 
reserved, 1003k data, 200k init)
Calibrating delay using timer specific routine.. 4003.07 BogoMIPS 
(lpj=8006152)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12500065
Detected 12.500 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4000.05 BogoMIPS 
(lpj=8000114)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 3800+ stepping 02
Brought up 2 CPUs
migration_cost=199
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000 - efffffff
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:14.4
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCE7._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
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
pnp: ACPI device : hid PNP0A03
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0200
pnp: ACPI device : hid PNP0B00
pnp: ACPI device : hid PNP0800
pnp: ACPI device : hid PNP0C04
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0700
pnp: ACPI device : hid PNP0501
pnp: ACPI device : hid PNP0400
pnp: ACPI device : hid PNP0303
pnp: ACPI device : hid PNP0C02
pnp: ACPI device : hid PNP0C01
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
libata version 2.20 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ 8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: the driver 'system' has been registered
pnp: match found with the PnP device '00:01' and the driver 'system'
pnp: 00:01: ioport range 0x4100-0x411f has been reserved
pnp: 00:01: ioport range 0x228-0x22f has been reserved
pnp: 00:01: ioport range 0x40b-0x40b has been reserved
pnp: 00:01: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:01: ioport range 0xc00-0xc01 has been reserved
pnp: 00:01: ioport range 0xc14-0xc14 has been reserved
pnp: 00:01: ioport range 0xc50-0xc52 has been reserved
pnp: 00:01: ioport range 0xc6c-0xc6d has been reserved
pnp: match found with the PnP device '00:06' and the driver 'system'
pnp: match found with the PnP device '00:0b' and the driver 'system'
pnp: 00:0b: iomem range 0xe0000000-0xefffffff could not be reserved
pnp: match found with the PnP device '00:0c' and the driver 'system'
pnp: 00:0c: iomem range 0xcd400-0xcffff has been reserved
pnp: 00:0c: iomem range 0xf0000-0xf7fff could not be reserved
pnp: 00:0c: iomem range 0xf8000-0xfbfff could not be reserved
pnp: 00:0c: iomem range 0xfc000-0xfffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: fdb00000-fdcfffff
  PREFETCH window: f0000000-f7ffffff
PCI: Bridge: 0000:00:07.0
  IO window: e000-efff
  MEM window: fda00000-fdafffff
  PREFETCH window: fdf00000-fdffffff
PCI: Bridge: 0000:00:14.4
  IO window: c000-cfff
  MEM window: fde00000-fdefffff
  PREFETCH window: fdd00000-fddfffff
PCI: Setting latency timer of device 0000:00:07.0 to 64
NET: Registered protocol family 2
Time: acpi_pm clocksource has been installed.
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 4041k freed
audit: initializing netlink socket (disabled)
audit(1180122565.948:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:01:05.0
PCI: Setting latency timer of device 0000:00:07.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:07.0:pcie00]
Allocate Port Service[0000:00:07.0:pcie03]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.102 (c) Dave Jones
RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 blocksize
ahci 0000:00:12.0: version 2.1
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
ahci 0000:00:12.0: flags: 64bit ncq ilck pm led clo pmp pio slum part
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
scsi3 : ahci
ata1: SATA max UDMA/133 cmd 0xffffc2000001a100 ctl 0x0000000000000000 
bmdma 0x0000000000000000 irq 0
ata2: SATA max UDMA/133 cmd 0xffffc2000001a180 ctl 0x0000000000000000 
bmdma 0x0000000000000000 irq 0
ata3: SATA max UDMA/133 cmd 0xffffc2000001a200 ctl 0x0000000000000000 
bmdma 0x0000000000000000 irq 0
ata4: SATA max UDMA/133 cmd 0xffffc2000001a280 ctl 0x0000000000000000 
bmdma 0x0000000000000000 irq 0
ata1: SATA link down (SStatus 0 SControl 300)
ata2: softreset failed (1st FIS failed)
ata2: reset failed (errno=-5), retrying in 10 secs
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2.00: limiting speed to UDMA7:PIO5
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: qc timeout (cmd 0xec)
ata2.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata4: softreset failed (1st FIS failed)
ata4: reset failed (errno=-5), retrying in 10 secs
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4.00: limiting speed to UDMA7:PIO5
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: qc timeout (cmd 0xec)
ata4.00: failed to IDENTIFY (I/O error, err_mask=0x4)
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ACPI: PCI Interrupt 0000:00:14.1[A] -> GSI 16 (level, low) -> IRQ 16
scsi4 : pata_atiixp
scsi5 : pata_atiixp
ata5: PATA max UDMA/100 cmd 0x00000000000101f0 ctl 0x00000000000103f6 
bmdma 0x000000000001f900 irq 14
ata6: PATA max UDMA/100 cmd 0x0000000000010170 ctl 0x0000000000010376 
bmdma 0x000000000001f908 irq 15
ata5.00: ata_hpa_resize 1: sectors = 488397168, hpa_sectors = 488397168
ata5.00: ATA-6: HDS722525VLAT80, V36OA6MA, max UDMA/100
ata5.00: 488397168 sectors, multi 1: LBA48
ata5.01: ATAPI, max UDMA/33
ata5.00: ata_hpa_resize 1: sectors = 488397168, hpa_sectors = 488397168
ata5.00: configured for UDMA/100
ata5.01: configured for UDMA/33
ata6: device not ready (errno=-19), forcing hardreset
ata6: BUG: prereset() requested invalid reset type
scsi 4:0:0:0: Direct-Access     ATA      HDS722525VLAT80  V36O PQ: 0 ANSI: 5
scsi 4:0:1:0: CD-ROM            PLEXTOR  CD-R   PX-W2410A 1.00 PQ: 0 ANSI: 5
pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:0a' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
Freeing unused kernel memory: 200k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: Fan [FAN] (on)
ACPI: Thermal Zone [THRM] (40 C)
sd 4:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 4:0:0:0: [sda] Write Protect is off
sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
sd 4:0:0:0: [sda] 488397168 512-byte hardware sectors (250059 MB)
sd 4:0:0:0: [sda] Write Protect is off
sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 4:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
 sda: sda1 sda2 < sda5 >
sd 4:0:0:0: [sda] Attached SCSI disk
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ACPI: PCI Interrupt 0000:00:13.0[A] -> GSI 16 (level, low) -> IRQ 16
ohci_hcd 0000:00:13.0: OHCI Host Controller
ohci_hcd 0000:00:13.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:13.0: irq 16, io mem 0xfe02e000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.1[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.1: OHCI Host Controller
ohci_hcd 0000:00:13.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:13.1: irq 17, io mem 0xfe02d000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.2[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.2: OHCI Host Controller
ohci_hcd 0000:00:13.2: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:13.2: irq 18, io mem 0xfe02c000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.3[B] -> GSI 17 (level, low) -> IRQ 17
ohci_hcd 0000:00:13.3: OHCI Host Controller
ohci_hcd 0000:00:13.3: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:13.3: irq 17, io mem 0xfe02b000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:13.4[C] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:13.4: OHCI Host Controller
ohci_hcd 0000:00:13.4: new USB bus registered, assigned bus number 5
ohci_hcd 0000:00:13.4: irq 18, io mem 0xfe02a000
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: RTL8168b/8111b at 0xffffc20000028000, 00:1a:92:77:20:ad, IRQ 19
ACPI: PCI Interrupt 0000:00:13.5[D] -> GSI 19 (level, low) -> IRQ 19
ehci_hcd 0000:00:13.5: EHCI Host Controller
ehci_hcd 0000:00:13.5: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:13.5: debug port 1
ehci_hcd 0000:00:13.5: irq 19, io mem 0xfe029000
ehci_hcd 0000:00:13.5: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 10 ports detected
ACPI: PCI Interrupt 0000:03:07.0[A] -> GSI 22 (level, low) -> IRQ 22
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[22]  
MMIO=[fdeff000-fdeff7ff]  Max Packet=[1024]  IR/IT contexts=[4/8]
md: raid1 personality registered for level 1
md: md3 stopped.
md: md0 stopped.
md: md1 stopped.
md: md2 stopped.
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: 
dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0000000000000000]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 4:0:1:0: Attached scsi CD-ROM sr0
piix4_smbus 0000:00:14.0: Found 0000:00:14.0 device
Floppy drive(s): fd0 is 1.44M
sd 4:0:0:0: Attached scsi generic sg0 type 0
sr 4:0:1:0: Attached scsi generic sg1 type 5
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
FDC 0 is a post-1991 82077
pnp: the driver 'serial' has been registered
pnp: match found with the PnP device '00:08' and the driver 'serial'
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
EXT3 FS on dm-0, internal journal
loop: module loaded
md: md3 stopped.
md: md0 stopped.
md: md1 stopped.
md: md2 stopped.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 11763704k swap on /dev/mapper/server1-swap_1.  Priority:-1 
extents:1 across:11763704k
r8169: eth1: link up
r8169: eth1: link up
input: Power Button (FF) as /class/input/input1
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
NET: Registered protocol family 5
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
eth1: no IPv6 routers present


/Bo Bai
