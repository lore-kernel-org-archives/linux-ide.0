From: Mike Hayward <hayward@loup.net>
Subject: Re: Regression: my systems can no longer boot from an ide hard drive
Date: Tue, 23 Mar 2010 18:46:57 -0600
Message-ID: <201003240046.o2O0kvHU010541@alien.loup.net>
References: <201003230801.o2N81UKg009750@alien.loup.net> <20100323091718.5a57b6e1.randy.dunlap@oracle.com> <4BA95AD1.2090906@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tenax.loup.net ([209.169.16.66]:50015 "EHLO tenax.loup.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780Ab0CXBBw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 Mar 2010 21:01:52 -0400
In-reply-to: <4BA95AD1.2090906@gmail.com> (message from Robert Hancock on Tue,
	23 Mar 2010 18:20:33 -0600)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hancockrwd@gmail.com
Cc: randy.dunlap@oracle.com, linux-ide@vger.kernel.org

 > Most likely the IDE drive isn't being detected properly, but we need 
 > more info on the hardware. Can you post the dmesg output from bootup 
 > with a working kernel? (If you can, the boot messages from the ones that 
 > fail to boot would be ideal. For the Fedora one, you can edit the kernel 
 > command line in grub and take the "quiet" off the end to see more of 
 > them on the screen, any ata output would be useful..)

Ok, here goes with a working ubuntu system.  Getting logs from failed
to boot systems is a challenge; none of the Fedora logs had anything
obvious to me at the tail but I couldn't review them all.  Systems are
production so I couldn't keep offline after weekend.

This is from literally the same exact installation process except to a
different drive.  The ide hard drive works just fine after booting
from sata.  Hopefully boot messages can help.  Any ideas why Ubuntu
didn't even bring up grub when pressing keys?  I am not so familiar
with it, but guessing boot loader wedged before kernel bootstrap.

- Mike

Mar 23 10:44:19 opt2 kernel: imklog 4.2.0, log source = /var/run/rsyslog/kmsg started.
Mar 23 10:44:19 opt2 rsyslogd: [origin software="rsyslogd" swVersion="4.2.0" x-pid="646" x-info="http://www.rsyslog.com"] (re)start
Mar 23 10:44:19 opt2 rsyslogd: rsyslogd's groupid changed to 103
Mar 23 10:44:20 opt2 rsyslogd: rsyslogd's userid changed to 101
Mar 23 10:44:19 opt2 rsyslogd-2039: Could no open output file '/dev/xconsole' [try http://www.rsyslog.com/e/2039 ]
Mar 23 10:44:20 opt2 kernel: [    0.000000] Initializing cgroup subsys cpuset
Mar 23 10:44:20 opt2 kernel: [    0.000000] Initializing cgroup subsys cpu
Mar 23 10:44:20 opt2 kernel: [    0.000000] Linux version 2.6.31-14-server (buildd@crested) (gcc version 4.4.1 (Ubuntu 4.4.1-4ubuntu8) ) #48-Ubuntu SMP Fri Oct 16 15:07:34 UTC 2009 (Ubuntu 2.6.31-14.48-server)
Mar 23 10:44:20 opt2 kernel: [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-2.6.31-14-server root=UUID=17f0eb6b-217b-440e-8289-6162ed85da7f ro quiet splash
Mar 23 10:44:20 opt2 kernel: [    0.000000] KERNEL supported cpus:
Mar 23 10:44:20 opt2 kernel: [    0.000000]   Intel GenuineIntel
Mar 23 10:44:20 opt2 kernel: [    0.000000]   AMD AuthenticAMD
Mar 23 10:44:20 opt2 kernel: [    0.000000]   Centaur CentaurHauls
Mar 23 10:44:20 opt2 kernel: [    0.000000] BIOS-provided physical RAM map:
Mar 23 10:44:20 opt2 kernel: [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Mar 23 10:44:20 opt2 kernel: [    0.000000] DMI 2.3 present.
Mar 23 10:44:20 opt2 kernel: [    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around it.
Mar 23 10:44:20 opt2 kernel: [    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
Mar 23 10:44:20 opt2 kernel: [    0.000000] last_pfn = 0x7fff0 max_arch_pfn = 0x400000000
Mar 23 10:44:20 opt2 kernel: [    0.000000] MTRR default type: uncachable
Mar 23 10:44:20 opt2 kernel: [    0.000000] MTRR fixed ranges enabled:
Mar 23 10:44:20 opt2 kernel: [    0.000000]   00000-9FFFF write-back
Mar 23 10:44:20 opt2 kernel: [    0.000000]   A0000-EFFFF uncachable
Mar 23 10:44:20 opt2 kernel: [    0.000000]   F0000-FFFFF write-protect
Mar 23 10:44:20 opt2 kernel: [    0.000000] MTRR variable ranges enabled:
Mar 23 10:44:20 opt2 kernel: [    0.000000]   0 base 0000000000 mask FF80000000 write-back
Mar 23 10:44:20 opt2 kernel: [    0.000000]   1 disabled
Mar 23 10:44:20 opt2 kernel: [    0.000000]   2 disabled
Mar 23 10:44:20 opt2 kernel: [    0.000000]   3 disabled
Mar 23 10:44:20 opt2 kernel: [    0.000000]   4 disabled
Mar 23 10:44:20 opt2 kernel: [    0.000000]   5 disabled
Mar 23 10:44:20 opt2 kernel: [    0.000000]   6 disabled
Mar 23 10:44:20 opt2 kernel: [    0.000000]   7 disabled
Mar 23 10:44:20 opt2 kernel: [    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
Mar 23 10:44:20 opt2 kernel: [    0.000000] Scanning 0 areas for low memory corruption
Mar 23 10:44:20 opt2 kernel: [    0.000000] modified physical RAM map:
Mar 23 10:44:20 opt2 kernel: [    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  modified: 0000000000010000 - 000000000009fc00 (usable)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  modified: 000000000009fc00 - 00000000000a0000 (reserved)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  modified: 00000000000e0000 - 0000000000100000 (reserved)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  modified: 0000000000100000 - 000000007fff0000 (usable)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  modified: 000000007fff0000 - 000000007ffff000 (ACPI data)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  modified: 000000007ffff000 - 0000000080000000 (ACPI NVS)
Mar 23 10:44:20 opt2 kernel: [    0.000000]  modified: 00000000ff7c0000 - 0000000100000000 (reserved)
Mar 23 10:44:20 opt2 kernel: [    0.000000] initial memory mapped : 0 - 20000000
Mar 23 10:44:20 opt2 kernel: [    0.000000] init_memory_mapping: 0000000000000000-000000007fff0000
Mar 23 10:44:20 opt2 kernel: [    0.000000] Using x86 segment limits to approximate NX protection
Mar 23 10:44:20 opt2 kernel: [    0.000000]  0000000000 - 007fe00000 page 2M
Mar 23 10:44:20 opt2 kernel: [    0.000000]  007fe00000 - 007fff0000 page 4k
Mar 23 10:44:20 opt2 kernel: [    0.000000] kernel direct mapping tables up to 7fff0000 @ 10000-14000
Mar 23 10:44:20 opt2 kernel: [    0.000000] RAMDISK: 37957000 - 37fefbb8
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: RSDP 00000000000f4620 00014 (v00 ACPIAM)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: RSDT 000000007fff0000 00034 (v01 A M I  OEMRSDT  10000304 MSFT 00000097)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: FACP 000000007fff0200 00081 (v02 A M I  OEMFACP  10000304 MSFT 00000097)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: DSDT 000000007fff0400 03086 (v01  0AAAA 0AAAA000 00000000 INTL 02002026)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: FACS 000000007ffff000 00040
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: APIC 000000007fff0380 00074 (v01 A M I  OEMAPIC  10000304 MSFT 00000097)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: OEMB 000000007ffff040 0005E (v01 A M I  OEMBIOS  10000304 MSFT 00000097)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: ASF! 000000007fff3490 00086 (v16 AMIASF AMDSTRET 00000001 INTL 02002026)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Mar 23 10:44:20 opt2 kernel: [    0.000000] Scanning NUMA topology in Northbridge 24
Mar 23 10:44:20 opt2 kernel: [    0.000000] Number of nodes 2
Mar 23 10:44:20 opt2 kernel: [    0.000000] Node 0 MemBase 0000000000000000 Limit 0000000040000000
Mar 23 10:44:20 opt2 kernel: [    0.000000] Node 1 MemBase 0000000040000000 Limit 000000007fff0000
Mar 23 10:44:20 opt2 kernel: [    0.000000] NUMA: Using 30 for the hash shift.
Mar 23 10:44:20 opt2 kernel: [    0.000000] Using node hash shift of 30
Mar 23 10:44:20 opt2 kernel: [    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Mar 23 10:44:20 opt2 kernel: [    0.000000] Bootmem setup node 0 0000000000000000-0000000040000000
Mar 23 10:44:20 opt2 kernel: [    0.000000]   NODE_DATA [0000000000012000 - 0000000000016fff]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   bootmap [0000000000017000 -  000000000001efff] pages 8
Mar 23 10:44:20 opt2 kernel: [    0.000000] (7 early reservations) ==> bootmem [0000000000 - 0040000000]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #2 [0001000000 - 00019e0ccc]    TEXT DATA BSS ==> [0001000000 - 00019e0ccc]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #3 [0037957000 - 0037fefbb8]          RAMDISK ==> [0037957000 - 0037fefbb8]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #4 [000009d400 - 0000100000]    BIOS reserved ==> [000009d400 - 0000100000]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #5 [00019e1000 - 00019e1280]              BRK ==> [00019e1000 - 00019e1280]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #6 [0000010000 - 0000012000]          PGTABLE ==> [0000010000 - 0000012000]
Mar 23 10:44:20 opt2 kernel: [    0.000000] Bootmem setup node 1 0000000040000000-000000007fff0000
Mar 23 10:44:20 opt2 kernel: [    0.000000]   NODE_DATA [0000000040000000 - 0000000040004fff]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   bootmap [0000000040005000 -  000000004000cfff] pages 8
Mar 23 10:44:20 opt2 kernel: [    0.000000] (7 early reservations) ==> bootmem [0040000000 - 007fff0000]
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #2 [0001000000 - 00019e0ccc]    TEXT DATA BSS
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #3 [0037957000 - 0037fefbb8]          RAMDISK
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #4 [000009d400 - 0000100000]    BIOS reserved
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #5 [00019e1000 - 00019e1280]              BRK
Mar 23 10:44:20 opt2 kernel: [    0.000000]   #6 [0000010000 - 0000012000]          PGTABLE
Mar 23 10:44:20 opt2 kernel: [    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
Mar 23 10:44:20 opt2 kernel: [    0.000000]  [ffffea0000000000-ffffea0000dfffff] PMD -> [ffff880001e00000-ffff880002bfffff] on node 0
Mar 23 10:44:20 opt2 kernel: [    0.000000]  [ffffea0000e00000-ffffea0001bfffff] PMD -> [ffff880040200000-ffff880040ffffff] on node 1
Mar 23 10:44:20 opt2 kernel: [    0.000000] Zone PFN ranges:
Mar 23 10:44:20 opt2 kernel: [    0.000000]   DMA      0x00000010 -> 0x00001000
Mar 23 10:44:20 opt2 kernel: [    0.000000]   DMA32    0x00001000 -> 0x00100000
Mar 23 10:44:20 opt2 kernel: [    0.000000]   Normal   0x00100000 -> 0x00100000
Mar 23 10:44:20 opt2 kernel: [    0.000000] Movable zone start PFN for each node
Mar 23 10:44:20 opt2 kernel: [    0.000000] early_node_map[3] active PFN ranges
Mar 23 10:44:20 opt2 kernel: [    0.000000]     0: 0x00000010 -> 0x0000009f
Mar 23 10:44:20 opt2 kernel: [    0.000000]     0: 0x00000100 -> 0x00040000
Mar 23 10:44:20 opt2 kernel: [    0.000000]     1: 0x00040000 -> 0x0007fff0
Mar 23 10:44:20 opt2 kernel: [    0.000000] On node 0 totalpages: 262031
Mar 23 10:44:20 opt2 kernel: [    0.000000]   DMA zone: 56 pages used for memmap
Mar 23 10:44:20 opt2 kernel: [    0.000000]   DMA zone: 103 pages reserved
Mar 23 10:44:20 opt2 kernel: [    0.000000]   DMA zone: 3824 pages, LIFO batch:0
Mar 23 10:44:20 opt2 kernel: [    0.000000]   DMA32 zone: 3528 pages used for memmap
Mar 23 10:44:20 opt2 kernel: [    0.000000]   DMA32 zone: 254520 pages, LIFO batch:31
Mar 23 10:44:20 opt2 kernel: [    0.000000] On node 1 totalpages: 262128
Mar 23 10:44:20 opt2 kernel: [    0.000000]   DMA32 zone: 3584 pages used for memmap
Mar 23 10:44:20 opt2 kernel: [    0.000000]   DMA32 zone: 258544 pages, LIFO batch:31
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: PM-Timer IO Port: 0x5008
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: Local APIC address 0xfee00000
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Mar 23 10:44:20 opt2 kernel: [    0.000000] IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: IOAPIC (id[0x03] address[0xfebff000] gsi_base[24])
Mar 23 10:44:20 opt2 kernel: [    0.000000] IOAPIC[1]: apic_id 3, version 17, address 0xfebff000, GSI 24-27
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: IOAPIC (id[0x04] address[0xfebfe000] gsi_base[28])
Mar 23 10:44:20 opt2 kernel: [    0.000000] IOAPIC[2]: apic_id 4, version 17, address 0xfebfe000, GSI 28-31
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: IRQ0 used by override.
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: IRQ2 used by override.
Mar 23 10:44:20 opt2 kernel: [    0.000000] ACPI: IRQ9 used by override.
Mar 23 10:44:20 opt2 kernel: [    0.000000] Using ACPI (MADT) for SMP configuration information
Mar 23 10:44:20 opt2 kernel: [    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
Mar 23 10:44:20 opt2 kernel: [    0.000000] nr_irqs_gsi: 32
Mar 23 10:44:20 opt2 kernel: [    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
Mar 23 10:44:20 opt2 kernel: [    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
Mar 23 10:44:20 opt2 kernel: [    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
Mar 23 10:44:20 opt2 kernel: [    0.000000] Allocating PCI resources starting at 80000000 (gap: 80000000:7f7c0000)
Mar 23 10:44:20 opt2 kernel: [    0.000000] NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:2
Mar 23 10:44:20 opt2 kernel: [    0.000000] PERCPU: Remapped at ffffc90000000000 with large pages, static data 90720 bytes
Mar 23 10:44:20 opt2 kernel: [    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 516888
Mar 23 10:44:20 opt2 kernel: [    0.000000] Policy zone: DMA32
Mar 23 10:44:20 opt2 kernel: [    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.31-14-server root=UUID=17f0eb6b-217b-440e-8289-6162ed85da7f ro quiet splash
Mar 23 10:44:20 opt2 kernel: [    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
Mar 23 10:44:20 opt2 kernel: [    0.000000] Initializing CPU#0
Mar 23 10:44:20 opt2 kernel: [    0.000000] Checking aperture...
Mar 23 10:44:20 opt2 kernel: [    0.000000] No AGP bridge found
Mar 23 10:44:20 opt2 kernel: [    0.000000] Node 0: aperture @ 7b5e000000 size 32 MB
Mar 23 10:44:20 opt2 kernel: [    0.000000] Aperture beyond 4GB. Ignoring.
Mar 23 10:44:20 opt2 kernel: [    0.000000] Memory: 2050640k/2097088k available (5303k kernel code, 452k absent, 45996k reserved, 3013k data, 660k init)
Mar 23 10:44:20 opt2 kernel: [    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=2
Mar 23 10:44:20 opt2 kernel: [    0.000000] NR_IRQS:4352 nr_irqs:512
Mar 23 10:44:20 opt2 kernel: [    0.000000] Fast TSC calibration using PIT
Mar 23 10:44:20 opt2 kernel: [    0.000000] Detected 1394.256 MHz processor.
Mar 23 10:44:20 opt2 kernel: [    0.000016] spurious 8259A interrupt: IRQ7.
Mar 23 10:44:20 opt2 kernel: [    0.003059] Console: colour VGA+ 80x25
Mar 23 10:44:20 opt2 kernel: [    0.003063] console [tty0] enabled
Mar 23 10:44:20 opt2 kernel: [    0.010000] allocated 20971520 bytes of page_cgroup
Mar 23 10:44:20 opt2 kernel: [    0.010000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
Mar 23 10:44:20 opt2 kernel: [    0.010011] Calibrating delay loop (skipped), value calculated using timer frequency.. 2788.51 BogoMIPS (lpj=13942560)
Mar 23 10:44:20 opt2 kernel: [    0.010065] Security Framework initialized
Mar 23 10:44:20 opt2 kernel: [    0.010104] AppArmor: AppArmor initialized
Mar 23 10:44:20 opt2 kernel: [    0.010416] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Mar 23 10:44:20 opt2 kernel: [    0.013040] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Mar 23 10:44:20 opt2 kernel: [    0.014084] Mount-cache hash table entries: 256
Mar 23 10:44:20 opt2 kernel: [    0.014326] Initializing cgroup subsys ns
Mar 23 10:44:20 opt2 kernel: [    0.014332] Initializing cgroup subsys cpuacct
Mar 23 10:44:20 opt2 kernel: [    0.014339] Initializing cgroup subsys memory
Mar 23 10:44:20 opt2 kernel: [    0.014357] Initializing cgroup subsys freezer
Mar 23 10:44:20 opt2 kernel: [    0.014360] Initializing cgroup subsys net_cls
Mar 23 10:44:20 opt2 kernel: [    0.014388] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Mar 23 10:44:20 opt2 kernel: [    0.014392] CPU: L2 Cache: 1024K (64 bytes/line)
Mar 23 10:44:20 opt2 kernel: [    0.014397] CPU 0/0x0 -> Node 0
Mar 23 10:44:20 opt2 kernel: [    0.014400] tseg: 0000000000
Mar 23 10:44:20 opt2 kernel: [    0.014427] mce: CPU supports 5 MCE banks
Mar 23 10:44:20 opt2 kernel: [    0.014444] Performance Counters: AMD PMU driver.
Mar 23 10:44:20 opt2 kernel: [    0.014451] ... version:                 0
Mar 23 10:44:20 opt2 kernel: [    0.014453] ... bit width:               48
Mar 23 10:44:20 opt2 kernel: [    0.014456] ... generic counters:        4
Mar 23 10:44:20 opt2 kernel: [    0.014458] ... value mask:              0000ffffffffffff
Mar 23 10:44:20 opt2 kernel: [    0.014461] ... max period:              00007fffffffffff
Mar 23 10:44:20 opt2 kernel: [    0.014463] ... fixed-purpose counters:  0
Mar 23 10:44:20 opt2 kernel: [    0.014466] ... counter mask:            000000000000000f
Mar 23 10:44:20 opt2 kernel: [    0.017015] ACPI: Core revision 20090521
Mar 23 10:44:20 opt2 kernel: [    0.025477] Setting APIC routing to flat
Mar 23 10:44:20 opt2 kernel: [    0.025812] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=0 pin2=0
Mar 23 10:44:20 opt2 kernel: [    0.126106] CPU0: AMD Opteron(tm) Processor 240 stepping 01
Mar 23 10:44:20 opt2 kernel: [    0.130000] Booting processor 1 APIC 0x1 ip 0x6000
Mar 23 10:44:20 opt2 kernel: [    0.010000] Initializing CPU#1
Mar 23 10:44:20 opt2 kernel: [    0.010000] Calibrating delay using timer specific routine.. 2788.28 BogoMIPS (lpj=13941417)
Mar 23 10:44:20 opt2 kernel: [    0.010000] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Mar 23 10:44:20 opt2 kernel: [    0.010000] CPU: L2 Cache: 1024K (64 bytes/line)
Mar 23 10:44:20 opt2 kernel: [    0.010000] CPU 1/0x1 -> Node 1
Mar 23 10:44:20 opt2 kernel: [    0.010000] mce: CPU supports 5 MCE banks
Mar 23 10:44:20 opt2 kernel: [    0.010000] x86 PAT enabled: cpu 1, old 0x7040600070406, new 0x7010600070106
Mar 23 10:44:20 opt2 kernel: [    0.280837] CPU1: AMD Opteron(tm) Processor 240 stepping 01
Mar 23 10:44:20 opt2 kernel: [    0.280857] Brought up 2 CPUs
Mar 23 10:44:20 opt2 kernel: [    0.280860] Total of 2 processors activated (5576.79 BogoMIPS).
Mar 23 10:44:20 opt2 kernel: [    0.280943] CPU0 attaching sched-domain:
Mar 23 10:44:20 opt2 kernel: [    0.280948]  domain 0: span 0-1 level NODE
Mar 23 10:44:20 opt2 kernel: [    0.280952]   groups: 0 1
Mar 23 10:44:20 opt2 kernel: [    0.280961] CPU1 attaching sched-domain:
Mar 23 10:44:20 opt2 kernel: [    0.280964]  domain 0: span 0-1 level NODE
Mar 23 10:44:20 opt2 kernel: [    0.280967]   groups: 1 0
Mar 23 10:44:20 opt2 kernel: [    0.281079] Booting paravirtualized kernel on bare hardware
Mar 23 10:44:20 opt2 kernel: [    0.281079] regulator: core version 0.5
Mar 23 10:44:20 opt2 kernel: [    0.281079] Time: 16:43:59  Date: 03/23/10
Mar 23 10:44:20 opt2 kernel: [    0.281079] NET: Registered protocol family 16
Mar 23 10:44:20 opt2 kernel: [    0.281079] node 0 link 0: io port [0, ffffff]
Mar 23 10:44:20 opt2 kernel: [    0.281079] TOM: 0000000080000000 aka 2048M
Mar 23 10:44:20 opt2 kernel: [    0.281079] node 0 link 0: mmio [a0000, bffff]
Mar 23 10:44:20 opt2 kernel: [    0.281079] node 0 link 0: mmio [80000000, ffffffff]
Mar 23 10:44:20 opt2 kernel: [    0.281079] bus: [00,ff] on node 0 link 0
Mar 23 10:44:20 opt2 kernel: [    0.281079] bus: 00 index 0 io port: [0, ffff]
Mar 23 10:44:20 opt2 kernel: [    0.281079] bus: 00 index 1 mmio: [a0000, bffff]
Mar 23 10:44:20 opt2 kernel: [    0.281079] bus: 00 index 2 mmio: [80000000, fcffffffff]
Mar 23 10:44:20 opt2 kernel: [    0.281079] ACPI: bus type pci registered
Mar 23 10:44:20 opt2 kernel: [    0.281079] PCI: Using configuration type 1 for base access
Mar 23 10:44:20 opt2 kernel: [    0.281810] bio: create slab <bio-0> at 0
Mar 23 10:44:20 opt2 kernel: [    0.281810] ACPI: EC: Look up EC in DSDT
Mar 23 10:44:20 opt2 kernel: [    0.299084] ACPI: Interpreter enabled
Mar 23 10:44:20 opt2 kernel: [    0.299089] ACPI: (supports S0 S1 S4 S5)
Mar 23 10:44:20 opt2 kernel: [    0.299121] ACPI: Using IOAPIC for interrupt routing
Mar 23 10:44:20 opt2 kernel: [    0.308529] ACPI: No dock devices found.
Mar 23 10:44:20 opt2 kernel: [    0.308699] ACPI: PCI Root Bridge [PCI0] (0000:00)
Mar 23 10:44:20 opt2 kernel: [    0.308903] pci 0000:00:07.1: reg 20 io port: [0xffa0-0xffaf]
Mar 23 10:44:20 opt2 kernel: [    0.308938] pci 0000:00:07.2: reg 10 io port: [0xcc00-0xcc1f]
Mar 23 10:44:20 opt2 kernel: [    0.309094] pci 0000:00:0a.1: reg 10 64bit mmio: [0xfebff000-0xfebfffff]
Mar 23 10:44:20 opt2 kernel: [    0.309169] pci 0000:00:0b.1: reg 10 64bit mmio: [0xfebfe000-0xfebfefff]
Mar 23 10:44:20 opt2 kernel: [    0.309393] pci 0000:03:00.0: reg 10 32bit mmio: [0xfeafc000-0xfeafcfff]
Mar 23 10:44:20 opt2 kernel: [    0.309453] pci 0000:03:00.1: reg 10 32bit mmio: [0xfeafd000-0xfeafdfff]
Mar 23 10:44:20 opt2 kernel: [    0.309538] pci 0000:03:05.0: reg 10 io port: [0xac00-0xac07]
Mar 23 10:44:20 opt2 kernel: [    0.309546] pci 0000:03:05.0: reg 14 io port: [0xa480-0xa483]
Mar 23 10:44:20 opt2 kernel: [    0.309555] pci 0000:03:05.0: reg 18 io port: [0xa400-0xa407]
Mar 23 10:44:20 opt2 kernel: [    0.309564] pci 0000:03:05.0: reg 1c io port: [0xa080-0xa083]
Mar 23 10:44:20 opt2 kernel: [    0.309573] pci 0000:03:05.0: reg 20 io port: [0xa000-0xa00f]
Mar 23 10:44:20 opt2 kernel: [    0.309582] pci 0000:03:05.0: reg 24 32bit mmio: [0xfeafec00-0xfeafefff]
Mar 23 10:44:20 opt2 kernel: [    0.309591] pci 0000:03:05.0: reg 30 32bit mmio: [0xfea00000-0xfea7ffff]
Mar 23 10:44:20 opt2 kernel: [    0.309613] pci 0000:03:05.0: supports D1 D2
Mar 23 10:44:20 opt2 kernel: [    0.309654] pci 0000:03:06.0: reg 10 32bit mmio: [0xfd000000-0xfdffffff]
Mar 23 10:44:20 opt2 kernel: [    0.309664] pci 0000:03:06.0: reg 14 io port: [0xa800-0xa8ff]
Mar 23 10:44:20 opt2 kernel: [    0.309673] pci 0000:03:06.0: reg 18 32bit mmio: [0xfeaff000-0xfeafffff]
Mar 23 10:44:20 opt2 kernel: [    0.309699] pci 0000:03:06.0: reg 30 32bit mmio: [0xfeac0000-0xfeadffff]
Mar 23 10:44:20 opt2 kernel: [    0.309722] pci 0000:03:06.0: supports D1 D2
Mar 23 10:44:20 opt2 kernel: [    0.309762] pci 0000:03:08.0: reg 10 32bit mmio: [0xfeafb000-0xfeafbfff]
Mar 23 10:44:20 opt2 kernel: [    0.309771] pci 0000:03:08.0: reg 14 io port: [0x9c00-0x9c3f]
Mar 23 10:44:20 opt2 kernel: [    0.309780] pci 0000:03:08.0: reg 18 32bit mmio: [0xfea80000-0xfea9ffff]
Mar 23 10:44:20 opt2 kernel: [    0.309821] pci 0000:03:08.0: supports D1 D2
Mar 23 10:44:20 opt2 kernel: [    0.309824] pci 0000:03:08.0: PME# supported from D0 D1 D2 D3hot D3cold
Mar 23 10:44:20 opt2 kernel: [    0.309831] pci 0000:03:08.0: PME# disabled
Mar 23 10:44:20 opt2 kernel: [    0.309874] pci 0000:00:06.0: bridge io port: [0x9000-0xafff]
Mar 23 10:44:20 opt2 kernel: [    0.309880] pci 0000:00:06.0: bridge 32bit mmio: [0xfc900000-0xfeafffff]
Mar 23 10:44:20 opt2 kernel: [    0.309886] pci 0000:00:06.0: bridge 32bit mmio pref: [0xff500000-0xff5fffff]
Mar 23 10:44:20 opt2 kernel: [    0.309915] pci 0000:02:02.0: reg 10 io port: [0x8c00-0x8c7f]
Mar 23 10:44:20 opt2 kernel: [    0.309924] pci 0000:02:02.0: reg 18 io port: [0x8800-0x88ff]
Mar 23 10:44:20 opt2 kernel: [    0.309930] pci 0000:02:02.0: reg 1c 32bit mmio: [0xfc8ff000-0xfc8fffff]
Mar 23 10:44:20 opt2 kernel: [    0.309937] pci 0000:02:02.0: reg 20 32bit mmio: [0xfc8c0000-0xfc8dffff]
Mar 23 10:44:20 opt2 kernel: [    0.309946] pci 0000:02:02.0: reg 30 32bit mmio: [0xfc8f0000-0xfc8f7fff]
Mar 23 10:44:20 opt2 kernel: [    0.309959] pci 0000:02:02.0: supports D1
Mar 23 10:44:20 opt2 kernel: [    0.310011] pci 0000:02:09.0: reg 10 64bit mmio: [0xfc890000-0xfc89ffff]
Mar 23 10:44:20 opt2 kernel: [    0.310021] pci 0000:02:09.0: reg 18 64bit mmio: [0xfc880000-0xfc88ffff]
Mar 23 10:44:20 opt2 kernel: [    0.310033] pci 0000:02:09.0: reg 30 32bit mmio: [0xfc870000-0xfc87ffff]
Mar 23 10:44:20 opt2 kernel: [    0.310052] pci 0000:02:09.0: PME# supported from D3hot D3cold
Mar 23 10:44:20 opt2 kernel: [    0.310057] pci 0000:02:09.0: PME# disabled
Mar 23 10:44:20 opt2 kernel: [    0.310094] pci 0000:02:09.1: reg 10 64bit mmio: [0xfc8e0000-0xfc8effff]
Mar 23 10:44:20 opt2 kernel: [    0.310104] pci 0000:02:09.1: reg 18 64bit mmio: [0xfc8b0000-0xfc8bffff]
Mar 23 10:44:20 opt2 kernel: [    0.310116] pci 0000:02:09.1: reg 30 32bit mmio: [0xfc8a0000-0xfc8affff]
Mar 23 10:44:20 opt2 kernel: [    0.310135] pci 0000:02:09.1: PME# supported from D3hot D3cold
Mar 23 10:44:20 opt2 kernel: [    0.310140] pci 0000:02:09.1: PME# disabled
Mar 23 10:44:20 opt2 kernel: [    0.310172] pci 0000:00:0a.0: bridge io port: [0x8000-0x8fff]
Mar 23 10:44:20 opt2 kernel: [    0.310177] pci 0000:00:0a.0: bridge 32bit mmio: [0xfc700000-0xfc8fffff]
Mar 23 10:44:20 opt2 kernel: [    0.310183] pci 0000:00:0a.0: bridge 64bit mmio pref: [0xff400000-0xff4fffff]
Mar 23 10:44:20 opt2 kernel: [    0.310212] pci 0000:01:03.0: reg 10 io port: [0x7c00-0x7c7f]
Mar 23 10:44:20 opt2 kernel: [    0.310221] pci 0000:01:03.0: reg 18 io port: [0x7800-0x78ff]
Mar 23 10:44:20 opt2 kernel: [    0.310227] pci 0000:01:03.0: reg 1c 32bit mmio: [0xfc6ff000-0xfc6fffff]
Mar 23 10:44:20 opt2 kernel: [    0.310234] pci 0000:01:03.0: reg 20 32bit mmio: [0xfc6c0000-0xfc6dffff]
Mar 23 10:44:20 opt2 kernel: [    0.310243] pci 0000:01:03.0: reg 30 32bit mmio: [0xfc6f0000-0xfc6f7fff]
Mar 23 10:44:20 opt2 kernel: [    0.310256] pci 0000:01:03.0: supports D1
Mar 23 10:44:20 opt2 kernel: [    0.310286] pci 0000:00:0b.0: bridge io port: [0x7000-0x7fff]
Mar 23 10:44:20 opt2 kernel: [    0.310291] pci 0000:00:0b.0: bridge 32bit mmio: [0xfc600000-0xfc6fffff]
Mar 23 10:44:20 opt2 kernel: [    0.310297] pci 0000:00:0b.0: bridge 64bit mmio pref: [0xff300000-0xff3fffff]
Mar 23 10:44:20 opt2 kernel: [    0.310315] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Mar 23 10:44:20 opt2 kernel: [    0.310396] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Mar 23 10:44:20 opt2 kernel: [    0.310515] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
Mar 23 10:44:20 opt2 kernel: [    0.310655] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
Mar 23 10:44:20 opt2 kernel: [    0.313823] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Mar 23 10:44:20 opt2 kernel: [    0.313976] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Mar 23 10:44:20 opt2 kernel: [    0.314126] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Mar 23 10:44:20 opt2 kernel: [    0.314276] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Mar 23 10:44:20 opt2 kernel: [    0.314524] SCSI subsystem initialized
Mar 23 10:44:20 opt2 kernel: [    0.314562] libata version 3.00 loaded.
Mar 23 10:44:20 opt2 kernel: [    0.314562] usbcore: registered new interface driver usbfs
Mar 23 10:44:20 opt2 kernel: [    0.314562] usbcore: registered new interface driver hub
Mar 23 10:44:20 opt2 kernel: [    0.314562] usbcore: registered new device driver usb
Mar 23 10:44:20 opt2 kernel: [    0.314562] ACPI: WMI: Mapper loaded
Mar 23 10:44:20 opt2 kernel: [    0.314562] PCI: Using ACPI for IRQ routing
Mar 23 10:44:20 opt2 kernel: [    0.340012] Bluetooth: Core ver 2.15
Mar 23 10:44:20 opt2 kernel: [    0.340040] NET: Registered protocol family 31
Mar 23 10:44:20 opt2 kernel: [    0.340040] Bluetooth: HCI device and connection manager initialized
Mar 23 10:44:20 opt2 kernel: [    0.340040] Bluetooth: HCI socket layer initialized
Mar 23 10:44:20 opt2 kernel: [    0.340040] NetLabel: Initializing
Mar 23 10:44:20 opt2 kernel: [    0.340040] NetLabel:  domain hash size = 128
Mar 23 10:44:20 opt2 kernel: [    0.340040] NetLabel:  protocols = UNLABELED CIPSOv4
Mar 23 10:44:20 opt2 kernel: [    0.340058] NetLabel:  unlabeled traffic allowed by default
Mar 23 10:44:20 opt2 kernel: [    0.370022] pnp: PnP ACPI init
Mar 23 10:44:20 opt2 kernel: [    0.370048] ACPI: bus type pnp registered
Mar 23 10:44:20 opt2 kernel: [    0.376168] pnp: PnP ACPI: found 14 devices
Mar 23 10:44:20 opt2 kernel: [    0.376171] ACPI: ACPI bus type pnp unregistered
Mar 23 10:44:20 opt2 kernel: [    0.376191] system 00:09: ioport range 0x680-0x6ff has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376195] system 00:09: ioport range 0x295-0x296 has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376200] system 00:09: ioport range 0x778-0x77f has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376204] system 00:09: ioport range 0xb78-0xb7f has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376208] system 00:09: ioport range 0xf78-0xf7f has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376217] system 00:0a: ioport range 0x4d0-0x4d1 has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376222] system 00:0a: ioport range 0x5000-0x50bf has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376227] system 00:0a: ioport range 0x50e0-0x50ff has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376231] system 00:0a: ioport range 0x50c0-0x50df has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376236] system 00:0a: ioport range 0xde00-0xde7f has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376241] system 00:0a: ioport range 0xde80-0xdeff has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376250] system 00:0c: iomem range 0xfec00000-0xfec00fff could not be reserved
Mar 23 10:44:20 opt2 kernel: [    0.376255] system 00:0c: iomem range 0xfee00000-0xfee00fff has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376260] system 00:0c: iomem range 0xfff80000-0xffffffff has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376268] system 00:0d: iomem range 0x0-0x9ffff could not be reserved
Mar 23 10:44:20 opt2 kernel: [    0.376273] system 00:0d: iomem range 0xc0000-0xdffff has been reserved
Mar 23 10:44:20 opt2 kernel: [    0.376278] system 00:0d: iomem range 0xe0000-0xfffff could not be reserved
Mar 23 10:44:20 opt2 kernel: [    0.376283] system 00:0d: iomem range 0x100000-0x7fffffff could not be reserved
Mar 23 10:44:20 opt2 kernel: [    0.381046] AppArmor: AppArmor Filesystem Enabled
Mar 23 10:44:20 opt2 kernel: [    0.381100] pci 0000:00:06.0: PCI bridge, secondary bus 0000:03
Mar 23 10:44:20 opt2 kernel: [    0.381105] pci 0000:00:06.0:   IO window: 0x9000-0xafff
Mar 23 10:44:20 opt2 kernel: [    0.381112] pci 0000:00:06.0:   MEM window: 0xfc900000-0xfeafffff
Mar 23 10:44:20 opt2 kernel: [    0.381119] pci 0000:00:06.0:   PREFETCH window: 0xff500000-0xff5fffff
Mar 23 10:44:20 opt2 kernel: [    0.381125] pci 0000:00:0a.0: PCI bridge, secondary bus 0000:02
Mar 23 10:44:20 opt2 kernel: [    0.381129] pci 0000:00:0a.0:   IO window: 0x8000-0x8fff
Mar 23 10:44:20 opt2 kernel: [    0.381135] pci 0000:00:0a.0:   MEM window: 0xfc700000-0xfc8fffff
Mar 23 10:44:20 opt2 kernel: [    0.381140] pci 0000:00:0a.0:   PREFETCH window: 0x000000ff400000-0x000000ff4fffff
Mar 23 10:44:20 opt2 kernel: [    0.381146] pci 0000:00:0b.0: PCI bridge, secondary bus 0000:01
Mar 23 10:44:20 opt2 kernel: [    0.381150] pci 0000:00:0b.0:   IO window: 0x7000-0x7fff
Mar 23 10:44:20 opt2 kernel: [    0.381155] pci 0000:00:0b.0:   MEM window: 0xfc600000-0xfc6fffff
Mar 23 10:44:20 opt2 kernel: [    0.381160] pci 0000:00:0b.0:   PREFETCH window: 0x000000ff300000-0x000000ff3fffff
Mar 23 10:44:20 opt2 kernel: [    0.381184] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
Mar 23 10:44:20 opt2 kernel: [    0.381188] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
Mar 23 10:44:20 opt2 kernel: [    0.381193] pci_bus 0000:03: resource 0 io:  [0x9000-0xafff]
Mar 23 10:44:20 opt2 kernel: [    0.381197] pci_bus 0000:03: resource 1 mem: [0xfc900000-0xfeafffff]
Mar 23 10:44:20 opt2 kernel: [    0.381201] pci_bus 0000:03: resource 2 pref mem [0xff500000-0xff5fffff]
Mar 23 10:44:20 opt2 kernel: [    0.381206] pci_bus 0000:02: resource 0 io:  [0x8000-0x8fff]
Mar 23 10:44:20 opt2 kernel: [    0.381210] pci_bus 0000:02: resource 1 mem: [0xfc700000-0xfc8fffff]
Mar 23 10:44:20 opt2 kernel: [    0.381214] pci_bus 0000:02: resource 2 pref mem [0xff400000-0xff4fffff]
Mar 23 10:44:20 opt2 kernel: [    0.381219] pci_bus 0000:01: resource 0 io:  [0x7000-0x7fff]
Mar 23 10:44:20 opt2 kernel: [    0.381223] pci_bus 0000:01: resource 1 mem: [0xfc600000-0xfc6fffff]
Mar 23 10:44:20 opt2 kernel: [    0.381227] pci_bus 0000:01: resource 2 pref mem [0xff300000-0xff3fffff]
Mar 23 10:44:20 opt2 kernel: [    0.381288] NET: Registered protocol family 2
Mar 23 10:44:20 opt2 kernel: [    0.381520] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
Mar 23 10:44:20 opt2 kernel: [    0.383643] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
Mar 23 10:44:20 opt2 kernel: [    0.388501] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
Mar 23 10:44:20 opt2 kernel: [    0.389635] TCP: Hash tables configured (established 262144 bind 65536)
Mar 23 10:44:20 opt2 kernel: [    0.389639] TCP reno registered
Mar 23 10:44:20 opt2 kernel: [    0.389795] NET: Registered protocol family 1
Mar 23 10:44:20 opt2 kernel: [    0.389929] Trying to unpack rootfs image as initramfs...
Mar 23 10:44:20 opt2 kernel: [    0.390032] Switched to high resolution mode on CPU 0
Mar 23 10:44:20 opt2 kernel: [    0.390783] Switched to high resolution mode on CPU 1
Mar 23 10:44:20 opt2 kernel: [    0.658081] Freeing initrd memory: 6754k freed
Mar 23 10:44:20 opt2 kernel: [    0.667622] Scanning for low memory corruption every 60 seconds
Mar 23 10:44:20 opt2 kernel: [    0.667863] audit: initializing netlink socket (disabled)
Mar 23 10:44:20 opt2 kernel: [    0.667886] type=2000 audit(1269362639.660:1): initialized
Mar 23 10:44:20 opt2 kernel: [    0.681795] HugeTLB registered 2 MB page size, pre-allocated 0 pages
Mar 23 10:44:20 opt2 kernel: [    0.684066] VFS: Disk quotas dquot_6.5.2
Mar 23 10:44:20 opt2 kernel: [    0.684155] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Mar 23 10:44:20 opt2 kernel: [    0.685139] fuse init (API version 7.12)
Mar 23 10:44:20 opt2 kernel: [    0.685262] msgmni has been set to 4018
Mar 23 10:44:20 opt2 kernel: [    0.685657] alg: No test for stdrng (krng)
Mar 23 10:44:20 opt2 kernel: [    0.685697] io scheduler noop registered
Mar 23 10:44:20 opt2 kernel: [    0.685700] io scheduler anticipatory registered
Mar 23 10:44:20 opt2 kernel: [    0.685703] io scheduler deadline registered (default)
Mar 23 10:44:20 opt2 kernel: [    0.685764] io scheduler cfq registered
Mar 23 10:44:20 opt2 kernel: [    0.685789] boot interrupts on PCI device 0x1022:0x746b already disabled
Mar 23 10:44:20 opt2 kernel: [    0.685795] pci 0000:00:0a.0: MSI quirk detected; subordinate MSI disabled
Mar 23 10:44:20 opt2 kernel: [    0.685802] disabled boot interrupts on PCI device 0x1022:0x7450
Mar 23 10:44:20 opt2 kernel: [    0.685806] pci 0000:00:0a.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
Mar 23 10:44:20 opt2 kernel: [    0.685813] pci 0000:00:0b.0: MSI quirk detected; subordinate MSI disabled
Mar 23 10:44:20 opt2 kernel: [    0.685818] disabled boot interrupts on PCI device 0x1022:0x7450
Mar 23 10:44:20 opt2 kernel: [    0.685822] pci 0000:00:0b.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
Mar 23 10:44:20 opt2 kernel: [    0.740025] pci 0000:03:06.0: Boot video device
Mar 23 10:44:20 opt2 kernel: [    0.740042] pci 0000:03:08.0: Firmware left e100 interrupts enabled; disabling
Mar 23 10:44:20 opt2 kernel: [    0.740403] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Mar 23 10:44:20 opt2 kernel: [    0.740441] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
Mar 23 10:44:20 opt2 kernel: [    0.740622] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
Mar 23 10:44:20 opt2 kernel: [    0.740629] ACPI: Power Button [PWRF]
Mar 23 10:44:20 opt2 kernel: [    0.740711] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
Mar 23 10:44:20 opt2 kernel: [    0.740720] ACPI: Power Button [PWRB]
Mar 23 10:44:20 opt2 kernel: [    0.740977] ACPI: processor limited to max C-state 1
Mar 23 10:44:20 opt2 kernel: [    0.741018] processor LNXCPU:00: registered as cooling_device0
Mar 23 10:44:20 opt2 kernel: [    0.741024] ACPI: Processor [CPU0] (supports 8 throttling states)
Mar 23 10:44:20 opt2 kernel: [    0.741088] processor LNXCPU:01: registered as cooling_device1
Mar 23 10:44:20 opt2 kernel: [    0.745609] hpet_acpi_add: no address or irqs in _CRS
Mar 23 10:44:20 opt2 kernel: [    0.745626] Linux agpgart interface v0.103
Mar 23 10:44:20 opt2 kernel: [    0.745642] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
Mar 23 10:44:20 opt2 kernel: [    0.745773] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar 23 10:44:20 opt2 kernel: [    0.745883] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar 23 10:44:20 opt2 kernel: [    0.746177] 00:05: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Mar 23 10:44:20 opt2 kernel: [    0.746328] 00:06: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Mar 23 10:44:20 opt2 kernel: [    0.747884] brd: module loaded
Mar 23 10:44:20 opt2 kernel: [    0.748529] loop: module loaded
Mar 23 10:44:20 opt2 kernel: [    0.748651] input: Macintosh mouse button emulation as /devices/virtual/input/input2
Mar 23 10:44:20 opt2 kernel: [    0.748917] sata_promise 0000:02:02.0: version 2.12
Mar 23 10:44:20 opt2 kernel: [    0.748937]   alloc irq_desc for 26 on node 0
Mar 23 10:44:20 opt2 kernel: [    0.748940]   alloc kstat_irqs on node 0
Mar 23 10:44:20 opt2 kernel: [    0.748954] sata_promise 0000:02:02.0: PCI INT A -> GSI 26 (level, low) -> IRQ 26
Mar 23 10:44:20 opt2 kernel: [    0.749173] scsi0 : sata_promise
Mar 23 10:44:20 opt2 kernel: [    0.749330] scsi1 : sata_promise
Mar 23 10:44:20 opt2 kernel: [    0.749421] scsi2 : sata_promise
Mar 23 10:44:20 opt2 kernel: [    0.749511] scsi3 : sata_promise
Mar 23 10:44:20 opt2 kernel: [    0.749561] ata1: SATA max UDMA/133 mmio m4096@0xfc8ff000 ata 0xfc8ff380 irq 26
Mar 23 10:44:20 opt2 kernel: [    0.749566] ata2: SATA max UDMA/133 mmio m4096@0xfc8ff000 ata 0xfc8ff280 irq 26
Mar 23 10:44:20 opt2 kernel: [    0.749570] ata3: SATA max UDMA/133 mmio m4096@0xfc8ff000 ata 0xfc8ff200 irq 26
Mar 23 10:44:20 opt2 kernel: [    0.749575] ata4: SATA max UDMA/133 mmio m4096@0xfc8ff000 ata 0xfc8ff300 irq 26
Mar 23 10:44:20 opt2 kernel: [    0.749663]   alloc irq_desc for 28 on node 0
Mar 23 10:44:20 opt2 kernel: [    0.749666]   alloc kstat_irqs on node 0
Mar 23 10:44:20 opt2 kernel: [    0.749672] sata_promise 0000:01:03.0: PCI INT A -> GSI 28 (level, low) -> IRQ 28
Mar 23 10:44:20 opt2 kernel: [    0.749851] scsi4 : sata_promise
Mar 23 10:44:20 opt2 kernel: [    0.749980] scsi5 : sata_promise
Mar 23 10:44:20 opt2 kernel: [    0.750110] scsi6 : sata_promise
Mar 23 10:44:20 opt2 kernel: [    0.750210] scsi7 : sata_promise
Mar 23 10:44:20 opt2 kernel: [    0.750257] ata5: SATA max UDMA/133 mmio m4096@0xfc6ff000 ata 0xfc6ff380 irq 28
Mar 23 10:44:20 opt2 kernel: [    0.750261] ata6: SATA max UDMA/133 mmio m4096@0xfc6ff000 ata 0xfc6ff280 irq 28
Mar 23 10:44:20 opt2 kernel: [    0.750266] ata7: SATA max UDMA/133 mmio m4096@0xfc6ff000 ata 0xfc6ff200 irq 28
Mar 23 10:44:20 opt2 kernel: [    0.750270] ata8: SATA max UDMA/133 mmio m4096@0xfc6ff000 ata 0xfc6ff300 irq 28
Mar 23 10:44:20 opt2 kernel: [    0.750497] sata_sil 0000:03:05.0: version 2.4
Mar 23 10:44:20 opt2 kernel: [    0.750573]   alloc irq_desc for 19 on node 0
Mar 23 10:44:20 opt2 kernel: [    0.750576]   alloc kstat_irqs on node 0
Mar 23 10:44:20 opt2 kernel: [    0.750582] sata_sil 0000:03:05.0: PCI INT A -> GSI 19 (level, low) -> IRQ 19
Mar 23 10:44:20 opt2 kernel: [    0.750604] sata_sil 0000:03:05.0: Applying R_ERR on DMA activate FIS errata fix
Mar 23 10:44:20 opt2 kernel: [    0.750728] scsi8 : sata_sil
Mar 23 10:44:20 opt2 kernel: [    0.750835] scsi9 : sata_sil
Mar 23 10:44:20 opt2 kernel: [    0.750933] scsi10 : sata_sil
Mar 23 10:44:20 opt2 kernel: [    0.751028] scsi11 : sata_sil
Mar 23 10:44:20 opt2 kernel: [    0.751082] ata9: SATA max UDMA/100 mmio m1024@0xfeafec00 tf 0xfeafec80 irq 19
Mar 23 10:44:20 opt2 kernel: [    0.751087] ata10: SATA max UDMA/100 mmio m1024@0xfeafec00 tf 0xfeafecc0 irq 19
Mar 23 10:44:20 opt2 kernel: [    0.751092] ata11: SATA max UDMA/100 mmio m1024@0xfeafec00 tf 0xfeafee80 irq 19
Mar 23 10:44:20 opt2 kernel: [    0.751097] ata12: SATA max UDMA/100 mmio m1024@0xfeafec00 tf 0xfeafeec0 irq 19
Mar 23 10:44:20 opt2 kernel: [    0.751615] pata_amd 0000:00:07.1: version 0.4.1
Mar 23 10:44:20 opt2 kernel: [    0.751848] scsi12 : pata_amd
Mar 23 10:44:20 opt2 kernel: [    0.751947] scsi13 : pata_amd
Mar 23 10:44:20 opt2 kernel: [    0.753001] ata13: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xffa0 irq 14
Mar 23 10:44:20 opt2 kernel: [    0.753005] ata14: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xffa8 irq 15
Mar 23 10:44:20 opt2 kernel: [    0.754185] Fixed MDIO Bus: probed
Mar 23 10:44:20 opt2 kernel: [    0.754242] PPP generic driver version 2.4.2
Mar 23 10:44:20 opt2 kernel: [    0.754396] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Mar 23 10:44:20 opt2 kernel: [    0.754423] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Mar 23 10:44:20 opt2 kernel: [    0.754541] ohci_hcd 0000:03:00.0: PCI INT D -> GSI 19 (level, low) -> IRQ 19
Mar 23 10:44:20 opt2 kernel: [    0.754563] ohci_hcd 0000:03:00.0: OHCI Host Controller
Mar 23 10:44:20 opt2 kernel: [    0.754651] ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
Mar 23 10:44:20 opt2 kernel: [    0.754676] ohci_hcd 0000:03:00.0: irq 19, io mem 0xfeafc000
Mar 23 10:44:20 opt2 kernel: [    0.812140] usb usb1: configuration #1 chosen from 1 choice
Mar 23 10:44:20 opt2 kernel: [    0.812185] hub 1-0:1.0: USB hub found
Mar 23 10:44:20 opt2 kernel: [    0.812203] hub 1-0:1.0: 3 ports detected
Mar 23 10:44:20 opt2 kernel: [    0.812349] ohci_hcd 0000:03:00.1: PCI INT D -> GSI 19 (level, low) -> IRQ 19
Mar 23 10:44:20 opt2 kernel: [    0.812363] ohci_hcd 0000:03:00.1: OHCI Host Controller
Mar 23 10:44:20 opt2 kernel: [    0.812429] ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 2
Mar 23 10:44:20 opt2 kernel: [    0.812451] ohci_hcd 0000:03:00.1: irq 19, io mem 0xfeafd000
Mar 23 10:44:20 opt2 kernel: [    0.872104] usb usb2: configuration #1 chosen from 1 choice
Mar 23 10:44:20 opt2 kernel: [    0.872146] hub 2-0:1.0: USB hub found
Mar 23 10:44:20 opt2 kernel: [    0.872159] hub 2-0:1.0: 3 ports detected
Mar 23 10:44:20 opt2 kernel: [    0.872236] uhci_hcd: USB Universal Host Controller Interface driver
Mar 23 10:44:20 opt2 kernel: [    0.872423] PNP: No PS/2 controller found. Probing ports directly.
Mar 23 10:44:20 opt2 kernel: [    0.874466] serio: i8042 KBD port at 0x60,0x64 irq 1
Mar 23 10:44:20 opt2 kernel: [    0.874476] serio: i8042 AUX port at 0x60,0x64 irq 12
Mar 23 10:44:20 opt2 kernel: [    0.874609] mice: PS/2 mouse device common for all mice
Mar 23 10:44:20 opt2 kernel: [    0.874748] rtc_cmos 00:02: RTC can wake from S4
Mar 23 10:44:20 opt2 kernel: [    0.874813] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
Mar 23 10:44:20 opt2 kernel: [    0.874847] rtc0: alarms up to one year, y3k, 114 bytes nvram
Mar 23 10:44:20 opt2 kernel: [    0.875044] device-mapper: uevent: version 1.0.3
Mar 23 10:44:20 opt2 kernel: [    0.875205] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
Mar 23 10:44:20 opt2 kernel: [    0.875353] device-mapper: multipath: version 1.1.0 loaded
Mar 23 10:44:20 opt2 kernel: [    0.875359] device-mapper: multipath round-robin: version 1.0.0 loaded
Mar 23 10:44:20 opt2 kernel: [    0.875694] cpuidle: using governor ladder
Mar 23 10:44:20 opt2 kernel: [    0.875697] cpuidle: using governor menu
Mar 23 10:44:20 opt2 kernel: [    0.876366] TCP cubic registered
Mar 23 10:44:20 opt2 kernel: [    0.876566] NET: Registered protocol family 10
Mar 23 10:44:20 opt2 kernel: [    0.877256] lo: Disabled Privacy Extensions
Mar 23 10:44:20 opt2 kernel: [    0.877676] NET: Registered protocol family 17
Mar 23 10:44:20 opt2 kernel: [    0.877708] Bluetooth: L2CAP ver 2.13
Mar 23 10:44:20 opt2 kernel: [    0.877711] Bluetooth: L2CAP socket layer initialized
Mar 23 10:44:20 opt2 kernel: [    0.877716] Bluetooth: SCO (Voice Link) ver 0.6
Mar 23 10:44:20 opt2 kernel: [    0.877718] Bluetooth: SCO socket layer initialized
Mar 23 10:44:20 opt2 kernel: [    0.877773] Bluetooth: RFCOMM TTY layer initialized
Mar 23 10:44:20 opt2 kernel: [    0.877777] Bluetooth: RFCOMM socket layer initialized
Mar 23 10:44:20 opt2 kernel: [    0.877779] Bluetooth: RFCOMM ver 1.11
Mar 23 10:44:20 opt2 kernel: [    0.877819] powernow-k8: Power state transitions not supported
Mar 23 10:44:20 opt2 kernel: [    0.877825] powernow-k8: Power state transitions not supported
Mar 23 10:44:20 opt2 kernel: [    0.877950] PM: Resume from disk failed.
Mar 23 10:44:20 opt2 kernel: [    0.877970] registered taskstats version 1
Mar 23 10:44:20 opt2 kernel: [    0.878212]   Magic number: 2:92:743
Mar 23 10:44:20 opt2 kernel: [    0.878339] rtc_cmos 00:02: setting system clock to 2010-03-23 16:44:00 UTC (1269362640)
Mar 23 10:44:20 opt2 kernel: [    0.878344] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
Mar 23 10:44:20 opt2 kernel: [    0.878347] EDD information not available.
Mar 23 10:44:20 opt2 kernel: [    0.953048] ata13.00: ATA-6: Maxtor 4D040H2, DAH017K0, max UDMA/100
Mar 23 10:44:20 opt2 kernel: [    0.953052] ata13.00: 80043264 sectors, multi 16: LBA 
Mar 23 10:44:20 opt2 kernel: [    0.953097] ata13.01: ATAPI: SONY    DVD RW AW-G540A, 1.30, max UDMA/33
Mar 23 10:44:20 opt2 kernel: [    0.992986] ata13.00: configured for UDMA/100
Mar 23 10:44:20 opt2 kernel: [    1.032763] ata13.01: configured for UDMA/33
Mar 23 10:44:20 opt2 kernel: [    1.092536] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    1.100038] ata9: SATA link down (SStatus 0 SControl 310)
Mar 23 10:44:20 opt2 kernel: [    1.100100] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    1.153805] ata1.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
Mar 23 10:44:20 opt2 kernel: [    1.153810] ata1.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
Mar 23 10:44:20 opt2 kernel: [    1.160291] ata5.00: ATA-7: ST3320620AS, 3.AAE, max UDMA/133
Mar 23 10:44:20 opt2 kernel: [    1.160295] ata5.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
Mar 23 10:44:20 opt2 kernel: [    1.243589] ata5.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    1.245425] ata1.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    1.245586] scsi 0:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [    1.245771] sd 0:0:0:0: Attached scsi generic sg0 type 0
Mar 23 10:44:20 opt2 kernel: [    1.245835] sd 0:0:0:0: [sda] 625142448 512-byte logical blocks: (320 GB/298 GiB)
Mar 23 10:44:20 opt2 kernel: [    1.245902] sd 0:0:0:0: [sda] Write Protect is off
Mar 23 10:44:20 opt2 kernel: [    1.245906] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
Mar 23 10:44:20 opt2 kernel: [    1.245941] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 23 10:44:20 opt2 kernel: [    1.246141]  sda: sda1 sda2
Mar 23 10:44:20 opt2 kernel: [    1.285690] sd 0:0:0:0: [sda] Attached SCSI disk
Mar 23 10:44:20 opt2 kernel: [    1.590036] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    1.651576] ata2.00: ATA-7: ST3320620AS, 3.AAE, max UDMA/133
Mar 23 10:44:20 opt2 kernel: [    1.651580] ata2.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
Mar 23 10:44:20 opt2 kernel: [    1.743201] ata2.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    1.743416] ata2: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
Mar 23 10:44:20 opt2 kernel: [    1.743419] ata2: hotplug_status 0x22
Mar 23 10:44:20 opt2 kernel: [    1.743427] ata2: hard resetting link
Mar 23 10:44:20 opt2 kernel: [    2.490037] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    2.634325] ata2.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    2.634330] ata2: EH complete
Mar 23 10:44:20 opt2 kernel: [    2.634399] scsi 1:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [    2.634542] sd 1:0:0:0: Attached scsi generic sg1 type 0
Mar 23 10:44:20 opt2 kernel: [    2.634590] sd 1:0:0:0: [sdb] 625142448 512-byte logical blocks: (320 GB/298 GiB)
Mar 23 10:44:20 opt2 kernel: [    2.634650] sd 1:0:0:0: [sdb] Write Protect is off
Mar 23 10:44:20 opt2 kernel: [    2.634653] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
Mar 23 10:44:20 opt2 kernel: [    2.634684] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 23 10:44:20 opt2 kernel: [    2.634823]  sdb: unknown partition table
Mar 23 10:44:20 opt2 kernel: [    2.674337] sd 1:0:0:0: [sdb] Attached SCSI disk
Mar 23 10:44:20 opt2 kernel: [    2.980037] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    3.035629] ata3.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
Mar 23 10:44:20 opt2 kernel: [    3.035634] ata3.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
Mar 23 10:44:20 opt2 kernel: [    3.118938] ata3.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    3.119149] ata3: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
Mar 23 10:44:20 opt2 kernel: [    3.119152] ata3: hotplug_status 0x11
Mar 23 10:44:20 opt2 kernel: [    3.119160] ata3: hard resetting link
Mar 23 10:44:20 opt2 kernel: [    3.860037] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    4.001773] ata3.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    4.001777] ata3: EH complete
Mar 23 10:44:20 opt2 kernel: [    4.001847] scsi 2:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [    4.001992] sd 2:0:0:0: Attached scsi generic sg2 type 0
Mar 23 10:44:20 opt2 kernel: [    4.002034] sd 2:0:0:0: [sdc] 625142448 512-byte logical blocks: (320 GB/298 GiB)
Mar 23 10:44:20 opt2 kernel: [    4.002093] sd 2:0:0:0: [sdc] Write Protect is off
Mar 23 10:44:20 opt2 kernel: [    4.002097] sd 2:0:0:0: [sdc] Mode Sense: 00 3a 00 00
Mar 23 10:44:20 opt2 kernel: [    4.002126] sd 2:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 23 10:44:20 opt2 kernel: [    4.002265]  sdc: unknown partition table
Mar 23 10:44:20 opt2 kernel: [    4.041843] sd 2:0:0:0: [sdc] Attached SCSI disk
Mar 23 10:44:20 opt2 kernel: [    4.350037] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    4.406159] ata4.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
Mar 23 10:44:20 opt2 kernel: [    4.406164] ata4.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
Mar 23 10:44:20 opt2 kernel: [    4.489468] ata4.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    4.489679] ata4: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
Mar 23 10:44:20 opt2 kernel: [    4.489682] ata4: hotplug_status 0x44
Mar 23 10:44:20 opt2 kernel: [    4.489690] ata4: hard resetting link
Mar 23 10:44:20 opt2 kernel: [    5.230038] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    5.372289] ata4.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    5.372292] ata4: EH complete
Mar 23 10:44:20 opt2 kernel: [    5.372360] scsi 3:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [    5.372498] sd 3:0:0:0: Attached scsi generic sg3 type 0
Mar 23 10:44:20 opt2 kernel: [    5.372552] sd 3:0:0:0: [sdd] 625142448 512-byte logical blocks: (320 GB/298 GiB)
Mar 23 10:44:20 opt2 kernel: [    5.372608] sd 3:0:0:0: [sdd] Write Protect is off
Mar 23 10:44:20 opt2 kernel: [    5.372612] sd 3:0:0:0: [sdd] Mode Sense: 00 3a 00 00
Mar 23 10:44:20 opt2 kernel: [    5.372642] sd 3:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 23 10:44:20 opt2 kernel: [    5.372794]  sdd:
Mar 23 10:44:20 opt2 kernel: [    5.372884] scsi 4:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [    5.373031] sd 4:0:0:0: Attached scsi generic sg4 type 0
Mar 23 10:44:20 opt2 kernel: [    5.373071] sd 4:0:0:0: [sde] 625142448 512-byte logical blocks: (320 GB/298 GiB)
Mar 23 10:44:20 opt2 kernel: [    5.373125] sd 4:0:0:0: [sde] Write Protect is off
Mar 23 10:44:20 opt2 kernel: [    5.373129] sd 4:0:0:0: [sde] Mode Sense: 00 3a 00 00
Mar 23 10:44:20 opt2 kernel: [    5.373158] sd 4:0:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 23 10:44:20 opt2 kernel: [    5.373301]  sde: unknown partition table
Mar 23 10:44:20 opt2 kernel: [    5.389480] sd 4:0:0:0: [sde] Attached SCSI disk
Mar 23 10:44:20 opt2 kernel: [    5.412128]  unknown partition table
Mar 23 10:44:20 opt2 kernel: [    5.412320] sd 3:0:0:0: [sdd] Attached SCSI disk
Mar 23 10:44:20 opt2 kernel: [    5.720038] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    5.783506] ata6.00: ATA-7: ST3320620AS, 3.AAE, max UDMA/133
Mar 23 10:44:20 opt2 kernel: [    5.783511] ata6.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
Mar 23 10:44:20 opt2 kernel: [    5.875135] ata6.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    5.875347] ata6: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
Mar 23 10:44:20 opt2 kernel: [    5.875350] ata6: hotplug_status 0x2
Mar 23 10:44:20 opt2 kernel: [    5.875358] ata6: hard resetting link
Mar 23 10:44:20 opt2 kernel: [    6.620039] ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    6.757944] ata6.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    6.757948] ata6: EH complete
Mar 23 10:44:20 opt2 kernel: [    6.758020] scsi 5:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [    6.758171] sd 5:0:0:0: Attached scsi generic sg5 type 0
Mar 23 10:44:20 opt2 kernel: [    6.758213] sd 5:0:0:0: [sdf] 625142448 512-byte logical blocks: (320 GB/298 GiB)
Mar 23 10:44:20 opt2 kernel: [    6.758271] sd 5:0:0:0: [sdf] Write Protect is off
Mar 23 10:44:20 opt2 kernel: [    6.758275] sd 5:0:0:0: [sdf] Mode Sense: 00 3a 00 00
Mar 23 10:44:20 opt2 kernel: [    6.758306] sd 5:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 23 10:44:20 opt2 kernel: [    6.758454]  sdf: unknown partition table
Mar 23 10:44:20 opt2 kernel: [    6.797953] sd 5:0:0:0: [sdf] Attached SCSI disk
Mar 23 10:44:20 opt2 kernel: [    7.100038] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    7.152078] ata7.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
Mar 23 10:44:20 opt2 kernel: [    7.152083] ata7.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
Mar 23 10:44:20 opt2 kernel: [    7.243715] ata7.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    7.243926] ata7: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
Mar 23 10:44:20 opt2 kernel: [    7.243929] ata7: hotplug_status 0x11
Mar 23 10:44:20 opt2 kernel: [    7.243937] ata7: hard resetting link
Mar 23 10:44:20 opt2 kernel: [    7.990037] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    8.134876] ata7.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    8.134880] ata7: EH complete
Mar 23 10:44:20 opt2 kernel: [    8.134948] scsi 6:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [    8.135097] sd 6:0:0:0: Attached scsi generic sg6 type 0
Mar 23 10:44:20 opt2 kernel: [    8.135138] sd 6:0:0:0: [sdg] 625142448 512-byte logical blocks: (320 GB/298 GiB)
Mar 23 10:44:20 opt2 kernel: [    8.135195] sd 6:0:0:0: [sdg] Write Protect is off
Mar 23 10:44:20 opt2 kernel: [    8.135199] sd 6:0:0:0: [sdg] Mode Sense: 00 3a 00 00
Mar 23 10:44:20 opt2 kernel: [    8.135228] sd 6:0:0:0: [sdg] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 23 10:44:20 opt2 kernel: [    8.135368]  sdg: unknown partition table
Mar 23 10:44:20 opt2 kernel: [    8.174944] sd 6:0:0:0: [sdg] Attached SCSI disk
Mar 23 10:44:20 opt2 kernel: [    8.480038] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    8.545473] ata8.00: ATA-7: ST3320620AS, 3.AAJ, max UDMA/133
Mar 23 10:44:20 opt2 kernel: [    8.545478] ata8.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 0/32)
Mar 23 10:44:20 opt2 kernel: [    8.628773] ata8.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    8.628984] ata8: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xf t4
Mar 23 10:44:20 opt2 kernel: [    8.628987] ata8: hotplug_status 0x44
Mar 23 10:44:20 opt2 kernel: [    8.628995] ata8: hard resetting link
Mar 23 10:44:20 opt2 kernel: [    9.370041] ata8: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Mar 23 10:44:20 opt2 kernel: [    9.503254] ata8.00: configured for UDMA/133
Mar 23 10:44:20 opt2 kernel: [    9.503258] ata8: EH complete
Mar 23 10:44:20 opt2 kernel: [    9.503328] scsi 7:0:0:0: Direct-Access     ATA      ST3320620AS      3.AA PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [    9.503468] sd 7:0:0:0: Attached scsi generic sg7 type 0
Mar 23 10:44:20 opt2 kernel: [    9.503513] sd 7:0:0:0: [sdh] 625142448 512-byte logical blocks: (320 GB/298 GiB)
Mar 23 10:44:20 opt2 kernel: [    9.503571] sd 7:0:0:0: [sdh] Write Protect is off
Mar 23 10:44:20 opt2 kernel: [    9.503575] sd 7:0:0:0: [sdh] Mode Sense: 00 3a 00 00
Mar 23 10:44:20 opt2 kernel: [    9.503606] sd 7:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 23 10:44:20 opt2 kernel: [    9.503755]  sdh: unknown partition table
Mar 23 10:44:20 opt2 kernel: [    9.543312] sd 7:0:0:0: [sdh] Attached SCSI disk
Mar 23 10:44:20 opt2 kernel: [    9.850034] ata10: SATA link down (SStatus 0 SControl 310)
Mar 23 10:44:20 opt2 kernel: [   10.200037] ata11: SATA link down (SStatus 0 SControl 310)
Mar 23 10:44:20 opt2 kernel: [   10.552533] ata12: SATA link down (SStatus 0 SControl 310)
Mar 23 10:44:20 opt2 kernel: [   10.552625] scsi 12:0:0:0: Direct-Access     ATA      Maxtor 4D040H2   DAH0 PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [   10.552781] sd 12:0:0:0: Attached scsi generic sg8 type 0
Mar 23 10:44:20 opt2 kernel: [   10.555645] sd 12:0:0:0: [sdi] 80043264 512-byte logical blocks: (40.9 GB/38.1 GiB)
Mar 23 10:44:20 opt2 kernel: [   10.555701] sd 12:0:0:0: [sdi] Write Protect is off
Mar 23 10:44:20 opt2 kernel: [   10.555706] sd 12:0:0:0: [sdi] Mode Sense: 00 3a 00 00
Mar 23 10:44:20 opt2 kernel: [   10.555736] sd 12:0:0:0: [sdi] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Mar 23 10:44:20 opt2 kernel: [   10.555880]  sdi:
Mar 23 10:44:20 opt2 kernel: [   10.593577] scsi 12:0:1:0: CD-ROM            SONY     DVD RW AW-G540A  1.30 PQ: 0 ANSI: 5
Mar 23 10:44:20 opt2 kernel: [   10.599123] sd 12:0:0:0: [sdi] Attached SCSI disk
Mar 23 10:44:20 opt2 kernel: [   10.612782] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Mar 23 10:44:20 opt2 kernel: [   10.612788] Uniform CD-ROM driver Revision: 3.20
Mar 23 10:44:20 opt2 kernel: [   10.612890] sr 12:0:1:0: Attached scsi CD-ROM sr0
Mar 23 10:44:20 opt2 kernel: [   10.612944] sr 12:0:1:0: Attached scsi generic sg9 type 5
Mar 23 10:44:20 opt2 kernel: [   10.781278] Freeing unused kernel memory: 660k freed
Mar 23 10:44:20 opt2 kernel: [   10.781961] Write protecting the kernel read-only data: 7572k
Mar 23 10:44:20 opt2 kernel: [   11.111781] Floppy drive(s): fd0 is 1.44M
Mar 23 10:44:20 opt2 kernel: [   11.136166] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
Mar 23 10:44:20 opt2 kernel: [   11.136172] e100: Copyright(c) 1999-2006 Intel Corporation
Mar 23 10:44:20 opt2 kernel: [   11.146285] FDC 0 is a post-1991 82077
Mar 23 10:44:20 opt2 kernel: [   11.149223]   alloc irq_desc for 18 on node 0
Mar 23 10:44:20 opt2 kernel: [   11.149230]   alloc kstat_irqs on node 0
Mar 23 10:44:20 opt2 kernel: [   11.149255] e100 0000:03:08.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Mar 23 10:44:20 opt2 kernel: [   11.252187] e100 0000:03:08.0: PME# disabled
Mar 23 10:44:20 opt2 kernel: [   11.253055] e100: eth0: e100_probe: addr 0xfeafb000, irq 18, MAC addr 00:e0:81:28:67:de
Mar 23 10:44:20 opt2 kernel: [   11.253536] tg3.c:v3.99 (April 20, 2009)
Mar 23 10:44:20 opt2 kernel: [   11.253550]   alloc irq_desc for 24 on node 0
Mar 23 10:44:20 opt2 kernel: [   11.253553]   alloc kstat_irqs on node 0
Mar 23 10:44:20 opt2 kernel: [   11.253560] tg3 0000:02:09.0: PCI INT A -> GSI 24 (level, low) -> IRQ 24
Mar 23 10:44:20 opt2 kernel: [   11.280128] tg3 0000:02:09.0: wake-up capability disabled by ACPI
Mar 23 10:44:20 opt2 kernel: [   11.280139] tg3 0000:02:09.0: PME# disabled
Mar 23 10:44:20 opt2 kernel: [   11.311997] eth1: Tigon3 [partno(BCM95704A7) rev 2003] (PCI:66MHz:64-bit) MAC address 00:e0:81:28:67:fc
Mar 23 10:44:20 opt2 kernel: [   11.312006] eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1])
Mar 23 10:44:20 opt2 kernel: [   11.312011] eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
Mar 23 10:44:20 opt2 kernel: [   11.312014] eth1: dma_rwctrl[763f0000] dma_mask[64-bit]
Mar 23 10:44:20 opt2 kernel: [   11.324132]   alloc irq_desc for 25 on node 0
Mar 23 10:44:20 opt2 kernel: [   11.324140]   alloc kstat_irqs on node 0
Mar 23 10:44:20 opt2 kernel: [   11.324155] tg3 0000:02:09.1: PCI INT B -> GSI 25 (level, low) -> IRQ 25
Mar 23 10:44:20 opt2 kernel: [   11.350065] tg3 0000:02:09.1: PME# disabled
Mar 23 10:44:20 opt2 kernel: [   11.374786] eth2: Tigon3 [partno(BCM95704A7) rev 2003] (PCI:66MHz:64-bit) MAC address 00:e0:81:28:67:fd
Mar 23 10:44:20 opt2 kernel: [   11.374793] eth2: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1])
Mar 23 10:44:20 opt2 kernel: [   11.374798] eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
Mar 23 10:44:20 opt2 kernel: [   11.374802] eth2: dma_rwctrl[763f0000] dma_mask[64-bit]
Mar 23 10:44:20 opt2 kernel: [   11.739999] PM: Starting manual resume from disk
Mar 23 10:44:20 opt2 kernel: [   11.740008] PM: Resume from partition 8:1
Mar 23 10:44:20 opt2 kernel: [   11.740011] PM: Checking hibernation image.
Mar 23 10:44:20 opt2 kernel: [   11.740122] PM: Resume from disk failed.
Mar 23 10:44:20 opt2 kernel: [   11.756191] EXT4-fs (sda2): INFO: recovery required on readonly filesystem
Mar 23 10:44:20 opt2 kernel: [   11.756199] EXT4-fs (sda2): write access will be enabled during recovery
Mar 23 10:44:20 opt2 kernel: [   11.760544] EXT4-fs (sda2): barriers enabled
Mar 23 10:44:20 opt2 kernel: [   16.760982] kjournald2 starting: pid 400, dev sda2:8, commit interval 5 seconds
Mar 23 10:44:20 opt2 kernel: [   16.761028] EXT4-fs (sda2): delayed allocation enabled
Mar 23 10:44:20 opt2 kernel: [   16.761034] EXT4-fs: file extents enabled
Mar 23 10:44:20 opt2 kernel: [   16.827590] EXT4-fs: mballoc enabled
Mar 23 10:44:20 opt2 kernel: [   16.827618] EXT4-fs (sda2): orphan cleanup on readonly fs
Mar 23 10:44:20 opt2 kernel: [   16.827633] EXT4-fs (sda2): ext4_orphan_cleanup: deleting unreferenced inode 416
Mar 23 10:44:20 opt2 kernel: [   16.827799] EXT4-fs (sda2): ext4_orphan_cleanup: deleting unreferenced inode 410
Mar 23 10:44:20 opt2 kernel: [   16.827890] EXT4-fs (sda2): ext4_orphan_cleanup: deleting unreferenced inode 407
Mar 23 10:44:20 opt2 kernel: [   16.827920] EXT4-fs (sda2): ext4_orphan_cleanup: deleting unreferenced inode 405
Mar 23 10:44:20 opt2 kernel: [   16.827951] EXT4-fs (sda2): ext4_orphan_cleanup: deleting unreferenced inode 403
Mar 23 10:44:20 opt2 kernel: [   16.827980] EXT4-fs (sda2): ext4_orphan_cleanup: deleting unreferenced inode 402
Mar 23 10:44:20 opt2 kernel: [   16.828011] EXT4-fs (sda2): ext4_orphan_cleanup: deleting unreferenced inode 396
Mar 23 10:44:20 opt2 kernel: [   16.828080] EXT4-fs (sda2): ext4_orphan_cleanup: deleting unreferenced inode 393
Mar 23 10:44:20 opt2 kernel: [   16.828109] EXT4-fs (sda2): 8 orphan inodes deleted
Mar 23 10:44:20 opt2 kernel: [   16.828114] EXT4-fs (sda2): recovery complete
Mar 23 10:44:20 opt2 kernel: [   17.569454] EXT4-fs (sda2): mounted filesystem with ordered data mode
Mar 23 10:44:20 opt2 kernel: [   18.044899] type=1505 audit(1269362657.664:2): operation="profile_load" pid=421 name=/sbin/dhclient3
Mar 23 10:44:20 opt2 kernel: [   18.045334] type=1505 audit(1269362657.664:3): operation="profile_load" pid=421 name=/usr/lib/NetworkManager/nm-dhcp-client.action
Mar 23 10:44:20 opt2 kernel: [   18.045576] type=1505 audit(1269362657.664:4): operation="profile_load" pid=421 name=/usr/lib/connman/scripts/dhclient-script
Mar 23 10:44:20 opt2 kernel: [   18.048803] type=1505 audit(1269362657.664:5): operation="profile_load" pid=422 name=/usr/sbin/tcpdump
Mar 23 10:44:20 opt2 kernel: [   18.586156] Adding 1951856k swap on /dev/sda1.  Priority:-1 extents:1 across:1951856k 
Mar 23 10:44:20 opt2 kernel: [   18.881171] EXT4-fs (sda2): internal journal on sda2:8
Mar 23 10:44:20 opt2 kernel: [   18.996738] udev: starting version 147
Mar 23 10:44:20 opt2 kernel: [   19.971463] parport_pc 00:08: reported by Plug and Play ACPI
Mar 23 10:44:20 opt2 kernel: [   19.971526] parport0: PC-style at 0x378, irq 7 [PCSPP]
Mar 23 10:44:20 opt2 kernel: [   19.982287] shpchp 0000:00:06.0: HPC vendor_id 1022 device_id 7460 ss_vid 0 ss_did 0
Mar 23 10:44:20 opt2 kernel: [   19.982295] shpchp 0000:00:06.0: Cannot reserve MMIO region
Mar 23 10:44:20 opt2 kernel: [   19.983057] shpchp 0000:00:0a.0: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
Mar 23 10:44:20 opt2 kernel: [   19.983062] shpchp 0000:00:0a.0: Cannot reserve MMIO region
Mar 23 10:44:20 opt2 kernel: [   19.983219] shpchp 0000:00:0b.0: HPC vendor_id 1022 device_id 7450 ss_vid 0 ss_did 0
Mar 23 10:44:20 opt2 kernel: [   19.983224] shpchp 0000:00:0b.0: Cannot reserve MMIO region
Mar 23 10:44:20 opt2 kernel: [   19.983363] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Mar 23 10:44:20 opt2 kernel: [   20.071977] EDAC MC: Ver: 2.1.0 Oct 16 2009
Mar 23 10:44:20 opt2 kernel: [   20.130097] lp0: using parport0 (interrupt-driven).
Mar 23 10:44:20 opt2 kernel: [   20.170112] EDAC amd64_edac:  Ver: 3.2.0 Oct 16 2009
Mar 23 10:44:20 opt2 kernel: [   20.173157] ppdev: user-space parallel port driver
Mar 23 10:44:20 opt2 kernel: [   20.190054] EDAC amd64: ECC is enabled by BIOS, Proceeding with EDAC module initialization
Mar 23 10:44:20 opt2 kernel: [   20.216667] EDAC amd64: ECC is enabled by BIOS, Proceeding with EDAC module initialization
Mar 23 10:44:20 opt2 kernel: [   20.216748] EDAC MC: Rev E or earlier detected
Mar 23 10:44:20 opt2 kernel: [   20.216870] EDAC MC0: Giving out device to 'amd64_edac' 'RevF': DEV 0000:00:18.2
Mar 23 10:44:20 opt2 kernel: [   20.216874] EDAC MC: Rev E or earlier detected
Mar 23 10:44:20 opt2 kernel: [   20.216951] EDAC MC1: Giving out device to 'amd64_edac' 'RevF': DEV 0000:00:19.2
Mar 23 10:44:20 opt2 kernel: [   20.216987] EDAC PCI0: Giving out device to module 'amd64_edac' controller 'EDAC PCI controller': DEV '0000:00:18.2' (POLLED)
Mar 23 10:44:20 opt2 kernel: [   20.249972] AMD768 RNG detected
Mar 23 10:44:20 opt2 kernel: [   20.365190] ACPI: I/O resource amd756_smbus [0x50e0-0x50ef] conflicts with ACPI region PMIO [0x5000-0x50fe]
Mar 23 10:44:20 opt2 kernel: [   20.365289] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Mar 23 10:44:20 opt2 kernel: [   20.365322] amd756_smbus: probe of 0000:00:07.3 failed with error -16
Mar 23 10:44:20 opt2 kernel: [   20.366257] ACPI: I/O resource 0000:00:07.2 [0xcc00-0xcc1f] conflicts with ACPI region ECIO [0xcc00-0xcc1f]
Mar 23 10:44:20 opt2 kernel: [   20.366353] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
Mar 23 10:44:20 opt2 kernel: [   20.366378] amd8111_smbus2: probe of 0000:00:07.2 failed with error -16
Mar 23 10:44:20 opt2 kernel: [   20.590402] ip_tables: (C) 2000-2006 Netfilter Core Team
Mar 23 10:44:20 opt2 kernel: [   20.608635] udev: renamed network interface eth2 to eth1
Mar 23 10:44:20 opt2 kernel: [   20.655723] udev: renamed network interface eth1_rename to eth0
Mar 23 10:44:20 opt2 kernel: [   20.656699] udev: renamed network interface eth0_rename to eth2
Mar 23 10:44:20 opt2 kernel: [   20.781721] e100 0000:03:08.0: firmware: requesting e100/d102e_ucode.bin
Mar 23 10:44:20 opt2 kernel: [   21.040831] ADDRCONF(NETDEV_UP): eth2: link is not ready
Mar 23 10:44:20 opt2 kernel: [   21.080762] tg3 0000:02:09.1: firmware: requesting tigon/tg3_tso.bin
Mar 23 10:44:21 opt2 kernel: [   21.458804] type=1505 audit(1269362661.071:6): operation="profile_replace" pid=860 name=/sbin/dhclient3
Mar 23 10:44:21 opt2 kernel: [   21.459248] type=1505 audit(1269362661.071:7): operation="profile_replace" pid=860 name=/usr/lib/NetworkManager/nm-dhcp-client.action
Mar 23 10:44:21 opt2 kernel: [   21.459501] type=1505 audit(1269362661.071:8): operation="profile_replace" pid=860 name=/usr/lib/connman/scripts/dhclient-script
Mar 23 10:44:21 opt2 kernel: [   21.461582] tg3 0000:02:09.1: PME# disabled
Mar 23 10:44:21 opt2 kernel: [   21.517438] ADDRCONF(NETDEV_UP): eth1: link is not ready
Mar 23 10:44:21 opt2 kernel: [   21.518350] type=1505 audit(1269362661.131:9): operation="profile_replace" pid=864 name=/usr/sbin/tcpdump
Mar 23 10:44:21 opt2 kernel: [   21.597857] tg3 0000:02:09.0: firmware: requesting tigon/tg3_tso.bin
Mar 23 10:44:21 opt2 kernel: [   21.614472] tg3 0000:02:09.0: wake-up capability disabled by ACPI
Mar 23 10:44:21 opt2 kernel: [   21.614481] tg3 0000:02:09.0: PME# disabled
Mar 23 10:44:21 opt2 kernel: [   21.680769] ADDRCONF(NETDEV_UP): eth0: link is not ready
Mar 23 10:44:21 opt2 init: apport pre-start process (1050) terminated with status 1
Mar 23 10:44:21 opt2 init: apport post-stop process (1063) terminated with status 1
Mar 23 10:44:21 opt2 cron[1054]: (CRON) INFO (pidfile fd = 3)
Mar 23 10:44:21 opt2 cron[1068]: (CRON) STARTUP (fork ok)
Mar 23 10:44:22 opt2 cron[1068]: (CRON) INFO (Running @reboot jobs)
Mar 23 10:44:22 opt2 kernel: [   23.040279] e100: eth2 NIC Link is Up 100 Mbps Full Duplex
Mar 23 10:44:22 opt2 kernel: [   23.041074] ADDRCONF(NETDEV_CHANGE): eth2: link becomes ready
Mar 23 10:44:22 opt2 ntpdate[919]: step time server 91.189.94.4 offset -0.564254 sec
Mar 23 10:44:23 opt2 kernel: [   24.630033] tg3: eth1: Link is up at 1000 Mbps, full duplex.
Mar 23 10:44:23 opt2 kernel: [   24.630040] tg3: eth1: Flow control is on for TX and on for RX.
Mar 23 10:44:23 opt2 kernel: [   24.630720] ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
Mar 23 10:44:26 opt2 kernel: [   27.320046] tg3: eth0: Link is up at 1000 Mbps, full duplex.
Mar 23 10:44:26 opt2 kernel: [   27.320054] tg3: eth0: Flow control is on for TX and on for RX.
Mar 23 10:44:26 opt2 kernel: [   27.320718] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Mar 23 10:44:26 opt2 ntpdate[1131]: step time server 91.189.94.4 offset 0.000606 sec
Mar 23 10:44:27 opt2 kernel: [   28.585782] tg3: eth0: Link is down.
Mar 23 10:44:30 opt2 kernel: [   30.978660] tg3: eth0: Link is up at 1000 Mbps, full duplex.
Mar 23 10:44:30 opt2 kernel: [   30.978664] tg3: eth0: Flow control is on for TX and on for RX.
Mar 23 10:44:31 opt2 kernel: [   32.098774] tg3: eth0: Link is down.
Mar 23 10:44:32 opt2 kernel: [   33.800012] eth2: no IPv6 routers present
Mar 23 10:44:33 opt2 kernel: [   34.910015] eth1: no IPv6 routers present
Mar 23 10:44:36 opt2 kernel: [   37.560017] eth0: no IPv6 routers present
