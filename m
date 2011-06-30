From: Derry Bryson <derry@high-rely.com>
Subject: RE: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Thu, 30 Jun 2011 17:53:32 +0000
Message-ID: <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cal3-mh482-a.smtproutes.com ([208.70.89.239]:45625 "EHLO
	cal3-mh482-a.smtproutes.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751930Ab1F3SHn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Jun 2011 14:07:43 -0400
In-Reply-To: <20110628095723.GC3386@htj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Thanks for the quick response.

> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of tj@kernel.org
> Sent: Tuesday, June 28, 2011 2:57 AM
> To: Derry Bryson
> Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
> 
> Hello,
> 
> Can you please cc linux-ide@vger.kernel.org when replying?
> 
> On Mon, Jun 27, 2011 at 06:02:23PM +0000, Derry Bryson wrote:
> > I found this thread from around 2.5 years ago describing the same
> > problem I am having in only in kernel 2.6.38 (ubuntu 11.04):
> >
> > http://marc.info/?l=linux-ide&m=122373892631645&w=2
> >
> > The thread seemed to stop with you sending another patch to be
> > tested and nothing more after that.  Was this ever fixed?
> 
> Hmm... it seems like the last test patch didn't get replied and I
> forgot about it.  Can you please provide the following information?
> 
> * Detailed sequence of actions to trigger the problem.
> 

Hardware:  Silicon Image 3124 PCI card in computer connected eSATA to an
external drive enclosure with a Silicon Image 3726 port multiplier chip with
5 removable drive trays (http://high-rely.com/HR3/includes/HighRely/5BayMT/5BayMT.php)
containing 5 various hard drives.

To create the problem I simply turn off a drive bay and wait for it to be removed
from the system.  Then turn the drive bay back on and usually the drive will not
reconnect without several cycles of turning it off and on.

Note the drives always seem to come up fine on boot with the external drive bays
already powered on and if I power cycle the drive bays with the computer on and booted.

I have included info from kern.log below showing turning the bay on and off before and
after I patched the kernel.  I first applied the patch from your previous email
and changed the second timing value to 1000 and that makes it work.  It also works
if you leave the timing values alone and up the retries (i.e ATA_EH_PMP_LINK_TRIES) from 
3 to 5.  It seems to me the drives are taking a long (relatively) time to spin up and
either way all we are doing is giving it more time to spin up.  Is there some way to
know it is spinning up and wait for that rather than just trying to reset the controller
over and over?  Also I notice from the kernel log that the 'hotplugged' flag is only
set the first time it does the hard reset and is then cleared.  If this didn't get 
cleared it may work that way as well.  All of this only fixes the problem until an
slower drive comes out.

>From the SMART info on the drives for the WD 3TB that fails the spin up value was 188 vs.
a Seagate 160GB that was 87.  I believe these values are in milliseconds so we can see
that the drive that fails takes much longer to spin up.

> * dmesg output after hotplug failure w/ CONFIG_PRINTK_TIME set
>   including boot messages.
> 

Here is dmesg from boot (kernel 2.6.32):

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.32-21-generic (buildd@yellow) (gcc version 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #32-Ubuntu SMP Fri Apr 16 08:09:38 UTC 2010 (Ubuntu 2.6.32-21.32-generic 2.6.32.11+drm33.2)
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-2.6.32-21-generic root=UUID=4091bfa7-5a4a-45c4-8b6f-a364fdce5a47 ro quiet nomodeset text
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
[    0.000000]  BIOS-e820: 000000000008f000 - 0000000000090000 (reserved)
[    0.000000]  BIOS-e820: 0000000000090000 - 000000000009c800 (usable)
[    0.000000]  BIOS-e820: 000000000009c800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003ee98000 (usable)
[    0.000000]  BIOS-e820: 000000003ee98000 - 000000003eebf000 (reserved)
[    0.000000]  BIOS-e820: 000000003eebf000 - 000000003ef47000 (usable)
[    0.000000]  BIOS-e820: 000000003ef47000 - 000000003efbf000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003efbf000 - 000000003eff1000 (usable)
[    0.000000]  BIOS-e820: 000000003eff1000 - 000000003efff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003efff000 - 000000003f000000 (usable)
[    0.000000]  BIOS-e820: 000000003f000000 - 0000000040000000 (reserved)
[    0.000000]  BIOS-e820: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.5 present.
[    0.000000] last_pfn = 0x3f000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-FFFFF uncachable
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FC0000000 write-back
[    0.000000]   1 base 03F000000 mask FFF000000 uncachable
[    0.000000]   2 base 0FFFF0000 mask FFFFF0000 write-protect
[    0.000000]   3 base 0FFF10000 mask FFFFF0000 write-protect
[    0.000000]   4 base 0FFF20000 mask FFFFF0000 write-protect
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 0000000000001000 - 0000000000006000 (usable) ==> (reserved)
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000001000 (usable)
[    0.000000]  modified: 0000000000001000 - 0000000000006000 (reserved)
[    0.000000]  modified: 0000000000006000 - 000000000008f000 (usable)
[    0.000000]  modified: 000000000008f000 - 0000000000090000 (reserved)
[    0.000000]  modified: 0000000000090000 - 000000000009c800 (usable)
[    0.000000]  modified: 000000000009c800 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 000000003ee98000 (usable)
[    0.000000]  modified: 000000003ee98000 - 000000003eebf000 (reserved)
[    0.000000]  modified: 000000003eebf000 - 000000003ef47000 (usable)
[    0.000000]  modified: 000000003ef47000 - 000000003efbf000 (ACPI NVS)
[    0.000000]  modified: 000000003efbf000 - 000000003eff1000 (usable)
[    0.000000]  modified: 000000003eff1000 - 000000003efff000 (ACPI data)
[    0.000000]  modified: 000000003efff000 - 000000003f000000 (usable)
[    0.000000]  modified: 000000003f000000 - 0000000040000000 (reserved)
[    0.000000]  modified: 00000000f8000000 - 00000000fc000000 (reserved)
[    0.000000]  modified: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] init_memory_mapping: 0000000000000000-000000003f000000
[    0.000000] NX (Execute Disable) protection: active
[    0.000000]  0000000000 - 003f000000 page 2M
[    0.000000] kernel direct mapping tables up to 3f000000 @ 8000-a000
[    0.000000] RAMDISK: 2eb40000 - 2f331b3e
[    0.000000] ACPI: RSDP 00000000000f2060 00024 (v02 INTEL )
[    0.000000] ACPI: XSDT 000000003effe120 0004C (v01 INTEL  D525MW   0000004E      01000013)
[    0.000000] ACPI: FACP 000000003effd000 000F4 (v03 INTEL  D525MW   0000004E MSFT 0100000D)
[    0.000000] ACPI: DSDT 000000003eff9000 03796 (v01 INTEL  D525MW   0000004E MSFT 0100000D)
[    0.000000] ACPI: FACS 000000003ef87000 00040
[    0.000000] ACPI: APIC 000000003eff8000 00084 (v02 INTEL  D525MW   0000004E MSFT 0100000D)
[    0.000000] ACPI: MCFG 000000003eff7000 0003C (v01 INTEL  D525MW   0000004E MSFT 0100000D)
[    0.000000] ACPI: HPET 000000003eff6000 00038 (v01 INTEL  D525MW   0000004E MSFT 0100000D)
[    0.000000] ACPI: SSDT 000000003eff2000 0377C (v01 INTEL  D525MW   0000004E MSFT 0100000D)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000003f000000
[    0.000000] Bootmem setup node 0 0000000000000000-000000003f000000
[    0.000000]   NODE_DATA [0000000000008000 - 000000000000cfff]
[    0.000000]   bootmap [000000000000d000 -  0000000000014dff] pages 8
[    0.000000] (6 early reservations) ==> bootmem [0000000000 - 003f000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0001000000 - 0001a29e64]    TEXT DATA BSS ==> [0001000000 - 0001a29e64]
[    0.000000]   #3 [002eb40000 - 002f331b3e]          RAMDISK ==> [002eb40000 - 002f331b3e]
[    0.000000]   #4 [000009c800 - 0000100000]    BIOS reserved ==> [000009c800 - 0000100000]
[    0.000000]   #5 [0001a2a000 - 0001a2a19e]              BRK ==> [0001a2a000 - 0001a2a19e]
[    0.000000] found SMP MP-table at [ffff8800000fbe70] fbe70
[    0.000000]  [ffffea0000000000-ffffea0000dfffff] PMD -> [ffff880002000000-ffff880002dfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00100000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[7] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00000001
[    0.000000]     0: 0x00000006 -> 0x0000008f
[    0.000000]     0: 0x00000090 -> 0x0000009c
[    0.000000]     0: 0x00000100 -> 0x0003ee98
[    0.000000]     0: 0x0003eebf -> 0x0003ef47
[    0.000000]     0: 0x0003efbf -> 0x0003eff1
[    0.000000]     0: 0x0003efff -> 0x0003f000
[    0.000000] On node 0 totalpages: 257769
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 102 pages reserved
[    0.000000]   DMA zone: 3832 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3472 pages used for memmap
[    0.000000]   DMA32 zone: 250307 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high level lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high level lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x08] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 0000000000001000 - 0000000000006000
[    0.000000] PM: Registered nosave memory: 000000000008f000 - 0000000000090000
[    0.000000] PM: Registered nosave memory: 000000000009c000 - 000000000009d000
[    0.000000] PM: Registered nosave memory: 000000000009d000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000003ee98000 - 000000003eebf000
[    0.000000] PM: Registered nosave memory: 000000003ef47000 - 000000003efbf000
[    0.000000] PM: Registered nosave memory: 000000003eff1000 - 000000003efff000
[    0.000000] Allocating PCI resources starting at 40000000 (gap: 40000000:b8000000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff880001c00000 s91544 r8192 d23144 u524288
[    0.000000] pcpu-alloc: s91544 r8192 d23144 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 254139
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-2.6.32-21-generic root=UUID=4091bfa7-5a4a-45c4-8b6f-a364fdce5a47 ro quiet nomodeset text
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 997568k/1032192k available (5409k kernel code, 1116k absent, 33508k reserved, 2976k data, 876k init)
[    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:4352 nr_irqs:440
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 10485760 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1799.930 MHz processor.
[    0.010012] Calibrating delay loop (skipped), value calculated using timer frequency.. 3599.86 BogoMIPS (lpj=17999300)
[    0.010075] Security Framework initialized
[    0.010116] AppArmor: AppArmor initialized
[    0.010389] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.011295] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.011705] Mount-cache hash table entries: 256
[    0.012011] Initializing cgroup subsys ns
[    0.012022] Initializing cgroup subsys cpuacct
[    0.012032] Initializing cgroup subsys memory
[    0.012048] Initializing cgroup subsys devices
[    0.012054] Initializing cgroup subsys freezer
[    0.012060] Initializing cgroup subsys net_cls
[    0.012102] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.012109] CPU: L2 cache: 512K
[    0.012116] CPU 0/0x0 -> Node 0
[    0.012120] CPU: Physical Processor ID: 0
[    0.012125] CPU: Processor Core ID: 0
[    0.012131] mce: CPU supports 5 MCE banks
[    0.012145] CPU0: Thermal monitoring enabled (TM1)
[    0.012154] using mwait in idle threads.
[    0.012159] Performance Events: Atom events, Intel PMU driver.
[    0.012172] ... version:                3
[    0.012176] ... bit width:              40
[    0.012180] ... generic registers:      2
[    0.012185] ... value mask:             000000ffffffffff
[    0.012190] ... max period:             000000007fffffff
[    0.012194] ... fixed-purpose events:   3
[    0.012199] ... event mask:             0000000700000003
[    0.020473] ACPI: Core revision 20090903
[    0.045502] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.045513] ftrace: allocating 22518 entries in 89 pages
[    0.050117] Setting APIC routing to flat
[    0.050511] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.159362] CPU0: Intel(R) Atom(TM) CPU D525   @ 1.80GHz stepping 0a
[    0.160000] Booting processor 1 APIC 0x1 ip 0x6000
[    0.020000] Initializing CPU#1
[    0.020000] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.020000] CPU: L2 cache: 512K
[    0.020000] CPU 1/0x1 -> Node 0
[    0.020000] CPU: Physical Processor ID: 0
[    0.020000] CPU: Processor Core ID: 0
[    0.020000] CPU1: Thermal monitoring enabled (TM1)
[    0.310094] CPU1: Intel(R) Atom(TM) CPU D525   @ 1.80GHz stepping 0a
[    0.310110] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.320239] Booting processor 2 APIC 0x2 ip 0x6000
[    0.020000] Initializing CPU#2
[    0.020000] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.020000] CPU: L2 cache: 512K
[    0.020000] CPU 2/0x2 -> Node 0
[    0.020000] CPU: Physical Processor ID: 0
[    0.020000] CPU: Processor Core ID: 1
[    0.020000] CPU2: Thermal monitoring enabled (TM1)
[    0.480106] CPU2: Intel(R) Atom(TM) CPU D525   @ 1.80GHz stepping 0a
[    0.480119] checking TSC synchronization [CPU#0 -> CPU#2]: passed.
[    0.490180] Booting processor 3 APIC 0x3 ip 0x6000
[    0.020000] Initializing CPU#3
[    0.020000] CPU: L1 I cache: 32K, L1 D cache: 24K
[    0.020000] CPU: L2 cache: 512K
[    0.020000] CPU 3/0x3 -> Node 0
[    0.020000] CPU: Physical Processor ID: 0
[    0.020000] CPU: Processor Core ID: 1
[    0.020000] CPU3: Thermal monitoring enabled (TM1)
[    0.650071] CPU3: Intel(R) Atom(TM) CPU D525   @ 1.80GHz stepping 0a
[    0.650086] checking TSC synchronization [CPU#0 -> CPU#3]: passed.
[    0.660026] Brought up 4 CPUs
[    0.660032] Total of 4 processors activated (14400.32 BogoMIPS).
[    0.661297] CPU0 attaching sched-domain:
[    0.661306]  domain 0: span 0-1 level SIBLING
[    0.661311]   groups: 0 (cpu_power = 589) 1 (cpu_power = 589)
[    0.661323]   domain 1: span 0-1 level MC
[    0.661328]    groups: 0-1 (cpu_power = 1178)
[    0.661337]    domain 2: span 0-3 level CPU
[    0.661342]     groups: 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178)
[    0.661358] CPU1 attaching sched-domain:
[    0.661362]  domain 0: span 0-1 level SIBLING
[    0.661367]   groups: 1 (cpu_power = 589) 0 (cpu_power = 589)
[    0.661378]   domain 1: span 0-1 level MC
[    0.661383]    groups: 0-1 (cpu_power = 1178)
[    0.661391]    domain 2: span 0-3 level CPU
[    0.661396]     groups: 0-1 (cpu_power = 1178) 2-3 (cpu_power = 1178)
[    0.661409] CPU2 attaching sched-domain:
[    0.661413]  domain 0: span 2-3 level SIBLING
[    0.661418]   groups: 2 (cpu_power = 589) 3 (cpu_power = 589)
[    0.661429]   domain 1: span 2-3 level MC
[    0.661434]    groups: 2-3 (cpu_power = 1178)
[    0.661442]    domain 2: span 0-3 level CPU
[    0.661447]     groups: 2-3 (cpu_power = 1178) 0-1 (cpu_power = 1178)
[    0.661459] CPU3 attaching sched-domain:
[    0.661463]  domain 0: span 2-3 level SIBLING
[    0.661468]   groups: 3 (cpu_power = 589) 2 (cpu_power = 589)
[    0.661479]   domain 1: span 2-3 level MC
[    0.661484]    groups: 2-3 (cpu_power = 1178)
[    0.661492]    domain 2: span 0-3 level CPU
[    0.661497]     groups: 2-3 (cpu_power = 1178) 0-1 (cpu_power = 1178)
[    0.661887] devtmpfs: initialized
[    0.661887] regulator: core version 0.5
[    0.661887] Time: 16:26:02  Date: 06/30/11
[    0.661887] NET: Registered protocol family 16
[    0.661887] Trying to unpack rootfs image as initramfs...
[    0.661887] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.661887] ACPI: bus type pci registered
[    0.661887] PCI: MCFG configuration 0: base f8000000 segment 0 buses 0 - 63
[    0.661887] PCI: MCFG area at f8000000 reserved in E820
[    0.665227] PCI: Using MMCONFIG at f8000000 - fbffffff
[    0.665231] PCI: Using configuration type 1 for base access
[    0.670113] bio: create slab <bio-0> at 0
[    0.671192] ACPI: EC: Look up EC in DSDT
[    0.683502] ACPI: BIOS _OSI(Linux) query ignored
[    0.684727] ACPI: Interpreter enabled
[    0.684737] ACPI: (supports S0 S1 S3 S4 S5)
[    0.684793] ACPI: Using IOAPIC for interrupt routing
[    0.693989] ACPI: No dock devices found.
[    0.694388] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.694532] pci 0000:00:02.0: reg 10 32bit mmio: [0xf0300000-0xf037ffff]
[    0.694542] pci 0000:00:02.0: reg 14 io port: [0x30c0-0x30c7]
[    0.694550] pci 0000:00:02.0: reg 18 32bit mmio pref: [0xe0000000-0xefffffff]
[    0.694558] pci 0000:00:02.0: reg 1c 32bit mmio: [0xf0200000-0xf02fffff]
[    0.694687] pci 0000:00:1b.0: reg 10 64bit mmio: [0xf0380000-0xf0383fff]
[    0.694755] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.694764] pci 0000:00:1b.0: PME# disabled
[    0.694872] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.694880] pci 0000:00:1c.0: PME# disabled
[    0.694980] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.694987] pci 0000:00:1c.1: PME# disabled
[    0.695090] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    0.695097] pci 0000:00:1c.2: PME# disabled
[    0.695195] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    0.695203] pci 0000:00:1c.3: PME# disabled
[    0.695291] pci 0000:00:1d.0: reg 20 io port: [0x3080-0x309f]
[    0.695372] pci 0000:00:1d.1: reg 20 io port: [0x3060-0x307f]
[    0.695448] pci 0000:00:1d.2: reg 20 io port: [0x3040-0x305f]
[    0.695547] pci 0000:00:1d.3: reg 20 io port: [0x3020-0x303f]
[    0.695641] pci 0000:00:1d.7: reg 10 32bit mmio: [0xf0384400-0xf03847ff]
[    0.695715] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.695723] pci 0000:00:1d.7: PME# disabled
[    0.695973] pci 0000:00:1f.2: reg 10 io port: [0x30b8-0x30bf]
[    0.695984] pci 0000:00:1f.2: reg 14 io port: [0x30cc-0x30cf]
[    0.695995] pci 0000:00:1f.2: reg 18 io port: [0x30b0-0x30b7]
[    0.696005] pci 0000:00:1f.2: reg 1c io port: [0x30c8-0x30cb]
[    0.696016] pci 0000:00:1f.2: reg 20 io port: [0x30a0-0x30af]
[    0.696027] pci 0000:00:1f.2: reg 24 32bit mmio: [0xf0384000-0xf03843ff]
[    0.696067] pci 0000:00:1f.2: PME# supported from D3hot
[    0.696073] pci 0000:00:1f.2: PME# disabled
[    0.696142] pci 0000:00:1f.3: reg 20 io port: [0x3000-0x301f]
[    0.696252] pci 0000:01:00.0: reg 10 io port: [0x2000-0x20ff]
[    0.696283] pci 0000:01:00.0: reg 18 64bit mmio pref: [0xf0004000-0xf0004fff]
[    0.696305] pci 0000:01:00.0: reg 20 64bit mmio pref: [0xf0000000-0xf0003fff]
[    0.696370] pci 0000:01:00.0: supports D1 D2
[    0.696375] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.696384] pci 0000:01:00.0: PME# disabled
[    0.696489] pci 0000:00:1c.0: bridge io port: [0x2000-0x2fff]
[    0.696503] pci 0000:00:1c.0: bridge 64bit mmio pref: [0xf0000000-0xf00fffff]
[    0.696817] pci 0000:05:00.0: reg 10 64bit mmio: [0xf0108000-0xf010807f]
[    0.696836] pci 0000:05:00.0: reg 18 64bit mmio: [0xf0100000-0xf0107fff]
[    0.696848] pci 0000:05:00.0: reg 20 io port: [0x1000-0x100f]
[    0.696867] pci 0000:05:00.0: reg 30 32bit mmio pref: [0xfff80000-0xffffffff]
[    0.696905] pci 0000:05:00.0: supports D1 D2
[    0.696982] pci 0000:00:1e.0: transparent bridge
[    0.696990] pci 0000:00:1e.0: bridge io port: [0x1000-0x1fff]
[    0.696998] pci 0000:00:1e.0: bridge 32bit mmio: [0xf0100000-0xf01fffff]
[    0.697043] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.697404] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
[    0.697631] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
[    0.697781] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX1._PRT]
[    0.697931] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
[    0.698081] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
[    0.707426] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
[    0.707661] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.707893] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12)
[    0.708125] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
[    0.708353] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 *10 11 12)
[    0.708584] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0, disabled.
[    0.708813] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
[    0.709042] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
[    0.709286] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.709311] vgaarb: loaded
[    0.709566] SCSI subsystem initialized
[    0.709664] libata version 3.00 loaded.
[    0.710080] usbcore: registered new interface driver usbfs
[    0.710115] usbcore: registered new interface driver hub
[    0.710163] usbcore: registered new device driver usb
[    0.710181] ACPI: WMI: Mapper loaded
[    0.710181] PCI: Using ACPI for IRQ routing
[    0.710424] NetLabel: Initializing
[    0.710429] NetLabel:  domain hash size = 128
[    0.710433] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.710459] NetLabel:  unlabeled traffic allowed by default
[    0.710557] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.710568] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.740051] Switching to clocksource tsc
[    0.745755] AppArmor: AppArmor Filesystem Enabled
[    0.745810] pnp: PnP ACPI init
[    0.745855] ACPI: bus type pnp registered
[    0.751957] pnp: PnP ACPI: found 13 devices
[    0.751965] ACPI: ACPI bus type pnp unregistered
[    0.751999] system 00:01: iomem range 0xf8000000-0xfbffffff has been reserved
[    0.752009] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
[    0.752019] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
[    0.752028] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
[    0.752038] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.752047] system 00:01: iomem range 0xc0000-0xdffff has been reserved
[    0.752056] system 00:01: iomem range 0xe0000-0xfffff could not be reserved
[    0.752066] system 00:01: iomem range 0xfff00000-0xffffffff has been reserved
[    0.752089] system 00:06: ioport range 0x500-0x53f has been reserved
[    0.752098] system 00:06: ioport range 0x400-0x47f has been reserved
[    0.752107] system 00:06: ioport range 0x680-0x6ff has been reserved
[    0.752116] system 00:06: ioport range 0x295-0x296 has been reserved
[    0.757264] pci 0000:05:00.0: BAR 6: address space collision on of device [0xfff80000-0xffffffff]
[    0.757372] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:01
[    0.757381] pci 0000:00:1c.0:   IO window: 0x2000-0x2fff
[    0.757393] pci 0000:00:1c.0:   MEM window: 0x40000000-0x403fffff
[    0.757404] pci 0000:00:1c.0:   PREFETCH window: 0x000000f0000000-0x000000f00fffff
[    0.757418] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:02
[    0.757426] pci 0000:00:1c.1:   IO window: 0x4000-0x4fff
[    0.757438] pci 0000:00:1c.1:   MEM window: 0x40400000-0x405fffff
[    0.757449] pci 0000:00:1c.1:   PREFETCH window: 0x00000040600000-0x000000407fffff
[    0.757462] pci 0000:00:1c.2: PCI bridge, secondary bus 0000:03
[    0.757471] pci 0000:00:1c.2:   IO window: 0x5000-0x5fff
[    0.757482] pci 0000:00:1c.2:   MEM window: 0x40800000-0x409fffff
[    0.757493] pci 0000:00:1c.2:   PREFETCH window: 0x00000040a00000-0x00000040bfffff
[    0.757507] pci 0000:00:1c.3: PCI bridge, secondary bus 0000:04
[    0.757515] pci 0000:00:1c.3:   IO window: 0x6000-0x6fff
[    0.757526] pci 0000:00:1c.3:   MEM window: 0x40c00000-0x40dfffff
[    0.757537] pci 0000:00:1c.3:   PREFETCH window: 0x00000040e00000-0x00000040ffffff
[    0.757554] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:05
[    0.757563] pci 0000:00:1e.0:   IO window: 0x1000-0x1fff
[    0.757575] pci 0000:00:1e.0:   MEM window: 0xf0100000-0xf01fffff
[    0.757587] pci 0000:00:1e.0:   PREFETCH window: 0x41000000-0x410fffff
[    0.757624]   alloc irq_desc for 17 on node -1
[    0.757631]   alloc kstat_irqs on node -1
[    0.757649] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.757663] pci 0000:00:1c.0: setting latency timer to 64
[    0.757683] pci 0000:00:1c.1: enabling device (0000 -> 0003)
[    0.757694]   alloc irq_desc for 16 on node -1
[    0.757700]   alloc kstat_irqs on node -1
[    0.757713] pci 0000:00:1c.1: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.757727] pci 0000:00:1c.1: setting latency timer to 64
[    0.757747] pci 0000:00:1c.2: enabling device (0000 -> 0003)
[    0.757757]   alloc irq_desc for 18 on node -1
[    0.757763]   alloc kstat_irqs on node -1
[    0.757775] pci 0000:00:1c.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.757787] pci 0000:00:1c.2: setting latency timer to 64
[    0.757804] pci 0000:00:1c.3: enabling device (0000 -> 0003)
[    0.757814]   alloc irq_desc for 19 on node -1
[    0.757820]   alloc kstat_irqs on node -1
[    0.757830] pci 0000:00:1c.3: PCI INT D -> GSI 19 (level, low) -> IRQ 19
[    0.757843] pci 0000:00:1c.3: setting latency timer to 64
[    0.757858] pci 0000:00:1e.0: setting latency timer to 64
[    0.757869] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.757877] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.757886] pci_bus 0000:01: resource 0 io:  [0x2000-0x2fff]
[    0.757893] pci_bus 0000:01: resource 1 mem: [0x40000000-0x403fffff]
[    0.757901] pci_bus 0000:01: resource 2 pref mem [0xf0000000-0xf00fffff]
[    0.757910] pci_bus 0000:02: resource 0 io:  [0x4000-0x4fff]
[    0.757917] pci_bus 0000:02: resource 1 mem: [0x40400000-0x405fffff]
[    0.757925] pci_bus 0000:02: resource 2 pref mem [0x40600000-0x407fffff]
[    0.757933] pci_bus 0000:03: resource 0 io:  [0x5000-0x5fff]
[    0.757941] pci_bus 0000:03: resource 1 mem: [0x40800000-0x409fffff]
[    0.757949] pci_bus 0000:03: resource 2 pref mem [0x40a00000-0x40bfffff]
[    0.757957] pci_bus 0000:04: resource 0 io:  [0x6000-0x6fff]
[    0.757964] pci_bus 0000:04: resource 1 mem: [0x40c00000-0x40dfffff]
[    0.757972] pci_bus 0000:04: resource 2 pref mem [0x40e00000-0x40ffffff]
[    0.757980] pci_bus 0000:05: resource 0 io:  [0x1000-0x1fff]
[    0.757988] pci_bus 0000:05: resource 1 mem: [0xf0100000-0xf01fffff]
[    0.757996] pci_bus 0000:05: resource 2 pref mem [0x41000000-0x410fffff]
[    0.758003] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
[    0.758011] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.758106] NET: Registered protocol family 2
[    0.758441] IP route cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.759916] TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
[    0.761787] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.762486] TCP: Hash tables configured (established 131072 bind 65536)
[    0.762496] TCP reno registered
[    0.762817] NET: Registered protocol family 1
[    0.762873] pci 0000:00:02.0: Boot video device
[    0.780390] Scanning for low memory corruption every 60 seconds
[    0.780787] audit: initializing netlink socket (disabled)
[    0.780813] type=2000 audit(1309451161.779:1): initialized
[    0.799307] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.804122] VFS: Disk quotas dquot_6.5.2
[    0.804317] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.806404] fuse init (API version 7.13)
[    0.806706] msgmni has been set to 1948
[    0.807474] alg: No test for stdrng (krng)
[    0.807670] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.807681] io scheduler noop registered
[    0.807687] io scheduler anticipatory registered
[    0.807692] io scheduler deadline registered
[    0.807808] io scheduler cfq registered (default)
[    0.808155]   alloc irq_desc for 24 on node -1
[    0.808162]   alloc kstat_irqs on node -1
[    0.808184] pcieport 0000:00:1c.0: irq 24 for MSI/MSI-X
[    0.808204] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.808472]   alloc irq_desc for 25 on node -1
[    0.808478]   alloc kstat_irqs on node -1
[    0.808497] pcieport 0000:00:1c.1: irq 25 for MSI/MSI-X
[    0.808514] pcieport 0000:00:1c.1: setting latency timer to 64
[    0.808767]   alloc irq_desc for 26 on node -1
[    0.808774]   alloc kstat_irqs on node -1
[    0.808791] pcieport 0000:00:1c.2: irq 26 for MSI/MSI-X
[    0.808808] pcieport 0000:00:1c.2: setting latency timer to 64
[    0.809095]   alloc irq_desc for 27 on node -1
[    0.809102]   alloc kstat_irqs on node -1
[    0.809121] pcieport 0000:00:1c.3: irq 27 for MSI/MSI-X
[    0.809139] pcieport 0000:00:1c.3: setting latency timer to 64
[    0.809391] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.809707] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.809958] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    0.809977] ACPI: Sleep Button [SLPB]
[    0.810132] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.810141] ACPI: Power Button [PWRF]
[    0.812256] Monitor-Mwait will be used to enter C-1 state
[    0.812342] processor LNXCPU:00: registered as cooling_device0
[    0.813666] processor LNXCPU:01: registered as cooling_device1
[    0.815089] processor LNXCPU:02: registered as cooling_device2
[    0.817193] processor LNXCPU:03: registered as cooling_device3
[    0.823337] Linux agpgart interface v0.103
[    0.823416] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.823573] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.823736] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.824241] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.824462] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.826893] brd: module loaded
[    0.828050] loop: module loaded
[    0.828286] input: Macintosh mouse button emulation as /devices/virtual/input/input2
[    0.829238] Fixed MDIO Bus: probed
[    0.829479] PPP generic driver version 2.4.2
[    0.829589] tun: Universal TUN/TAP device driver, 1.6
[    0.829594] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.829786] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.829835]   alloc irq_desc for 23 on node -1
[    0.829840]   alloc kstat_irqs on node -1
[    0.829853] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.829884] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    0.829891] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    0.829982] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
[    0.830016] ehci_hcd 0000:00:1d.7: using broken periodic workaround
[    0.830033] ehci_hcd 0000:00:1d.7: debug port 1
[    0.833912] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    0.833943] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf0384400
[    0.849299] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.849494] usb usb1: configuration #1 chosen from 1 choice
[    0.849558] hub 1-0:1.0: USB hub found
[    0.849575] hub 1-0:1.0: 8 ports detected
[    0.849710] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.849743] uhci_hcd: USB Universal Host Controller Interface driver
[    0.849807] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.849821] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    0.849828] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.849915] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    0.849954] uhci_hcd 0000:00:1d.0: irq 23, io base 0x00003080
[    0.850156] usb usb2: configuration #1 chosen from 1 choice
[    0.850219] hub 2-0:1.0: USB hub found
[    0.850235] hub 2-0:1.0: 2 ports detected
[    0.850333] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.850347] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    0.850353] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.850434] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
[    0.850492] uhci_hcd 0000:00:1d.1: irq 19, io base 0x00003060
[    0.850695] usb usb3: configuration #1 chosen from 1 choice
[    0.850756] hub 3-0:1.0: USB hub found
[    0.850772] hub 3-0:1.0: 2 ports detected
[    0.850870] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.850882] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    0.850889] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.850972] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
[    0.851019] uhci_hcd 0000:00:1d.2: irq 18, io base 0x00003040
[    0.851240] usb usb4: configuration #1 chosen from 1 choice
[    0.851302] hub 4-0:1.0: USB hub found
[    0.851318] hub 4-0:1.0: 2 ports detected
[    0.851416] uhci_hcd 0000:00:1d.3: PCI INT D -> GSI 16 (level, low) -> IRQ 16
[    0.851428] uhci_hcd 0000:00:1d.3: setting latency timer to 64
[    0.851435] uhci_hcd 0000:00:1d.3: UHCI Host Controller
[    0.851522] uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
[    0.851578] uhci_hcd 0000:00:1d.3: irq 16, io base 0x00003020
[    0.851784] usb usb5: configuration #1 chosen from 1 choice
[    0.851846] hub 5-0:1.0: USB hub found
[    0.851861] hub 5-0:1.0: 2 ports detected
[    0.852066] PNP: No PS/2 controller found. Probing ports directly.
[    0.855200] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.855217] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.855436] mice: PS/2 mouse device common for all mice
[    0.855672] rtc_cmos 00:03: RTC can wake from S4
[    0.855765] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.855807] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.856107] device-mapper: uevent: version 1.0.3
[    0.856390] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[    0.856717] device-mapper: multipath: version 1.1.0 loaded
[    0.856724] device-mapper: multipath round-robin: version 1.0.0 loaded
[    0.857373] cpuidle: using governor ladder
[    0.857378] cpuidle: using governor menu
[    0.858141] TCP cubic registered
[    0.858464] NET: Registered protocol family 10
[    0.859531] lo: Disabled Privacy Extensions
[    0.860143] NET: Registered protocol family 17
[    0.860923] ACPI Exception: AE_NOT_FOUND, Evaluating _PSS (20090903/processor_perflib-264)
[    0.860998] ACPI Exception: AE_NOT_FOUND, Evaluating _PSS (20090903/processor_perflib-264)
[    0.861068] ACPI Exception: AE_NOT_FOUND, Evaluating _PSS (20090903/processor_perflib-264)
[    0.861138] ACPI Exception: AE_NOT_FOUND, Evaluating _PSS (20090903/processor_perflib-264)
[    0.861356] PM: Resume from disk failed.
[    0.861381] registered taskstats version 1
[    0.861941]   Magic number: 15:326:440
[    0.862016] pcieport 0000:00:1c.1: hash matches
[    0.862082] rtc_cmos 00:03: setting system clock to 2011-06-30 16:26:02 UTC (1309451162)
[    0.862089] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    0.862093] EDD information not available.
[    1.032580] Freeing initrd memory: 8134k freed
[    1.038080] Freeing unused kernel memory: 876k freed
[    1.038484] Write protecting the kernel read-only data: 7680k
[    1.075712] udev: starting version 151
[    1.148143] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    1.148194] r8169 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.148272] r8169 0000:01:00.0: setting latency timer to 64
[    1.148286] r8169 0000:01:00.0: unknown MAC, using family default
[    1.148365]   alloc irq_desc for 28 on node -1
[    1.148372]   alloc kstat_irqs on node -1
[    1.148403] r8169 0000:01:00.0: irq 28 for MSI/MSI-X
[    1.150141] eth0: RTL8168b/8111b at 0xffffc900001f6000, 70:71:bc:cc:e8:37, XID 0c200000 IRQ 28
[    1.203136] sata_sil24 0000:05:00.0: version 1.1
[    1.203177]   alloc irq_desc for 20 on node -1
[    1.203186]   alloc kstat_irqs on node -1
[    1.203205] sata_sil24 0000:05:00.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    1.220752] scsi0 : sata_sil24
[    1.221356] ahci 0000:00:1f.2: version 3.0
[    1.221395] ahci 0000:00:1f.2: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    1.221484]   alloc irq_desc for 29 on node -1
[    1.221492]   alloc kstat_irqs on node -1
[    1.221518] ahci 0000:00:1f.2: irq 29 for MSI/MSI-X
[    1.221598] ahci: SSS flag set, parallel bus scan disabled
[    1.221655] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0x3 impl SATA mode
[    1.221667] ahci 0000:00:1f.2: flags: 64bit ncq stag pm led clo pio slum part 
[    1.221681] ahci 0000:00:1f.2: setting latency timer to 64
[    1.221903] scsi1 : sata_sil24
[    1.222240] scsi2 : ahci
[    1.222410] scsi3 : sata_sil24
[    1.222576] scsi4 : ahci
[    1.222945] scsi5 : ahci
[    1.222957] scsi6 : sata_sil24
[    1.223160] ata1: SATA max UDMA/100 host m128@0xf0108000 port 0xf0100000 irq 20
[    1.223173] ata2: SATA max UDMA/100 host m128@0xf0108000 port 0xf0102000 irq 20
[    1.223184] ata3: SATA max UDMA/100 host m128@0xf0108000 port 0xf0104000 irq 20
[    1.223195] ata4: SATA max UDMA/100 host m128@0xf0108000 port 0xf0106000 irq 20
[    1.223457] scsi7 : ahci
[    1.224040] ata5: SATA max UDMA/133 abar m1024@0xf0384000 port 0xf0384100 irq 29
[    1.224052] ata6: SATA max UDMA/133 abar m1024@0xf0384000 port 0xf0384180 irq 29
[    1.224060] ata7: DUMMY
[    1.224064] ata8: DUMMY
[    1.400033] usb 5-1: new low speed USB device using uhci_hcd and address 2
[    1.570039] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.573889] usb 5-1: configuration #1 chosen from 1 choice
[    1.575809] ata5.00: ATA-8: SAMSUNG HD103SJ, 1AJ100E5, max UDMA/133
[    1.575820] ata5.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    1.581679] ata5.00: configured for UDMA/133
[    1.613318] usbcore: registered new interface driver hiddev
[    1.627277] input: USB CAT5 as /devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.0/input/input3
[    1.627620] generic-usb 0003:0D3D:0040.0001: input,hidraw0: USB HID v1.00 Keyboard [USB CAT5] on usb-0000:00:1d.3-1/input0
[    1.643201] input: USB CAT5 as /devices/pci0000:00/0000:00:1d.3/usb5/5-1/5-1:1.1/input/input4
[    1.643656] generic-usb 0003:0D3D:0040.0002: input,hidraw1: USB HID v1.00 Mouse [USB CAT5] on usb-0000:00:1d.3-1/input1
[    1.643718] usbcore: registered new interface driver usbhid
[    1.643812] usbhid: v2.6:USB HID core driver
[    3.440046] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
[    3.440365] ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x1/0x9
[    3.440691] ata1.00: hard resetting link
[    3.790423] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[    3.790468] ata1.01: hard resetting link
[    4.140414] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.140458] ata1.02: hard resetting link
[    4.490411] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.490455] ata1.03: hard resetting link
[    4.840412] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.840456] ata1.04: hard resetting link
[    5.190412] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.190456] ata1.05: hard resetting link
[    5.540423] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
[    5.546901] ata1.00: ATA-7: SAMSUNG HD154UI, 1AG01118, max UDMA7
[    5.546909] ata1.00: 2930277168 sectors, multi 16: LBA48 NCQ (depth 31/32)
[    5.553492] ata1.00: configured for UDMA/100
[    5.557739] ata1.01: ATA-8: WDC WD30EZRS-00J99B0, 80.00A80, max UDMA/133
[    5.557746] ata1.01: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    5.562773] ata1.01: configured for UDMA/100
[    5.606008] ata1.02: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
[    5.606014] ata1.02: 312581808 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    5.664350] ata1.02: configured for UDMA/100
[    5.668688] ata1.03: ATA-8: WDC WD30EZRX-00MMMB0, 80.00A80, max UDMA/133
[    5.668695] ata1.03: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    5.673712] ata1.03: configured for UDMA/100
[    5.674959] ata1.04: ATA-8: ST320005XXXX, CC34, max UDMA/133
[    5.674966] ata1.04: 3907029168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    5.676421] ata1.04: configured for UDMA/100
[    5.676506] ata1: EH complete
[    5.676720] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD154UI  1AG0 PQ: 0 ANSI: 5
[    5.677246] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.677299] sd 0:0:0:0: [sda] 2930277168 512-byte logical blocks: (1.50 TB/1.36 TiB)
[    5.677437] sd 0:0:0:0: [sda] Write Protect is off
[    5.677444] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.677519] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.677739] scsi 0:1:0:0: Direct-Access     ATA      WDC WD30EZRS-00J 80.0 PQ: 0 ANSI: 5
[    5.677904]  sda:
[    5.678115] sd 0:1:0:0: Attached scsi generic sg1 type 0
[    5.678169] sd 0:1:0:0: [sdb] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    5.678176] sd 0:1:0:0: [sdb] 4096-byte physical blocks
[    5.678316] sd 0:1:0:0: [sdb] Write Protect is off
[    5.678324] sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
[    5.678393] sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.678640] scsi 0:2:0:0: Direct-Access     ATA      ST3160815AS      4.AA PQ: 0 ANSI: 5
[    5.678766]  sdb:
[    5.679070] sd 0:2:0:0: Attached scsi generic sg2 type 0
[    5.679094] sd 0:2:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    5.679229] sd 0:2:0:0: [sdc] Write Protect is off
[    5.679236] sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
[    5.679309] sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.679596] scsi 0:3:0:0: Direct-Access     ATA      WDC WD30EZRX-00M 80.0 PQ: 0 ANSI: 5
[    5.679689]  sdc:
[    5.680191] sd 0:3:0:0: [sdd] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
[    5.680198] sd 0:3:0:0: [sdd] 4096-byte physical blocks
[    5.680322] sd 0:3:0:0: Attached scsi generic sg3 type 0
[    5.680333] sd 0:3:0:0: [sdd] Write Protect is off
[    5.680340] sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
[    5.680411] sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.680692] scsi 0:4:0:0: Direct-Access     ATA      ST320005XXXX     CC34 PQ: 0 ANSI: 5
[    5.680800]  sdd:
[    5.681284] sd 0:4:0:0: [sde] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
[    5.681412] sd 0:4:0:0: Attached scsi generic sg4 type 0
[    5.681421] sd 0:4:0:0: [sde] Write Protect is off
[    5.681433] sd 0:4:0:0: [sde] Mode Sense: 00 3a 00 00
[    5.681510] sd 0:4:0:0: [sde] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.682021]  sde: sda1
[    5.688373] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.705952]  sde1
[    5.706920] sd 0:4:0:0: [sde] Attached SCSI disk
[    5.712379]  sdc1
[    5.713104] sd 0:2:0:0: [sdc] Attached SCSI disk
[    6.153657]  sdd1 sdd2
[    6.154817] sd 0:3:0:0: [sdd] Attached SCSI disk
[    6.271972]  sdb1
[    6.272961] sd 0:1:0:0: [sdb] Attached SCSI disk
[    7.770043] ata2: SATA link down (SStatus 0 SControl 0)
[    9.860042] ata3: SATA link down (SStatus 0 SControl 0)
[   11.950049] ata4: SATA link down (SStatus 0 SControl 0)
[   11.950306] scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD103SJ  1AJ1 PQ: 0 ANSI: 5
[   11.950703] sd 2:0:0:0: [sdf] 1953525168 512-byte logical blocks: (1.00 TB/931 GiB)
[   11.950744] sd 2:0:0:0: Attached scsi generic sg5 type 0
[   11.950874] sd 2:0:0:0: [sdf] Write Protect is off
[   11.950883] sd 2:0:0:0: [sdf] Mode Sense: 00 3a 00 00
[   11.950966] sd 2:0:0:0: [sdf] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   11.951373]  sdf: sdf1 sdf2
[   11.962694] sd 2:0:0:0: [sdf] Attached SCSI disk
[   12.300035] ata6: SATA link down (SStatus 0 SControl 300)
[   12.462166] EXT4-fs (sdf1): INFO: recovery required on readonly filesystem
[   12.462176] EXT4-fs (sdf1): write access will be enabled during recovery
[   12.507173] EXT4-fs (sdf1): recovery complete
[   12.507429] EXT4-fs (sdf1): mounted filesystem with ordered data mode
[   16.095233] udev: starting version 151
[   16.157763] agpgart-intel 0000:00:00.0: Intel IGD Chipset
[   16.158170] agpgart-intel 0000:00:00.0: detected 8188K stolen memory
[   16.174205] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
[   16.175406] lp: driver loaded but no devices found
[   16.325386] [drm] Initialized drm 1.1.0 20060810
[   16.365337] parport_pc 00:08: reported by Plug and Play ACPI
[   16.365408] parport0: PC-style at 0x378, irq 7 [PCSPP]
[   16.442672] type=1505 audit(1309451178.080:2):  operation="profile_load" pid=504 name="/sbin/dhclient3"
[   16.443546] type=1505 audit(1309451178.080:3):  operation="profile_load" pid=504 name="/usr/lib/NetworkManager/nm-dhcp-client.action"
[   16.444103] type=1505 audit(1309451178.080:4):  operation="profile_load" pid=504 name="/usr/lib/connman/scripts/dhclient-script"
[   16.444341] lp0: using parport0 (interrupt-driven).
[   16.477145] type=1505 audit(1309451178.110:5):  operation="profile_load" pid=579 name="/usr/sbin/ntpd"
[   16.638979] pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   16.638992] pci 0000:00:02.0: setting latency timer to 64
[   16.681503] ppdev: user-space parallel port driver
[   16.688167]   alloc irq_desc for 30 on node -1
[   16.688175]   alloc kstat_irqs on node -1
[   16.688197] pci 0000:00:02.0: irq 30 for MSI/MSI-X
[   16.689350] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
[   16.698628] vga16fb: initializing
[   16.698642] vga16fb: mapped to 0xffff8800000a0000
[   16.699123] fb0: VGA16 VGA frame buffer device
[   16.787391] r8169: eth0: link up
[   16.787404] r8169: eth0: link up
[   16.880165] Console: switching to colour frame buffer device 80x30
[   17.133529]   alloc irq_desc for 22 on node -1
[   17.133539]   alloc kstat_irqs on node -1
[   17.133559] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   17.133644] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   17.227825] type=1505 audit(1309451178.860:6):  operation="profile_load" pid=899 name="/usr/share/gdm/guest-session/Xsession"
[   17.231057] type=1505 audit(1309451178.860:7):  operation="profile_replace" pid=900 name="/sbin/dhclient3"
[   17.231678] type=1505 audit(1309451178.860:8):  operation="profile_replace" pid=900 name="/usr/lib/NetworkManager/nm-dhcp-client.action"
[   17.231970] type=1505 audit(1309451178.860:9):  operation="profile_replace" pid=900 name="/usr/lib/connman/scripts/dhclient-script"
[   17.237602] type=1505 audit(1309451178.870:10):  operation="profile_load" pid=901 name="/usr/bin/evince"
[   17.244718] type=1505 audit(1309451178.880:11):  operation="profile_load" pid=901 name="/usr/bin/evince-previewer"
[   17.293714] hda_codec: ALC662 rev1: BIOS auto-probing.
[   17.295479] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input5
[   17.509763] RPC: Registered udp transport module.
[   17.509772] RPC: Registered tcp transport module.
[   17.509778] RPC: Registered tcp NFSv4.1 backchannel transport module.

>From kern.log after turning off bay before patch:

Jun 30 09:27:05 HR-NETSWAP kernel: [   63.691846] ata1.03: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Jun 30 09:27:05 HR-NETSWAP kernel: [   63.703423] ata1.03: SError: { PHYRdyChg DevExch }
Jun 30 09:27:05 HR-NETSWAP kernel: [   63.709248] ata1.03: hard resetting link
Jun 30 09:27:06 HR-NETSWAP kernel: [   64.450399] ata1.03: SATA link down (SStatus 0 SControl 320)
Jun 30 09:27:11 HR-NETSWAP kernel: [   69.450022] ata1.03: hard resetting link
Jun 30 09:27:11 HR-NETSWAP kernel: [   69.800421] ata1.03: SATA link down (SStatus 0 SControl 320)
Jun 30 09:27:11 HR-NETSWAP kernel: [   69.800563] ata1.03: limiting SATA link speed to 1.5 Gbps
Jun 30 09:27:16 HR-NETSWAP kernel: [   74.800066] ata1.03: hard resetting link
Jun 30 09:27:16 HR-NETSWAP kernel: [   75.150392] ata1.03: SATA link down (SStatus 0 SControl 310)
Jun 30 09:27:16 HR-NETSWAP kernel: [   75.150504] ata1.03: disabled
Jun 30 09:27:16 HR-NETSWAP kernel: [   75.150622] ata1: EH complete
Jun 30 09:27:16 HR-NETSWAP kernel: [   75.150632] ata1.03: detaching (SCSI 0:3:0:0)
Jun 30 09:27:16 HR-NETSWAP kernel: [   75.181719] sd 0:3:0:0: [sdd] Synchronizing SCSI cache
Jun 30 09:27:16 HR-NETSWAP kernel: [   75.182940] sd 0:3:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Jun 30 09:27:16 HR-NETSWAP kernel: [   75.182952] sd 0:3:0:0: [sdd] Stopping disk
Jun 30 09:27:16 HR-NETSWAP kernel: [   75.182990] sd 0:3:0:0: [sdd] START_STOP FAILED
Jun 30 09:27:16 HR-NETSWAP kernel: [   75.182997] sd 0:3:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

>From kern.log after turning bay on before patch:

Jun 30 09:28:20 HR-NETSWAP kernel: [  139.105594] ata1.03: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
Jun 30 09:28:20 HR-NETSWAP kernel: [  139.111769] ata1.03: SError: { PHYRdyChg CommWake DevExch }
Jun 30 09:28:20 HR-NETSWAP kernel: [  139.118130] ata1.03: hard resetting link
Jun 30 09:28:21 HR-NETSWAP kernel: [  139.951641] ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Jun 30 09:28:21 HR-NETSWAP kernel: [  139.951747] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
Jun 30 09:28:21 HR-NETSWAP kernel: [  139.951756] ata1.15: hard resetting link
Jun 30 09:28:23 HR-NETSWAP kernel: [  142.170048] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Jun 30 09:28:23 HR-NETSWAP kernel: [  142.170324] ata1.00: hard resetting link
Jun 30 09:28:24 HR-NETSWAP kernel: [  142.521646] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Jun 30 09:28:24 HR-NETSWAP kernel: [  142.521692] ata1.01: hard resetting link
Jun 30 09:28:24 HR-NETSWAP kernel: [  142.871638] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:24 HR-NETSWAP kernel: [  142.871682] ata1.02: hard resetting link
Jun 30 09:28:24 HR-NETSWAP kernel: [  143.220413] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:26 HR-NETSWAP kernel: [  144.950035] ata1.03: hard resetting link
Jun 30 09:28:26 HR-NETSWAP kernel: [  145.300399] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:26 HR-NETSWAP kernel: [  145.300444] ata1.04: hard resetting link
Jun 30 09:28:27 HR-NETSWAP kernel: [  145.650410] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:27 HR-NETSWAP kernel: [  145.650455] ata1.05: hard resetting link
Jun 30 09:28:27 HR-NETSWAP kernel: [  146.000393] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Jun 30 09:28:27 HR-NETSWAP kernel: [  146.013474] ata1.00: configured for UDMA/100
Jun 30 09:28:27 HR-NETSWAP kernel: [  146.022600] ata1.01: configured for UDMA/100
Jun 30 09:28:27 HR-NETSWAP kernel: [  146.129262] ata1.02: configured for UDMA/100
Jun 30 09:28:27 HR-NETSWAP kernel: [  146.129331] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
Jun 30 09:28:27 HR-NETSWAP kernel: [  146.129341] ata1.15: hard resetting link
Jun 30 09:28:29 HR-NETSWAP kernel: [  148.340049] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Jun 30 09:28:29 HR-NETSWAP kernel: [  148.340321] ata1.00: hard resetting link
Jun 30 09:28:30 HR-NETSWAP kernel: [  148.710385] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Jun 30 09:28:30 HR-NETSWAP kernel: [  148.710431] ata1.01: hard resetting link
Jun 30 09:28:30 HR-NETSWAP kernel: [  149.071617] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:30 HR-NETSWAP kernel: [  149.071661] ata1.02: hard resetting link
Jun 30 09:28:31 HR-NETSWAP kernel: [  149.441636] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:31 HR-NETSWAP kernel: [  150.300034] ata1.03: hard resetting link
Jun 30 09:28:32 HR-NETSWAP kernel: [  150.654706] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:32 HR-NETSWAP kernel: [  150.654750] ata1.04: hard resetting link
Jun 30 09:28:32 HR-NETSWAP kernel: [  151.000367] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:32 HR-NETSWAP kernel: [  151.000409] ata1.05: hard resetting link
Jun 30 09:28:32 HR-NETSWAP kernel: [  151.350388] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Jun 30 09:28:33 HR-NETSWAP kernel: [  151.363470] ata1.00: configured for UDMA/100
Jun 30 09:28:33 HR-NETSWAP kernel: [  151.373200] ata1.01: configured for UDMA/100
Jun 30 09:28:33 HR-NETSWAP kernel: [  151.460635] ata1.02: configured for UDMA/100
Jun 30 09:28:33 HR-NETSWAP kernel: [  151.460701] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
Jun 30 09:28:33 HR-NETSWAP kernel: [  151.460709] ata1.03: failed to recover link after 3 tries, disabling
Jun 30 09:28:33 HR-NETSWAP kernel: [  151.460717] ata1.15: hard resetting link
Jun 30 09:28:35 HR-NETSWAP kernel: [  153.684422] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Jun 30 09:28:35 HR-NETSWAP kernel: [  154.034292] ata1.00: hard resetting link
Jun 30 09:28:36 HR-NETSWAP kernel: [  154.380389] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Jun 30 09:28:36 HR-NETSWAP kernel: [  154.380433] ata1.01: hard resetting link
Jun 30 09:28:36 HR-NETSWAP kernel: [  154.734289] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:36 HR-NETSWAP kernel: [  154.734333] ata1.02: hard resetting link
Jun 30 09:28:36 HR-NETSWAP kernel: [  155.070389] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:37 HR-NETSWAP kernel: [  156.000035] ata1.04: hard resetting link
Jun 30 09:28:37 HR-NETSWAP kernel: [  156.354373] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 09:28:37 HR-NETSWAP kernel: [  156.354419] ata1.05: hard resetting link
Jun 30 09:28:38 HR-NETSWAP kernel: [  156.700389] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Jun 30 09:28:38 HR-NETSWAP kernel: [  156.713473] ata1.00: configured for UDMA/100
Jun 30 09:28:38 HR-NETSWAP kernel: [  156.722797] ata1.01: configured for UDMA/100
Jun 30 09:28:38 HR-NETSWAP kernel: [  156.817016] ata1.02: configured for UDMA/100
Jun 30 09:28:38 HR-NETSWAP kernel: [  156.819785] ata1.04: configured for UDMA/100
Jun 30 09:28:38 HR-NETSWAP kernel: [  156.819871] ata1: EH complete

>From kern.log after turning bay off after patch (changed ATA_EH_PMP_LINK_TRIES from 3 to 5):

Jun 30 10:01:56 HR-NETSWAP kernel: [   69.805574] ata1.03: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Jun 30 10:01:56 HR-NETSWAP kernel: [   69.814603] ata1.03: SError: { PHYRdyChg DevExch }
Jun 30 10:01:56 HR-NETSWAP kernel: [   69.823948] ata1.03: hard resetting link
Jun 30 10:01:56 HR-NETSWAP kernel: [   69.823969] ata1.03: XXXX hardreset hotplugged = true
Jun 30 10:01:56 HR-NETSWAP kernel: [   69.823976] ata1.03: XXX0 hardreset debounce 25 500 2000
Jun 30 10:01:56 HR-NETSWAP kernel: [   69.823981] ata1.03: XXX1 hardreset debounce 25 500 2000
Jun 30 10:01:57 HR-NETSWAP kernel: [   70.570402] ata1.03: SATA link down (SStatus 0 SControl 320)
Jun 30 10:02:02 HR-NETSWAP kernel: [   75.570028] ata1.03: hard resetting link
Jun 30 10:02:02 HR-NETSWAP kernel: [   75.570051] ata1.03: XXXX hardreset hotplugged = false
Jun 30 10:02:02 HR-NETSWAP kernel: [   75.570057] ata1.03: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:02 HR-NETSWAP kernel: [   75.570062] ata1.03: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:02 HR-NETSWAP kernel: [   75.921656] ata1.03: SATA link down (SStatus 0 SControl 320)
Jun 30 10:02:02 HR-NETSWAP kernel: [   75.921799] ata1.03: limiting SATA link speed to 1.5 Gbps
Jun 30 10:02:07 HR-NETSWAP kernel: [   80.920028] ata1.03: hard resetting link
Jun 30 10:02:07 HR-NETSWAP kernel: [   80.920050] ata1.03: XXXX hardreset hotplugged = false
Jun 30 10:02:07 HR-NETSWAP kernel: [   80.920056] ata1.03: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:07 HR-NETSWAP kernel: [   80.920062] ata1.03: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:07 HR-NETSWAP kernel: [   81.270394] ata1.03: SATA link down (SStatus 0 SControl 310)
Jun 30 10:02:07 HR-NETSWAP kernel: [   81.270507] ata1.03: disabled
Jun 30 10:02:07 HR-NETSWAP kernel: [   81.270627] ata1: EH complete
Jun 30 10:02:07 HR-NETSWAP kernel: [   81.270638] ata1.03: detaching (SCSI 0:3:0:0)
Jun 30 10:02:07 HR-NETSWAP kernel: [   81.300423] sd 0:3:0:0: [sdd] Synchronizing SCSI cache
Jun 30 10:02:07 HR-NETSWAP kernel: [   81.300587] sd 0:3:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK
Jun 30 10:02:07 HR-NETSWAP kernel: [   81.300601] sd 0:3:0:0: [sdd] Stopping disk
Jun 30 10:02:07 HR-NETSWAP kernel: [   81.300642] sd 0:3:0:0: [sdd] START_STOP FAILED
Jun 30 10:02:07 HR-NETSWAP kernel: [   81.300649] sd 0:3:0:0: [sdd] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK

>From kern.log after turning bay on after patch  (changed ATA_EH_PMP_LINK_TRIES from 3 to 5):

Jun 30 10:02:16 HR-NETSWAP kernel: [   90.353682] ata1.03: exception Emask 0x10 SAct 0x0 SErr 0x4050000 action 0xf
Jun 30 10:02:16 HR-NETSWAP kernel: [   90.365393] ata1.03: SError: { PHYRdyChg CommWake DevExch }
Jun 30 10:02:16 HR-NETSWAP kernel: [   90.377061] ata1.03: hard resetting link
Jun 30 10:02:16 HR-NETSWAP kernel: [   90.377083] ata1.03: XXXX hardreset hotplugged = true
Jun 30 10:02:16 HR-NETSWAP kernel: [   90.377089] ata1.03: XXX0 hardreset debounce 25 500 2000
Jun 30 10:02:16 HR-NETSWAP kernel: [   90.377094] ata1.03: XXX1 hardreset debounce 25 500 2000
Jun 30 10:02:17 HR-NETSWAP kernel: [   91.120398] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Jun 30 10:02:17 HR-NETSWAP kernel: [   91.120506] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
Jun 30 10:02:17 HR-NETSWAP kernel: [   91.120516] ata1.15: hard resetting link
Jun 30 10:02:19 HR-NETSWAP kernel: [   93.340047] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Jun 30 10:02:19 HR-NETSWAP kernel: [   93.340329] ata1.00: hard resetting link
Jun 30 10:02:19 HR-NETSWAP kernel: [   93.340349] ata1.00: XXXX hardreset hotplugged = false
Jun 30 10:02:19 HR-NETSWAP kernel: [   93.340355] ata1.00: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:19 HR-NETSWAP kernel: [   93.340360] ata1.00: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:20 HR-NETSWAP kernel: [   93.690395] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Jun 30 10:02:20 HR-NETSWAP kernel: [   93.690440] ata1.01: hard resetting link
Jun 30 10:02:20 HR-NETSWAP kernel: [   93.690460] ata1.01: XXXX hardreset hotplugged = false
Jun 30 10:02:20 HR-NETSWAP kernel: [   93.690465] ata1.01: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:20 HR-NETSWAP kernel: [   93.690471] ata1.01: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:20 HR-NETSWAP kernel: [   94.040391] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:20 HR-NETSWAP kernel: [   94.040436] ata1.02: hard resetting link
Jun 30 10:02:20 HR-NETSWAP kernel: [   94.040456] ata1.02: XXXX hardreset hotplugged = false
Jun 30 10:02:20 HR-NETSWAP kernel: [   94.040461] ata1.02: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:20 HR-NETSWAP kernel: [   94.040467] ata1.02: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:21 HR-NETSWAP kernel: [   94.390453] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:22 HR-NETSWAP kernel: [   96.120024] ata1.03: hard resetting link
Jun 30 10:02:22 HR-NETSWAP kernel: [   96.120046] ata1.03: XXXX hardreset hotplugged = false
Jun 30 10:02:22 HR-NETSWAP kernel: [   96.120052] ata1.03: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:22 HR-NETSWAP kernel: [   96.120058] ata1.03: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.470398] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.470446] ata1.04: hard resetting link
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.470467] ata1.04: XXXX hardreset hotplugged = false
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.470472] ata1.04: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.470478] ata1.04: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.821674] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.821720] ata1.05: hard resetting link
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.821744] ata1.05: XXXX hardreset hotplugged = false
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.821750] ata1.05: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:23 HR-NETSWAP kernel: [   96.821756] ata1.05: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:23 HR-NETSWAP kernel: [   97.170399] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Jun 30 10:02:23 HR-NETSWAP kernel: [   97.183479] ata1.00: configured for UDMA/100
Jun 30 10:02:23 HR-NETSWAP kernel: [   97.192728] ata1.01: configured for UDMA/100
Jun 30 10:02:23 HR-NETSWAP kernel: [   97.298289] ata1.02: configured for UDMA/100
Jun 30 10:02:23 HR-NETSWAP kernel: [   97.298356] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
Jun 30 10:02:23 HR-NETSWAP kernel: [   97.298366] ata1.15: hard resetting link
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510055] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510330] ata1.00: hard resetting link
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510350] ata1.00: XXXX hardreset hotplugged = false
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510356] ata1.00: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.510361] ata1.00: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.860387] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.860430] ata1.01: hard resetting link
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.860450] ata1.01: XXXX hardreset hotplugged = false
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.860455] ata1.01: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:26 HR-NETSWAP kernel: [   99.860461] ata1.01: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:26 HR-NETSWAP kernel: [  100.211693] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:26 HR-NETSWAP kernel: [  100.211741] ata1.02: hard resetting link
Jun 30 10:02:26 HR-NETSWAP kernel: [  100.211771] ata1.02: XXXX hardreset hotplugged = false
Jun 30 10:02:26 HR-NETSWAP kernel: [  100.211777] ata1.02: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:26 HR-NETSWAP kernel: [  100.211783] ata1.02: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:27 HR-NETSWAP kernel: [  100.560373] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:28 HR-NETSWAP kernel: [  101.470023] ata1.03: hard resetting link
Jun 30 10:02:28 HR-NETSWAP kernel: [  101.470044] ata1.03: XXXX hardreset hotplugged = false
Jun 30 10:02:28 HR-NETSWAP kernel: [  101.470050] ata1.03: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:28 HR-NETSWAP kernel: [  101.470056] ata1.03: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:28 HR-NETSWAP kernel: [  101.820366] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:28 HR-NETSWAP kernel: [  101.820409] ata1.04: hard resetting link
Jun 30 10:02:28 HR-NETSWAP kernel: [  101.820428] ata1.04: XXXX hardreset hotplugged = false
Jun 30 10:02:28 HR-NETSWAP kernel: [  101.820434] ata1.04: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:28 HR-NETSWAP kernel: [  101.820439] ata1.04: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:28 HR-NETSWAP kernel: [  102.170367] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:28 HR-NETSWAP kernel: [  102.170409] ata1.05: hard resetting link
Jun 30 10:02:28 HR-NETSWAP kernel: [  102.170429] ata1.05: XXXX hardreset hotplugged = false
Jun 30 10:02:28 HR-NETSWAP kernel: [  102.170434] ata1.05: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:28 HR-NETSWAP kernel: [  102.170440] ata1.05: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:29 HR-NETSWAP kernel: [  102.521676] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Jun 30 10:02:29 HR-NETSWAP kernel: [  102.534788] ata1.00: configured for UDMA/100
Jun 30 10:02:29 HR-NETSWAP kernel: [  102.544981] ata1.01: configured for UDMA/100
Jun 30 10:02:29 HR-NETSWAP kernel: [  102.637647] ata1.02: configured for UDMA/100
Jun 30 10:02:29 HR-NETSWAP kernel: [  102.637732] ata1.03: failed to IDENTIFY (I/O error, err_mask=0x11)
Jun 30 10:02:29 HR-NETSWAP kernel: [  102.637744] ata1.15: hard resetting link
Jun 30 10:02:31 HR-NETSWAP kernel: [  104.851295] ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
Jun 30 10:02:31 HR-NETSWAP kernel: [  104.851565] ata1.00: hard resetting link
Jun 30 10:02:31 HR-NETSWAP kernel: [  104.851585] ata1.00: XXXX hardreset hotplugged = false
Jun 30 10:02:31 HR-NETSWAP kernel: [  104.851591] ata1.00: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:31 HR-NETSWAP kernel: [  104.851597] ata1.00: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:31 HR-NETSWAP kernel: [  105.200371] ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
Jun 30 10:02:31 HR-NETSWAP kernel: [  105.200414] ata1.01: hard resetting link
Jun 30 10:02:31 HR-NETSWAP kernel: [  105.200434] ata1.01: XXXX hardreset hotplugged = false
Jun 30 10:02:31 HR-NETSWAP kernel: [  105.200440] ata1.01: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:31 HR-NETSWAP kernel: [  105.200446] ata1.01: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:32 HR-NETSWAP kernel: [  105.550374] ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:32 HR-NETSWAP kernel: [  105.550417] ata1.02: hard resetting link
Jun 30 10:02:32 HR-NETSWAP kernel: [  105.550437] ata1.02: XXXX hardreset hotplugged = false
Jun 30 10:02:32 HR-NETSWAP kernel: [  105.550442] ata1.02: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:32 HR-NETSWAP kernel: [  105.550448] ata1.02: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:32 HR-NETSWAP kernel: [  105.901675] ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:33 HR-NETSWAP kernel: [  106.821277] ata1.03: hard resetting link
Jun 30 10:02:33 HR-NETSWAP kernel: [  106.821299] ata1.03: XXXX hardreset hotplugged = false
Jun 30 10:02:33 HR-NETSWAP kernel: [  106.821305] ata1.03: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:33 HR-NETSWAP kernel: [  106.821310] ata1.03: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:33 HR-NETSWAP kernel: [  107.170377] ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:33 HR-NETSWAP kernel: [  107.170421] ata1.04: hard resetting link
Jun 30 10:02:33 HR-NETSWAP kernel: [  107.170441] ata1.04: XXXX hardreset hotplugged = false
Jun 30 10:02:33 HR-NETSWAP kernel: [  107.170447] ata1.04: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:33 HR-NETSWAP kernel: [  107.170453] ata1.04: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:34 HR-NETSWAP kernel: [  107.520377] ata1.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
Jun 30 10:02:34 HR-NETSWAP kernel: [  107.520420] ata1.05: hard resetting link
Jun 30 10:02:34 HR-NETSWAP kernel: [  107.520440] ata1.05: XXXX hardreset hotplugged = false
Jun 30 10:02:34 HR-NETSWAP kernel: [  107.520446] ata1.05: XXX0 hardreset debounce 5 100 2000
Jun 30 10:02:34 HR-NETSWAP kernel: [  107.520451] ata1.05: XXX1 hardreset debounce 5 100 2000
Jun 30 10:02:34 HR-NETSWAP kernel: [  107.870381] ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 320)
Jun 30 10:02:34 HR-NETSWAP kernel: [  107.883447] ata1.00: configured for UDMA/100
Jun 30 10:02:34 HR-NETSWAP kernel: [  107.893209] ata1.01: configured for UDMA/100
Jun 30 10:02:34 HR-NETSWAP kernel: [  107.985315] ata1.02: configured for UDMA/100
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.009122] ata1.03: ATA-8: WDC WD30EZRX-00MMMB0, 80.00A80, max UDMA/133
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.009129] ata1.03: 5860533168 sectors, multi 0: LBA48 NCQ (depth 31/32)
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.014862] ata1.03: configured for UDMA/100
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.017593] ata1.04: configured for UDMA/100
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.017672] ata1: EH complete
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.020238] scsi 0:3:0:0: Direct-Access     ATA      WDC WD30EZRX-00M 80.0 PQ: 0 ANSI: 5
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.020715] sd 0:3:0:0: [sdd] 5860533168 512-byte logical blocks: (3.00 TB/2.72 TiB)
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.020723] sd 0:3:0:0: [sdd] 4096-byte physical blocks
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.020875] sd 0:3:0:0: [sdd] Write Protect is off
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.020882] sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.020953] sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.020999] sd 0:3:0:0: Attached scsi generic sg3 type 0
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.021384]  sdd: sdd1 sdd2
Jun 30 10:02:34 HR-NETSWAP kernel: [  108.072613] sd 0:3:0:0: [sdd] Attached SCSI disk

>From the above we can see it finally connecting on the 4th try.

> * hdparm -I output of the drive.
>

Info for two of the drives that fail regularly:

Drive 1 Western Digital 3TB:

  /dev/sdb:

  ATA device, with non-removable media
  	Model Number:       WDC WD30EZRS-00J99B0                    
  	Serial Number:      WD-WCAWZ0038962
  	Firmware Revision:  80.00A80
	Transport:          Serial, SATA 1.0a, SATA II Extensions, SATA Rev 2.5, SATA Rev     2.6
  Standards:
	Supported: 8 7 6 5 
	Likely used: 8
  Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors: 5860533168
	Logical  Sector size:                   512 bytes
	Physical Sector size:                  4096 bytes
	Logical Sector-0 offset:                  0 bytes
	device size with M = 1024*1024:     2861588 MBytes
	device size with M = 1000*1000:     3000592 MBytes (3000 GB)
	cache/buffer size  = unknown
  Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, with device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
  Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	    	Power-Up In Standby feature set
	   *	SET_FEATURES required to spinup after power up
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	Segmented DOWNLOAD_MICROCODE
	   *	Gen1 signaling speed (1.5Gb/s)
	   *	Gen2 signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	NCQ priority information
	    	DMA Setup Auto-Activate optimization
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT LBA Segment Access (AC2)
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
	    	unknown 206[12] (vendor specific)
	    	unknown 206[13] (vendor specific)
  Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	508min for SECURITY ERASE UNIT. 508min for ENHANCED SECURITY ERASE UNIT.
  Logical Unit WWN Device Identifier: 50014ee2afe03ed4
	NAA		: 5
	IEEE OUI	: 0014ee
	Unique ID	: 2afe03ed4
  Checksum: correct

Drive 2 Samsung 1.5 TB:
/dev/sda:

  ATA device, with non-removable media
	Model Number:       SAMSUNG HD154UI                         
	Serial Number:      S1XWJ9BB102098      
	Firmware Revision:  1AG01118
  Standards:
	Used: ATA-8-ACS revision 3b 
	Supported: 7 6 5 4 
  Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors: 2930277168
	Logical/Physical Sector size:           512 bytes
	device size with M = 1024*1024:     1430799 MBytes
	device size with M = 1000*1000:     1500301 MBytes (1500 GB)
	cache/buffer size  = unknown
  Capabilities:
	LBA, IORDY(can be disabled)
	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 0
	Advanced power management level: 254
	Recommended acoustic management value: 254, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6 udma7 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
  Commands/features:
	Enabled	Supported:
	   *	SMART feature set
	    	Security Mode feature set
	   *	Power Management feature set
	   *	Write cache
	   *	Look-ahead
	   *	Host Protected Area feature set
	   *	WRITE_BUFFER command
	   *	READ_BUFFER command
	   *	NOP cmd
	   *	DOWNLOAD_MICROCODE
	   *	Advanced Power Management feature set
	    	Power-Up In Standby feature set
	   *	SET_FEATURES required to spinup after power up
	    	SET_MAX security extension
	    	Automatic Acoustic Management feature set
	   *	48-bit Address feature set
	   *	Device Configuration Overlay feature set
	   *	Mandatory FLUSH_CACHE
	   *	FLUSH_CACHE_EXT
	   *	SMART error logging
	   *	SMART self-test
	    	Media Card Pass-Through
	   *	General Purpose Logging feature set
	   *	64-bit World wide name
	   *	WRITE_UNCORRECTABLE_EXT command
	   *	{READ,WRITE}_DMA_EXT_GPL commands
	   *	Segmented DOWNLOAD_MICROCODE
	   *	Gen1 signaling speed (1.5Gb/s)
	   *	Gen2 signaling speed (3.0Gb/s)
	   *	Native Command Queueing (NCQ)
	   *	Host-initiated interface power management
	   *	Phy event counters
	   *	NCQ priority information
	    	DMA Setup Auto-Activate optimization
	    	Device-initiated interface power management
	   *	Software settings preservation
	   *	SMART Command Transport (SCT) feature set
	   *	SCT Long Sector Access (AC1)
	   *	SCT LBA Segment Access (AC2)
	   *	SCT Error Recovery Control (AC3)
	   *	SCT Features Control (AC4)
	   *	SCT Data Tables (AC5)
  Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
		supported: enhanced erase
	324min for SECURITY ERASE UNIT. 324min for ENHANCED SECURITY ERASE UNIT.
  Logical Unit WWN Device Identifier: 50024e92046e42ff
	NAA		: 5
	IEEE OUI	: 0024e9
	Unique ID	: 2046e42ff
  Checksum: correct
 
> Thanks.
> 

If need more info or want me to do more tests please let me know.

Thanks.

Derry Bryson
Sr. Software Engineer 

Highly Reliable Systems
www.High-Rely.com
"Making Backup Invisible"

Phone: 775.329.5139 X129
Fax:     775.370.1001

Sales & Support: 877.384.6838

This e-mail and any files transmitted with it are the property of Highly Reliable Systems, Inc. This (email) information is confidential, and is intended solely for the use of the individual or entity to whom this e-mail is addressed. If you are not one of the named recipient(s) or otherwise have reason to believe that you have received this message in error, please notify the sender and delete this message immediately from your computer. Any other use, disclosure, retention, dissemination, forwarding, printing, distribution or copying of this e-mail is strictly prohibited.



