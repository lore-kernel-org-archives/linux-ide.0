From: Thomas Renninger <trenn@suse.de>
Subject: Re: Hard freeze / interrupt-related death / instability
Date: Tue, 08 Apr 2008 22:47:53 +0200
Message-ID: <1207687673.3091.12.camel@linux-2bdv.site>
References: <d55656c10804080627r6cb7ba2ao37476b602e4f157e@mail.gmail.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56450 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbYDHUrr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Apr 2008 16:47:47 -0400
In-Reply-To: <d55656c10804080627r6cb7ba2ao37476b602e4f157e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Gervai <grinapo@gmail.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Hi,

I expect this is more a ata/ahci or chipset problem (this is ICH7,
right?), maybe ide list has an idea or has seen something similar
already?

Two more little comments below.

  Thomas

On Tue, 2008-04-08 at 15:27 +0200, Peter Gervai wrote:
> Hello,
> 
> First: I know, I *hate* such bug reports, because it's nearly impossible to
> reproduce, and not enough data available to be sure what's the problem. I hope
> the data I was able to gather _may_ help someone - or maybe not. Let me try.
> 
> Kernel: vanilla, released 2.6.24.* (right now .2, doesn't seem to matter)
> Hw: board Intel D945PVS, cpu Intel(R) Pentium(R) D CPU 3.00GHz (Type 0, Family
> 15, Model 6, Stepping 2), ram 2G, 2 SATA HDD (AHCI), 1 IDE HDD, 1 DVDROM, usb
> mouse, onboard e1000 eth, onboard intel HDA sound, NVidia 8400 GS, madwifi
> driven pci card.
> dmesg (partial) at the end, full on request, as well as any other info
> on the hw I forgot.
> 
> The machine started to "freeze" daily/2-3 daily, somwehere around the
> upgrade to 2.6.24
> -- I cannot really "noticed"
> because I bought RAM (which had to swapped 3 times until it ran through memtest,
> kingmax lifetime guarantee, tells a lot about the industry), changed
> the disks.. and
> tried to track the freeze to hardware components...
> but now I believe everything hardware-wise should be okay (I didn't change the
> power supply but it seems it wasn't the culprit).
> 
> The freeze occurs under Xwindow and usually goes the way that mouse became
> _extremely_ jerky, cpu load goes up and usege on both cores top 100%, often the
> hdd led stays lit. (That's why I started to blame sata/disks first.)
> 
> While the mouse works (kind of), the system isn't usable, and dies instantly
> (hard freeze) if I try to switch to console (by any means, including UnRaw/SAK
> sysrq combinations). (So I cannot even see the oops, if there was any. Most
> likely there was no oops but lots of sata/other irq timeouts.)
> 
> I have seen error messages as well related to sata (which is supposed to be
> related to the problem, but I cannot say for sure):
> 
> Mar 14 13:54:12 narya kernel: [102647.103323] ata3.00: exception Emask 0x0 SAct
> 0x7 SErr 0x0 action 0x2 frozen
> Mar 14 13:54:12 narya kernel: [102647.103336] ata3.00: cmd
> 60/f8:00:01:21:9b/00:00:24:00:00/40 tag 0 ncq 126976 in
> Mar 14 13:54:12 narya kernel: [102647.103338]          res
> 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> Mar 14 13:54:12 narya kernel: [102647.103343] ata3.00: status: { DRDY }
> Mar 14 13:54:12 narya kernel: [102647.103349] ata3.00: cmd
> 60/00:08:01:20:9b/01:00:24:00:00/40 tag 1 ncq 131072 in
> Mar 14 13:54:12 narya kernel: [102647.103350]          res
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 14 13:54:12 narya kernel: [102647.103354] ata3.00: status: { DRDY }
> Mar 14 13:54:12 narya kernel: [102647.103360] ata3.00: cmd
> 60/08:10:f9:21:9b/00:00:24:00:00/40 tag 2 ncq 4096 in
> Mar 14 13:54:12 narya kernel: [102647.103361]          res
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 14 13:54:12 narya kernel: [102647.103365] ata3.00: status: { DRDY }
> Mar 14 13:54:12 narya kernel: [102647.406031] ata3: soft resetting link
> Mar 14 13:54:12 narya kernel: [102647.558893] ata3: SATA link up 3.0 Gbps
> (SStatus 123 SControl 300)
> Mar 14 13:54:14 narya kernel: [102649.732201] ata3.00: configured for UDMA/133
> Mar 14 13:54:14 narya kernel: [102649.732225] ata3: EH complete
> Mar 14 13:54:14 narya kernel: [102649.732530] sd 2:0:0:0: [sdb] 625142448
> 512-byte hardware sectors (320073 MB)
> Mar 14 13:54:14 narya kernel: [102649.732549] sd 2:0:0:0: [sdb] Write
> Protect is off
> Mar 14 13:54:14 narya kernel: [102649.732552] sd 2:0:0:0: [sdb] Mode Sense: 00
> 3a 00 00
> Mar 14 13:54:14 narya kernel: [102649.732577] sd 2:0:0:0: [sdb] Write cache:
> enabled, read cache: enabled, doesn't support DPO or FUA
> Mar 14 13:54:44 narya kernel: [102679.704026] ata3.00: exception Emask 0x0 SAct
> 0x4 SErr 0x0 action 0x2 frozen
> Mar 14 13:54:44 narya kernel: [102679.704038] ata3.00: cmd
> 60/f8:10:01:21:9b/00:00:24:00:00/40 tag 2 ncq 126976 in
> Mar 14 13:54:44 narya kernel: [102679.704040]          res
> 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> Mar 14 13:54:44 narya kernel: [102679.704043] ata3.00: status: { DRDY }
> Mar 14 13:54:45 narya kernel: [102680.006733] ata3: soft resetting link
> Mar 14 13:54:45 narya kernel: [102680.159596] ata3: SATA link up 3.0 Gbps
> (SStatus 123 SControl 300)
> Mar 14 13:54:47 narya kernel: [102682.335802] ata3.00: configured for UDMA/133
> Mar 14 13:54:47 narya kernel: [102682.335816] ata3: EH complete
> Mar 14 13:54:47 narya kernel: [102682.336051] sd 2:0:0:0: [sdb] 625142448
> 512-byte hardware sectors (320073 MB)
> Mar 14 13:54:47 narya kernel: [102682.336070] sd 2:0:0:0: [sdb] Write
> Protect is off
> Mar 14 13:54:47 narya kernel: [102682.336073] sd 2:0:0:0: [sdb] Mode Sense: 00
> 3a 00 00
> Mar 14 13:54:47 narya kernel: [102682.336097] sd 2:0:0:0: [sdb] Write cache:
> enabled, read cache: enabled, doesn't support DPO or FUA
> Mar 14 13:55:17 narya kernel: [102712.307723] ata3.00: exception Emask 0x0 SAct
> 0x1 SErr 0x0 action 0x2 frozen
> Mar 14 13:55:17 narya kernel: [102712.307736] ata3.00: cmd
> 60/f8:00:01:21:9b/00:00:24:00:00/40 tag 0 ncq 126976 in
> Mar 14 13:55:17 narya kernel: [102712.307738]          res
> 40/00:fe:00:00:00/00:00:00:00:00/40 Emask 0x4 (timeout)
> Mar 14 13:55:17 narya kernel: [102712.307742] ata3.00: status: { DRDY }
> Mar 14 13:55:17 narya kernel: [102712.610430] ata3: soft resetting link
> Mar 14 13:55:18 narya kernel: [102712.763294] ata3: SATA link up 3.0 Gbps
> (SStatus 123 SControl 300)
> Mar 14 13:55:20 narya kernel: [102714.939406] ata3.00: configured for UDMA/133
> Mar 14 13:55:20 narya kernel: [102714.939420] ata3: EH complete
> Mar 14 13:55:20 narya kernel: [102714.939467] sd 2:0:0:0: [sdb] 625142448
> 512-byte hardware sectors (320073 MB)
> Mar 14 13:55:20 narya kernel: [102714.939486] sd 2:0:0:0: [sdb] Write
> Protect is off
> Mar 14 13:55:20 narya kernel: [102714.939489] sd 2:0:0:0: [sdb] Mode Sense: 00
> 3a 00 00
> Mar 14 13:55:20 narya kernel: [102714.939513] sd 2:0:0:0: [sdb] Write cache:
> enabled, read cache: enabled, doesn't support DPO or FUA
> 
> Looking it up didn't really helped, lots of natural remedies were tried, nothing
> helped. It seemed somehow related to the jerky death I experienced, like IRQs
> were choked or dead altogether, misrouted, whatever. (I stopped advancing in IRQ
> field since the original IBM PICs :))
> 
> Then one page started to suggest to play with acpi switches on boot, and I went
> on. The results:
> 
> #irqpoll                        - dies eventually
> #noapic irqpoll pci=nommconf    - dies eventually
> #pci=noacpi                     - dies eventually
> #noacpi                         - dies eventually, but it took longest (3 days)
> 
> #acpi=off                       - uniprocessor, ok
> #noapic acpi=off                - uniprocessor, ok
What means uniprocessor?
Also added nosmp or maxcpus=1?
> 
> These weren't "solutions" since the machine did not see the second core, and
> half a cpu isn't good enough, but it was stable (but slow).
> 
> #acpi_irq_balance               -
> Now, I am running under this one for 6 days, I cannot be _sure_ that it is going
> to stay alive, but this is the longest uptime in months.
> 
> My trouble is - if I understand this switch correctly - that this switch should
> not change anything, since this seems to be the default. So I leave the question
> open to you wise men what could that mean.
> 
> All kinds of dmesgs are available on request (using the boot params listed
> above), most of them ended with death. I do not have kernel log of the death
> because SATA/IDE dies as well, and I have no means now to serial console myself.
> 
> Thanks,
> Peter
> 
> ps: please cc me, I am not on the list. Thank you.
> 
> 
> There follows the top of the current (working) dmesg.
> 
> [    0.000000] Linux version 2.6.24.4-narya2 (root@narya.grin.hu) (gcc version
> 4.2.3 (Debian 4.2.3-1)) #1 SMP PREEMPT Mon Mar 31 21:08:31 CEST 2008
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
> [    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
> [    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> [    0.000000]  BIOS-e820: 0000000000100000 - 000000007ee4c000 (usable)
> [    0.000000]  BIOS-e820: 000000007ee4c000 - 000000007ee98000 (ACPI NVS)
> [    0.000000]  BIOS-e820: 000000007ee98000 - 000000007fea7000 (usable)
> [    0.000000]  BIOS-e820: 000000007fea7000 - 000000007fee9000 (ACPI NVS)
> [    0.000000]  BIOS-e820: 000000007fee9000 - 000000007feec000 (usable)
> [    0.000000]  BIOS-e820: 000000007feec000 - 000000007feff000 (ACPI data)
> [    0.000000]  BIOS-e820: 000000007feff000 - 000000007ff00000 (usable)
> [    0.000000] 1151MB HIGHMEM available.
> [    0.000000] 896MB LOWMEM available.
> [    0.000000] found SMP MP-table at 000fe680
> [    0.000000] Entering add_active_range(0, 0, 524032) 0 entries of 256 used
> [    0.000000] Zone PFN ranges:
> [    0.000000]   DMA             0 ->     4096
> [    0.000000]   Normal       4096 ->   229376
> [    0.000000]   HighMem    229376 ->   524032
> [    0.000000] Movable zone start PFN for each node
> [    0.000000] early_node_map[1] active PFN ranges
> [    0.000000]     0:        0 ->   524032
> [    0.000000] On node 0 totalpages: 524032
> [    0.000000]   DMA zone: 32 pages used for memmap
> [    0.000000]   DMA zone: 0 pages reserved
> [    0.000000]   DMA zone: 4064 pages, LIFO batch:0
> [    0.000000]   Normal zone: 1760 pages used for memmap
> [    0.000000]   Normal zone: 223520 pages, LIFO batch:31
> [    0.000000]   HighMem zone: 2302 pages used for memmap
> [    0.000000]   HighMem zone: 292354 pages, LIFO batch:31
> [    0.000000]   Movable zone: 0 pages used for memmap
> [    0.000000] DMI 2.3 present.
> [    0.000000] ACPI: RSDP 000FE020, 0014 (r0 INTEL )
> [    0.000000] ACPI: RSDT 7FEFDE48, 0040 (r1 INTEL  D945PVS        67
> MSFT  1000013)
> [    0.000000] ACPI: FACP 7FEFCF10, 0074 (r1 INTEL  D945PVS        67
> MSFT  1000013)
> [    0.000000] ACPI: DSDT 7FEF7010, 4112 (r1 INTEL  D945PVS        67
> MSFT  1000013)
> [    0.000000] ACPI: FACS 7FEE4C40, 0040
> [    0.000000] ACPI: APIC 7FEFCE10, 0078 (r1 INTEL  D945PVS        67
> MSFT  1000013)
> [    0.000000] ACPI: WDDT 7FEF6F90, 0040 (r1 INTEL  D945PVS        67
> MSFT  1000013)
> [    0.000000] ACPI: MCFG 7FEF6F10, 003C (r1 INTEL  D945PVS        67
> MSFT  1000013)
> [    0.000000] ACPI: ASF! 7FEFCD10, 00A6 (r32 INTEL  D945PVS        67 MSFT
> 1000013)
> [    0.000000] ACPI: HPET 7FEF6E90, 0038 (r1 INTEL  D945PVS        67
> MSFT  1000013)
> [    0.000000] ACPI: SSDT 7FEF6E10, 002F (r1 INTEL  SetupVar       67
> MSFT  1000013)
> [    0.000000] ACPI: PM-Timer IO Port: 0x408
> [    0.000000] ACPI: Local APIC address 0xfee00000
> [    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
> [    0.000000] Processor #0 15:6 APIC version 20
> [    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
> [    0.000000] Processor #1 15:6 APIC version 20
> [    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
> [    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
> [    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
> [    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> [    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.000000] ACPI: IRQ0 used by override.
> [    0.000000] ACPI: IRQ2 used by override.
> [    0.000000] ACPI: IRQ9 used by override.
> [    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
> [    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.000000] Using ACPI (MADT) for SMP configuration information
> [    0.000000] Allocating PCI resources starting at 80000000 (gap:
> 7ff00000:80100000)
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total
> pages: 519938
> [    0.000000] Kernel command line: root=/dev/md1 rootflags=usrquota,prjquota rw
> vga=1 acpi_irq_balance
> [    0.000000] mapped APIC to ffffb000 (fee00000)
> [    0.000000] mapped IOAPIC to ffffa000 (fec00000)
> [    0.000000] Enabling fast FPU save and restore... done.
> [    0.000000] Enabling unmasked SIMD FPU exception support... done.
> [    0.000000] Initializing CPU#0
> [    0.000000] PID hash table entries: 4096 (order: 12, 16384 bytes)
> [    0.000000] Detected 3000.267 MHz processor.
> [   24.867461] Console: colour VGA+ 80x50
> [   24.867465] console [tty0] enabled
> [   24.870184] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [   24.870628] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [   24.985942] Memory: 2073056k/2096128k available (2455k kernel code, 21212k
> reserved, 843k data, 216k init, 1177980k highmem)
> [   24.986013] virtual kernel memory layout:
> [   24.986014]     fixmap  : 0xfff4d000 - 0xfffff000   ( 712 kB)
> [   24.986015]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
> [   24.986016]     vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
> [   24.986017]     lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
> [   24.986018]       .init : 0xc0440000 - 0xc0476000   ( 216 kB)
> [   24.986019]       .data : 0xc0365f92 - 0xc0438f3c   ( 843 kB)
> [   24.986021]       .text : 0xc0100000 - 0xc0365f92   (2455 kB)
> [   24.986377] Checking if this processor honours the WP bit even in supervisor
> mode... Ok.
> [   24.986502] SLUB: Genslabs=11, HWalign=64, Order=0-1, MinObjects=4, CPUs=2,
> Nodes=1
> [   24.986644] hpet clockevent registered
> [   25.046593] Calibrating delay using timer specific routine.. 6004.39 BogoMIPS
> (lpj=3002199)
> [   25.046701] Security Framework initialized
> [   25.046750] Capability LSM initialized
> [   25.046805] Mount-cache hash table entries: 512
> [   25.046969] Initializing cgroup subsys ns
> [   25.047016] Initializing cgroup subsys cpuacct
> [   25.047074] CPU: After generic identify, caps: bfebfbff 20100000 00000000
> 00000000 0000e43d 00000000 00000001 00000000
> [   25.047083] monitor/mwait feature present.
> [   25.047127] using mwait in idle threads.
> [   25.047177] CPU: Trace cache: 12K uops, L1 D cache: 16K
> [   25.047254] CPU: L2 cache: 2048K
> [   25.047298] CPU: Physical Processor ID: 0
> [   25.047342] CPU: Processor Core ID: 0
> [   25.047387] CPU: After all inits, caps: bfebfbff 20100000 00000000 0000b180
> 0000e43d 00000000 00000001 00000000
> [   25.047394] Intel machine check architecture supported.
> [   25.047444] Intel machine check reporting enabled on CPU#0.
> [   25.047491] CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
> [   25.047541] Compat vDSO mapped to ffffe000.
> [   25.047607] Checking 'hlt' instruction... OK.
> [   25.051892] SMP alternatives: switching to UP code
> [   25.052833] ACPI: Core revision 20070126
> [   25.055461] CPU0: Intel(R) Pentium(R) D CPU 3.00GHz stepping 02
> [   25.055594] SMP alternatives: switching to SMP code
> [   25.056255] Booting processor 1/1 eip 3000
> [   25.066755] Initializing CPU#1
> [   25.126514] Calibrating delay using timer specific routine.. 6000.30 BogoMIPS
> (lpj=3000154)
> [   25.126523] CPU: After generic identify, caps: bfebfbff 20100000 00000000
> 00000000 0000e43d 00000000 00000001 00000000
> [   25.126529] monitor/mwait feature present.
> [   25.126535] CPU: Trace cache: 12K uops, L1 D cache: 16K
> [   25.126537] CPU: L2 cache: 2048K
> [   25.126539] CPU: Physical Processor ID: 0
> [   25.126541] CPU: Processor Core ID: 1
> [   25.126543] CPU: After all inits, caps: bfebfbff 20100000 00000000 0000b180
> 0000e43d 00000000 00000001 00000000
> [   25.126548] Intel machine check architecture supported.
> [   25.126554] Intel machine check reporting enabled on CPU#1.
> [   25.126556] CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
> [   25.127042] CPU1: Intel(R) Pentium(R) D CPU 3.00GHz stepping 02
> [   25.127634] Total of 2 processors activated (12004.70 BogoMIPS).
> [   25.127826] ENABLING IO-APIC IRQs
> [   25.128042] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
> [   25.239502] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
> [   25.259579] Brought up 2 CPUs
> [   25.259647] CPU0 attaching sched-domain:
> [   25.259651]  domain 0: span 03
> [   25.259653]   groups: 01 02
> [   25.259657] CPU1 attaching sched-domain:
> [   25.259659]  domain 0: span 03
> [   25.259661]   groups: 02 01
> [   25.259875] net_namespace: 64 bytes
> [   25.260503] NET: Registered protocol family 16
> [   25.260754] ACPI: bus type pci registered
> [   25.260899] PCI: Found Intel Corporation 945G/GZ/P/PL Express Memory
> Controller Hub without MMCONFIG support.
> [   25.263613] PCI: Using configuration type 1
> [   25.263658] Setting up standard PCI resources
> [   25.274462] ACPI: EC: Look up EC in DSDT
> [   25.276225] ACPI: Interpreter enabled
> [   25.276272] ACPI: (supports S0 S1 S3 S5)
> [   25.276467] ACPI: Using IOAPIC for interrupt routing
> [   25.280755] ACPI: PCI Root Bridge [PCI0] (0000:00)
> [   25.281476] PCI quirk: region 0400-047f claimed by ICH6 ACPI/GPIO/TCO
> [   25.281527] PCI quirk: region 0500-053f claimed by ICH6 GPIO
> [   25.282586] PCI: Transparent bridge - 0000:00:1e.0
> [   25.282675] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> [   25.283012] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P32_._PRT]
> [   25.283431] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX0._PRT]
> [   25.283551] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX2._PRT]
> [   25.283668] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX3._PRT]
> [   25.283786] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX4._PRT]
> [   25.283904] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PEX5._PRT]
> [   25.288003] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
> [   25.288483] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 *10 11 12)
> [   25.288939] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *9 10 11 12)
> [   25.289400] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 9 10 *11 12)
> [   25.289858] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 11 12) *0,
> disabled.
> [   25.290390] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 9 10 11 12) *0,
> disabled.
> [   25.290917] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 *9 10 11 12)
> [   25.291376] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 9 *10 11 12)
> [   25.291883] Linux Plug and Play Support v0.97 (c) Adam Belay
> [   25.291968] pnp: PnP ACPI init
> [   25.292020] ACPI: bus type pnp registered
> [   25.293016] pnp 00:00: Plug and Play ACPI device, IDs PNP0a03 (active)
> [   25.293076] pnp 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [   25.293406] pnp 00:02: Plug and Play ACPI device, IDs PNP0200 (active)
> [   25.293474] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
> [   25.293541] pnp 00:04: Plug and Play ACPI device, IDs PNP0c04 (active)
> [   25.293605] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
> [   25.293669] pnp 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> [   25.294197] pnp 00:07: Plug and Play ACPI device, IDs PNP0401 (active)
> [   25.294327] pnp 00:08: Plug and Play ACPI device, IDs PNP0303
> PNP030b (active)
> [   25.294592] pnp 00:09: Plug and Play ACPI device, IDs PNP0501 (active)
> [   25.294699] pnp 00:0a: Plug and Play ACPI device, IDs PNP0003 (active)
> [   25.294797] pnp 00:0b: Plug and Play ACPI device, IDs PNP0103 (active)
> [   25.294827] pnp: PnP ACPI: found 12 devices
> [   25.294874] ACPI: ACPI bus type pnp unregistered
> [   25.295129] SCSI subsystem initialized
> [   25.295215] libata version 3.00 loaded.
> [   25.295393] PCI: Using ACPI for IRQ routing
> [   25.295440] PCI: If a device doesn't work, try "pci=routeirq".  If it helps,
> post a report
> [   25.299364] NetLabel: Initializing
> [   25.299410] NetLabel:  domain hash size = 128
> [   25.299455] NetLabel:  protocols = UNLABELED CIPSOv4
> [   25.299514] NetLabel:  unlabeled traffic allowed by default
> [   25.299565] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [   25.299737] hpet0: 3 64-bit timers, 14318180 Hz
> [   25.301353] Time: tsc clocksource has been installed.
> [   25.303358] pnp: the driver 'system' has been registered
> [   25.303401] system 00:01: iomem range 0xf0000000-0xf3ffffff has been reserved
> [   25.303452] system 00:01: iomem range 0xfed13000-0xfed13fff has been reserved
> [   25.303501] system 00:01: iomem range 0xfed14000-0xfed17fff has been reserved
> [   25.303550] system 00:01: iomem range 0xfed18000-0xfed18fff has been reserved
> [   25.303600] system 00:01: iomem range 0xfed19000-0xfed19fff has been reserved
> [   25.303649] system 00:01: iomem range 0xfed1c000-0xfed1ffff has been reserved
> [   25.303698] system 00:01: iomem range 0xfed20000-0xfed3ffff has been reserved
> [   25.303750] system 00:01: iomem range 0xfed45000-0xfed99fff has been reserved
> [   25.303799] system 00:01: iomem range 0xc0000-0xdffff could not be reserved
> [   25.303848] system 00:01: iomem range 0xe0000-0xfffff could not be reserved
> [   25.303896] system 00:01: driver attached
> [   25.303906] system 00:06: ioport range 0x500-0x53f has been reserved
> [   25.303954] system 00:06: ioport range 0x400-0x47f has been reserved
> [   25.304002] system 00:06: ioport range 0x680-0x6ff has been reserved
> [   25.304050] system 00:06: driver attached
> [   25.334535] PCI: Failed to allocate mem resource #6:20000@90000000 for
> 0000:01:00.0
> [   25.334594] PCI: Bridge: 0000:00:01.0
> [   25.334639]   IO window: 2000-2fff
> [   25.334686]   MEM window: 90000000-92ffffff
> [   25.334732]   PREFETCH window: 80000000-8fffffff
> [   25.334779] PCI: Bridge: 0000:00:1c.0
> [   25.334825]   IO window: 1000-1fff
> [   25.334872]   MEM window: 93100000-931fffff
> [   25.334918]   PREFETCH window: disabled.
> [   25.334966] PCI: Bridge: 0000:00:1c.2
> [   25.335010]   IO window: disabled.
> [   25.335057]   MEM window: 93300000-933fffff
> [   25.337138]   PREFETCH window: disabled.
> [   25.337186] PCI: Bridge: 0000:00:1c.3
> [   25.337230]   IO window: disabled.
> [   25.337277]   MEM window: 93400000-934fffff
> [   25.337326]   PREFETCH window: disabled.
> [   25.337374] PCI: Bridge: 0000:00:1c.4
> [   25.337417]   IO window: disabled.
> [   25.337464]   MEM window: 93500000-935fffff
> [   25.337511]   PREFETCH window: disabled.
> [   25.337558] PCI: Bridge: 0000:00:1c.5
> [   25.337602]   IO window: disabled.
> [   25.337649]   MEM window: 93600000-936fffff
> [   25.337695]   PREFETCH window: disabled.
> [   25.337743] PCI: Bridge: 0000:00:1e.0
> [   25.337787]   IO window: disabled.
> [   25.337834]   MEM window: 93000000-930fffff
> [   25.337880]   PREFETCH window: disabled.
> [   25.337938] ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level,
> low) -> IRQ 16
> [   25.338030] PCI: Setting latency timer of device 0000:00:01.0 to 64
> [   25.338051] ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 17 (level,
> low) -> IRQ 17
> [   25.338142] PCI: Setting latency timer of device 0000:00:1c.0 to 64
> [   25.338161] ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level,
> low) -> IRQ 18
> [   25.338251] PCI: Setting latency timer of device 0000:00:1c.2 to 64
> [   25.338269] ACPI: PCI Interrupt 0000:00:1c.3[D] -> GSI 19 (level,
> low) -> IRQ 19
> [   25.338363] PCI: Setting latency timer of device 0000:00:1c.3 to 64
> [   25.338381] ACPI: PCI Interrupt 0000:00:1c.4[A] -> GSI 17 (level,
> low) -> IRQ 17
> [   25.338472] PCI: Setting latency timer of device 0000:00:1c.4 to 64
> [   25.338489] ACPI: PCI Interrupt 0000:00:1c.5[B] -> GSI 16 (level,
> low) -> IRQ 16
> [   25.338580] PCI: Setting latency timer of device 0000:00:1c.5 to 64
> [   25.338590] PCI: Setting latency timer of device 0000:00:1e.0 to 64
> [   25.338601] NET: Registered protocol family 2
> [   25.347380] IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
> [   25.347728] TCP established hash table entries: 131072 (order: 8,
> 1048576 bytes)
> [   25.348376] TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
> [   25.348754] TCP: Hash tables configured (established 131072 bind 65536)
> [   25.348802] TCP reno registered
> [   25.351890] Machine check exception polling timer started.
> [   25.352314] audit: initializing netlink socket (disabled)
> [   25.352373] audit(1207040944.244:1): initialized
> [   25.352610] highmem bounce pool size: 64 pages
> [   25.355364] VFS: Disk quotas dquot_6.5.1
> [   25.355500] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> [   25.355926] SGI XFS with ACLs, security attributes, realtime, no
> debug enabled
> [   25.356686] SGI XFS Quota Management subsystem
> [   25.356852] io scheduler noop registered
> [   25.356898] io scheduler anticipatory registered
> [   25.356943] io scheduler deadline registered
> [   25.357069] io scheduler cfq registered (default)
> [   25.357135] pci 0000:00:1d.0: uhci_check_and_reset_hc: legsup = 0x0f10
> [   25.357137] pci 0000:00:1d.0: Performing full reset
> [   25.357153] pci 0000:00:1d.1: uhci_check_and_reset_hc: legsup = 0x0010
> [   25.357155] pci 0000:00:1d.1: Performing full reset
> [   25.357170] pci 0000:00:1d.2: uhci_check_and_reset_hc: legsup = 0x0010
> [   25.357172] pci 0000:00:1d.2: Performing full reset
> [   25.357187] pci 0000:00:1d.3: uhci_check_and_reset_hc: legsup = 0x0010
> [   25.357189] pci 0000:00:1d.3: Performing full reset
> [   25.357323] Boot video device is 0000:01:00.0
> [   25.357452] PCI: Setting latency timer of device 0000:00:01.0 to 64
> [   25.357495] assign_interrupt_mode Found MSI capability
> [   25.357571] Allocate Port Service[0000:00:01.0:pcie00]
> [   25.357663] PCI: Setting latency timer of device 0000:00:1c.0 to 64
> [   25.357704] assign_interrupt_mode Found MSI capability
> [   25.357783] Allocate Port Service[0000:00:1c.0:pcie00]
> [   25.357829] Allocate Port Service[0000:00:1c.0:pcie02]
> [   25.357925] PCI: Setting latency timer of device 0000:00:1c.2 to 64
> [   25.357967] assign_interrupt_mode Found MSI capability
> [   25.358045] Allocate Port Service[0000:00:1c.2:pcie00]
> [   25.358090] Allocate Port Service[0000:00:1c.2:pcie02]
> [   25.358186] PCI: Setting latency timer of device 0000:00:1c.3 to 64
> [   25.358228] assign_interrupt_mode Found MSI capability
> [   25.358306] Allocate Port Service[0000:00:1c.3:pcie00]
> [   25.358362] Allocate Port Service[0000:00:1c.3:pcie02]
> [   25.358458] PCI: Setting latency timer of device 0000:00:1c.4 to 64
> [   25.358503] assign_interrupt_mode Found MSI capability
> [   25.358581] Allocate Port Service[0000:00:1c.4:pcie00]
> [   25.358626] Allocate Port Service[0000:00:1c.4:pcie02]
> [   25.358720] PCI: Setting latency timer of device 0000:00:1c.5 to 64
> [   25.358762] assign_interrupt_mode Found MSI capability
> [   25.358840] Allocate Port Service[0000:00:1c.5:pcie00]
> [   25.358884] Allocate Port Service[0000:00:1c.5:pcie02]
> [   25.359201] input: Power Button (FF) as /devices/virtual/input/input0
> [   25.359251] ACPI: Power Button (FF) [PWRF]
> [   25.359387] input: Sleep Button (CM) as /devices/virtual/input/input1
> [   25.359439] ACPI: Sleep Button (CM) [SLPB]
> [   25.359729] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor
> Device is not present [20070126]
> [   25.359862] ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor
> Device is not present [20070126]
> [   25.371633] hpet_resources: 0xfed00000 is busy
> [   25.371653] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds,
> margin is 60 seconds).
> [   25.371713] Hangcheck: Using get_cycles().
> [   25.372567] RAMDISK driver initialized: 16 RAM disks of 4096K size
> 1024 blocksize
> [   25.372629] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> [   25.372678] ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> [   25.372795] ICH7: IDE controller (0x8086:0x27df rev 0x01) at  PCI slot
> 0000:00:1f.1
> [   25.372858] ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level,
> low) -> IRQ 18
> [   25.372951] ICH7: not 100% native mode: will probe irqs later
> [   25.373005]     ide0: BM-DMA at 0x30b0-0x30b7, BIOS settings:
> hda:DMA, hdb:DMA
> [   25.373129] ICH7: IDE port disabled
> [   25.373175] Probing IDE interface ide0...
> [   25.608235] Switched to high resolution mode on CPU 1
> [   25.609057] Switched to high resolution mode on CPU 0
> [   25.634589] hdb: SAMSUNG SV1204H, ATA DISK drive
> [   26.042288] hda: _NEC DVD_RW ND-4550A, ATAPI CD/DVD-ROM drive
> [   26.042441] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> [   26.042587] hda: UDMA/33 mode selected
> [   26.042818] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
> [   26.042884] hdb: UDMA/100 mode selected
> [   26.043024] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> [   26.046910] Probing IDE interface ide1...
> [   26.559520] hdb: max request size: 128KiB
> [   26.559645] hdb: 234493056 sectors (120060 MB) w/2048KiB Cache,
> CHS=65535/16/63
> [   26.559838] hdb: cache flushes supported
> [   26.559923]  hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 >
> [   26.625598] hda: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
> [   26.625837] Uniform CD-ROM driver Revision: 3.20
> [   26.627963] Driver 'sd' needs updating - please use bus_type methods
> [   26.628086] ahci 0000:00:1f.2: version 3.0
> [   26.628112] ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level,
> low) -> IRQ 19
> [   27.627695] ahci 0000:00:1f.2: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf
> impl SATA mode
> [   27.627754] ahci 0000:00:1f.2: flags: 64bit ncq led clo pio slum part
> [   27.627804] PCI: Setting latency timer of device 0000:00:1f.2 to 64
> [   27.628034] scsi0 : ahci
> [   27.628158] scsi1 : ahci
> [   27.628271] scsi2 : ahci
> [   27.628385] scsi3 : ahci
> [   27.628542] ata1: SATA max UDMA/133 abar m1024@0x93204000 port
> 0x93204100 irq 217
> [   27.628601] ata2: SATA max UDMA/133 abar m1024@0x93204000 port
> 0x93204180 irq 217
> [   27.628658] ata3: SATA max UDMA/133 abar m1024@0x93204000 port
> 0x93204200 irq 217
> [   27.628721] ata4: SATA max UDMA/133 abar m1024@0x93204000 port
> 0x93204280 irq 217
> [   27.931456] ata1: SATA link down (SStatus 0 SControl 300)
> [   28.387121] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   28.390348] ata2.00: ATA-7: SAMSUNG SP2004C, VM100-33, max UDMA7
> [   28.390397] ata2.00: 390721968 sectors, multi 16: LBA48 NCQ (depth 31/32)
> [   28.393653] ata2.00: configured for UDMA/133
> [   28.859773] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   28.880347] ata3.00: ATA-8: SAMSUNG HD321KJ, CP100-12, max UDMA7
> [   28.880396] ata3.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
> [   28.882418] ata3.00: configured for UDMA/133
> [   29.348413] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [   29.369196] ata4.00: ATA-8: WDC WD3200AAKS-00YGA0, 12.01C02, max UDMA/133
> [   29.369246] ata4.00: 625142448 sectors, multi 16: LBA48 NCQ (depth 31/32)
> [   29.370044] ata4.00: configured for UDMA/133
> [   29.380472] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG SP2004C  VM10
> PQ: 0 ANSI: 5
> [   29.380661] sd 1:0:0:0: [sda] 390721968 512-byte hardware sectors (200050 MB)
> [   29.380723] sd 1:0:0:0: [sda] Write Protect is off
> ...
> 
> grin@narya:~$ cat /proc/interrupts
>            CPU0       CPU1
>   0:       2321          0   IO-APIC-edge      timer
>   1:     180936     130348   IO-APIC-edge      i8042
>   4:    1312180    1012562   IO-APIC-edge      serial
>   7:          0          0   IO-APIC-edge      parport0
>   9:          0          0   IO-APIC-fasteoi   acpi
>  14:    5588399     135231   IO-APIC-edge      ide0
>  16:   35116207    2613936   IO-APIC-fasteoi   uhci_hcd:usb4, nvidia
>  17:          3          0   IO-APIC-fasteoi   ohci1394
>  18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb3
>  19:     600387     935577   IO-APIC-fasteoi   uhci_hcd:usb2
>  20:      19730      21023   IO-APIC-fasteoi   uhci_hcd:usb1, ehci_hcd:usb5
>  21:    5219472   51586534   IO-APIC-fasteoi   wifi0, HDA Intel
> 216:         71     817955   PCI-MSI-edge      eth1
> 217:     323619   34269764   PCI-MSI-edge      ahci
Maybe pci=nomsi helps?

> NMI:          0          0   Non-maskable interrupts
> LOC:  704379435  704036426   Local timer interrupts
> RES:    7502797    5744836   Rescheduling interrupts
> CAL:      58926      13905   function call interrupts
> TLB:    3064915    1626067   TLB shootdowns
> TRM:          0          0   Thermal event interrupts
> SPU:          0          0   Spurious interrupts
> ERR:          0
> MIS:          0


