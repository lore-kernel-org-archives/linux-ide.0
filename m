From: Orson <orson.wellies@gmail.com>
Subject: Bug#605395: JMicron Technology JMB362 JMB363 SError: { DevExch } ExpressCard, sometimes fails to boot
Date: Mon, 10 Oct 2011 17:58:27 +0300
Message-ID: <4E930813.1080409@gmail.com>
References: <4CF44B35.3070108@gmail.com> <20110824223821.GA25723@elie.sbx02827.chicail.wayport.net>
Reply-To: Orson <orson.wellies@gmail.com>, 605395@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------010007070204030002040907"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.605395.B605395.131825872615452@bugs.debian.org>
In-Reply-To: <20110824223821.GA25723@elie.sbx02827.chicail.wayport.net>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Jonathan Nieder <jrnieder@gmail.com>, linux-ide@vger.kernel.org, arieslee@jmicron.com, 605395@bugs.debian.org
List-Id: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------010007070204030002040907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=605395

On 25/08/11 01:39, Jonathan Nieder wrote:
> Hi Orson,
>
> Orson wrote:
>
>> The single port card I have is JMB 360 id. 197B:2360  it DOES NOT give any
>> error, and works perfectly.
>> The problem is only from my cards with JMB362/363 chipset.
> Thanks for a useful report and sorry for the delay in responding.
>
> I don't see any relevant fixes upstream unfortunately, but JMB363 is
> supposed to work.  If you get a chance, please test a recent v3.x
> version from unstable, letting us know the result, and if that fails
> then describe the symptoms to linux-ide@vger.kernel.org, cc-ing Aries
> Lee<arieslee@jmicron.com>  and this bug log.
>
> Ciao,
> Jonathan

Hi Jonathan

I tried my xpress54 card JMB362/363 on Debian Wheezy testing, with 
kernel 3.0.0-1-amd64 (Debian 3.0.0.-3).

The card was inserted into the express slot without any external disk 
attached and I experienced the same problems I had been having with 
debian squeeze, perhaps even more consistently.

I am now only using single port JMB 360 cards which operate flawlessly.

I am attaching a kernel log with the said card inserted.

regards

Orson

Oct  9 23:45:46 hp-laptop kernel: imklog 5.8.5, log source = /proc/kmsg 
started.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Initializing cgroup 
subsys cpuset
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Initializing cgroup 
subsys cpu
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Linux version 
3.0.0-1-amd64 (Debian 3.0.0-3) (ben@decadent.org.uk) (gcc version 4.5.3 
(Debian 4.5.3-8) ) #1 SMP Sat Aug 27 16:21:11 UTC 2011
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Command line: 
BOOT_IMAGE=/boot/vmlinuz-3.0.0-1-amd64 
root=UUID=da9df6fe-041d-4cd9-b203-98e636840bdc ro quiet splash
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] BIOS-provided physical 
RAM map:
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
0000000000000000 - 000000000009fc00 (usable)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
000000000009fc00 - 00000000000a0000 (reserved)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
00000000000e0000 - 0000000000100000 (reserved)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
0000000000100000 - 0000000077fd0000 (usable)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
0000000077fd0000 - 0000000077fe5600 (reserved)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
0000000077fe5600 - 0000000077ff8000 (ACPI NVS)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
0000000077ff8000 - 0000000080000000 (reserved)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
00000000e0000000 - 00000000f0000000 (reserved)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
00000000fec00000 - 00000000fec02000 (reserved)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
00000000ffbc0000 - 00000000ffcc0000 (reserved)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  BIOS-e820: 
00000000fff00000 - 0000000100000000 (reserved)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] NX (Execute Disable) 
protection: active
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] DMI 2.4 present.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] DMI: Hewlett-Packard HP 
Compaq nx6325 (EY351ET#ABU)/30B0, BIOS 68TT2 Ver. F.07 05/08/2007
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] e820 update range: 
0000000000000000 - 0000000000010000 (usable) ==> (reserved)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] e820 remove range: 
00000000000a0000 - 0000000000100000 (usable)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] No AGP bridge found
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] last_pfn = 0x77fd0 
max_arch_pfn = 0x400000000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] MTRR default type: 
uncachable
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] MTRR fixed ranges enabled:
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   00000-9FFFF write-back
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   A0000-BFFFF uncachable
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   C0000-C0FFF write-protect
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   C1000-C3FFF write-back
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   C4000-C4FFF write-protect
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   C5000-C7FFF write-back
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   C8000-C8FFF write-protect
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   C9000-CBFFF write-back
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   CC000-CCFFF write-protect
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   CD000-CFFFF write-back
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   D0000-EFFFF uncachable
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   F0000-FFFFF write-protect
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] MTRR variable ranges 
enabled:
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   0 base 0000000000 
mask FFC0000000 write-back
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   1 base 0040000000 
mask FFE0000000 write-back
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   2 base 0060000000 
mask FFF0000000 write-back
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   3 base 0070000000 
mask FFF8000000 write-back
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   4 disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   5 disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   6 disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   7 disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] x86 PAT enabled: cpu 0, 
old 0x7040600070406, new 0x7010600070106
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] initial memory mapped : 
0 - 20000000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Base memory trampoline 
at [ffff88000009a000] 9a000 size 20480
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] init_memory_mapping: 
0000000000000000-0000000077fd0000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  0000000000 - 
0077e00000 page 2M
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  0077e00000 - 
0077fd0000 page 4k
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] kernel direct mapping 
tables up to 77fd0000 @ 77fcc000-77fd0000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] RAMDISK: 3634a000 - 
3719d000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: RSDP 
00000000000f7a90 00024 (v02 HP    )
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: XSDT 
0000000077fe57b4 00054 (v01 HPQOEM SLIC-MPC 00000001 HP   00000001)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: FACP 
0000000077fe5684 000F4 (v04 HP     0944     00000003 HP   00000001)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: DSDT 
0000000077fe5a54 0F6D3 (v01 HP        SB400 00010000 MSFT 0100000E)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: FACS 
0000000077ff7e80 00040
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: SLIC 
0000000077fe5808 00176 (v01 HPQOEM SLIC-MPC 00000001 HP   00000001)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: APIC 
0000000077fe5980 00062 (v01 HP     0944     00000001 HP   00000001)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: MCFG 
0000000077fe59e4 0003C (v01 HP     0944     00000001 HP   00000001)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: TCPA 
0000000077fe5a20 00032 (v02 HP     0944     00000001 HP   00000001)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: SSDT 
0000000077ff5127 00206 (v01 HP     PSSTBLID 00000001 HP   00000001)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: Local APIC 
address 0xfee00000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Scanning NUMA topology 
in Northbridge 24
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] No NUMA configuration found
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Faking a node at 
0000000000000000-0000000077fd0000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Initmem setup node 0 
0000000000000000-0000000077fd0000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   NODE_DATA 
[0000000077fc7000 - 0000000077fcbfff]
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]  
[ffffea0000000000-ffffea0001bfffff] PMD -> 
[ffff880075800000-ffff8800773fffff] on node 0
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Zone PFN ranges:
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   DMA      0x00000010 
-> 0x00001000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   DMA32    0x00001000 
-> 0x00100000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   Normal   empty
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Movable zone start PFN 
for each node
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] early_node_map[2] 
active PFN ranges
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]     0: 0x00000010 -> 
0x0000009f
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]     0: 0x00000100 -> 
0x00077fd0
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] On node 0 totalpages: 
491359
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   DMA zone: 56 pages 
used for memmap
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   DMA zone: 5 pages 
reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   DMA zone: 3922 pages, 
LIFO batch:0
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   DMA32 zone: 6664 
pages used for memmap
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]   DMA32 zone: 480712 
pages, LIFO batch:31
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] SB4X0 revision 0x82
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Ignoring ACPI timer 
override.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] If you got timer 
trouble try acpi_use_timer_override
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Detected use of 
extended apic ids on hypertransport bus
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: PM-Timer IO Port: 
0x8008
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: Local APIC 
address 0xfee00000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: LAPIC 
(acpi_id[0x01] lapic_id[0x00] enabled)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: LAPIC 
(acpi_id[0x02] lapic_id[0x01] enabled)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: LAPIC_NMI 
(acpi_id[0x01] high edge lint[0x1])
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: IOAPIC (id[0x02] 
address[0xfec00000] gsi_base[0])
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] IOAPIC[0]: apic_id 2, 
version 33, address 0xfec00000, GSI 0-23
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 
0 bus_irq 0 global_irq 2 dfl dfl)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: BIOS IRQ0 pin2 
override ignored.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: INT_SRC_OVR (bus 
0 bus_irq 9 global_irq 21 low level)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] ACPI: IRQ9 used by 
override.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Using ACPI (MADT) for 
SMP configuration information
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] SMP: Allowing 2 CPUs, 0 
hotplug CPUs
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] nr_irqs_gsi: 40
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] PM: Registered nosave 
memory: 000000000009f000 - 00000000000a0000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] PM: Registered nosave 
memory: 00000000000a0000 - 00000000000e0000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] PM: Registered nosave 
memory: 00000000000e0000 - 0000000000100000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Allocating PCI 
resources starting at 80000000 (gap: 80000000:60000000)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Booting paravirtualized 
kernel on bare hardware
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] setup_percpu: 
NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 nr_node_ids:1
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] PERCPU: Embedded 27 
pages/cpu @ffff880077c00000 s78912 r8192 d23488 u1048576
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] pcpu-alloc: s78912 
r8192 d23488 u1048576 alloc=1*2097152
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] pcpu-alloc: [0] 0 1
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Built 1 zonelists in 
Node order, mobility grouping on.  Total pages: 484634
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Policy zone: DMA32
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Kernel command line: 
BOOT_IMAGE=/boot/vmlinuz-3.0.0-1-amd64 
root=UUID=da9df6fe-041d-4cd9-b203-98e636840bdc ro quiet splash
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] PID hash table entries: 
4096 (order: 3, 32768 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Checking aperture...
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] No AGP bridge found
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Node 0: aperture @ 
c094000000 size 32 MB
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Aperture beyond 4GB. 
Ignoring.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Memory: 
1913428k/1965888k available (3325k kernel code, 452k absent, 52008k 
reserved, 3370k data, 560k init)
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Hierarchical RCU 
implementation.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000]     RCU dyntick-idle 
grace-period acceleration is enabled.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] NR_IRQS:33024 
nr_irqs:512 16
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Extended CMOS year: 2000
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] spurious 8259A 
interrupt: IRQ7.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Console: colour VGA+ 80x25
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] console [tty0] enabled
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Fast TSC calibration 
using PIT
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Detected 1994.760 MHz 
processor.
Oct  9 23:45:46 hp-laptop kernel: [    0.000000] Marking TSC unstable 
due to TSCs unsynchronized
Oct  9 23:45:46 hp-laptop kernel: [    0.008007] Calibrating delay loop 
(skipped), value calculated using timer frequency.. 3989.52 BogoMIPS 
(lpj=7979040)
Oct  9 23:45:46 hp-laptop kernel: [    0.008012] pid_max: default: 32768 
minimum: 301
Oct  9 23:45:46 hp-laptop kernel: [    0.008186] Security Framework 
initialized
Oct  9 23:45:46 hp-laptop kernel: [    0.008193] SELinux:  Disabled at boot.
Oct  9 23:45:46 hp-laptop kernel: [    0.008477] Dentry cache hash table 
entries: 262144 (order: 9, 2097152 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.009639] Inode-cache hash table 
entries: 131072 (order: 8, 1048576 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.012069] Mount-cache hash table 
entries: 256
Oct  9 23:45:46 hp-laptop kernel: [    0.012281] Initializing cgroup 
subsys cpuacct
Oct  9 23:45:46 hp-laptop kernel: [    0.012288] Initializing cgroup 
subsys memory
Oct  9 23:45:46 hp-laptop kernel: [    0.012307] Initializing cgroup 
subsys devices
Oct  9 23:45:46 hp-laptop kernel: [    0.012310] Initializing cgroup 
subsys freezer
Oct  9 23:45:46 hp-laptop kernel: [    0.012313] Initializing cgroup 
subsys net_cls
Oct  9 23:45:46 hp-laptop kernel: [    0.012316] Initializing cgroup 
subsys blkio
Oct  9 23:45:46 hp-laptop kernel: [    0.012383] tseg: 0000000000
Oct  9 23:45:46 hp-laptop kernel: [    0.012407] CPU: Physical Processor 
ID: 0
Oct  9 23:45:46 hp-laptop kernel: [    0.012409] CPU: Processor Core ID: 0
Oct  9 23:45:46 hp-laptop kernel: [    0.012412] mce: CPU supports 5 MCE 
banks
Oct  9 23:45:46 hp-laptop kernel: [    0.012426] using AMD E400 aware 
idle routine
Oct  9 23:45:46 hp-laptop kernel: [    0.012758] ACPI: Core revision 
20110413
Oct  9 23:45:46 hp-laptop kernel: [    0.020466] ..TIMER: vector=0x30 
apic1=0 pin1=0 apic2=-1 pin2=-1
Oct  9 23:45:46 hp-laptop kernel: [    0.060805] CPU0: AMD Turion(tm) 64 
X2 Mobile Technology TL-60 stepping 02
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] Performance Events: AMD 
PMU driver.
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] ... 
version:                0
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] ... bit 
width:              48
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] ... generic 
registers:      4
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] ... value 
mask:             0000ffffffffffff
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] ... max 
period:             00007fffffffffff
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] ... fixed-purpose 
events:   0
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] ... event 
mask:             000000000000000f
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] NMI watchdog enabled, 
takes one hw-pmu counter.
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] Booting Node   0, 
Processors  #1 Ok.
Oct  9 23:45:46 hp-laptop kernel: [    0.064003] smpboot cpu 1: start_ip 
= 9a000
Oct  9 23:45:46 hp-laptop kernel: [    0.148087] NMI watchdog enabled, 
takes one hw-pmu counter.
Oct  9 23:45:46 hp-laptop kernel: [    0.148115] System has AMD C1E enabled
Oct  9 23:45:46 hp-laptop kernel: [    0.148120] Brought up 2 CPUs
Oct  9 23:45:46 hp-laptop kernel: [    0.148124] Total of 2 processors 
activated (7979.83 BogoMIPS).
Oct  9 23:45:46 hp-laptop kernel: [    0.148115] Switch to broadcast 
mode on CPU1
Oct  9 23:45:46 hp-laptop kernel: [    0.148581] Switch to broadcast 
mode on CPU0
Oct  9 23:45:46 hp-laptop kernel: [    0.148581] devtmpfs: initialized
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] PM: Registering ACPI 
NVS region at 77fe5600 (76288 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] print_constraints: dummy:
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] NET: Registered 
protocol family 16
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] node 0 link 0: io port 
[1000, fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] TOM: 0000000080000000 
aka 2048M
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] node 0 link 0: mmio 
[f0000000, ffffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] node 0 link 0: mmio 
[e0000000, efffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] node 0 link 0: mmio 
[c8000000, dfffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] node 0 link 0: mmio 
[c0000000, c7ffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] node 0 link 0: mmio 
[a0000, bffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] node 0 link 0: mmio 
[80000000, bfffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] bus: [00, ff] on node 0 
link 0
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] bus: 00 index 0 [io  
0x0000-0xffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] bus: 00 index 1 [mem 
0x80000000-0xfcffffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] bus: 00 index 2 [mem 
0x000a0000-0x000bffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] ACPI: bus type pci 
registered
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] PCI: MMCONFIG for 
domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base 0xe0000000)
Oct  9 23:45:46 hp-laptop kernel: [    0.155573] PCI: MMCONFIG at [mem 
0xe0000000-0xefffffff] reserved in E820
Oct  9 23:45:46 hp-laptop kernel: [    0.171484] PCI: Using 
configuration type 1 for base access
Oct  9 23:45:46 hp-laptop kernel: [    0.176170] bio: create slab 
<bio-0> at 0
Oct  9 23:45:46 hp-laptop kernel: [    0.177282] ACPI: EC: Look up EC in 
DSDT
Oct  9 23:45:46 hp-laptop kernel: [    0.208099] ACPI: Interpreter enabled
Oct  9 23:45:46 hp-laptop kernel: [    0.208105] ACPI: (supports S0 S3 
S4 S5)
Oct  9 23:45:46 hp-laptop kernel: [    0.208131] ACPI: Using IOAPIC for 
interrupt routing
Oct  9 23:45:46 hp-laptop kernel: [    0.208702] [Firmware Bug]: ACPI: 
No _BQC method, cannot determine initial brightness
Oct  9 23:45:46 hp-laptop kernel: [    0.209539] ACPI: Power Resource 
[C22D] (off)
Oct  9 23:45:46 hp-laptop kernel: [    0.209539] ACPI: Power Resource 
[C221] (on)
Oct  9 23:45:46 hp-laptop kernel: [    0.215149] ACPI: Power Resource 
[C360] (off)
Oct  9 23:45:46 hp-laptop kernel: [    0.215220] ACPI: Power Resource 
[C361] (off)
Oct  9 23:45:46 hp-laptop kernel: [    0.215293] ACPI: Power Resource 
[C362] (off)
Oct  9 23:45:46 hp-laptop kernel: [    0.215363] ACPI: Power Resource 
[C363] (off)
Oct  9 23:45:46 hp-laptop kernel: [    0.216044] ACPI: EC: GPE = 0x11, 
I/O: command/status = 0x66, data = 0x62
Oct  9 23:45:46 hp-laptop kernel: [    0.216340] ACPI: No dock devices 
found.
Oct  9 23:45:46 hp-laptop kernel: [    0.216343] HEST: Table not found.
Oct  9 23:45:46 hp-laptop kernel: [    0.216348] PCI: Ignoring host 
bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
Oct  9 23:45:46 hp-laptop kernel: [    0.220902] ACPI: PCI Root Bridge 
[C079] (domain 0000 [bus 00-ff])
Oct  9 23:45:46 hp-laptop kernel: [    0.230021] pci_root PNP0A03:00: 
host bridge window [io  0x0000-0x0cf7] (ignored)
Oct  9 23:45:46 hp-laptop kernel: [    0.230025] pci_root PNP0A03:00: 
host bridge window [io  0x0d00-0xffff] (ignored)
Oct  9 23:45:46 hp-laptop kernel: [    0.230028] pci_root PNP0A03:00: 
host bridge window [mem 0x000a0000-0x000bffff] (ignored)
Oct  9 23:45:46 hp-laptop kernel: [    0.230032] pci_root PNP0A03:00: 
host bridge window [mem 0x80000000-0xfedfffff] (ignored)
Oct  9 23:45:46 hp-laptop kernel: [    0.230036] pci_root PNP0A03:00: 
host bridge window [mem 0xfee01000-0xffffffff] (ignored)
Oct  9 23:45:46 hp-laptop kernel: [    0.230039] pci_root PNP0A03:00: 
host bridge window [mem 0x000d0000-0x000dffff] (ignored)
Oct  9 23:45:46 hp-laptop kernel: [    0.230052] pci 0000:00:00.0: 
[1002:5950] type 0 class 0x000600
Oct  9 23:45:46 hp-laptop kernel: [    0.230088] pci 0000:00:01.0: 
[1002:5a3f] type 1 class 0x000604
Oct  9 23:45:46 hp-laptop kernel: [    0.230131] pci 0000:00:04.0: 
[1002:5a36] type 1 class 0x000604
Oct  9 23:45:46 hp-laptop kernel: [    0.230160] pci 0000:00:04.0: PME# 
supported from D0 D3hot D3cold
Oct  9 23:45:46 hp-laptop kernel: [    0.230164] pci 0000:00:04.0: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.230183] pci 0000:00:05.0: 
[1002:5a37] type 1 class 0x000604
Oct  9 23:45:46 hp-laptop kernel: [    0.230211] pci 0000:00:05.0: PME# 
supported from D0 D3hot D3cold
Oct  9 23:45:46 hp-laptop kernel: [    0.230215] pci 0000:00:05.0: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.230233] pci 0000:00:06.0: 
[1002:5a38] type 1 class 0x000604
Oct  9 23:45:46 hp-laptop kernel: [    0.230262] pci 0000:00:06.0: PME# 
supported from D0 D3hot D3cold
Oct  9 23:45:46 hp-laptop kernel: [    0.230265] pci 0000:00:06.0: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.230315] pci 0000:00:12.0: 
[1002:4379] type 0 class 0x000101
Oct  9 23:45:46 hp-laptop kernel: [    0.230343] pci 0000:00:12.0: reg 
10: [io  0x9000-0x9007]
Oct  9 23:45:46 hp-laptop kernel: [    0.230358] pci 0000:00:12.0: reg 
14: [io  0x9008-0x900b]
Oct  9 23:45:46 hp-laptop kernel: [    0.230372] pci 0000:00:12.0: reg 
18: [io  0x9010-0x9017]
Oct  9 23:45:46 hp-laptop kernel: [    0.230386] pci 0000:00:12.0: reg 
1c: [io  0x6018-0x601b]
Oct  9 23:45:46 hp-laptop kernel: [    0.230400] pci 0000:00:12.0: reg 
20: [io  0x6020-0x602f]
Oct  9 23:45:46 hp-laptop kernel: [    0.230415] pci 0000:00:12.0: reg 
24: [mem 0xd0509000-0xd05091ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.230429] pci 0000:00:12.0: reg 
30: [mem 0x00000000-0x0007ffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.230463] pci 0000:00:12.0: 
supports D1 D2
Oct  9 23:45:46 hp-laptop kernel: [    0.230488] pci 0000:00:13.0: 
[1002:4374] type 0 class 0x000c03
Oct  9 23:45:46 hp-laptop kernel: [    0.230508] pci 0000:00:13.0: reg 
10: [mem 0xd0501000-0xd0501fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.230601] pci 0000:00:13.1: 
[1002:4375] type 0 class 0x000c03
Oct  9 23:45:46 hp-laptop kernel: [    0.230620] pci 0000:00:13.1: reg 
10: [mem 0xd0502000-0xd0502fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.230717] pci 0000:00:13.2: 
[1002:4373] type 0 class 0x000c03
Oct  9 23:45:46 hp-laptop kernel: [    0.230742] pci 0000:00:13.2: reg 
10: [mem 0xd0503000-0xd0503fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.230834] pci 0000:00:13.2: 
supports D1 D2
Oct  9 23:45:46 hp-laptop kernel: [    0.230836] pci 0000:00:13.2: PME# 
supported from D0 D1 D2 D3hot
Oct  9 23:45:46 hp-laptop kernel: [    0.230842] pci 0000:00:13.2: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.230877] pci 0000:00:14.0: 
[1002:4372] type 0 class 0x000c05
Oct  9 23:45:46 hp-laptop kernel: [    0.230899] pci 0000:00:14.0: reg 
10: [io  0x8200-0x820f]
Oct  9 23:45:46 hp-laptop kernel: [    0.230913] pci 0000:00:14.0: reg 
14: [mem 0xd0504000-0xd05043ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.230974] HPET not enabled in 
BIOS. You might try hpet=force boot option
Oct  9 23:45:46 hp-laptop kernel: [    0.231025] pci 0000:00:14.1: 
[1002:4376] type 0 class 0x000101
Oct  9 23:45:46 hp-laptop kernel: [    0.231049] pci 0000:00:14.1: reg 
10: [io  0x0000-0x0007]
Oct  9 23:45:46 hp-laptop kernel: [    0.231063] pci 0000:00:14.1: reg 
14: [io  0x0000-0x0003]
Oct  9 23:45:46 hp-laptop kernel: [    0.231076] pci 0000:00:14.1: reg 
18: [io  0x0000-0x0007]
Oct  9 23:45:46 hp-laptop kernel: [    0.231091] pci 0000:00:14.1: reg 
1c: [io  0x0000-0x0003]
Oct  9 23:45:46 hp-laptop kernel: [    0.231105] pci 0000:00:14.1: reg 
20: [io  0x6040-0x604f]
Oct  9 23:45:46 hp-laptop kernel: [    0.231182] pci 0000:00:14.2: 
[1002:437b] type 0 class 0x000403
Oct  9 23:45:46 hp-laptop kernel: [    0.231217] pci 0000:00:14.2: reg 
10: [mem 0xd0508000-0xd050bfff 64bit]
Oct  9 23:45:46 hp-laptop kernel: [    0.231305] pci 0000:00:14.2: PME# 
supported from D0 D3hot D3cold
Oct  9 23:45:46 hp-laptop kernel: [    0.231311] pci 0000:00:14.2: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.231338] pci 0000:00:14.3: 
[1002:4377] type 0 class 0x000601
Oct  9 23:45:46 hp-laptop kernel: [    0.231445] pci 0000:00:14.4: 
[1002:4371] type 1 class 0x000604
Oct  9 23:45:46 hp-laptop kernel: [    0.231511] pci 0000:00:18.0: 
[1022:1100] type 0 class 0x000600
Oct  9 23:45:46 hp-laptop kernel: [    0.231536] pci 0000:00:18.1: 
[1022:1101] type 0 class 0x000600
Oct  9 23:45:46 hp-laptop kernel: [    0.231556] pci 0000:00:18.2: 
[1022:1102] type 0 class 0x000600
Oct  9 23:45:46 hp-laptop kernel: [    0.231577] pci 0000:00:18.3: 
[1022:1103] type 0 class 0x000600
Oct  9 23:45:46 hp-laptop kernel: [    0.231607] PCI: peer root bus 00 
res updated from pci conf
Oct  9 23:45:46 hp-laptop kernel: [    0.231638] pci 0000:01:05.0: 
[1002:5975] type 0 class 0x000300
Oct  9 23:45:46 hp-laptop kernel: [    0.231647] pci 0000:01:05.0: reg 
10: [mem 0xc0000000-0xc7ffffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.231653] pci 0000:01:05.0: reg 
14: [io  0x5000-0x50ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.231660] pci 0000:01:05.0: reg 
18: [mem 0xd0400000-0xd040ffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.231675] pci 0000:01:05.0: reg 
30: [mem 0x00000000-0x0001ffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.231684] pci 0000:01:05.0: 
supports D1 D2
Oct  9 23:45:46 hp-laptop kernel: [    0.231700] pci 0000:00:01.0: PCI 
bridge to [bus 01-01]
Oct  9 23:45:46 hp-laptop kernel: [    0.231706] pci 0000:00:01.0:   
bridge window [io  0x5000-0x5fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.231710] pci 0000:00:01.0:   
bridge window [mem 0xd0400000-0xd04fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.231715] pci 0000:00:01.0:   
bridge window [mem 0xc0000000-0xc7ffffff 64bit pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.231762] pci 0000:10:00.0: 
[197b:2363] type 0 class 0x000106
Oct  9 23:45:46 hp-laptop kernel: [    0.231847] pci 0000:10:00.0: reg 
24: [mem 0xd0000000-0xd0001fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.231861] pci 0000:10:00.0: reg 
30: [mem 0x00000000-0x0000ffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.231894] pci 0000:10:00.0: PME# 
supported from D3hot
Oct  9 23:45:46 hp-laptop kernel: [    0.231899] pci 0000:10:00.0: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.231933] pci 0000:10:00.1: 
[197b:2363] type 0 class 0x000101
Oct  9 23:45:46 hp-laptop kernel: [    0.231958] pci 0000:10:00.1: reg 
10: [io  0x4000-0x4007]
Oct  9 23:45:46 hp-laptop kernel: [    0.231972] pci 0000:10:00.1: reg 
14: [io  0x4008-0x400b]
Oct  9 23:45:46 hp-laptop kernel: [    0.231986] pci 0000:10:00.1: reg 
18: [io  0x4010-0x4017]
Oct  9 23:45:46 hp-laptop kernel: [    0.231999] pci 0000:10:00.1: reg 
1c: [io  0x4018-0x401b]
Oct  9 23:45:46 hp-laptop kernel: [    0.232021] pci 0000:10:00.1: reg 
20: [io  0x4020-0x402f]
Oct  9 23:45:46 hp-laptop kernel: [    0.232090] pci 0000:10:00.0: 
disabling ASPM on pre-1.1 PCIe device.  You can enable it with 
'pcie_aspm=force'
Oct  9 23:45:46 hp-laptop kernel: [    0.232105] pci 0000:00:04.0: PCI 
bridge to [bus 10-10]
Oct  9 23:45:46 hp-laptop kernel: [    0.232110] pci 0000:00:04.0:   
bridge window [io  0x4000-0x4fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.232114] pci 0000:00:04.0:   
bridge window [mem 0xd0000000-0xd00fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.232119] pci 0000:00:04.0:   
bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
Oct  9 23:45:46 hp-laptop kernel: [    0.232146] pci 0000:00:05.0: PCI 
bridge to [bus 20-20]
Oct  9 23:45:46 hp-laptop kernel: [    0.232151] pci 0000:00:05.0:   
bridge window [io  0x2000-0x3fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.232155] pci 0000:00:05.0:   
bridge window [mem 0xcc000000-0xcfffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.232160] pci 0000:00:05.0:   
bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
Oct  9 23:45:46 hp-laptop kernel: [    0.232209] pci 0000:30:00.0: 
[14e4:4312] type 0 class 0x000280
Oct  9 23:45:46 hp-laptop kernel: [    0.232227] pci 0000:30:00.0: reg 
10: [mem 0xc8000000-0xc8003fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.232320] pci 0000:30:00.0: 
supports D1 D2
Oct  9 23:45:46 hp-laptop kernel: [    0.232341] pci 0000:30:00.0: 
disabling ASPM on pre-1.1 PCIe device.  You can enable it with 
'pcie_aspm=force'
Oct  9 23:45:46 hp-laptop kernel: [    0.232351] pci 0000:00:06.0: PCI 
bridge to [bus 30-30]
Oct  9 23:45:46 hp-laptop kernel: [    0.232355] pci 0000:00:06.0:   
bridge window [io  0xf000-0x0000] (disabled)
Oct  9 23:45:46 hp-laptop kernel: [    0.232359] pci 0000:00:06.0:   
bridge window [mem 0xc8000000-0xc80fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.232364] pci 0000:00:06.0:   
bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
Oct  9 23:45:46 hp-laptop kernel: [    0.232417] pci 0000:02:01.0: 
[14e4:169c] type 0 class 0x000200
Oct  9 23:45:46 hp-laptop kernel: [    0.232456] pci 0000:02:01.0: reg 
10: [mem 0xd0100000-0xd010ffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.232592] pci 0000:02:01.0: PME# 
supported from D3hot D3cold
Oct  9 23:45:46 hp-laptop kernel: [    0.232600] pci 0000:02:01.0: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.232639] pci 0000:02:04.0: 
[104c:8039] type 2 class 0x000607
Oct  9 23:45:46 hp-laptop kernel: [    0.232669] pci 0000:02:04.0: reg 
10: [mem 0xd0110000-0xd0110fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.232702] pci 0000:02:04.0: 
supports D1 D2
Oct  9 23:45:46 hp-laptop kernel: [    0.232705] pci 0000:02:04.0: PME# 
supported from D0 D1 D2 D3hot
Oct  9 23:45:46 hp-laptop kernel: [    0.232711] pci 0000:02:04.0: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.232744] pci 0000:02:04.2: 
[104c:803b] type 0 class 0x000180
Oct  9 23:45:46 hp-laptop kernel: [    0.232773] pci 0000:02:04.2: reg 
10: [mem 0xd0118000-0xd0118fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.232888] pci 0000:02:04.2: 
supports D1 D2
Oct  9 23:45:46 hp-laptop kernel: [    0.232890] pci 0000:02:04.2: PME# 
supported from D0 D1 D2 D3hot
Oct  9 23:45:46 hp-laptop kernel: [    0.232897] pci 0000:02:04.2: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.232929] pci 0000:02:04.3: 
[104c:803c] type 0 class 0x000805
Oct  9 23:45:46 hp-laptop kernel: [    0.232958] pci 0000:02:04.3: reg 
10: [mem 0xd0119000-0xd01190ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.233073] pci 0000:02:04.3: 
supports D1 D2
Oct  9 23:45:46 hp-laptop kernel: [    0.233075] pci 0000:02:04.3: PME# 
supported from D0 D1 D2 D3hot
Oct  9 23:45:46 hp-laptop kernel: [    0.233082] pci 0000:02:04.3: PME# 
disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.233157] pci 0000:00:14.4: PCI 
bridge to [bus 02-03] (subtractive decode)
Oct  9 23:45:46 hp-laptop kernel: [    0.233166] pci 0000:00:14.4:   
bridge window [io  0xf000-0x0000] (disabled)
Oct  9 23:45:46 hp-laptop kernel: [    0.233173] pci 0000:00:14.4:   
bridge window [mem 0xd0100000-0xd03fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.233180] pci 0000:00:14.4:   
bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
Oct  9 23:45:46 hp-laptop kernel: [    0.233184] pci 0000:00:14.4:   
bridge window [io  0x0000-0xffff] (subtractive decode)
Oct  9 23:45:46 hp-laptop kernel: [    0.233188] pci 0000:00:14.4:   
bridge window [mem 0x80000000-0xfcffffffff] (subtractive decode)
Oct  9 23:45:46 hp-laptop kernel: [    0.233192] pci 0000:00:14.4:   
bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
Oct  9 23:45:46 hp-laptop kernel: [    0.233254] pci_bus 0000:03: [bus 
03-06] partially hidden behind transparent bridge 0000:02 [bus 02-03]
Oct  9 23:45:46 hp-laptop kernel: [    0.233276] ACPI: PCI Interrupt 
Routing Table [\_SB_.C079._PRT]
Oct  9 23:45:46 hp-laptop kernel: [    0.233483] ACPI: PCI Interrupt 
Routing Table [\_SB_.C079.C07A._PRT]
Oct  9 23:45:46 hp-laptop kernel: [    0.233531] ACPI: PCI Interrupt 
Routing Table [\_SB_.C079.C0E5._PRT]
Oct  9 23:45:46 hp-laptop kernel: [    0.233774]  pci0000:00: Requesting 
ACPI _OSC control (0x1d)
Oct  9 23:45:46 hp-laptop kernel: [    0.233779]  pci0000:00: ACPI _OSC 
request failed (AE_NOT_FOUND), returned control mask: 0x1d
Oct  9 23:45:46 hp-laptop kernel: [    0.233781] ACPI _OSC control for 
PCIe not granted, disabling ASPM
Oct  9 23:45:46 hp-laptop kernel: [    0.246884] ACPI: PCI Interrupt 
Link [C12B] (IRQs 10 11) *0, disabled.
Oct  9 23:45:46 hp-laptop kernel: [    0.246965] ACPI: PCI Interrupt 
Link [C12C] (IRQs 10 11) *0, disabled.
Oct  9 23:45:46 hp-laptop kernel: [    0.247045] ACPI: PCI Interrupt 
Link [C12D] (IRQs 10 11) *0, disabled.
Oct  9 23:45:46 hp-laptop kernel: [    0.247123] ACPI: PCI Interrupt 
Link [C12E] (IRQs 10 11) *0, disabled.
Oct  9 23:45:46 hp-laptop kernel: [    0.247201] ACPI: PCI Interrupt 
Link [C12F] (IRQs 10 11) *0, disabled.
Oct  9 23:45:46 hp-laptop kernel: [    0.247280] ACPI: PCI Interrupt 
Link [C130] (IRQs 9) *0, disabled.
Oct  9 23:45:46 hp-laptop kernel: [    0.247358] ACPI: PCI Interrupt 
Link [C131] (IRQs 10 11) *0, disabled.
Oct  9 23:45:46 hp-laptop kernel: [    0.247448] ACPI: PCI Interrupt 
Link [C132] (IRQs 10 11) *5
Oct  9 23:45:46 hp-laptop kernel: [    0.247624] vgaarb: device added: 
PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none
Oct  9 23:45:46 hp-laptop kernel: [    0.247633] vgaarb: loaded
Oct  9 23:45:46 hp-laptop kernel: [    0.247635] vgaarb: bridge control 
possible 0000:01:05.0
Oct  9 23:45:46 hp-laptop kernel: [    0.247694] PCI: Using ACPI for IRQ 
routing
Oct  9 23:45:46 hp-laptop kernel: [    0.259514] PCI: 
pci_cache_line_size set to 64 bytes
Oct  9 23:45:46 hp-laptop kernel: [    0.259554] pci 0000:00:14.2: 
address space collision: [mem 0xd0508000-0xd050bfff 64bit] conflicts 
with 0000:00:12.0 [mem 0xd0509000-0xd05091ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.259650] reserve RAM buffer: 
000000000009fc00 - 000000000009ffff
Oct  9 23:45:46 hp-laptop kernel: [    0.259654] reserve RAM buffer: 
0000000077fd0000 - 0000000077ffffff
Oct  9 23:45:46 hp-laptop kernel: [    0.262217] pnp: PnP ACPI init
Oct  9 23:45:46 hp-laptop kernel: [    0.262243] ACPI: bus type pnp 
registered
Oct  9 23:45:46 hp-laptop kernel: [    0.262403] pnp 00:00: [mem 
0x00000000-0x0009ffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.262406] pnp 00:00: [mem 
0x000e0000-0x000fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.262410] pnp 00:00: [mem 
0x00100000-0x77ffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.262503] system 00:00: [mem 
0x00000000-0x0009ffff] could not be reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.262508] system 00:00: [mem 
0x000e0000-0x000fffff] could not be reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.262512] system 00:00: [mem 
0x00100000-0x77ffffff] could not be reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.262517] system 00:00: Plug and 
Play ACPI device, IDs PNP0c01 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.267038] pnp 00:01: [bus 00-ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.267042] pnp 00:01: [io  
0x0cf8-0x0cff]
Oct  9 23:45:46 hp-laptop kernel: [    0.267045] pnp 00:01: [io  
0x0000-0x0cf7 window]
Oct  9 23:45:46 hp-laptop kernel: [    0.267048] pnp 00:01: [io  
0x0d00-0xffff window]
Oct  9 23:45:46 hp-laptop kernel: [    0.267052] pnp 00:01: [mem 
0x000a0000-0x000bffff window]
Oct  9 23:45:46 hp-laptop kernel: [    0.267055] pnp 00:01: [mem 
0x80000000-0xfedfffff window]
Oct  9 23:45:46 hp-laptop kernel: [    0.267060] pnp 00:01: [mem 
0xfee01000-0xffffffff window]
Oct  9 23:45:46 hp-laptop kernel: [    0.267064] pnp 00:01: [mem 
0x000d0000-0x000dffff window]
Oct  9 23:45:46 hp-laptop kernel: [    0.267169] pnp 00:01: Plug and 
Play ACPI device, IDs PNP0a03 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.267417] pnp 00:02: [io  
0x0520-0x052f]
Oct  9 23:45:46 hp-laptop kernel: [    0.267420] pnp 00:02: [io  
0x0530-0x053f]
Oct  9 23:45:46 hp-laptop kernel: [    0.267424] pnp 00:02: [mem 
0xfed40000-0xfed44fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.267471] pnp 00:02: Plug and 
Play ACPI device, IDs IFX0102 PNP0c31 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.267486] pnp 00:03: [io  
0x00f0-0x00ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.267503] pnp 00:03: [irq 13]
Oct  9 23:45:46 hp-laptop kernel: [    0.267544] pnp 00:03: Plug and 
Play ACPI device, IDs PNP0c04 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.267561] pnp 00:04: [io  
0x0000-0x000f]
Oct  9 23:45:46 hp-laptop kernel: [    0.267564] pnp 00:04: [io  
0x0080-0x008f]
Oct  9 23:45:46 hp-laptop kernel: [    0.267568] pnp 00:04: [io  
0x00c0-0x00df]
Oct  9 23:45:46 hp-laptop kernel: [    0.267571] pnp 00:04: [dma 4]
Oct  9 23:45:46 hp-laptop kernel: [    0.267607] pnp 00:04: Plug and 
Play ACPI device, IDs PNP0200 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.267621] pnp 00:05: [io  0x0061]
Oct  9 23:45:46 hp-laptop kernel: [    0.267658] pnp 00:05: Plug and 
Play ACPI device, IDs PNP0800 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.267673] pnp 00:06: [io  
0x0070-0x0071]
Oct  9 23:45:46 hp-laptop kernel: [    0.267677] pnp 00:06: [io  
0x0072-0x0073]
Oct  9 23:45:46 hp-laptop kernel: [    0.267686] pnp 00:06: [irq 8]
Oct  9 23:45:46 hp-laptop kernel: [    0.267723] pnp 00:06: Plug and 
Play ACPI device, IDs PNP0b00 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.267756] pnp 00:07: [io  0x0060]
Oct  9 23:45:46 hp-laptop kernel: [    0.267759] pnp 00:07: [io  0x0064]
Oct  9 23:45:46 hp-laptop kernel: [    0.267768] pnp 00:07: [irq 1]
Oct  9 23:45:46 hp-laptop kernel: [    0.267805] pnp 00:07: Plug and 
Play ACPI device, IDs PNP0303 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.267825] pnp 00:08: [irq 12]
Oct  9 23:45:46 hp-laptop kernel: [    0.267867] pnp 00:08: Plug and 
Play ACPI device, IDs SYN0118 SYN0100 SYN0002 PNP0f13 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.268061] pnp 00:09: [io  
0x0010-0x001f]
Oct  9 23:45:46 hp-laptop kernel: [    0.268064] pnp 00:09: [io  
0x002e-0x002f]
Oct  9 23:45:46 hp-laptop kernel: [    0.268068] pnp 00:09: [io  
0x004e-0x004f]
Oct  9 23:45:46 hp-laptop kernel: [    0.268071] pnp 00:09: [io  0x0092]
Oct  9 23:45:46 hp-laptop kernel: [    0.268073] pnp 00:09: [io  
0x00b0-0x00b1]
Oct  9 23:45:46 hp-laptop kernel: [    0.268076] pnp 00:09: [io  0x040b]
Oct  9 23:45:46 hp-laptop kernel: [    0.268080] pnp 00:09: [io  
0x04d0-0x04d1]
Oct  9 23:45:46 hp-laptop kernel: [    0.268083] pnp 00:09: [io  0x04d6]
Oct  9 23:45:46 hp-laptop kernel: [    0.268085] pnp 00:09: [io  
0x0500-0x051f]
Oct  9 23:45:46 hp-laptop kernel: [    0.268088] pnp 00:09: [io  
0x0c00-0x0c01]
Oct  9 23:45:46 hp-laptop kernel: [    0.268093] pnp 00:09: [io  0x0c14]
Oct  9 23:45:46 hp-laptop kernel: [    0.268096] pnp 00:09: [io  
0x0c50-0x0c51]
Oct  9 23:45:46 hp-laptop kernel: [    0.268099] pnp 00:09: [io  0x0c52]
Oct  9 23:45:46 hp-laptop kernel: [    0.268102] pnp 00:09: [io  0x0c6c]
Oct  9 23:45:46 hp-laptop kernel: [    0.268105] pnp 00:09: [io  0x0c6f]
Oct  9 23:45:46 hp-laptop kernel: [    0.268108] pnp 00:09: [io  
0x0cd4-0x0cdf]
Oct  9 23:45:46 hp-laptop kernel: [    0.268112] pnp 00:09: [mem 
0xffb00000-0xffbfffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.268115] pnp 00:09: [mem 
0xfff00000-0xffffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.268210] system 00:09: [io  
0x040b] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268213] system 00:09: [io  
0x04d0-0x04d1] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268217] system 00:09: [io  
0x04d6] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268221] system 00:09: [io  
0x0500-0x051f] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268225] system 00:09: [io  
0x0c00-0x0c01] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268229] system 00:09: [io  
0x0c14] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268233] system 00:09: [io  
0x0c50-0x0c51] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268236] system 00:09: [io  
0x0c52] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268240] system 00:09: [io  
0x0c6c] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268244] system 00:09: [io  
0x0c6f] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268247] system 00:09: [io  
0x0cd4-0x0cdf] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268252] system 00:09: [mem 
0xffb00000-0xffbfffff] could not be reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268256] system 00:09: [mem 
0xfff00000-0xffffffff] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268260] system 00:09: Plug and 
Play ACPI device, IDs PNP0c02 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.268704] pnp 00:0a: [io  
0x8000-0x802f]
Oct  9 23:45:46 hp-laptop kernel: [    0.268707] pnp 00:0a: [io  
0x8100-0x811f]
Oct  9 23:45:46 hp-laptop kernel: [    0.268711] pnp 00:0a: [mem 
0xe0000000-0xefffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.268714] pnp 00:0a: [mem 
0xfec00000-0xfec00fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.268806] system 00:0a: [io  
0x8000-0x802f] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268810] system 00:0a: [io  
0x8100-0x811f] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268814] system 00:0a: [mem 
0xe0000000-0xefffffff] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268819] system 00:0a: [mem 
0xfec00000-0xfec00fff] could not be reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.268823] system 00:0a: Plug and 
Play ACPI device, IDs PNP0c02 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.269143] pnp 00:0b: [mem 
0x78000000-0x7fffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.269147] pnp 00:0b: [mem 
0xfee00000-0xfee00fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.269238] system 00:0b: [mem 
0x78000000-0x7fffffff] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.269242] system 00:0b: [mem 
0xfee00000-0xfee00fff] has been reserved
Oct  9 23:45:46 hp-laptop kernel: [    0.269246] system 00:0b: Plug and 
Play ACPI device, IDs PNP0c02 (active)
Oct  9 23:45:46 hp-laptop kernel: [    0.269264] pnp: PnP ACPI: found 12 
devices
Oct  9 23:45:46 hp-laptop kernel: [    0.269267] ACPI: ACPI bus type pnp 
unregistered
Oct  9 23:45:46 hp-laptop kernel: [    0.276333] Switching to 
clocksource acpi_pm
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] PCI: max bus depth: 2 
pci_try_num: 3
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:14.4: BAR 
15: assigned [mem 0x80000000-0x83ffffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:04.0: BAR 
15: assigned [mem 0x84000000-0x840fffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:12.0: BAR 
6: assigned [mem 0x84100000-0x8417ffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:14.2: BAR 
0: assigned [mem 0x84180000-0x84183fff 64bit]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:14.2: BAR 
0: set to [mem 0x84180000-0x84183fff 64bit] (PCI address 
[0x84180000-0x84183fff])
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:14.4: BAR 
13: assigned [io  0x1000-0x1fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:01:05.0: BAR 
6: assigned [mem 0xd0420000-0xd043ffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:01.0: PCI 
bridge to [bus 01-01]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:01.0:   
bridge window [io  0x5000-0x5fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:01.0:   
bridge window [mem 0xd0400000-0xd04fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:01.0:   
bridge window [mem 0xc0000000-0xc7ffffff 64bit pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:10:00.0: BAR 
6: assigned [mem 0x84000000-0x8400ffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:04.0: PCI 
bridge to [bus 10-10]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:04.0:   
bridge window [io  0x4000-0x4fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:04.0:   
bridge window [mem 0xd0000000-0xd00fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:04.0:   
bridge window [mem 0x84000000-0x840fffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:05.0: PCI 
bridge to [bus 20-20]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:05.0:   
bridge window [io  0x2000-0x3fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:05.0:   
bridge window [mem 0xcc000000-0xcfffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:05.0:   
bridge window [mem pref disabled]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:06.0: PCI 
bridge to [bus 30-30]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:06.0:   
bridge window [io  disabled]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:06.0:   
bridge window [mem 0xc8000000-0xc80fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:06.0:   
bridge window [mem pref disabled]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0: BAR 
15: assigned [mem 0x80000000-0x83ffffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0: BAR 
16: assigned [mem 0x88000000-0x8bffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0: BAR 
13: assigned [io  0x1000-0x10ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0: BAR 
14: assigned [io  0x1400-0x14ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0: 
CardBus bridge to [bus 03-06]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0:   
bridge window [io  0x1000-0x10ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0:   
bridge window [io  0x1400-0x14ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0:   
bridge window [mem 0x80000000-0x83ffffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0:   
bridge window [mem 0x88000000-0x8bffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:14.4: PCI 
bridge to [bus 02-03]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:14.4:   
bridge window [io  0x1000-0x1fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:14.4:   
bridge window [mem 0xd0100000-0xd03fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:14.4:   
bridge window [mem 0x80000000-0x83ffffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:04.0: 
setting latency timer to 64
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:05.0: 
setting latency timer to 64
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:00:06.0: 
setting latency timer to 64
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci 0000:02:04.0: PCI 
INT A -> GSI 20 (level, low) -> IRQ 20
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:00: 
resource 4 [io  0x0000-0xffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:00: 
resource 5 [mem 0x80000000-0xfcffffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:00: 
resource 6 [mem 0x000a0000-0x000bffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:01: 
resource 0 [io  0x5000-0x5fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:01: 
resource 1 [mem 0xd0400000-0xd04fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:01: 
resource 2 [mem 0xc0000000-0xc7ffffff 64bit pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:10: 
resource 0 [io  0x4000-0x4fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:10: 
resource 1 [mem 0xd0000000-0xd00fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:10: 
resource 2 [mem 0x84000000-0x840fffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:20: 
resource 0 [io  0x2000-0x3fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:20: 
resource 1 [mem 0xcc000000-0xcfffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:30: 
resource 1 [mem 0xc8000000-0xc80fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:02: 
resource 0 [io  0x1000-0x1fff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:02: 
resource 1 [mem 0xd0100000-0xd03fffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:02: 
resource 2 [mem 0x80000000-0x83ffffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:02: 
resource 4 [io  0x0000-0xffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:02: 
resource 5 [mem 0x80000000-0xfcffffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:02: 
resource 6 [mem 0x000a0000-0x000bffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:03: 
resource 0 [io  0x1000-0x10ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:03: 
resource 1 [io  0x1400-0x14ff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:03: 
resource 2 [mem 0x80000000-0x83ffffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] pci_bus 0000:03: 
resource 3 [mem 0x88000000-0x8bffffff]
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] NET: Registered 
protocol family 2
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] IP route cache hash 
table entries: 65536 (order: 7, 524288 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.280017] TCP established hash 
table entries: 262144 (order: 10, 4194304 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.283743] Switched to NOHz mode 
on CPU #1
Oct  9 23:45:46 hp-laptop kernel: [    0.283747] Switched to NOHz mode 
on CPU #0
Oct  9 23:45:46 hp-laptop kernel: [    0.284229] TCP bind hash table 
entries: 65536 (order: 8, 1048576 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.284774] TCP: Hash tables 
configured (established 262144 bind 65536)
Oct  9 23:45:46 hp-laptop kernel: [    0.284778] TCP reno registered
Oct  9 23:45:46 hp-laptop kernel: [    0.284790] UDP hash table entries: 
1024 (order: 3, 32768 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.284820] UDP-Lite hash table 
entries: 1024 (order: 3, 32768 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.285056] NET: Registered 
protocol family 1
Oct  9 23:45:46 hp-laptop kernel: [    0.285071] pci 0000:00:00.0: MSI 
quirk detected; MSI disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.285080] pci 0000:00:01.0: MSI 
quirk detected; subordinate MSI disabled
Oct  9 23:45:46 hp-laptop kernel: [    0.285188] pci 0000:01:05.0: Boot 
video device
Oct  9 23:45:46 hp-laptop kernel: [    0.285220] PCI: CLS 64 bytes, 
default 64
Oct  9 23:45:46 hp-laptop kernel: [    0.285287] Unpacking initramfs...
Oct  9 23:45:46 hp-laptop kernel: [    0.728770] Freeing initrd memory: 
14668k freed
Oct  9 23:45:46 hp-laptop kernel: [    0.740487] audit: initializing 
netlink socket (disabled)
Oct  9 23:45:46 hp-laptop kernel: [    0.740505] type=2000 
audit(1318203934.736:1): initialized
Oct  9 23:45:46 hp-laptop kernel: [    0.766185] HugeTLB registered 2 MB 
page size, pre-allocated 0 pages
Oct  9 23:45:46 hp-laptop kernel: [    0.783902] VFS: Disk quotas 
dquot_6.5.2
Oct  9 23:45:46 hp-laptop kernel: [    0.783965] Dquot-cache hash table 
entries: 512 (order 0, 4096 bytes)
Oct  9 23:45:46 hp-laptop kernel: [    0.784090] msgmni has been set to 3765
Oct  9 23:45:46 hp-laptop kernel: [    0.784446] alg: No test for stdrng 
(krng)
Oct  9 23:45:46 hp-laptop kernel: [    0.784509] Block layer SCSI 
generic (bsg) driver version 0.4 loaded (major 253)
Oct  9 23:45:46 hp-laptop kernel: [    0.784513] io scheduler noop 
registered
Oct  9 23:45:46 hp-laptop kernel: [    0.784515] io scheduler deadline 
registered
Oct  9 23:45:46 hp-laptop kernel: [    0.784560] io scheduler cfq 
registered (default)
Oct  9 23:45:46 hp-laptop kernel: [    0.785230] ERST: Table is not found!
Oct  9 23:45:46 hp-laptop kernel: [    0.785325] Serial: 8250/16550 
driver, 4 ports, IRQ sharing enabled
Oct  9 23:45:46 hp-laptop kernel: [    0.824511] Linux agpgart interface 
v0.103
Oct  9 23:45:46 hp-laptop kernel: [    0.824671] i8042: PNP: PS/2 
Controller [PNP0303:C21E,PNP0f13:C21F] at 0x60,0x64 irq 1,12
Oct  9 23:45:46 hp-laptop kernel: [    0.826324] i8042: Detected active 
multiplexing controller, rev 1.1
Oct  9 23:45:46 hp-laptop kernel: [    0.827073] serio: i8042 KBD port 
at 0x60,0x64 irq 1
Oct  9 23:45:46 hp-laptop kernel: [    0.827082] serio: i8042 AUX0 port 
at 0x60,0x64 irq 12
Oct  9 23:45:46 hp-laptop kernel: [    0.827122] serio: i8042 AUX1 port 
at 0x60,0x64 irq 12
Oct  9 23:45:46 hp-laptop kernel: [    0.827155] serio: i8042 AUX2 port 
at 0x60,0x64 irq 12
Oct  9 23:45:46 hp-laptop kernel: [    0.827188] serio: i8042 AUX3 port 
at 0x60,0x64 irq 12
Oct  9 23:45:46 hp-laptop kernel: [    0.827337] mousedev: PS/2 mouse 
device common for all mice
Oct  9 23:45:46 hp-laptop kernel: [    0.827411] rtc_cmos 00:06: RTC can 
wake from S4
Oct  9 23:45:46 hp-laptop kernel: [    0.827551] rtc_cmos 00:06: rtc 
core: registered rtc_cmos as rtc0
Oct  9 23:45:46 hp-laptop kernel: [    0.827585] rtc0: alarms up to one 
month, y3k, 114 bytes nvram
Oct  9 23:45:46 hp-laptop kernel: [    0.827599] cpuidle: using governor 
ladder
Oct  9 23:45:46 hp-laptop kernel: [    0.827602] cpuidle: using governor 
menu
Oct  9 23:45:46 hp-laptop kernel: [    0.827910] TCP cubic registered
Oct  9 23:45:46 hp-laptop kernel: [    0.828071] NET: Registered 
protocol family 10
Oct  9 23:45:46 hp-laptop kernel: [    0.828828] Mobile IPv6
Oct  9 23:45:46 hp-laptop kernel: [    0.828831] NET: Registered 
protocol family 17
Oct  9 23:45:46 hp-laptop kernel: [    0.828837] Registering the 
dns_resolver key type
Oct  9 23:45:46 hp-laptop kernel: [    0.828989] PM: Hibernation image 
not present or could not be loaded.
Oct  9 23:45:46 hp-laptop kernel: [    0.829004] registered taskstats 
version 1
Oct  9 23:45:46 hp-laptop kernel: [    0.838155] rtc_cmos 00:06: setting 
system clock to 2011-10-09 23:45:35 UTC (1318203935)
Oct  9 23:45:46 hp-laptop kernel: [    0.838218] Initializing network 
drop monitor service
Oct  9 23:45:46 hp-laptop kernel: [    0.839838] Freeing unused kernel 
memory: 560k freed
Oct  9 23:45:46 hp-laptop kernel: [    0.840149] Write protecting the 
kernel read-only data: 6144k
Oct  9 23:45:46 hp-laptop kernel: [    0.844424] Freeing unused kernel 
memory: 752k freed
Oct  9 23:45:46 hp-laptop kernel: [    0.848928] Freeing unused kernel 
memory: 720k freed
Oct  9 23:45:46 hp-laptop kernel: [    0.852916] input: AT Translated 
Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
Oct  9 23:45:46 hp-laptop kernel: [    0.938166] input: Sleep Button as 
/devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input1
Oct  9 23:45:46 hp-laptop kernel: [    0.938175] ACPI: Sleep Button [C266]
Oct  9 23:45:46 hp-laptop kernel: [    0.938255] input: Lid Switch as 
/devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2
Oct  9 23:45:46 hp-laptop kernel: [    0.938341] ACPI: Lid Switch [C267]
Oct  9 23:45:46 hp-laptop kernel: [    0.938426] input: Power Button as 
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
Oct  9 23:45:46 hp-laptop kernel: [    0.938430] ACPI: Power Button [PWRF]
Oct  9 23:45:46 hp-laptop kernel: [    0.947745] SCSI subsystem initialized
Oct  9 23:45:46 hp-laptop kernel: [    0.951257] usbcore: registered new 
interface driver usbfs
Oct  9 23:45:46 hp-laptop kernel: [    0.951290] usbcore: registered new 
interface driver hub
Oct  9 23:45:46 hp-laptop kernel: [    0.951776] tg3.c:v3.119 (May 18, 2011)
Oct  9 23:45:46 hp-laptop kernel: [    0.951813] tg3 0000:02:01.0: PCI 
INT A -> GSI 23 (level, low) -> IRQ 23
Oct  9 23:45:46 hp-laptop kernel: [    0.951940] b43-pci-bridge 
0000:30:00.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
Oct  9 23:45:46 hp-laptop kernel: [    0.951948] b43-pci-bridge 
0000:30:00.0: setting latency timer to 64
Oct  9 23:45:46 hp-laptop kernel: [    0.958016] usbcore: registered new 
device driver usb
Oct  9 23:45:46 hp-laptop kernel: [    0.958831] ehci_hcd: USB 2.0 
'Enhanced' Host Controller (EHCI) Driver
Oct  9 23:45:46 hp-laptop kernel: [    0.986848] ssb: Core 0 found: 
ChipCommon (cc 0x800, rev 0x11, vendor 0x4243)
Oct  9 23:45:46 hp-laptop kernel: [    0.986863] ssb: Core 1 found: IEEE 
802.11 (cc 0x812, rev 0x0A, vendor 0x4243)
Oct  9 23:45:46 hp-laptop kernel: [    0.986871] ssb: Core 2 found: USB 
1.1 Host (cc 0x817, rev 0x03, vendor 0x4243)
Oct  9 23:45:46 hp-laptop kernel: [    0.986879] ssb: Core 3 found: 
PCI-E (cc 0x820, rev 0x01, vendor 0x4243)
Oct  9 23:45:46 hp-laptop kernel: [    0.988066] ehci_hcd 0000:00:13.2: 
PCI INT A -> GSI 19 (level, low) -> IRQ 19
Oct  9 23:45:46 hp-laptop kernel: [    0.988090] ehci_hcd 0000:00:13.2: 
EHCI Host Controller
Oct  9 23:45:46 hp-laptop kernel: [    0.988128] ehci_hcd 0000:00:13.2: 
new USB bus registered, assigned bus number 1
Oct  9 23:45:46 hp-laptop kernel: [    0.988224] ehci_hcd 0000:00:13.2: 
irq 19, io mem 0xd0503000
Oct  9 23:45:46 hp-laptop kernel: [    1.001882] ACPI: Fan [C364] (off)
Oct  9 23:45:46 hp-laptop kernel: [    1.001942] ACPI: Fan [C365] (off)
Oct  9 23:45:46 hp-laptop kernel: [    1.001995] ACPI: Fan [C366] (off)
Oct  9 23:45:46 hp-laptop kernel: [    1.002047] ACPI: Fan [C367] (off)
Oct  9 23:45:46 hp-laptop kernel: [    1.002376] libata version 3.00 loaded.
Oct  9 23:45:46 hp-laptop kernel: [    1.014102] ehci_hcd 0000:00:13.2: 
USB 2.0 started, EHCI 1.00
Oct  9 23:45:46 hp-laptop kernel: [    1.014142] usb usb1: New USB 
device found, idVendor=1d6b, idProduct=0002
Oct  9 23:45:46 hp-laptop kernel: [    1.014145] usb usb1: New USB 
device strings: Mfr=3, Product=2, SerialNumber=1
Oct  9 23:45:46 hp-laptop kernel: [    1.014149] usb usb1: Product: EHCI 
Host Controller
Oct  9 23:45:46 hp-laptop kernel: [    1.014151] usb usb1: Manufacturer: 
Linux 3.0.0-1-amd64 ehci_hcd
Oct  9 23:45:46 hp-laptop kernel: [    1.014154] usb usb1: SerialNumber: 
0000:00:13.2
Oct  9 23:45:46 hp-laptop kernel: [    1.014329] hub 1-0:1.0: USB hub found
Oct  9 23:45:46 hp-laptop kernel: [    1.014335] hub 1-0:1.0: 8 ports 
detected
Oct  9 23:45:46 hp-laptop kernel: [    1.015147] ohci_hcd: USB 1.1 
'Open' Host Controller (OHCI) Driver
Oct  9 23:45:46 hp-laptop kernel: [    1.025509] ahci 0000:10:00.0: 
version 3.0
Oct  9 23:45:46 hp-laptop kernel: [    1.025552] ahci 0000:10:00.0: PCI 
INT A -> GSI 16 (level, low) -> IRQ 16
Oct  9 23:45:46 hp-laptop kernel: [    1.032139] ohci_hcd 0000:00:13.0: 
PCI INT A -> GSI 19 (level, low) -> IRQ 19
Oct  9 23:45:46 hp-laptop kernel: [    1.032181] ohci_hcd 0000:00:13.0: 
OHCI Host Controller
Oct  9 23:45:46 hp-laptop kernel: [    1.032216] ohci_hcd 0000:00:13.0: 
new USB bus registered, assigned bus number 2
Oct  9 23:45:46 hp-laptop kernel: [    1.032257] ohci_hcd 0000:00:13.0: 
irq 19, io mem 0xd0501000
Oct  9 23:45:46 hp-laptop kernel: [    1.032956] tg3 0000:02:01.0: eth0: 
Tigon3 [partno(BCM95788A50) rev 3003] (PCI:33MHz:32-bit) MAC address 
00:17:a4:d6:bf:87
Oct  9 23:45:46 hp-laptop kernel: [    1.032962] tg3 0000:02:01.0: eth0: 
attached PHY is 5705 (10/100/1000Base-T Ethernet) (WireSpeed[0], EEE[0])
Oct  9 23:45:46 hp-laptop kernel: [    1.032966] tg3 0000:02:01.0: eth0: 
RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
Oct  9 23:45:46 hp-laptop kernel: [    1.032970] tg3 0000:02:01.0: eth0: 
dma_rwctrl[763f0000] dma_mask[32-bit]
Oct  9 23:45:46 hp-laptop kernel: [    1.040115] ahci 0000:10:00.0: AHCI 
0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode
Oct  9 23:45:46 hp-laptop kernel: [    1.040121] ahci 0000:10:00.0: 
flags: 64bit ncq pm led clo pmp pio slum part
Oct  9 23:45:46 hp-laptop kernel: [    1.040130] ahci 0000:10:00.0: 
setting latency timer to 64
Oct  9 23:45:46 hp-laptop kernel: [    1.044136] sdhci: Secure Digital 
Host Controller Interface driver
Oct  9 23:45:46 hp-laptop kernel: [    1.044140] sdhci: Copyright(c) 
Pierre Ossman
Oct  9 23:45:46 hp-laptop kernel: [    1.048570] scsi0 : ahci
Oct  9 23:45:46 hp-laptop kernel: [    1.050875] [Firmware Bug]: ACPI: 
No _BQC method, cannot determine initial brightness
Oct  9 23:45:46 hp-laptop kernel: [    1.050983] [Firmware Bug]: _BCQ is 
used instead of _BQC
Oct  9 23:45:46 hp-laptop kernel: [    1.062332] scsi1 : ahci
Oct  9 23:45:46 hp-laptop kernel: [    1.062452] ata1: SATA max UDMA/133 
abar m8192@0xd0000000 port 0xd0000100 irq 16
Oct  9 23:45:46 hp-laptop kernel: [    1.062457] ata2: SATA max UDMA/133 
abar m8192@0xd0000000 port 0xd0000180 irq 16
Oct  9 23:45:46 hp-laptop kernel: [    1.066961] sdhci-pci 0000:02:04.3: 
SDHCI controller found [104c:803c] (rev 0)
Oct  9 23:45:46 hp-laptop kernel: [    1.066988] sdhci-pci 0000:02:04.3: 
PCI INT A -> GSI 20 (level, low) -> IRQ 20
Oct  9 23:45:46 hp-laptop kernel: [    1.067071] mmc0: no vmmc regulator 
found
Oct  9 23:45:46 hp-laptop kernel: [    1.067135] Registered led device: 
mmc0::
Oct  9 23:45:46 hp-laptop kernel: [    1.067195] mmc0: SDHCI controller 
on PCI [0000:02:04.3] using PIO
Oct  9 23:45:46 hp-laptop kernel: [    1.067259] pata_jmicron 
0000:10:00.1: enabling device (0000 -> 0001)
Oct  9 23:45:46 hp-laptop kernel: [    1.067286] pata_jmicron 
0000:10:00.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
Oct  9 23:45:46 hp-laptop kernel: [    1.067340] pata_jmicron 
0000:10:00.1: setting latency timer to 64
Oct  9 23:45:46 hp-laptop kernel: [    1.069188] [drm] Initialized drm 
1.1.0 20060810
Oct  9 23:45:46 hp-laptop kernel: [    1.071481] acpi device:03: 
registered as cooling_device4
Oct  9 23:45:46 hp-laptop kernel: [    1.071651] scsi2 : pata_jmicron
Oct  9 23:45:46 hp-laptop kernel: [    1.071778] scsi3 : pata_jmicron
Oct  9 23:45:46 hp-laptop kernel: [    1.071838] ata3: PATA max UDMA/100 
cmd 0x4000 ctl 0x4008 bmdma 0x4020 irq 17
Oct  9 23:45:46 hp-laptop kernel: [    1.071842] ata4: PATA max UDMA/100 
cmd 0x4010 ctl 0x4018 bmdma 0x4028 irq 17
Oct  9 23:45:46 hp-laptop kernel: [    1.072458] thermal LNXTHERM:00: 
registered as thermal_zone0
Oct  9 23:45:46 hp-laptop kernel: [    1.072463] ACPI: Thermal Zone 
[TZ1] (56 C)
Oct  9 23:45:46 hp-laptop kernel: [    1.072818] input: Video Bus as 
/devices/LNXSYSTM:00/device:00/PNP0A03:00/device:01/LNXVIDEO:00/input/input4
Oct  9 23:45:46 hp-laptop kernel: [    1.072826] ACPI: Video Device 
[C07B] (multi-head: yes  rom: no  post: no)
Oct  9 23:45:46 hp-laptop kernel: [    1.075866] thermal LNXTHERM:01: 
registered as thermal_zone1
Oct  9 23:45:46 hp-laptop kernel: [    1.075869] ACPI: Thermal Zone 
[TZ2] (48 C)
Oct  9 23:45:46 hp-laptop kernel: [    1.086654] thermal LNXTHERM:02: 
registered as thermal_zone2
Oct  9 23:45:46 hp-laptop kernel: [    1.086658] ACPI: Thermal Zone 
[TZ3] (29 C)
Oct  9 23:45:46 hp-laptop kernel: [    1.092285] usb usb2: New USB 
device found, idVendor=1d6b, idProduct=0001
Oct  9 23:45:46 hp-laptop kernel: [    1.092295] usb usb2: New USB 
device strings: Mfr=3, Product=2, SerialNumber=1
Oct  9 23:45:46 hp-laptop kernel: [    1.092298] usb usb2: Product: OHCI 
Host Controller
Oct  9 23:45:46 hp-laptop kernel: [    1.092301] usb usb2: Manufacturer: 
Linux 3.0.0-1-amd64 ohci_hcd
Oct  9 23:45:46 hp-laptop kernel: [    1.092304] usb usb2: SerialNumber: 
0000:00:13.0
Oct  9 23:45:46 hp-laptop kernel: [    1.092834] hub 2-0:1.0: USB hub found
Oct  9 23:45:46 hp-laptop kernel: [    1.092847] hub 2-0:1.0: 4 ports 
detected
Oct  9 23:45:46 hp-laptop kernel: [    1.093051] ohci_hcd 0000:00:13.1: 
PCI INT A -> GSI 19 (level, low) -> IRQ 19
Oct  9 23:45:46 hp-laptop kernel: [    1.093084] ohci_hcd 0000:00:13.1: 
OHCI Host Controller
Oct  9 23:45:46 hp-laptop kernel: [    1.093095] ohci_hcd 0000:00:13.1: 
new USB bus registered, assigned bus number 3
Oct  9 23:45:46 hp-laptop kernel: [    1.093127] ohci_hcd 0000:00:13.1: 
irq 19, io mem 0xd0502000
Oct  9 23:45:46 hp-laptop kernel: [    1.116147] ssb: Sonics Silicon 
Backplane found on PCI device 0000:30:00.0
Oct  9 23:45:46 hp-laptop kernel: [    1.152074] usb usb3: New USB 
device found, idVendor=1d6b, idProduct=0001
Oct  9 23:45:46 hp-laptop kernel: [    1.152079] usb usb3: New USB 
device strings: Mfr=3, Product=2, SerialNumber=1
Oct  9 23:45:46 hp-laptop kernel: [    1.152082] usb usb3: Product: OHCI 
Host Controller
Oct  9 23:45:46 hp-laptop kernel: [    1.152085] usb usb3: Manufacturer: 
Linux 3.0.0-1-amd64 ohci_hcd
Oct  9 23:45:46 hp-laptop kernel: [    1.152087] usb usb3: SerialNumber: 
0000:00:13.1
Oct  9 23:45:46 hp-laptop kernel: [    1.152249] hub 3-0:1.0: USB hub found
Oct  9 23:45:46 hp-laptop kernel: [    1.152262] hub 3-0:1.0: 4 ports 
detected
Oct  9 23:45:46 hp-laptop kernel: [    1.152573] pata_atiixp 
0000:00:14.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Oct  9 23:45:46 hp-laptop kernel: [    1.153129] scsi4 : pata_atiixp
Oct  9 23:45:46 hp-laptop kernel: [    1.153231] scsi5 : pata_atiixp
Oct  9 23:45:46 hp-laptop kernel: [    1.153765] ata5: PATA max UDMA/100 
cmd 0x1f0 ctl 0x3f6 bmdma 0x6040 irq 14
Oct  9 23:45:46 hp-laptop kernel: [    1.153769] ata6: PATA max UDMA/100 
cmd 0x170 ctl 0x376 bmdma 0x6048 irq 15
Oct  9 23:45:46 hp-laptop kernel: [    1.153890] sata_sil 0000:00:12.0: 
version 2.4
Oct  9 23:45:46 hp-laptop kernel: [    1.153894] sata_sil 0000:00:12.0: 
quirky BIOS, skipping spindown on poweroff and hibernation
Oct  9 23:45:46 hp-laptop kernel: [    1.153933] sata_sil 0000:00:12.0: 
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Oct  9 23:45:46 hp-laptop kernel: [    1.154321] scsi6 : sata_sil
Oct  9 23:45:46 hp-laptop kernel: [    1.154418] scsi7 : sata_sil
Oct  9 23:45:46 hp-laptop kernel: [    1.154599] ata7: SATA max UDMA/100 
mmio m512@0xd0509000 tf 0xd0509080 irq 16
Oct  9 23:45:46 hp-laptop kernel: [    1.154604] ata8: SATA max UDMA/100 
mmio m512@0xd0509000 tf 0xd05090c0 irq 16
Oct  9 23:45:46 hp-laptop kernel: [    1.332662] ata5.00: ATAPI: PIONEER 
DVD-RW  DVRKD08, 1.00, max UDMA/33
Oct  9 23:45:46 hp-laptop kernel: [    1.364590] ata5.00: configured for 
UDMA/33
Oct  9 23:45:46 hp-laptop kernel: [    1.388073] ata2: SATA link down 
(SStatus 0 SControl 300)
Oct  9 23:45:46 hp-laptop kernel: [    1.412082] ata1: SATA link down 
(SStatus 0 SControl 300)
Oct  9 23:45:46 hp-laptop kernel: [    1.414084] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:45:46 hp-laptop kernel: [    1.414134] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:45:46 hp-laptop kernel: [    1.414183] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:45:46 hp-laptop kernel: [    1.414234] ata1: hard resetting link
Oct  9 23:45:46 hp-laptop kernel: [    1.480080] ata7: SATA link up 1.5 
Gbps (SStatus 113 SControl 300)
Oct  9 23:45:46 hp-laptop kernel: [    1.488359] ata7.00: ATA-7: FUJITSU 
MHV2080BH PL, 892C, max UDMA/100
Oct  9 23:45:46 hp-laptop kernel: [    1.488363] ata7.00: 156301488 
sectors, multi 16: LBA48
Oct  9 23:45:46 hp-laptop kernel: [    1.504366] ata7.00: configured for 
UDMA/100
Oct  9 23:45:46 hp-laptop kernel: [    1.588024] scsi 4:0:0:0: 
CD-ROM            PIONEER  DVD-RW  DVRKD08  1.00 PQ: 0 ANSI: 5
Oct  9 23:45:46 hp-laptop kernel: [    1.588379] scsi 6:0:0:0: 
Direct-Access     ATA      FUJITSU MHV2080B 892C PQ: 0 ANSI: 5
Oct  9 23:45:46 hp-laptop kernel: [    1.684048] usb 2-3: new low speed 
USB device number 2 using ohci_hcd
Oct  9 23:45:46 hp-laptop kernel: [    1.890102] usb 2-3: New USB device 
found, idVendor=15d9, idProduct=0a4c
Oct  9 23:45:46 hp-laptop kernel: [    1.890106] usb 2-3: New USB device 
strings: Mfr=0, Product=1, SerialNumber=0
Oct  9 23:45:46 hp-laptop kernel: [    1.890109] usb 2-3: Product:  USB 
OPTICAL MOUSE
Oct  9 23:45:46 hp-laptop kernel: [    1.908085] ata8: SATA link down 
(SStatus 0 SControl 300)
Oct  9 23:45:46 hp-laptop kernel: [    1.934753] [drm] radeon kernel 
modesetting enabled.
Oct  9 23:45:46 hp-laptop kernel: [    1.934927] radeon 0000:01:05.0: 
PCI INT A -> GSI 17 (level, low) -> IRQ 17
Oct  9 23:45:46 hp-laptop kernel: [    1.935290] [drm] initializing 
kernel modesetting (RS480 0x1002:0x5975 0x103C:0x30B0).
Oct  9 23:45:46 hp-laptop kernel: [    1.935316] [drm] register mmio 
base: 0xD0400000
Oct  9 23:45:46 hp-laptop kernel: [    1.935318] [drm] register mmio 
size: 65536
Oct  9 23:45:46 hp-laptop kernel: [    1.935487] [drm] Generation 2 PCI 
interface, using max accessible memory
Oct  9 23:45:46 hp-laptop kernel: [    1.935493] radeon 0000:01:05.0: 
VRAM: 128M 0x0000000078000000 - 0x000000007FFFFFFF (128M used)
Oct  9 23:45:46 hp-laptop kernel: [    1.935497] radeon 0000:01:05.0: 
GTT: 512M 0x0000000080000000 - 0x000000009FFFFFFF
Oct  9 23:45:46 hp-laptop kernel: [    1.935511] [drm] Supports vblank 
timestamp caching Rev 1 (10.10.2010).
Oct  9 23:45:46 hp-laptop kernel: [    1.935513] [drm] Driver supports 
precise vblank timestamp query.
Oct  9 23:45:46 hp-laptop kernel: [    1.935525] [drm] radeon: irq 
initialized.
Oct  9 23:45:46 hp-laptop kernel: [    1.935718] [drm] Detected VRAM 
RAM=128M, BAR=128M
Oct  9 23:45:46 hp-laptop kernel: [    1.935723] [drm] RAM width 128bits DDR
Oct  9 23:45:46 hp-laptop kernel: [    1.935828] [TTM] Zone  kernel: 
Available graphics memory: 965064 kiB.
Oct  9 23:45:46 hp-laptop kernel: [    1.935831] [TTM] Initializing pool 
allocator.
Oct  9 23:45:46 hp-laptop kernel: [    1.935872] [drm] radeon: 128M of 
VRAM memory ready
Oct  9 23:45:46 hp-laptop kernel: [    1.935875] [drm] radeon: 512M of 
GTT memory ready.
Oct  9 23:45:46 hp-laptop kernel: [    1.935904] [drm] GART: num cpu 
pages 131072, num gpu pages 131072
Oct  9 23:45:46 hp-laptop kernel: [    1.938579] input:  USB OPTICAL 
MOUSE as /devices/pci0000:00/0000:00:13.0/usb2/2-3/2-3:1.0/input/input5
Oct  9 23:45:46 hp-laptop kernel: [    1.938757] generic-usb 
0003:15D9:0A4C.0001: input,hidraw0: USB HID v1.11 Mouse [ USB OPTICAL 
MOUSE] on usb-0000:00:13.0-3/input0
Oct  9 23:45:46 hp-laptop kernel: [    1.938995] usbcore: registered new 
interface driver usbhid
Oct  9 23:45:46 hp-laptop kernel: [    1.938998] usbhid: USB HID core driver
Oct  9 23:45:46 hp-laptop kernel: [    1.939746] [drm] radeon: 4 quad 
pipes, 1 z pipes initialized.
Oct  9 23:45:46 hp-laptop kernel: [    1.939956] sr0: scsi3-mmc drive: 
24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
Oct  9 23:45:46 hp-laptop kernel: [    1.939962] cdrom: Uniform CD-ROM 
driver Revision: 3.20
Oct  9 23:45:46 hp-laptop kernel: [    1.940159] sr 4:0:0:0: Attached 
scsi CD-ROM sr0
Oct  9 23:45:46 hp-laptop kernel: [    1.940854] sd 6:0:0:0: [sda] 
156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
Oct  9 23:45:46 hp-laptop kernel: [    1.940920] sd 6:0:0:0: [sda] Write 
Protect is off
Oct  9 23:45:46 hp-laptop kernel: [    1.940924] sd 6:0:0:0: [sda] Mode 
Sense: 00 3a 00 00
Oct  9 23:45:46 hp-laptop kernel: [    1.941429] sd 6:0:0:0: [sda] Write 
cache: enabled, read cache: enabled, doesn't support DPO or FUA
Oct  9 23:45:46 hp-laptop kernel: [    1.948301] sr 4:0:0:0: Attached 
scsi generic sg0 type 5
Oct  9 23:45:46 hp-laptop kernel: [    1.948382] sd 6:0:0:0: Attached 
scsi generic sg1 type 0
Oct  9 23:45:46 hp-laptop kernel: [    1.949559] radeon 0000:01:05.0: WB 
enabled
Oct  9 23:45:46 hp-laptop kernel: [    1.949635] [drm] Loading R300 
Microcode
Oct  9 23:45:46 hp-laptop kernel: [    1.954402] [drm] radeon: ring at 
0x0000000080001000
Oct  9 23:45:46 hp-laptop kernel: [    1.954424] [drm] ring test 
succeeded in 1 usecs
Oct  9 23:45:46 hp-laptop kernel: [    1.954611] [drm] radeon: ib pool 
ready.
Oct  9 23:45:46 hp-laptop kernel: [    1.954690] [drm] ib test succeeded 
in 0 usecs
Oct  9 23:45:46 hp-laptop kernel: [    1.954933] [drm] Panel ID String: SEC
Oct  9 23:45:46 hp-laptop kernel: [    1.954936] [drm] Panel Size 1400x1050
Oct  9 23:45:46 hp-laptop kernel: [    1.967958] [drm] radeon legacy 
LVDS backlight initialized
Oct  9 23:45:46 hp-laptop kernel: [    1.968026] [drm] Radeon Display 
Connectors
Oct  9 23:45:46 hp-laptop kernel: [    1.968028] [drm] Connector 0:
Oct  9 23:45:46 hp-laptop kernel: [    1.968030] [drm]   VGA
Oct  9 23:45:46 hp-laptop kernel: [    1.968032] [drm]   DDC: 0x68 0x68 
0x68 0x68 0x68 0x68 0x68 0x68
Oct  9 23:45:46 hp-laptop kernel: [    1.968035] [drm]   Encoders:
Oct  9 23:45:46 hp-laptop kernel: [    1.968037] [drm]     CRT1: 
INTERNAL_DAC2
Oct  9 23:45:46 hp-laptop kernel: [    1.968039] [drm] Connector 1:
Oct  9 23:45:46 hp-laptop kernel: [    1.968040] [drm]   LVDS
Oct  9 23:45:46 hp-laptop kernel: [    1.968043] [drm]   DDC: 0x198 
0x198 0x19c 0x19c 0x1a0 0x1a0 0x1a4 0x1a4
Oct  9 23:45:46 hp-laptop kernel: [    1.968045] [drm]   Encoders:
Oct  9 23:45:46 hp-laptop kernel: [    1.968047] [drm]     LCD1: 
INTERNAL_LVDS
Oct  9 23:45:46 hp-laptop kernel: [    1.968049] [drm] Connector 2:
Oct  9 23:45:46 hp-laptop kernel: [    1.968051] [drm]   S-video
Oct  9 23:45:46 hp-laptop kernel: [    1.968052] [drm]   Encoders:
Oct  9 23:45:46 hp-laptop kernel: [    1.968054] [drm]     TV1: 
INTERNAL_DAC2
Oct  9 23:45:46 hp-laptop kernel: [    1.977533] [drm] Radeon display 
connector VGA-1: No monitor connected or invalid EDID
Oct  9 23:45:46 hp-laptop kernel: [    1.992024]  sda: sda1 sda2 sda3
Oct  9 23:45:46 hp-laptop kernel: [    1.992439] sd 6:0:0:0: [sda] 
Attached SCSI disk
Oct  9 23:45:46 hp-laptop kernel: [    2.028544] [drm] Radeon display 
connector LVDS-1: Found valid EDID
Oct  9 23:45:46 hp-laptop kernel: [    2.028562] [drm] radeon: power 
management initialized
Oct  9 23:45:46 hp-laptop kernel: [    2.127986] [drm] fb mappable at 
0xC0040000
Oct  9 23:45:46 hp-laptop kernel: [    2.127988] [drm] vram apper at 
0xC0000000
Oct  9 23:45:46 hp-laptop kernel: [    2.127990] [drm] size 5914624
Oct  9 23:45:46 hp-laptop kernel: [    2.127992] [drm] fb depth is 24
Oct  9 23:45:46 hp-laptop kernel: [    2.127993] [drm]    pitch is 5632
Oct  9 23:45:46 hp-laptop kernel: [    2.128085] fbcon: radeondrmfb 
(fb0) is primary device
Oct  9 23:45:46 hp-laptop kernel: [    2.181138] Console: switching to 
colour frame buffer device 175x65
Oct  9 23:45:46 hp-laptop kernel: [    2.196051] usb 3-1: new full speed 
USB device number 2 using ohci_hcd
Oct  9 23:45:46 hp-laptop kernel: [    2.196097] fb0: radeondrmfb frame 
buffer device
Oct  9 23:45:46 hp-laptop kernel: [    2.196099] drm: registered panic 
notifier
Oct  9 23:45:46 hp-laptop kernel: [    2.196106] [drm] Initialized 
radeon 2.10.0 20080528 for 0000:01:05.0 on minor 0
Oct  9 23:45:46 hp-laptop kernel: [    2.401109] usb 3-1: New USB device 
found, idVendor=08ff, idProduct=2580
Oct  9 23:45:46 hp-laptop kernel: [    2.401115] usb 3-1: New USB device 
strings: Mfr=0, Product=1, SerialNumber=0
Oct  9 23:45:46 hp-laptop kernel: [    2.401118] usb 3-1: Product: 
Fingerprint Sensor
Oct  9 23:45:46 hp-laptop kernel: [    2.720439] PM: Starting manual 
resume from disk
Oct  9 23:45:46 hp-laptop kernel: [    2.720445] PM: Hibernation image 
partition 8:3 present
Oct  9 23:45:46 hp-laptop kernel: [    2.720447] PM: Looking for 
hibernation image.
Oct  9 23:45:46 hp-laptop kernel: [    2.720746] PM: Image not found 
(code -22)
Oct  9 23:45:46 hp-laptop kernel: [    2.720751] PM: Hibernation image 
not present or could not be loaded.
Oct  9 23:45:46 hp-laptop kernel: [    2.772594] EXT4-fs (sda2): mounted 
filesystem with ordered data mode. Opts: (null)
Oct  9 23:45:46 hp-laptop kernel: [    3.660068] ata1: COMRESET failed 
(errno=-32)
Oct  9 23:45:46 hp-laptop kernel: [    3.660078] ata1: reset failed 
(errno=-32), retrying in 8 secs
Oct  9 23:45:46 hp-laptop kernel: [    5.203643] ACPI: acpi_idle 
registered with cpuidle
Oct  9 23:45:46 hp-laptop kernel: [    5.203744] ACPI: processor limited 
to max C-state 1
Oct  9 23:45:46 hp-laptop kernel: [    5.212810] ACPI: AC Adapter [C1C3] 
(on-line)
Oct  9 23:45:46 hp-laptop kernel: [    5.258656] wmi: Mapper loaded
Oct  9 23:45:46 hp-laptop kernel: [    5.307105] ACPI: Battery Slot 
[C1C5] (battery present)
Oct  9 23:45:46 hp-laptop kernel: [    5.307204] ACPI: Battery Slot 
[C1C4] (battery absent)
Oct  9 23:45:46 hp-laptop kernel: [    5.321667] tpm_tis 00:02: 1.2 TPM 
(device-id 0xB, rev-id 16)
Oct  9 23:45:46 hp-laptop kernel: [    5.514125] input: PC Speaker as 
/devices/platform/pcspkr/input/input6
Oct  9 23:45:46 hp-laptop kernel: [    5.568261] k8temp 0000:00:18.3: 
Temperature readouts might be wrong - check erratum #141
Oct  9 23:45:46 hp-laptop kernel: [    5.598475] piix4_smbus 
0000:00:14.0: SMBus Host Controller at 0x8200, revision 0
Oct  9 23:45:46 hp-laptop kernel: [    5.639633] cfg80211: Calling CRDA 
to update world regulatory domain
Oct  9 23:45:46 hp-laptop kernel: [    5.652587] pci_hotplug: PCI Hot 
Plug PCI Core version: 0.5
Oct  9 23:45:46 hp-laptop kernel: [    5.655531] Synaptics Touchpad, 
model: 1, fw: 6.2, id: 0x2580b1, caps: 0xa04793/0x300000/0x0
Oct  9 23:45:46 hp-laptop kernel: [    5.655547] serio: Synaptics 
pass-through port at isa0060/serio4/input0
Oct  9 23:45:46 hp-laptop kernel: [    5.661907] shpchp: Standard Hot 
Plug PCI Controller Driver version: 0.4
Oct  9 23:45:46 hp-laptop kernel: [    5.695729] input: SynPS/2 
Synaptics TouchPad as /devices/platform/i8042/serio4/input/input7
Oct  9 23:45:46 hp-laptop kernel: [    5.716217] input: HP WMI hotkeys 
as /devices/virtual/input/input8
Oct  9 23:45:46 hp-laptop kernel: [    5.764256] MCE: In-kernel MCE 
decoding enabled.
Oct  9 23:45:46 hp-laptop kernel: [    5.767309] EDAC MC: Ver: 2.1.0
Oct  9 23:45:46 hp-laptop kernel: [    5.772601] AMD64 EDAC driver v3.4.0
Oct  9 23:45:46 hp-laptop kernel: [    5.772763] EDAC amd64: DRAM ECC 
disabled.
Oct  9 23:45:46 hp-laptop kernel: [    5.772773] EDAC amd64: ECC 
disabled in the BIOS or no ECC capability, module will not load.
Oct  9 23:45:46 hp-laptop kernel: [    5.772776]  Either enable ECC 
checking or force module loading by setting 'ecc_enable_override'.
Oct  9 23:45:46 hp-laptop kernel: [    5.772778]  (Note that use of the 
override may cause unknown side effects.)
Oct  9 23:45:46 hp-laptop kernel: [    5.836932] yenta_cardbus 
0000:02:04.0: CardBus bridge found [103c:30b0]
Oct  9 23:45:46 hp-laptop kernel: [    5.836964] yenta_cardbus 
0000:02:04.0: Enabling burst memory read transactions
Oct  9 23:45:46 hp-laptop kernel: [    5.836971] yenta_cardbus 
0000:02:04.0: Using INTVAL to route CSC interrupts to PCI
Oct  9 23:45:46 hp-laptop kernel: [    5.836974] yenta_cardbus 
0000:02:04.0: Routing CardBus interrupts to PCI
Oct  9 23:45:46 hp-laptop kernel: [    5.836981] yenta_cardbus 
0000:02:04.0: TI: mfunc 0x01a11002, devctl 0x64
Oct  9 23:45:46 hp-laptop kernel: [    6.069040] yenta_cardbus 
0000:02:04.0: ISA IRQ mask 0x0cf8, PCI irq 20
Oct  9 23:45:46 hp-laptop kernel: [    6.069047] yenta_cardbus 
0000:02:04.0: Socket status: 30000006
Oct  9 23:45:46 hp-laptop kernel: [    6.069052] pci_bus 0000:02: 
Raising subordinate bus# of parent bus (#02) from #03 to #06
Oct  9 23:45:46 hp-laptop kernel: [    6.069065] yenta_cardbus 
0000:02:04.0: pcmcia: parent PCI bridge window: [io  0x1000-0x1fff]
Oct  9 23:45:46 hp-laptop kernel: [    6.069070] yenta_cardbus 
0000:02:04.0: pcmcia: parent PCI bridge window: [mem 0xd0100000-0xd03fffff]
Oct  9 23:45:46 hp-laptop kernel: [    6.069075] pcmcia_socket 
pcmcia_socket0: cs: memory probe 0xd0100000-0xd03fffff: excluding 
0xd0100000-0xd012ffff
Oct  9 23:45:46 hp-laptop kernel: [    6.069092] yenta_cardbus 
0000:02:04.0: pcmcia: parent PCI bridge window: [mem 
0x80000000-0x83ffffff pref]
Oct  9 23:45:46 hp-laptop kernel: [    6.069096] pcmcia_socket 
pcmcia_socket0: cs: memory probe 0x80000000-0x83ffffff: excluding 
0x80000000-0x83ffffff
Oct  9 23:45:46 hp-laptop kernel: [    6.165810] b43-phy0: Broadcom 4311 
WLAN found (core revision 10)
Oct  9 23:45:46 hp-laptop kernel: [    6.286540] ieee80211 phy0: 
Selected rate control algorithm 'minstrel_ht'
Oct  9 23:45:46 hp-laptop kernel: [    6.287284] Registered led device: 
b43-phy0::tx
Oct  9 23:45:46 hp-laptop kernel: [    6.287310] Registered led device: 
b43-phy0::rx
Oct  9 23:45:46 hp-laptop kernel: [    6.287338] Registered led device: 
b43-phy0::radio
Oct  9 23:45:46 hp-laptop kernel: [    6.287360] Broadcom 43xx driver 
loaded [ Features: PMNLS, Firmware-ID: FW13 ]
Oct  9 23:45:46 hp-laptop kernel: [    6.551048] pcmcia_socket 
pcmcia_socket0: cs: memory probe 0x0c0000-0x0fffff: excluding 
0xc0000-0xfffff
Oct  9 23:45:46 hp-laptop kernel: [    6.551082] pcmcia_socket 
pcmcia_socket0: cs: memory probe 0xa0000000-0xa0ffffff: clean.
Oct  9 23:45:46 hp-laptop kernel: [    6.551114] pcmcia_socket 
pcmcia_socket0: cs: memory probe 0x60000000-0x60ffffff: excluding 
0x60000000-0x60ffffff
Oct  9 23:45:46 hp-laptop kernel: [    6.572203] tifm_7xx1 0000:02:04.2: 
PCI INT A -> GSI 20 (level, low) -> IRQ 20
Oct  9 23:45:46 hp-laptop kernel: [    6.981156] HDA Intel 0000:00:14.2: 
PCI INT A -> GSI 16 (level, low) -> IRQ 16
Oct  9 23:45:46 hp-laptop kernel: [    7.147503] input: HDA Digital 
PCBeep as /devices/pci0000:00/0000:00:14.2/input/input9
Oct  9 23:45:46 hp-laptop kernel: [    8.319845] Adding 3145724k swap on 
/dev/sda3.  Priority:-1 extents:1 across:3145724k
Oct  9 23:45:46 hp-laptop kernel: [    8.325683] EXT4-fs (sda2): 
re-mounted. Opts: (null)
Oct  9 23:45:46 hp-laptop kernel: [    8.498765] EXT4-fs (sda2): 
re-mounted. Opts: errors=remount-ro
Oct  9 23:45:46 hp-laptop kernel: [    8.554700] loop: module loaded
Oct  9 23:45:46 hp-laptop kernel: [    9.907911] RPC: Registered named 
UNIX socket transport module.
Oct  9 23:45:46 hp-laptop kernel: [    9.907916] RPC: Registered udp 
transport module.
Oct  9 23:45:46 hp-laptop kernel: [    9.907918] RPC: Registered tcp 
transport module.
Oct  9 23:45:46 hp-laptop kernel: [    9.907921] RPC: Registered tcp 
NFSv4.1 backchannel transport module.
Oct  9 23:45:46 hp-laptop kernel: [    9.999650] FS-Cache: Loaded
Oct  9 23:45:46 hp-laptop kernel: [   10.063047] FS-Cache: Netfs 'nfs' 
registered for caching
Oct  9 23:45:46 hp-laptop kernel: [   10.088193] Installing knfsd 
(copyright (C) 1996 okir@monad.swb.de).
Oct  9 23:45:46 hp-laptop kernel: [   10.401339] fuse init (API version 
7.16)
Oct  9 23:45:46 hp-laptop kernel: [   11.412145] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:45:46 hp-laptop kernel: [   11.412152] ata1: hard resetting link
Oct  9 23:45:46 hp-laptop kernel: [   12.136078] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:45:46 hp-laptop kernel: [   12.136097] ata1: EH complete
Oct  9 23:45:46 hp-laptop kernel: [   12.164726] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:45:46 hp-laptop kernel: [   12.164731] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:45:46 hp-laptop kernel: [   12.164736] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:45:46 hp-laptop kernel: [   12.164744] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:45:46 hp-laptop kernel: [   12.164749] ata1: hard resetting link
Oct  9 23:45:47 hp-laptop kernel: [   12.515587] input: ACPI Virtual 
Keyboard Device as /devices/virtual/input/input10
Oct  9 23:45:49 hp-laptop kernel: [   14.464063] ata1: COMRESET failed 
(errno=-32)
Oct  9 23:45:49 hp-laptop kernel: [   14.464072] ata1: reset failed 
(errno=-32), retrying in 8 secs
Oct  9 23:45:50 hp-laptop kernel: [   16.152558] lp: driver loaded but 
no devices found
Oct  9 23:45:50 hp-laptop kernel: [   16.286031] ppdev: user-space 
parallel port driver
Oct  9 23:45:56 hp-laptop kernel: [   22.164070] ata1: hard resetting link
Oct  9 23:45:57 hp-laptop kernel: [   23.304084] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:45:57 hp-laptop kernel: [   23.304104] ata1: EH complete
Oct  9 23:45:57 hp-laptop kernel: [   23.305853] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:45:57 hp-laptop kernel: [   23.305859] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:45:57 hp-laptop kernel: [   23.305864] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:45:57 hp-laptop kernel: [   23.305872] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:45:57 hp-laptop kernel: [   23.305877] ata1: hard resetting link
Oct  9 23:45:59 hp-laptop kernel: [   24.688079] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:45:59 hp-laptop kernel: [   24.688098] ata1: EH complete
Oct  9 23:45:59 hp-laptop kernel: [   24.688919] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:45:59 hp-laptop kernel: [   24.688925] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:45:59 hp-laptop kernel: [   24.688930] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:45:59 hp-laptop kernel: [   24.688939] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:45:59 hp-laptop kernel: [   24.688944] ata1: hard resetting link
Oct  9 23:45:59 hp-laptop kernel: [   24.868718] Disabling lock 
debugging due to kernel taint
Oct  9 23:45:59 hp-laptop kernel: [   24.883180] vboxdrv: Found 2 
processor cores.
Oct  9 23:45:59 hp-laptop kernel: [   24.883523] vboxdrv: fAsync=1 
offMin=0x80fcc offMax=0x80fcc
Oct  9 23:45:59 hp-laptop kernel: [   24.883664] vboxdrv: TSC mode is 
'asynchronous', kernel timer mode is 'normal'.
Oct  9 23:45:59 hp-laptop kernel: [   24.883667] vboxdrv: Successfully 
loaded version 4.0.12 (interface 0x00180000).
Oct  9 23:45:59 hp-laptop kernel: [   24.923487] powernow-k8: Found 1 
AMD Turion(tm) 64 X2 Mobile Technology TL-60 (2 cpu cores) (version 2.20.00)
Oct  9 23:45:59 hp-laptop kernel: [   24.923545] powernow-k8: fid 0xc 
(2000 MHz), vid 0x13
Oct  9 23:45:59 hp-laptop kernel: [   24.923548] powernow-k8: fid 0xa 
(1800 MHz), vid 0x15
Oct  9 23:45:59 hp-laptop kernel: [   24.923550] powernow-k8: fid 0x8 
(1600 MHz), vid 0x17
Oct  9 23:45:59 hp-laptop kernel: [   24.923553] powernow-k8: fid 0x0 
(800 MHz), vid 0x1e
Oct  9 23:46:00 hp-laptop kernel: [   25.864104] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:00 hp-laptop kernel: [   25.864138] ata1: EH complete
Oct  9 23:46:00 hp-laptop kernel: [   25.864352] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:00 hp-laptop kernel: [   25.864363] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:00 hp-laptop kernel: [   25.864374] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:00 hp-laptop kernel: [   25.864392] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:00 hp-laptop kernel: [   25.864402] ata1: hard resetting link
Oct  9 23:46:01 hp-laptop kernel: [   27.068122] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:01 hp-laptop kernel: [   27.068159] ata1: EH complete
Oct  9 23:46:01 hp-laptop kernel: [   27.077634] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:01 hp-laptop kernel: [   27.077646] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:01 hp-laptop kernel: [   27.077657] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:01 hp-laptop kernel: [   27.077676] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:01 hp-laptop kernel: [   27.077688] ata1: hard resetting link
Oct  9 23:46:02 hp-laptop kernel: [   27.804109] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:02 hp-laptop kernel: [   27.804143] ata1: EH complete
Oct  9 23:46:02 hp-laptop kernel: [   27.807479] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:02 hp-laptop kernel: [   27.807493] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:02 hp-laptop kernel: [   27.807507] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:02 hp-laptop kernel: [   27.807527] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:02 hp-laptop kernel: [   27.807538] ata1: hard resetting link
Oct  9 23:46:03 hp-laptop kernel: [   28.528179] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:03 hp-laptop kernel: [   28.528216] ata1: EH complete
Oct  9 23:46:03 hp-laptop kernel: [   28.543595] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:03 hp-laptop kernel: [   28.543612] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:03 hp-laptop kernel: [   28.543625] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:03 hp-laptop kernel: [   28.543649] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:03 hp-laptop kernel: [   28.543661] ata1: hard resetting link
Oct  9 23:46:04 hp-laptop kernel: [   29.536110] b43-phy0: Loading 
firmware version 508.1084 (2009-01-14 01:32:01)
Oct  9 23:46:04 hp-laptop kernel: [   29.610589] ADDRCONF(NETDEV_UP): 
wlan0: link is not ready
Oct  9 23:46:05 hp-laptop kernel: [   31.160105] ata1: COMRESET failed 
(errno=-32)
Oct  9 23:46:05 hp-laptop kernel: [   31.160124] ata1: reset failed 
(errno=-32), retrying in 8 secs
Oct  9 23:46:10 hp-laptop kernel: [   35.698454] ADDRCONF(NETDEV_UP): 
eth0: link is not ready
Oct  9 23:46:13 hp-laptop kernel: [   38.540087] ata1: hard resetting link
Oct  9 23:46:14 hp-laptop kernel: [   39.836088] b43-phy0: Loading 
firmware version 508.1084 (2009-01-14 01:32:01)
Oct  9 23:46:14 hp-laptop kernel: [   39.918326] ADDRCONF(NETDEV_UP): 
wlan0: link is not ready
Oct  9 23:46:14 hp-laptop kernel: [   40.076175] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:14 hp-laptop kernel: [   40.076211] ata1: EH complete
Oct  9 23:46:14 hp-laptop kernel: [   40.132381] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:14 hp-laptop kernel: [   40.132398] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:14 hp-laptop kernel: [   40.132410] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:14 hp-laptop kernel: [   40.132433] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:14 hp-laptop kernel: [   40.132447] ata1: hard resetting link
Oct  9 23:46:15 hp-laptop kernel: [   40.696108] tg3 0000:02:01.0: BAR 
0: set to [mem 0xd0100000-0xd010ffff] (PCI address [0xd0100000-0xd010ffff])
Oct  9 23:46:15 hp-laptop kernel: [   40.860086] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:15 hp-laptop kernel: [   40.860122] ata1: EH complete
Oct  9 23:46:15 hp-laptop kernel: [   40.871770] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:15 hp-laptop kernel: [   40.871781] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:15 hp-laptop kernel: [   40.871792] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:15 hp-laptop kernel: [   40.871810] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:15 hp-laptop kernel: [   40.871820] ata1: hard resetting link
Oct  9 23:46:15 hp-laptop kernel: [   41.002308] ADDRCONF(NETDEV_UP): 
eth0: link is not ready
Oct  9 23:46:16 hp-laptop kernel: [   41.540090] b43-phy0: Loading 
firmware version 508.1084 (2009-01-14 01:32:01)
Oct  9 23:46:16 hp-laptop kernel: [   41.622387] ADDRCONF(NETDEV_UP): 
wlan0: link is not ready
Oct  9 23:46:16 hp-laptop kernel: [   42.032098] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:16 hp-laptop kernel: [   42.032132] ata1: EH complete
Oct  9 23:46:16 hp-laptop kernel: [   42.056234] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:16 hp-laptop kernel: [   42.056245] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:16 hp-laptop kernel: [   42.056256] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:16 hp-laptop kernel: [   42.056275] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:16 hp-laptop kernel: [   42.056285] ata1: hard resetting link
Oct  9 23:46:17 hp-laptop kernel: [   42.780101] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:17 hp-laptop kernel: [   42.780133] ata1: EH complete
Oct  9 23:46:17 hp-laptop kernel: [   42.805307] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:17 hp-laptop kernel: [   42.805317] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:17 hp-laptop kernel: [   42.805327] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:17 hp-laptop kernel: [   42.805345] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:17 hp-laptop kernel: [   42.805355] ata1: hard resetting link
Oct  9 23:46:18 hp-laptop kernel: [   43.592099] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:18 hp-laptop kernel: [   43.592133] ata1: EH complete
Oct  9 23:46:18 hp-laptop kernel: [   43.599101] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:18 hp-laptop kernel: [   43.599110] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:18 hp-laptop kernel: [   43.599120] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:18 hp-laptop kernel: [   43.599139] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:18 hp-laptop kernel: [   43.599149] ata1: hard resetting link
Oct  9 23:46:19 hp-laptop kernel: [   44.520208] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:19 hp-laptop kernel: [   44.520248] ata1: EH complete
Oct  9 23:46:19 hp-laptop kernel: [   44.581225] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:19 hp-laptop kernel: [   44.581239] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:19 hp-laptop kernel: [   44.581252] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:19 hp-laptop kernel: [   44.581272] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:19 hp-laptop kernel: [   44.581282] ata1: hard resetting link
Oct  9 23:46:19 hp-laptop kernel: [   45.304111] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:19 hp-laptop kernel: [   45.304149] ata1: EH complete
Oct  9 23:46:20 hp-laptop kernel: [   45.365250] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:20 hp-laptop kernel: [   45.365263] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:20 hp-laptop kernel: [   45.365275] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:20 hp-laptop kernel: [   45.365297] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:20 hp-laptop kernel: [   45.365307] ata1: hard resetting link
Oct  9 23:46:20 hp-laptop kernel: [   45.388691] wlan0: authenticate 
with 38:22:9d:1b:bc:23 (try 1)
Oct  9 23:46:20 hp-laptop kernel: [   45.390268] wlan0: authenticated
Oct  9 23:46:20 hp-laptop kernel: [   45.390755] wlan0: associate with 
38:22:9d:1b:bc:23 (try 1)
Oct  9 23:46:20 hp-laptop kernel: [   45.411519] wlan0: RX AssocResp 
from 38:22:9d:1b:bc:23 (capab=0x431 status=0 aid=2)
Oct  9 23:46:20 hp-laptop kernel: [   45.411530] wlan0: associated
Oct  9 23:46:20 hp-laptop kernel: [   45.413631] 
ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
Oct  9 23:46:21 hp-laptop kernel: [   46.504210] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:21 hp-laptop kernel: [   46.504246] ata1: EH complete
Oct  9 23:46:21 hp-laptop kernel: [   46.516834] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:21 hp-laptop kernel: [   46.516849] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:21 hp-laptop kernel: [   46.516860] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:21 hp-laptop kernel: [   46.516882] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:21 hp-laptop kernel: [   46.516893] ata1: hard resetting link
Oct  9 23:46:21 hp-laptop kernel: [   47.252113] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:21 hp-laptop kernel: [   47.252147] ata1: EH complete
Oct  9 23:46:21 hp-laptop kernel: [   47.270336] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:21 hp-laptop kernel: [   47.270351] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:21 hp-laptop kernel: [   47.270363] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:21 hp-laptop kernel: [   47.270385] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:21 hp-laptop kernel: [   47.270397] ata1: hard resetting link
Oct  9 23:46:22 hp-laptop kernel: [   48.056142] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:22 hp-laptop kernel: [   48.056178] ata1: EH complete
Oct  9 23:46:22 hp-laptop kernel: [   48.083417] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:22 hp-laptop kernel: [   48.083433] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:22 hp-laptop kernel: [   48.083446] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:22 hp-laptop kernel: [   48.083469] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:22 hp-laptop kernel: [   48.083480] ata1: hard resetting link
Oct  9 23:46:23 hp-laptop kernel: [   48.804122] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:23 hp-laptop kernel: [   48.804156] ata1: EH complete
Oct  9 23:46:23 hp-laptop kernel: [   48.828702] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:23 hp-laptop kernel: [   48.828716] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:23 hp-laptop kernel: [   48.828729] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:23 hp-laptop kernel: [   48.828751] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:23 hp-laptop kernel: [   48.828764] ata1: hard resetting link
Oct  9 23:46:24 hp-laptop kernel: [   49.552175] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:24 hp-laptop kernel: [   49.552211] ata1: EH complete
Oct  9 23:46:24 hp-laptop kernel: [   49.607549] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:24 hp-laptop kernel: [   49.607562] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:24 hp-laptop kernel: [   49.607574] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:24 hp-laptop kernel: [   49.607595] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:24 hp-laptop kernel: [   49.607606] ata1: hard resetting link
Oct  9 23:46:25 hp-laptop kernel: [   50.396120] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:25 hp-laptop kernel: [   50.396156] ata1: EH complete
Oct  9 23:46:25 hp-laptop kernel: [   50.398238] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:25 hp-laptop kernel: [   50.398251] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:25 hp-laptop kernel: [   50.398263] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:25 hp-laptop kernel: [   50.398284] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:25 hp-laptop kernel: [   50.398294] ata1: hard resetting link
Oct  9 23:46:25 hp-laptop kernel: [   51.124122] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:25 hp-laptop kernel: [   51.124156] ata1: EH complete
Oct  9 23:46:25 hp-laptop kernel: [   51.175092] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:25 hp-laptop kernel: [   51.175104] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:25 hp-laptop kernel: [   51.175115] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:25 hp-laptop kernel: [   51.175136] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:25 hp-laptop kernel: [   51.175146] ata1: hard resetting link
Oct  9 23:46:26 hp-laptop kernel: [   51.896103] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:26 hp-laptop kernel: [   51.896136] ata1: EH complete
Oct  9 23:46:26 hp-laptop kernel: [   51.901836] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:26 hp-laptop kernel: [   51.901847] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:26 hp-laptop kernel: [   51.901858] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:26 hp-laptop kernel: [   51.901878] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:26 hp-laptop kernel: [   51.901888] ata1: hard resetting link
Oct  9 23:46:27 hp-laptop kernel: [   52.884147] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:27 hp-laptop kernel: [   52.884181] ata1: EH complete
Oct  9 23:46:27 hp-laptop kernel: [   52.963328] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:27 hp-laptop kernel: [   52.963345] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:27 hp-laptop kernel: [   52.963357] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:27 hp-laptop kernel: [   52.963381] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:27 hp-laptop kernel: [   52.963394] ata1: hard resetting link
Oct  9 23:46:28 hp-laptop kernel: [   53.684139] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:28 hp-laptop kernel: [   53.684175] ata1: EH complete
Oct  9 23:46:28 hp-laptop kernel: [   53.891250] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:28 hp-laptop kernel: [   53.891265] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:28 hp-laptop kernel: [   53.891277] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:28 hp-laptop kernel: [   53.891299] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:28 hp-laptop kernel: [   53.891310] ata1: hard resetting link
Oct  9 23:46:29 hp-laptop kernel: [   54.618791] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:29 hp-laptop kernel: [   54.618831] ata1: EH complete
Oct  9 23:46:29 hp-laptop kernel: [   54.641292] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:29 hp-laptop kernel: [   54.641306] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:29 hp-laptop kernel: [   54.641317] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:29 hp-laptop kernel: [   54.641339] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:29 hp-laptop kernel: [   54.641350] ata1: hard resetting link
Oct  9 23:46:30 hp-laptop kernel: [   55.364158] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:30 hp-laptop kernel: [   55.364193] ata1: EH complete
Oct  9 23:46:30 hp-laptop kernel: [   55.399893] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:30 hp-laptop kernel: [   55.399907] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:30 hp-laptop kernel: [   55.399919] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:30 hp-laptop kernel: [   55.399941] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:30 hp-laptop kernel: [   55.399953] ata1: hard resetting link
Oct  9 23:46:30 hp-laptop kernel: [   55.616039] wlan0: no IPv6 routers 
present
Oct  9 23:46:30 hp-laptop kernel: [   56.120159] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:30 hp-laptop kernel: [   56.120196] ata1: EH complete
Oct  9 23:46:30 hp-laptop kernel: [   56.161586] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:30 hp-laptop kernel: [   56.161601] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:30 hp-laptop kernel: [   56.161614] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:30 hp-laptop kernel: [   56.161637] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:30 hp-laptop kernel: [   56.161647] ata1: hard resetting link
Oct  9 23:46:31 hp-laptop kernel: [   56.884143] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:31 hp-laptop kernel: [   56.884181] ata1: EH complete
Oct  9 23:46:31 hp-laptop kernel: [   56.896044] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:31 hp-laptop kernel: [   56.896057] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:31 hp-laptop kernel: [   56.896069] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:31 hp-laptop kernel: [   56.896091] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:31 hp-laptop kernel: [   56.896102] ata1: hard resetting link
Oct  9 23:46:32 hp-laptop kernel: [   57.624156] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:32 hp-laptop kernel: [   57.624191] ata1: EH complete
Oct  9 23:46:32 hp-laptop kernel: [   57.657094] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:32 hp-laptop kernel: [   57.657109] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:32 hp-laptop kernel: [   57.657122] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:32 hp-laptop kernel: [   57.657146] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:32 hp-laptop kernel: [   57.657157] ata1: hard resetting link
Oct  9 23:46:33 hp-laptop kernel: [   58.772114] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:33 hp-laptop kernel: [   58.772148] ata1: EH complete
Oct  9 23:46:33 hp-laptop kernel: [   58.831574] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:33 hp-laptop kernel: [   58.831589] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:33 hp-laptop kernel: [   58.831602] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:33 hp-laptop kernel: [   58.831625] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:33 hp-laptop kernel: [   58.831636] ata1: hard resetting link
Oct  9 23:46:33 hp-laptop kernel: [   58.992731] EXT4-fs (sda2): 
re-mounted. Opts: errors=remount-ro,commit=0
Oct  9 23:46:34 hp-laptop kernel: [   59.552121] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:34 hp-laptop kernel: [   59.568106] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:46:34 hp-laptop kernel: [   59.568117] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:34 hp-laptop kernel: [   59.568129] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:34 hp-laptop kernel: [   59.568150] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:34 hp-laptop kernel: [   59.568160] ata1: hard resetting link
Oct  9 23:46:35 hp-laptop kernel: [   60.516122] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:35 hp-laptop kernel: [   60.532072] ata1: EH complete
Oct  9 23:46:35 hp-laptop kernel: [   60.543288] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:35 hp-laptop kernel: [   60.543302] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:35 hp-laptop kernel: [   60.543314] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:35 hp-laptop kernel: [   60.543338] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:35 hp-laptop kernel: [   60.543349] ata1: hard resetting link
Oct  9 23:46:36 hp-laptop kernel: [   62.196073] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:36 hp-laptop kernel: [   62.212095] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:46:36 hp-laptop kernel: [   62.212101] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:36 hp-laptop kernel: [   62.212107] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:36 hp-laptop kernel: [   62.212119] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:36 hp-laptop kernel: [   62.212125] ata1: hard resetting link
Oct  9 23:46:38 hp-laptop kernel: [   63.384103] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:38 hp-laptop kernel: [   63.400079] ata1: EH complete
Oct  9 23:46:38 hp-laptop kernel: [   63.533956] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:38 hp-laptop kernel: [   63.533970] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:38 hp-laptop kernel: [   63.533982] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:38 hp-laptop kernel: [   63.534006] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:38 hp-laptop kernel: [   63.534016] ata1: hard resetting link
Oct  9 23:46:38 hp-laptop kernel: [   64.256092] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:38 hp-laptop kernel: [   64.272094] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:46:38 hp-laptop kernel: [   64.272106] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:38 hp-laptop kernel: [   64.272117] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:38 hp-laptop kernel: [   64.272138] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:38 hp-laptop kernel: [   64.272148] ata1: hard resetting link
Oct  9 23:46:39 hp-laptop kernel: [   64.996084] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:39 hp-laptop kernel: [   65.012092] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:46:39 hp-laptop kernel: [   65.012102] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:39 hp-laptop kernel: [   65.012111] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:39 hp-laptop kernel: [   65.012127] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:39 hp-laptop kernel: [   65.012135] ata1: hard resetting link
Oct  9 23:46:41 hp-laptop kernel: [   66.472102] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:41 hp-laptop kernel: [   66.488208] ata1: EH complete
Oct  9 23:46:41 hp-laptop kernel: [   66.524790] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:41 hp-laptop kernel: [   66.524801] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:41 hp-laptop kernel: [   66.524812] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:41 hp-laptop kernel: [   66.524837] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:41 hp-laptop kernel: [   66.524847] ata1: hard resetting link
Oct  9 23:46:41 hp-laptop kernel: [   67.252102] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:41 hp-laptop kernel: [   67.268087] ata1: EH complete
Oct  9 23:46:42 hp-laptop kernel: [   67.579093] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:42 hp-laptop kernel: [   67.579107] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:42 hp-laptop kernel: [   67.579119] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:42 hp-laptop kernel: [   67.579141] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:42 hp-laptop kernel: [   67.579152] ata1: hard resetting link
Oct  9 23:46:42 hp-laptop kernel: [   68.300092] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:42 hp-laptop kernel: [   68.316094] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:46:42 hp-laptop kernel: [   68.316105] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:42 hp-laptop kernel: [   68.316115] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:42 hp-laptop kernel: [   68.316137] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:42 hp-laptop kernel: [   68.316148] ata1: hard resetting link
Oct  9 23:46:43 hp-laptop kernel: [   69.040107] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:43 hp-laptop kernel: [   69.056129] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:46:43 hp-laptop kernel: [   69.056143] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:43 hp-laptop kernel: [   69.056154] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:43 hp-laptop kernel: [   69.056176] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:43 hp-laptop kernel: [   69.056188] ata1: hard resetting link
Oct  9 23:46:45 hp-laptop kernel: [   70.776122] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:45 hp-laptop kernel: [   70.792091] ata1: EH complete
Oct  9 23:46:45 hp-laptop kernel: [   70.792837] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:45 hp-laptop kernel: [   70.792852] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:45 hp-laptop kernel: [   70.792864] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:45 hp-laptop kernel: [   70.792888] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:45 hp-laptop kernel: [   70.792899] ata1: hard resetting link
Oct  9 23:46:46 hp-laptop kernel: [   71.520161] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:46 hp-laptop kernel: [   71.537105] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:46:46 hp-laptop kernel: [   71.537121] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:46 hp-laptop kernel: [   71.537134] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:46 hp-laptop kernel: [   71.537159] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:46 hp-laptop kernel: [   71.537170] ata1: hard resetting link
Oct  9 23:46:47 hp-laptop kernel: [   72.612168] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:47 hp-laptop kernel: [   72.628195] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:46:47 hp-laptop kernel: [   72.628212] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:47 hp-laptop kernel: [   72.628225] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:47 hp-laptop kernel: [   72.628254] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:47 hp-laptop kernel: [   72.628267] ata1: hard resetting link
Oct  9 23:46:48 hp-laptop kernel: [   73.352111] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:48 hp-laptop kernel: [   73.368103] ata1: EH complete
Oct  9 23:46:48 hp-laptop kernel: [   73.372610] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:48 hp-laptop kernel: [   73.372621] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:48 hp-laptop kernel: [   73.372632] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:48 hp-laptop kernel: [   73.372655] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:48 hp-laptop kernel: [   73.372666] ata1: hard resetting link
Oct  9 23:46:49 hp-laptop kernel: [   74.352128] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:49 hp-laptop kernel: [   74.368082] ata1: EH complete
Oct  9 23:46:49 hp-laptop kernel: [   74.384830] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:49 hp-laptop kernel: [   74.384842] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:49 hp-laptop kernel: [   74.384853] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:49 hp-laptop kernel: [   74.384874] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:49 hp-laptop kernel: [   74.384884] ata1: hard resetting link
Oct  9 23:46:50 hp-laptop kernel: [   76.068109] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:50 hp-laptop kernel: [   76.084120] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:46:50 hp-laptop kernel: [   76.084133] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:50 hp-laptop kernel: [   76.084144] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:50 hp-laptop kernel: [   76.084166] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:50 hp-laptop kernel: [   76.084176] ata1: hard resetting link
Oct  9 23:46:51 hp-laptop kernel: [   77.000137] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:51 hp-laptop kernel: [   77.016199] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:46:51 hp-laptop kernel: [   77.016213] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:51 hp-laptop kernel: [   77.016225] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:51 hp-laptop kernel: [   77.016249] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:51 hp-laptop kernel: [   77.016263] ata1: hard resetting link
Oct  9 23:46:52 hp-laptop kernel: [   77.742212] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:52 hp-laptop kernel: [   77.756148] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2
Oct  9 23:46:52 hp-laptop kernel: [   77.756163] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:52 hp-laptop kernel: [   77.756174] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:52 hp-laptop kernel: [   77.756200] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:52 hp-laptop kernel: [   77.756211] ata1: hard resetting link
Oct  9 23:46:53 hp-laptop kernel: [   78.480211] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:53 hp-laptop kernel: [   78.496106] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t1
Oct  9 23:46:53 hp-laptop kernel: [   78.496122] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:53 hp-laptop kernel: [   78.496134] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:53 hp-laptop kernel: [   78.496160] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:53 hp-laptop kernel: [   78.496172] ata1: hard resetting link
Oct  9 23:46:53 hp-laptop kernel: [   79.220110] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:53 hp-laptop kernel: [   79.236087] ata1: EH complete
Oct  9 23:46:53 hp-laptop kernel: [   79.273339] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:53 hp-laptop kernel: [   79.273349] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:53 hp-laptop kernel: [   79.273359] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:53 hp-laptop kernel: [   79.273381] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:53 hp-laptop kernel: [   79.273393] ata1: hard resetting link
Oct  9 23:46:54 hp-laptop kernel: [   79.996102] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:54 hp-laptop kernel: [   80.012231] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:46:54 hp-laptop kernel: [   80.012246] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:54 hp-laptop kernel: [   80.012258] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:54 hp-laptop kernel: [   80.012281] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:54 hp-laptop kernel: [   80.012293] ata1: hard resetting link
Oct  9 23:46:55 hp-laptop kernel: [   81.185827] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:55 hp-laptop kernel: [   81.200108] ata1: EH complete
Oct  9 23:46:55 hp-laptop kernel: [   81.230849] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:55 hp-laptop kernel: [   81.230863] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:55 hp-laptop kernel: [   81.230875] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:55 hp-laptop kernel: [   81.230900] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:55 hp-laptop kernel: [   81.230913] ata1: hard resetting link
Oct  9 23:46:56 hp-laptop kernel: [   81.956109] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:56 hp-laptop kernel: [   81.972120] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:46:56 hp-laptop kernel: [   81.972134] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:56 hp-laptop kernel: [   81.972144] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:56 hp-laptop kernel: [   81.972168] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:56 hp-laptop kernel: [   81.972178] ata1: hard resetting link
Oct  9 23:46:57 hp-laptop kernel: [   82.696129] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:57 hp-laptop kernel: [   82.712205] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:46:57 hp-laptop kernel: [   82.712221] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:57 hp-laptop kernel: [   82.712234] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:57 hp-laptop kernel: [   82.712261] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:57 hp-laptop kernel: [   82.712273] ata1: hard resetting link
Oct  9 23:46:58 hp-laptop kernel: [   83.436108] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:58 hp-laptop kernel: [   83.452119] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2
Oct  9 23:46:58 hp-laptop kernel: [   83.452133] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:58 hp-laptop kernel: [   83.452144] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:58 hp-laptop kernel: [   83.452167] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:58 hp-laptop kernel: [   83.452178] ata1: hard resetting link
Oct  9 23:46:58 hp-laptop kernel: [   84.176095] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:58 hp-laptop kernel: [   84.192077] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t1
Oct  9 23:46:58 hp-laptop kernel: [   84.192086] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:58 hp-laptop kernel: [   84.192096] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:58 hp-laptop kernel: [   84.192115] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:58 hp-laptop kernel: [   84.192124] ata1: hard resetting link
Oct  9 23:46:59 hp-laptop kernel: [   84.916192] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:46:59 hp-laptop kernel: [   84.932132] ata1: EH complete
Oct  9 23:46:59 hp-laptop kernel: [   85.012393] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:46:59 hp-laptop kernel: [   85.012409] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:46:59 hp-laptop kernel: [   85.012421] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:46:59 hp-laptop kernel: [   85.012449] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:46:59 hp-laptop kernel: [   85.012461] ata1: hard resetting link
Oct  9 23:47:00 hp-laptop kernel: [   85.736109] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:00 hp-laptop kernel: [   85.752087] ata1: EH complete
Oct  9 23:47:00 hp-laptop kernel: [   85.756778] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:00 hp-laptop kernel: [   85.756788] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:00 hp-laptop kernel: [   85.756799] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:00 hp-laptop kernel: [   85.756820] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:00 hp-laptop kernel: [   85.756831] ata1: hard resetting link
Oct  9 23:47:01 hp-laptop kernel: [   86.480128] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:01 hp-laptop kernel: [   86.496217] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:01 hp-laptop kernel: [   86.496233] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:01 hp-laptop kernel: [   86.496246] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:01 hp-laptop kernel: [   86.496276] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:01 hp-laptop kernel: [   86.496290] ata1: hard resetting link
Oct  9 23:47:01 hp-laptop kernel: [   87.220104] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:01 hp-laptop kernel: [   87.236127] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:47:01 hp-laptop kernel: [   87.236141] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:01 hp-laptop kernel: [   87.236154] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:01 hp-laptop kernel: [   87.236178] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:01 hp-laptop kernel: [   87.236189] ata1: hard resetting link
Oct  9 23:47:03 hp-laptop kernel: [   88.824106] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:03 hp-laptop kernel: [   88.840142] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2
Oct  9 23:47:03 hp-laptop kernel: [   88.840156] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:03 hp-laptop kernel: [   88.840167] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:03 hp-laptop kernel: [   88.840191] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:03 hp-laptop kernel: [   88.840202] ata1: hard resetting link
Oct  9 23:47:05 hp-laptop kernel: [   91.228099] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:05 hp-laptop kernel: [   91.244105] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t1
Oct  9 23:47:05 hp-laptop kernel: [   91.244117] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:05 hp-laptop kernel: [   91.244127] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:05 hp-laptop kernel: [   91.244149] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:05 hp-laptop kernel: [   91.244161] ata1: hard resetting link
Oct  9 23:47:06 hp-laptop kernel: [   91.968088] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:06 hp-laptop kernel: [   91.984080] ata1: EH complete
Oct  9 23:47:06 hp-laptop kernel: [   91.984172] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:06 hp-laptop kernel: [   91.984181] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:06 hp-laptop kernel: [   91.984191] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:06 hp-laptop kernel: [   91.984209] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:06 hp-laptop kernel: [   91.984217] ata1: hard resetting link
Oct  9 23:47:07 hp-laptop kernel: [   93.092103] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:07 hp-laptop kernel: [   93.108122] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:07 hp-laptop kernel: [   93.108137] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:07 hp-laptop kernel: [   93.108148] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:07 hp-laptop kernel: [   93.108169] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:07 hp-laptop kernel: [   93.108180] ata1: hard resetting link
Oct  9 23:47:09 hp-laptop kernel: [   95.112109] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:09 hp-laptop kernel: [   95.128109] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:47:09 hp-laptop kernel: [   95.128124] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:09 hp-laptop kernel: [   95.128135] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:09 hp-laptop kernel: [   95.128158] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:09 hp-laptop kernel: [   95.128170] ata1: hard resetting link
Oct  9 23:47:10 hp-laptop kernel: [   95.852102] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:10 hp-laptop kernel: [   95.868074] ata1: EH complete
Oct  9 23:47:10 hp-laptop kernel: [   95.882872] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:10 hp-laptop kernel: [   95.882882] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:10 hp-laptop kernel: [   95.882892] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:10 hp-laptop kernel: [   95.882913] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:10 hp-laptop kernel: [   95.882924] ata1: hard resetting link
Oct  9 23:47:11 hp-laptop kernel: [   96.604099] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:11 hp-laptop kernel: [   96.620082] ata1: EH complete
Oct  9 23:47:11 hp-laptop kernel: [   96.648665] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:11 hp-laptop kernel: [   96.648673] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:11 hp-laptop kernel: [   96.648683] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:11 hp-laptop kernel: [   96.648701] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:11 hp-laptop kernel: [   96.648709] ata1: hard resetting link
Oct  9 23:47:12 hp-laptop kernel: [   97.376257] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:12 hp-laptop kernel: [   97.392108] ata1: EH complete
Oct  9 23:47:12 hp-laptop kernel: [   97.410862] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:12 hp-laptop kernel: [   97.410879] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:12 hp-laptop kernel: [   97.410892] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:12 hp-laptop kernel: [   97.410920] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:12 hp-laptop kernel: [   97.410934] ata1: hard resetting link
Oct  9 23:47:12 hp-laptop kernel: [   98.260116] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:12 hp-laptop kernel: [   98.276107] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:12 hp-laptop kernel: [   98.276124] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:12 hp-laptop kernel: [   98.276136] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:12 hp-laptop kernel: [   98.276164] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:12 hp-laptop kernel: [   98.276177] ata1: hard resetting link
Oct  9 23:47:13 hp-laptop kernel: [   99.000195] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:13 hp-laptop kernel: [   99.016149] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:47:13 hp-laptop kernel: [   99.016160] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:13 hp-laptop kernel: [   99.016171] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:13 hp-laptop kernel: [   99.016192] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:13 hp-laptop kernel: [   99.016203] ata1: hard resetting link
Oct  9 23:47:14 hp-laptop kernel: [   99.964102] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:14 hp-laptop kernel: [   99.980080] ata1: EH complete
Oct  9 23:47:14 hp-laptop kernel: [  100.335587] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:14 hp-laptop kernel: [  100.335600] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:14 hp-laptop kernel: [  100.335612] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:14 hp-laptop kernel: [  100.335633] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:14 hp-laptop kernel: [  100.335643] ata1: hard resetting link
Oct  9 23:47:15 hp-laptop kernel: [  101.056137] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:15 hp-laptop kernel: [  101.074070] ata1: EH complete
Oct  9 23:47:15 hp-laptop kernel: [  101.119317] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:15 hp-laptop kernel: [  101.119332] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:15 hp-laptop kernel: [  101.119343] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:15 hp-laptop kernel: [  101.119368] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:15 hp-laptop kernel: [  101.119378] ata1: hard resetting link
Oct  9 23:47:16 hp-laptop kernel: [  101.840205] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:16 hp-laptop kernel: [  101.856861] ata1: EH complete
Oct  9 23:47:16 hp-laptop kernel: [  101.931016] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:16 hp-laptop kernel: [  101.931031] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:16 hp-laptop kernel: [  101.931043] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:16 hp-laptop kernel: [  101.931069] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:16 hp-laptop kernel: [  101.931080] ata1: hard resetting link
Oct  9 23:47:17 hp-laptop kernel: [  102.652105] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:17 hp-laptop kernel: [  102.668086] ata1: EH complete
Oct  9 23:47:17 hp-laptop kernel: [  102.710314] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:17 hp-laptop kernel: [  102.710325] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:17 hp-laptop kernel: [  102.710336] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:17 hp-laptop kernel: [  102.710358] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:17 hp-laptop kernel: [  102.710370] ata1: hard resetting link
Oct  9 23:47:18 hp-laptop kernel: [  103.912111] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:18 hp-laptop kernel: [  103.928113] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:18 hp-laptop kernel: [  103.928124] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:18 hp-laptop kernel: [  103.928133] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:18 hp-laptop kernel: [  103.928153] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:18 hp-laptop kernel: [  103.928163] ata1: hard resetting link
Oct  9 23:47:19 hp-laptop kernel: [  104.652097] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:19 hp-laptop kernel: [  104.668076] ata1: EH complete
Oct  9 23:47:19 hp-laptop kernel: [  104.769694] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:19 hp-laptop kernel: [  104.769705] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:19 hp-laptop kernel: [  104.769716] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:19 hp-laptop kernel: [  104.769737] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:19 hp-laptop kernel: [  104.769749] ata1: hard resetting link
Oct  9 23:47:20 hp-laptop kernel: [  105.492087] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:20 hp-laptop kernel: [  105.508078] ata1: EH complete
Oct  9 23:47:20 hp-laptop kernel: [  105.546197] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:20 hp-laptop kernel: [  105.546206] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:20 hp-laptop kernel: [  105.546215] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:20 hp-laptop kernel: [  105.546232] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:20 hp-laptop kernel: [  105.546241] ata1: hard resetting link
Oct  9 23:47:21 hp-laptop kernel: [  106.652096] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:21 hp-laptop kernel: [  106.668099] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:21 hp-laptop kernel: [  106.668110] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:21 hp-laptop kernel: [  106.668121] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:21 hp-laptop kernel: [  106.668141] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:21 hp-laptop kernel: [  106.668150] ata1: hard resetting link
Oct  9 23:47:22 hp-laptop kernel: [  107.392103] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:22 hp-laptop kernel: [  107.408128] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:47:22 hp-laptop kernel: [  107.408142] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:22 hp-laptop kernel: [  107.408154] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:22 hp-laptop kernel: [  107.408177] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:22 hp-laptop kernel: [  107.408189] ata1: hard resetting link
Oct  9 23:47:24 hp-laptop kernel: [  109.732103] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:24 hp-laptop kernel: [  109.748089] ata1: EH complete
Oct  9 23:47:24 hp-laptop kernel: [  109.761020] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:24 hp-laptop kernel: [  109.761035] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:24 hp-laptop kernel: [  109.761046] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:24 hp-laptop kernel: [  109.761068] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:24 hp-laptop kernel: [  109.761078] ata1: hard resetting link
Oct  9 23:47:25 hp-laptop kernel: [  110.484088] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:25 hp-laptop kernel: [  110.500078] ata1: EH complete
Oct  9 23:47:25 hp-laptop kernel: [  110.501794] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:25 hp-laptop kernel: [  110.501802] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:25 hp-laptop kernel: [  110.501812] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:25 hp-laptop kernel: [  110.501831] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:25 hp-laptop kernel: [  110.501840] ata1: hard resetting link
Oct  9 23:47:25 hp-laptop kernel: [  111.224099] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:25 hp-laptop kernel: [  111.240076] ata1: EH complete
Oct  9 23:47:26 hp-laptop kernel: [  111.463073] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:26 hp-laptop kernel: [  111.463082] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:26 hp-laptop kernel: [  111.463091] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:26 hp-laptop kernel: [  111.463107] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:26 hp-laptop kernel: [  111.463115] ata1: hard resetting link
Oct  9 23:47:26 hp-laptop kernel: [  112.188101] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:26 hp-laptop kernel: [  112.204106] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:26 hp-laptop kernel: [  112.204117] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:26 hp-laptop kernel: [  112.204128] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:26 hp-laptop kernel: [  112.204149] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:26 hp-laptop kernel: [  112.204159] ata1: hard resetting link
Oct  9 23:47:27 hp-laptop kernel: [  113.280089] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:27 hp-laptop kernel: [  113.296081] ata1: EH complete
Oct  9 23:47:27 hp-laptop kernel: [  113.299602] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:27 hp-laptop kernel: [  113.299612] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:27 hp-laptop kernel: [  113.299622] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:27 hp-laptop kernel: [  113.299643] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:27 hp-laptop kernel: [  113.299652] ata1: hard resetting link
Oct  9 23:47:28 hp-laptop kernel: [  114.020104] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:28 hp-laptop kernel: [  114.036109] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:28 hp-laptop kernel: [  114.036119] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:28 hp-laptop kernel: [  114.036130] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:28 hp-laptop kernel: [  114.036148] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:28 hp-laptop kernel: [  114.036159] ata1: hard resetting link
Oct  9 23:47:29 hp-laptop kernel: [  114.760091] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:29 hp-laptop kernel: [  114.776080] ata1: EH complete
Oct  9 23:47:29 hp-laptop kernel: [  114.791683] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:29 hp-laptop kernel: [  114.791691] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:29 hp-laptop kernel: [  114.791700] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:29 hp-laptop kernel: [  114.791716] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:29 hp-laptop kernel: [  114.791724] ata1: hard resetting link
Oct  9 23:47:30 hp-laptop kernel: [  115.832369] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:30 hp-laptop kernel: [  115.848101] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:30 hp-laptop kernel: [  115.848112] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:30 hp-laptop kernel: [  115.848122] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:30 hp-laptop kernel: [  115.848142] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:30 hp-laptop kernel: [  115.848152] ata1: hard resetting link
Oct  9 23:47:31 hp-laptop kernel: [  116.672140] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:31 hp-laptop kernel: [  116.688121] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:47:31 hp-laptop kernel: [  116.688139] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:31 hp-laptop kernel: [  116.688152] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:31 hp-laptop kernel: [  116.688179] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:31 hp-laptop kernel: [  116.688193] ata1: hard resetting link
Oct  9 23:47:32 hp-laptop kernel: [  117.768250] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:32 hp-laptop kernel: [  117.784101] ata1: EH complete
Oct  9 23:47:32 hp-laptop kernel: [  117.793206] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:32 hp-laptop kernel: [  117.793222] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:32 hp-laptop kernel: [  117.793237] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:32 hp-laptop kernel: [  117.793266] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:32 hp-laptop kernel: [  117.793280] ata1: hard resetting link
Oct  9 23:47:33 hp-laptop kernel: [  118.708137] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:33 hp-laptop kernel: [  118.724086] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:33 hp-laptop kernel: [  118.724101] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:33 hp-laptop kernel: [  118.724112] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:33 hp-laptop kernel: [  118.724137] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:33 hp-laptop kernel: [  118.724149] ata1: hard resetting link
Oct  9 23:47:34 hp-laptop kernel: [  119.448120] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:34 hp-laptop kernel: [  119.464114] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:47:34 hp-laptop kernel: [  119.464128] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:34 hp-laptop kernel: [  119.464140] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:34 hp-laptop kernel: [  119.464164] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:34 hp-laptop kernel: [  119.464175] ata1: hard resetting link
Oct  9 23:47:34 hp-laptop kernel: [  120.188150] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:34 hp-laptop kernel: [  120.204125] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2
Oct  9 23:47:34 hp-laptop kernel: [  120.204138] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:34 hp-laptop kernel: [  120.204149] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:34 hp-laptop kernel: [  120.204173] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:34 hp-laptop kernel: [  120.204184] ata1: hard resetting link
Oct  9 23:47:36 hp-laptop kernel: [  121.856172] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:36 hp-laptop kernel: [  121.872149] ata1: EH complete
Oct  9 23:47:36 hp-laptop kernel: [  121.972073] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:36 hp-laptop kernel: [  121.972088] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:36 hp-laptop kernel: [  121.972102] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:36 hp-laptop kernel: [  121.972135] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:36 hp-laptop kernel: [  121.972151] ata1: hard resetting link
Oct  9 23:47:37 hp-laptop kernel: [  122.696103] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:37 hp-laptop kernel: [  122.712128] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:37 hp-laptop kernel: [  122.712141] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:37 hp-laptop kernel: [  122.712154] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:37 hp-laptop kernel: [  122.712179] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:37 hp-laptop kernel: [  122.712191] ata1: hard resetting link
Oct  9 23:47:38 hp-laptop kernel: [  123.436205] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:38 hp-laptop kernel: [  123.452492] ata1: EH complete
Oct  9 23:47:38 hp-laptop kernel: [  123.452899] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:38 hp-laptop kernel: [  123.452913] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:38 hp-laptop kernel: [  123.452925] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:38 hp-laptop kernel: [  123.452951] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:38 hp-laptop kernel: [  123.452963] ata1: hard resetting link
Oct  9 23:47:38 hp-laptop kernel: [  124.304106] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:38 hp-laptop kernel: [  124.320139] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:38 hp-laptop kernel: [  124.320153] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:38 hp-laptop kernel: [  124.320166] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:38 hp-laptop kernel: [  124.320188] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:38 hp-laptop kernel: [  124.320198] ata1: hard resetting link
Oct  9 23:47:40 hp-laptop kernel: [  126.136096] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:40 hp-laptop kernel: [  126.152104] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:47:40 hp-laptop kernel: [  126.152118] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:40 hp-laptop kernel: [  126.152129] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:40 hp-laptop kernel: [  126.152152] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:40 hp-laptop kernel: [  126.152162] ata1: hard resetting link
Oct  9 23:47:41 hp-laptop kernel: [  126.876109] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:41 hp-laptop kernel: [  126.892086] ata1: EH complete
Oct  9 23:47:41 hp-laptop kernel: [  126.926784] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:41 hp-laptop kernel: [  126.926803] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:41 hp-laptop kernel: [  126.926816] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:41 hp-laptop kernel: [  126.926842] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:41 hp-laptop kernel: [  126.926859] ata1: hard resetting link
Oct  9 23:47:42 hp-laptop kernel: [  127.744131] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:42 hp-laptop kernel: [  127.760083] ata1: EH complete
Oct  9 23:47:42 hp-laptop kernel: [  127.772116] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:42 hp-laptop kernel: [  127.772130] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:42 hp-laptop kernel: [  127.772141] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:42 hp-laptop kernel: [  127.772164] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:42 hp-laptop kernel: [  127.772174] ata1: hard resetting link
Oct  9 23:47:43 hp-laptop kernel: [  128.496092] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:43 hp-laptop kernel: [  128.512095] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:43 hp-laptop kernel: [  128.512104] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:43 hp-laptop kernel: [  128.512114] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:43 hp-laptop kernel: [  128.512133] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:43 hp-laptop kernel: [  128.512142] ata1: hard resetting link
Oct  9 23:47:43 hp-laptop kernel: [  129.236103] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:43 hp-laptop kernel: [  129.252106] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:47:43 hp-laptop kernel: [  129.252116] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:43 hp-laptop kernel: [  129.252125] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:43 hp-laptop kernel: [  129.252143] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:43 hp-laptop kernel: [  129.252152] ata1: hard resetting link
Oct  9 23:47:44 hp-laptop kernel: [  129.976090] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:44 hp-laptop kernel: [  129.992078] ata1: EH complete
Oct  9 23:47:44 hp-laptop kernel: [  130.029371] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:44 hp-laptop kernel: [  130.029380] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:44 hp-laptop kernel: [  130.029390] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:44 hp-laptop kernel: [  130.029407] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:44 hp-laptop kernel: [  130.029416] ata1: hard resetting link
Oct  9 23:47:45 hp-laptop kernel: [  130.752214] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:45 hp-laptop kernel: [  130.768091] ata1: EH complete
Oct  9 23:47:45 hp-laptop kernel: [  130.926051] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:45 hp-laptop kernel: [  130.926067] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:45 hp-laptop kernel: [  130.926079] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:45 hp-laptop kernel: [  130.926112] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:45 hp-laptop kernel: [  130.926125] ata1: hard resetting link
Oct  9 23:47:48 hp-laptop kernel: [  133.376106] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:48 hp-laptop kernel: [  133.392086] ata1: EH complete
Oct  9 23:47:48 hp-laptop kernel: [  133.428394] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:48 hp-laptop kernel: [  133.428407] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:48 hp-laptop kernel: [  133.428418] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:48 hp-laptop kernel: [  133.428442] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:48 hp-laptop kernel: [  133.428453] ata1: hard resetting link
Oct  9 23:47:48 hp-laptop kernel: [  134.152100] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:48 hp-laptop kernel: [  134.168108] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:48 hp-laptop kernel: [  134.168119] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:48 hp-laptop kernel: [  134.168130] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:48 hp-laptop kernel: [  134.168150] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:48 hp-laptop kernel: [  134.168160] ata1: hard resetting link
Oct  9 23:47:49 hp-laptop kernel: [  135.180110] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:49 hp-laptop kernel: [  135.196082] ata1: EH complete
Oct  9 23:47:49 hp-laptop kernel: [  135.206323] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen
Oct  9 23:47:49 hp-laptop kernel: [  135.206337] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:49 hp-laptop kernel: [  135.206350] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:49 hp-laptop kernel: [  135.206373] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:49 hp-laptop kernel: [  135.206383] ata1: hard resetting link
Oct  9 23:47:50 hp-laptop kernel: [  135.928101] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:50 hp-laptop kernel: [  135.944104] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4
Oct  9 23:47:50 hp-laptop kernel: [  135.944115] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:50 hp-laptop kernel: [  135.944127] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:50 hp-laptop kernel: [  135.944149] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:50 hp-laptop kernel: [  135.944159] ata1: hard resetting link
Oct  9 23:47:51 hp-laptop kernel: [  136.668089] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:51 hp-laptop kernel: [  136.684094] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3
Oct  9 23:47:51 hp-laptop kernel: [  136.684103] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:51 hp-laptop kernel: [  136.684113] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:51 hp-laptop kernel: [  136.684131] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:51 hp-laptop kernel: [  136.684140] ata1: hard resetting link
Oct  9 23:47:52 hp-laptop kernel: [  137.416102] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:52 hp-laptop kernel: [  137.432116] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2
Oct  9 23:47:52 hp-laptop kernel: [  137.432129] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:52 hp-laptop kernel: [  137.432139] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:52 hp-laptop kernel: [  137.432160] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:52 hp-laptop kernel: [  137.432170] ata1: hard resetting link
Oct  9 23:47:52 hp-laptop kernel: [  138.156102] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:52 hp-laptop kernel: [  138.172095] ata1: exception Emask 
0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t1
Oct  9 23:47:52 hp-laptop kernel: [  138.172108] ata1: irq_stat 
0x00000040, connection status changed
Oct  9 23:47:52 hp-laptop kernel: [  138.172119] ata1: SError: { PHYInt 
CommWake DevExch }
Oct  9 23:47:52 hp-laptop kernel: [  138.172140] ata1: limiting SATA 
link speed to 1.5 Gbps
Oct  9 23:47:52 hp-laptop kernel: [  138.172151] ata1: hard resetting link
Oct  9 23:47:53 hp-laptop kernel: [  138.896102] ata1: SATA link down 
(SStatus 0 SControl 310)
Oct  9 23:47:53 hp-laptop kernel: [  138.912088] ata1: EH pending after 
5 tries, giving up
Oct  9 23:47:53 hp-laptop kernel: [  138.912098] ata1: EH complete




--------------010007070204030002040907
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000000">
    <a class="moz-txt-link-freetext" href="http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=605395">http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=605395</a><br>
    <br>
    On 25/08/11 01:39, Jonathan Nieder wrote:
    <blockquote
      cite="mid:20110824223821.GA25723@elie.sbx02827.chicail.wayport.net"
      type="cite">
      <pre wrap="">Hi Orson,

Orson wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">The single port card I have is JMB 360 id. 197B:2360  it DOES NOT give any
error, and works perfectly.
The problem is only from my cards with JMB362/363 chipset.
</pre>
      </blockquote>
      <pre wrap="">
Thanks for a useful report and sorry for the delay in responding.

I don't see any relevant fixes upstream unfortunately, but JMB363 is
supposed to work.  If you get a chance, please test a recent v3.x
version from unstable, letting us know the result, and if that fails
then describe the symptoms to <a class="moz-txt-link-abbreviated" href="mailto:linux-ide@vger.kernel.org">linux-ide@vger.kernel.org</a>, cc-ing Aries
Lee <a class="moz-txt-link-rfc2396E" href="mailto:arieslee@jmicron.com">&lt;arieslee@jmicron.com&gt;</a> and this bug log.

Ciao,
Jonathan
</pre>
    </blockquote>
    <br>
    <font face="Arial">Hi Jonathan<br>
      <br>
      I tried my xpress54 card JMB362/363 on Debian Wheezy testing, with
      kernel 3.0.0-1-amd64 (Debian 3.0.0.-3).<br>
      <br>
      The card was inserted into the express slot without any external
      disk attached</font> and I experienced the same problems I had
    been having with debian squeeze, perhaps even more consistently.<br>
    <br>
    I am now only using single port JMB 360 cards which operate
    flawlessly.<br>
    <br>
    I am attaching a kernel log with the said card inserted.<br>
    <br>
    regards<br>
    <br>
    Orson<br>
    <br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: imklog 5.8.5, log source =
    /proc/kmsg started.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Initializing cgroup
    subsys cpuset<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Initializing cgroup
    subsys cpu<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Linux version
    3.0.0-1-amd64 (Debian 3.0.0-3) (<a class="moz-txt-link-abbreviated" href="mailto:ben@decadent.org.uk">ben@decadent.org.uk</a>) (gcc version
    4.5.3 (Debian 4.5.3-8) ) #1 SMP Sat Aug 27 16:21:11 UTC 2011<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Command line:
    BOOT_IMAGE=/boot/vmlinuz-3.0.0-1-amd64
    root=UUID=da9df6fe-041d-4cd9-b203-98e636840bdc ro quiet splash<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] BIOS-provided
    physical RAM map:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    0000000000000000 - 000000000009fc00 (usable)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    000000000009fc00 - 00000000000a0000 (reserved)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    00000000000e0000 - 0000000000100000 (reserved)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    0000000000100000 - 0000000077fd0000 (usable)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    0000000077fd0000 - 0000000077fe5600 (reserved)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    0000000077fe5600 - 0000000077ff8000 (ACPI NVS)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    0000000077ff8000 - 0000000080000000 (reserved)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    00000000e0000000 - 00000000f0000000 (reserved)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    00000000fec00000 - 00000000fec02000 (reserved)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    00000000ffbc0000 - 00000000ffcc0000 (reserved)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; BIOS-e820:
    00000000fff00000 - 0000000100000000 (reserved)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] NX (Execute
    Disable) protection: active<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] DMI 2.4 present.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] DMI:
    Hewlett-Packard HP Compaq nx6325 (EY351ET#ABU)/30B0, BIOS 68TT2 Ver.
    F.07 05/08/2007<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] e820 update range:
    0000000000000000 - 0000000000010000 (usable) ==&gt; (reserved)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] e820 remove range:
    00000000000a0000 - 0000000000100000 (usable)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] No AGP bridge found<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] last_pfn = 0x77fd0
    max_arch_pfn = 0x400000000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] MTRR default type:
    uncachable<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] MTRR fixed ranges
    enabled:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; 00000-9FFFF
    write-back<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; A0000-BFFFF
    uncachable<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; C0000-C0FFF
    write-protect<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; C1000-C3FFF
    write-back<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; C4000-C4FFF
    write-protect<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; C5000-C7FFF
    write-back<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; C8000-C8FFF
    write-protect<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; C9000-CBFFF
    write-back<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; CC000-CCFFF
    write-protect<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; CD000-CFFFF
    write-back<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; D0000-EFFFF
    uncachable<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; F0000-FFFFF
    write-protect<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] MTRR variable
    ranges enabled:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; 0 base 0000000000
    mask FFC0000000 write-back<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; 1 base 0040000000
    mask FFE0000000 write-back<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; 2 base 0060000000
    mask FFF0000000 write-back<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; 3 base 0070000000
    mask FFF8000000 write-back<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; 4 disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; 5 disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; 6 disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; 7 disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] x86 PAT enabled:
    cpu 0, old 0x7040600070406, new 0x7010600070106<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] initial memory
    mapped : 0 - 20000000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Base memory
    trampoline at [ffff88000009a000] 9a000 size 20480<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]
    init_memory_mapping: 0000000000000000-0000000077fd0000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; 0000000000 -
    0077e00000 page 2M<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp; 0077e00000 -
    0077fd0000 page 4k<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] kernel direct
    mapping tables up to 77fd0000 @ 77fcc000-77fd0000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] RAMDISK: 3634a000 -
    3719d000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: RSDP
    00000000000f7a90 00024 (v02 HP&nbsp;&nbsp;&nbsp; )<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: XSDT
    0000000077fe57b4 00054 (v01 HPQOEM SLIC-MPC 00000001 HP&nbsp;&nbsp; 00000001)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: FACP
    0000000077fe5684 000F4 (v04 HP&nbsp;&nbsp;&nbsp;&nbsp; 0944&nbsp;&nbsp;&nbsp;&nbsp; 00000003 HP&nbsp;&nbsp; 00000001)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: DSDT
    0000000077fe5a54 0F6D3 (v01 HP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SB400 00010000 MSFT 0100000E)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: FACS
    0000000077ff7e80 00040<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: SLIC
    0000000077fe5808 00176 (v01 HPQOEM SLIC-MPC 00000001 HP&nbsp;&nbsp; 00000001)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: APIC
    0000000077fe5980 00062 (v01 HP&nbsp;&nbsp;&nbsp;&nbsp; 0944&nbsp;&nbsp;&nbsp;&nbsp; 00000001 HP&nbsp;&nbsp; 00000001)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: MCFG
    0000000077fe59e4 0003C (v01 HP&nbsp;&nbsp;&nbsp;&nbsp; 0944&nbsp;&nbsp;&nbsp;&nbsp; 00000001 HP&nbsp;&nbsp; 00000001)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: TCPA
    0000000077fe5a20 00032 (v02 HP&nbsp;&nbsp;&nbsp;&nbsp; 0944&nbsp;&nbsp;&nbsp;&nbsp; 00000001 HP&nbsp;&nbsp; 00000001)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: SSDT
    0000000077ff5127 00206 (v01 HP&nbsp;&nbsp;&nbsp;&nbsp; PSSTBLID 00000001 HP&nbsp;&nbsp; 00000001)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: Local APIC
    address 0xfee00000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Scanning NUMA
    topology in Northbridge 24<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] No NUMA
    configuration found<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Faking a node at
    0000000000000000-0000000077fd0000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Initmem setup node
    0 0000000000000000-0000000077fd0000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; NODE_DATA
    [0000000077fc7000 - 0000000077fcbfff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;
    [ffffea0000000000-ffffea0001bfffff] PMD -&gt;
    [ffff880075800000-ffff8800773fffff] on node 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Zone PFN ranges:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    0x00000010 -&gt; 0x00001000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA32&nbsp;&nbsp;&nbsp;
    0x00001000 -&gt; 0x00100000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; Normal&nbsp;&nbsp; empty<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Movable zone start
    PFN for each node<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] early_node_map[2]
    active PFN ranges<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; 0: 0x00000010
    -&gt; 0x0000009f<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp;&nbsp;&nbsp; 0: 0x00000100
    -&gt; 0x00077fd0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] On node 0
    totalpages: 491359<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA zone: 56
    pages used for memmap<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA zone: 5 pages
    reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA zone: 3922
    pages, LIFO batch:0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA32 zone: 6664
    pages used for memmap<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000]&nbsp;&nbsp; DMA32 zone:
    480712 pages, LIFO batch:31<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] SB4X0 revision 0x82<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Ignoring ACPI timer
    override.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] If you got timer
    trouble try acpi_use_timer_override<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Detected use of
    extended apic ids on hypertransport bus<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: PM-Timer IO
    Port: 0x8008<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: Local APIC
    address 0xfee00000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC
    (acpi_id[0x01] lapic_id[0x00] enabled)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC
    (acpi_id[0x02] lapic_id[0x01] enabled)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: LAPIC_NMI
    (acpi_id[0x01] high edge lint[0x1])<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: IOAPIC
    (id[0x02] address[0xfec00000] gsi_base[0])<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] IOAPIC[0]: apic_id
    2, version 33, address 0xfec00000, GSI 0-23<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: INT_SRC_OVR
    (bus 0 bus_irq 0 global_irq 2 dfl dfl)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: BIOS IRQ0
    pin2 override ignored.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: INT_SRC_OVR
    (bus 0 bus_irq 9 global_irq 21 low level)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] ACPI: IRQ9 used by
    override.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Using ACPI (MADT)
    for SMP configuration information<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] SMP: Allowing 2
    CPUs, 0 hotplug CPUs<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] nr_irqs_gsi: 40<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered
    nosave memory: 000000000009f000 - 00000000000a0000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered
    nosave memory: 00000000000a0000 - 00000000000e0000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] PM: Registered
    nosave memory: 00000000000e0000 - 0000000000100000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Allocating PCI
    resources starting at 80000000 (gap: 80000000:60000000)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Booting
    paravirtualized kernel on bare hardware<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] setup_percpu:
    NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:2 nr_node_ids:1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] PERCPU: Embedded 27
    pages/cpu @ffff880077c00000 s78912 r8192 d23488 u1048576<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] pcpu-alloc: s78912
    r8192 d23488 u1048576 alloc=1*2097152<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] pcpu-alloc: [0] 0 1
    <br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Built 1 zonelists
    in Node order, mobility grouping on.&nbsp; Total pages: 484634<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Policy zone: DMA32<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Kernel command
    line: BOOT_IMAGE=/boot/vmlinuz-3.0.0-1-amd64
    root=UUID=da9df6fe-041d-4cd9-b203-98e636840bdc ro quiet splash<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] PID hash table
    entries: 4096 (order: 3, 32768 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Checking
    aperture...<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] No AGP bridge found<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Node 0: aperture @
    c094000000 size 32 MB<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Aperture beyond
    4GB. Ignoring.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Memory:
    1913428k/1965888k available (3325k kernel code, 452k absent, 52008k
    reserved, 3370k data, 560k init)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Hierarchical RCU
    implementation.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] &nbsp;&nbsp;&nbsp; RCU
    dyntick-idle grace-period acceleration is enabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] NR_IRQS:33024
    nr_irqs:512 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Extended CMOS year:
    2000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] spurious 8259A
    interrupt: IRQ7.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Console: colour
    VGA+ 80x25<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] console [tty0]
    enabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Fast TSC
    calibration using PIT<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Detected 1994.760
    MHz processor.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.000000] Marking TSC
    unstable due to TSCs unsynchronized<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.008007] Calibrating delay
    loop (skipped), value calculated using timer frequency.. 3989.52
    BogoMIPS (lpj=7979040)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.008012] pid_max: default:
    32768 minimum: 301<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.008186] Security Framework
    initialized<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.008193] SELinux:&nbsp; Disabled
    at boot.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.008477] Dentry cache hash
    table entries: 262144 (order: 9, 2097152 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.009639] Inode-cache hash
    table entries: 131072 (order: 8, 1048576 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012069] Mount-cache hash
    table entries: 256<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012281] Initializing cgroup
    subsys cpuacct<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012288] Initializing cgroup
    subsys memory<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012307] Initializing cgroup
    subsys devices<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012310] Initializing cgroup
    subsys freezer<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012313] Initializing cgroup
    subsys net_cls<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012316] Initializing cgroup
    subsys blkio<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012383] tseg: 0000000000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012407] CPU: Physical
    Processor ID: 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012409] CPU: Processor Core
    ID: 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012412] mce: CPU supports 5
    MCE banks<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012426] using AMD E400
    aware idle routine<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.012758] ACPI: Core revision
    20110413<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.020466] ..TIMER:
    vector=0x30 apic1=0 pin1=0 apic2=-1 pin2=-1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.060805] CPU0: AMD
    Turion(tm) 64 X2 Mobile Technology TL-60 stepping 02<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] Performance Events:
    AMD PMU driver.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] ...
    version:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] ... bit
    width:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 48<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] ... generic
    registers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] ... value
    mask:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000ffffffffffff<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] ... max
    period:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00007fffffffffff<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] ... fixed-purpose
    events:&nbsp;&nbsp; 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] ... event
    mask:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 000000000000000f<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] NMI watchdog
    enabled, takes one hw-pmu counter.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] Booting Node&nbsp;&nbsp; 0,
    Processors&nbsp; #1 Ok.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.064003] smpboot cpu 1:
    start_ip = 9a000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.148087] NMI watchdog
    enabled, takes one hw-pmu counter.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.148115] System has AMD C1E
    enabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.148120] Brought up 2 CPUs<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.148124] Total of 2
    processors activated (7979.83 BogoMIPS).<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.148115] Switch to broadcast
    mode on CPU1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.148581] Switch to broadcast
    mode on CPU0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.148581] devtmpfs:
    initialized<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] PM: Registering
    ACPI NVS region at 77fe5600 (76288 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] print_constraints:
    dummy: <br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] NET: Registered
    protocol family 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] node 0 link 0: io
    port [1000, fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] TOM:
    0000000080000000 aka 2048M<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] node 0 link 0: mmio
    [f0000000, ffffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] node 0 link 0: mmio
    [e0000000, efffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] node 0 link 0: mmio
    [c8000000, dfffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] node 0 link 0: mmio
    [c0000000, c7ffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] node 0 link 0: mmio
    [a0000, bffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] node 0 link 0: mmio
    [80000000, bfffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] bus: [00, ff] on
    node 0 link 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] bus: 00 index 0
    [io&nbsp; 0x0000-0xffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] bus: 00 index 1
    [mem 0x80000000-0xfcffffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] bus: 00 index 2
    [mem 0x000a0000-0x000bffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] ACPI: bus type pci
    registered<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] PCI: MMCONFIG for
    domain 0000 [bus 00-ff] at [mem 0xe0000000-0xefffffff] (base
    0xe0000000)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.155573] PCI: MMCONFIG at
    [mem 0xe0000000-0xefffffff] reserved in E820<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.171484] PCI: Using
    configuration type 1 for base access<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.176170] bio: create slab
    &lt;bio-0&gt; at 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.177282] ACPI: EC: Look up
    EC in DSDT<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.208099] ACPI: Interpreter
    enabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.208105] ACPI: (supports S0
    S3 S4 S5)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.208131] ACPI: Using IOAPIC
    for interrupt routing<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.208702] [Firmware Bug]:
    ACPI: No _BQC method, cannot determine initial brightness<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.209539] ACPI: Power
    Resource [C22D] (off)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.209539] ACPI: Power
    Resource [C221] (on)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.215149] ACPI: Power
    Resource [C360] (off)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.215220] ACPI: Power
    Resource [C361] (off)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.215293] ACPI: Power
    Resource [C362] (off)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.215363] ACPI: Power
    Resource [C363] (off)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.216044] ACPI: EC: GPE =
    0x11, I/O: command/status = 0x66, data = 0x62<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.216340] ACPI: No dock
    devices found.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.216343] HEST: Table not
    found.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.216348] PCI: Ignoring host
    bridge windows from ACPI; if necessary, use "pci=use_crs" and report
    a bug<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.220902] ACPI: PCI Root
    Bridge [C079] (domain 0000 [bus 00-ff])<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230021] pci_root
    PNP0A03:00: host bridge window [io&nbsp; 0x0000-0x0cf7] (ignored)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230025] pci_root
    PNP0A03:00: host bridge window [io&nbsp; 0x0d00-0xffff] (ignored)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230028] pci_root
    PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230032] pci_root
    PNP0A03:00: host bridge window [mem 0x80000000-0xfedfffff] (ignored)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230036] pci_root
    PNP0A03:00: host bridge window [mem 0xfee01000-0xffffffff] (ignored)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230039] pci_root
    PNP0A03:00: host bridge window [mem 0x000d0000-0x000dffff] (ignored)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230052] pci 0000:00:00.0:
    [1002:5950] type 0 class 0x000600<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230088] pci 0000:00:01.0:
    [1002:5a3f] type 1 class 0x000604<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230131] pci 0000:00:04.0:
    [1002:5a36] type 1 class 0x000604<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230160] pci 0000:00:04.0:
    PME# supported from D0 D3hot D3cold<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230164] pci 0000:00:04.0:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230183] pci 0000:00:05.0:
    [1002:5a37] type 1 class 0x000604<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230211] pci 0000:00:05.0:
    PME# supported from D0 D3hot D3cold<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230215] pci 0000:00:05.0:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230233] pci 0000:00:06.0:
    [1002:5a38] type 1 class 0x000604<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230262] pci 0000:00:06.0:
    PME# supported from D0 D3hot D3cold<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230265] pci 0000:00:06.0:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230315] pci 0000:00:12.0:
    [1002:4379] type 0 class 0x000101<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230343] pci 0000:00:12.0:
    reg 10: [io&nbsp; 0x9000-0x9007]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230358] pci 0000:00:12.0:
    reg 14: [io&nbsp; 0x9008-0x900b]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230372] pci 0000:00:12.0:
    reg 18: [io&nbsp; 0x9010-0x9017]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230386] pci 0000:00:12.0:
    reg 1c: [io&nbsp; 0x6018-0x601b]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230400] pci 0000:00:12.0:
    reg 20: [io&nbsp; 0x6020-0x602f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230415] pci 0000:00:12.0:
    reg 24: [mem 0xd0509000-0xd05091ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230429] pci 0000:00:12.0:
    reg 30: [mem 0x00000000-0x0007ffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230463] pci 0000:00:12.0:
    supports D1 D2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230488] pci 0000:00:13.0:
    [1002:4374] type 0 class 0x000c03<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230508] pci 0000:00:13.0:
    reg 10: [mem 0xd0501000-0xd0501fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230601] pci 0000:00:13.1:
    [1002:4375] type 0 class 0x000c03<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230620] pci 0000:00:13.1:
    reg 10: [mem 0xd0502000-0xd0502fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230717] pci 0000:00:13.2:
    [1002:4373] type 0 class 0x000c03<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230742] pci 0000:00:13.2:
    reg 10: [mem 0xd0503000-0xd0503fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230834] pci 0000:00:13.2:
    supports D1 D2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230836] pci 0000:00:13.2:
    PME# supported from D0 D1 D2 D3hot<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230842] pci 0000:00:13.2:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230877] pci 0000:00:14.0:
    [1002:4372] type 0 class 0x000c05<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230899] pci 0000:00:14.0:
    reg 10: [io&nbsp; 0x8200-0x820f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230913] pci 0000:00:14.0:
    reg 14: [mem 0xd0504000-0xd05043ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.230974] HPET not enabled in
    BIOS. You might try hpet=force boot option<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231025] pci 0000:00:14.1:
    [1002:4376] type 0 class 0x000101<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231049] pci 0000:00:14.1:
    reg 10: [io&nbsp; 0x0000-0x0007]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231063] pci 0000:00:14.1:
    reg 14: [io&nbsp; 0x0000-0x0003]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231076] pci 0000:00:14.1:
    reg 18: [io&nbsp; 0x0000-0x0007]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231091] pci 0000:00:14.1:
    reg 1c: [io&nbsp; 0x0000-0x0003]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231105] pci 0000:00:14.1:
    reg 20: [io&nbsp; 0x6040-0x604f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231182] pci 0000:00:14.2:
    [1002:437b] type 0 class 0x000403<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231217] pci 0000:00:14.2:
    reg 10: [mem 0xd0508000-0xd050bfff 64bit]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231305] pci 0000:00:14.2:
    PME# supported from D0 D3hot D3cold<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231311] pci 0000:00:14.2:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231338] pci 0000:00:14.3:
    [1002:4377] type 0 class 0x000601<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231445] pci 0000:00:14.4:
    [1002:4371] type 1 class 0x000604<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231511] pci 0000:00:18.0:
    [1022:1100] type 0 class 0x000600<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231536] pci 0000:00:18.1:
    [1022:1101] type 0 class 0x000600<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231556] pci 0000:00:18.2:
    [1022:1102] type 0 class 0x000600<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231577] pci 0000:00:18.3:
    [1022:1103] type 0 class 0x000600<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231607] PCI: peer root bus
    00 res updated from pci conf<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231638] pci 0000:01:05.0:
    [1002:5975] type 0 class 0x000300<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231647] pci 0000:01:05.0:
    reg 10: [mem 0xc0000000-0xc7ffffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231653] pci 0000:01:05.0:
    reg 14: [io&nbsp; 0x5000-0x50ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231660] pci 0000:01:05.0:
    reg 18: [mem 0xd0400000-0xd040ffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231675] pci 0000:01:05.0:
    reg 30: [mem 0x00000000-0x0001ffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231684] pci 0000:01:05.0:
    supports D1 D2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231700] pci 0000:00:01.0:
    PCI bridge to [bus 01-01]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231706] pci 0000:00:01.0:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x5000-0x5fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231710] pci 0000:00:01.0:&nbsp;&nbsp;
    bridge window [mem 0xd0400000-0xd04fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231715] pci 0000:00:01.0:&nbsp;&nbsp;
    bridge window [mem 0xc0000000-0xc7ffffff 64bit pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231762] pci 0000:10:00.0:
    [197b:2363] type 0 class 0x000106<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231847] pci 0000:10:00.0:
    reg 24: [mem 0xd0000000-0xd0001fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231861] pci 0000:10:00.0:
    reg 30: [mem 0x00000000-0x0000ffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231894] pci 0000:10:00.0:
    PME# supported from D3hot<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231899] pci 0000:10:00.0:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231933] pci 0000:10:00.1:
    [197b:2363] type 0 class 0x000101<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231958] pci 0000:10:00.1:
    reg 10: [io&nbsp; 0x4000-0x4007]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231972] pci 0000:10:00.1:
    reg 14: [io&nbsp; 0x4008-0x400b]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231986] pci 0000:10:00.1:
    reg 18: [io&nbsp; 0x4010-0x4017]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.231999] pci 0000:10:00.1:
    reg 1c: [io&nbsp; 0x4018-0x401b]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232021] pci 0000:10:00.1:
    reg 20: [io&nbsp; 0x4020-0x402f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232090] pci 0000:10:00.0:
    disabling ASPM on pre-1.1 PCIe device.&nbsp; You can enable it with
    'pcie_aspm=force'<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232105] pci 0000:00:04.0:
    PCI bridge to [bus 10-10]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232110] pci 0000:00:04.0:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x4000-0x4fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232114] pci 0000:00:04.0:&nbsp;&nbsp;
    bridge window [mem 0xd0000000-0xd00fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232119] pci 0000:00:04.0:&nbsp;&nbsp;
    bridge window [mem 0xfff00000-0x000fffff pref] (disabled)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232146] pci 0000:00:05.0:
    PCI bridge to [bus 20-20]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232151] pci 0000:00:05.0:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x2000-0x3fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232155] pci 0000:00:05.0:&nbsp;&nbsp;
    bridge window [mem 0xcc000000-0xcfffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232160] pci 0000:00:05.0:&nbsp;&nbsp;
    bridge window [mem 0xfff00000-0x000fffff pref] (disabled)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232209] pci 0000:30:00.0:
    [14e4:4312] type 0 class 0x000280<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232227] pci 0000:30:00.0:
    reg 10: [mem 0xc8000000-0xc8003fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232320] pci 0000:30:00.0:
    supports D1 D2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232341] pci 0000:30:00.0:
    disabling ASPM on pre-1.1 PCIe device.&nbsp; You can enable it with
    'pcie_aspm=force'<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232351] pci 0000:00:06.0:
    PCI bridge to [bus 30-30]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232355] pci 0000:00:06.0:&nbsp;&nbsp;
    bridge window [io&nbsp; 0xf000-0x0000] (disabled)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232359] pci 0000:00:06.0:&nbsp;&nbsp;
    bridge window [mem 0xc8000000-0xc80fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232364] pci 0000:00:06.0:&nbsp;&nbsp;
    bridge window [mem 0xfff00000-0x000fffff pref] (disabled)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232417] pci 0000:02:01.0:
    [14e4:169c] type 0 class 0x000200<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232456] pci 0000:02:01.0:
    reg 10: [mem 0xd0100000-0xd010ffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232592] pci 0000:02:01.0:
    PME# supported from D3hot D3cold<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232600] pci 0000:02:01.0:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232639] pci 0000:02:04.0:
    [104c:8039] type 2 class 0x000607<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232669] pci 0000:02:04.0:
    reg 10: [mem 0xd0110000-0xd0110fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232702] pci 0000:02:04.0:
    supports D1 D2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232705] pci 0000:02:04.0:
    PME# supported from D0 D1 D2 D3hot<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232711] pci 0000:02:04.0:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232744] pci 0000:02:04.2:
    [104c:803b] type 0 class 0x000180<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232773] pci 0000:02:04.2:
    reg 10: [mem 0xd0118000-0xd0118fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232888] pci 0000:02:04.2:
    supports D1 D2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232890] pci 0000:02:04.2:
    PME# supported from D0 D1 D2 D3hot<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232897] pci 0000:02:04.2:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232929] pci 0000:02:04.3:
    [104c:803c] type 0 class 0x000805<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.232958] pci 0000:02:04.3:
    reg 10: [mem 0xd0119000-0xd01190ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233073] pci 0000:02:04.3:
    supports D1 D2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233075] pci 0000:02:04.3:
    PME# supported from D0 D1 D2 D3hot<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233082] pci 0000:02:04.3:
    PME# disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233157] pci 0000:00:14.4:
    PCI bridge to [bus 02-03] (subtractive decode)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233166] pci 0000:00:14.4:&nbsp;&nbsp;
    bridge window [io&nbsp; 0xf000-0x0000] (disabled)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233173] pci 0000:00:14.4:&nbsp;&nbsp;
    bridge window [mem 0xd0100000-0xd03fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233180] pci 0000:00:14.4:&nbsp;&nbsp;
    bridge window [mem 0xfff00000-0x000fffff pref] (disabled)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233184] pci 0000:00:14.4:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x0000-0xffff] (subtractive decode)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233188] pci 0000:00:14.4:&nbsp;&nbsp;
    bridge window [mem 0x80000000-0xfcffffffff] (subtractive decode)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233192] pci 0000:00:14.4:&nbsp;&nbsp;
    bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233254] pci_bus 0000:03:
    [bus 03-06] partially hidden behind transparent bridge 0000:02 [bus
    02-03]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233276] ACPI: PCI Interrupt
    Routing Table [\_SB_.C079._PRT]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233483] ACPI: PCI Interrupt
    Routing Table [\_SB_.C079.C07A._PRT]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233531] ACPI: PCI Interrupt
    Routing Table [\_SB_.C079.C0E5._PRT]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233774]&nbsp; pci0000:00:
    Requesting ACPI _OSC control (0x1d)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233779]&nbsp; pci0000:00: ACPI
    _OSC request failed (AE_NOT_FOUND), returned control mask: 0x1d<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.233781] ACPI _OSC control
    for PCIe not granted, disabling ASPM<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.246884] ACPI: PCI Interrupt
    Link [C12B] (IRQs 10 11) *0, disabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.246965] ACPI: PCI Interrupt
    Link [C12C] (IRQs 10 11) *0, disabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247045] ACPI: PCI Interrupt
    Link [C12D] (IRQs 10 11) *0, disabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247123] ACPI: PCI Interrupt
    Link [C12E] (IRQs 10 11) *0, disabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247201] ACPI: PCI Interrupt
    Link [C12F] (IRQs 10 11) *0, disabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247280] ACPI: PCI Interrupt
    Link [C130] (IRQs 9) *0, disabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247358] ACPI: PCI Interrupt
    Link [C131] (IRQs 10 11) *0, disabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247448] ACPI: PCI Interrupt
    Link [C132] (IRQs 10 11) *5<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247624] vgaarb: device
    added: PCI:0000:01:05.0,decodes=io+mem,owns=io+mem,locks=none<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247633] vgaarb: loaded<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247635] vgaarb: bridge
    control possible 0000:01:05.0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.247694] PCI: Using ACPI for
    IRQ routing<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.259514] PCI:
    pci_cache_line_size set to 64 bytes<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.259554] pci 0000:00:14.2:
    address space collision: [mem 0xd0508000-0xd050bfff 64bit] conflicts
    with 0000:00:12.0 [mem 0xd0509000-0xd05091ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.259650] reserve RAM buffer:
    000000000009fc00 - 000000000009ffff <br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.259654] reserve RAM buffer:
    0000000077fd0000 - 0000000077ffffff <br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.262217] pnp: PnP ACPI init<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.262243] ACPI: bus type pnp
    registered<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.262403] pnp 00:00: [mem
    0x00000000-0x0009ffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.262406] pnp 00:00: [mem
    0x000e0000-0x000fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.262410] pnp 00:00: [mem
    0x00100000-0x77ffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.262503] system 00:00: [mem
    0x00000000-0x0009ffff] could not be reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.262508] system 00:00: [mem
    0x000e0000-0x000fffff] could not be reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.262512] system 00:00: [mem
    0x00100000-0x77ffffff] could not be reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.262517] system 00:00: Plug
    and Play ACPI device, IDs PNP0c01 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267038] pnp 00:01: [bus
    00-ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267042] pnp 00:01: [io&nbsp;
    0x0cf8-0x0cff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267045] pnp 00:01: [io&nbsp;
    0x0000-0x0cf7 window]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267048] pnp 00:01: [io&nbsp;
    0x0d00-0xffff window]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267052] pnp 00:01: [mem
    0x000a0000-0x000bffff window]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267055] pnp 00:01: [mem
    0x80000000-0xfedfffff window]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267060] pnp 00:01: [mem
    0xfee01000-0xffffffff window]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267064] pnp 00:01: [mem
    0x000d0000-0x000dffff window]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267169] pnp 00:01: Plug and
    Play ACPI device, IDs PNP0a03 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267417] pnp 00:02: [io&nbsp;
    0x0520-0x052f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267420] pnp 00:02: [io&nbsp;
    0x0530-0x053f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267424] pnp 00:02: [mem
    0xfed40000-0xfed44fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267471] pnp 00:02: Plug and
    Play ACPI device, IDs IFX0102 PNP0c31 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267486] pnp 00:03: [io&nbsp;
    0x00f0-0x00ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267503] pnp 00:03: [irq 13]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267544] pnp 00:03: Plug and
    Play ACPI device, IDs PNP0c04 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267561] pnp 00:04: [io&nbsp;
    0x0000-0x000f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267564] pnp 00:04: [io&nbsp;
    0x0080-0x008f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267568] pnp 00:04: [io&nbsp;
    0x00c0-0x00df]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267571] pnp 00:04: [dma 4]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267607] pnp 00:04: Plug and
    Play ACPI device, IDs PNP0200 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267621] pnp 00:05: [io&nbsp;
    0x0061]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267658] pnp 00:05: Plug and
    Play ACPI device, IDs PNP0800 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267673] pnp 00:06: [io&nbsp;
    0x0070-0x0071]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267677] pnp 00:06: [io&nbsp;
    0x0072-0x0073]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267686] pnp 00:06: [irq 8]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267723] pnp 00:06: Plug and
    Play ACPI device, IDs PNP0b00 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267756] pnp 00:07: [io&nbsp;
    0x0060]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267759] pnp 00:07: [io&nbsp;
    0x0064]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267768] pnp 00:07: [irq 1]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267805] pnp 00:07: Plug and
    Play ACPI device, IDs PNP0303 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267825] pnp 00:08: [irq 12]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.267867] pnp 00:08: Plug and
    Play ACPI device, IDs SYN0118 SYN0100 SYN0002 PNP0f13 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268061] pnp 00:09: [io&nbsp;
    0x0010-0x001f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268064] pnp 00:09: [io&nbsp;
    0x002e-0x002f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268068] pnp 00:09: [io&nbsp;
    0x004e-0x004f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268071] pnp 00:09: [io&nbsp;
    0x0092]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268073] pnp 00:09: [io&nbsp;
    0x00b0-0x00b1]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268076] pnp 00:09: [io&nbsp;
    0x040b]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268080] pnp 00:09: [io&nbsp;
    0x04d0-0x04d1]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268083] pnp 00:09: [io&nbsp;
    0x04d6]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268085] pnp 00:09: [io&nbsp;
    0x0500-0x051f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268088] pnp 00:09: [io&nbsp;
    0x0c00-0x0c01]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268093] pnp 00:09: [io&nbsp;
    0x0c14]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268096] pnp 00:09: [io&nbsp;
    0x0c50-0x0c51]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268099] pnp 00:09: [io&nbsp;
    0x0c52]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268102] pnp 00:09: [io&nbsp;
    0x0c6c]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268105] pnp 00:09: [io&nbsp;
    0x0c6f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268108] pnp 00:09: [io&nbsp;
    0x0cd4-0x0cdf]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268112] pnp 00:09: [mem
    0xffb00000-0xffbfffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268115] pnp 00:09: [mem
    0xfff00000-0xffffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268210] system 00:09: [io&nbsp;
    0x040b] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268213] system 00:09: [io&nbsp;
    0x04d0-0x04d1] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268217] system 00:09: [io&nbsp;
    0x04d6] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268221] system 00:09: [io&nbsp;
    0x0500-0x051f] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268225] system 00:09: [io&nbsp;
    0x0c00-0x0c01] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268229] system 00:09: [io&nbsp;
    0x0c14] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268233] system 00:09: [io&nbsp;
    0x0c50-0x0c51] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268236] system 00:09: [io&nbsp;
    0x0c52] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268240] system 00:09: [io&nbsp;
    0x0c6c] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268244] system 00:09: [io&nbsp;
    0x0c6f] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268247] system 00:09: [io&nbsp;
    0x0cd4-0x0cdf] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268252] system 00:09: [mem
    0xffb00000-0xffbfffff] could not be reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268256] system 00:09: [mem
    0xfff00000-0xffffffff] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268260] system 00:09: Plug
    and Play ACPI device, IDs PNP0c02 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268704] pnp 00:0a: [io&nbsp;
    0x8000-0x802f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268707] pnp 00:0a: [io&nbsp;
    0x8100-0x811f]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268711] pnp 00:0a: [mem
    0xe0000000-0xefffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268714] pnp 00:0a: [mem
    0xfec00000-0xfec00fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268806] system 00:0a: [io&nbsp;
    0x8000-0x802f] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268810] system 00:0a: [io&nbsp;
    0x8100-0x811f] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268814] system 00:0a: [mem
    0xe0000000-0xefffffff] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268819] system 00:0a: [mem
    0xfec00000-0xfec00fff] could not be reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.268823] system 00:0a: Plug
    and Play ACPI device, IDs PNP0c02 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.269143] pnp 00:0b: [mem
    0x78000000-0x7fffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.269147] pnp 00:0b: [mem
    0xfee00000-0xfee00fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.269238] system 00:0b: [mem
    0x78000000-0x7fffffff] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.269242] system 00:0b: [mem
    0xfee00000-0xfee00fff] has been reserved<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.269246] system 00:0b: Plug
    and Play ACPI device, IDs PNP0c02 (active)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.269264] pnp: PnP ACPI:
    found 12 devices<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.269267] ACPI: ACPI bus type
    pnp unregistered<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.276333] Switching to
    clocksource acpi_pm<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] PCI: max bus depth:
    2 pci_try_num: 3<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:14.4:
    BAR 15: assigned [mem 0x80000000-0x83ffffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:04.0:
    BAR 15: assigned [mem 0x84000000-0x840fffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:12.0:
    BAR 6: assigned [mem 0x84100000-0x8417ffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:14.2:
    BAR 0: assigned [mem 0x84180000-0x84183fff 64bit]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:14.2:
    BAR 0: set to [mem 0x84180000-0x84183fff 64bit] (PCI address
    [0x84180000-0x84183fff])<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:14.4:
    BAR 13: assigned [io&nbsp; 0x1000-0x1fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:01:05.0:
    BAR 6: assigned [mem 0xd0420000-0xd043ffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:01.0:
    PCI bridge to [bus 01-01]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:01.0:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x5000-0x5fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:01.0:&nbsp;&nbsp;
    bridge window [mem 0xd0400000-0xd04fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:01.0:&nbsp;&nbsp;
    bridge window [mem 0xc0000000-0xc7ffffff 64bit pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:10:00.0:
    BAR 6: assigned [mem 0x84000000-0x8400ffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:04.0:
    PCI bridge to [bus 10-10]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:04.0:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x4000-0x4fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:04.0:&nbsp;&nbsp;
    bridge window [mem 0xd0000000-0xd00fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:04.0:&nbsp;&nbsp;
    bridge window [mem 0x84000000-0x840fffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:05.0:
    PCI bridge to [bus 20-20]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:05.0:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x2000-0x3fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:05.0:&nbsp;&nbsp;
    bridge window [mem 0xcc000000-0xcfffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:05.0:&nbsp;&nbsp;
    bridge window [mem pref disabled]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:06.0:
    PCI bridge to [bus 30-30]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:06.0:&nbsp;&nbsp;
    bridge window [io&nbsp; disabled]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:06.0:&nbsp;&nbsp;
    bridge window [mem 0xc8000000-0xc80fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:06.0:&nbsp;&nbsp;
    bridge window [mem pref disabled]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:
    BAR 15: assigned [mem 0x80000000-0x83ffffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:
    BAR 16: assigned [mem 0x88000000-0x8bffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:
    BAR 13: assigned [io&nbsp; 0x1000-0x10ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:
    BAR 14: assigned [io&nbsp; 0x1400-0x14ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:
    CardBus bridge to [bus 03-06]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x1000-0x10ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x1400-0x14ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:&nbsp;&nbsp;
    bridge window [mem 0x80000000-0x83ffffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:&nbsp;&nbsp;
    bridge window [mem 0x88000000-0x8bffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:14.4:
    PCI bridge to [bus 02-03]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:14.4:&nbsp;&nbsp;
    bridge window [io&nbsp; 0x1000-0x1fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:14.4:&nbsp;&nbsp;
    bridge window [mem 0xd0100000-0xd03fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:14.4:&nbsp;&nbsp;
    bridge window [mem 0x80000000-0x83ffffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:04.0:
    setting latency timer to 64<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:05.0:
    setting latency timer to 64<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:00:06.0:
    setting latency timer to 64<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci 0000:02:04.0:
    PCI INT A -&gt; GSI 20 (level, low) -&gt; IRQ 20<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:00:
    resource 4 [io&nbsp; 0x0000-0xffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:00:
    resource 5 [mem 0x80000000-0xfcffffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:00:
    resource 6 [mem 0x000a0000-0x000bffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:01:
    resource 0 [io&nbsp; 0x5000-0x5fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:01:
    resource 1 [mem 0xd0400000-0xd04fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:01:
    resource 2 [mem 0xc0000000-0xc7ffffff 64bit pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:10:
    resource 0 [io&nbsp; 0x4000-0x4fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:10:
    resource 1 [mem 0xd0000000-0xd00fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:10:
    resource 2 [mem 0x84000000-0x840fffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:20:
    resource 0 [io&nbsp; 0x2000-0x3fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:20:
    resource 1 [mem 0xcc000000-0xcfffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:30:
    resource 1 [mem 0xc8000000-0xc80fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:02:
    resource 0 [io&nbsp; 0x1000-0x1fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:02:
    resource 1 [mem 0xd0100000-0xd03fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:02:
    resource 2 [mem 0x80000000-0x83ffffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:02:
    resource 4 [io&nbsp; 0x0000-0xffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:02:
    resource 5 [mem 0x80000000-0xfcffffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:02:
    resource 6 [mem 0x000a0000-0x000bffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:03:
    resource 0 [io&nbsp; 0x1000-0x10ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:03:
    resource 1 [io&nbsp; 0x1400-0x14ff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:03:
    resource 2 [mem 0x80000000-0x83ffffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] pci_bus 0000:03:
    resource 3 [mem 0x88000000-0x8bffffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] NET: Registered
    protocol family 2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] IP route cache hash
    table entries: 65536 (order: 7, 524288 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.280017] TCP established
    hash table entries: 262144 (order: 10, 4194304 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.283743] Switched to NOHz
    mode on CPU #1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.283747] Switched to NOHz
    mode on CPU #0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.284229] TCP bind hash table
    entries: 65536 (order: 8, 1048576 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.284774] TCP: Hash tables
    configured (established 262144 bind 65536)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.284778] TCP reno registered<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.284790] UDP hash table
    entries: 1024 (order: 3, 32768 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.284820] UDP-Lite hash table
    entries: 1024 (order: 3, 32768 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.285056] NET: Registered
    protocol family 1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.285071] pci 0000:00:00.0:
    MSI quirk detected; MSI disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.285080] pci 0000:00:01.0:
    MSI quirk detected; subordinate MSI disabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.285188] pci 0000:01:05.0:
    Boot video device<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.285220] PCI: CLS 64 bytes,
    default 64<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.285287] Unpacking
    initramfs...<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.728770] Freeing initrd
    memory: 14668k freed<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.740487] audit: initializing
    netlink socket (disabled)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.740505] type=2000
    audit(1318203934.736:1): initialized<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.766185] HugeTLB registered
    2 MB page size, pre-allocated 0 pages<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.783902] VFS: Disk quotas
    dquot_6.5.2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.783965] Dquot-cache hash
    table entries: 512 (order 0, 4096 bytes)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.784090] msgmni has been set
    to 3765<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.784446] alg: No test for
    stdrng (krng)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.784509] Block layer SCSI
    generic (bsg) driver version 0.4 loaded (major 253)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.784513] io scheduler noop
    registered<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.784515] io scheduler
    deadline registered<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.784560] io scheduler cfq
    registered (default)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.785230] ERST: Table is not
    found!<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.785325] Serial: 8250/16550
    driver, 4 ports, IRQ sharing enabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.824511] Linux agpgart
    interface v0.103<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.824671] i8042: PNP: PS/2
    Controller [PNP0303:C21E,PNP0f13:C21F] at 0x60,0x64 irq 1,12<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.826324] i8042: Detected
    active multiplexing controller, rev 1.1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827073] serio: i8042 KBD
    port at 0x60,0x64 irq 1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827082] serio: i8042 AUX0
    port at 0x60,0x64 irq 12<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827122] serio: i8042 AUX1
    port at 0x60,0x64 irq 12<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827155] serio: i8042 AUX2
    port at 0x60,0x64 irq 12<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827188] serio: i8042 AUX3
    port at 0x60,0x64 irq 12<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827337] mousedev: PS/2
    mouse device common for all mice<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827411] rtc_cmos 00:06: RTC
    can wake from S4<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827551] rtc_cmos 00:06: rtc
    core: registered rtc_cmos as rtc0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827585] rtc0: alarms up to
    one month, y3k, 114 bytes nvram<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827599] cpuidle: using
    governor ladder<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827602] cpuidle: using
    governor menu<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.827910] TCP cubic
    registered<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.828071] NET: Registered
    protocol family 10<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.828828] Mobile IPv6<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.828831] NET: Registered
    protocol family 17<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.828837] Registering the
    dns_resolver key type<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.828989] PM: Hibernation
    image not present or could not be loaded.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.829004] registered
    taskstats version 1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.838155] rtc_cmos 00:06:
    setting system clock to 2011-10-09 23:45:35 UTC (1318203935)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.838218] Initializing
    network drop monitor service<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.839838] Freeing unused
    kernel memory: 560k freed<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.840149] Write protecting
    the kernel read-only data: 6144k<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.844424] Freeing unused
    kernel memory: 752k freed<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.848928] Freeing unused
    kernel memory: 720k freed<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.852916] input: AT
    Translated Set 2 keyboard as
    /devices/platform/i8042/serio0/input/input0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.938166] input: Sleep Button
    as /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.938175] ACPI: Sleep Button
    [C266]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.938255] input: Lid Switch
    as /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.938341] ACPI: Lid Switch
    [C267]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.938426] input: Power Button
    as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.938430] ACPI: Power Button
    [PWRF]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.947745] SCSI subsystem
    initialized<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.951257] usbcore: registered
    new interface driver usbfs<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.951290] usbcore: registered
    new interface driver hub<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.951776] tg3.c:v3.119 (May
    18, 2011)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.951813] tg3 0000:02:01.0:
    PCI INT A -&gt; GSI 23 (level, low) -&gt; IRQ 23<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.951940] b43-pci-bridge
    0000:30:00.0: PCI INT A -&gt; GSI 18 (level, low) -&gt; IRQ 18<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.951948] b43-pci-bridge
    0000:30:00.0: setting latency timer to 64<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.958016] usbcore: registered
    new device driver usb<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.958831] ehci_hcd: USB 2.0
    'Enhanced' Host Controller (EHCI) Driver<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.986848] ssb: Core 0 found:
    ChipCommon (cc 0x800, rev 0x11, vendor 0x4243)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.986863] ssb: Core 1 found:
    IEEE 802.11 (cc 0x812, rev 0x0A, vendor 0x4243)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.986871] ssb: Core 2 found:
    USB 1.1 Host (cc 0x817, rev 0x03, vendor 0x4243)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.986879] ssb: Core 3 found:
    PCI-E (cc 0x820, rev 0x01, vendor 0x4243)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.988066] ehci_hcd
    0000:00:13.2: PCI INT A -&gt; GSI 19 (level, low) -&gt; IRQ 19<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.988090] ehci_hcd
    0000:00:13.2: EHCI Host Controller<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.988128] ehci_hcd
    0000:00:13.2: new USB bus registered, assigned bus number 1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 0.988224] ehci_hcd
    0000:00:13.2: irq 19, io mem 0xd0503000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.001882] ACPI: Fan [C364]
    (off)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.001942] ACPI: Fan [C365]
    (off)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.001995] ACPI: Fan [C366]
    (off)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.002047] ACPI: Fan [C367]
    (off)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.002376] libata version 3.00
    loaded.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.014102] ehci_hcd
    0000:00:13.2: USB 2.0 started, EHCI 1.00<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.014142] usb usb1: New USB
    device found, idVendor=1d6b, idProduct=0002<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.014145] usb usb1: New USB
    device strings: Mfr=3, Product=2, SerialNumber=1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.014149] usb usb1: Product:
    EHCI Host Controller<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.014151] usb usb1:
    Manufacturer: Linux 3.0.0-1-amd64 ehci_hcd<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.014154] usb usb1:
    SerialNumber: 0000:00:13.2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.014329] hub 1-0:1.0: USB
    hub found<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.014335] hub 1-0:1.0: 8
    ports detected<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.015147] ohci_hcd: USB 1.1
    'Open' Host Controller (OHCI) Driver<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.025509] ahci 0000:10:00.0:
    version 3.0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.025552] ahci 0000:10:00.0:
    PCI INT A -&gt; GSI 16 (level, low) -&gt; IRQ 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.032139] ohci_hcd
    0000:00:13.0: PCI INT A -&gt; GSI 19 (level, low) -&gt; IRQ 19<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.032181] ohci_hcd
    0000:00:13.0: OHCI Host Controller<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.032216] ohci_hcd
    0000:00:13.0: new USB bus registered, assigned bus number 2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.032257] ohci_hcd
    0000:00:13.0: irq 19, io mem 0xd0501000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.032956] tg3 0000:02:01.0:
    eth0: Tigon3 [partno(BCM95788A50) rev 3003] (PCI:33MHz:32-bit) MAC
    address 00:17:a4:d6:bf:87<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.032962] tg3 0000:02:01.0:
    eth0: attached PHY is 5705 (10/100/1000Base-T Ethernet)
    (WireSpeed[0], EEE[0])<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.032966] tg3 0000:02:01.0:
    eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.032970] tg3 0000:02:01.0:
    eth0: dma_rwctrl[763f0000] dma_mask[32-bit]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.040115] ahci 0000:10:00.0:
    AHCI 0001.0000 32 slots 2 ports 3 Gbps 0x3 impl SATA mode<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.040121] ahci 0000:10:00.0:
    flags: 64bit ncq pm led clo pmp pio slum part <br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.040130] ahci 0000:10:00.0:
    setting latency timer to 64<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.044136] sdhci: Secure
    Digital Host Controller Interface driver<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.044140] sdhci: Copyright(c)
    Pierre Ossman<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.048570] scsi0 : ahci<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.050875] [Firmware Bug]:
    ACPI: No _BQC method, cannot determine initial brightness<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.050983] [Firmware Bug]:
    _BCQ is used instead of _BQC<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.062332] scsi1 : ahci<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.062452] ata1: SATA max
    UDMA/133 abar m8192@0xd0000000 port 0xd0000100 irq 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.062457] ata2: SATA max
    UDMA/133 abar m8192@0xd0000000 port 0xd0000180 irq 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.066961] sdhci-pci
    0000:02:04.3: SDHCI controller found [104c:803c] (rev 0)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.066988] sdhci-pci
    0000:02:04.3: PCI INT A -&gt; GSI 20 (level, low) -&gt; IRQ 20<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.067071] mmc0: no vmmc
    regulator found<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.067135] Registered led
    device: mmc0::<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.067195] mmc0: SDHCI
    controller on PCI [0000:02:04.3] using PIO<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.067259] pata_jmicron
    0000:10:00.1: enabling device (0000 -&gt; 0001)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.067286] pata_jmicron
    0000:10:00.1: PCI INT B -&gt; GSI 17 (level, low) -&gt; IRQ 17<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.067340] pata_jmicron
    0000:10:00.1: setting latency timer to 64<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.069188] [drm] Initialized
    drm 1.1.0 20060810<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.071481] acpi device:03:
    registered as cooling_device4<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.071651] scsi2 :
    pata_jmicron<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.071778] scsi3 :
    pata_jmicron<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.071838] ata3: PATA max
    UDMA/100 cmd 0x4000 ctl 0x4008 bmdma 0x4020 irq 17<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.071842] ata4: PATA max
    UDMA/100 cmd 0x4010 ctl 0x4018 bmdma 0x4028 irq 17<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.072458] thermal
    LNXTHERM:00: registered as thermal_zone0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.072463] ACPI: Thermal Zone
    [TZ1] (56 C)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.072818] input: Video Bus as
/devices/LNXSYSTM:00/device:00/PNP0A03:00/device:01/LNXVIDEO:00/input/input4<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.072826] ACPI: Video Device
    [C07B] (multi-head: yes&nbsp; rom: no&nbsp; post: no)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.075866] thermal
    LNXTHERM:01: registered as thermal_zone1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.075869] ACPI: Thermal Zone
    [TZ2] (48 C)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.086654] thermal
    LNXTHERM:02: registered as thermal_zone2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.086658] ACPI: Thermal Zone
    [TZ3] (29 C)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.092285] usb usb2: New USB
    device found, idVendor=1d6b, idProduct=0001<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.092295] usb usb2: New USB
    device strings: Mfr=3, Product=2, SerialNumber=1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.092298] usb usb2: Product:
    OHCI Host Controller<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.092301] usb usb2:
    Manufacturer: Linux 3.0.0-1-amd64 ohci_hcd<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.092304] usb usb2:
    SerialNumber: 0000:00:13.0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.092834] hub 2-0:1.0: USB
    hub found<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.092847] hub 2-0:1.0: 4
    ports detected<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.093051] ohci_hcd
    0000:00:13.1: PCI INT A -&gt; GSI 19 (level, low) -&gt; IRQ 19<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.093084] ohci_hcd
    0000:00:13.1: OHCI Host Controller<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.093095] ohci_hcd
    0000:00:13.1: new USB bus registered, assigned bus number 3<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.093127] ohci_hcd
    0000:00:13.1: irq 19, io mem 0xd0502000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.116147] ssb: Sonics Silicon
    Backplane found on PCI device 0000:30:00.0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.152074] usb usb3: New USB
    device found, idVendor=1d6b, idProduct=0001<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.152079] usb usb3: New USB
    device strings: Mfr=3, Product=2, SerialNumber=1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.152082] usb usb3: Product:
    OHCI Host Controller<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.152085] usb usb3:
    Manufacturer: Linux 3.0.0-1-amd64 ohci_hcd<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.152087] usb usb3:
    SerialNumber: 0000:00:13.1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.152249] hub 3-0:1.0: USB
    hub found<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.152262] hub 3-0:1.0: 4
    ports detected<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.152573] pata_atiixp
    0000:00:14.1: PCI INT A -&gt; GSI 16 (level, low) -&gt; IRQ 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.153129] scsi4 : pata_atiixp<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.153231] scsi5 : pata_atiixp<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.153765] ata5: PATA max
    UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x6040 irq 14<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.153769] ata6: PATA max
    UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x6048 irq 15<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.153890] sata_sil
    0000:00:12.0: version 2.4<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.153894] sata_sil
    0000:00:12.0: quirky BIOS, skipping spindown on poweroff and
    hibernation<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.153933] sata_sil
    0000:00:12.0: PCI INT A -&gt; GSI 16 (level, low) -&gt; IRQ 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.154321] scsi6 : sata_sil<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.154418] scsi7 : sata_sil<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.154599] ata7: SATA max
    UDMA/100 mmio m512@0xd0509000 tf 0xd0509080 irq 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.154604] ata8: SATA max
    UDMA/100 mmio m512@0xd0509000 tf 0xd05090c0 irq 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.332662] ata5.00: ATAPI:
    PIONEER DVD-RW&nbsp; DVRKD08, 1.00, max UDMA/33<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.364590] ata5.00: configured
    for UDMA/33<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.388073] ata2: SATA link
    down (SStatus 0 SControl 300)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.412082] ata1: SATA link
    down (SStatus 0 SControl 300)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.414084] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.414134] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.414183] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.414234] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.480080] ata7: SATA link up
    1.5 Gbps (SStatus 113 SControl 300)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.488359] ata7.00: ATA-7:
    FUJITSU MHV2080BH PL, 892C, max UDMA/100<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.488363] ata7.00: 156301488
    sectors, multi 16: LBA48 <br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.504366] ata7.00: configured
    for UDMA/100<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.588024] scsi 4:0:0:0:
    CD-ROM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PIONEER&nbsp; DVD-RW&nbsp; DVRKD08&nbsp; 1.00 PQ: 0 ANSI: 5<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.588379] scsi 6:0:0:0:
    Direct-Access&nbsp;&nbsp;&nbsp;&nbsp; ATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FUJITSU MHV2080B 892C PQ: 0 ANSI: 5<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.684048] usb 2-3: new low
    speed USB device number 2 using ohci_hcd<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.890102] usb 2-3: New USB
    device found, idVendor=15d9, idProduct=0a4c<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.890106] usb 2-3: New USB
    device strings: Mfr=0, Product=1, SerialNumber=0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.890109] usb 2-3: Product:&nbsp;
    USB OPTICAL MOUSE<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.908085] ata8: SATA link
    down (SStatus 0 SControl 300)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.934753] [drm] radeon kernel
    modesetting enabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.934927] radeon
    0000:01:05.0: PCI INT A -&gt; GSI 17 (level, low) -&gt; IRQ 17<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935290] [drm] initializing
    kernel modesetting (RS480 0x1002:0x5975 0x103C:0x30B0).<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935316] [drm] register mmio
    base: 0xD0400000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935318] [drm] register mmio
    size: 65536<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935487] [drm] Generation 2
    PCI interface, using max accessible memory<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935493] radeon
    0000:01:05.0: VRAM: 128M 0x0000000078000000 - 0x000000007FFFFFFF
    (128M used)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935497] radeon
    0000:01:05.0: GTT: 512M 0x0000000080000000 - 0x000000009FFFFFFF<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935511] [drm] Supports
    vblank timestamp caching Rev 1 (10.10.2010).<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935513] [drm] Driver
    supports precise vblank timestamp query.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935525] [drm] radeon: irq
    initialized.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935718] [drm] Detected VRAM
    RAM=128M, BAR=128M<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935723] [drm] RAM width
    128bits DDR<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935828] [TTM] Zone&nbsp; kernel:
    Available graphics memory: 965064 kiB.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935831] [TTM] Initializing
    pool allocator.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935872] [drm] radeon: 128M
    of VRAM memory ready<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935875] [drm] radeon: 512M
    of GTT memory ready.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.935904] [drm] GART: num cpu
    pages 131072, num gpu pages 131072<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.938579] input:&nbsp; USB OPTICAL
    MOUSE as
    /devices/pci0000:00/0000:00:13.0/usb2/2-3/2-3:1.0/input/input5<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.938757] generic-usb
    0003:15D9:0A4C.0001: input,hidraw0: USB HID v1.11 Mouse [ USB
    OPTICAL MOUSE] on usb-0000:00:13.0-3/input0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.938995] usbcore: registered
    new interface driver usbhid<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.938998] usbhid: USB HID
    core driver<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.939746] [drm] radeon: 4
    quad pipes, 1 z pipes initialized.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.939956] sr0: scsi3-mmc
    drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.939962] cdrom: Uniform
    CD-ROM driver Revision: 3.20<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.940159] sr 4:0:0:0:
    Attached scsi CD-ROM sr0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.940854] sd 6:0:0:0: [sda]
    156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.940920] sd 6:0:0:0: [sda]
    Write Protect is off<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.940924] sd 6:0:0:0: [sda]
    Mode Sense: 00 3a 00 00<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.941429] sd 6:0:0:0: [sda]
    Write cache: enabled, read cache: enabled, doesn't support DPO or
    FUA<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.948301] sr 4:0:0:0:
    Attached scsi generic sg0 type 5<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.948382] sd 6:0:0:0:
    Attached scsi generic sg1 type 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.949559] radeon
    0000:01:05.0: WB enabled<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.949635] [drm] Loading R300
    Microcode<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.954402] [drm] radeon: ring
    at 0x0000000080001000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.954424] [drm] ring test
    succeeded in 1 usecs<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.954611] [drm] radeon: ib
    pool ready.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.954690] [drm] ib test
    succeeded in 0 usecs<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.954933] [drm] Panel ID
    String: SEC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.954936] [drm] Panel Size
    1400x1050<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.967958] [drm] radeon legacy
    LVDS backlight initialized<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968026] [drm] Radeon
    Display Connectors<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968028] [drm] Connector 0:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968030] [drm]&nbsp;&nbsp; VGA<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968032] [drm]&nbsp;&nbsp; DDC: 0x68
    0x68 0x68 0x68 0x68 0x68 0x68 0x68<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968035] [drm]&nbsp;&nbsp; Encoders:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968037] [drm]&nbsp;&nbsp;&nbsp;&nbsp; CRT1:
    INTERNAL_DAC2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968039] [drm] Connector 1:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968040] [drm]&nbsp;&nbsp; LVDS<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968043] [drm]&nbsp;&nbsp; DDC: 0x198
    0x198 0x19c 0x19c 0x1a0 0x1a0 0x1a4 0x1a4<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968045] [drm]&nbsp;&nbsp; Encoders:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968047] [drm]&nbsp;&nbsp;&nbsp;&nbsp; LCD1:
    INTERNAL_LVDS<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968049] [drm] Connector 2:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968051] [drm]&nbsp;&nbsp; S-video<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968052] [drm]&nbsp;&nbsp; Encoders:<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.968054] [drm]&nbsp;&nbsp;&nbsp;&nbsp; TV1:
    INTERNAL_DAC2<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.977533] [drm] Radeon
    display connector VGA-1: No monitor connected or invalid EDID<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.992024]&nbsp; sda: sda1 sda2
    sda3<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 1.992439] sd 6:0:0:0: [sda]
    Attached SCSI disk<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.028544] [drm] Radeon
    display connector LVDS-1: Found valid EDID<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.028562] [drm] radeon: power
    management initialized<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.127986] [drm] fb mappable
    at 0xC0040000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.127988] [drm] vram apper at
    0xC0000000<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.127990] [drm] size 5914624<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.127992] [drm] fb depth is
    24<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.127993] [drm]&nbsp;&nbsp;&nbsp; pitch is
    5632<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.128085] fbcon: radeondrmfb
    (fb0) is primary device<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.181138] Console: switching
    to colour frame buffer device 175x65<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.196051] usb 3-1: new full
    speed USB device number 2 using ohci_hcd<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.196097] fb0: radeondrmfb
    frame buffer device<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.196099] drm: registered
    panic notifier<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.196106] [drm] Initialized
    radeon 2.10.0 20080528 for 0000:01:05.0 on minor 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.401109] usb 3-1: New USB
    device found, idVendor=08ff, idProduct=2580<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.401115] usb 3-1: New USB
    device strings: Mfr=0, Product=1, SerialNumber=0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.401118] usb 3-1: Product:
    Fingerprint Sensor<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.720439] PM: Starting manual
    resume from disk<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.720445] PM: Hibernation
    image partition 8:3 present<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.720447] PM: Looking for
    hibernation image.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.720746] PM: Image not found
    (code -22)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.720751] PM: Hibernation
    image not present or could not be loaded.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 2.772594] EXT4-fs (sda2):
    mounted filesystem with ordered data mode. Opts: (null)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 3.660068] ata1: COMRESET
    failed (errno=-32)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 3.660078] ata1: reset failed
    (errno=-32), retrying in 8 secs<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.203643] ACPI: acpi_idle
    registered with cpuidle<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.203744] ACPI: processor
    limited to max C-state 1<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.212810] ACPI: AC Adapter
    [C1C3] (on-line)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.258656] wmi: Mapper loaded<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.307105] ACPI: Battery Slot
    [C1C5] (battery present)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.307204] ACPI: Battery Slot
    [C1C4] (battery absent)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.321667] tpm_tis 00:02: 1.2
    TPM (device-id 0xB, rev-id 16)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.514125] input: PC Speaker
    as /devices/platform/pcspkr/input/input6<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.568261] k8temp
    0000:00:18.3: Temperature readouts might be wrong - check erratum
    #141<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.598475] piix4_smbus
    0000:00:14.0: SMBus Host Controller at 0x8200, revision 0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.639633] cfg80211: Calling
    CRDA to update world regulatory domain<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.652587] pci_hotplug: PCI
    Hot Plug PCI Core version: 0.5<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.655531] Synaptics Touchpad,
    model: 1, fw: 6.2, id: 0x2580b1, caps: 0xa04793/0x300000/0x0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.655547] serio: Synaptics
    pass-through port at isa0060/serio4/input0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.661907] shpchp: Standard
    Hot Plug PCI Controller Driver version: 0.4<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.695729] input: SynPS/2
    Synaptics TouchPad as /devices/platform/i8042/serio4/input/input7<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.716217] input: HP WMI
    hotkeys as /devices/virtual/input/input8<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.764256] MCE: In-kernel MCE
    decoding enabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.767309] EDAC MC: Ver: 2.1.0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.772601] AMD64 EDAC driver
    v3.4.0<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.772763] EDAC amd64: DRAM
    ECC disabled.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.772773] EDAC amd64: ECC
    disabled in the BIOS or no ECC capability, module will not load.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.772776]&nbsp; Either enable ECC
    checking or force module loading by setting 'ecc_enable_override'.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.772778]&nbsp; (Note that use of
    the override may cause unknown side effects.)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.836932] yenta_cardbus
    0000:02:04.0: CardBus bridge found [103c:30b0]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.836964] yenta_cardbus
    0000:02:04.0: Enabling burst memory read transactions<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.836971] yenta_cardbus
    0000:02:04.0: Using INTVAL to route CSC interrupts to PCI<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.836974] yenta_cardbus
    0000:02:04.0: Routing CardBus interrupts to PCI<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 5.836981] yenta_cardbus
    0000:02:04.0: TI: mfunc 0x01a11002, devctl 0x64<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.069040] yenta_cardbus
    0000:02:04.0: ISA IRQ mask 0x0cf8, PCI irq 20<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.069047] yenta_cardbus
    0000:02:04.0: Socket status: 30000006<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.069052] pci_bus 0000:02:
    Raising subordinate bus# of parent bus (#02) from #03 to #06<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.069065] yenta_cardbus
    0000:02:04.0: pcmcia: parent PCI bridge window: [io&nbsp; 0x1000-0x1fff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.069070] yenta_cardbus
    0000:02:04.0: pcmcia: parent PCI bridge window: [mem
    0xd0100000-0xd03fffff]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.069075] pcmcia_socket
    pcmcia_socket0: cs: memory probe 0xd0100000-0xd03fffff: excluding
    0xd0100000-0xd012ffff<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.069092] yenta_cardbus
    0000:02:04.0: pcmcia: parent PCI bridge window: [mem
    0x80000000-0x83ffffff pref]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.069096] pcmcia_socket
    pcmcia_socket0: cs: memory probe 0x80000000-0x83ffffff: excluding
    0x80000000-0x83ffffff<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.165810] b43-phy0: Broadcom
    4311 WLAN found (core revision 10)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.286540] ieee80211 phy0:
    Selected rate control algorithm 'minstrel_ht'<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.287284] Registered led
    device: b43-phy0::tx<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.287310] Registered led
    device: b43-phy0::rx<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.287338] Registered led
    device: b43-phy0::radio<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.287360] Broadcom 43xx
    driver loaded [ Features: PMNLS, Firmware-ID: FW13 ]<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.551048] pcmcia_socket
    pcmcia_socket0: cs: memory probe 0x0c0000-0x0fffff: excluding
    0xc0000-0xfffff<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.551082] pcmcia_socket
    pcmcia_socket0: cs: memory probe 0xa0000000-0xa0ffffff: clean.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.551114] pcmcia_socket
    pcmcia_socket0: cs: memory probe 0x60000000-0x60ffffff: excluding
    0x60000000-0x60ffffff<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.572203] tifm_7xx1
    0000:02:04.2: PCI INT A -&gt; GSI 20 (level, low) -&gt; IRQ 20<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 6.981156] HDA Intel
    0000:00:14.2: PCI INT A -&gt; GSI 16 (level, low) -&gt; IRQ 16<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 7.147503] input: HDA Digital
    PCBeep as /devices/pci0000:00/0000:00:14.2/input/input9<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 8.319845] Adding 3145724k
    swap on /dev/sda3.&nbsp; Priority:-1 extents:1 across:3145724k <br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 8.325683] EXT4-fs (sda2):
    re-mounted. Opts: (null)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 8.498765] EXT4-fs (sda2):
    re-mounted. Opts: errors=remount-ro<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 8.554700] loop: module loaded<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 9.907911] RPC: Registered
    named UNIX socket transport module.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 9.907916] RPC: Registered udp
    transport module.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 9.907918] RPC: Registered tcp
    transport module.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 9.907921] RPC: Registered tcp
    NFSv4.1 backchannel transport module.<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp;&nbsp; 9.999650] FS-Cache: Loaded<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 10.063047] FS-Cache: Netfs
    'nfs' registered for caching<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 10.088193] Installing knfsd
    (copyright (C) 1996 <a class="moz-txt-link-abbreviated" href="mailto:okir@monad.swb.de">okir@monad.swb.de</a>).<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 10.401339] fuse init (API
    version 7.16)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 11.412145] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 11.412152] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 12.136078] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 12.136097] ata1: EH complete<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 12.164726] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 12.164731] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 12.164736] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 12.164744] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:45:46 hp-laptop kernel: [&nbsp;&nbsp; 12.164749] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:45:47 hp-laptop kernel: [&nbsp;&nbsp; 12.515587] input: ACPI Virtual
    Keyboard Device as /devices/virtual/input/input10<br>
    Oct&nbsp; 9 23:45:49 hp-laptop kernel: [&nbsp;&nbsp; 14.464063] ata1: COMRESET
    failed (errno=-32)<br>
    Oct&nbsp; 9 23:45:49 hp-laptop kernel: [&nbsp;&nbsp; 14.464072] ata1: reset failed
    (errno=-32), retrying in 8 secs<br>
    Oct&nbsp; 9 23:45:50 hp-laptop kernel: [&nbsp;&nbsp; 16.152558] lp: driver loaded
    but no devices found<br>
    Oct&nbsp; 9 23:45:50 hp-laptop kernel: [&nbsp;&nbsp; 16.286031] ppdev: user-space
    parallel port driver<br>
    Oct&nbsp; 9 23:45:56 hp-laptop kernel: [&nbsp;&nbsp; 22.164070] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:45:57 hp-laptop kernel: [&nbsp;&nbsp; 23.304084] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:45:57 hp-laptop kernel: [&nbsp;&nbsp; 23.304104] ata1: EH complete<br>
    Oct&nbsp; 9 23:45:57 hp-laptop kernel: [&nbsp;&nbsp; 23.305853] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:45:57 hp-laptop kernel: [&nbsp;&nbsp; 23.305859] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:45:57 hp-laptop kernel: [&nbsp;&nbsp; 23.305864] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:45:57 hp-laptop kernel: [&nbsp;&nbsp; 23.305872] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:45:57 hp-laptop kernel: [&nbsp;&nbsp; 23.305877] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.688079] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.688098] ata1: EH complete<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.688919] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.688925] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.688930] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.688939] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.688944] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.868718] Disabling lock
    debugging due to kernel taint<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.883180] vboxdrv: Found 2
    processor cores.<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.883523] vboxdrv: fAsync=1
    offMin=0x80fcc offMax=0x80fcc<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.883664] vboxdrv: TSC mode
    is 'asynchronous', kernel timer mode is 'normal'.<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.883667] vboxdrv:
    Successfully loaded version 4.0.12 (interface 0x00180000).<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.923487] powernow-k8: Found
    1 AMD Turion(tm) 64 X2 Mobile Technology TL-60 (2 cpu cores)
    (version 2.20.00)<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.923545] powernow-k8: fid
    0xc (2000 MHz), vid 0x13<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.923548] powernow-k8: fid
    0xa (1800 MHz), vid 0x15<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.923550] powernow-k8: fid
    0x8 (1600 MHz), vid 0x17<br>
    Oct&nbsp; 9 23:45:59 hp-laptop kernel: [&nbsp;&nbsp; 24.923553] powernow-k8: fid
    0x0 (800 MHz), vid 0x1e<br>
    Oct&nbsp; 9 23:46:00 hp-laptop kernel: [&nbsp;&nbsp; 25.864104] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:00 hp-laptop kernel: [&nbsp;&nbsp; 25.864138] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:00 hp-laptop kernel: [&nbsp;&nbsp; 25.864352] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:00 hp-laptop kernel: [&nbsp;&nbsp; 25.864363] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:00 hp-laptop kernel: [&nbsp;&nbsp; 25.864374] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:00 hp-laptop kernel: [&nbsp;&nbsp; 25.864392] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:00 hp-laptop kernel: [&nbsp;&nbsp; 25.864402] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:01 hp-laptop kernel: [&nbsp;&nbsp; 27.068122] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:01 hp-laptop kernel: [&nbsp;&nbsp; 27.068159] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:01 hp-laptop kernel: [&nbsp;&nbsp; 27.077634] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:01 hp-laptop kernel: [&nbsp;&nbsp; 27.077646] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:01 hp-laptop kernel: [&nbsp;&nbsp; 27.077657] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:01 hp-laptop kernel: [&nbsp;&nbsp; 27.077676] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:01 hp-laptop kernel: [&nbsp;&nbsp; 27.077688] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:02 hp-laptop kernel: [&nbsp;&nbsp; 27.804109] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:02 hp-laptop kernel: [&nbsp;&nbsp; 27.804143] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:02 hp-laptop kernel: [&nbsp;&nbsp; 27.807479] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:02 hp-laptop kernel: [&nbsp;&nbsp; 27.807493] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:02 hp-laptop kernel: [&nbsp;&nbsp; 27.807507] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:02 hp-laptop kernel: [&nbsp;&nbsp; 27.807527] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:02 hp-laptop kernel: [&nbsp;&nbsp; 27.807538] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:03 hp-laptop kernel: [&nbsp;&nbsp; 28.528179] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:03 hp-laptop kernel: [&nbsp;&nbsp; 28.528216] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:03 hp-laptop kernel: [&nbsp;&nbsp; 28.543595] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:03 hp-laptop kernel: [&nbsp;&nbsp; 28.543612] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:03 hp-laptop kernel: [&nbsp;&nbsp; 28.543625] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:03 hp-laptop kernel: [&nbsp;&nbsp; 28.543649] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:03 hp-laptop kernel: [&nbsp;&nbsp; 28.543661] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:04 hp-laptop kernel: [&nbsp;&nbsp; 29.536110] b43-phy0: Loading
    firmware version 508.1084 (2009-01-14 01:32:01)<br>
    Oct&nbsp; 9 23:46:04 hp-laptop kernel: [&nbsp;&nbsp; 29.610589]
    ADDRCONF(NETDEV_UP): wlan0: link is not ready<br>
    Oct&nbsp; 9 23:46:05 hp-laptop kernel: [&nbsp;&nbsp; 31.160105] ata1: COMRESET
    failed (errno=-32)<br>
    Oct&nbsp; 9 23:46:05 hp-laptop kernel: [&nbsp;&nbsp; 31.160124] ata1: reset failed
    (errno=-32), retrying in 8 secs<br>
    Oct&nbsp; 9 23:46:10 hp-laptop kernel: [&nbsp;&nbsp; 35.698454]
    ADDRCONF(NETDEV_UP): eth0: link is not ready<br>
    Oct&nbsp; 9 23:46:13 hp-laptop kernel: [&nbsp;&nbsp; 38.540087] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:14 hp-laptop kernel: [&nbsp;&nbsp; 39.836088] b43-phy0: Loading
    firmware version 508.1084 (2009-01-14 01:32:01)<br>
    Oct&nbsp; 9 23:46:14 hp-laptop kernel: [&nbsp;&nbsp; 39.918326]
    ADDRCONF(NETDEV_UP): wlan0: link is not ready<br>
    Oct&nbsp; 9 23:46:14 hp-laptop kernel: [&nbsp;&nbsp; 40.076175] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:14 hp-laptop kernel: [&nbsp;&nbsp; 40.076211] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:14 hp-laptop kernel: [&nbsp;&nbsp; 40.132381] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:14 hp-laptop kernel: [&nbsp;&nbsp; 40.132398] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:14 hp-laptop kernel: [&nbsp;&nbsp; 40.132410] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:14 hp-laptop kernel: [&nbsp;&nbsp; 40.132433] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:14 hp-laptop kernel: [&nbsp;&nbsp; 40.132447] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:15 hp-laptop kernel: [&nbsp;&nbsp; 40.696108] tg3 0000:02:01.0:
    BAR 0: set to [mem 0xd0100000-0xd010ffff] (PCI address
    [0xd0100000-0xd010ffff])<br>
    Oct&nbsp; 9 23:46:15 hp-laptop kernel: [&nbsp;&nbsp; 40.860086] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:15 hp-laptop kernel: [&nbsp;&nbsp; 40.860122] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:15 hp-laptop kernel: [&nbsp;&nbsp; 40.871770] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:15 hp-laptop kernel: [&nbsp;&nbsp; 40.871781] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:15 hp-laptop kernel: [&nbsp;&nbsp; 40.871792] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:15 hp-laptop kernel: [&nbsp;&nbsp; 40.871810] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:15 hp-laptop kernel: [&nbsp;&nbsp; 40.871820] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:15 hp-laptop kernel: [&nbsp;&nbsp; 41.002308]
    ADDRCONF(NETDEV_UP): eth0: link is not ready<br>
    Oct&nbsp; 9 23:46:16 hp-laptop kernel: [&nbsp;&nbsp; 41.540090] b43-phy0: Loading
    firmware version 508.1084 (2009-01-14 01:32:01)<br>
    Oct&nbsp; 9 23:46:16 hp-laptop kernel: [&nbsp;&nbsp; 41.622387]
    ADDRCONF(NETDEV_UP): wlan0: link is not ready<br>
    Oct&nbsp; 9 23:46:16 hp-laptop kernel: [&nbsp;&nbsp; 42.032098] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:16 hp-laptop kernel: [&nbsp;&nbsp; 42.032132] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:16 hp-laptop kernel: [&nbsp;&nbsp; 42.056234] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:16 hp-laptop kernel: [&nbsp;&nbsp; 42.056245] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:16 hp-laptop kernel: [&nbsp;&nbsp; 42.056256] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:16 hp-laptop kernel: [&nbsp;&nbsp; 42.056275] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:16 hp-laptop kernel: [&nbsp;&nbsp; 42.056285] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:17 hp-laptop kernel: [&nbsp;&nbsp; 42.780101] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:17 hp-laptop kernel: [&nbsp;&nbsp; 42.780133] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:17 hp-laptop kernel: [&nbsp;&nbsp; 42.805307] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:17 hp-laptop kernel: [&nbsp;&nbsp; 42.805317] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:17 hp-laptop kernel: [&nbsp;&nbsp; 42.805327] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:17 hp-laptop kernel: [&nbsp;&nbsp; 42.805345] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:17 hp-laptop kernel: [&nbsp;&nbsp; 42.805355] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:18 hp-laptop kernel: [&nbsp;&nbsp; 43.592099] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:18 hp-laptop kernel: [&nbsp;&nbsp; 43.592133] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:18 hp-laptop kernel: [&nbsp;&nbsp; 43.599101] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:18 hp-laptop kernel: [&nbsp;&nbsp; 43.599110] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:18 hp-laptop kernel: [&nbsp;&nbsp; 43.599120] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:18 hp-laptop kernel: [&nbsp;&nbsp; 43.599139] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:18 hp-laptop kernel: [&nbsp;&nbsp; 43.599149] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:19 hp-laptop kernel: [&nbsp;&nbsp; 44.520208] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:19 hp-laptop kernel: [&nbsp;&nbsp; 44.520248] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:19 hp-laptop kernel: [&nbsp;&nbsp; 44.581225] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:19 hp-laptop kernel: [&nbsp;&nbsp; 44.581239] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:19 hp-laptop kernel: [&nbsp;&nbsp; 44.581252] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:19 hp-laptop kernel: [&nbsp;&nbsp; 44.581272] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:19 hp-laptop kernel: [&nbsp;&nbsp; 44.581282] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:19 hp-laptop kernel: [&nbsp;&nbsp; 45.304111] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:19 hp-laptop kernel: [&nbsp;&nbsp; 45.304149] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.365250] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.365263] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.365275] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.365297] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.365307] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.388691] wlan0: authenticate
    with 38:22:9d:1b:bc:23 (try 1)<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.390268] wlan0:
    authenticated<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.390755] wlan0: associate
    with 38:22:9d:1b:bc:23 (try 1)<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.411519] wlan0: RX AssocResp
    from 38:22:9d:1b:bc:23 (capab=0x431 status=0 aid=2)<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.411530] wlan0: associated<br>
    Oct&nbsp; 9 23:46:20 hp-laptop kernel: [&nbsp;&nbsp; 45.413631]
    ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 46.504210] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 46.504246] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 46.516834] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 46.516849] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 46.516860] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 46.516882] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 46.516893] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 47.252113] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 47.252147] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 47.270336] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 47.270351] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 47.270363] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 47.270385] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:21 hp-laptop kernel: [&nbsp;&nbsp; 47.270397] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:22 hp-laptop kernel: [&nbsp;&nbsp; 48.056142] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:22 hp-laptop kernel: [&nbsp;&nbsp; 48.056178] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:22 hp-laptop kernel: [&nbsp;&nbsp; 48.083417] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:22 hp-laptop kernel: [&nbsp;&nbsp; 48.083433] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:22 hp-laptop kernel: [&nbsp;&nbsp; 48.083446] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:22 hp-laptop kernel: [&nbsp;&nbsp; 48.083469] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:22 hp-laptop kernel: [&nbsp;&nbsp; 48.083480] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:23 hp-laptop kernel: [&nbsp;&nbsp; 48.804122] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:23 hp-laptop kernel: [&nbsp;&nbsp; 48.804156] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:23 hp-laptop kernel: [&nbsp;&nbsp; 48.828702] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:23 hp-laptop kernel: [&nbsp;&nbsp; 48.828716] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:23 hp-laptop kernel: [&nbsp;&nbsp; 48.828729] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:23 hp-laptop kernel: [&nbsp;&nbsp; 48.828751] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:23 hp-laptop kernel: [&nbsp;&nbsp; 48.828764] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:24 hp-laptop kernel: [&nbsp;&nbsp; 49.552175] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:24 hp-laptop kernel: [&nbsp;&nbsp; 49.552211] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:24 hp-laptop kernel: [&nbsp;&nbsp; 49.607549] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:24 hp-laptop kernel: [&nbsp;&nbsp; 49.607562] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:24 hp-laptop kernel: [&nbsp;&nbsp; 49.607574] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:24 hp-laptop kernel: [&nbsp;&nbsp; 49.607595] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:24 hp-laptop kernel: [&nbsp;&nbsp; 49.607606] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 50.396120] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 50.396156] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 50.398238] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 50.398251] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 50.398263] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 50.398284] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 50.398294] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 51.124122] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 51.124156] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 51.175092] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 51.175104] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 51.175115] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 51.175136] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:25 hp-laptop kernel: [&nbsp;&nbsp; 51.175146] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:26 hp-laptop kernel: [&nbsp;&nbsp; 51.896103] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:26 hp-laptop kernel: [&nbsp;&nbsp; 51.896136] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:26 hp-laptop kernel: [&nbsp;&nbsp; 51.901836] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:26 hp-laptop kernel: [&nbsp;&nbsp; 51.901847] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:26 hp-laptop kernel: [&nbsp;&nbsp; 51.901858] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:26 hp-laptop kernel: [&nbsp;&nbsp; 51.901878] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:26 hp-laptop kernel: [&nbsp;&nbsp; 51.901888] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:27 hp-laptop kernel: [&nbsp;&nbsp; 52.884147] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:27 hp-laptop kernel: [&nbsp;&nbsp; 52.884181] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:27 hp-laptop kernel: [&nbsp;&nbsp; 52.963328] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:27 hp-laptop kernel: [&nbsp;&nbsp; 52.963345] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:27 hp-laptop kernel: [&nbsp;&nbsp; 52.963357] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:27 hp-laptop kernel: [&nbsp;&nbsp; 52.963381] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:27 hp-laptop kernel: [&nbsp;&nbsp; 52.963394] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:28 hp-laptop kernel: [&nbsp;&nbsp; 53.684139] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:28 hp-laptop kernel: [&nbsp;&nbsp; 53.684175] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:28 hp-laptop kernel: [&nbsp;&nbsp; 53.891250] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:28 hp-laptop kernel: [&nbsp;&nbsp; 53.891265] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:28 hp-laptop kernel: [&nbsp;&nbsp; 53.891277] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:28 hp-laptop kernel: [&nbsp;&nbsp; 53.891299] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:28 hp-laptop kernel: [&nbsp;&nbsp; 53.891310] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:29 hp-laptop kernel: [&nbsp;&nbsp; 54.618791] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:29 hp-laptop kernel: [&nbsp;&nbsp; 54.618831] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:29 hp-laptop kernel: [&nbsp;&nbsp; 54.641292] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:29 hp-laptop kernel: [&nbsp;&nbsp; 54.641306] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:29 hp-laptop kernel: [&nbsp;&nbsp; 54.641317] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:29 hp-laptop kernel: [&nbsp;&nbsp; 54.641339] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:29 hp-laptop kernel: [&nbsp;&nbsp; 54.641350] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 55.364158] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 55.364193] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 55.399893] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 55.399907] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 55.399919] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 55.399941] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 55.399953] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 55.616039] wlan0: no IPv6
    routers present<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 56.120159] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 56.120196] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 56.161586] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 56.161601] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 56.161614] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 56.161637] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:30 hp-laptop kernel: [&nbsp;&nbsp; 56.161647] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:31 hp-laptop kernel: [&nbsp;&nbsp; 56.884143] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:31 hp-laptop kernel: [&nbsp;&nbsp; 56.884181] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:31 hp-laptop kernel: [&nbsp;&nbsp; 56.896044] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:31 hp-laptop kernel: [&nbsp;&nbsp; 56.896057] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:31 hp-laptop kernel: [&nbsp;&nbsp; 56.896069] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:31 hp-laptop kernel: [&nbsp;&nbsp; 56.896091] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:31 hp-laptop kernel: [&nbsp;&nbsp; 56.896102] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:32 hp-laptop kernel: [&nbsp;&nbsp; 57.624156] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:32 hp-laptop kernel: [&nbsp;&nbsp; 57.624191] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:32 hp-laptop kernel: [&nbsp;&nbsp; 57.657094] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:32 hp-laptop kernel: [&nbsp;&nbsp; 57.657109] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:32 hp-laptop kernel: [&nbsp;&nbsp; 57.657122] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:32 hp-laptop kernel: [&nbsp;&nbsp; 57.657146] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:32 hp-laptop kernel: [&nbsp;&nbsp; 57.657157] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:33 hp-laptop kernel: [&nbsp;&nbsp; 58.772114] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:33 hp-laptop kernel: [&nbsp;&nbsp; 58.772148] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:33 hp-laptop kernel: [&nbsp;&nbsp; 58.831574] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:33 hp-laptop kernel: [&nbsp;&nbsp; 58.831589] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:33 hp-laptop kernel: [&nbsp;&nbsp; 58.831602] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:33 hp-laptop kernel: [&nbsp;&nbsp; 58.831625] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:33 hp-laptop kernel: [&nbsp;&nbsp; 58.831636] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:33 hp-laptop kernel: [&nbsp;&nbsp; 58.992731] EXT4-fs (sda2):
    re-mounted. Opts: errors=remount-ro,commit=0<br>
    Oct&nbsp; 9 23:46:34 hp-laptop kernel: [&nbsp;&nbsp; 59.552121] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:34 hp-laptop kernel: [&nbsp;&nbsp; 59.568106] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:46:34 hp-laptop kernel: [&nbsp;&nbsp; 59.568117] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:34 hp-laptop kernel: [&nbsp;&nbsp; 59.568129] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:34 hp-laptop kernel: [&nbsp;&nbsp; 59.568150] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:34 hp-laptop kernel: [&nbsp;&nbsp; 59.568160] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:35 hp-laptop kernel: [&nbsp;&nbsp; 60.516122] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:35 hp-laptop kernel: [&nbsp;&nbsp; 60.532072] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:35 hp-laptop kernel: [&nbsp;&nbsp; 60.543288] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:35 hp-laptop kernel: [&nbsp;&nbsp; 60.543302] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:35 hp-laptop kernel: [&nbsp;&nbsp; 60.543314] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:35 hp-laptop kernel: [&nbsp;&nbsp; 60.543338] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:35 hp-laptop kernel: [&nbsp;&nbsp; 60.543349] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:36 hp-laptop kernel: [&nbsp;&nbsp; 62.196073] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:36 hp-laptop kernel: [&nbsp;&nbsp; 62.212095] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:46:36 hp-laptop kernel: [&nbsp;&nbsp; 62.212101] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:36 hp-laptop kernel: [&nbsp;&nbsp; 62.212107] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:36 hp-laptop kernel: [&nbsp;&nbsp; 62.212119] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:36 hp-laptop kernel: [&nbsp;&nbsp; 62.212125] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 63.384103] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 63.400079] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 63.533956] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 63.533970] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 63.533982] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 63.534006] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 63.534016] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 64.256092] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 64.272094] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 64.272106] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 64.272117] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 64.272138] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:38 hp-laptop kernel: [&nbsp;&nbsp; 64.272148] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:39 hp-laptop kernel: [&nbsp;&nbsp; 64.996084] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:39 hp-laptop kernel: [&nbsp;&nbsp; 65.012092] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:46:39 hp-laptop kernel: [&nbsp;&nbsp; 65.012102] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:39 hp-laptop kernel: [&nbsp;&nbsp; 65.012111] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:39 hp-laptop kernel: [&nbsp;&nbsp; 65.012127] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:39 hp-laptop kernel: [&nbsp;&nbsp; 65.012135] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:41 hp-laptop kernel: [&nbsp;&nbsp; 66.472102] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:41 hp-laptop kernel: [&nbsp;&nbsp; 66.488208] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:41 hp-laptop kernel: [&nbsp;&nbsp; 66.524790] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:41 hp-laptop kernel: [&nbsp;&nbsp; 66.524801] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:41 hp-laptop kernel: [&nbsp;&nbsp; 66.524812] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:41 hp-laptop kernel: [&nbsp;&nbsp; 66.524837] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:41 hp-laptop kernel: [&nbsp;&nbsp; 66.524847] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:41 hp-laptop kernel: [&nbsp;&nbsp; 67.252102] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:41 hp-laptop kernel: [&nbsp;&nbsp; 67.268087] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 67.579093] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 67.579107] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 67.579119] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 67.579141] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 67.579152] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 68.300092] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 68.316094] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 68.316105] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 68.316115] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 68.316137] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:42 hp-laptop kernel: [&nbsp;&nbsp; 68.316148] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:43 hp-laptop kernel: [&nbsp;&nbsp; 69.040107] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:43 hp-laptop kernel: [&nbsp;&nbsp; 69.056129] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:46:43 hp-laptop kernel: [&nbsp;&nbsp; 69.056143] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:43 hp-laptop kernel: [&nbsp;&nbsp; 69.056154] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:43 hp-laptop kernel: [&nbsp;&nbsp; 69.056176] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:43 hp-laptop kernel: [&nbsp;&nbsp; 69.056188] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:45 hp-laptop kernel: [&nbsp;&nbsp; 70.776122] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:45 hp-laptop kernel: [&nbsp;&nbsp; 70.792091] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:45 hp-laptop kernel: [&nbsp;&nbsp; 70.792837] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:45 hp-laptop kernel: [&nbsp;&nbsp; 70.792852] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:45 hp-laptop kernel: [&nbsp;&nbsp; 70.792864] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:45 hp-laptop kernel: [&nbsp;&nbsp; 70.792888] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:45 hp-laptop kernel: [&nbsp;&nbsp; 70.792899] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:46 hp-laptop kernel: [&nbsp;&nbsp; 71.520161] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:46 hp-laptop kernel: [&nbsp;&nbsp; 71.537105] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:46:46 hp-laptop kernel: [&nbsp;&nbsp; 71.537121] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:46 hp-laptop kernel: [&nbsp;&nbsp; 71.537134] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:46 hp-laptop kernel: [&nbsp;&nbsp; 71.537159] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:46 hp-laptop kernel: [&nbsp;&nbsp; 71.537170] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:47 hp-laptop kernel: [&nbsp;&nbsp; 72.612168] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:47 hp-laptop kernel: [&nbsp;&nbsp; 72.628195] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:46:47 hp-laptop kernel: [&nbsp;&nbsp; 72.628212] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:47 hp-laptop kernel: [&nbsp;&nbsp; 72.628225] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:47 hp-laptop kernel: [&nbsp;&nbsp; 72.628254] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:47 hp-laptop kernel: [&nbsp;&nbsp; 72.628267] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:48 hp-laptop kernel: [&nbsp;&nbsp; 73.352111] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:48 hp-laptop kernel: [&nbsp;&nbsp; 73.368103] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:48 hp-laptop kernel: [&nbsp;&nbsp; 73.372610] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:48 hp-laptop kernel: [&nbsp;&nbsp; 73.372621] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:48 hp-laptop kernel: [&nbsp;&nbsp; 73.372632] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:48 hp-laptop kernel: [&nbsp;&nbsp; 73.372655] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:48 hp-laptop kernel: [&nbsp;&nbsp; 73.372666] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:49 hp-laptop kernel: [&nbsp;&nbsp; 74.352128] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:49 hp-laptop kernel: [&nbsp;&nbsp; 74.368082] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:49 hp-laptop kernel: [&nbsp;&nbsp; 74.384830] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:49 hp-laptop kernel: [&nbsp;&nbsp; 74.384842] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:49 hp-laptop kernel: [&nbsp;&nbsp; 74.384853] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:49 hp-laptop kernel: [&nbsp;&nbsp; 74.384874] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:49 hp-laptop kernel: [&nbsp;&nbsp; 74.384884] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:50 hp-laptop kernel: [&nbsp;&nbsp; 76.068109] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:50 hp-laptop kernel: [&nbsp;&nbsp; 76.084120] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:46:50 hp-laptop kernel: [&nbsp;&nbsp; 76.084133] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:50 hp-laptop kernel: [&nbsp;&nbsp; 76.084144] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:50 hp-laptop kernel: [&nbsp;&nbsp; 76.084166] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:50 hp-laptop kernel: [&nbsp;&nbsp; 76.084176] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:51 hp-laptop kernel: [&nbsp;&nbsp; 77.000137] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:51 hp-laptop kernel: [&nbsp;&nbsp; 77.016199] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:46:51 hp-laptop kernel: [&nbsp;&nbsp; 77.016213] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:51 hp-laptop kernel: [&nbsp;&nbsp; 77.016225] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:51 hp-laptop kernel: [&nbsp;&nbsp; 77.016249] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:51 hp-laptop kernel: [&nbsp;&nbsp; 77.016263] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:52 hp-laptop kernel: [&nbsp;&nbsp; 77.742212] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:52 hp-laptop kernel: [&nbsp;&nbsp; 77.756148] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2<br>
    Oct&nbsp; 9 23:46:52 hp-laptop kernel: [&nbsp;&nbsp; 77.756163] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:52 hp-laptop kernel: [&nbsp;&nbsp; 77.756174] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:52 hp-laptop kernel: [&nbsp;&nbsp; 77.756200] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:52 hp-laptop kernel: [&nbsp;&nbsp; 77.756211] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 78.480211] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 78.496106] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t1<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 78.496122] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 78.496134] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 78.496160] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 78.496172] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 79.220110] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 79.236087] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 79.273339] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 79.273349] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 79.273359] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 79.273381] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:53 hp-laptop kernel: [&nbsp;&nbsp; 79.273393] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:54 hp-laptop kernel: [&nbsp;&nbsp; 79.996102] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:54 hp-laptop kernel: [&nbsp;&nbsp; 80.012231] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:46:54 hp-laptop kernel: [&nbsp;&nbsp; 80.012246] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:54 hp-laptop kernel: [&nbsp;&nbsp; 80.012258] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:54 hp-laptop kernel: [&nbsp;&nbsp; 80.012281] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:54 hp-laptop kernel: [&nbsp;&nbsp; 80.012293] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:55 hp-laptop kernel: [&nbsp;&nbsp; 81.185827] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:55 hp-laptop kernel: [&nbsp;&nbsp; 81.200108] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:55 hp-laptop kernel: [&nbsp;&nbsp; 81.230849] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:55 hp-laptop kernel: [&nbsp;&nbsp; 81.230863] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:55 hp-laptop kernel: [&nbsp;&nbsp; 81.230875] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:55 hp-laptop kernel: [&nbsp;&nbsp; 81.230900] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:55 hp-laptop kernel: [&nbsp;&nbsp; 81.230913] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:56 hp-laptop kernel: [&nbsp;&nbsp; 81.956109] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:56 hp-laptop kernel: [&nbsp;&nbsp; 81.972120] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:46:56 hp-laptop kernel: [&nbsp;&nbsp; 81.972134] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:56 hp-laptop kernel: [&nbsp;&nbsp; 81.972144] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:56 hp-laptop kernel: [&nbsp;&nbsp; 81.972168] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:56 hp-laptop kernel: [&nbsp;&nbsp; 81.972178] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:57 hp-laptop kernel: [&nbsp;&nbsp; 82.696129] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:57 hp-laptop kernel: [&nbsp;&nbsp; 82.712205] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:46:57 hp-laptop kernel: [&nbsp;&nbsp; 82.712221] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:57 hp-laptop kernel: [&nbsp;&nbsp; 82.712234] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:57 hp-laptop kernel: [&nbsp;&nbsp; 82.712261] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:57 hp-laptop kernel: [&nbsp;&nbsp; 82.712273] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 83.436108] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 83.452119] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 83.452133] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 83.452144] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 83.452167] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 83.452178] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 84.176095] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 84.192077] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t1<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 84.192086] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 84.192096] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 84.192115] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:58 hp-laptop kernel: [&nbsp;&nbsp; 84.192124] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:46:59 hp-laptop kernel: [&nbsp;&nbsp; 84.916192] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:46:59 hp-laptop kernel: [&nbsp;&nbsp; 84.932132] ata1: EH complete<br>
    Oct&nbsp; 9 23:46:59 hp-laptop kernel: [&nbsp;&nbsp; 85.012393] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:46:59 hp-laptop kernel: [&nbsp;&nbsp; 85.012409] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:46:59 hp-laptop kernel: [&nbsp;&nbsp; 85.012421] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:46:59 hp-laptop kernel: [&nbsp;&nbsp; 85.012449] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:46:59 hp-laptop kernel: [&nbsp;&nbsp; 85.012461] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:00 hp-laptop kernel: [&nbsp;&nbsp; 85.736109] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:00 hp-laptop kernel: [&nbsp;&nbsp; 85.752087] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:00 hp-laptop kernel: [&nbsp;&nbsp; 85.756778] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:00 hp-laptop kernel: [&nbsp;&nbsp; 85.756788] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:00 hp-laptop kernel: [&nbsp;&nbsp; 85.756799] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:00 hp-laptop kernel: [&nbsp;&nbsp; 85.756820] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:00 hp-laptop kernel: [&nbsp;&nbsp; 85.756831] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 86.480128] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 86.496217] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 86.496233] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 86.496246] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 86.496276] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 86.496290] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 87.220104] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 87.236127] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 87.236141] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 87.236154] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 87.236178] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:01 hp-laptop kernel: [&nbsp;&nbsp; 87.236189] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:03 hp-laptop kernel: [&nbsp;&nbsp; 88.824106] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:03 hp-laptop kernel: [&nbsp;&nbsp; 88.840142] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2<br>
    Oct&nbsp; 9 23:47:03 hp-laptop kernel: [&nbsp;&nbsp; 88.840156] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:03 hp-laptop kernel: [&nbsp;&nbsp; 88.840167] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:03 hp-laptop kernel: [&nbsp;&nbsp; 88.840191] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:03 hp-laptop kernel: [&nbsp;&nbsp; 88.840202] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:05 hp-laptop kernel: [&nbsp;&nbsp; 91.228099] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:05 hp-laptop kernel: [&nbsp;&nbsp; 91.244105] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t1<br>
    Oct&nbsp; 9 23:47:05 hp-laptop kernel: [&nbsp;&nbsp; 91.244117] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:05 hp-laptop kernel: [&nbsp;&nbsp; 91.244127] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:05 hp-laptop kernel: [&nbsp;&nbsp; 91.244149] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:05 hp-laptop kernel: [&nbsp;&nbsp; 91.244161] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:06 hp-laptop kernel: [&nbsp;&nbsp; 91.968088] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:06 hp-laptop kernel: [&nbsp;&nbsp; 91.984080] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:06 hp-laptop kernel: [&nbsp;&nbsp; 91.984172] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:06 hp-laptop kernel: [&nbsp;&nbsp; 91.984181] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:06 hp-laptop kernel: [&nbsp;&nbsp; 91.984191] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:06 hp-laptop kernel: [&nbsp;&nbsp; 91.984209] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:06 hp-laptop kernel: [&nbsp;&nbsp; 91.984217] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:07 hp-laptop kernel: [&nbsp;&nbsp; 93.092103] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:07 hp-laptop kernel: [&nbsp;&nbsp; 93.108122] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:07 hp-laptop kernel: [&nbsp;&nbsp; 93.108137] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:07 hp-laptop kernel: [&nbsp;&nbsp; 93.108148] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:07 hp-laptop kernel: [&nbsp;&nbsp; 93.108169] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:07 hp-laptop kernel: [&nbsp;&nbsp; 93.108180] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:09 hp-laptop kernel: [&nbsp;&nbsp; 95.112109] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:09 hp-laptop kernel: [&nbsp;&nbsp; 95.128109] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:47:09 hp-laptop kernel: [&nbsp;&nbsp; 95.128124] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:09 hp-laptop kernel: [&nbsp;&nbsp; 95.128135] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:09 hp-laptop kernel: [&nbsp;&nbsp; 95.128158] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:09 hp-laptop kernel: [&nbsp;&nbsp; 95.128170] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:10 hp-laptop kernel: [&nbsp;&nbsp; 95.852102] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:10 hp-laptop kernel: [&nbsp;&nbsp; 95.868074] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:10 hp-laptop kernel: [&nbsp;&nbsp; 95.882872] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:10 hp-laptop kernel: [&nbsp;&nbsp; 95.882882] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:10 hp-laptop kernel: [&nbsp;&nbsp; 95.882892] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:10 hp-laptop kernel: [&nbsp;&nbsp; 95.882913] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:10 hp-laptop kernel: [&nbsp;&nbsp; 95.882924] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:11 hp-laptop kernel: [&nbsp;&nbsp; 96.604099] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:11 hp-laptop kernel: [&nbsp;&nbsp; 96.620082] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:11 hp-laptop kernel: [&nbsp;&nbsp; 96.648665] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:11 hp-laptop kernel: [&nbsp;&nbsp; 96.648673] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:11 hp-laptop kernel: [&nbsp;&nbsp; 96.648683] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:11 hp-laptop kernel: [&nbsp;&nbsp; 96.648701] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:11 hp-laptop kernel: [&nbsp;&nbsp; 96.648709] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 97.376257] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 97.392108] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 97.410862] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 97.410879] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 97.410892] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 97.410920] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 97.410934] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 98.260116] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 98.276107] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 98.276124] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 98.276136] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 98.276164] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:12 hp-laptop kernel: [&nbsp;&nbsp; 98.276177] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:13 hp-laptop kernel: [&nbsp;&nbsp; 99.000195] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:13 hp-laptop kernel: [&nbsp;&nbsp; 99.016149] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:47:13 hp-laptop kernel: [&nbsp;&nbsp; 99.016160] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:13 hp-laptop kernel: [&nbsp;&nbsp; 99.016171] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:13 hp-laptop kernel: [&nbsp;&nbsp; 99.016192] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:13 hp-laptop kernel: [&nbsp;&nbsp; 99.016203] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:14 hp-laptop kernel: [&nbsp;&nbsp; 99.964102] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:14 hp-laptop kernel: [&nbsp;&nbsp; 99.980080] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:14 hp-laptop kernel: [&nbsp; 100.335587] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:14 hp-laptop kernel: [&nbsp; 100.335600] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:14 hp-laptop kernel: [&nbsp; 100.335612] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:14 hp-laptop kernel: [&nbsp; 100.335633] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:14 hp-laptop kernel: [&nbsp; 100.335643] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:15 hp-laptop kernel: [&nbsp; 101.056137] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:15 hp-laptop kernel: [&nbsp; 101.074070] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:15 hp-laptop kernel: [&nbsp; 101.119317] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:15 hp-laptop kernel: [&nbsp; 101.119332] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:15 hp-laptop kernel: [&nbsp; 101.119343] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:15 hp-laptop kernel: [&nbsp; 101.119368] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:15 hp-laptop kernel: [&nbsp; 101.119378] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:16 hp-laptop kernel: [&nbsp; 101.840205] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:16 hp-laptop kernel: [&nbsp; 101.856861] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:16 hp-laptop kernel: [&nbsp; 101.931016] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:16 hp-laptop kernel: [&nbsp; 101.931031] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:16 hp-laptop kernel: [&nbsp; 101.931043] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:16 hp-laptop kernel: [&nbsp; 101.931069] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:16 hp-laptop kernel: [&nbsp; 101.931080] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:17 hp-laptop kernel: [&nbsp; 102.652105] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:17 hp-laptop kernel: [&nbsp; 102.668086] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:17 hp-laptop kernel: [&nbsp; 102.710314] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:17 hp-laptop kernel: [&nbsp; 102.710325] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:17 hp-laptop kernel: [&nbsp; 102.710336] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:17 hp-laptop kernel: [&nbsp; 102.710358] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:17 hp-laptop kernel: [&nbsp; 102.710370] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:18 hp-laptop kernel: [&nbsp; 103.912111] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:18 hp-laptop kernel: [&nbsp; 103.928113] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:18 hp-laptop kernel: [&nbsp; 103.928124] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:18 hp-laptop kernel: [&nbsp; 103.928133] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:18 hp-laptop kernel: [&nbsp; 103.928153] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:18 hp-laptop kernel: [&nbsp; 103.928163] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:19 hp-laptop kernel: [&nbsp; 104.652097] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:19 hp-laptop kernel: [&nbsp; 104.668076] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:19 hp-laptop kernel: [&nbsp; 104.769694] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:19 hp-laptop kernel: [&nbsp; 104.769705] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:19 hp-laptop kernel: [&nbsp; 104.769716] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:19 hp-laptop kernel: [&nbsp; 104.769737] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:19 hp-laptop kernel: [&nbsp; 104.769749] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:20 hp-laptop kernel: [&nbsp; 105.492087] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:20 hp-laptop kernel: [&nbsp; 105.508078] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:20 hp-laptop kernel: [&nbsp; 105.546197] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:20 hp-laptop kernel: [&nbsp; 105.546206] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:20 hp-laptop kernel: [&nbsp; 105.546215] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:20 hp-laptop kernel: [&nbsp; 105.546232] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:20 hp-laptop kernel: [&nbsp; 105.546241] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:21 hp-laptop kernel: [&nbsp; 106.652096] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:21 hp-laptop kernel: [&nbsp; 106.668099] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:21 hp-laptop kernel: [&nbsp; 106.668110] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:21 hp-laptop kernel: [&nbsp; 106.668121] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:21 hp-laptop kernel: [&nbsp; 106.668141] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:21 hp-laptop kernel: [&nbsp; 106.668150] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:22 hp-laptop kernel: [&nbsp; 107.392103] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:22 hp-laptop kernel: [&nbsp; 107.408128] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:47:22 hp-laptop kernel: [&nbsp; 107.408142] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:22 hp-laptop kernel: [&nbsp; 107.408154] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:22 hp-laptop kernel: [&nbsp; 107.408177] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:22 hp-laptop kernel: [&nbsp; 107.408189] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:24 hp-laptop kernel: [&nbsp; 109.732103] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:24 hp-laptop kernel: [&nbsp; 109.748089] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:24 hp-laptop kernel: [&nbsp; 109.761020] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:24 hp-laptop kernel: [&nbsp; 109.761035] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:24 hp-laptop kernel: [&nbsp; 109.761046] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:24 hp-laptop kernel: [&nbsp; 109.761068] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:24 hp-laptop kernel: [&nbsp; 109.761078] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:25 hp-laptop kernel: [&nbsp; 110.484088] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:25 hp-laptop kernel: [&nbsp; 110.500078] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:25 hp-laptop kernel: [&nbsp; 110.501794] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:25 hp-laptop kernel: [&nbsp; 110.501802] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:25 hp-laptop kernel: [&nbsp; 110.501812] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:25 hp-laptop kernel: [&nbsp; 110.501831] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:25 hp-laptop kernel: [&nbsp; 110.501840] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:25 hp-laptop kernel: [&nbsp; 111.224099] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:25 hp-laptop kernel: [&nbsp; 111.240076] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 111.463073] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 111.463082] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 111.463091] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 111.463107] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 111.463115] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 112.188101] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 112.204106] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 112.204117] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 112.204128] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 112.204149] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:26 hp-laptop kernel: [&nbsp; 112.204159] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:27 hp-laptop kernel: [&nbsp; 113.280089] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:27 hp-laptop kernel: [&nbsp; 113.296081] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:27 hp-laptop kernel: [&nbsp; 113.299602] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:27 hp-laptop kernel: [&nbsp; 113.299612] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:27 hp-laptop kernel: [&nbsp; 113.299622] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:27 hp-laptop kernel: [&nbsp; 113.299643] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:27 hp-laptop kernel: [&nbsp; 113.299652] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:28 hp-laptop kernel: [&nbsp; 114.020104] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:28 hp-laptop kernel: [&nbsp; 114.036109] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:28 hp-laptop kernel: [&nbsp; 114.036119] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:28 hp-laptop kernel: [&nbsp; 114.036130] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:28 hp-laptop kernel: [&nbsp; 114.036148] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:28 hp-laptop kernel: [&nbsp; 114.036159] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:29 hp-laptop kernel: [&nbsp; 114.760091] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:29 hp-laptop kernel: [&nbsp; 114.776080] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:29 hp-laptop kernel: [&nbsp; 114.791683] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:29 hp-laptop kernel: [&nbsp; 114.791691] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:29 hp-laptop kernel: [&nbsp; 114.791700] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:29 hp-laptop kernel: [&nbsp; 114.791716] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:29 hp-laptop kernel: [&nbsp; 114.791724] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:30 hp-laptop kernel: [&nbsp; 115.832369] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:30 hp-laptop kernel: [&nbsp; 115.848101] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:30 hp-laptop kernel: [&nbsp; 115.848112] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:30 hp-laptop kernel: [&nbsp; 115.848122] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:30 hp-laptop kernel: [&nbsp; 115.848142] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:30 hp-laptop kernel: [&nbsp; 115.848152] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:31 hp-laptop kernel: [&nbsp; 116.672140] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:31 hp-laptop kernel: [&nbsp; 116.688121] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:47:31 hp-laptop kernel: [&nbsp; 116.688139] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:31 hp-laptop kernel: [&nbsp; 116.688152] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:31 hp-laptop kernel: [&nbsp; 116.688179] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:31 hp-laptop kernel: [&nbsp; 116.688193] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:32 hp-laptop kernel: [&nbsp; 117.768250] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:32 hp-laptop kernel: [&nbsp; 117.784101] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:32 hp-laptop kernel: [&nbsp; 117.793206] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:32 hp-laptop kernel: [&nbsp; 117.793222] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:32 hp-laptop kernel: [&nbsp; 117.793237] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:32 hp-laptop kernel: [&nbsp; 117.793266] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:32 hp-laptop kernel: [&nbsp; 117.793280] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:33 hp-laptop kernel: [&nbsp; 118.708137] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:33 hp-laptop kernel: [&nbsp; 118.724086] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:33 hp-laptop kernel: [&nbsp; 118.724101] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:33 hp-laptop kernel: [&nbsp; 118.724112] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:33 hp-laptop kernel: [&nbsp; 118.724137] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:33 hp-laptop kernel: [&nbsp; 118.724149] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 119.448120] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 119.464114] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 119.464128] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 119.464140] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 119.464164] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 119.464175] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 120.188150] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 120.204125] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 120.204138] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 120.204149] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 120.204173] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:34 hp-laptop kernel: [&nbsp; 120.204184] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:36 hp-laptop kernel: [&nbsp; 121.856172] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:36 hp-laptop kernel: [&nbsp; 121.872149] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:36 hp-laptop kernel: [&nbsp; 121.972073] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:36 hp-laptop kernel: [&nbsp; 121.972088] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:36 hp-laptop kernel: [&nbsp; 121.972102] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:36 hp-laptop kernel: [&nbsp; 121.972135] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:36 hp-laptop kernel: [&nbsp; 121.972151] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:37 hp-laptop kernel: [&nbsp; 122.696103] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:37 hp-laptop kernel: [&nbsp; 122.712128] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:37 hp-laptop kernel: [&nbsp; 122.712141] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:37 hp-laptop kernel: [&nbsp; 122.712154] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:37 hp-laptop kernel: [&nbsp; 122.712179] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:37 hp-laptop kernel: [&nbsp; 122.712191] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 123.436205] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 123.452492] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 123.452899] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 123.452913] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 123.452925] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 123.452951] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 123.452963] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 124.304106] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 124.320139] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 124.320153] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 124.320166] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 124.320188] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:38 hp-laptop kernel: [&nbsp; 124.320198] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:40 hp-laptop kernel: [&nbsp; 126.136096] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:40 hp-laptop kernel: [&nbsp; 126.152104] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:47:40 hp-laptop kernel: [&nbsp; 126.152118] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:40 hp-laptop kernel: [&nbsp; 126.152129] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:40 hp-laptop kernel: [&nbsp; 126.152152] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:40 hp-laptop kernel: [&nbsp; 126.152162] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:41 hp-laptop kernel: [&nbsp; 126.876109] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:41 hp-laptop kernel: [&nbsp; 126.892086] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:41 hp-laptop kernel: [&nbsp; 126.926784] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:41 hp-laptop kernel: [&nbsp; 126.926803] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:41 hp-laptop kernel: [&nbsp; 126.926816] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:41 hp-laptop kernel: [&nbsp; 126.926842] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:41 hp-laptop kernel: [&nbsp; 126.926859] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:42 hp-laptop kernel: [&nbsp; 127.744131] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:42 hp-laptop kernel: [&nbsp; 127.760083] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:42 hp-laptop kernel: [&nbsp; 127.772116] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:42 hp-laptop kernel: [&nbsp; 127.772130] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:42 hp-laptop kernel: [&nbsp; 127.772141] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:42 hp-laptop kernel: [&nbsp; 127.772164] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:42 hp-laptop kernel: [&nbsp; 127.772174] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 128.496092] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 128.512095] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 128.512104] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 128.512114] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 128.512133] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 128.512142] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 129.236103] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 129.252106] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 129.252116] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 129.252125] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 129.252143] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:43 hp-laptop kernel: [&nbsp; 129.252152] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:44 hp-laptop kernel: [&nbsp; 129.976090] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:44 hp-laptop kernel: [&nbsp; 129.992078] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:44 hp-laptop kernel: [&nbsp; 130.029371] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:44 hp-laptop kernel: [&nbsp; 130.029380] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:44 hp-laptop kernel: [&nbsp; 130.029390] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:44 hp-laptop kernel: [&nbsp; 130.029407] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:44 hp-laptop kernel: [&nbsp; 130.029416] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:45 hp-laptop kernel: [&nbsp; 130.752214] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:45 hp-laptop kernel: [&nbsp; 130.768091] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:45 hp-laptop kernel: [&nbsp; 130.926051] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:45 hp-laptop kernel: [&nbsp; 130.926067] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:45 hp-laptop kernel: [&nbsp; 130.926079] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:45 hp-laptop kernel: [&nbsp; 130.926112] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:45 hp-laptop kernel: [&nbsp; 130.926125] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 133.376106] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 133.392086] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 133.428394] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 133.428407] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 133.428418] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 133.428442] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 133.428453] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 134.152100] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 134.168108] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 134.168119] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 134.168130] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 134.168150] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:48 hp-laptop kernel: [&nbsp; 134.168160] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:49 hp-laptop kernel: [&nbsp; 135.180110] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:49 hp-laptop kernel: [&nbsp; 135.196082] ata1: EH complete<br>
    Oct&nbsp; 9 23:47:49 hp-laptop kernel: [&nbsp; 135.206323] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen<br>
    Oct&nbsp; 9 23:47:49 hp-laptop kernel: [&nbsp; 135.206337] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:49 hp-laptop kernel: [&nbsp; 135.206350] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:49 hp-laptop kernel: [&nbsp; 135.206373] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:49 hp-laptop kernel: [&nbsp; 135.206383] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:50 hp-laptop kernel: [&nbsp; 135.928101] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:50 hp-laptop kernel: [&nbsp; 135.944104] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t4<br>
    Oct&nbsp; 9 23:47:50 hp-laptop kernel: [&nbsp; 135.944115] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:50 hp-laptop kernel: [&nbsp; 135.944127] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:50 hp-laptop kernel: [&nbsp; 135.944149] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:50 hp-laptop kernel: [&nbsp; 135.944159] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:51 hp-laptop kernel: [&nbsp; 136.668089] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:51 hp-laptop kernel: [&nbsp; 136.684094] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t3<br>
    Oct&nbsp; 9 23:47:51 hp-laptop kernel: [&nbsp; 136.684103] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:51 hp-laptop kernel: [&nbsp; 136.684113] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:51 hp-laptop kernel: [&nbsp; 136.684131] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:51 hp-laptop kernel: [&nbsp; 136.684140] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 137.416102] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 137.432116] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t2<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 137.432129] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 137.432139] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 137.432160] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 137.432170] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 138.156102] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 138.172095] ata1: exception
    Emask 0x10 SAct 0x0 SErr 0x4060000 action 0xe frozen t1<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 138.172108] ata1: irq_stat
    0x00000040, connection status changed<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 138.172119] ata1: SError: {
    PHYInt CommWake DevExch }<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 138.172140] ata1: limiting SATA
    link speed to 1.5 Gbps<br>
    Oct&nbsp; 9 23:47:52 hp-laptop kernel: [&nbsp; 138.172151] ata1: hard
    resetting link<br>
    Oct&nbsp; 9 23:47:53 hp-laptop kernel: [&nbsp; 138.896102] ata1: SATA link
    down (SStatus 0 SControl 310)<br>
    Oct&nbsp; 9 23:47:53 hp-laptop kernel: [&nbsp; 138.912088] ata1: EH pending
    after 5 tries, giving up<br>
    Oct&nbsp; 9 23:47:53 hp-laptop kernel: [&nbsp; 138.912098] ata1: EH complete<br>
    <br>
    <br>
    <br>
  </body>
</html>

--------------010007070204030002040907--
