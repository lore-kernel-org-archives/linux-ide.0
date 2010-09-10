From: Hugo Antunes <hugo.antunes@gmail.com>
Subject: Re: sata_sil boot problems with kernel 2.6.35 and current git
Date: Fri, 10 Sep 2010 15:30:04 +0100
Message-ID: <4C8A40EC.3090606@gmail.com>
References: <20100908182651.GA32114@seek.priv> <4C88F69E.6070000@kernel.org> <4C8A210C0200007800015648@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020106090208000304000504"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46750 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab0IJOgn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Sep 2010 10:36:43 -0400
Received: by wyf22 with SMTP id 22so2878890wyf.19
        for <linux-ide@vger.kernel.org>; Fri, 10 Sep 2010 07:36:41 -0700 (PDT)
In-Reply-To: <4C8A210C0200007800015648@vpn.id2.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, dieter@plaetinck.be, Sergei Shtylyov <sshtylyov@ru.mvista.com>, gianluca <gianluca@sottospazio.it>, Mark Lord <kernel@teksavvy.com>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020106090208000304000504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Greetings,

Following the list this pasts days as a sysadmin, building a big machine
with 45 sata2 disks (WD green 1.5TB), Sil3124 4 ports sata2 with 9 port
multipliers with 5 each also from Silicom image.

This machine should smoke but it doesn't, attached is the dmesg dump where it is possible to see the enourmous ammount
 of hard and soft resets.Using Ubuntu/server 10.4 2.6.32-25-server x86_64, been questioning if this patch could 
make me have better i/o, sata link allways at half speed, going to build a debian/ubuntu kernel image with the patch, 
if anyone has a link for a deb image with this patch..apreciated.

Keep the good work

Regards,
./hantunes



On 09/10/2010 11:14 AM, Jan Beulich wrote:
>>>> On 09.09.10 at 17:00, Tejun Heo <tj@kernel.org> wrote:
>>>>         
>> Can you please test whether the patch at the end of this message is
>> enough to fix the problem?
>>     
> Both the revert of the original change and the patch here solved the
> problem also for me (on .36-rc3).
>
> Thanks, Jan
>
>   
>> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
>> index 030b1c4..6a43129 100644
>> --- a/drivers/ata/libata-sff.c
>> +++ b/drivers/ata/libata-sff.c
>> @@ -418,6 +418,7 @@ void ata_sff_tf_load(struct ata_port *ap, const struct 
>> ata_taskfile *tf)
>>  		if (ioaddr->ctl_addr)
>>  			iowrite8(tf->ctl, ioaddr->ctl_addr);
>>  		ap->last_ctl = tf->ctl;
>> +		ap->ops->sff_check_status(ap);
>>  	}
>>
>>  	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
>> @@ -453,6 +454,7 @@ void ata_sff_tf_load(struct ata_port *ap, const struct 
>> ata_taskfile *tf)
>>  		iowrite8(tf->device, ioaddr->device_addr);
>>  		VPRINTK("device 0x%X\n", tf->device);
>>  	}
>> +	ap->ops->sff_check_status(ap);
>>  }
>>  EXPORT_SYMBOL_GPL(ata_sff_tf_load);
>>     
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   


--------------020106090208000304000504
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.32-21-server (buildd@yellow) (gcc version 4.4.3 (Ubuntu 4.4.3-4ubuntu5) ) #32-Ubuntu SMP Fri Apr 16 09:17:34 UTC 2010 (Ubuntu 2.6.32-21.32-server 2.6.32.11+drm33.2)
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-2.6.32-21-server root=/dev/mapper/zoom--storage--srv0-root ro quiet
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 00000000cff80000 (usable)
[    0.000000]  BIOS-e820: 00000000cff80000 - 00000000cff8e000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000cff8e000 - 00000000cffd0000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000cffd0000 - 00000000d0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] DMI present.
[    0.000000] AMI BIOS detected: BIOS may corrupt low RAM, working around it.
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0x130000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-DFFFF write-protect
[    0.000000]   E0000-EFFFF write-through
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask F00000000 write-back
[    0.000000]   1 base 100000000 mask FE0000000 write-back
[    0.000000]   2 base 120000000 mask FF0000000 write-back
[    0.000000]   3 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   4 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820 update range: 00000000d0000000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0xcff80 max_arch_pfn = 0x400000000
[    0.000000] Scanning 0 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009fc00 (usable)
[    0.000000]  modified: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000e4000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 00000000cff80000 (usable)
[    0.000000]  modified: 00000000cff80000 - 00000000cff8e000 (ACPI data)
[    0.000000]  modified: 00000000cff8e000 - 00000000cffd0000 (ACPI NVS)
[    0.000000]  modified: 00000000cffd0000 - 00000000d0000000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000]  modified: 0000000100000000 - 0000000130000000 (usable)
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] init_memory_mapping: 0000000000000000-00000000cff80000
[    0.000000] NX (Execute Disable) protection: active
[    0.000000]  0000000000 - 00cfe00000 page 2M
[    0.000000]  00cfe00000 - 00cff80000 page 4k
[    0.000000] kernel direct mapping tables up to cff80000 @ 10000-16000
[    0.000000] init_memory_mapping: 0000000100000000-0000000130000000
[    0.000000] NX (Execute Disable) protection: active
[    0.000000]  0100000000 - 0130000000 page 2M
[    0.000000] kernel direct mapping tables up to 130000000 @ 14000-1a000
[    0.000000] RAMDISK: 3750b000 - 37fefb03
[    0.000000] ACPI: RSDP 00000000000fbb10 00024 (v02 ACPIAM)
[    0.000000] ACPI: XSDT 00000000cff80100 0005C (v01 A_M_I_ OEMXSDT  07000930 MSFT 00000097)
[    0.000000] ACPI: FACP 00000000cff80290 000F4 (v03 A_M_I_ OEMFACP  07000930 MSFT 00000097)
[    0.000000] ACPI: DSDT 00000000cff80440 09004 (v01  A1430 A1430001 00000001 INTL 20060113)
[    0.000000] ACPI: FACS 00000000cff8e000 00040
[    0.000000] ACPI: APIC 00000000cff80390 0006C (v01 A_M_I_ OEMAPIC  07000930 MSFT 00000097)
[    0.000000] ACPI: MCFG 00000000cff80400 0003C (v01 A_M_I_ OEMMCFG  07000930 MSFT 00000097)
[    0.000000] ACPI: OEMB 00000000cff8e040 00081 (v01 A_M_I_ AMI_OEM  07000930 MSFT 00000097)
[    0.000000] ACPI: HPET 00000000cff89450 00038 (v01 A_M_I_ OEMHPET  07000930 MSFT 00000097)
[    0.000000] ACPI: OSFR 00000000cff89490 000B0 (v01 A_M_I_ OEMOSFR  07000930 MSFT 00000097)
[    0.000000] ACPI: SSDT 00000000cff8e650 00A7C (v01 DpgPmm    CpuPm 00000012 INTL 20060113)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-0000000130000000
[    0.000000] Bootmem setup node 0 0000000000000000-0000000130000000
[    0.000000]   NODE_DATA [0000000000015000 - 0000000000019fff]
[    0.000000]   bootmap [000000000001a000 -  000000000003ffff] pages 26
[    0.000000] (8 early reservations) ==> bootmem [0000000000 - 0130000000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0001000000 - 0001a46ea4]    TEXT DATA BSS ==> [0001000000 - 0001a46ea4]
[    0.000000]   #3 [003750b000 - 0037fefb03]          RAMDISK ==> [003750b000 - 0037fefb03]
[    0.000000]   #4 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #5 [0001a47000 - 0001a47288]              BRK ==> [0001a47000 - 0001a47288]
[    0.000000]   #6 [0000010000 - 0000014000]          PGTABLE ==> [0000010000 - 0000014000]
[    0.000000]   #7 [0000014000 - 0000015000]          PGTABLE ==> [0000014000 - 0000015000]
[    0.000000] found SMP MP-table at [ffff8800000ff780] ff780
[    0.000000]  [ffffea0000000000-ffffea00043fffff] PMD -> [ffff880001c00000-ffff8800055fffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00130000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x000cff80
[    0.000000]     0: 0x00100000 -> 0x00130000
[    0.000000] On node 0 totalpages: 1048335
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 104 pages reserved
[    0.000000]   DMA zone: 3823 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 833464 pages, LIFO batch:31
[    0.000000]   Normal zone: 2688 pages used for memmap
[    0.000000]   Normal zone: 193920 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a301 base: 0xfed00000
[    0.000000] SMP: Allowing 4 CPUs, 2 hotplug CPUs
[    0.000000] nr_irqs_gsi: 24
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e4000
[    0.000000] PM: Registered nosave memory: 00000000000e4000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 00000000cff80000 - 00000000cff8e000
[    0.000000] PM: Registered nosave memory: 00000000cff8e000 - 00000000cffd0000
[    0.000000] PM: Registered nosave memory: 00000000cffd0000 - 00000000d0000000
[    0.000000] PM: Registered nosave memory: 00000000d0000000 - 00000000fee00000
[    0.000000] PM: Registered nosave memory: 00000000fee00000 - 00000000fee01000
[    0.000000] PM: Registered nosave memory: 00000000fee01000 - 00000000fff00000
[    0.000000] PM: Registered nosave memory: 00000000fff00000 - 0000000100000000
[    0.000000] Allocating PCI resources starting at d0000000 (gap: d0000000:2ee00000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 30 pages/cpu @ffff880005800000 s91544 r8192 d23144 u524288
[    0.000000] pcpu-alloc: s91544 r8192 d23144 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1031207
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-2.6.32-21-server root=/dev/mapper/zoom--storage--srv0-root ro quiet
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Initializing CPU#0
[    0.000000] xsave/xrstor: enabled xstate_bv 0x3, cntxt size 0x240
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.000000] Placing 64MB software IO TLB between ffff88000599e000 - ffff88000999e000
[    0.000000] software IO TLB at phys 0x599e000 - 0x999e000
[    0.000000] Memory: 4045416k/4980736k available (5499k kernel code, 787396k absent, 147924k reserved, 3081k data, 796k init)
[    0.000000] SLUB: Genslabs=14, HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:4352 nr_irqs:440
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] allocated 41943040 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] HPET: 4 timers in total, 0 timers will be used for per-cpu timer
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 3329.572 MHz processor.
[    0.000006] Calibrating delay loop (skipped), value calculated using timer frequency.. 6659.14 BogoMIPS (lpj=33295720)
[    0.000028] Security Framework initialized
[    0.000044] AppArmor: AppArmor initialized
[    0.000292] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.011706] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.012532] Mount-cache hash table entries: 256
[    0.012646] Initializing cgroup subsys ns
[    0.012650] Initializing cgroup subsys cpuacct
[    0.012653] Initializing cgroup subsys memory
[    0.012659] Initializing cgroup subsys devices
[    0.012661] Initializing cgroup subsys freezer
[    0.012662] Initializing cgroup subsys net_cls
[    0.012678] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.012680] CPU: L2 cache: 6144K
[    0.012683] CPU 0/0x0 -> Node 0
[    0.012685] CPU: Physical Processor ID: 0
[    0.012686] CPU: Processor Core ID: 0
[    0.012688] mce: CPU supports 6 MCE banks
[    0.012694] CPU0: Thermal monitoring enabled (TM2)
[    0.012697] using mwait in idle threads.
[    0.012699] Performance Events: Core2 events, Intel PMU driver.
[    0.012703] ... version:                2
[    0.012704] ... bit width:              40
[    0.012705] ... generic registers:      2
[    0.012706] ... value mask:             000000ffffffffff
[    0.012707] ... max period:             000000007fffffff
[    0.012708] ... fixed-purpose events:   3
[    0.012709] ... event mask:             0000000700000003
[    0.015001] ACPI: Core revision 20090903
[    0.025710] ftrace: converting mcount calls to 0f 1f 44 00 00
[    0.025714] ftrace: allocating 22808 entries in 90 pages
[    0.030038] Setting APIC routing to flat
[    0.030330] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.132701] CPU0: Intel(R) Core(TM)2 Duo CPU     E8600  @ 3.33GHz stepping 0a
[    0.140000] Booting processor 1 APIC 0x1 ip 0x6000
[    0.010000] Initializing CPU#1
[    0.010000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.010000] CPU: L2 cache: 6144K
[    0.010000] CPU 1/0x1 -> Node 0
[    0.010000] CPU: Physical Processor ID: 0
[    0.010000] CPU: Processor Core ID: 1
[    0.010000] CPU1: Thermal monitoring enabled (TM2)
[    0.290054] CPU1: Intel(R) Core(TM)2 Duo CPU     E8600  @ 3.33GHz stepping 0a
[    0.290058] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.300014] Brought up 2 CPUs
[    0.300016] Total of 2 processors activated (13319.08 BogoMIPS).
[    0.300721] CPU0 attaching sched-domain:
[    0.300724]  domain 0: span 0-1 level MC
[    0.300725]   groups: 0 1
[    0.300730] CPU1 attaching sched-domain:
[    0.300731]  domain 0: span 0-1 level MC
[    0.300733]   groups: 1 0
[    0.300809] devtmpfs: initialized
[    0.301777] regulator: core version 0.5
[    0.301777] Time:  5:39:41  Date: 08/15/10
[    0.301777] NET: Registered protocol family 16
[    0.301777] ACPI: bus type pci registered
[    0.301777] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.301777] PCI: Not using MMCONFIG.
[    0.301777] PCI: Using configuration type 1 for base access
[    0.301777] Trying to unpack rootfs image as initramfs...
[    0.310043] bio: create slab <bio-0> at 0
[    0.310610] ACPI: EC: Look up EC in DSDT
[    0.312351] ACPI: Executed 1 blocks of module-level executable AML code
[    0.320434] ACPI: Interpreter enabled
[    0.320437] ACPI: (supports S0 S1 S3 S4 S5)
[    0.320454] ACPI: Using IOAPIC for interrupt routing
[    0.320493] PCI: MCFG configuration 0: base e0000000 segment 0 buses 0 - 255
[    0.322320] PCI: MCFG area at e0000000 reserved in ACPI motherboard resources
[    0.326929] PCI: Using MMCONFIG at e0000000 - efffffff
[    0.332378] ACPI Warning: Incorrect checksum in table [OEMB] - B2, should be B1 (20090903/tbutils-314)
[    0.332478] ACPI: No dock devices found.
[    0.332565] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.332636] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.332638] pci 0000:00:01.0: PME# disabled
[    0.332692] pci 0000:00:1a.0: reg 20 io port: [0xb800-0xb81f]
[    0.332747] pci 0000:00:1a.1: reg 20 io port: [0xb880-0xb89f]
[    0.332800] pci 0000:00:1a.2: reg 20 io port: [0xbc00-0xbc1f]
[    0.332858] pci 0000:00:1a.7: reg 10 32bit mmio: [0xf9fffc00-0xf9ffffff]
[    0.332901] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.332904] pci 0000:00:1a.7: PME# disabled
[    0.332935] pci 0000:00:1b.0: reg 10 64bit mmio: [0xf9ff8000-0xf9ffbfff]
[    0.332968] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.332970] pci 0000:00:1b.0: PME# disabled
[    0.333017] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.333020] pci 0000:00:1c.0: PME# disabled
[    0.333071] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.333074] pci 0000:00:1c.4: PME# disabled
[    0.333123] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    0.333126] pci 0000:00:1c.5: PME# disabled
[    0.333168] pci 0000:00:1d.0: reg 20 io port: [0xb080-0xb09f]
[    0.333221] pci 0000:00:1d.1: reg 20 io port: [0xb400-0xb41f]
[    0.333277] pci 0000:00:1d.2: reg 20 io port: [0xb480-0xb49f]
[    0.333334] pci 0000:00:1d.7: reg 10 32bit mmio: [0xf9fff800-0xf9fffbff]
[    0.333377] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.333380] pci 0000:00:1d.7: PME# disabled
[    0.333517] pci 0000:00:1f.2: reg 10 io port: [0xa000-0xa007]
[    0.333521] pci 0000:00:1f.2: reg 14 io port: [0x9c00-0x9c03]
[    0.333525] pci 0000:00:1f.2: reg 18 io port: [0x9880-0x9887]
[    0.333529] pci 0000:00:1f.2: reg 1c io port: [0x9800-0x9803]
[    0.333533] pci 0000:00:1f.2: reg 20 io port: [0x9480-0x948f]
[    0.333537] pci 0000:00:1f.2: reg 24 io port: [0x9400-0x940f]
[    0.333572] pci 0000:00:1f.3: reg 10 64bit mmio: [0xf9fff400-0xf9fff4ff]
[    0.333581] pci 0000:00:1f.3: reg 20 io port: [0x400-0x41f]
[    0.333617] pci 0000:00:1f.5: reg 10 io port: [0xb000-0xb007]
[    0.333621] pci 0000:00:1f.5: reg 14 io port: [0xac00-0xac03]
[    0.333625] pci 0000:00:1f.5: reg 18 io port: [0xa880-0xa887]
[    0.333629] pci 0000:00:1f.5: reg 1c io port: [0xa800-0xa803]
[    0.333633] pci 0000:00:1f.5: reg 20 io port: [0xa480-0xa48f]
[    0.333637] pci 0000:00:1f.5: reg 24 io port: [0xa400-0xa40f]
[    0.333681] pci 0000:01:00.0: reg 10 32bit mmio: [0xfd000000-0xfdffffff]
[    0.333687] pci 0000:01:00.0: reg 14 64bit mmio pref: [0xd0000000-0xdfffffff]
[    0.333694] pci 0000:01:00.0: reg 1c 64bit mmio: [0xfa000000-0xfbffffff]
[    0.333698] pci 0000:01:00.0: reg 24 io port: [0xcc00-0xcc7f]
[    0.333702] pci 0000:01:00.0: reg 30 32bit mmio pref: [0xfe9e0000-0xfe9fffff]
[    0.333748] pci 0000:00:01.0: bridge io port: [0xc000-0xcfff]
[    0.333750] pci 0000:00:01.0: bridge 32bit mmio: [0xfa000000-0xfe9fffff]
[    0.333754] pci 0000:00:01.0: bridge 64bit mmio pref: [0xd0000000-0xdfffffff]
[    0.333789] pci 0000:00:1c.0: bridge 64bit mmio pref: [0xf8f00000-0xf8ffffff]
[    0.333836] pci 0000:03:00.0: reg 10 io port: [0xec00-0xec07]
[    0.333844] pci 0000:03:00.0: reg 14 io port: [0xe880-0xe883]
[    0.333851] pci 0000:03:00.0: reg 18 io port: [0xe800-0xe807]
[    0.333859] pci 0000:03:00.0: reg 1c io port: [0xe480-0xe483]
[    0.333866] pci 0000:03:00.0: reg 20 io port: [0xe400-0xe40f]
[    0.333879] pci 0000:03:00.0: reg 30 32bit mmio pref: [0xfebf0000-0xfebfffff]
[    0.333953] pci 0000:00:1c.4: bridge io port: [0xe000-0xefff]
[    0.333956] pci 0000:00:1c.4: bridge 32bit mmio: [0xfeb00000-0xfebfffff]
[    0.334003] pci 0000:02:00.0: reg 10 64bit mmio: [0xfeac0000-0xfeafffff]
[    0.334009] pci 0000:02:00.0: reg 18 io port: [0xdc00-0xdc7f]
[    0.334061] pci 0000:02:00.0: PME# supported from D3hot D3cold
[    0.334065] pci 0000:02:00.0: PME# disabled
[    0.334106] pci 0000:00:1c.5: bridge io port: [0xd000-0xdfff]
[    0.334108] pci 0000:00:1c.5: bridge 32bit mmio: [0xfea00000-0xfeafffff]
[    0.334153] pci 0000:00:1e.0: transparent bridge
[    0.334175] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.334262] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
[    0.334300] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
[    0.334371] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P8._PRT]
[    0.334411] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    0.334463] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
[    0.345823] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[    0.345902] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.345980] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 *15)
[    0.346060] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.346136] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.346213] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 *14 15)
[    0.346289] ACPI: PCI Interrupt Link [LNKG] (IRQs *3 4 5 6 7 10 11 12 14 15)
[    0.346365] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    0.346451] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.346453] vgaarb: loaded
[    0.346533] SCSI subsystem initialized
[    0.346600] libata version 3.00 loaded.
[    0.346651] usbcore: registered new interface driver usbfs
[    0.346658] usbcore: registered new interface driver hub
[    0.346676] usbcore: registered new device driver usb
[    0.346761] ACPI: WMI: Mapper loaded
[    0.346762] PCI: Using ACPI for IRQ routing
[    0.346883] NetLabel: Initializing
[    0.346884] NetLabel:  domain hash size = 128
[    0.346885] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.346894] NetLabel:  unlabeled traffic allowed by default
[    0.346916] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0
[    0.346919] hpet0: 4 comparators, 64-bit 14.318180 MHz counter
[    0.350173] Switching to clocksource tsc
[    0.351377] AppArmor: AppArmor Filesystem Enabled
[    0.351384] pnp: PnP ACPI init
[    0.351392] ACPI: bus type pnp registered
[    0.353481] pnp: PnP ACPI: found 15 devices
[    0.353482] ACPI: ACPI bus type pnp unregistered
[    0.353489] system 00:01: iomem range 0xfed14000-0xfed19fff has been reserved
[    0.353494] system 00:06: ioport range 0x290-0x29f has been reserved
[    0.353497] system 00:07: ioport range 0x4d0-0x4d1 has been reserved
[    0.353499] system 00:07: ioport range 0x800-0x87f has been reserved
[    0.353500] system 00:07: ioport range 0x500-0x57f has been reserved
[    0.353502] system 00:07: iomem range 0xfed08000-0xfed08fff has been reserved
[    0.353504] system 00:07: iomem range 0xfed1c000-0xfed1ffff has been reserved
[    0.353506] system 00:07: iomem range 0xfed20000-0xfed3ffff has been reserved
[    0.353507] system 00:07: iomem range 0xfed50000-0xfed8ffff has been reserved
[    0.353511] system 00:0a: iomem range 0xffc00000-0xffefffff has been reserved
[    0.353514] system 00:0b: iomem range 0xfec00000-0xfec00fff could not be reserved
[    0.353516] system 00:0b: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.353519] system 00:0d: iomem range 0xe0000000-0xefffffff has been reserved
[    0.353523] system 00:0e: iomem range 0x0-0x9ffff could not be reserved
[    0.353524] system 00:0e: iomem range 0xc0000-0xcffff has been reserved
[    0.353528] system 00:0e: iomem range 0xe0000-0xfffff could not be reserved
[    0.353530] system 00:0e: iomem range 0x100000-0xcfffffff could not be reserved
[    0.358181] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.358183] pci 0000:00:01.0:   IO window: 0xc000-0xcfff
[    0.358186] pci 0000:00:01.0:   MEM window: 0xfa000000-0xfe9fffff
[    0.358188] pci 0000:00:01.0:   PREFETCH window: 0x000000d0000000-0x000000dfffffff
[    0.358191] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:04
[    0.358193] pci 0000:00:1c.0:   IO window: 0x1000-0x1fff
[    0.358196] pci 0000:00:1c.0:   MEM window: 0xf0000000-0xf03fffff
[    0.358199] pci 0000:00:1c.0:   PREFETCH window: 0x000000f8f00000-0x000000f8ffffff
[    0.358203] pci 0000:00:1c.4: PCI bridge, secondary bus 0000:03
[    0.358205] pci 0000:00:1c.4:   IO window: 0xe000-0xefff
[    0.358208] pci 0000:00:1c.4:   MEM window: 0xfeb00000-0xfebfffff
[    0.358211] pci 0000:00:1c.4:   PREFETCH window: 0x000000f0400000-0x000000f05fffff
[    0.358215] pci 0000:00:1c.5: PCI bridge, secondary bus 0000:02
[    0.358217] pci 0000:00:1c.5:   IO window: 0xd000-0xdfff
[    0.358221] pci 0000:00:1c.5:   MEM window: 0xfea00000-0xfeafffff
[    0.358223] pci 0000:00:1c.5:   PREFETCH window: 0x000000f0600000-0x000000f07fffff
[    0.358228] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:05
[    0.358229] pci 0000:00:1e.0:   IO window: disabled
[    0.358232] pci 0000:00:1e.0:   MEM window: disabled
[    0.358234] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.358243]   alloc irq_desc for 16 on node -1
[    0.358244]   alloc kstat_irqs on node -1
[    0.358248] pci 0000:00:01.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.358251] pci 0000:00:01.0: setting latency timer to 64
[    0.358256] pci 0000:00:1c.0: enabling device (0106 -> 0107)
[    0.358258]   alloc irq_desc for 17 on node -1
[    0.358259]   alloc kstat_irqs on node -1
[    0.358261] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.358264] pci 0000:00:1c.0: setting latency timer to 64
[    0.358269] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.358272] pci 0000:00:1c.4: setting latency timer to 64
[    0.358277] pci 0000:00:1c.5: PCI INT B -> GSI 16 (level, low) -> IRQ 16
[    0.358280] pci 0000:00:1c.5: setting latency timer to 64
[    0.358284] pci 0000:00:1e.0: setting latency timer to 64
[    0.358288] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.358290] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffffffffffff]
[    0.358291] pci_bus 0000:01: resource 0 io:  [0xc000-0xcfff]
[    0.358293] pci_bus 0000:01: resource 1 mem: [0xfa000000-0xfe9fffff]
[    0.358294] pci_bus 0000:01: resource 2 pref mem [0xd0000000-0xdfffffff]
[    0.358296] pci_bus 0000:04: resource 0 io:  [0x1000-0x1fff]
[    0.358297] pci_bus 0000:04: resource 1 mem: [0xf0000000-0xf03fffff]
[    0.358299] pci_bus 0000:04: resource 2 pref mem [0xf8f00000-0xf8ffffff]
[    0.358300] pci_bus 0000:03: resource 0 io:  [0xe000-0xefff]
[    0.358302] pci_bus 0000:03: resource 1 mem: [0xfeb00000-0xfebfffff]
[    0.358303] pci_bus 0000:03: resource 2 pref mem [0xf0400000-0xf05fffff]
[    0.358304] pci_bus 0000:02: resource 0 io:  [0xd000-0xdfff]
[    0.358306] pci_bus 0000:02: resource 1 mem: [0xfea00000-0xfeafffff]
[    0.358307] pci_bus 0000:02: resource 2 pref mem [0xf0600000-0xf07fffff]
[    0.358309] pci_bus 0000:05: resource 3 io:  [0x00-0xffff]
[    0.358310] pci_bus 0000:05: resource 4 mem: [0x000000-0xffffffffffffffff]
[    0.358333] NET: Registered protocol family 2
[    0.358448] IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.359275] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.362760] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.363203] TCP: Hash tables configured (established 524288 bind 65536)
[    0.363204] TCP reno registered
[    0.363309] NET: Registered protocol family 1
[    0.363450] pci 0000:01:00.0: Boot video device
[    0.363625] Scanning for low memory corruption every 60 seconds
[    0.363722] audit: initializing netlink socket (disabled)
[    0.363731] type=2000 audit(1281850780.359:1): initialized
[    0.369844] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.370749] VFS: Disk quotas dquot_6.5.2
[    0.370783] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.371158] fuse init (API version 7.13)
[    0.371212] msgmni has been set to 7901
[    0.371348] alg: No test for stdrng (krng)
[    0.371386] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.371389] io scheduler noop registered
[    0.371390] io scheduler anticipatory registered
[    0.371391] io scheduler deadline registered (default)
[    0.371417] io scheduler cfq registered
[    0.371509]   alloc irq_desc for 24 on node -1
[    0.371510]   alloc kstat_irqs on node -1
[    0.371516] pcieport 0000:00:01.0: irq 24 for MSI/MSI-X
[    0.371520] pcieport 0000:00:01.0: setting latency timer to 64
[    0.371590]   alloc irq_desc for 25 on node -1
[    0.371591]   alloc kstat_irqs on node -1
[    0.371596] pcieport 0000:00:1c.0: irq 25 for MSI/MSI-X
[    0.371602] pcieport 0000:00:1c.0: setting latency timer to 64
[    0.371685]   alloc irq_desc for 26 on node -1
[    0.371686]   alloc kstat_irqs on node -1
[    0.371691] pcieport 0000:00:1c.4: irq 26 for MSI/MSI-X
[    0.371697] pcieport 0000:00:1c.4: setting latency timer to 64
[    0.371774]   alloc irq_desc for 27 on node -1
[    0.371775]   alloc kstat_irqs on node -1
[    0.371779] pcieport 0000:00:1c.5: irq 27 for MSI/MSI-X
[    0.371785] pcieport 0000:00:1c.5: setting latency timer to 64
[    0.371843] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.371915] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.371999] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    0.372002] ACPI: Power Button [PWRB]
[    0.372032] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.372033] ACPI: Power Button [PWRF]
[    0.372573] ACPI: SSDT 00000000cff8e0d0 002B9 (v01 DpgPmm  P001Ist 00000011 INTL 20060113)
[    0.372950] processor LNXCPU:00: registered as cooling_device0
[    0.373265] ACPI: SSDT 00000000cff8e390 002B9 (v01 DpgPmm  P002Ist 00000012 INTL 20060113)
[    0.373635] processor LNXCPU:01: registered as cooling_device1
[    0.376196] Linux agpgart interface v0.103
[    0.376220] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.376302] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.376549] 00:0c: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.377209] brd: module loaded
[    0.377508] loop: module loaded
[    0.377562] input: Macintosh mouse button emulation as /devices/virtual/input/input2
[    0.377633] ata_piix 0000:00:1f.2: version 2.13
[    0.377644]   alloc irq_desc for 19 on node -1
[    0.377645]   alloc kstat_irqs on node -1
[    0.377649] ata_piix 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.377653] ata_piix 0000:00:1f.2: MAP [ P0 P2 P1 P3 ]
[    0.377682] ata_piix 0000:00:1f.2: setting latency timer to 64
[    0.377734] scsi0 : ata_piix
[    0.377778] scsi1 : ata_piix
[    0.378590] ata1: SATA max UDMA/133 cmd 0xa000 ctl 0x9c00 bmdma 0x9480 irq 19
[    0.378594] ata2: SATA max UDMA/133 cmd 0x9880 ctl 0x9800 bmdma 0x9488 irq 19
[    0.378609] ata_piix 0000:00:1f.5: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.378612] ata_piix 0000:00:1f.5: MAP [ P0 -- P1 -- ]
[    0.378635] ata_piix 0000:00:1f.5: setting latency timer to 64
[    0.378657] scsi2 : ata_piix
[    0.378688] scsi3 : ata_piix
[    0.379466] ata3: SATA max UDMA/133 cmd 0xb000 ctl 0xac00 bmdma 0xa480 irq 19
[    0.379469] ata4: SATA max UDMA/133 cmd 0xa880 ctl 0xa800 bmdma 0xa488 irq 19
[    0.379506] pata_acpi 0000:03:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.379526] pata_acpi 0000:03:00.0: setting latency timer to 64
[    0.379536] pata_acpi 0000:03:00.0: PCI INT A disabled
[    0.379740] Fixed MDIO Bus: probed
[    0.379760] PPP generic driver version 2.4.2
[    0.379782] tun: Universal TUN/TAP device driver, 1.6
[    0.379783] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.379838] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.379852]   alloc irq_desc for 18 on node -1
[    0.379853]   alloc kstat_irqs on node -1
[    0.379856] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.379866] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    0.379869] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    0.379890] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 1
[    0.379914] ehci_hcd 0000:00:1a.7: debug port 1
[    0.383795] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    0.383805] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xf9fffc00
[    0.399740] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00
[    0.399825] usb usb1: configuration #1 chosen from 1 choice
[    0.399846] hub 1-0:1.0: USB hub found
[    0.399852] hub 1-0:1.0: 6 ports detected
[    0.399904]   alloc irq_desc for 23 on node -1
[    0.399905]   alloc kstat_irqs on node -1
[    0.399911] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.399929] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    0.399932] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    0.399957] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
[    0.399978] ehci_hcd 0000:00:1d.7: debug port 1
[    0.403846] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    0.403859] ehci_hcd 0000:00:1d.7: irq 23, io mem 0xf9fff800
[    0.419732] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00
[    0.419815] usb usb2: configuration #1 chosen from 1 choice
[    0.419839] hub 2-0:1.0: USB hub found
[    0.419846] hub 2-0:1.0: 6 ports detected
[    0.419895] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.419911] uhci_hcd: USB Universal Host Controller Interface driver
[    0.419949] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.419956] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    0.419959] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    0.419983] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    0.420013] uhci_hcd 0000:00:1a.0: irq 16, io base 0x0000b800
[    0.420069] usb usb3: configuration #1 chosen from 1 choice
[    0.420084] hub 3-0:1.0: USB hub found
[    0.420088] hub 3-0:1.0: 2 ports detected
[    0.420119]   alloc irq_desc for 21 on node -1
[    0.420121]   alloc kstat_irqs on node -1
[    0.420125] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 21 (level, low) -> IRQ 21
[    0.420130] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    0.420132] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    0.420153] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 4
[    0.420176] uhci_hcd 0000:00:1a.1: irq 21, io base 0x0000b880
[    0.420234] usb usb4: configuration #1 chosen from 1 choice
[    0.420250] hub 4-0:1.0: USB hub found
[    0.420254] hub 4-0:1.0: 2 ports detected
[    0.420282] uhci_hcd 0000:00:1a.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.420286] uhci_hcd 0000:00:1a.2: setting latency timer to 64
[    0.420288] uhci_hcd 0000:00:1a.2: UHCI Host Controller
[    0.420307] uhci_hcd 0000:00:1a.2: new USB bus registered, assigned bus number 5
[    0.420326] uhci_hcd 0000:00:1a.2: irq 18, io base 0x0000bc00
[    0.420384] usb usb5: configuration #1 chosen from 1 choice
[    0.420398] hub 5-0:1.0: USB hub found
[    0.420402] hub 5-0:1.0: 2 ports detected
[    0.420431] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    0.420435] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    0.420437] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    0.420465] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 6
[    0.420483] uhci_hcd 0000:00:1d.0: irq 23, io base 0x0000b080
[    0.420538] usb usb6: configuration #1 chosen from 1 choice
[    0.420553] hub 6-0:1.0: USB hub found
[    0.420556] hub 6-0:1.0: 2 ports detected
[    0.420585] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    0.420588] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    0.420590] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    0.420615] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 7
[    0.420633] uhci_hcd 0000:00:1d.1: irq 19, io base 0x0000b400
[    0.420684] usb usb7: configuration #1 chosen from 1 choice
[    0.420699] hub 7-0:1.0: USB hub found
[    0.420705] hub 7-0:1.0: 2 ports detected
[    0.420737] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    0.420741] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    0.420743] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    0.420760] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 8
[    0.420778] uhci_hcd 0000:00:1d.2: irq 18, io base 0x0000b480
[    0.420831] usb usb8: configuration #1 chosen from 1 choice
[    0.420846] hub 8-0:1.0: USB hub found
[    0.420849] hub 8-0:1.0: 2 ports detected
[    0.420914] PNP: No PS/2 controller found. Probing ports directly.
[    0.423440] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.423445] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.423496] mice: PS/2 mouse device common for all mice
[    0.423562] rtc_cmos 00:03: RTC can wake from S4
[    0.423594] rtc_cmos 00:03: rtc core: registered rtc_cmos as rtc0
[    0.423614] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.423691] device-mapper: uevent: version 1.0.3
[    0.423785] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[    0.423827] device-mapper: multipath: version 1.1.0 loaded
[    0.423829] device-mapper: multipath round-robin: version 1.0.0 loaded
[    0.423918] cpuidle: using governor ladder
[    0.423920] cpuidle: using governor menu
[    0.424166] TCP cubic registered
[    0.424240] NET: Registered protocol family 10
[    0.424539] lo: Disabled Privacy Extensions
[    0.424709] NET: Registered protocol family 17
[    0.425352] PM: Resume from disk failed.
[    0.425361] registered taskstats version 1
[    0.425667]   Magic number: 6:798:668
[    0.425746] rtc_cmos 00:03: setting system clock to 2010-08-15 05:39:41 UTC (1281850781)
[    0.425748] BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
[    0.425749] EDD information not available.
[    0.463247] Freeing initrd memory: 11154k freed
[    0.740224] ata3: SATA link down (SStatus 0 SControl 300)
[    0.750832] ata4: SATA link down (SStatus 0 SControl 300)
[    1.090627] ata2.00: SATA link down (SStatus 0 SControl 300)
[    1.090637] ata2.01: SATA link down (SStatus 0 SControl 300)
[    1.110625] ata1.00: SATA link down (SStatus 0 SControl 300)
[    1.110635] ata1.01: SATA link down (SStatus 0 SControl 300)
[    1.110669] Freeing unused kernel memory: 796k freed
[    1.110909] Write protecting the kernel read-only data: 7788k
[    1.120615] udev: starting version 151
[    1.165709] [drm] Initialized drm 1.1.0 20060810
[    1.166685] pata_jmicron 0000:03:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.166714] pata_jmicron 0000:03:00.0: setting latency timer to 64
[    1.168039] scsi4 : pata_jmicron
[    1.168086] scsi5 : pata_jmicron
[    1.168637] ata5: PATA max UDMA/100 cmd 0xec00 ctl 0xe880 bmdma 0xe400 irq 16
[    1.168639] ata6: PATA max UDMA/100 cmd 0xe800 ctl 0xe480 bmdma 0xe408 irq 16
[    1.169994] ATL1E 0000:02:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    1.170004] ATL1E 0000:02:00.0: setting latency timer to 64
[    1.340675] ata5.01: ATA-5: MAXTOR 6L040J2, A93.0300, max UDMA/133
[    1.340678] ata5.01: 78177792 sectors, multi 0: LBA 
[    1.380679] ata5.01: configured for UDMA/100
[    1.380771] scsi 4:0:1:0: Direct-Access     ATA      MAXTOR 6L040J2   A93. PQ: 0 ANSI: 5
[    1.380913] sd 4:0:1:0: [sda] 78177792 512-byte logical blocks: (40.0 GB/37.2 GiB)
[    1.380918] sd 4:0:1:0: Attached scsi generic sg0 type 0
[    1.380974] sd 4:0:1:0: [sda] Write Protect is off
[    1.380976] sd 4:0:1:0: [sda] Mode Sense: 00 3a 00 00
[    1.380992] sd 4:0:1:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.381079]  sda: sda1 sda2 < sda5 >
[    1.396057] sd 4:0:1:0: [sda] Attached SCSI disk
[    1.553378] nouveau 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    1.553383] nouveau 0000:01:00.0: setting latency timer to 64
[    1.554919] [drm] nouveau 0000:01:00.0: Detected an NV50 generation card (0x298200a2)
[    1.555529] [drm] nouveau 0000:01:00.0: Attempting to load BIOS image from PRAMIN
[    1.601954] [drm] nouveau 0000:01:00.0: ... appears to be valid
[    1.601957] [drm] nouveau 0000:01:00.0: BIT BIOS found
[    1.601958] [drm] nouveau 0000:01:00.0: Bios version 62.98.29.00
[    1.601961] [drm] nouveau 0000:01:00.0: TMDS table revision 2.0 not currently supported
[    1.601962] [drm] nouveau 0000:01:00.0: Found Display Configuration Block version 4.0
[    1.601964] [drm] nouveau 0000:01:00.0: DCB connector table: VHER 0x40 5 16 4
[    1.601966] [drm] nouveau 0000:01:00.0:   0: 0x00001030: type 0x30 idx 0 tag 0x07
[    1.601968] [drm] nouveau 0000:01:00.0:   1: 0x00000100: type 0x00 idx 1 tag 0xff
[    1.601969] [drm] nouveau 0000:01:00.0: Raw DCB entry 0: 02000300 00000028
[    1.601971] [drm] nouveau 0000:01:00.0: Raw DCB entry 1: 01000302 00000030
[    1.601972] [drm] nouveau 0000:01:00.0: Raw DCB entry 2: 04011310 00000028
[    1.601978] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 0 at offset 0xD40E
[    1.700113] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 1 at offset 0xD785
[    1.760007] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 2 at offset 0xE02B
[    1.760014] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 3 at offset 0xE11D
[    1.790080] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table 4 at offset 0xE2F9
[    1.790083] [drm] nouveau 0000:01:00.0: Parsing VBIOS init table at offset 0xE35E
[    1.810010] [drm] nouveau 0000:01:00.0: 0xE35E: Condition still not met after 20ms, skipping following opcodes
[    1.810017] [drm] nouveau 0000:01:00.0: 0xC3D8: parsing output script 0
[    1.880149] [TTM] Zone  kernel: Available graphics memory: 2028684 kiB.
[    1.880159] [drm] nouveau 0000:01:00.0: 512 MiB VRAM
[    1.893518] [drm] nouveau 0000:01:00.0: 512 MiB GART (aperture)
[    1.893524] mtrr: type mismatch for d0000000,10000000 old: write-back new: write-combining
[    1.893660] [drm] nouveau 0000:01:00.0: Allocating FIFO number 1
[    1.896408] [drm] nouveau 0000:01:00.0: nouveau_channel_alloc: initialised FIFO 1
[    1.896856] [drm] nouveau 0000:01:00.0: Detected a DAC output
[    1.896860] [drm] nouveau 0000:01:00.0: Detected a TMDS output
[    1.896861] [drm] nouveau 0000:01:00.0: Detected a DAC output
[    1.896863] [drm] nouveau 0000:01:00.0: Detected a DVI-I connector
[    1.896896] [drm] nouveau 0000:01:00.0: Detected a VGA connector
[    2.068650] [drm] nouveau 0000:01:00.0: allocated 1680x1050 fb: 0x40250000, bo ffff880126870600
[    2.068695] fb0: nouveaufb frame buffer device
[    2.068697] registered panic notifier
[    2.068701] [drm] Initialized nouveau 0.0.15 20090420 for 0000:01:00.0 on minor 0
[    2.069703] vga16fb: initializing
[    2.069705] vga16fb: mapped to 0xffff8800000a0000
[    2.069707] vga16fb: not registering due to another framebuffer present
[    2.074497] Console: switching to colour frame buffer device 210x65
[    2.076442] [drm] nouveau 0000:01:00.0: 0xC3F6: parsing output script 1
[    2.076465] [drm] nouveau 0000:01:00.0: 0xC3F7: parsing output script 2
[    2.076478] [drm] nouveau 0000:01:00.0: 0xC0ED: parsing clock script 0
[    2.076766] [drm] nouveau 0000:01:00.0: 0xBA22: parsing clock script 1
[    7.560217] EXT4-fs (dm-0): mounted filesystem with ordered data mode
[   10.086971] udev: starting version 151
[   12.882714] lp: driver loaded but no devices found
[   13.560962]   alloc irq_desc for 22 on node -1
[   13.560964]   alloc kstat_irqs on node -1
[   13.560969] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   13.561013] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   13.688651] type=1505 audit(1281850794.754:2):  operation="profile_load" pid=657 name="/sbin/dhclient3"
[   13.688713] type=1505 audit(1281850794.754:3):  operation="profile_load" pid=657 name="/usr/lib/NetworkManager/nm-dhcp-client.action"
[   13.688754] type=1505 audit(1281850794.754:4):  operation="profile_load" pid=657 name="/usr/lib/connman/scripts/dhclient-script"
[   13.801549] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input3
[   14.504878]   alloc irq_desc for 28 on node -1
[   14.504881]   alloc kstat_irqs on node -1
[   14.504893] ATL1E 0000:02:00.0: irq 28 for MSI/MSI-X
[   14.505029] ATL1E 0000:02:00.0: ATL1E: eth0 NIC Link is Up<100 Mbps Full Duplex>
[   14.505325] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   14.505570] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   15.259457] type=1505 audit(1281850796.324:5):  operation="profile_replace" pid=819 name="/sbin/dhclient3"
[   15.259867] type=1505 audit(1281850796.324:6):  operation="profile_replace" pid=819 name="/usr/lib/NetworkManager/nm-dhcp-client.action"
[   15.260099] type=1505 audit(1281850796.334:7):  operation="profile_replace" pid=819 name="/usr/lib/connman/scripts/dhclient-script"
[   15.358095] type=1505 audit(1281850796.424:8):  operation="profile_load" pid=823 name="/usr/sbin/tcpdump"
[   19.916351] Intel AES-NI instructions are not detected.
[   20.000850] padlock: VIA PadLock not detected.
[   20.078923] padlock: VIA PadLock Hash Engine not detected.
[   21.537397] Adding 1642488k swap on /dev/mapper/cryptswap1.  Priority:-1 extents:1 across:1642488k 
[   25.340029] eth0: no IPv6 routers present

--------------020106090208000304000504--
