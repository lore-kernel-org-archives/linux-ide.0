From: Utku Somer <utku@zeitin.com>
Subject: utku's sata freeze and hard reset problem
Date: Mon, 18 May 2009 03:58:10 +0300
Message-ID: <4A10B2A2.3030003@zeitin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host-212-154-27-247.parkyeri.net ([212.154.27.247]:47264 "EHLO
	witten.zeitin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbZERBSX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 21:18:23 -0400
Received: from [85.105.94.127] (helo=[192.168.42.3])
	by witten.zeitin.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <utku@zeitin.com>)
	id 1M5rBS-0008ES-Jz
	for linux-ide@vger.kernel.org; Mon, 18 May 2009 03:58:29 +0300
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org



I have started getting this error from the sata kernel code which
freezes my system for 20-30 seconds. I haven't been able to tell the
exact reason so far. My current configuration is two SATA disks on
which three partitions are raided with soft raid1.

Here is the error, which I get for both the disks from time to time:

May 18 02:19:32 peace kernel: [ 1483.509617] ata2.00: exception Emask 
0x0 SAct 0x1 SErr 0x0 action 0x6 frozen
May 18 02:19:32 peace kernel: [ 1483.509634] ata2.00: cmd 
61/08:00:d9:89:a1/00:00:12:00:00/40 tag 0 ncq 4096 out
May 18 02:19:32 peace kernel: [ 1483.509637]          res 
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
May 18 02:19:32 peace kernel: [ 1483.509643] ata2.00: status: { DRDY }
May 18 02:19:32 peace kernel: [ 1483.509656] ata2: hard resetting link
May 18 02:19:33 peace kernel: [ 1484.323823] ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 300)
May 18 02:19:33 peace kernel: [ 1484.326730] ata2.00: configured for 
UDMA/133
May 18 02:19:33 peace kernel: [ 1484.326744] ata2: EH complete
May 18 02:19:33 peace kernel: [ 1484.327807] sd 1:0:0:0: [sdb] 312581808 
512-byte hardware sectors (160042 MB)
May 18 02:19:33 peace kernel: [ 1484.330598] sd 1:0:0:0: [sdb] Write 
Protect is off
May 18 02:19:33 peace kernel: [ 1484.330598] sd 1:0:0:0: [sdb] Mode 
Sense: 00 3a 00 00
May 18 02:19:33 peace kernel: [ 1484.327807] sd 1:0:0:0: [sdb] Write 
cache: enabled, read cache: enabled, doesn't support DPO or FUA


Apparently the controller is timing out and I am getting a hard reset.

Here are some interesting facts, as I toyed with this error so far:

- I was not having these freezes two weeks ago, so naturally at first
  I thought one of the disks was going bad, so I immediately backed up
  the stuff. I also had a kernel upgrade gone bad at the time, after
  which I ended up with a non-booting system, so I just made a quick
  reinstall of my debian system. I also changed the partitioning of my
  disks, my old configuration was both disks had 1 partition which was
  raid1 on which there was an lvm which kept the partitions. I got rid
  of the lvm, and made 3 partitions on both disks which I made
  raid1. I noticed the errors as I was installing the new system.

- I did try going back to the old kernel, 2.6.26-1 of debian, but I
  still got the errors.

- I have checked cleanliness of the cables and the connections. I
  could not check the voltage yet.

- I did fiddle with the SATA settings on the motherboard BIOS. But I
  leave the setting in AHCI after all.

- I checked the disks with smartctl, but did not find any errors. I am
  attaching the status of the disks in case somebody needs them.

- When I ran smartctl tests on the drives, if the error above
  happened, the test would fail because of the hard host reset. The
  short tests would fail if I did them simultaneously for both
  drives. In the case of the long test though, the test would fail if
  I didn't do it simultaneously for both the drives, and the error
  would come from the idle drive that I wasn't testing.

- I removed one of the disks from the raid array, took it out from the
  system. Still errors. I then removed the other disk as well. I still
  got the errors with single disks with degraded raid1s.

- I started looking at the source of libata in kernel 2.6.26, but it
  is now getting late here, and I have decided to send this email to
  the list. Any help would be appreciated.

Here is my bootup /var/log/syslog messages, this one is from the last
boot when I had just put back /dev/sdb back into the system:


May 18 03:03:43 peace kernel: imklog 3.18.6, log source = /proc/kmsg 
started.
May 18 03:03:43 peace kernel: [    0.000000] Initializing cgroup subsys 
cpuset
May 18 03:03:43 peace kernel: [    0.000000] Initializing cgroup subsys cpu
May 18 03:03:43 peace kernel: [    0.000000] Linux version 2.6.26-2-686 
(Debian 2.6.26-15lenny2) (dannf@debian.org) (gcc version 4.1.3 20080704 
(prerelease) (Debian 4.1.2-25)) #1 SMP Mon May 11 19:00:59 UTC 2009
May 18 03:03:43 peace kernel: [    0.000000] BIOS-provided physical RAM map:
May 18 03:03:43 peace kernel: [    0.000000]  BIOS-e820: 
0000000000000000 - 000000000009fc00 (usable)
May 18 03:03:43 peace kernel: [    0.000000]  BIOS-e820: 
000000000009fc00 - 00000000000a0000 (reserved)
May 18 03:03:43 peace kernel: [    0.000000]  BIOS-e820: 
00000000000e4000 - 0000000000100000 (reserved)
May 18 03:03:43 peace kernel: [    0.000000]  BIOS-e820: 
0000000000100000 - 000000003ffb0000 (usable)
May 18 03:03:43 peace kernel: [    0.000000]  BIOS-e820: 
000000003ffb0000 - 000000003ffbe000 (ACPI data)
May 18 03:03:43 peace kernel: [    0.000000]  BIOS-e820: 
000000003ffbe000 - 000000003fff0000 (ACPI NVS)
May 18 03:03:43 peace kernel: [    0.000000]  BIOS-e820: 
000000003fff0000 - 0000000040000000 (reserved)
May 18 03:03:43 peace kernel: [    0.000000]  BIOS-e820: 
00000000ffb80000 - 0000000100000000 (reserved)
May 18 03:03:43 peace kernel: [    0.000000] 127MB HIGHMEM available.
May 18 03:03:43 peace kernel: [    0.000000] 896MB LOWMEM available.
May 18 03:03:43 peace kernel: [    0.000000] found SMP MP-table at 
[c00ff780] 000ff780
May 18 03:03:43 peace kernel: [    0.000000] Entering 
add_active_range(0, 0, 262064) 0 entries of 256 used
May 18 03:03:43 peace kernel: [    0.000000] Zone PFN ranges:
May 18 03:03:43 peace kernel: [    0.000000]   DMA             0 ->     4096
May 18 03:03:43 peace kernel: [    0.000000]   Normal       4096 ->   229376
May 18 03:03:43 peace kernel: [    0.000000]   HighMem    229376 ->   262064
May 18 03:03:43 peace kernel: [    0.000000] Movable zone start PFN for 
each node
May 18 03:03:43 peace kernel: [    0.000000] early_node_map[1] active 
PFN ranges
May 18 03:03:43 peace kernel: [    0.000000]     0:        0 ->   262064
May 18 03:03:43 peace kernel: [    0.000000] On node 0 totalpages: 262064
May 18 03:03:43 peace kernel: [    0.000000]   DMA zone: 32 pages used 
for memmap
May 18 03:03:43 peace kernel: [    0.000000]   DMA zone: 0 pages reserved
May 18 03:03:43 peace kernel: [    0.000000]   DMA zone: 4064 pages, 
LIFO batch:0
May 18 03:03:43 peace kernel: [    0.000000]   Normal zone: 1760 pages 
used for memmap
May 18 03:03:43 peace kernel: [    0.000000]   Normal zone: 223520 
pages, LIFO batch:31
May 18 03:03:43 peace kernel: [    0.000000]   HighMem zone: 256 pages 
used for memmap
May 18 03:03:43 peace kernel: [    0.000000]   HighMem zone: 32432 
pages, LIFO batch:7
May 18 03:03:43 peace kernel: [    0.000000]   Movable zone: 0 pages 
used for memmap
May 18 03:03:43 peace kernel: [    0.000000] DMI 2.3 present.
May 18 03:03:43 peace kernel: [    0.000000] ACPI: RSDP 000FB030, 0014 
(r0 ACPIAM)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: RSDT 3FFB0000, 0034 
(r1 A M I  OEMRSDT   2000606 MSFT       97)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: FACP 3FFB0200, 0081 
(r1 A M I  OEMFACP   2000606 MSFT       97)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: DSDT 3FFB0400, 6A11 
(r1  A0079 A0079003        3 INTL  2002026)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: FACS 3FFBE000, 0040
May 18 03:03:43 peace kernel: [    0.000000] ACPI: APIC 3FFB0390, 0070 
(r1 A M I  OEMAPIC   2000606 MSFT       97)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: OEMB 3FFBE040, 0046 
(r1 A M I  AMI_OEM   2000606 MSFT       97)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: MCFG 3FFB6E20, 003C 
(r1 A M I  OEMMCFG   2000606 MSFT       97)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x808
May 18 03:03:43 peace kernel: [    0.000000] ACPI: Local APIC address 
0xfee00000
May 18 03:03:43 peace kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] 
lapic_id[0x00] enabled)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] 
lapic_id[0x01] enabled)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: IOAPIC (id[0x02] 
address[0xfec00000] gsi_base[0])
May 18 03:03:43 peace kernel: [    0.000000] IOAPIC[0]: apic_id 2, 
version 32, address 0xfec00000, GSI 0-23
May 18 03:03:43 peace kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 
bus_irq 0 global_irq 2 dfl dfl)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 
bus_irq 9 global_irq 9 high level)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 
bus_irq 0 global_irq 2 dfl dfl)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 
bus_irq 9 global_irq 9 high level)
May 18 03:03:43 peace kernel: [    0.000000] ACPI: IRQ0 used by override.
May 18 03:03:43 peace kernel: [    0.000000] ACPI: IRQ2 used by override.
May 18 03:03:43 peace kernel: [    0.000000] ACPI: IRQ9 used by override.
May 18 03:03:43 peace kernel: [    0.000000] Enabling APIC mode:  Flat.  
Using 1 I/O APICs
May 18 03:03:43 peace kernel: [    0.000000] Using ACPI (MADT) for SMP 
configuration information
May 18 03:03:43 peace kernel: [    0.000000] Allocating PCI resources 
starting at 50000000 (gap: 40000000:bfb80000)
May 18 03:03:43 peace kernel: [    0.000000] PM: Registered nosave 
memory: 000000000009f000 - 00000000000a0000
May 18 03:03:43 peace kernel: [    0.000000] PM: Registered nosave 
memory: 00000000000a0000 - 00000000000e4000
May 18 03:03:43 peace kernel: [    0.000000] PM: Registered nosave 
memory: 00000000000e4000 - 0000000000100000
May 18 03:03:43 peace kernel: [    0.000000] SMP: Allowing 2 CPUs, 0 
hotplug CPUs
May 18 03:03:43 peace kernel: [    0.000000] PERCPU: Allocating 37960 
bytes of per cpu data
May 18 03:03:43 peace kernel: [    0.000000] NR_CPUS: 8, nr_cpu_ids: 2
May 18 03:03:43 peace kernel: [    0.000000] Built 1 zonelists in Zone 
order, mobility grouping on.  Total pages: 260016
May 18 03:03:43 peace kernel: [    0.000000] Kernel command line: 
root=/dev/md2 ro quiet
May 18 03:03:43 peace kernel: [    0.000000] mapped APIC to ffffb000 
(fee00000)
May 18 03:03:43 peace kernel: [    0.000000] mapped IOAPIC to ffffa000 
(fec00000)
May 18 03:03:43 peace kernel: [    0.000000] Enabling fast FPU save and 
restore... done.
May 18 03:03:43 peace kernel: [    0.000000] Enabling unmasked SIMD FPU 
exception support... done.
May 18 03:03:43 peace kernel: [    0.000000] Initializing CPU#0
May 18 03:03:43 peace kernel: [    0.000000] PID hash table entries: 
4096 (order: 12, 16384 bytes)
May 18 03:03:43 peace kernel: [    0.000000] Detected 3010.753 MHz 
processor.
May 18 03:03:43 peace kernel: [    0.004000] Console: colour VGA+ 80x25
May 18 03:03:43 peace kernel: [    0.004000] console [tty0] enabled
May 18 03:03:43 peace kernel: [    0.004000] Dentry cache hash table 
entries: 131072 (order: 7, 524288 bytes)
May 18 03:03:43 peace kernel: [    0.004000] Inode-cache hash table 
entries: 65536 (order: 6, 262144 bytes)
May 18 03:03:43 peace kernel: [    0.004000] Memory: 1027940k/1048256k 
available (1769k kernel code, 19600k reserved, 752k data, 244k init, 
130752k highmem)
May 18 03:03:43 peace kernel: [    0.004000] virtual kernel memory layout:
May 18 03:03:43 peace kernel: [    0.004000]     fixmap  : 0xfff4c000 - 
0xfffff000   ( 716 kB)
May 18 03:03:43 peace kernel: [    0.004000]     pkmap   : 0xff800000 - 
0xffc00000   (4096 kB)
May 18 03:03:43 peace kernel: [    0.004000]     vmalloc : 0xf8800000 - 
0xff7fe000   ( 111 MB)
May 18 03:03:43 peace kernel: [    0.004000]     lowmem  : 0xc0000000 - 
0xf8000000   ( 896 MB)
May 18 03:03:43 peace kernel: [    0.004000]       .init : 0xc037f000 - 
0xc03bc000   ( 244 kB)
May 18 03:03:43 peace kernel: [    0.004000]       .data : 0xc02ba5eb - 
0xc0376620   ( 752 kB)
May 18 03:03:43 peace kernel: [    0.004000]       .text : 0xc0100000 - 
0xc02ba5eb   (1769 kB)
May 18 03:03:43 peace kernel: [    0.004000] Checking if this processor 
honours the WP bit even in supervisor mode...Ok.
May 18 03:03:43 peace kernel: [    0.004000] CPA: page pool initialized 
1 of 1 pages preallocated
May 18 03:03:43 peace kernel: [    0.084152] Calibrating delay using 
timer specific routine.. 6028.21 BogoMIPS (lpj=12056423)
May 18 03:03:43 peace kernel: [    0.084195] Security Framework initialized
May 18 03:03:43 peace kernel: [    0.084201] SELinux:  Disabled at boot.
May 18 03:03:43 peace kernel: [    0.084205] Capability LSM initialized
May 18 03:03:43 peace kernel: [    0.084222] Mount-cache hash table 
entries: 512
May 18 03:03:43 peace kernel: [    0.084382] Initializing cgroup subsys ns
May 18 03:03:43 peace kernel: [    0.084387] Initializing cgroup subsys 
cpuacct
May 18 03:03:43 peace kernel: [    0.084390] Initializing cgroup subsys 
devices
May 18 03:03:43 peace kernel: [    0.084417] CPU: Trace cache: 12K uops, 
L1 D cache: 16K
May 18 03:03:43 peace kernel: [    0.084421] CPU: L2 cache: 1024K
May 18 03:03:43 peace kernel: [    0.084424] CPU: Physical Processor ID: 0
May 18 03:03:43 peace kernel: [    0.084427] Intel machine check 
architecture supported.
May 18 03:03:43 peace kernel: [    0.084434] Intel machine check 
reporting enabled on CPU#0.
May 18 03:03:43 peace kernel: [    0.084437] CPU0: Intel P4/Xeon 
Extended MCE MSRs (12) available
May 18 03:03:43 peace kernel: [    0.084442] CPU0: Thermal monitoring 
enabled
May 18 03:03:43 peace kernel: [    0.084444] using mwait in idle threads.
May 18 03:03:43 peace kernel: [    0.084457] Checking 'hlt' 
instruction... OK.
May 18 03:03:43 peace kernel: [    0.101671] ACPI: Core revision 20080321
May 18 03:03:43 peace kernel: [    0.120168] ENABLING IO-APIC IRQs
May 18 03:03:43 peace kernel: [    0.120345] ..TIMER: vector=0x31 
apic1=0 pin1=2 apic2=-1 pin2=-1
May 18 03:03:43 peace kernel: [    0.160010] CPU0: Intel(R) Pentium(R) 4 
CPU 3.00GHz stepping 04
May 18 03:03:43 peace kernel: [    0.160010] Booting processor 1/1 ip 6000
May 18 03:03:43 peace kernel: [    0.168010] Initializing CPU#1
May 18 03:03:43 peace kernel: [    0.168010] Calibrating delay using 
timer specific routine.. 6021.80 BogoMIPS (lpj=12043610)
May 18 03:03:43 peace kernel: [    0.168010] CPU: Trace cache: 12K uops, 
L1 D cache: 16K
May 18 03:03:43 peace kernel: [    0.168010] CPU: L2 cache: 1024K
May 18 03:03:43 peace kernel: [    0.168010] CPU: Physical Processor ID: 0
May 18 03:03:43 peace kernel: [    0.168010] Intel machine check 
architecture supported.
May 18 03:03:43 peace kernel: [    0.168010] Intel machine check 
reporting enabled on CPU#1.
May 18 03:03:43 peace kernel: [    0.168010] CPU1: Intel P4/Xeon 
Extended MCE MSRs (12) available
May 18 03:03:43 peace kernel: [    0.168010] CPU1: Thermal monitoring 
enabled
May 18 03:03:43 peace kernel: [    0.248015] CPU1: Intel(R) Pentium(R) 4 
CPU 3.00GHz stepping 04
May 18 03:03:43 peace kernel: [    0.248015] checking TSC 
synchronization [CPU#0 -> CPU#1]: passed.
May 18 03:03:43 peace kernel: [    0.252015] Brought up 2 CPUs
May 18 03:03:43 peace kernel: [    0.252015] Total of 2 processors 
activated (12050.01 BogoMIPS).
May 18 03:03:43 peace kernel: [    0.252015] CPU0 attaching sched-domain:
May 18 03:03:43 peace kernel: [    0.252015]  domain 0: span 0-1
May 18 03:03:43 peace kernel: [    0.252015]   groups: 0 1
May 18 03:03:43 peace kernel: [    0.252015]   domain 1: span 0-1
May 18 03:03:43 peace kernel: [    0.252015]    groups: 0-1
May 18 03:03:43 peace kernel: [    0.252015] CPU1 attaching sched-domain:
May 18 03:03:43 peace kernel: [    0.252015]  domain 0: span 0-1
May 18 03:03:43 peace kernel: [    0.252015]   groups: 1 0
May 18 03:03:43 peace kernel: [    0.252015]   domain 1: span 0-1
May 18 03:03:43 peace kernel: [    0.252015]    groups: 0-1
May 18 03:03:43 peace kernel: [    0.252015] net_namespace: 660 bytes
May 18 03:03:43 peace kernel: [    0.252015] Booting paravirtualized 
kernel on bare hardware
May 18 03:03:43 peace kernel: [    0.252015] NET: Registered protocol 
family 16
May 18 03:03:43 peace kernel: [    0.252015] ACPI: bus type pci registered
May 18 03:03:43 peace kernel: [    0.252015] PCI: MCFG configuration 0: 
base e0000000 segment 0 buses 0 - 255
May 18 03:03:43 peace kernel: [    0.252015] PCI: Not using MMCONFIG.
May 18 03:03:43 peace kernel: [    0.252015] PCI: PCI BIOS revision 2.10 
entry at 0xf0031, last bus=4
May 18 03:03:43 peace kernel: [    0.252015] PCI: Using configuration 
type 1 for base access
May 18 03:03:43 peace kernel: [    0.252015] Setting up standard PCI 
resources
May 18 03:03:43 peace kernel: [    0.264016] ACPI: EC: Look up EC in DSDT
May 18 03:03:43 peace kernel: [    0.278631] ACPI: Interpreter enabled
May 18 03:03:43 peace kernel: [    0.278631] ACPI: (supports S0 S1 S3 S4 S5)
May 18 03:03:43 peace kernel: [    0.278631] ACPI: Using IOAPIC for 
interrupt routing
May 18 03:03:43 peace kernel: [    0.278631] PCI: MCFG configuration 0: 
base e0000000 segment 0 buses 0 - 255
May 18 03:03:43 peace kernel: [    0.285498] PCI: MCFG area at e0000000 
reserved in ACPI motherboard resources
May 18 03:03:43 peace kernel: [    0.285501] PCI: Using MMCONFIG for 
extended config space
May 18 03:03:43 peace kernel: [    0.295851] ACPI: PCI Root Bridge 
[PCI0] (0000:00)
May 18 03:03:43 peace kernel: [    0.295851] pci 0000:00:1f.0: quirk: 
region 0800-087f claimed by ICH6 ACPI/GPIO/TCO
May 18 03:03:43 peace kernel: [    0.295851] pci 0000:00:1f.0: quirk: 
region 0480-04bf claimed by ICH6 GPIO
May 18 03:03:43 peace kernel: [    0.296565] PCI: Transparent bridge - 
0000:00:1e.0
May 18 03:03:43 peace kernel: [    0.296601] ACPI: PCI Interrupt Routing 
Table [\_SB_.PCI0._PRT]
May 18 03:03:43 peace kernel: [    0.297692] ACPI: PCI Interrupt Routing 
Table [\_SB_.PCI0.P0P1._PRT]
May 18 03:03:43 peace kernel: [    0.297821] ACPI: PCI Interrupt Routing 
Table [\_SB_.PCI0.P0P3._PRT]
May 18 03:03:43 peace kernel: [    0.298047] ACPI: PCI Interrupt Routing 
Table [\_SB_.PCI0.P0P4._PRT]
May 18 03:03:43 peace kernel: [    0.298170] ACPI: PCI Interrupt Routing 
Table [\_SB_.PCI0.P0P5._PRT]
May 18 03:03:43 peace kernel: [    0.304642] ACPI: PCI Interrupt Link 
[LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
May 18 03:03:43 peace kernel: [    0.304642] ACPI: PCI Interrupt Link 
[LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
May 18 03:03:43 peace kernel: [    0.304642] ACPI: PCI Interrupt Link 
[LNKC] (IRQs *3 4 5 6 7 10 11 12 14 15)
May 18 03:03:43 peace kernel: [    0.304642] ACPI: PCI Interrupt Link 
[LNKD] (IRQs 3 4 5 6 7 *10 11 12 14 15)
May 18 03:03:43 peace kernel: [    0.304642] ACPI: PCI Interrupt Link 
[LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
May 18 03:03:43 peace kernel: [    0.304642] ACPI: PCI Interrupt Link 
[LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
May 18 03:03:43 peace kernel: [    0.304642] ACPI: PCI Interrupt Link 
[LNKG] (IRQs 3 4 *5 6 7 10 11 12 14 15)
May 18 03:03:43 peace kernel: [    0.304642] ACPI: PCI Interrupt Link 
[LNKH] (IRQs 3 4 *5 6 7 10 11 12 14 15)
May 18 03:03:43 peace kernel: [    0.304642] ACPI Warning 
(tbutils-0217): Incorrect checksum in table [OEMB] - F3, should be E6 
[20080321]
May 18 03:03:43 peace kernel: [    0.304642] Linux Plug and Play Support 
v0.97 (c) Adam Belay
May 18 03:03:43 peace kernel: [    0.304642] pnp: PnP ACPI init
May 18 03:03:43 peace kernel: [    0.304642] ACPI: bus type pnp registered
May 18 03:03:43 peace kernel: [    0.312643] pnp: PnP ACPI: found 16 devices
May 18 03:03:43 peace kernel: [    0.312643] ACPI: ACPI bus type pnp 
unregistered
May 18 03:03:43 peace kernel: [    0.312643] PnPBIOS: Disabled by ACPI PNP
May 18 03:03:43 peace kernel: [    0.312741] PCI: Using ACPI for IRQ routing
May 18 03:03:43 peace kernel: [    0.315874] ACPI: RTC can wake from S4
May 18 03:03:43 peace kernel: [    0.319826] system 00:01: iomem range 
0xfed13000-0xfed19fff has been reserved
May 18 03:03:43 peace kernel: [    0.319839] system 00:08: ioport range 
0x290-0x297 has been reserved
May 18 03:03:43 peace kernel: [    0.319847] system 00:09: ioport range 
0x4d0-0x4d1 has been reserved
May 18 03:03:43 peace kernel: [    0.319850] system 00:09: ioport range 
0x800-0x87f has been reserved
May 18 03:03:43 peace kernel: [    0.319853] system 00:09: ioport range 
0x400-0x41f has been reserved
May 18 03:03:43 peace kernel: [    0.319856] system 00:09: ioport range 
0x480-0x4bf has been reserved
May 18 03:03:43 peace kernel: [    0.319860] system 00:09: iomem range 
0xfed1c000-0xfed1ffff has been reserved
May 18 03:03:43 peace kernel: [    0.319863] system 00:09: iomem range 
0xfed20000-0xfed8ffff has been reserved
May 18 03:03:43 peace kernel: [    0.319867] system 00:09: iomem range 
0xffb00000-0xffbfffff could not be reserved
May 18 03:03:43 peace kernel: [    0.319870] system 00:09: iomem range 
0xfff80000-0xffffffff could not be reserved
May 18 03:03:43 peace kernel: [    0.319879] system 00:0b: iomem range 
0xfec00000-0xfec00fff has been reserved
May 18 03:03:43 peace kernel: [    0.319883] system 00:0b: iomem range 
0xfee00000-0xfee00fff has been reserved
May 18 03:03:43 peace kernel: [    0.319893] system 00:0d: iomem range 
0xe0000000-0xefffffff has been reserved
May 18 03:03:43 peace kernel: [    0.319901] system 00:0e: iomem range 
0xe0000000-0xefffffff has been reserved
May 18 03:03:43 peace kernel: [    0.319909] system 00:0f: iomem range 
0x0-0x9ffff could not be reserved
May 18 03:03:43 peace kernel: [    0.319913] system 00:0f: iomem range 
0xe0000-0xfffff could not be reserved
May 18 03:03:43 peace kernel: [    0.319916] system 00:0f: iomem range 
0x100000-0x3fffffff could not be reserved
May 18 03:03:43 peace kernel: [    0.349192] PCI: Bridge: 0000:00:01.0
May 18 03:03:43 peace kernel: [    0.349192]   IO window: e000-efff
May 18 03:03:43 peace kernel: [    0.349192]   MEM window: 
0xcdf00000-0xcfffffff
May 18 03:03:43 peace kernel: [    0.349192]   PREFETCH window: 
0x00000000d0000000-0x00000000dfffffff
May 18 03:03:43 peace kernel: [    0.349192] PCI: Bridge: 0000:00:1c.0
May 18 03:03:43 peace kernel: [    0.349192]   IO window: d000-dfff
May 18 03:03:43 peace kernel: [    0.349192]   MEM window: disabled.
May 18 03:03:43 peace kernel: [    0.349192]   PREFETCH window: disabled.
May 18 03:03:43 peace kernel: [    0.349192] PCI: Bridge: 0000:00:1c.1
May 18 03:03:43 peace kernel: [    0.349192]   IO window: c000-cfff
May 18 03:03:43 peace kernel: [    0.349192]   MEM window: 
0xcde00000-0xcdefffff
May 18 03:03:43 peace kernel: [    0.349192]   PREFETCH window: disabled.
May 18 03:03:43 peace kernel: [    0.349192] PCI: Bridge: 0000:00:1e.0
May 18 03:03:43 peace kernel: [    0.349192]   IO window: a000-bfff
May 18 03:03:43 peace kernel: [    0.349192]   MEM window: 
0xcdd00000-0xcddfffff
May 18 03:03:43 peace kernel: [    0.349192]   PREFETCH window: 
0x0000000050000000-0x00000000500fffff
May 18 03:03:43 peace kernel: [    0.349192] ACPI: PCI Interrupt 
0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 16
May 18 03:03:43 peace kernel: [    0.349192] PCI: Setting latency timer 
of device 0000:00:01.0 to 64
May 18 03:03:43 peace kernel: [    0.349192] ACPI: PCI Interrupt 
0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 16
May 18 03:03:43 peace kernel: [    0.349192] PCI: Setting latency timer 
of device 0000:00:1c.0 to 64
May 18 03:03:43 peace kernel: [    0.349192] ACPI: PCI Interrupt 
0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 17
May 18 03:03:43 peace kernel: [    0.349192] PCI: Setting latency timer 
of device 0000:00:1c.1 to 64
May 18 03:03:43 peace kernel: [    0.349192] PCI: Setting latency timer 
of device 0000:00:1e.0 to 64
May 18 03:03:43 peace kernel: [    0.349192] NET: Registered protocol 
family 2
May 18 03:03:43 peace kernel: [    0.358252] IP route cache hash table 
entries: 32768 (order: 5, 131072 bytes)
May 18 03:03:43 peace kernel: [    0.358555] TCP established hash table 
entries: 131072 (order: 8, 1048576 bytes)
May 18 03:03:43 peace kernel: [    0.359062] TCP bind hash table 
entries: 65536 (order: 7, 524288 bytes)
May 18 03:03:43 peace kernel: [    0.359339] TCP: Hash tables configured 
(established 131072 bind 65536)
May 18 03:03:43 peace kernel: [    0.359342] TCP reno registered
May 18 03:03:43 peace kernel: [    0.362270] NET: Registered protocol 
family 1
May 18 03:03:43 peace kernel: [    0.362407] checking if image is 
initramfs... it is
May 18 03:03:43 peace kernel: [    0.845962] Switched to high resolution 
mode on CPU 1
May 18 03:03:43 peace kernel: [    0.849216] Switched to high resolution 
mode on CPU 0
May 18 03:03:43 peace kernel: [    0.957725] Freeing initrd memory: 
7264k freed
May 18 03:03:43 peace kernel: [    0.957736] audit: initializing netlink 
socket (disabled)
May 18 03:03:43 peace kernel: [    0.957736] type=2000 
audit(1242605007.952:1): initialized
May 18 03:03:43 peace kernel: [    0.957736] highmem bounce pool size: 
64 pages
May 18 03:03:43 peace kernel: [    0.957736] Total HugeTLB memory 
allocated, 0
May 18 03:03:43 peace kernel: [    0.960631] VFS: Disk quotas dquot_6.5.1
May 18 03:03:43 peace kernel: [    0.960631] Dquot-cache hash table 
entries: 1024 (order 0, 4096 bytes)
May 18 03:03:43 peace kernel: [    0.960631] msgmni has been set to 1767
May 18 03:03:43 peace kernel: [    0.960631] Block layer SCSI generic 
(bsg) driver version 0.4 loaded (major 253)
May 18 03:03:43 peace kernel: [    0.960631] io scheduler noop registered
May 18 03:03:43 peace kernel: [    0.960631] io scheduler anticipatory 
registered
May 18 03:03:43 peace kernel: [    0.960631] io scheduler deadline 
registered
May 18 03:03:43 peace kernel: [    0.960631] io scheduler cfq registered 
(default)
May 18 03:03:43 peace kernel: [    0.960631] pci 0000:04:00.0: Boot 
video device
May 18 03:03:43 peace kernel: [    0.960631] PCI: Setting latency timer 
of device 0000:00:01.0 to 64
May 18 03:03:43 peace kernel: [    0.960631] assign_interrupt_mode Found 
MSI capability
May 18 03:03:43 peace kernel: [    0.960631] Allocate Port 
Service[0000:00:01.0:pcie00]
May 18 03:03:43 peace kernel: [    0.960631] Allocate Port 
Service[0000:00:01.0:pcie03]
May 18 03:03:43 peace kernel: [    0.960631] PCI: Setting latency timer 
of device 0000:00:1c.0 to 64
May 18 03:03:43 peace kernel: [    0.960631] assign_interrupt_mode Found 
MSI capability
May 18 03:03:43 peace kernel: [    0.960631] Allocate Port 
Service[0000:00:1c.0:pcie00]
May 18 03:03:43 peace kernel: [    0.960631] Allocate Port 
Service[0000:00:1c.0:pcie02]
May 18 03:03:43 peace kernel: [    0.960631] Allocate Port 
Service[0000:00:1c.0:pcie03]
May 18 03:03:43 peace kernel: [    0.960631] PCI: Setting latency timer 
of device 0000:00:1c.1 to 64
May 18 03:03:43 peace kernel: [    0.960631] assign_interrupt_mode Found 
MSI capability
May 18 03:03:43 peace kernel: [    0.960631] Allocate Port 
Service[0000:00:1c.1:pcie00]
May 18 03:03:43 peace kernel: [    0.960631] Allocate Port 
Service[0000:00:1c.1:pcie02]
May 18 03:03:43 peace kernel: [    0.960631] Allocate Port 
Service[0000:00:1c.1:pcie03]
May 18 03:03:43 peace kernel: [    0.960631] isapnp: Scanning for PnP 
cards...
May 18 03:03:43 peace kernel: [    1.312520] isapnp: No Plug & Play 
device found
May 18 03:03:43 peace kernel: [    1.319633] Serial: 8250/16550 driver 
$Revision: 1.90 $ 4 ports, IRQ sharing enabled
May 18 03:03:43 peace kernel: [    1.319633] serial8250: ttyS0 at I/O 
0x3f8 (irq = 4) is a 16550A
May 18 03:03:43 peace kernel: [    1.319633] 00:0c: ttyS0 at I/O 0x3f8 
(irq = 4) is a 16550A
May 18 03:03:43 peace kernel: [    1.323632] brd: module loaded
May 18 03:03:43 peace kernel: [    1.323632] PNP: PS/2 Controller 
[PNP0303:PS2K] at 0x60,0x64 irq 1
May 18 03:03:43 peace kernel: [    1.323632] PNP: PS/2 appears to have 
AUX port disabled, if this is incorrect please boot with i8042.nopnp
May 18 03:03:43 peace kernel: [    1.323632] serio: i8042 KBD port at 
0x60,0x64 irq 1
May 18 03:03:43 peace kernel: [    1.323632] mice: PS/2 mouse device 
common for all mice
May 18 03:03:43 peace kernel: [    1.323632] rtc_cmos 00:03: rtc core: 
registered rtc_cmos as rtc0
May 18 03:03:43 peace kernel: [    1.323632] rtc0: alarms up to one month
May 18 03:03:43 peace kernel: [    1.323632] cpuidle: using governor ladder
May 18 03:03:43 peace kernel: [    1.323632] cpuidle: using governor menu
May 18 03:03:43 peace kernel: [    1.323632] No iBFT detected.
May 18 03:03:43 peace kernel: [    1.323632] TCP cubic registered
May 18 03:03:43 peace kernel: [    1.323632] NET: Registered protocol 
family 17
May 18 03:03:43 peace kernel: [    1.323632] Using IPI No-Shortcut mode
May 18 03:03:43 peace kernel: [    1.327631] registered taskstats version 1
May 18 03:03:43 peace kernel: [    1.327631] rtc_cmos 00:03: setting 
system clock to 2009-05-18 00:03:28 UTC (1242605008)
May 18 03:03:43 peace kernel: [    1.327631] Freeing unused kernel 
memory: 244k freed
May 18 03:03:43 peace kernel: [    1.353488] input: AT Translated Set 2 
keyboard as /class/input/input0
May 18 03:03:43 peace kernel: [    1.432255] ACPI: ACPI0007:00 is 
registered as cooling_device0
May 18 03:03:43 peace kernel: [    1.432255] ACPI: Processor [CPU1] 
(supports 8 throttling states)
May 18 03:03:43 peace kernel: [    1.432255] ACPI: ACPI0007:01 is 
registered as cooling_device1
May 18 03:03:43 peace kernel: [    1.921714] usbcore: registered new 
interface driver usbfs
May 18 03:03:43 peace kernel: [    1.921722] usbcore: registered new 
interface driver hub
May 18 03:03:43 peace kernel: [    1.925421] usbcore: registered new 
device driver usb
May 18 03:03:43 peace kernel: [    1.925432] USB Universal Host 
Controller Interface driver v3.0
May 18 03:03:43 peace kernel: [    1.925432] ACPI: PCI Interrupt 
0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 23
May 18 03:03:43 peace kernel: [    1.925432] PCI: Setting latency timer 
of device 0000:00:1d.0 to 64
May 18 03:03:43 peace kernel: [    1.925432] uhci_hcd 0000:00:1d.0: UHCI 
Host Controller
May 18 03:03:43 peace kernel: [    1.925432] uhci_hcd 0000:00:1d.0: new 
USB bus registered, assigned bus number 1
May 18 03:03:43 peace kernel: [    1.925432] uhci_hcd 0000:00:1d.0: irq 
23, io base 0x00007000
May 18 03:03:43 peace kernel: [    1.925432] usb usb1: configuration #1 
chosen from 1 choice
May 18 03:03:43 peace kernel: [    1.925432] hub 1-0:1.0: USB hub found
May 18 03:03:43 peace kernel: [    1.925432] hub 1-0:1.0: 2 ports detected
May 18 03:03:43 peace kernel: [    2.034012] usb usb1: New USB device 
found, idVendor=1d6b, idProduct=0001
May 18 03:03:43 peace kernel: [    2.034018] usb usb1: New USB device 
strings: Mfr=3, Product=2, SerialNumber=1
May 18 03:03:43 peace kernel: [    2.034023] usb usb1: Product: UHCI 
Host Controller
May 18 03:03:43 peace kernel: [    2.034027] usb usb1: Manufacturer: 
Linux 2.6.26-2-686 uhci_hcd
May 18 03:03:43 peace kernel: [    2.034031] usb usb1: SerialNumber: 
0000:00:1d.0
May 18 03:03:43 peace kernel: [    2.034012] ACPI: PCI Interrupt 
0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
May 18 03:03:43 peace kernel: [    2.034028] PCI: Setting latency timer 
of device 0000:00:1d.1 to 64
May 18 03:03:43 peace kernel: [    2.034034] uhci_hcd 0000:00:1d.1: UHCI 
Host Controller
May 18 03:03:43 peace kernel: [    2.034079] uhci_hcd 0000:00:1d.1: new 
USB bus registered, assigned bus number 2
May 18 03:03:43 peace kernel: [    2.034115] uhci_hcd 0000:00:1d.1: irq 
19, io base 0x00007400
May 18 03:03:43 peace kernel: [    2.034243] usb usb2: configuration #1 
chosen from 1 choice
May 18 03:03:43 peace kernel: [    2.034293] hub 2-0:1.0: USB hub found
May 18 03:03:43 peace kernel: [    2.034303] hub 2-0:1.0: 2 ports detected
May 18 03:03:43 peace kernel: [    2.068239] Uniform Multi-Platform 
E-IDE driver
May 18 03:03:43 peace kernel: [    2.068248] ide: Assuming 33MHz system 
bus speed for PIO modes; override with idebus=xx
May 18 03:03:43 peace kernel: [    2.071549] No dock devices found.
May 18 03:03:43 peace kernel: [    2.115370] SCSI subsystem initialized
May 18 03:03:43 peace kernel: [    2.136019] usb usb2: New USB device 
found, idVendor=1d6b, idProduct=0001
May 18 03:03:43 peace kernel: [    2.136026] usb usb2: New USB device 
strings: Mfr=3, Product=2, SerialNumber=1
May 18 03:03:43 peace kernel: [    2.136031] usb usb2: Product: UHCI 
Host Controller
May 18 03:03:43 peace kernel: [    2.136036] usb usb2: Manufacturer: 
Linux 2.6.26-2-686 uhci_hcd
May 18 03:03:43 peace kernel: [    2.136041] usb usb2: SerialNumber: 
0000:00:1d.1
May 18 03:03:43 peace kernel: [    2.136146] ACPI: PCI Interrupt 
0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
May 18 03:03:43 peace kernel: [    2.136161] PCI: Setting latency timer 
of device 0000:00:1d.2 to 64
May 18 03:03:43 peace kernel: [    2.136167] uhci_hcd 0000:00:1d.2: UHCI 
Host Controller
May 18 03:03:43 peace kernel: [    2.136209] uhci_hcd 0000:00:1d.2: new 
USB bus registered, assigned bus number 3
May 18 03:03:43 peace kernel: [    2.136247] uhci_hcd 0000:00:1d.2: irq 
18, io base 0x00007800
May 18 03:03:43 peace kernel: [    2.136390] usb usb3: configuration #1 
chosen from 1 choice
May 18 03:03:43 peace kernel: [    2.136459] hub 3-0:1.0: USB hub found
May 18 03:03:43 peace kernel: [    2.136469] hub 3-0:1.0: 2 ports detected
May 18 03:03:43 peace kernel: [    2.193309] libata version 3.00 loaded.
May 18 03:03:43 peace kernel: [    2.195369] Floppy drive(s): fd0 is 1.44M
May 18 03:03:43 peace kernel: [    2.217303] FDC 0 is a post-1991 82077
May 18 03:03:43 peace kernel: [    2.248071] usb usb3: New USB device 
found, idVendor=1d6b, idProduct=0001
May 18 03:03:43 peace kernel: [    2.248071] usb usb3: New USB device 
strings: Mfr=3, Product=2, SerialNumber=1
May 18 03:03:43 peace kernel: [    2.248071] usb usb3: Product: UHCI 
Host Controller
May 18 03:03:43 peace kernel: [    2.248071] usb usb3: Manufacturer: 
Linux 2.6.26-2-686 uhci_hcd
May 18 03:03:43 peace kernel: [    2.248071] usb usb3: SerialNumber: 
0000:00:1d.2
May 18 03:03:43 peace kernel: [    2.248071] ACPI: PCI Interrupt 
0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 16
May 18 03:03:43 peace kernel: [    2.248071] PCI: Setting latency timer 
of device 0000:00:1d.3 to 64
May 18 03:03:43 peace kernel: [    2.248071] uhci_hcd 0000:00:1d.3: UHCI 
Host Controller
May 18 03:03:43 peace kernel: [    2.248071] uhci_hcd 0000:00:1d.3: new 
USB bus registered, assigned bus number 4
May 18 03:03:43 peace kernel: [    2.248071] uhci_hcd 0000:00:1d.3: irq 
16, io base 0x00008000
May 18 03:03:43 peace kernel: [    2.248071] usb usb4: configuration #1 
chosen from 1 choice
May 18 03:03:43 peace kernel: [    2.248071] hub 4-0:1.0: USB hub found
May 18 03:03:43 peace kernel: [    2.248071] hub 4-0:1.0: 2 ports detected
May 18 03:03:43 peace kernel: [    2.355066] usb usb4: New USB device 
found, idVendor=1d6b, idProduct=0001
May 18 03:03:43 peace kernel: [    2.355066] usb usb4: New USB device 
strings: Mfr=3, Product=2, SerialNumber=1
May 18 03:03:43 peace kernel: [    2.355066] usb usb4: Product: UHCI 
Host Controller
May 18 03:03:43 peace kernel: [    2.355066] usb usb4: Manufacturer: 
Linux 2.6.26-2-686 uhci_hcd
May 18 03:03:43 peace kernel: [    2.355066] usb usb4: SerialNumber: 
0000:00:1d.3
May 18 03:03:43 peace kernel: [    2.355066] ACPI: PCI Interrupt 
0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 23
May 18 03:03:43 peace kernel: [    2.355066] PCI: Setting latency timer 
of device 0000:00:1d.7 to 64
May 18 03:03:43 peace kernel: [    2.355066] ehci_hcd 0000:00:1d.7: EHCI 
Host Controller
May 18 03:03:43 peace kernel: [    2.355066] ehci_hcd 0000:00:1d.7: new 
USB bus registered, assigned bus number 5
May 18 03:03:43 peace kernel: [    2.356875] ehci_hcd 0000:00:1d.7: 
debug port 1
May 18 03:03:43 peace kernel: [    2.356886] PCI: cache line size of 128 
is not supported by device 0000:00:1d.7
May 18 03:03:43 peace kernel: [    2.356898] ehci_hcd 0000:00:1d.7: irq 
23, io mem 0xcdcff800
May 18 03:03:43 peace kernel: [    2.376030] ehci_hcd 0000:00:1d.7: USB 
2.0 started, EHCI 1.00, driver 10 Dec 2004
May 18 03:03:43 peace kernel: [    2.376171] usb usb5: configuration #1 
chosen from 1 choice
May 18 03:03:43 peace kernel: [    2.376232] hub 5-0:1.0: USB hub found
May 18 03:03:43 peace kernel: [    2.376244] hub 5-0:1.0: 8 ports detected
May 18 03:03:43 peace kernel: [    2.480137] usb usb5: New USB device 
found, idVendor=1d6b, idProduct=0002
May 18 03:03:43 peace kernel: [    2.480137] usb usb5: New USB device 
strings: Mfr=3, Product=2, SerialNumber=1
May 18 03:03:43 peace kernel: [    2.480137] usb usb5: Product: EHCI 
Host Controller
May 18 03:03:43 peace kernel: [    2.480137] usb usb5: Manufacturer: 
Linux 2.6.26-2-686 ehci_hcd
May 18 03:03:43 peace kernel: [    2.480137] usb usb5: SerialNumber: 
0000:00:1d.7
May 18 03:03:43 peace kernel: [    2.480136] ACPI: PCI Interrupt 
0000:02:00.0[A] -> GSI 17 (level, low) -> IRQ 17
May 18 03:03:43 peace kernel: [    2.480151] PCI: Setting latency timer 
of device 0000:02:00.0 to 64
May 18 03:03:43 peace kernel: [    2.480184] sky2 0000:02:00.0: v1.21 
addr 0xcdefc000 irq 17 Yukon-EC (0xb6) rev 1
May 18 03:03:43 peace kernel: [    2.480137] ICH6: IDE controller 
(0x8086:0x266f rev 0x03) at  PCI slot 0000:00:1f.1
May 18 03:03:43 peace kernel: [    2.480137] ACPI: PCI Interrupt 
0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
May 18 03:03:43 peace kernel: [    2.480137] ICH6: not 100% native mode: 
will probe irqs later
May 18 03:03:43 peace kernel: [    2.480137]     ide0: BM-DMA at 
0xffa0-0xffa7
May 18 03:03:43 peace kernel: [    2.480137]     ide1: BM-DMA at 
0xffa8-0xffaf
May 18 03:03:43 peace kernel: [    2.480137] Probing IDE interface ide0...
May 18 03:03:43 peace kernel: [    2.488405] sky2 eth0: addr 
00:11:2f:c9:bd:aa
May 18 03:03:43 peace kernel: [    2.948834] usb 3-1: new low speed USB 
device using uhci_hcd and address 2
May 18 03:03:43 peace kernel: [    3.056831] Probing IDE interface ide1...
May 18 03:03:43 peace kernel: [    3.183230] usb 3-1: configuration #1 
chosen from 1 choice
May 18 03:03:43 peace kernel: [    3.186431] usb 3-1: New USB device 
found, idVendor=045e, idProduct=0040
May 18 03:03:43 peace kernel: [    3.186438] usb 3-1: New USB device 
strings: Mfr=1, Product=3, SerialNumber=0
May 18 03:03:43 peace kernel: [    3.186442] usb 3-1: Product: Microsoft 
3-Button Mouse with IntelliEye(TM)
May 18 03:03:43 peace kernel: [    3.186446] usb 3-1: Manufacturer: 
Microsoft
May 18 03:03:43 peace kernel: [    3.221749] usbcore: registered new 
interface driver hiddev
May 18 03:03:43 peace kernel: [    3.237743] input: Microsoft Microsoft 
3-Button Mouse with IntelliEye(TM) as /class/input/input1
May 18 03:03:43 peace kernel: [    3.240292] input,hidraw0: USB HID 
v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on 
usb-0000:00:1d.2-1
May 18 03:03:43 peace kernel: [    3.240318] usbcore: registered new 
interface driver usbhid
May 18 03:03:43 peace kernel: [    3.240323] usbhid: v2.6:USB HID core 
driver
May 18 03:03:43 peace kernel: [    3.742902] ide0 at 0x1f0-0x1f7,0x3f6 
on irq 14
May 18 03:03:43 peace kernel: [    3.742961] ide1 at 0x170-0x177,0x376 
on irq 15
May 18 03:03:43 peace kernel: [    3.742961] IT8212: IDE controller 
(0x1283:0x8212 rev 0x13) at  PCI slot 0000:01:04.0
May 18 03:03:43 peace kernel: [    3.742961] ACPI: PCI Interrupt 
0000:01:04.0[A] -> GSI 23 (level, low) -> IRQ 23
May 18 03:03:43 peace kernel: [    3.742961] it821x: controller in pass 
through mode.
May 18 03:03:43 peace kernel: [    3.742961] IT8212: 100% native mode on 
irq 23
May 18 03:03:43 peace kernel: [    3.742961]     ide2: BM-DMA at 
0xa000-0xa007
May 18 03:03:43 peace kernel: [    3.742961]     ide3: BM-DMA at 
0xa008-0xa00f
May 18 03:03:43 peace kernel: [    3.742961] Probing IDE interface ide2...
May 18 03:03:43 peace kernel: [    3.902982] ahci 0000:00:1f.2: version 3.0
May 18 03:03:43 peace kernel: [    3.903001] ACPI: PCI Interrupt 
0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 19
May 18 03:03:43 peace kernel: [    4.478902] Probing IDE interface ide3...
May 18 03:03:43 peace kernel: [    4.923902] ahci 0000:00:1f.2: AHCI 
0001.0000 32 slots 4 ports 1.5 Gbps 0xf impl SATA mode
May 18 03:03:43 peace kernel: [    4.923907] ahci 0000:00:1f.2: flags: 
64bit ncq pm led slum part
May 18 03:03:43 peace kernel: [    4.923912] PCI: Setting latency timer 
of device 0000:00:1f.2 to 64
May 18 03:03:43 peace kernel: [    4.927861] scsi0 : ahci
May 18 03:03:43 peace kernel: [    4.927861] scsi1 : ahci
May 18 03:03:43 peace kernel: [    4.927861] scsi2 : ahci
May 18 03:03:43 peace kernel: [    4.927861] scsi3 : ahci
May 18 03:03:43 peace kernel: [    4.927861] ata1: SATA max UDMA/133 
abar m1024@0xcdcffc00 port 0xcdcffd00 irq 19
May 18 03:03:43 peace kernel: [    4.927861] ata2: SATA max UDMA/133 
abar m1024@0xcdcffc00 port 0xcdcffd80 irq 19
May 18 03:03:43 peace kernel: [    4.927861] ata3: SATA max UDMA/133 
abar m1024@0xcdcffc00 port 0xcdcffe00 irq 19
May 18 03:03:43 peace kernel: [    4.927861] ata4: SATA max UDMA/133 
abar m1024@0xcdcffc00 port 0xcdcffe80 irq 19
May 18 03:03:43 peace kernel: [    5.238081] hdg: HL-DT-ST DVDRAM 
GSA-4160B, ATAPI CD/DVD-ROM drive
May 18 03:03:43 peace kernel: [    5.268866] ata1: SATA link up 1.5 Gbps 
(SStatus 113 SControl 300)
May 18 03:03:43 peace kernel: [    5.268851] ata1.00: ATA-6: 
ST3160827AS, 3.42, max UDMA/133
May 18 03:03:43 peace kernel: [    5.268851] ata1.00: 312581808 sectors, 
multi 16: LBA48 NCQ (depth 31/32)
May 18 03:03:43 peace kernel: [    5.268851] ata1.00: configured for 
UDMA/133
May 18 03:03:43 peace kernel: [    5.584862] hdg: host max PIO4 wanted 
PIO255(auto-tune) selected PIO4
May 18 03:03:43 peace kernel: [    5.585663] hdg: UDMA/66 mode selected
May 18 03:03:43 peace kernel: [    5.589815] ide2 at 
0xb400-0xb407,0xb002 on irq 23
May 18 03:03:43 peace kernel: [    5.589815] ide3 at 
0xa800-0xa807,0xa402 on irq 23
May 18 03:03:43 peace kernel: [    5.610213] hdg: ATAPI 40X DVD-ROM 
DVD-R-RAM CD-R/RW drive, 2048kB Cache
May 18 03:03:43 peace kernel: [    5.610213] Uniform CD-ROM driver 
Revision: 3.20
May 18 03:03:43 peace kernel: [    5.621045] ata2: SATA link up 1.5 Gbps 
(SStatus 113 SControl 300)
May 18 03:03:43 peace kernel: [    5.621820] ata2.00: ATA-6: 
ST3160827AS, 3.42, max UDMA/133
May 18 03:03:43 peace kernel: [    5.621820] ata2.00: 312581808 sectors, 
multi 16: LBA48 NCQ (depth 31/32)
May 18 03:03:43 peace kernel: [    5.623094] ata2.00: configured for 
UDMA/133
May 18 03:03:43 peace kernel: [    5.957831] ata3: SATA link down 
(SStatus 0 SControl 300)
May 18 03:03:43 peace kernel: [    6.297684] ata4: SATA link down 
(SStatus 0 SControl 300)
May 18 03:03:43 peace kernel: [    6.449779] scsi 0:0:0:0: 
Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
May 18 03:03:43 peace kernel: [    6.449779] scsi 1:0:0:0: 
Direct-Access     ATA      ST3160827AS      3.42 PQ: 0 ANSI: 5
May 18 03:03:43 peace kernel: [    6.540531] ACPI: PCI Interrupt 
0000:01:0b.0[A] -> GSI 22 (level, low) -> IRQ 22
May 18 03:03:43 peace kernel: [    6.592315] ohci1394: fw-host0: 
OHCI-1394 1.1 (PCI): IRQ=[22]  MMIO=[cddff000-cddff7ff]  Max 
Packet=[2048]  IR/IT contexts=[4/4]
May 18 03:03:43 peace kernel: [    6.641502] Driver 'sd' needs updating 
- please use bus_type methods
May 18 03:03:43 peace kernel: [    6.643136] sd 0:0:0:0: [sda] 312581808 
512-byte hardware sectors (160042 MB)
May 18 03:03:43 peace kernel: [    6.643136] sd 0:0:0:0: [sda] Write 
Protect is off
May 18 03:03:43 peace kernel: [    6.643136] sd 0:0:0:0: [sda] Mode 
Sense: 00 3a 00 00
May 18 03:03:43 peace kernel: [    6.643136] sd 0:0:0:0: [sda] Write 
cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 18 03:03:43 peace kernel: [    6.643136] sd 0:0:0:0: [sda] 312581808 
512-byte hardware sectors (160042 MB)
May 18 03:03:43 peace kernel: [    6.643136] sd 0:0:0:0: [sda] Write 
Protect is off
May 18 03:03:43 peace kernel: [    6.643136] sd 0:0:0:0: [sda] Mode 
Sense: 00 3a 00 00
May 18 03:03:43 peace kernel: [    6.643136] sd 0:0:0:0: [sda] Write 
cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 18 03:03:43 peace kernel: [    6.643136]  sda: sda1 sda2 sda3
May 18 03:03:43 peace kernel: [    6.652837] sd 0:0:0:0: [sda] Attached 
SCSI disk
May 18 03:03:43 peace kernel: [    6.652837] sd 1:0:0:0: [sdb] 312581808 
512-byte hardware sectors (160042 MB)
May 18 03:03:43 peace kernel: [    6.652837] sd 1:0:0:0: [sdb] Write 
Protect is off
May 18 03:03:43 peace kernel: [    6.652837] sd 1:0:0:0: [sdb] Mode 
Sense: 00 3a 00 00
May 18 03:03:43 peace kernel: [    6.652837] sd 1:0:0:0: [sdb] Write 
cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 18 03:03:43 peace kernel: [    6.652837] sd 1:0:0:0: [sdb] 312581808 
512-byte hardware sectors (160042 MB)
May 18 03:03:43 peace kernel: [    6.652837] sd 1:0:0:0: [sdb] Write 
Protect is off
May 18 03:03:43 peace kernel: [    6.652837] sd 1:0:0:0: [sdb] Mode 
Sense: 00 3a 00 00
May 18 03:03:43 peace kernel: [    6.652837] sd 1:0:0:0: [sdb] Write 
cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 18 03:03:43 peace kernel: [    6.652837]  sdb: sdb1 sdb2 sdb3
May 18 03:03:43 peace kernel: [    6.657501] sd 1:0:0:0: [sdb] Attached 
SCSI disk
May 18 03:03:43 peace kernel: [    6.817732] md: raid1 personality 
registered for level 1
May 18 03:03:43 peace kernel: [    6.825880] md: md1 stopped.
May 18 03:03:43 peace kernel: [    6.833460] md: bind<sdb1>
May 18 03:03:43 peace kernel: [    6.833641] md: bind<sda1>
May 18 03:03:43 peace kernel: [    6.833665] md: kicking non-fresh sdb1 
from array!
May 18 03:03:43 peace kernel: [    6.833672] md: unbind<sdb1>
May 18 03:03:43 peace kernel: [    6.833679] md: export_rdev(sdb1)
May 18 03:03:43 peace kernel: [    6.845728] raid1: raid set md1 active 
with 1 out of 2 mirrors
May 18 03:03:43 peace kernel: [    6.853731] md: md2 stopped.
May 18 03:03:43 peace kernel: [    6.858669] md: bind<sdb2>
May 18 03:03:43 peace kernel: [    6.858824] md: bind<sda2>
May 18 03:03:43 peace kernel: [    6.858849] md: kicking non-fresh sdb2 
from array!
May 18 03:03:43 peace kernel: [    6.858856] md: unbind<sdb2>
May 18 03:03:43 peace kernel: [    6.858863] md: export_rdev(sdb2)
May 18 03:03:43 peace kernel: [    6.869729] raid1: raid set md2 active 
with 1 out of 2 mirrors
May 18 03:03:43 peace kernel: [    6.877731] md: md3 stopped.
May 18 03:03:43 peace kernel: [    6.883412] md: bind<sdb3>
May 18 03:03:43 peace kernel: [    6.883594] md: bind<sda3>
May 18 03:03:43 peace kernel: [    6.883619] md: kicking non-fresh sdb3 
from array!
May 18 03:03:43 peace kernel: [    6.883626] md: unbind<sdb3>
May 18 03:03:43 peace kernel: [    6.883632] md: export_rdev(sdb3)
May 18 03:03:43 peace kernel: [    6.896449] raid1: raid set md3 active 
with 1 out of 2 mirrors
May 18 03:03:43 peace kernel: [    7.022191] PM: Starting manual resume 
from disk
May 18 03:03:43 peace kernel: [    7.061240] kjournald starting.  Commit 
interval 5 seconds
May 18 03:03:43 peace kernel: [    7.064753] EXT3-fs: mounted filesystem 
with ordered data mode.
May 18 03:03:43 peace kernel: [    8.174984] ieee1394: Host added: 
ID:BUS[0-00:1023]  GUID[00004c01070022d0]
May 18 03:03:43 peace kernel: [    8.547436] udevd version 125 started
May 18 03:03:43 peace kernel: [    9.355978] Linux agpgart interface v0.103
May 18 03:03:43 peace kernel: [    9.582683] input: Power Button (FF) as 
/class/input/input2
May 18 03:03:43 peace kernel: [    9.627413] ACPI: Power Button (FF) [PWRF]
May 18 03:03:43 peace kernel: [    9.627564] input: Power Button (CM) as 
/class/input/input3
May 18 03:03:43 peace kernel: [    9.685368] ACPI: Power Button (CM) [PWRB]
May 18 03:03:43 peace kernel: [   10.676633] input: PC Speaker as 
/class/input/input4
May 18 03:03:43 peace kernel: [   10.712630] intel_rng: FWH not detected
May 18 03:03:43 peace kernel: [   10.781307] iTCO_wdt: Intel TCO 
WatchDog Timer Driver v1.03 (30-Apr-2008)
May 18 03:03:43 peace kernel: [   10.781307] iTCO_wdt: Found a ICH6 or 
ICH6R TCO device (Version=2, TCOBASE=0x0860)
May 18 03:03:43 peace kernel: [   10.781307] iTCO_wdt: initialized. 
heartbeat=30 sec (nowayout=0)
May 18 03:03:43 peace kernel: [   11.076972] parport_pc 00:07: reported 
by Plug and Play ACPI
May 18 03:03:43 peace kernel: [   11.076972] parport0: PC-style at 0x378 
(0x778), irq 7 [PCSPP,TRISTATE,EPP]
May 18 03:03:43 peace kernel: [   11.149217] ACPI: PCI Interrupt 
0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 19
May 18 03:03:43 peace kernel: [   11.620093] ACPI: PCI Interrupt 
0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 16
May 18 03:03:43 peace kernel: [   11.620102] hda_intel: position_fix set 
to 1 for device 1043:813d
May 18 03:03:43 peace kernel: [   11.620122] PCI: Setting latency timer 
of device 0000:00:1b.0 to 64
May 18 03:03:43 peace kernel: [   12.578523] Adding 1951736k swap on 
/dev/md1.  Priority:-1 extents:1 across:1951736k
May 18 03:03:43 peace kernel: [   13.043088] EXT3 FS on md2, internal 
journal
May 18 03:03:43 peace kernel: [   13.815178] loop: module loaded
May 18 03:03:43 peace kernel: [   14.717640] kjournald starting.  Commit 
interval 5 seconds
May 18 03:03:43 peace kernel: [   14.719667] EXT3 FS on md3, internal 
journal
May 18 03:03:43 peace kernel: [   14.719674] EXT3-fs: mounted filesystem 
with ordered data mode.
May 18 03:03:43 peace kernel: [   17.180486] sky2 eth0: enabling interface
May 18 03:03:43 peace rsyslogd: [origin software="rsyslogd" 
swVersion="3.18.6" x-pid="2308" x-info="http://www.rsyslog.com"] restart
May 18 03:03:43 peace dhclient: Listening on LPF/eth0/00:11:2f:c9:bd:aa
May 18 03:03:43 peace dhclient: Sending on   LPF/eth0/00:11:2f:c9:bd:aa
May 18 03:03:43 peace dhclient: Sending on   Socket/fallback
May 18 03:03:43 peace dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 
port 67 interval 6
May 18 03:03:44 peace kernel: [   18.835651] NET: Registered protocol 
family 10
May 18 03:03:44 peace kernel: [   18.835651] lo: Disabled Privacy Extensions
May 18 03:03:44 peace kernel: [   18.835651] ADDRCONF(NETDEV_UP): eth0: 
link is not ready
May 18 03:03:44 peace kernel: [   19.382161] sky2 eth0: Link is up at 
100 Mbps, full duplex, flow control rx
May 18 03:03:44 peace kernel: [   19.382161] ADDRCONF(NETDEV_CHANGE): 
eth0: link becomes ready
May 18 03:03:45 peace acpid: client connected from 2689[107:109]
May 18 03:03:47 peace mdadm[2714]: DegradedArray event detected on md 
device /dev/md3
May 18 03:03:47 peace mdadm[2714]: DegradedArray event detected on md 
device /dev/md2
May 18 03:03:47 peace mdadm[2714]: DegradedArray event detected on md 
device /dev/md1
May 18 03:03:48 peace /usr/sbin/cron[2778]: (CRON) INFO (pidfile fd = 3)
May 18 03:03:48 peace /usr/sbin/cron[2779]: (CRON) STARTUP (fork ok)
May 18 03:03:48 peace /usr/sbin/cron[2779]: (CRON) INFO (Running @reboot 
jobs)
May 18 03:03:49 peace dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 
port 67 interval 21
May 18 03:03:49 peace dhclient: DHCPOFFER from 192.168.42.1
May 18 03:03:49 peace dhclient: DHCPREQUEST on eth0 to 255.255.255.255 
port 67
May 18 03:03:49 peace acpid: client connected from 2750[0:0]
May 18 03:03:49 peace dhclient: DHCPACK from 192.168.42.1
May 18 03:03:49 peace dhclient: bound to 192.168.42.3 -- renewal in 
65223 seconds.
May 18 03:03:55 peace kernel: [   31.770520] eth0: no IPv6 routers present


Here is output of `smartctl -a /dev/sda`:
-----------------------------------------

smartctl version 5.38 [i686-pc-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.7 and 7200.7 Plus family
Device Model:     ST3160827AS
Serial Number:    5MT002V2
Firmware Version: 3.42
User Capacity:    160,041,885,696 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 2
Local Time is:    Mon May 18 03:43:47 2009 EEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)    Offline data collection activity
                    was completed without error.
                    Auto Offline Data Collection: Enabled.
Self-test execution status:      (   0)    The previous self-test 
routine completed
                    without error or no self-test has ever
                    been run.
Total time to complete Offline
data collection:          ( 430) seconds.
Offline data collection
capabilities:              (0x5b) SMART execute Offline immediate.
                    Auto Offline data collection on/off support.
                    Suspend Offline collection upon new
                    command.
                    Offline surface scan supported.
                    Self-test supported.
                    No Conveyance Self-test supported.
                    Selective Self-test supported.
SMART capabilities:            (0x0003)    Saves SMART data before entering
                    power-saving mode.
                    Supports SMART auto save timer.
Error logging capability:        (0x01)    Error logging supported.
                    No General Purpose Logging support.
Short self-test routine
recommended polling time:      (   1) minutes.
Extended self-test routine
recommended polling time:      (  94) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   063   045   006    Pre-fail  
Always       -       379299
  3 Spin_Up_Time            0x0003   096   096   000    Pre-fail  
Always       -       0
  4 Start_Stop_Count        0x0032   099   099   020    Old_age   
Always       -       1712
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  
Always       -       0
  7 Seek_Error_Rate         0x000f   088   060   030    Pre-fail  
Always       -       686205129
  9 Power_On_Hours          0x0032   081   081   000    Old_age   
Always       -       16869
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  
Always       -       0
 12 Power_Cycle_Count       0x0032   099   099   020    Old_age   
Always       -       1708
194 Temperature_Celsius     0x0022   044   052   000    Old_age   
Always       -       44 (0 11 0 0)
195 Hardware_ECC_Recovered  0x001a   063   045   000    Old_age   
Always       -       379299
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   
Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   
Always       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   
Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   
Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Completed without error       00%     
16712         -
# 2  Short offline       Interrupted (host reset)      80%     
16712         -
# 3  Extended offline    Completed without error       00%     
16706         -
# 4  Extended offline    Interrupted (host reset)      40%     
16704         -
# 5  Extended offline    Aborted by host               90%     
16677         -
# 6  Short offline       Completed without error       00%     
16676         -
# 7  Extended offline    Aborted by host               90%     
16676         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.


Here is `smartctl -a /dev/sdb`:
-------------------------------
smartctl version 5.38 [i686-pc-linux-gnu] Copyright (C) 2002-8 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF INFORMATION SECTION ===
Model Family:     Seagate Barracuda 7200.7 and 7200.7 Plus family
Device Model:     ST3160827AS
Serial Number:    5MT003RJ
Firmware Version: 3.42
User Capacity:    160,041,885,696 bytes
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   6
ATA Standard is:  ATA/ATAPI-6 T13 1410D revision 2
Local Time is:    Mon May 18 03:46:36 2009 EEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=== START OF READ SMART DATA SECTION ===
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x82)    Offline data collection activity
                    was completed without error.
                    Auto Offline Data Collection: Enabled.
Self-test execution status:      (  39)    The self-test routine was 
interrupted
                    by the host with a hard or soft reset.
Total time to complete Offline
data collection:          ( 430) seconds.
Offline data collection
capabilities:              (0x5b) SMART execute Offline immediate.
                    Auto Offline data collection on/off support.
                    Suspend Offline collection upon new
                    command.
                    Offline surface scan supported.
                    Self-test supported.
                    No Conveyance Self-test supported.
                    Selective Self-test supported.
SMART capabilities:            (0x0003)    Saves SMART data before entering
                    power-saving mode.
                    Supports SMART auto save timer.
Error logging capability:        (0x01)    Error logging supported.
                    No General Purpose Logging support.
Short self-test routine
recommended polling time:      (   1) minutes.
Extended self-test routine
recommended polling time:      (  94) minutes.

SMART Attributes Data Structure revision number: 10
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   065   045   006    Pre-fail  
Always       -       116622053
  3 Spin_Up_Time            0x0003   096   096   000    Pre-fail  
Always       -       0
  4 Start_Stop_Count        0x0032   099   099   020    Old_age   
Always       -       1711
  5 Reallocated_Sector_Ct   0x0033   100   100   036    Pre-fail  
Always       -       0
  7 Seek_Error_Rate         0x000f   088   060   030    Pre-fail  
Always       -       724007819
  9 Power_On_Hours          0x0032   081   081   000    Old_age   
Always       -       16870
 10 Spin_Retry_Count        0x0013   100   100   097    Pre-fail  
Always       -       0
 12 Power_Cycle_Count       0x0032   099   099   020    Old_age   
Always       -       1707
194 Temperature_Celsius     0x0022   046   050   000    Old_age   
Always       -       46 (0 11 0 0)
195 Hardware_ECC_Recovered  0x001a   065   045   000    Old_age   
Always       -       116622053
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   
Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   
Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   200   000    Old_age   
Always       -       0
200 Multi_Zone_Error_Rate   0x0000   100   253   000    Old_age   
Offline      -       0
202 TA_Increase_Count       0x0032   100   253   000    Old_age   
Always       -       0

SMART Error Log Version: 1
No Errors Logged

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  
LifeTime(hours)  LBA_of_first_error
# 1  Short offline       Interrupted (host reset)      70%     
16712         -
# 2  Short offline       Completed without error       00%     
16712         -
# 3  Extended offline    Completed without error       00%     
16706         -
# 4  Extended offline    Interrupted (host reset)      90%     
16703         -
# 5  Short offline       Completed without error       00%     
16703         -

SMART Selective self-test log data structure revision number 1
 SPAN  MIN_LBA  MAX_LBA  CURRENT_TEST_STATUS
    1        0        0  Not_testing
    2        0        0  Not_testing
    3        0        0  Not_testing
    4        0        0  Not_testing
    5        0        0  Not_testing
Selective self-test flags (0x0):
  After scanning selected spans, do NOT read-scan remainder of disk.
If Selective self-test is pending on power-up, resume after 0 minute delay.

