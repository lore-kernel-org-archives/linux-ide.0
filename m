From: ethanhsiao@jmicron.com
Subject: RE: JMicron JMB361 sporadically failing to initialize from at least 2.6.18.4
 to 2.6.22-rc2
Date: Wed, 23 May 2007 20:06:24 +0800
Message-ID: <OF6F795DDD.05494362-ON482572E4.0040E9F8@jmicron.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0135_01C79D75.D6DD99D0"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spamfilter.jmicron.com ([220.130.51.235]:41302 "EHLO
	spamfilter.jmicron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758483AbXEWMD7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 08:03:59 -0400
Received: from jms10 (pop3.jmicron.com [192.168.101.166])
	by spamfilter.jmicron.com (8.13.1/8.13.1) with ESMTP id l4NC70Pn017791
	for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 20:07:05 +0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: andrew@ishiboo.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0135_01C79D75.D6DD99D0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

> Everyone, I tried rebuilding 2.6.22-rc2 last night with CONFIG_IDE
> disabled, but it still produces the same problem. The relevant config
> options:
> 
> # CONFIG_IDE is not set
> CONFIG_ATA=y
> CONFIG_ATA_ACPI=y
> CONFIG_SATA_AHCI=y
> CONFIG_ATA_PIIX=y
> CONFIG_PATA_JMICRON=y
> 
> Ethan, you mention that this is a known issue.. I can't find any link
> to this problem. This is happening on a cleanly rebuilt kernel, so I'm
> not sure if this has to do with Debian 4.0r0 probing the module
> incorrectly. I already have the OS installed, and I figured a newer
> kernel would have resolved this issue. Unlike the bug report I linked
> to, I am not seeing the driver detect JMB363 & JMB361 in the same boot
> log. Even when everything works, it only detects a JMB361.

I've tried to reproduce this issue under GA-965P-DQ6.
JMB363 works fine in 2.6.22-rc2.
The dmesg log is attached.
It will not show any device name in pata_jmicron.

> A working boot looks like this:
> 
> JMB361: IDE controller at PCI slot 0000:04:00.1
> ACPI: PCI Interrupt 0000:04:00.1[B] -> GSI 18 (level, low) -> IRQ 58
> JMB361: chipset revision 2
> JMB361: 100% native mode on irq 58
>     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA

If you disabled the entire old-IDE driver, this message should not be
existed.
It should be like this:

ACPI: PCI Interrupt 0000:03:00.1[B] -> GSI 18 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:03:00.1 to 64
scsi6 : pata_jmicron
scsi7 : pata_jmicron
ata7: PATA max UDMA/100 cmd 0x0001a000 ctl 0x0001a402 bmdma 0x0001b000 irq
0
ata8: PATA max UDMA/100 cmd 0x0001a800 ctl 0x0001ac02 bmdma 0x0001b008 irq
0

> No use of acpi=off, noapic, nolapic seems to affect the JMB361 from
> being detected properly or not.
> 
> Any next steps? Ethan, do you have more information about this
> particular issue with the DQ6 motherboard?
> 
> Thanks -Andrew

------=_NextPart_000_0135_01C79D75.D6DD99D0
Content-Type: application/octet-stream;
	name="dmesg.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg.log"

Linux version 2.6.22-rc2 (root@debian) (gcc version 4.1.2 20061115 =
(prerelease) (Debian 4.1.1-21)) #1 SMP Thu May 24 18:11:34 CST 2007=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)=0A=
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)=0A=
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)=0A=
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)=0A=
 BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)=0A=
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)=0A=
1151MB HIGHMEM available.=0A=
896MB LOWMEM available.=0A=
found SMP MP-table at 000f5510=0A=
Entering add_active_range(0, 0, 524272) 0 entries of 256 used=0A=
Zone PFN ranges:=0A=
  DMA             0 ->     4096=0A=
  Normal       4096 ->   229376=0A=
  HighMem    229376 ->   524272=0A=
early_node_map[1] active PFN ranges=0A=
    0:        0 ->   524272=0A=
On node 0 totalpages: 524272=0A=
  DMA zone: 32 pages used for memmap=0A=
  DMA zone: 0 pages reserved=0A=
  DMA zone: 4064 pages, LIFO batch:0=0A=
  Normal zone: 1760 pages used for memmap=0A=
  Normal zone: 223520 pages, LIFO batch:31=0A=
  HighMem zone: 2303 pages used for memmap=0A=
  HighMem zone: 292593 pages, LIFO batch:31=0A=
DMI 2.3 present.=0A=
ACPI: RSDP 000F6EB0, 0014 (r0 GBT   )=0A=
ACPI: RSDT 7FFF3040, 0038 (r1 GBT    AWRDACPI 42302E31 AWRD  1010101)=0A=
ACPI: FACP 7FFF30C0, 0074 (r1 GBT    AWRDACPI 42302E31 AWRD  1010101)=0A=
ACPI: DSDT 7FFF3180, 37B6 (r1 GBT    AWRDACPI     1000 MSFT  100000C)=0A=
ACPI: FACS 7FFF0000, 0040=0A=
ACPI: MCFG 7FFF6A80, 003C (r1 GBT    AWRDACPI 42302E31 AWRD  1010101)=0A=
ACPI: APIC 7FFF6980, 0084 (r1 GBT    AWRDACPI 42302E31 AWRD  1010101)=0A=
ACPI: SSDT 7FFF6B00, 015C (r1  PmRef  Cpu0Ist     3000 INTL 20040311)=0A=
ACPI: SSDT 7FFF6F90, 0275 (r1  PmRef    CpuPm     3000 INTL 20040311)=0A=
ACPI: PM-Timer IO Port: 0x408=0A=
ACPI: Local APIC address 0xfee00000=0A=
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)=0A=
Processor #0 6:15 APIC version 20=0A=
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)=0A=
Processor #1 6:15 APIC version 20=0A=
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] disabled)=0A=
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] disabled)=0A=
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])=0A=
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])=0A=
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])=0A=
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])=0A=
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])=0A=
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23=0A=
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)=0A=
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)=0A=
ACPI: IRQ0 used by override.=0A=
ACPI: IRQ2 used by override.=0A=
ACPI: IRQ9 used by override.=0A=
Enabling APIC mode:  Flat.  Using 1 I/O APICs=0A=
Using ACPI (MADT) for SMP configuration information=0A=
Allocating PCI resources starting at 88000000 (gap: 80000000:70000000)=0A=
Built 1 zonelists.  Total pages: 520177=0A=
Kernel command line: root=3D/dev/sda3 ro =0A=
mapped APIC to ffffd000 (fee00000)=0A=
mapped IOAPIC to ffffc000 (fec00000)=0A=
Enabling fast FPU save and restore... done.=0A=
Enabling unmasked SIMD FPU exception support... done.=0A=
Initializing CPU#0=0A=
PID hash table entries: 4096 (order: 12, 16384 bytes)=0A=
Detected 1866.722 MHz processor.=0A=
Console: colour VGA+ 80x25=0A=
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)=0A=
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)=0A=
Memory: 2071188k/2097088k available (1781k kernel code, 24576k reserved, =
727k data, 228k init, 1179584k highmem)=0A=
virtual kernel memory layout:=0A=
    fixmap  : 0xfff4f000 - 0xfffff000   ( 704 kB)=0A=
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)=0A=
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)=0A=
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)=0A=
      .init : 0xc037a000 - 0xc03b3000   ( 228 kB)=0A=
      .data : 0xc02bd441 - 0xc03730d4   ( 727 kB)=0A=
      .text : 0xc0100000 - 0xc02bd441   (1781 kB)=0A=
Checking if this processor honours the WP bit even in supervisor mode... =
Ok.=0A=
Calibrating delay using timer specific routine.. 3736.27 BogoMIPS =
(lpj=3D7472559)=0A=
Security Framework v1.0.0 initialized=0A=
SELinux:  Disabled at boot.=0A=
Capability LSM initialized=0A=
Mount-cache hash table entries: 512=0A=
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 =
0000e3bd 00000000 00000001=0A=
monitor/mwait feature present.=0A=
using mwait in idle threads.=0A=
CPU: L1 I cache: 32K, L1 D cache: 32K=0A=
CPU: L2 cache: 2048K=0A=
CPU: Physical Processor ID: 0=0A=
CPU: Processor Core ID: 0=0A=
CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd =
00000000 00000001=0A=
Intel machine check architecture supported.=0A=
Intel machine check reporting enabled on CPU#0.=0A=
Compat vDSO mapped to ffffe000.=0A=
Checking 'hlt' instruction... OK.=0A=
SMP alternatives: switching to UP code=0A=
ACPI: Core revision 20070126=0A=
CPU0: Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 02=0A=
SMP alternatives: switching to SMP code=0A=
Booting processor 1/1 eip 3000=0A=
Initializing CPU#1=0A=
Calibrating delay using timer specific routine.. 3733.59 BogoMIPS =
(lpj=3D7467194)=0A=
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 =
0000e3bd 00000000 00000001=0A=
monitor/mwait feature present.=0A=
CPU: L1 I cache: 32K, L1 D cache: 32K=0A=
CPU: L2 cache: 2048K=0A=
CPU: Physical Processor ID: 0=0A=
CPU: Processor Core ID: 1=0A=
CPU: After all inits, caps: bfebfbff 20100000 00000000 00003940 0000e3bd =
00000000 00000001=0A=
Intel machine check architecture supported.=0A=
Intel machine check reporting enabled on CPU#1.=0A=
CPU1: Intel(R) Core(TM)2 CPU          6300  @ 1.86GHz stepping 02=0A=
Total of 2 processors activated (7469.87 BogoMIPS).=0A=
ENABLING IO-APIC IRQs=0A=
..TIMER: vector=3D0x31 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1=0A=
checking TSC synchronization [CPU#0 -> CPU#1]: passed.=0A=
Brought up 2 CPUs=0A=
migration_cost=3D15=0A=
NET: Registered protocol family 16=0A=
ACPI: bus type pci registered=0A=
PCI: Using MMCONFIG=0A=
Setting up standard PCI resources=0A=
ACPI: Interpreter enabled=0A=
ACPI: (supports S0 S3 S4 S5)=0A=
ACPI: Using IOAPIC for interrupt routing=0A=
ACPI: PCI Root Bridge [PCI0] (0000:00)=0A=
PCI: Probing PCI hardware (bus 00)=0A=
PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO=0A=
PCI quirk: region 0480-04bf claimed by ICH6 GPIO=0A=
PCI: Transparent bridge - 0000:00:1e.0=0A=
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]=0A=
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]=0A=
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]=0A=
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]=0A=
ACPI: PCI Interrupt Link [LNKA] (IRQs *3 4 5 6 7 9 10 11 12 14 15)=0A=
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)=0A=
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)=0A=
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)=0A=
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, =
disabled.=0A=
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, =
disabled.=0A=
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, =
disabled.=0A=
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, =
disabled.=0A=
Linux Plug and Play Support v0.97 (c) Adam Belay=0A=
pnp: PnP ACPI init=0A=
ACPI: bus type pnp registered=0A=
pnp: PnP ACPI: found 14 devices=0A=
ACPI: ACPI bus type pnp unregistered=0A=
PnPBIOS: Disabled by ACPI PNP=0A=
SCSI subsystem initialized=0A=
libata version 2.20 loaded.=0A=
PCI: Using ACPI for IRQ routing=0A=
PCI: If a device doesn't work, try "pci=3Drouteirq".  If it helps, post =
a report=0A=
NET: Registered protocol family 8=0A=
NET: Registered protocol family 20=0A=
pnp: 00:0a: ioport range 0x400-0x4bf could not be reserved=0A=
pnp: 00:0b: iomem range 0xf0000000-0xf3ffffff could not be reserved=0A=
pnp: 00:0c: iomem range 0xd2800-0xd3fff has been reserved=0A=
pnp: 00:0c: iomem range 0xf0000-0xf7fff could not be reserved=0A=
pnp: 00:0c: iomem range 0xf8000-0xfbfff could not be reserved=0A=
pnp: 00:0c: iomem range 0xfc000-0xfffff could not be reserved=0A=
Time: tsc clocksource has been installed.=0A=
PCI: Bridge: 0000:00:01.0=0A=
  IO window: disabled.=0A=
  MEM window: f4000000-f6ffffff=0A=
  PREFETCH window: e0000000-efffffff=0A=
PCI: Bridge: 0000:00:1c.0=0A=
  IO window: 9000-9fff=0A=
  MEM window: disabled.=0A=
  PREFETCH window: disabled.=0A=
PCI: Bridge: 0000:00:1c.5=0A=
  IO window: a000-bfff=0A=
  MEM window: f7000000-f70fffff=0A=
  PREFETCH window: disabled.=0A=
PCI: Bridge: 0000:00:1e.0=0A=
  IO window: 8000-8fff=0A=
  MEM window: disabled.=0A=
  PREFETCH window: disabled.=0A=
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16=0A=
PCI: Setting latency timer of device 0000:00:01.0 to 64=0A=
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16=0A=
PCI: Setting latency timer of device 0000:00:1c.0 to 64=0A=
ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 17 (level, low) -> IRQ 17=0A=
PCI: Setting latency timer of device 0000:00:1c.5 to 64=0A=
PCI: Setting latency timer of device 0000:00:1e.0 to 64=0A=
NET: Registered protocol family 2=0A=
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)=0A=
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)=0A=
TCP: Hash tables configured (established 131072 bind 65536)=0A=
TCP reno registered=0A=
checking if image is initramfs... it is=0A=
Freeing initrd memory: 4241k freed=0A=
audit: initializing netlink socket (disabled)=0A=
audit(1179948968.892:1): initialized=0A=
highmem bounce pool size: 64 pages=0A=
VFS: Disk quotas dquot_6.5.1=0A=
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)=0A=
io scheduler noop registered=0A=
io scheduler anticipatory registered=0A=
io scheduler deadline registered=0A=
io scheduler cfq registered (default)=0A=
Boot video device is 0000:01:00.0=0A=
PCI: Setting latency timer of device 0000:00:01.0 to 64=0A=
assign_interrupt_mode Found MSI capability=0A=
Allocate Port Service[0000:00:01.0:pcie00]=0A=
Allocate Port Service[0000:00:01.0:pcie03]=0A=
PCI: Setting latency timer of device 0000:00:1c.0 to 64=0A=
assign_interrupt_mode Found MSI capability=0A=
Allocate Port Service[0000:00:1c.0:pcie00]=0A=
Allocate Port Service[0000:00:1c.0:pcie02]=0A=
Allocate Port Service[0000:00:1c.0:pcie03]=0A=
PCI: Setting latency timer of device 0000:00:1c.5 to 64=0A=
assign_interrupt_mode Found MSI capability=0A=
Allocate Port Service[0000:00:1c.5:pcie00]=0A=
Allocate Port Service[0000:00:1c.5:pcie02]=0A=
Allocate Port Service[0000:00:1c.5:pcie03]=0A=
isapnp: Scanning for PnP cards...=0A=
isapnp: No Plug & Play device found=0A=
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled=0A=
00:07: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A=0A=
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize=0A=
ahci 0000:03:00.0: version 2.1=0A=
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 17 (level, low) -> IRQ 17=0A=
ahci 0000:03:00.0: AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA =
mode=0A=
ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part =0A=
PCI: Setting latency timer of device 0000:03:00.0 to 64=0A=
scsi0 : ahci=0A=
scsi1 : ahci=0A=
ata1: SATA max UDMA/133 cmd 0xf881c100 ctl 0x00000000 bmdma 0x00000000 =
irq 0=0A=
ata2: SATA max UDMA/133 cmd 0xf881c180 ctl 0x00000000 bmdma 0x00000000 =
irq 0=0A=
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)=0A=
ata1.00: ata_hpa_resize 1: sectors =3D 156301488, hpa_sectors =3D =
156301488=0A=
ata1.00: ATA-7: ST3808110AS, 2AAA, max UDMA/133=0A=
ata1.00: 156301488 sectors, multi 16: LBA48 NCQ (depth 31/32)=0A=
ata1.00: ata_hpa_resize 1: sectors =3D 156301488, hpa_sectors =3D =
156301488=0A=
ata1.00: configured for UDMA/133=0A=
ata2: SATA link down (SStatus 0 SControl 300)=0A=
scsi 0:0:0:0: Direct-Access     ATA      ST3808110AS      2AAA PQ: 0 =
ANSI: 5=0A=
ata_piix 0000:00:1f.2: version 2.11=0A=
ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]=0A=
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 18=0A=
PCI: Setting latency timer of device 0000:00:1f.2 to 64=0A=
scsi2 : ata_piix=0A=
scsi3 : ata_piix=0A=
ata3: SATA max UDMA/133 cmd 0x000101f0 ctl 0x000103f6 bmdma 0x0001f000 =
irq 14=0A=
ata4: SATA max UDMA/133 cmd 0x00010170 ctl 0x00010376 bmdma 0x0001f008 =
irq 15=0A=
ATA: abnormal status 0x7F on port 0x000101f7=0A=
ATA: abnormal status 0x7F on port 0x00010177=0A=
ata_piix 0000:00:1f.5: MAP [ P0 P2 P1 P3 ]=0A=
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 19 (level, low) -> IRQ 18=0A=
PCI: Setting latency timer of device 0000:00:1f.5 to 64=0A=
scsi4 : ata_piix=0A=
scsi5 : ata_piix=0A=
ata5: SATA max UDMA/133 cmd 0x0001d800 ctl 0x0001dc02 bmdma 0x0001e800 =
irq 0=0A=
ata6: SATA max UDMA/133 cmd 0x0001e000 ctl 0x0001e402 bmdma 0x0001e808 =
irq 0=0A=
ATA: abnormal status 0x7F on port 0x0001d807=0A=
ATA: abnormal status 0x7F on port 0x0001e007=0A=
ACPI: PCI Interrupt 0000:03:00.1[B] -> GSI 18 (level, low) -> IRQ 19=0A=
PCI: Setting latency timer of device 0000:03:00.1 to 64=0A=
scsi6 : pata_jmicron=0A=
scsi7 : pata_jmicron=0A=
ata7: PATA max UDMA/100 cmd 0x0001a000 ctl 0x0001a402 bmdma 0x0001b000 =
irq 0=0A=
ata8: PATA max UDMA/100 cmd 0x0001a800 ctl 0x0001ac02 bmdma 0x0001b008 =
irq 0=0A=
ata7.00: ATAPI, max UDMA/66=0A=
ata7.01: ata_hpa_resize 1: sectors =3D 160086528, hpa_sectors =3D =
160086528=0A=
ata7.01: ATA-7: Maxtor 6L080P0, BAJ41G20, max UDMA/133=0A=
ata7.01: 160086528 sectors, multi 0: LBA48 =0A=
ata7.00: configured for UDMA/66=0A=
ata7.01: ata_hpa_resize 1: sectors =3D 160086528, hpa_sectors =3D =
160086528=0A=
ata7.01: configured for UDMA/100=0A=
ATA: abnormal status 0x7F on port 0x0001a807=0A=
scsi 6:0:0:0: CD-ROM            ASUS     DRW-1608P3S      1.24 PQ: 0 =
ANSI: 5=0A=
scsi 6:0:1:0: Direct-Access     ATA      Maxtor 6L080P0   BAJ4 PQ: 0 =
ANSI: 5=0A=
PNP: PS/2 Controller [PNP0f13:PS2M] at 0x60,0x64 irq 12=0A=
PNP: PS/2 controller doesn't have KBD irq; using default 1=0A=
serio: i8042 KBD port at 0x60,0x64 irq 1=0A=
serio: i8042 AUX port at 0x60,0x64 irq 12=0A=
mice: PS/2 mouse device common for all mice=0A=
TCP bic registered=0A=
NET: Registered protocol family 1=0A=
NET: Registered protocol family 17=0A=
Starting balanced_irq=0A=
Using IPI No-Shortcut mode=0A=
Freeing unused kernel memory: 228k freed=0A=
input: AT Translated Set 2 keyboard as /class/input/input0=0A=
ACPI: Processor [CPU0] (supports 2 throttling states)=0A=
ACPI: SSDT 7FFF6F00, 0087 (r1  PmRef  Cpu1Ist     3000 INTL 20040311)=0A=
ACPI: Processor [CPU1] (supports 2 throttling states)=0A=
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is =
not present [20070126]=0A=
ACPI Exception (processor_core-0781): AE_NOT_FOUND, Processor Device is =
not present [20070126]=0A=
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)=0A=
sd 0:0:0:0: [sda] Write Protect is off=0A=
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00=0A=
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA=0A=
sd 0:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)=0A=
sd 0:0:0:0: [sda] Write Protect is off=0A=
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00=0A=
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA=0A=
 sda: sda1 sda2 sda3=0A=
sd 0:0:0:0: [sda] Attached SCSI disk=0A=
sd 6:0:1:0: [sdb] 160086528 512-byte hardware sectors (81964 MB)=0A=
sd 6:0:1:0: [sdb] Write Protect is off=0A=
sd 6:0:1:0: [sdb] Mode Sense: 00 3a 00 00=0A=
sd 6:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA=0A=
sd 6:0:1:0: [sdb] 160086528 512-byte hardware sectors (81964 MB)=0A=
sd 6:0:1:0: [sdb] Write Protect is off=0A=
sd 6:0:1:0: [sdb] Mode Sense: 00 3a 00 00=0A=
sd 6:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't =
support DPO or FUA=0A=
 sdb:<6>usbcore: registered new interface driver usbfs=0A=
usbcore: registered new interface driver hub=0A=
usbcore: registered new device driver usb=0A=
 sdb4=0A=
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 19=0A=
PCI: Setting latency timer of device 0000:00:1a.7 to 64=0A=
ehci_hcd 0000:00:1a.7: EHCI Host Controller=0A=
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1=0A=
PCI: cache line size of 32 is not supported by device 0000:00:1a.7=0A=
ehci_hcd 0000:00:1a.7: irq 19, io mem 0xf7100000=0A=
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004=0A=
usb usb1: configuration #1 chosen from 1 choice=0A=
hub 1-0:1.0: USB hub found=0A=
hub 1-0:1.0: 4 ports detected=0A=
 sdb4: <openbsd:<6>USB Universal Host Controller Interface driver v3.0=0A=
 >=0A=
sd 6:0:1:0: [sdb] Attached SCSI disk=0A=
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16=0A=
PCI: Setting latency timer of device 0000:00:1a.0 to 64=0A=
uhci_hcd 0000:00:1a.0: UHCI Host Controller=0A=
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 2=0A=
uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000c400=0A=
usb usb2: configuration #1 chosen from 1 choice=0A=
hub 2-0:1.0: USB hub found=0A=
hub 2-0:1.0: 2 ports detected=0A=
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 20=0A=
PCI: Setting latency timer of device 0000:00:1a.1 to 64=0A=
uhci_hcd 0000:00:1a.1: UHCI Host Controller=0A=
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 3=0A=
uhci_hcd 0000:00:1a.1: irq 20, io base 0x0000c000=0A=
usb usb3: configuration #1 chosen from 1 choice=0A=
hub 3-0:1.0: USB hub found=0A=
hub 3-0:1.0: 2 ports detected=0A=
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21=0A=
PCI: Setting latency timer of device 0000:00:1d.0 to 64=0A=
uhci_hcd 0000:00:1d.0: UHCI Host Controller=0A=
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 4=0A=
uhci_hcd 0000:00:1d.0: irq 21, io base 0x0000c800=0A=
usb usb4: configuration #1 chosen from 1 choice=0A=
hub 4-0:1.0: USB hub found=0A=
hub 4-0:1.0: 2 ports detected=0A=
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 18=0A=
PCI: Setting latency timer of device 0000:00:1d.1 to 64=0A=
uhci_hcd 0000:00:1d.1: UHCI Host Controller=0A=
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5=0A=
uhci_hcd 0000:00:1d.1: irq 18, io base 0x0000cc00=0A=
usb usb5: configuration #1 chosen from 1 choice=0A=
hub 5-0:1.0: USB hub found=0A=
hub 5-0:1.0: 2 ports detected=0A=
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 19=0A=
PCI: Setting latency timer of device 0000:00:1d.2 to 64=0A=
uhci_hcd 0000:00:1d.2: UHCI Host Controller=0A=
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6=0A=
uhci_hcd 0000:00:1d.2: irq 19, io base 0x0000d000=0A=
usb usb6: configuration #1 chosen from 1 choice=0A=
hub 6-0:1.0: USB hub found=0A=
hub 6-0:1.0: 2 ports detected=0A=
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21=0A=
PCI: Setting latency timer of device 0000:00:1d.7 to 64=0A=
ehci_hcd 0000:00:1d.7: EHCI Host Controller=0A=
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7=0A=
PCI: cache line size of 32 is not supported by device 0000:00:1d.7=0A=
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xf7101000=0A=
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004=0A=
usb usb7: configuration #1 chosen from 1 choice=0A=
hub 7-0:1.0: USB hub found=0A=
hub 7-0:1.0: 6 ports detected=0A=
Attempting manual resume=0A=
sr0: scsi3-mmc drive: 62x/62x writer dvd-ram cd/rw xa/form2 cdda tray=0A=
Uniform CD-ROM driver Revision: 3.20=0A=
sr 6:0:0:0: Attached scsi CD-ROM sr0=0A=
Linux agpgart interface v0.102 (c) Dave Jones=0A=
agpgart: Detected an Intel 965G Chipset.=0A=
agpgart: AGP aperture is 256M @ 0x0=0A=
Floppy drive(s): fd0 is 1.44M=0A=
FDC 0 is a post-1991 82077=0A=
sd 0:0:0:0: Attached scsi generic sg0 type 0=0A=
sr 6:0:0:0: Attached scsi generic sg1 type 5=0A=
sd 6:0:1:0: Attached scsi generic sg2 type 0=0A=
input: PC Speaker as /class/input/input1=0A=
Real Time Clock Driver v1.12ac=0A=
parport_pc 00:08: reported by Plug and Play ACPI=0A=
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]=0A=
ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 18 (level, low) -> IRQ 19=0A=
Adding 2000084k swap on /dev/sda2.  Priority:-1 extents:1 across:2000084k=0A=
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2=0A=
loop: module loaded=0A=
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: =
dm-devel@redhat.com=0A=
input: Power Button (FF) as /class/input/input3=0A=
ACPI: Power Button (FF) [PWRF]=0A=
input: Power Button (CM) as /class/input/input4=0A=
ACPI: Power Button (CM) [PWRB]=0A=
lp0: using parport0 (interrupt-driven).=0A=
ppdev: user-space parallel port driver=0A=
tsdev (compaq touchscreen emulation) is scheduled for removal.=0A=
See Documentation/feature-removal-schedule.txt for details.=0A=

------=_NextPart_000_0135_01C79D75.D6DD99D0--

