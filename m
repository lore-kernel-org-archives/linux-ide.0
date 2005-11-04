From: Peter Loibl <ploibl@yahoo.de>
Subject: Problems on a Intel EM64T with IDE and SATA for 2.6.14
Date: Fri, 04 Nov 2005 17:31:07 +0100
Message-ID: <436B8CCB.90809@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050100070906080100030108"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dialin-145-254-195-121.pools.arcor-ip.net ([145.254.195.121]:59991
	"EHLO obelix") by vger.kernel.org with ESMTP id S932090AbVKDQ0i
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2005 11:26:38 -0500
Received: from [192.168.42.2] (asterix [192.168.42.2])
	by obelix (8.13.3/8.13.1/SuSE Linux 0.7) with ESMTP id jA4GOqOY010311
	for <linux-ide@vger.kernel.org>; Fri, 4 Nov 2005 17:24:53 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050100070906080100030108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I have problems on a Intel EM64T with the comibined usage of IDE and SATA.

My standard boot disc is on a SATA disk which works pretty fine. 
However, if I try to load the driver for the IDE disks (piix), then I am 
not able to access any of the disks or the IDE CD ROM at all - even 
though the message log lists the disks correctly.

Just a side note: Before the move of the SATA driver into the SCSI 
subsystem (kernels 2.6.12 and older), the system got rather instable 
when loading piix. This is no longer the case (the system stays stable).

For further questions, pls. contact me.

Regards,
Peter Loibl

--------------050100070906080100030108
Content-Type: text/plain;
 name="ver_linux"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ver_linux"

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux obelix 2.6.13.4 #2 SMP Wed Oct 26 16:14:12 CEST 2005 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  3.3.5
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12q
mount                  2.12q
module-init-tools      3.2-pre1
e2fsprogs              1.36
jfsutils               1.1.7
reiserfsprogs          3.6.18
reiser4progs           1.0.3
xfsprogs               2.6.25
PPP                    2.4.3
isdn4k-utils           3.7
nfs-utils              1.0.7
Linux C Library        x  1 root root 1446783 Jun 11 01:09 /lib64/tls/libc.so.6
Dynamic linker (ldd)   2.3.4
Linux C++ Library      5.0.7
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.3.0
udev                   053
Modules Loaded         ipt_pkttype ipt_TCPMSS ipt_LOG ipt_limit floppy usbserial parport_pc lp parport thermal fan button battery ac cpufreq_userspace speedstep_centrino processor hisax crc_ccitt isdn slhc ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip6table_filter ip6_tables ipv6 edd evdev joydev st sr_mod sg nls_iso8859_1 nls_cp437 vfat fat md_mod dm_mod reiserfs ata_piix ahci ip_tables usblp uhci_hcd usbcore sk98lin sym53c8xx scsi_transport_spi sata_sil libata sd_mod scsi_mod

--------------050100070906080100030108
Content-Type: text/plain;
 name="driverbug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driverbug"

VERSION
=======

Linux version 2.6.14 (root@obelix) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #3 SMP Mon Oct 31 23:28:27 CET 2005

dmesg
=====

Bootdata ok (command line is root=/dev/sdb2 vga=0x31a selinux=0 splash=silent console=tty0 resume=/dev/sdb1 desktop elevator=as)
Linux version 2.6.14 (root@obelix) (gcc version 3.3.5 20050117 (prerelease) (SUSE Linux)) #3 SMP Mon Oct 31 23:28:27 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
 BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000fafa0
ACPI: RSDT (v001 A M I  OEMRSDT  0x02000503 MSFT 0x00000097) @ 0x000000003ffb0000
ACPI: FADT (v001 A M I  OEMFACP  0x02000503 MSFT 0x00000097) @ 0x000000003ffb0200
ACPI: MADT (v001 A M I  OEMAPIC  0x02000503 MSFT 0x00000097) @ 0x000000003ffb0390
ACPI: OEMB (v001 A M I  AMI_OEM  0x02000503 MSFT 0x00000097) @ 0x000000003ffbe040
ACPI: MCFG (v001 A M I  OEMMCFG  0x02000503 MSFT 0x00000097) @ 0x000000003ffb6cc0
ACPI: DSDT (v001  A0143 A0143006 0x00000006 INTL 0x02002026) @ 0x0000000000000000
On node 0 totalpages: 261967
  DMA zone: 3999 pages, LIFO batch:1
  Normal zone: 257968 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb00000)
Built 1 zonelists
Kernel command line: root=/dev/sdb2 vga=0x31a selinux=0 splash=silent console=tty0 resume=/dev/sdb1 desktop elevator=as
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 3412.276 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Memory: 1023404k/1048256k available (2342k kernel code, 24084k reserved, 903k data, 200k init)
Calibrating delay using timer specific routine.. 6834.51 BogoMIPS (lpj=13669024)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU0: Thermal monitoring enabled (TM1)
mtrr: v2.0 (20020519)
 tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
Parsing all Control Methods:...............................................................................................................................................................................................
Table [DSDT](id 0005) - 727 Objects with 54 Devices 191 Methods 23 Regions
ACPI Namespace successfully loaded at root ffffffff8048ddc0
evxfevnt-0091 [03] enable                : Transition to ACPI mode successful
Using local APIC timer interrupts.
Detected 4.886 MHz APIC timer.
softlockup thread 0 started up.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6824.70 BogoMIPS (lpj=13649401)
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU1: Thermal monitoring enabled (TM1)
              Intel(R) Pentium(R) 4 CPU 3.40GHz stepping 03
APIC error on CPU1: 00(40)
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -145 cycles, maxerr 952 cycles)
Brought up 2 CPUs
softlockup thread 1 started up.
time.c: Using PIT/TSC based timekeeping.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20050902
evgpeblk-0988 [06] ev_create_gpe_block   : GPE 00 to 1F [_GPE] 4 regs on int 0x9
evgpeblk-0996 [06] ev_create_gpe_block   : Found 11 Wake, Enabled 0 Runtime GPEs in this block
Completing Region/Field/Buffer/Package initialization:......................................................................................................................................................................
Initialized 22/23 Regions 26/26 Fields 41/41 Buffers 77/78 Packages (736 nodes)
Executing all Device _STA and_INI methods:..........................................................
58 Devices found containing: 58 _STA, 1 _INI methods
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:04:00.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P3._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 *15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 *14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 17 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
pnp: 00:07: ioport range 0x290-0x297 has been reserved
pnp: 00:09: ioport range 0x3f6-0x3f6 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: d2f00000-d7ffffff
  PREFETCH window: d8000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: c000-cfff
  MEM window: d2e00000-d2efffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 9000-bfff
  MEM window: d2d00000-d2dfffff
  PREFETCH window: 50000000-500fffff
acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1130802329.628:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
NTFS driver 2.1.24 [Flags: R/W DEBUG].
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
vesafb: framebuffer at 0xd8000000, mapped to 0xffffc20010100000, using 5120k, total 131072k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: Mode is not VGA compatible
Console: switching to colour frame buffer device 160x64
fb0: VESA VGA frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xffff8100000a0000
fb1: VGA16 VGA frame buffer device
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
input: AT Translated Set 2 keyboard on isa0060/serio0
Freeing unused kernel memory: 200k freed
SCSI subsystem initialized
libata version 1.12 loaded.
sata_sil version 0.9
ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 22 (level, low) -> IRQ 217
ata1: SATA max UDMA/100 cmd 0xFFFFC20000006480 ctl 0xFFFFC2000000648A bmdma 0xFFFFC20000006400 irq 217
ata2: SATA max UDMA/100 cmd 0xFFFFC200000064C0 ctl 0xFFFFC200000064CA bmdma 0xFFFFC20000006408 irq 217
ata3: SATA max UDMA/100 cmd 0xFFFFC20000006680 ctl 0xFFFFC2000000668A bmdma 0xFFFFC20000006600 irq 217
ata4: SATA max UDMA/100 cmd 0xFFFFC200000066C0 ctl 0xFFFFC200000066CA bmdma 0xFFFFC20000006608 irq 217
logips2pp: Detected unknown logitech mouse model 113
input: ImExPS/2 Logitech Explorer Mouse on isa0060/serio1
ata1: no device found (phy stat 00000000)
scsi0 : sata_sil
ata2: no device found (phy stat 00000000)
scsi1 : sata_sil
ata3: no device found (phy stat 00000000)
scsi2 : sata_sil
ata4: no device found (phy stat 00000000)
scsi3 : sata_sil
ACPI: PCI Interrupt 0000:01:09.0[A] -> GSI 17 (level, low) -> IRQ 177
sym0: <895> rev 0x1 at pci 0000:01:09.0 irq 177
sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi4 : sym-2.2.1
  Vendor: SEAGATE   Model: DAT    06240-XXX  Rev: 8110
  Type:   Sequential-Access                  ANSI SCSI revision: 03
 target4:0:14: Beginning Domain Validation
 target4:0:14: asynchronous.
 target4:0:14: wide asynchronous.
 target4:0:14: Domain Validation skipping write tests
 target4:0:14: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 31)
 target4:0:14: Ending Domain Validation
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 177
sk98lin: Network Device Driver v8.23.1.3
(C)Copyright 1999-2005 Marvell(R).
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 225, io base 0x00007000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 233, io base 0x00007080
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 50, io base 0x00007400
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 169, io base 0x00007480
usb 1-1: new full speed USB device using uhci_hcd and address 2
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-2: new full speed USB device using uhci_hcd and address 3
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x04F9 pid 0x0007
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ip_tables: (C) 2000-2002 Netfilter core team
ahci version 1.01
acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
usb 2-1: new full speed USB device using uhci_hcd and address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 4 ports detected
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ahci(0000:00:1f.2) AHCI 0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl IDE mode
ahci(0000:00:1f.2) flags: 64bit ncq pm led slum part 
ata5: SATA max UDMA/133 cmd 0xFFFFC20000014D00 ctl 0x0 bmdma 0x0 irq 233
ata6: SATA max UDMA/133 cmd 0xFFFFC20000014D80 ctl 0x0 bmdma 0x0 irq 233
ata7: SATA max UDMA/133 cmd 0xFFFFC20000014E00 ctl 0x0 bmdma 0x0 irq 233
ata8: SATA max UDMA/133 cmd 0xFFFFC20000014E80 ctl 0x0 bmdma 0x0 irq 233
ata5: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:003f
ata5: dev 0 ATA, max UDMA/100, 160836480 sectors: lba48
ata5: dev 0 configured for UDMA/100
scsi5 : ahci
ata6: no device found (phy stat 00000000)
scsi6 : ahci
ata7: dev 0 cfg 49:2f00 82:74eb 83:7fea 84:4023 85:74e9 86:3c02 87:4023 88:003f
ata7: dev 0 ATA, max UDMA/100, 321672960 sectors: lba48
ata7: dev 0 configured for UDMA/100
scsi7 : ahci
ata8: no device found (phy stat 00000000)
scsi8 : ahci
  Vendor: ATA       Model: HDS722580VLSA80   Rev: V32O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 160836480 512-byte hdwr sectors (82348 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 >
Attached scsi disk sda at scsi5, channel 0, id 0, lun 0
  Vendor: ATA       Model: HDS722516VLSA80   Rev: V34O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 321672960 512-byte hdwr sectors (164697 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 321672960 512-byte hdwr sectors (164697 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi7, channel 0, id 0, lun 0
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ReiserFS: sdb2: found reiserfs format "3.6" with standard journal
ReiserFS: sdb2: using ordered data mode
ReiserFS: sdb2: journal params: device sdb2, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb2: checking transaction log (sdb2)
ReiserFS: sdb2: Using r5 hash to sort names
Adding 1052216k swap on /dev/sdb1.  Priority:42 extents:1 across:1052216k
md: md driver 0.90.2 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 3.39
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
acpi_bus-0200 [01] bus_set_power         : Device is not power manageable
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 225, io mem 0xd2cff800
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
ieee1394: Initialized config rom entry `ip1394'
usb 2-1: USB disconnect, address 2
ICH6: IDE controller at PCI slot 0000:00:1f.1
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 50
ICH6: chipset revision 4
ICH6: 100% native mode on irq 50
    ide0: BM-DMA at 0x7800-0x7807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x7808-0x780f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: WDC WD1600JB-00FUA0, ATA DISK drive
usb 5-3: new high speed USB device using ehci_hcd and address 4
hub 5-3:1.0: USB hub found
hub 5-3:1.0: 4 ports detected
usb 1-1: USB disconnect, address 2
drivers/usb/class/usblp.c: usblp0: removed
ide0 at 0x8080-0x8087,0x8002 on irq 50
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1
Probing IDE interface ide1...
usb 1-1: new full speed USB device using uhci_hcd and address 4
APIC error on CPU1: 40(60)
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:01:03.0[A] -> GSI 21 (level, low) -> IRQ 58
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[58]  MMIO=[d2dfd800-d2dfdfff]  Max Packet=[4096]
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 4 if 0 alt 0 proto 2 vid 0x04F9 pid 0x0007
usb 1-2: USB disconnect, address 3
usb 1-2: new full speed USB device using uhci_hcd and address 5
irq 50: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80154064>{__report_bad_irq+48} <ffffffff801542a5>{note_interrupt+497}
       <ffffffff80153b85>{__do_IRQ+187} <ffffffff8010ff92>{do_IRQ+47}
       <ffffffff8010df2c>{ret_from_intr+0}  <EOI> 
handlers:
[<ffffffff88084b96>] (usb_hcd_irq+0x0/0x4a [usbcore])
[<ffffffff880bbb10>] (ide_intr+0x0/0x1fc [ide_core])
Disabling IRQ #50
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011d800001d6314]
Attached scsi generic sg0 at scsi4, channel 0, id 14, lun 0,  type 1
Attached scsi generic sg1 at scsi5, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi7, channel 0, id 0, lun 0,  type 0
st: Version 20050830, fixed bufsize 32768, s/g segs 256
Attached scsi tape st0 at scsi4, channel 0, id 14, lun 0
st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
hda: lost interrupt
irq 50: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80154064>{__report_bad_irq+48} <ffffffff801542a5>{note_interrupt+497}
       <ffffffff80153b85>{__do_IRQ+187} <ffffffff88151ae7>{:ehci_hcd:ehci_watchdog+0}
       <ffffffff8010ff92>{do_IRQ+47} <ffffffff8010df2c>{ret_from_intr+0}
       <ffffffff803462f4>{_spin_unlock_irqrestore+5} <ffffffff801386cc>{run_timer_softirq+366}
       <ffffffff801353aa>{__do_softirq+102} <ffffffff8010eca3>{call_softirq+31}
       <ffffffff8010ff5a>{do_softirq+50} <ffffffff8010e50a>{apic_timer_interrupt+98}
        <EOI> <ffffffff8010c35d>{mwait_idle+86} <ffffffff8010cb7a>{cpu_idle+79}
       <ffffffff804b674a>{start_kernel+466} <ffffffff804b6213>{_sinittext+531}
       
handlers:
[<ffffffff88084b96>] (usb_hcd_irq+0x0/0x4a [usbcore])
[<ffffffff880bbb10>] (ide_intr+0x0/0x1fc [ide_core])
Disabling IRQ #50
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff803ecb00(lo)
IPv6 over IPv4 tunneling driver
ip6_tables: (C) 2000-2002 Netfilter core team
Disabled Privacy Extensions on device ffff81003bdf5800(sit0)
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.3 (4094 buckets, 32752 max) - 304 bytes per conntrack
CSLIP: code copyright 1989 Regents of the University of California
ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/1.1.2.2/1.1.2.2 loaded
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.46.2.5
HiSax: Layer2 Revision 2.30.2.4
HiSax: TeiMgr Revision 2.20.2.3
HiSax: Layer3 Revision 2.22.2.3
HiSax: LinkLayer Revision 2.59.2.4
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=contr0 (0)
HiSax: AVM PCI driver Rev. 1.29.2.4
ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 21 (level, low) -> IRQ 58
AVM PCI: stat 0x2020a
AVM PCI: Class A Rev 2
HiSax: AVM Fritz!PCI config irq:58 base:0xBC00
AVM PCI: ISAC version (0): 2086/2186 V1.1
AVM Fritz PnP/PCI: IRQ 58 count 2
AVM PCI/PnP: reset
AVM PCI/PnP: S1 0
AVM Fritz PnP/PCI: IRQ 58 count 7
HiSax: DSS1 Rev. 2.32.2.3
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
HiSax: debugging flags card 1 set to 4
ACPI: CPU0 (power states: C1[C1])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: CPU1 (power states: C1[C1])
Parsing all Control Methods:....
Table [SSDT](id 0007) - 10 Objects with 0 Devices 4 Methods 0 Regions
Parsing all Control Methods:....
Table [SSDT](id 0008) - 10 Objects with 0 Devices 4 Methods 0 Regions
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (interrupt-driven).
lp0: console ready
eth0: no IPv6 routers present
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
hda: dma_timer_expiry: dma status == 0x24
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
end_request: I/O error, dev fd0, sector 0
end_request: I/O error, dev fd0, sector 0
hda: DMA interrupt recovery
hda: lost interrupt
irq 50: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80154064>{__report_bad_irq+48} <ffffffff801542a5>{note_interrupt+497}
       <ffffffff80153b85>{__do_IRQ+187} <ffffffff8010ff92>{do_IRQ+47}
       <ffffffff8010df2c>{ret_from_intr+0}  <EOI> 
handlers:
[<ffffffff88084b96>] (usb_hcd_irq+0x0/0x4a [usbcore])
[<ffffffff880bbb10>] (ide_intr+0x0/0x1fc [ide_core])
Disabling IRQ #50
usb 5-3.4: new full speed USB device using ehci_hcd and address 5
Initializing USB Mass Storage driver...
scsi9 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
  Vendor: Generic   Model: Traveling Disk    Rev: 1.11
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdc: 129024 512-byte hdwr sectors (66 MB)
sdc: Write Protect is off
sdc: Mode Sense: 03 00 00 00
sdc: assuming drive cache: write through
SCSI device sdc: 129024 512-byte hdwr sectors (66 MB)
sdc: Write Protect is off
sdc: Mode Sense: 03 00 00 00
sdc: assuming drive cache: write through
 sdc: sdc1
Attached scsi removable disk sdc at scsi9, channel 0, id 0, lun 0
Attached scsi generic sg3 at scsi9, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
hda: lost interrupt
irq 50: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80154064>{__report_bad_irq+48} <ffffffff801542a5>{note_interrupt+497}
       <ffffffff80153b85>{__do_IRQ+187} <ffffffff8010ff92>{do_IRQ+47}
       <ffffffff8010df2c>{ret_from_intr+0}  <EOI> <ffffffff803462c7>{_spin_lock+3}
       <ffffffff8018a72e>{__d_lookup+271} <ffffffff8022672a>{_atomic_dec_and_lock+34}
       <ffffffff8018ab7a>{dput+44} <ffffffff80182b09>{__link_path_walk+2020}
       <ffffffff801832dc>{link_path_walk+86} <ffffffff80171e85>{get_unused_fd+231}
       <ffffffff80183887>{path_lookup+453} <ffffffff80183965>{open_namei+155}
       <ffffffff801720ec>{filp_open+80} <ffffffff80171e85>{get_unused_fd+231}
       <ffffffff8017215b>{do_sys_open+59} <ffffffff8010d98a>{system_call+126}
       
handlers:
[<ffffffff88084b96>] (usb_hcd_irq+0x0/0x4a [usbcore])
[<ffffffff880bbb10>] (ide_intr+0x0/0x1fc [ide_core])
Disabling IRQ #50
sym0: SCSI parity error detected: SCR1=1 DBC=50000000 SBCL=0
sym0:0: ERROR (81:0) (8-0-0) (0/0/0) @ (scripta 38:4f1c8482).
sym0: script cmd = e21c0004
sym0: regdump: da 00 00 00 47 00 00 02 00 08 00 00 80 00 0f 02 28 f1 16 3f 02 ff ff ff.
sym0: SCSI BUS reset detected.
sym0: SCSI BUS has been reset.
hda: dma_timer_expiry: dma status == 0x24
hda: DMA interrupt recovery
hda: lost interrupt
irq 50: nobody cared (try booting with the "irqpoll" option)

Call Trace: <IRQ> <ffffffff80154064>{__report_bad_irq+48} <ffffffff801542a5>{note_interrupt+497}
       <ffffffff80153b85>{__do_IRQ+187} <ffffffff8010ff92>{do_IRQ+47}
       <ffffffff8010df2c>{ret_from_intr+0}  <EOI> <ffffffff8010c35d>{mwait_idle+86}
       <ffffffff882b17f9>{:processor:acpi_processor_idle+307}
       <ffffffff8010cb7a>{cpu_idle+79} <ffffffff804b674a>{start_kernel+466}
       <ffffffff804b6213>{_sinittext+531} 
handlers:
[<ffffffff88084b96>] (usb_hcd_irq+0x0/0x4a [usbcore])
[<ffffffff880bbb10>] (ide_intr+0x0/0x1fc [ide_core])
Disabling IRQ #50

CPU INFO
========

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) 4 CPU 3.40GHz
stepping	: 3
cpu MHz		: 3412.276
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr
bogomips	: 6834.51
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	:               Intel(R) Pentium(R) 4 CPU 3.40GHz
stepping	: 3
cpu MHz		: 3412.276
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr
bogomips	: 6824.70
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:


MODULES
=======

ipt_TCPMSS 4096 1 - Live 0xffffffff8831b000
ipt_LOG 6912 7 - Live 0xffffffff88318000
ipt_limit 2560 7 - Live 0xffffffff882e3000
usb_storage 64192 0 - Live 0xffffffff88307000
floppy 65192 0 - Live 0xffffffff882f6000
usbserial 29680 0 - Live 0xffffffff882ed000
parport_pc 26728 1 - Live 0xffffffff882e5000
lp 11856 0 - Live 0xffffffff882df000
parport 34828 2 parport_pc,lp, Live 0xffffffff882d5000
thermal 20496 0 - Live 0xffffffff882ce000
fan 5640 0 - Live 0xffffffff882cb000
button 8480 0 - Live 0xffffffff882c7000
battery 12936 0 - Live 0xffffffff882c2000
ac 6408 0 - Live 0xffffffff882bf000
cpufreq_userspace 5056 2 - Live 0xffffffff882bc000
speedstep_centrino 5344 1 - Live 0xffffffff882b9000
processor 36832 2 thermal,speedstep_centrino, Live 0xffffffff882af000
hisax 427940 2 - Live 0xffffffff88245000
crc_ccitt 2432 1 hisax, Live 0xffffffff88243000
isdn 129120 9 hisax, Live 0xffffffff88222000
slhc 6528 1 isdn, Live 0xffffffff8821f000
ipt_state 2176 11 - Live 0xffffffff8821d000
ip6t_REJECT 4736 3 - Live 0xffffffff8821a000
ipt_REJECT 4992 3 - Live 0xffffffff88217000
iptable_mangle 2944 0 - Live 0xffffffff88215000
iptable_nat 7428 0 - Live 0xffffffff88212000
iptable_filter 3072 1 - Live 0xffffffff88210000
ip6table_mangle 2688 0 - Live 0xffffffff88164000
ip_nat_ftp 3584 0 - Live 0xffffffff8815e000
ip_nat 17948 2 iptable_nat,ip_nat_ftp, Live 0xffffffff8820a000
ip_conntrack_ftp 7248 1 ip_nat_ftp, Live 0xffffffff88207000
ip_conntrack 47136 5 ipt_state,iptable_nat,ip_nat_ftp,ip_nat,ip_conntrack_ftp, Live 0xffffffff881fa000
nfnetlink 5960 2 ip_nat,ip_conntrack, Live 0xffffffff881f7000
ip6table_filter 2944 1 - Live 0xffffffff88158000
ip6_tables 17936 3 ip6t_REJECT,ip6table_mangle,ip6table_filter, Live 0xffffffff881f1000
ipv6 250752 19 ip6t_REJECT, Live 0xffffffff881b2000
edd 10016 0 - Live 0xffffffff881ae000
evdev 10368 0 - Live 0xffffffff881aa000
joydev 9600 0 - Live 0xffffffff881a6000
st 37676 0 - Live 0xffffffff8819b000
sr_mod 15524 0 - Live 0xffffffff88196000
sg 35384 0 - Live 0xffffffff8818c000
ohci1394 30392 0 - Live 0xffffffff88183000
ieee1394 89336 1 ohci1394, Live 0xffffffff8816c000
nls_iso8859_1 5504 1 - Live 0xffffffff88169000
nls_cp437 7296 1 - Live 0xffffffff88166000
piix 11268 0 [permanent], Live 0xffffffff88160000
i2c_i801 8852 0 - Live 0xffffffff8815a000
ehci_hcd 30472 0 - Live 0xffffffff8814f000
i2c_core 19456 1 i2c_i801, Live 0xffffffff88149000
dm_mod 48600 0 - Live 0xffffffff8813c000
md_mod 55296 0 - Live 0xffffffff8812d000
reiserfs 233336 1 - Live 0xffffffff880f3000
ide_cd 37792 0 - Live 0xffffffff880e8000
cdrom 36008 2 sr_mod,ide_cd, Live 0xffffffff880de000
ide_disk 14720 0 - Live 0xffffffff880d9000
ide_core 130372 4 usb_storage,piix,ide_cd,ide_disk, Live 0xffffffff880b8000
ata_piix 8836 0 - Live 0xffffffff880b4000
ahci 10628 3 - Live 0xffffffff880b0000
ip_tables 19216 8 ipt_TCPMSS,ipt_LOG,ipt_limit,ipt_state,ipt_REJECT,iptable_mangle,iptable_nat,iptable_filter, Live 0xffffffff880aa000
usblp 12416 0 - Live 0xffffffff880a5000
uhci_hcd 30112 0 - Live 0xffffffff8809c000
usbcore 110752 6 usb_storage,usbserial,ehci_hcd,usblp,uhci_hcd, Live 0xffffffff8807f000
sk98lin 179172 1 - Live 0xffffffff88052000
sym53c8xx 74660 1 - Live 0xffffffff8803e000
scsi_transport_spi 21632 1 sym53c8xx, Live 0xffffffff88037000
sata_sil 8196 0 - Live 0xffffffff88033000
libata 42512 3 ata_piix,ahci,sata_sil, Live 0xffffffff88027000
sd_mod 15744 5 - Live 0xffffffff88022000
scsi_mod 133136 9 usb_storage,st,sr_mod,sg,ahci,sym53c8xx,scsi_transport_spi,libata,sd_mod, Live 0xffffffff88000000

IO PORTS
========

0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0290-0297 : pnp 00:07
0378-037a : parport0
037b-037f : parport0
03c0-03df : vesafb
03f6-03f6 : pnp 00:09
03f8-03ff : serial
0400-041f : 0000:00:1f.3
  0400-0407 : i801-smbus
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0810-0815 : ACPI CPU throttle
0820-0820 : PM2_CNT_BLK
0828-082f : GPE0_BLK
0cf8-0cff : PCI conf1
7000-701f : 0000:00:1d.0
  7000-701f : uhci_hcd
7080-709f : 0000:00:1d.1
  7080-709f : uhci_hcd
7400-741f : 0000:00:1d.2
  7400-741f : uhci_hcd
7480-749f : 0000:00:1d.3
  7480-749f : uhci_hcd
7800-780f : 0000:00:1f.1
  7800-7807 : ide0
  7808-780f : ide1
7880-7883 : 0000:00:1f.1
7c00-7c07 : 0000:00:1f.1
8000-8003 : 0000:00:1f.1
  8002-8002 : ide0
8080-8087 : 0000:00:1f.1
  8080-8087 : ide0
8400-840f : 0000:00:1f.2
  8400-840f : ahci
8480-8483 : 0000:00:1f.2
  8480-8483 : ahci
8800-8807 : 0000:00:1f.2
  8800-8807 : ahci
8880-8883 : 0000:00:1f.2
  8880-8883 : ahci
8c00-8c07 : 0000:00:1f.2
  8c00-8c07 : ahci
9000-bfff : PCI Bus #01
  9c00-9c0f : 0000:01:04.0
  a000-a003 : 0000:01:04.0
  a080-a087 : 0000:01:04.0
  a400-a403 : 0000:01:04.0
  a480-a487 : 0000:01:04.0
  a800-a80f : 0000:01:05.0
    a800-a80f : sata_sil
  a880-a883 : 0000:01:05.0
    a880-a883 : sata_sil
  ac00-ac07 : 0000:01:05.0
    ac00-ac07 : sata_sil
  b000-b0ff : 0000:01:09.0
    b000-b0ff : sym53c8xx
  b800-b803 : 0000:01:05.0
    b800-b803 : sata_sil
  b880-b887 : 0000:01:05.0
    b880-b887 : sata_sil
  bc00-bc1f : 0000:01:0a.0
    bc00-bc1f : avm PCI
c000-cfff : PCI Bus #02
  c800-c8ff : 0000:02:00.0
    c800-c8ff : sk98lin
d000-dfff : PCI Bus #03
e000-efff : PCI Bus #04

IO MEM
======

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cf000-000d37ff : Adapter ROM
000d3800-000d39ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffaffff : System RAM
  00100000-0034980b : Kernel code
  0034980c-0042b7d7 : Kernel data
3ffb0000-3ffbdfff : ACPI Tables
3ffbe000-3ffeffff : ACPI Non-volatile Storage
3fff0000-3fffffff : reserved
50000000-500fffff : PCI Bus #01
  50000000-5007ffff : 0000:01:05.0
  50080000-5009ffff : 0000:01:04.0
  500a0000-500affff : 0000:01:09.0
d2cf4000-d2cf7fff : 0000:00:1b.0
d2cff800-d2cffbff : 0000:00:1d.7
  d2cff800-d2cffbff : ehci_hcd
d2cffc00-d2cfffff : 0000:00:1f.2
  d2cffc00-d2cfffff : ahci
d2d00000-d2dfffff : PCI Bus #01
  d2da0000-d2daffff : 0000:01:00.0
  d2db0000-d2dbffff : 0000:01:00.0
  d2df8000-d2dfbfff : 0000:01:03.0
  d2dfd800-d2dfdfff : 0000:01:03.0
    d2dfd800-d2dfdfff : ohci1394
  d2dfe000-d2dfefff : 0000:01:09.0
    d2dfe000-d2dfefff : sym53c8xx
  d2dff400-d2dff7ff : 0000:01:05.0
    d2dff400-d2dff7ff : sata_sil
  d2dff800-d2dff8ff : 0000:01:09.0
    d2dff800-d2dff8ff : sym53c8xx
  d2dffc00-d2dffc1f : 0000:01:0a.0
d2e00000-d2efffff : PCI Bus #02
  d2ec0000-d2edffff : 0000:02:00.0
  d2efc000-d2efffff : 0000:02:00.0
    d2efc000-d2efffff : sk98lin
d2f00000-d7ffffff : PCI Bus #04
  d2fe0000-d2ffffff : 0000:04:00.0
  d3000000-d3ffffff : 0000:04:00.0
  d4000000-d7ffffff : 0000:04:00.0
d8000000-dfffffff : PCI Bus #04
  d8000000-dfffffff : 0000:04:00.0
    d8000000-dfffffff : vesafb
ffb00000-ffffffff : reserved

SCSI
====

Attached devices:
Host: scsi4 Channel: 00 Id: 14 Lun: 00
  Vendor: SEAGATE  Model: DAT    06240-XXX Rev: 8110
  Type:   Sequential-Access                ANSI SCSI revision: 03
Host: scsi5 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HDS722580VLSA80  Rev: V32O
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi7 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: HDS722516VLSA80  Rev: V34O
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi9 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: Traveling Disk   Rev: 1.11
  Type:   Direct-Access                    ANSI SCSI revision: 02

lspci
=====

0000:00:00.0 Host bridge: Intel Corporation 925X/XE Memory Controller Hub (rev 0e)
	Subsystem: Intel Corporation: Unknown device 2580
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: [e0] #09 [0109]

0000:00:01.0 PCI bridge: Intel Corporation 925X/XE PCI Express Root Port (rev 0e) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: d2f00000-d7ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 40c1
	Capabilities: [a0] #10 [0141]

0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 813d
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d2cf4000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 40c9
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: d2e00000-d2efffff
	Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [40] #10 [0141]
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
		Address: fee01004  Data: 40d1
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 225
	Region 4: I/O ports at 7000 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 233
	Region 4: I/O ports at 7080 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 50
	Region 4: I/O ports at 7400 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 169
	Region 4: I/O ports at 7480 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 225
	Region 0: Memory at d2cff800 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-0000bfff
	Memory behind bridge: d2d00000-d2dfffff
	Prefetchable memory behind bridge: 0000000050000000-0000000050000000
	BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 50
	Region 0: I/O ports at 8080 [size=8]
	Region 1: I/O ports at 8000 [size=4]
	Region 2: I/O ports at 7c00 [size=8]
	Region 3: I/O ports at 7880 [size=4]
	Region 4: I/O ports at 7800 [size=16]

0000:00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA Controller (rev 04) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 2601
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 233
	Region 0: I/O ports at 8c00 [size=8]
	Region 1: I/O ports at 8880 [size=4]
	Region 2: I/O ports at 8800 [size=8]
	Region 3: I/O ports at 8480 [size=4]
	Region 4: I/O ports at 8400 [size=16]
	Region 5: Memory at d2cffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [70] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at 0400 [size=32]

0000:01:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown device 1fa7 (rev 07)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 138f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 04
	Interrupt: pin A routed to IRQ 14
	Region 0: Memory at d2db0000 (32-bit, non-prefetchable) [size=64K]
	Region 1: Memory at d2da0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:03.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link Layer Controller (rev 01) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc.: Unknown device 813c
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 1000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 58
	Region 0: Memory at d2dfd800 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at d2df8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:01:04.0 Unknown mass storage controller: Integrated Technology Express, Inc. IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be IT8212, embedded seems (rev 13)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 813a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a480 [size=8]
	Region 1: I/O ports at a400 [size=4]
	Region 2: I/O ports at a080 [size=8]
	Region 3: I/O ports at a000 [size=4]
	Region 4: I/O ports at 9c00 [size=16]
	Expansion ROM at 50080000 [disabled] [size=128K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:05.0 Unknown mass storage controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (rev 02)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 8136
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 04
	Interrupt: pin A routed to IRQ 217
	Region 0: I/O ports at b880 [size=8]
	Region 1: I/O ports at b800 [size=4]
	Region 2: I/O ports at ac00 [size=8]
	Region 3: I/O ports at a880 [size=4]
	Region 4: I/O ports at a800 [size=16]
	Region 5: Memory at d2dff400 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at 50000000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:01:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
	Subsystem: Tekram Technology Co.,Ltd. DC-390U2W
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (7500ns min, 16000ns max), cache line size 20
	Interrupt: pin A routed to IRQ 177
	Region 0: I/O ports at b000 [size=256]
	Region 1: Memory at d2dff800 (32-bit, non-prefetchable) [size=256]
	Region 2: Memory at d2dfe000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 500a0000 [disabled] [size=64K]

0000:01:0a.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
	Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card ISDN Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 58
	Region 0: Memory at d2dffc00 (32-bit, non-prefetchable) [size=32]
	Region 1: I/O ports at bc00 [size=32]

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 15)
	Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet Controller (Asus)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR+ <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 177
	Region 0: Memory at d2efc000 (64-bit, non-prefetchable) [size=16K]
	Region 2: I/O ports at c800 [size=256]
	Expansion ROM at d2ec0000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [e0] #10 [0011]

0000:04:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0140 (rev a2) (prog-if 00 [VGA])
	Subsystem: Giga-byte Technology: Unknown device 3125
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=64M]
	Region 1: Memory at d8000000 (64-bit, prefetchable) [size=128M]
	Region 3: Memory at d3000000 (64-bit, non-prefetchable) [size=16M]
	Expansion ROM at d2fe0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [78] #10 [0001]


--------------050100070906080100030108--
