From: Hugo Grostabussiat <hugo.grostabussiat@club-internet.fr>
Subject: PROBLEM: NCQ spurious completion
Date: Thu, 27 Dec 2007 17:39:16 +0100
Message-ID: <4773D534.9060609@club-internet.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010009000804050104070800"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2b.orange.fr ([80.12.242.145]:35452 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbXL0Uyb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Dec 2007 15:54:31 -0500
Received: from smtp2b.orange.fr (mwinf2b28 [10.232.22.128])
	by mwinf2b15.orange.fr (SMTP Server) with ESMTP id 0550F1C15561
	for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 21:32:07 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b28.orange.fr (SMTP Server) with ESMTP id 44DFB7001FD7
	for <linux-ide@vger.kernel.org>; Thu, 27 Dec 2007 19:27:23 +0100 (CET)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010009000804050104070800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.
I am not a native English speaker, so sorry for my poor English.

I am running Debian Lenny, with a 2.6.22-3-686 kernel on a Toshiba
Satellite A200-13M laptop.
The problem occurs when several I/O operations are performed on the same
disk at the same time. The kind of messages shown in dmesg looks like
this one :
"ata1.00: exception Emask 0x2 SAct 0x6 SErr 0x0 action 0x2 frozen
ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x6
FIS=005040a1:00000001)
ata1.00: cmd 60/01:08:20:fa:23/00:00:00:00:00/40 tag 1 cdb 0x0 data 512 in
         res 50/00:01:21:fa:23/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata1.00: cmd 60/01:10:21:fa:23/00:00:00:00:00/40 tag 2 cdb 0x0 data 512 in
         res 50/00:01:21:fa:23/00:00:00:00:00/40 Emask 0x2 (HSM violation)"
(for further information, see the attached file
linux-2.6.22-3-686-dmesg.txt. It also contains the exact kernel version
at its top.)

I also tried with another kernel version (2.6.18-4-686). I booted in
single user mode and I typed "dd if=/dev/sda1 of=foo.raw", with foo.raw
located on another partition on the same disk (sda4) in order to trigger
the problem. I got a different kind of message (see
linux-2.6.18-4-686-dmesg.txt).

I had a look at the blacklist in the source file libata-core.c for
kernel version 2.6.22-3-686 and I found this entry : "{ "Hitachi
HTS541616J9SA00", "SB4OC70P", ATA_HORKAGE_NONCQ, }", which is very near
from my HDD (Model : Hitachi HTS541616J9SA00 Revision : SB4OC7DP). So, I
suppose the problem comes from the drive which doesn't handle NCQ
commands correctly, but it can't be sure.
I added "{ "Hitachi HTS541616J9SA00", "SB4OC7DP", ATA_HORKAGE_NONCQ, }"
to the blacklist and it worked as expected (NCQ disabled).

That's why I suggest drive Hitachi HTS541616J9SA00 revision SB4OC7DP to
be added to the blacklist.

--------------010009000804050104070800
Content-Type: text/plain;
 name="linux-2.6.22-3-686-dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.22-3-686-dmesg.txt"

Linux version 2.6.22-3-686 (Debian 2.6.22-6) (maks@debian.org) (gcc version 4.1.3 20071019 (prerelease) (Debian 4.1.2-17)) #1 SMP Mon Nov 12 08:32:57 UTC 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fed0000 (usable)
 BIOS-e820: 000000007fed0000 - 000000007fee3000 (ACPI NVS)
 BIOS-e820: 000000007fee3000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f71a0
Entering add_active_range(0, 0, 523984) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   523984
early_node_map[1] active PFN ranges
    0:        0 ->   523984
On node 0 totalpages: 523984
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 2301 pages used for memmap
  HighMem zone: 292307 pages, LIFO batch:31
DMI present.
ACPI: RSDP 000F7120, 0024 (r2 TOSCPL)
ACPI: XSDT 7FED7ABF, 0094 (r1 TOSCPL TOSCPL00  6040000  LTP        0)
ACPI: FACP 7FEDFB60, 00F4 (r3 TOSCPL CRESTLNE  6040000 ALAN        1)
ACPI: DSDT 7FED8E1A, 6CD2 (r2 TOSCPL CRESTLNE  6040000 INTL 20060608)
ACPI: FACS 7FEE2FC0, 0040
ACPI: APIC 7FEDFC54, 0068 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
ACPI: HPET 7FEDFCBC, 0038 (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
ACPI: MCFG 7FEDFCF4, 003C (r1 INTEL  CRESTLNE  6040000 LOHR       5A)
ACPI: TCPA 7FEDFD30, 0032 (r1 Intel  CRESTLNE  6040000 LOHR       5A)
ACPI: TMOR 7FEDFD62, 0026 (r1 PTLTD            6040000 PTL         3)
ACPI: SLIC 7FEDFD88, 0176 (r1 TOSCPL TOSCPL00  6040000 LOHR        0)
ACPI: OSFR 7FEDFEFE, 0072 (r1 TOSHIB A+2nd ID  6040000 TASM  4010000)
ACPI: APIC 7FEDFF70, 0068 (r1 PTLTD  	 APIC    6040000  LTP        0)
ACPI: BOOT 7FEDFFD8, 0028 (r1 PTLTD  $SBFTBL$  6040000  LTP        1)
ACPI: SSDT 7FED8B6D, 02AD (r1 SataRe SataAhci     1000 INTL 20050624)
ACPI: SSDT 7FED80DF, 025F (r1  PmRef  Cpu0Tst     3000 INTL 20050624)
ACPI: SSDT 7FED8039, 00A6 (r1  PmRef  Cpu1Tst     3000 INTL 20050624)
ACPI: SSDT 7FED7B53, 04E6 (r1  PmRef    CpuPm     3000 INTL 20050624)
ACPI: BIOS bug: multiple APIC/MADT found, using 0
ACPI: If "acpi_apic_instance=2" works better, notify linux-acpi@vger.kernel.org
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Built 1 zonelists.  Total pages: 519891
Kernel command line: root=/dev/sda2 ro single
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 1795.680 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2068648k/2095936k available (1687k kernel code, 25948k reserved, 646k data, 244k init, 1178432k highmem)
virtual kernel memory layout:
    fixmap  : 0xfff4e000 - 0xfffff000   ( 708 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc034d000 - 0xc038a000   ( 244 kB)
      .data : 0xc02a5f17 - 0xc03477e4   ( 646 kB)
      .text : 0xc0100000 - 0xc02a5f17   (1687 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Calibrating delay using timer specific routine.. 3594.89 BogoMIPS (lpj=7189786)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00003940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
CPU0: Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz stepping 0d
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3591.07 BogoMIPS (lpj=7182144)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20000000 00000000 00003940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz stepping 0d
Total of 2 processors activated (7185.96 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization [CPU#0 -> CPU#1]: passed.
Brought up 2 CPUs
migration_cost=75
Booting paravirtualized kernel on bare hardware
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: System BIOS is requesting _OSI(Linux)
ACPI: Please test with "acpi_osi=!Linux"
Please send dmidecode to linux-acpi@vger.kernel.org
ACPI: Interpreter enabled
ACPI: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 10 devices
ACPI: ACPI bus type pnp unregistered
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI: RTC can wake from S4
pnp: 00:01: iomem range 0xfed1c000-0xfed1ffff could not be reserved
pnp: 00:01: iomem range 0xfed14000-0xfed17fff could not be reserved
pnp: 00:01: iomem range 0xfed18000-0xfed18fff could not be reserved
pnp: 00:01: iomem range 0xfed19000-0xfed19fff could not be reserved
pnp: 00:04: iomem range 0xfed00000-0xfed003ff could not be reserved
Time: tsc clocksource has been installed.
Switched to high resolution mode on CPU 1
Switched to high resolution mode on CPU 0
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: c7e00000-c7efffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 3000-3fff
  MEM window: c0000000-c3ffffff
  PREFETCH window: cc000000-cdffffff
PCI: Bridge: 0000:00:1c.1
  IO window: 4000-4fff
  MEM window: f0000000-f3ffffff
  PREFETCH window: fa000000-fbffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 5000-5fff
  MEM window: f4000000-f7ffffff
  PREFETCH window: fc000000-fdffffff
PCI: Bridge: 0000:00:1c.3
  IO window: 6000-6fff
  MEM window: b8000000-bbffffff
  PREFETCH window: c8000000-c9ffffff
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 13, cardbus bridge: 0000:0c:04.0
  IO window: 00007000-000070ff
  IO window: 00007400-000074ff
  PREFETCH window: 88000000-8bffffff
  MEM window: 90000000-93ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 7000-7fff
  MEM window: f8000000-f80fffff
  PREFETCH window: 88000000-8bffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1c.4 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:0c:04.0[A] -> GSI 16 (level, low) -> IRQ 16
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1572864 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 5727k freed
Simple Boot Flag at 0x36 set to 0x1
audit: initializing netlink socket (disabled)
audit(1198760391.984:1): initialized
highmem bounce pool size: 64 pages
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Boot video device is 0000:01:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:01.0:pcie00]
Allocate Port Service[0000:00:01.0:pcie02]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
Allocate Port Service[0000:00:1c.4:pcie03]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
hpet_resources: 0xfed00000 is busy
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
Freeing unused kernel memory: 244k freed
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI: SSDT 7FED886D, 0238 (r1  PmRef  Cpu0Ist     3000 INTL 20050624)
ACPI: SSDT 7FED833E, 04AA (r1  PmRef  Cpu0Cst     3001 INTL 20050624)
Monitor-Mwait will be used to enter C-1 state
Monitor-Mwait will be used to enter C-2 state
Monitor-Mwait will be used to enter C-3 state
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI: SSDT 7FED8AA5, 00C8 (r1  PmRef  Cpu1Ist     3000 INTL 20050624)
ACPI: SSDT 7FED87E8, 0085 (r1  PmRef  Cpu1Cst     3000 INTL 20050624)
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
Marking TSC unstable due to: possible TSC halt in C2.
Time: hpet clocksource has been installed.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 16
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1a.0: irq 16, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
SCSI subsystem initialized
libata version 2.21 loaded.
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1a.1: irq 20, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.0: irq 21, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Clocksource tsc unstable (delta = -70692179 ns)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.1: irq 19, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.2: irq 18, io base 0x00001880
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf8304800
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 4 ports detected
ahci 0000:00:1f.2: version 2.2
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
usb 2-1: device not accepting address 2, error -71
usb 6-3: new high speed USB device using ehci_hcd and address 2
usb 6-3: configuration #1 chosen from 1 choice
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
PCI: Setting latency timer of device 0000:00:1f.2 to 64
scsi0 : ahci
scsi1 : ahci
scsi2 : ahci
ata1: SATA max UDMA/133 cmd 0xf8884100 ctl 0x00000000 bmdma 0x00000000 irq 217
ata2: SATA max UDMA/133 cmd 0xf8884180 ctl 0x00000000 bmdma 0x00000000 irq 217
ata3: SATA max UDMA/133 cmd 0xf8884200 ctl 0x00000000 bmdma 0x00000000 irq 217
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7: Hitachi HTS541616J9SA00, SB4OC7DP, max UDMA/100
ata1.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 31/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HTS54161 SB4O PQ: 0 ANSI: 5
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:04:00.0 to 64
eth0: RTL8101e at 0xf8858000, 00:1b:38:17:f5:05, IRQ 17
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 21, io mem 0xf8304c00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 6 ports detected
udev: renamed network interface eth0 to eth1
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<6>ACPI: PCI Interrupt 0000:0c:04.1[B] -> GSI 17 (level, low) -> IRQ 17
firewire_ohci: Added fw-ohci device 0000:0c:04.1, OHCI version 1.10
ICH8M: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 19 (level, low) -> IRQ 19
ICH8M: chipset revision 3
ICH8M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18a0-0x18a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x18a8-0x18af, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
 sda1 sda2 sda3 sda4
sd 0:0:0:0: [sda] Attached SCSI disk
firewire_core: created new fw device fw0 (0 config rom retries)
hda: TSSTcorpCD/DVDW TS-L632D, ATAPI CD/DVD-ROM drive
hda: selected mode 0x42
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Attempting manual resume
swsusp: Basic memory bitmaps created
swsusp: Basic memory bitmaps freed
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.102 (c) Dave Jones
Real Time Clock Driver v1.12ac
ACPI: PCI Interrupt 0000:0c:04.2[C] -> GSI 18 (level, low) -> IRQ 18
ieee80211_crypt: registered algorithm 'NULL'
ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 19 (level, low) -> IRQ 19
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:0c:04.3 [104c:803c] (rev 0)
ACPI: PCI Interrupt 0000:0c:04.3[C] -> GSI 18 (level, low) -> IRQ 18
mmc0: SDHCI at 0xf8006800 irq 18 DMA
Yenta: CardBus bridge found at 0000:0c:04.0 [1179:ff00]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:0c:04.0, mfunc 0x10a01b22, devctl 0x64
ipw3945: Intel(R) PRO/Wireless 3945 Network Connection driver for Linux, 1.2.2dmpr
ipw3945: Copyright(c) 2003-2006 Intel Corporation
Yenta: ISA IRQ mask 0x0cf8, PCI irq 16
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#0c) from #0d to #10
pcmcia: parent PCI bridge I/O window: 0x7000 - 0x7fff
cs: IO port probe 0x7000-0x7fff: clean.
pcmcia: parent PCI bridge Memory window: 0xf8000000 - 0xf80fffff
pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x8bffffff
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:05:00.0 to 64
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ipw3945: Detected Intel PRO/Wireless 3945ABG Network Connection
cs: IO port probe 0x100-0x3af: clean.
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
Synaptics Touchpad, model: 1, fw: 6.5, id: 0x82e0b1, caps: 0xb04711/0xe0440d
synaptics: Toshiba Satellite A200 detected, limiting rate to 40pps.
input: SynPS/2 Synaptics TouchPad as /class/input/input1
ALSA /home/darkwolf/alsa-driver-1.0.15/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:238: si3054: cannot initialize. EXT MID = 0000
Adding 3903784k swap on /dev/sda3.  Priority:-1 extents:1 across:3903784k
EXT3 FS on sda2, internal journal
loop: module loaded
set_level status: 0
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
fuse init (API version 7.8)
NTFS driver 2.1.28 [Flags: R/W MODULE].
NTFS volume version 3.1.
NTFS-fs warning (device sda1): load_system_files(): Volume is dirty.  Will not be able to remount read-write.  Run chkdsk and mount in Windows.
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
ipw3945: Detected geography ABG (13 802.11bg channels, 23 802.11a channels)
udev: renamed network interface eth0 to eth2
r8169: eth1: link down
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth1: link is not ready
ipw3945: Radio Frequency Kill Switch is On:
Kill switch must be turned off for wireless networking to work.
ata1.00: exception Emask 0x2 SAct 0x6 SErr 0x0 action 0x2 frozen
ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x6 FIS=005040a1:00000001)
ata1.00: cmd 60/01:08:20:fa:23/00:00:00:00:00/40 tag 1 cdb 0x0 data 512 in
         res 50/00:01:21:fa:23/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata1.00: cmd 60/01:10:21:fa:23/00:00:00:00:00/40 tag 2 cdb 0x0 data 512 in
         res 50/00:01:21:fa:23/00:00:00:00:00/40 Emask 0x2 (HSM violation)
ata1: soft resetting port
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 312581808 512-byte hardware sectors (160042 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA


--------------010009000804050104070800
Content-Type: text/plain;
 name="linux-2.6.18-4-686-dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.18-4-686-dmesg.txt"

Linux version 2.6.18-4-686 (Debian 2.6.18.dfsg.1-12etch2) (dannf@debian.org) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #1 SMP Wed May 9 23:03:12 UTC 2007
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fed0000 (usable)
 BIOS-e820: 000000007fed0000 - 000000007fee3000 (ACPI NVS)
 BIOS-e820: 000000007fee3000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fed00000 - 00000000fed00400 (reserved)
 BIOS-e820: 00000000fed14000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000fed90000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
1150MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f71a0
On node 0 totalpages: 523984
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294608 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v002 TOSCPL                                ) @ 0x000f7120
ACPI: XSDT (v001 TOSCPL TOSCPL00 0x06040000  LTP 0x00000000) @ 0x7fed7abf
ACPI: FADT (v003 TOSCPL CRESTLNE 0x06040000 ALAN 0x00000001) @ 0x7fedfb60
ACPI: MADT (v001 INTEL  CRESTLNE 0x06040000 LOHR 0x0000005a) @ 0x7fedfc54
ACPI: HPET (v001 INTEL  CRESTLNE 0x06040000 LOHR 0x0000005a) @ 0x7fedfcbc
ACPI: MCFG (v001 INTEL  CRESTLNE 0x06040000 LOHR 0x0000005a) @ 0x7fedfcf4
ACPI: TCPA (v001 Intel  CRESTLNE 0x06040000 LOHR 0x0000005a) @ 0x7fedfd30
ACPI: TMOR (v001 PTLTD           0x06040000 PTL  0x00000003) @ 0x7fedfd62
ACPI: SLIC (v001 TOSCPL TOSCPL00 0x06040000 LOHR 0x00000000) @ 0x7fedfd88
ACPI: OSFR (v001 TOSHIB A+2nd ID 0x06040000 TASM 0x04010000) @ 0x7fedfefe
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0x7fedff70
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x7fedffd8
ACPI: SSDT (v001 SataRe SataAhci 0x00001000 INTL 0x20050624) @ 0x7fed8b6d
ACPI: SSDT (v001  PmRef  Cpu0Tst 0x00003000 INTL 0x20050624) @ 0x7fed80df
ACPI: SSDT (v001  PmRef  Cpu1Tst 0x00003000 INTL 0x20050624) @ 0x7fed8039
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20050624) @ 0x7fed7b53
ACPI: DSDT (v002 TOSCPL CRESTLNE 0x06040000 INTL 0x20060608) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: 2 duplicate APIC table ignored.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
ACPI: HPET id: 0x8086a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
Detected 1795.682 MHz processor.
Built 1 zonelists.  Total pages: 523984
Kernel command line: root=/dev/sda2 ro single
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2069320k/2095936k available (1544k kernel code, 25336k reserved, 577k data, 196k init, 1178432k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
hpet0: at MMIO 0xfed00000 (virtual 0xf8800000), IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Using HPET for base-timer
Calibrating delay using timer specific routine.. 3594.91 BogoMIPS (lpj=7189829)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e3bd 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
CPU0: Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz stepping 0d
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3591.08 BogoMIPS (lpj=7182172)
CPU: After generic identify, caps: bfebfbff 20000000 00000000 00000000 0000e3bd 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20000000 00000000 00000000 0000e3bd 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU: After all inits, caps: bfebfbff 20000000 00000000 00000940 0000e3bd 00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 Duo CPU     T7100  @ 1.80GHz stepping 0d
Total of 2 processors activated (7186.00 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
migration_cost=86
checking if image is initramfs... it is
Freeing initrd memory: 5413k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #0d (-#10) is hidden behind transparent bridge #0c (-#0d) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEGP._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP01._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP02._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP03._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP04._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.RP05._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 10 12 14 15) *11
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 11 12 14 15) *10
ACPI: PCI Interrupt Link [LNKE] (IRQs 1 3 4 5 6 7 10 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 1 3 4 5 6 7 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 1 3 4 5 6 7 *10 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 1 3 4 *5 6 7 11 12 14 15)
ACPI: Embedded Controller [EC0] (gpe 28) interrupt mode.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: 2000-2fff
  MEM window: c7e00000-c7efffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: 3000-3fff
  MEM window: c0000000-c3ffffff
  PREFETCH window: cc000000-cdffffff
PCI: Bridge: 0000:00:1c.1
  IO window: 4000-4fff
  MEM window: f0000000-f3ffffff
  PREFETCH window: fa000000-fbffffff
PCI: Bridge: 0000:00:1c.2
  IO window: 5000-5fff
  MEM window: f4000000-f7ffffff
  PREFETCH window: fc000000-fdffffff
PCI: Bridge: 0000:00:1c.3
  IO window: 6000-6fff
  MEM window: b8000000-bbffffff
  PREFETCH window: c8000000-c9ffffff
PCI: Bridge: 0000:00:1c.4
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bus 13, cardbus bridge: 0000:0c:04.0
  IO window: 00007000-000070ff
  IO window: 00007400-000074ff
  PREFETCH window: 88000000-89ffffff
  MEM window: 8c000000-8dffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 7000-7fff
  MEM window: f8000000-f80fffff
  PREFETCH window: 88000000-89ffffff
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1c.3 to 64
ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.4 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:0c:04.0[A] -> GSI 16 (level, low) -> IRQ 169
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
audit: initializing netlink socket (disabled)
audit(1198761220.220:1): initialized
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
Allocate Port Service[0000:00:01.0:pcie02]
Allocate Port Service[0000:00:01.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
Allocate Port Service[0000:00:1c.0:pcie03]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
Allocate Port Service[0000:00:1c.1:pcie03]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
Allocate Port Service[0000:00:1c.2:pcie03]
PCI: Setting latency timer of device 0000:00:1c.3 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.3:pcie00]
Allocate Port Service[0000:00:1c.3:pcie02]
Allocate Port Service[0000:00:1c.3:pcie03]
PCI: Setting latency timer of device 0000:00:1c.4 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.4:pcie00]
Allocate Port Service[0000:00:1c.4:pcie02]
Allocate Port Service[0000:00:1c.4:pcie03]
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 8
NET: Registered protocol family 20
Starting balanced_irq
Using IPI No-Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 196k freed
Time: tsc clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu0Cst] [20060707]
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Ist] [20060707]
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [ PmRef] OemTableId [ Cpu1Cst] [20060707]
ACPI: CPU1 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU1] (supports 8 throttling states)
Time: hpet clocksource has been installed.
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1a.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1a.0 to 64
uhci_hcd 0000:00:1a.0: UHCI Host Controller
uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1a.0: irq 169, io base 0x00001800
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem initialized
libata version 2.00 loaded.
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:00:1a.1[B] -> GSI 21 (level, low) -> IRQ 66
PCI: Setting latency timer of device 0000:00:1a.1 to 64
uhci_hcd 0000:00:1a.1: UHCI Host Controller
uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1a.1: irq 66, io base 0x00001820
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 74
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.0: irq 74, io base 0x00001840
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.1: irq 193, io base 0x00001860
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.2: irq 185, io base 0x00001880
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
usb 2-1: new full speed USB device using uhci_hcd and address 2
ahci 0000:00:1f.2: version 2.0
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
usb 2-1: configuration #1 chosen from 1 choice
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 3 ports 3 Gbps 0x7 impl SATA mode
ahci 0000:00:1f.2: flags: 64bit ncq pm led clo pio slum part 
ata1: SATA max UDMA/133 cmd 0xF88A4100 ctl 0x0 bmdma 0x0 irq 82
ata2: SATA max UDMA/133 cmd 0xF88A4180 ctl 0x0 bmdma 0x0 irq 82
ata3: SATA max UDMA/133 cmd 0xF88A4200 ctl 0x0 bmdma 0x0 irq 82
scsi0 : ahci
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/100, 312581808 sectors: LBA48 NCQ (depth 31/32)
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ahci
ata2: SATA link down (SStatus 0 SControl 300)
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: Hitachi HTS54161  Rev: SB4O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ACPI: PCI Interrupt 0000:0c:04.1[B] -> <6>ACPI: PCI Interrupt 0000:00:1a.7[C] -> GSI 18 (level, low) -> IRQ 185
GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1a.7 to 64
ehci_hcd 0000:00:1a.7: EHCI Host Controller
ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 6
ehci_hcd 0000:00:1a.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1a.7
ehci_hcd 0000:00:1a.7: irq 185, io mem 0xf8304800
ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 4 ports detected
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[177]  MMIO=[f8006000-f80067ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda:<6>usb 2-1: USB disconnect, address 2
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 74
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 74, io mem 0xf8304c00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 6 ports detected
r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:04:00.0 to 64
eth0: RTL8101e at 0xf88b0000, 00:1b:38:17:f5:05, IRQ 177
ICH8M: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 19 (level, low) -> IRQ 193
ICH8M: chipset revision 3
ICH8M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x18a0-0x18a7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x18a8-0x18af, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
udev: renamed network interface eth0 to eth1
usb 6-3: new high speed USB device using ehci_hcd and address 2
 sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
usb 6-3: configuration #1 chosen from 1 choice
hda: TSSTcorpCD/DVDW TS-L632D, ATAPI CD/DVD-ROM drive
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f76ad40be0e]
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hda: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Attempting manual resume
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
eth1394: eth0: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
input: PC Speaker as /class/input/input1
ACPI: PCI Interrupt 0000:00:1f.3[C] -> GSI 19 (level, low) -> IRQ 193
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:0c:04.3 [104c:803c] (rev 0)
ACPI: PCI Interrupt 0000:0c:04.3[C] -> GSI 18 (level, low) -> IRQ 185
mmc0: SDHCI at 0xf8006800 irq 185 DMA
Real Time Clock Driver v1.12ac
Yenta: CardBus bridge found at 0000:0c:04.0 [1179:ff00]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:0c:04.0, mfunc 0x10a01b22, devctl 0x64
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 22 (level, low) -> IRQ 90
PCI: Setting latency timer of device 0000:00:1b.0 to 64
Yenta: ISA IRQ mask 0x0cf8, PCI irq 169
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#0c) from #0d to #10
pcmcia: parent PCI bridge I/O window: 0x7000 - 0x7fff
cs: IO port probe 0x7000-0x7fff: clean.
pcmcia: parent PCI bridge Memory window: 0xf8000000 - 0xf80fffff
pcmcia: parent PCI bridge Memory window: 0x88000000 - 0x89ffffff
cs: IO port probe 0x100-0x3af: excluding 0x170-0x177 0x370-0x377
cs: IO port probe 0x3e0-0x4ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
Synaptics Touchpad, model: 1, fw: 6.5, id: 0x82e0b1, caps: 0xb04711/0xe0440d
synaptics: Toshiba Satellite A200 detected, limiting rate to 40pps.
input: SynPS/2 Synaptics TouchPad as /class/input/input2
ts: Compaq touchscreen protocol output
Adding 3903784k swap on /dev/sda3.  Priority:-1 extents:1 across:3903784k
EXT3 FS on sda2, internal journal
loop: loaded (max 8 devices)
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised: dm-devel@redhat.com
fuse init (API version 7.7)
NTFS driver 2.1.27 [Flags: R/W MODULE].
NTFS volume version 3.1.
NTFS-fs warning (device sda1): load_system_files(): Volume is dirty.  Will not be able to remount read-write.  Run chkdsk and mount in Windows.
pcmcia: Detected deprecated PCMCIA ioctl usage from process: discover.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
r8169: eth1: link down
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth1: link is not ready
IPv6 over IPv4 tunneling driver
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0x16)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0xa)
ata1: spurious interrupt (irq_stat 0x8 active_tag -84148995 sactive 0xc)


--------------010009000804050104070800
Content-Type: text/plain;
 name="lspci-linux-2.6.22-3-686.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci-linux-2.6.22-3-686.txt"

00:00.0 Host bridge: Intel Corporation Mobile Memory Controller Hub (rev 0c)
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile PCI Express Root Port (rev 0c) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: c7e00000-c7efffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] Subsystem: Toshiba America Info Systems Unknown device ff00
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 41c9
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L0s L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise-
		Slot: Number 1, PowerLimit 75.000000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
		Slot: AttnInd Off, PwrInd On, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [140] Unknown (5)

00:1a.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at 1800 [size=32]

00:1a.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #5 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 20
	Region 4: I/O ports at 1820 [size=32]

00:1a.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #2 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at f8304800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at f8300000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)

00:1c.0 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: c0000000-c3ffffff
	Prefetchable memory behind bridge: 00000000cc000000-00000000cdffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 1
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x0
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 2, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 41d1
	Capabilities: [90] Subsystem: Toshiba America Info Systems Unknown device ff00
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.1 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f0000000-f3ffffff
	Prefetchable memory behind bridge: 00000000fa000000-00000000fbffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 2
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 3, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 41d9
	Capabilities: [90] Subsystem: Toshiba America Info Systems Unknown device ff00
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.2 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: f4000000-f7ffffff
	Prefetchable memory behind bridge: 00000000fc000000-00000000fdffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 3
		Link: Latency L0s <256ns, L1 <4us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 4, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 41e1
	Capabilities: [90] Subsystem: Toshiba America Info Systems Unknown device ff00
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.3 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 4 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: b8000000-bbffffff
	Prefetchable memory behind bridge: 00000000c8000000-00000000c9ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 4
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x0
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 5, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 41e9
	Capabilities: [90] Subsystem: Toshiba America Info Systems Unknown device ff00
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1c.4 PCI bridge: Intel Corporation 82801H (ICH8 Family) PCI Express Port 5 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Bus: primary=00, secondary=09, subordinate=09, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s unlimited, L1 unlimited
		Device: Errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 5
		Link: Latency L0s <1us, L1 <4us
		Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
		Link: Speed 2.5Gb/s, Width x0
		Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ Surpise+
		Slot: Number 2, PowerLimit 6.500000
		Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
		Slot: AttnInd Unknown, PwrInd Unknown, Power-
		Root: Correctable- Non-Fatal- Fatal- PME-
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/0 Enable+
		Address: fee0300c  Data: 4132
	Capabilities: [90] Subsystem: Toshiba America Info Systems Unknown device ff00
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Unknown (5)

00:1d.0 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at 1840 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at 1860 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801H (ICH8 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at 1880 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI #1 (rev 03) (prog-if 20 [EHCI])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at f8304c00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev f3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=0c, subordinate=10, sec-latency=32
	I/O behind bridge: 00007000-00007fff
	Memory behind bridge: f8000000-f80fffff
	Prefetchable memory behind bridge: 0000000088000000-000000008bffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] Subsystem: Toshiba America Info Systems Unknown device ff00

00:1f.0 ISA bridge: Intel Corporation Mobile LPC Interface Controller (rev 03)
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation Mobile IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 01f0 [size=8]
	Region 1: I/O ports at 03f4 [size=1]
	Region 2: I/O ports at 0170 [size=8]
	Region 3: I/O ports at 0374 [size=1]
	Region 4: I/O ports at 18a0 [size=16]

00:1f.2 SATA controller: Intel Corporation Mobile SATA AHCI Controller (rev 03) (prog-if 01 [AHCI 1.0])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 217
	Region 0: I/O ports at 18d8 [size=8]
	Region 1: I/O ports at 18cc [size=4]
	Region 2: I/O ports at 18d0 [size=8]
	Region 3: I/O ports at 18c8 [size=4]
	Region 4: I/O ports at 18e0 [size=32]
	Region 5: Memory at f8304000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/2 Enable+
		Address: fee0300c  Data: 414a
	Capabilities: [70] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a8] #12 [0010]

00:1f.3 SMBus: Intel Corporation 82801H (ICH8 Family) SMBus Controller (rev 03)
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 19
	Region 0: Memory at 8c000000 (32-bit, non-prefetchable) [size=256]
	Region 4: I/O ports at 1c00 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Unknown device 9581 (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at c7ef0000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at c7e00000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <4us, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM L0s L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [100] Unknown (11)

01:00.1 Audio device: ATI Technologies Inc Unknown device aa08
	Subsystem: ATI Technologies Inc Unknown device aa08
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at c7eec000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <4us, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM L0s L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x16
	Capabilities: [a0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [100] Unknown (11)

04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8101E PCI Express Fast Ethernet controller (rev 01)
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 4000 [size=256]
	Region 2: Memory at f0000000 (64-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at fa000000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] Vital Product Data
	Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [60] Express Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag+
		Device: Latency L0s <128ns, L1 unlimited
		Device: AtnBtn+ AtnInd+ PwrInd+
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s, Port 0
		Link: Latency L0s unlimited, L1 unlimited
		Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [84] Vendor Specific Information
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [12c] Virtual Channel
	Capabilities: [148] Device Serial Number 36-81-ec-10-00-00-00-02
	Capabilities: [154] Power Budgeting

05:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG Network Connection (rev 02)
	Subsystem: Intel Corporation Unknown device 1041
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [d0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <512ns, L1 unlimited
		Device: AtnBtn- AtnInd- PwrInd-
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, Port 0
		Link: Latency L0s <128ns, L1 <64us
		Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
		Link: Speed 2.5Gb/s, Width x1
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number f1-c4-72-ff-ff-77-1b-00

0c:04.0 CardBus bridge: Texas Instruments PCIxx12 Cardbus Controller
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f8004000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=0c, secondary=0d, subordinate=10, sec-latency=176
	Memory window 0: 88000000-8bfff000 (prefetchable)
	Memory window 1: 90000000-93fff000
	I/O window 0: 00007000-000070ff
	I/O window 1: 00007400-000074ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0c:04.1 FireWire (IEEE 1394): Texas Instruments PCIxx12 OHCI Compliant IEEE 1394 Host Controller (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems Unknown device ff00
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin B routed to IRQ 17
	Region 0: Memory at f8006000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at f8000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0c:04.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia Card Reader (SD/MMC/MS/MS PRO/xD)
	Subsystem: Toshiba America Info Systems Unknown device ff02
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at f8005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0c:04.3 Generic system peripheral [0805]: Texas Instruments PCIxx12 SDA Standard Compliant SD Host Controller (prog-if 01)
	Subsystem: Toshiba America Info Systems Unknown device ff02
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 57 (1750ns min, 1000ns max), Cache Line Size: 64 bytes
	Interrupt: pin C routed to IRQ 18
	Region 0: Memory at f8006800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



--------------010009000804050104070800--

