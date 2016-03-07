From: Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org
Subject: Re: DMAR error messages after 'shutdown -r'.
Date: Mon, 07 Mar 2016 16:41:57 -0500
Message-ID: <22265.1457386917@turing-police.cc.vt.edu>
References: <38172.1455047940@turing-police.cc.vt.edu>
	<20160216164745.GZ18805@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1457385849_24910"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20160216164745.GZ18805-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1457385849_24910
Content-Type: text/plain

(Sorry for the delay, $DAYJOB took a lot of cycles.  Adding AHCI maintainers to cc:)

On Tue, 16 Feb 2016 17:47:45 +0100, Joerg Roedel said:
> On Tue, Feb 09, 2016 at 02:59:00PM -0500, Valdis Kletnieks wrote:
> > [    0.027629] Freeing SMP alternatives memory: 28K (ffffffff8e111000 - ffffffff8e118000)
> > [    0.048199] ftrace: allocating 31090 entries in 122 pages
> > [    0.061837] DMAR: Host address width 36
> > [    0.061841] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
> > [    0.061894] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c9008020660262 ecap f0105a
> > [    0.061896] DMAR: RMRR base: 0x000000cdb11000 end: 0x000000cdb30fff
> > [    0.061899] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
> > [    0.061901] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
> > [    0.061903] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
> > ---- Error here....
> > [    0.062027] DMAR: DRHD: handling fault status reg 2
> > [    0.062034] DMAR: DMAR:[DMA Read] Request device [00:1f.2] fault addr cdacd000
> >                DMAR:[fault reason 06] PTE Read access is not set
> > ----
>
> This is probably from a missing RMRR entry for device 00:1f.2. Can you
> please post full dmesg after boot?

lspci says:
00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family 6-port SATA Controller [AHCI mode] (rev 04)

Not sure why I only see it on reboots - that means that when powering up, the kernel
gets handed a device config it likes, but when rebooting, something is leaving the
device in a config the kernel doesn't want to see.

Cold and warm boot dmesg's attached.


--==_Exmh_1457385849_24910
Content-Type: text/plain ; name="dmesg.coldboot"
Content-Description: dmesg.coldboot
Content-Disposition: attachment; filename="dmesg.coldboot"

[    0.000000] microcode: microcode updated early to revision 0x1c, date = 2015-02-26
[    0.000000] Linux version 4.5.0-rc4-next-20160216-00001-g5269cc926b02 (source-+bZmOdGhbsPr6rcHtW+onFJE71vCis6O@public.gmane.org) (gcc version 6.0.0 20160205 (Red Hat 6.0.0-0.10) (GCC) ) #166 SMP PREEMPT Tue Feb 16 11:51:56 EST 2016
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.5.0-rc4-next-20160216-00001-g5269cc926b02 root=/dev/mapper/turing--police-root ro rd.md=0 rd.dm=0 rd.lvm.lv=turing-police/00 console.keymap=us vconsole.font=latarcyrheb-sun16 rd.luks.uuid=luks-665bb147-9e39-4003-b3ae-7be925f51a97 rd.lvm.lv=turing-police/swap rd.lvm.lv=turing-police/root quiet LANG=en_US.UTF-8 nouveau.modeset=0 rd.driver.blacklist=nouveau video=vesa:off
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c9f09fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c9f0a000-0x00000000c9ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca000000-0x00000000ca752fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ca753000-0x00000000ca7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca800000-0x00000000cafb1fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cafb2000-0x00000000caffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cb000000-0x00000000cc6fdfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cc6fe000-0x00000000cc7fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cc800000-0x00000000cd99afff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cd99b000-0x00000000ce3a0fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ce3a1000-0x00000000ce3e3fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ce3e4000-0x00000000ceeb2fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ceeb3000-0x00000000cf3effff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cf3f0000-0x00000000cf3fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000022dffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xc735b018-0xc7377e57] usable ==> usable
[    0.000000] e820: update [mem 0xc734b018-0xc735ac57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000c734b017] usable
[    0.000000] reserve setup_data: [mem 0x00000000c734b018-0x00000000c735ac57] usable
[    0.000000] reserve setup_data: [mem 0x00000000c735ac58-0x00000000c735b017] usable
[    0.000000] reserve setup_data: [mem 0x00000000c735b018-0x00000000c7377e57] usable
[    0.000000] reserve setup_data: [mem 0x00000000c7377e58-0x00000000c9f09fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c9f0a000-0x00000000c9ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ca000000-0x00000000ca752fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000ca753000-0x00000000ca7fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ca800000-0x00000000cafb1fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cafb2000-0x00000000caffffff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000cb000000-0x00000000cc6fdfff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cc6fe000-0x00000000cc7fffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000cc800000-0x00000000cd99afff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cd99b000-0x00000000ce3a0fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ce3a1000-0x00000000ce3e3fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000ce3e4000-0x00000000ceeb2fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000ceeb3000-0x00000000cf3effff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000cf3f0000-0x00000000cf3fffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000022dffffff] usable
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0xcaff1000  ACPI 2.0=0xcaff1000  SMBIOS=0xf04c0  MPS=0xfd6d0 
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Dell Inc. Latitude E6530/07Y85M, BIOS A17 08/19/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x22e000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask E00000000 write-back
[    0.000000]   1 base 200000000 mask FE0000000 write-back
[    0.000000]   2 base 220000000 mask FF8000000 write-back
[    0.000000]   3 base 228000000 mask FFC000000 write-back
[    0.000000]   4 base 22C000000 mask FFE000000 write-back
[    0.000000]   5 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   6 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcf400 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fda20-0x000fda2f] mapped at [ffff8800000fda20]
[    0.000000] Base memory trampoline at [ffff880000095000] 95000 size 24576
[    0.000000] BRK [0x1f037000, 0x1f037fff] PGTABLE
[    0.000000] BRK [0x1f038000, 0x1f038fff] PGTABLE
[    0.000000] BRK [0x1f039000, 0x1f039fff] PGTABLE
[    0.000000] BRK [0x1f03a000, 0x1f03afff] PGTABLE
[    0.000000] BRK [0x1f03b000, 0x1f03bfff] PGTABLE
[    0.000000] BRK [0x1f03c000, 0x1f03cfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3f5d1000-0x3fffafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000CAFF1000 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x00000000CAFF1088 000094 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000CAFFB718 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000CAFF11B0 00A563 (v02 DELL   CBX3     00000021 INTL 20091112)
[    0.000000] ACPI: FACS 0x00000000CC7ED080 000040
[    0.000000] ACPI: APIC 0x00000000CAFFB828 000072 (v03 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000CAFFB8A0 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: TCPA 0x00000000CAFFB8E8 000032 (v02 APTIO4 NAPAASF  00000001 MSFT 01000013)
[    0.000000] ACPI: MCFG 0x00000000CAFFB920 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000CAFFB960 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000CAFFB998 000415 (v01 SataRe SataTabl 00001000 INTL 20091112)
[    0.000000] ACPI: SSDT 0x00000000CAFFBDB0 0009B9 (v01 PmRef  Cpu0Ist  00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 0x00000000CAFFC770 000B22 (v01 PmRef  CpuPm    00003000 INTL 20051117)
[    0.000000] ACPI: DMAR 0x00000000CAFFD298 000080 (v01 INTEL  SNB      00000001 INTL 00000001)
[    0.000000] ACPI: ASF! 0x00000000CAFFD318 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: SSDT 0x00000000CAFFD3C0 000579 (v01 AMITCG PROC     00000001 INTL 20051117)
[    0.000000] ACPI: BGRT 0x00000000CAFFD940 000038 (v00 ??              01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000CAFFD978 00198A (v01 NvdRef NvdTabl  00001000 INTL 20091112)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000001000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000022dffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000c9f09fff]
[    0.000000]   node   0: [mem 0x00000000ca000000-0x00000000ca752fff]
[    0.000000]   node   0: [mem 0x00000000ca800000-0x00000000cafb1fff]
[    0.000000]   node   0: [mem 0x00000000cb000000-0x00000000cc6fdfff]
[    0.000000]   node   0: [mem 0x00000000cc800000-0x00000000cd99afff]
[    0.000000]   node   0: [mem 0x00000000ce3e4000-0x00000000ceeb2fff]
[    0.000000]   node   0: [mem 0x00000000cf3f0000-0x00000000cf3fffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000022dffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000022dffffff]
[    0.000000] On node 0 totalpages: 2081061
[    0.000000]   DMA32 zone: 11541 pages used for memmap
[    0.000000]   DMA32 zone: 28 pages reserved
[    0.000000]   DMA32 zone: 844069 pages, LIFO batch:31
[    0.000000]   Normal zone: 16912 pages used for memmap
[    0.000000]   Normal zone: 1236992 pages, LIFO batch:31
[    0.000000] tboot: non-0 tboot_addr but it is not of type E820_RESERVED
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0xcf400000-0xf7ffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88022dc00000 s99400 r8192 d31672 u524288
[    0.000000] pcpu-alloc: s99400 r8192 d31672 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2052580
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.5.0-rc4-next-20160216-00001-g5269cc926b02 root=/dev/mapper/turing--police-root ro rd.md=0 rd.dm=0 rd.lvm.lv=turing-police/00 console.keymap=us vconsole.font=latarcyrheb-sun16 rd.luks.uuid=luks-665bb147-9e39-4003-b3ae-7be925f51a97 rd.lvm.lv=turing-police/swap rd.lvm.lv=turing-police/root quiet LANG=en_US.UTF-8 nouveau.modeset=0 rd.driver.blacklist=nouveau video=vesa:off
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Memory: 7906748K/8324244K available (10069K kernel code, 1814K rwdata, 3672K rodata, 1312K init, 15488K bss, 417496K reserved, 0K cma-reserved)
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:4352 nr_irqs:456 16
[    0.000000] Console: colour dummy device 160x64
[    0.000000] console [tty0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000000] ... CHAINHASH_SIZE:          32768
[    0.000000]  memory used by lock dependency info: 8159 kB
[    0.000000]  per task-struct memory footprint: 1920 bytes
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2691.263 MHz processor
[    0.000076] Calibrating delay loop (skipped), value calculated using timer frequency.. 5382.52 BogoMIPS (lpj=2691263)
[    0.000080] pid_max: default: 32768 minimum: 301
[    0.000091] ACPI: Core revision 20160108
[    0.025082] ACPI: 6 ACPI AML tables successfully acquired and loaded

[    0.025669] Security Framework initialized
[    0.025672] SELinux:  Initializing.
[    0.025711] SELinux:  Starting in permissive mode
[    0.025745] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.025749] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.027299] CPU: Physical Processor ID: 0
[    0.027301] CPU: Processor Core ID: 0
[    0.027305] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.027307] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.027310] mce: CPU supports 7 MCE banks
[    0.027350] process: using mwait in idle threads
[    0.027354] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.027356] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.027898] Freeing SMP alternatives memory: 28K (ffffffff9e10f000 - ffffffff9e116000)
[    0.049329] ftrace: allocating 31130 entries in 122 pages
[    0.062970] DMAR: Host address width 36
[    0.062975] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    0.063029] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.063032] DMAR: RMRR base: 0x000000cdb11000 end: 0x000000cdb30fff
[    0.063035] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
[    0.063037] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
[    0.063039] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.063253] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.063255] x2apic enabled
[    0.063262] Switched APIC routing to cluster x2apic.
[    0.064117] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.074136] TSC deadline timer enabled
[    0.074142] smpboot: CPU0: Intel(R) Core(TM) i5-3340M CPU @ 2.70GHz (family: 0x6, model: 0x3a, stepping: 0x9)
[    0.074155] Performance Events: PEBS fmt1+, 16-deep LBR, IvyBridge events, full-width counters, Intel PMU driver.
[    0.074185] ... version:                3
[    0.074186] ... bit width:              48
[    0.074187] ... generic registers:      4
[    0.074189] ... value mask:             0000ffffffffffff
[    0.074190] ... max period:             0000ffffffffffff
[    0.074191] ... fixed-purpose events:   3
[    0.074193] ... event mask:             000000070000000f
[    0.080590] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.083441] x86: Booting SMP configuration:
[    0.083444] .... node  #0, CPUs:      #1 #2 #3
[    0.096992] x86: Booted up 1 node, 4 CPUs

--==_Exmh_1457385849_24910
Content-Type: text/plain ; name="dmesg.reboot"
Content-Description: dmesg.reboot
Content-Disposition: attachment; filename="dmesg.reboot"

[    0.000000] microcode: microcode updated early to revision 0x1c, date = 2015-02-26
[    0.000000] Linux version 4.5.0-rc4-next-20160216-00001-g5269cc926b02 (source-+bZmOdGhbsPr6rcHtW+onFJE71vCis6O@public.gmane.org) (gcc version 6.0.0 20160205 (Red Hat 6.0.0-0.10) (GCC) ) #166 SMP PREEMPT Tue Feb 16 11:51:56 EST 2016
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-4.5.0-rc4-next-20160216-00001-g5269cc926b02 root=/dev/mapper/turing--police-root ro rd.md=0 rd.dm=0 rd.lvm.lv=turing-police/00 console.keymap=us vconsole.font=latarcyrheb-sun16 rd.luks.uuid=luks-665bb147-9e39-4003-b3ae-7be925f51a97 rd.lvm.lv=turing-police/swap rd.lvm.lv=turing-police/root quiet LANG=en_US.UTF-8 nouveau.modeset=0 rd.driver.blacklist=nouveau video=vesa:off single
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Supporting XSAVE feature 0x01: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x02: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x04: 'AVX registers'
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c9f09fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000c9f0a000-0x00000000c9ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca000000-0x00000000ca752fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ca753000-0x00000000ca7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca800000-0x00000000cafb1fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cafb2000-0x00000000caffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cb000000-0x00000000cc6fdfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cc6fe000-0x00000000cc7fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cc800000-0x00000000cd99afff] usable
[    0.000000] BIOS-e820: [mem 0x00000000cd99b000-0x00000000ce3a0fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ce3a1000-0x00000000ce3e3fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000ce3e4000-0x00000000ceeb2fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ceeb3000-0x00000000cf3effff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000cf3f0000-0x00000000cf3fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000022dffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0xc735b018-0xc7377e57] usable ==> usable
[    0.000000] e820: update [mem 0xc734b018-0xc735ac57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x00000000c734b017] usable
[    0.000000] reserve setup_data: [mem 0x00000000c734b018-0x00000000c735ac57] usable
[    0.000000] reserve setup_data: [mem 0x00000000c735ac58-0x00000000c735b017] usable
[    0.000000] reserve setup_data: [mem 0x00000000c735b018-0x00000000c7377e57] usable
[    0.000000] reserve setup_data: [mem 0x00000000c7377e58-0x00000000c9f09fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000c9f0a000-0x00000000c9ffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ca000000-0x00000000ca752fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000ca753000-0x00000000ca7fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ca800000-0x00000000cafb1fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cafb2000-0x00000000caffffff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000cb000000-0x00000000cc6fdfff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cc6fe000-0x00000000cc7fffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000cc800000-0x00000000cd99afff] usable
[    0.000000] reserve setup_data: [mem 0x00000000cd99b000-0x00000000ce3a0fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ce3a1000-0x00000000ce3e3fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000ce3e4000-0x00000000ceeb2fff] usable
[    0.000000] reserve setup_data: [mem 0x00000000ceeb3000-0x00000000cf3effff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000cf3f0000-0x00000000cf3fffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000022dffffff] usable
[    0.000000] efi: EFI v2.31 by American Megatrends
[    0.000000] efi:  ACPI=0xcaff1000  ACPI 2.0=0xcaff1000  SMBIOS=0xf04c0  MPS=0xfd6d0 
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: Dell Inc. Latitude E6530/07Y85M, BIOS A17 08/19/2015
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x22e000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-CFFFF write-protect
[    0.000000]   D0000-DFFFF uncachable
[    0.000000]   E0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask E00000000 write-back
[    0.000000]   1 base 200000000 mask FE0000000 write-back
[    0.000000]   2 base 220000000 mask FF8000000 write-back
[    0.000000]   3 base 228000000 mask FFC000000 write-back
[    0.000000]   4 base 22C000000 mask FFE000000 write-back
[    0.000000]   5 base 0E0000000 mask FE0000000 uncachable
[    0.000000]   6 base 0D0000000 mask FF0000000 uncachable
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT  
[    0.000000] e820: update [mem 0xd0000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0xcf400 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fda20-0x000fda2f] mapped at [ffff8800000fda20]
[    0.000000] Base memory trampoline at [ffff880000095000] 95000 size 24576
[    0.000000] BRK [0x17037000, 0x17037fff] PGTABLE
[    0.000000] BRK [0x17038000, 0x17038fff] PGTABLE
[    0.000000] BRK [0x17039000, 0x17039fff] PGTABLE
[    0.000000] BRK [0x1703a000, 0x1703afff] PGTABLE
[    0.000000] BRK [0x1703b000, 0x1703bfff] PGTABLE
[    0.000000] BRK [0x1703c000, 0x1703cfff] PGTABLE
[    0.000000] RAMDISK: [mem 0x3f5d1000-0x3fffafff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000CAFF1000 000024 (v02 DELL  )
[    0.000000] ACPI: XSDT 0x00000000CAFF1088 000094 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000CAFFB718 00010C (v05 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000CAFF11B0 00A563 (v02 DELL   CBX3     00000021 INTL 20091112)
[    0.000000] ACPI: FACS 0x00000000CC7ED080 000040
[    0.000000] ACPI: APIC 0x00000000CAFFB828 000072 (v03 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x00000000CAFFB8A0 000044 (v01 DELL   CBX3     01072009 AMI  00010013)
[    0.000000] ACPI: TCPA 0x00000000CAFFB8E8 000032 (v02 APTIO4 NAPAASF  00000001 MSFT 01000013)
[    0.000000] ACPI: MCFG 0x00000000CAFFB920 00003C (v01 DELL   CBX3     01072009 MSFT 00000097)
[    0.000000] ACPI: HPET 0x00000000CAFFB960 000038 (v01 DELL   CBX3     01072009 AMI. 00000005)
[    0.000000] ACPI: SSDT 0x00000000CAFFB998 000415 (v01 SataRe SataTabl 00001000 INTL 20091112)
[    0.000000] ACPI: SSDT 0x00000000CAFFBDB0 0009B9 (v01 PmRef  Cpu0Ist  00003000 INTL 20051117)
[    0.000000] ACPI: SSDT 0x00000000CAFFC770 000B22 (v01 PmRef  CpuPm    00003000 INTL 20051117)
[    0.000000] ACPI: DMAR 0x00000000CAFFD298 000080 (v01 INTEL  SNB      00000001 INTL 00000001)
[    0.000000] ACPI: ASF! 0x00000000CAFFD318 0000A5 (v32 INTEL   HCG     00000001 TFSM 000F4240)
[    0.000000] ACPI: SSDT 0x00000000CAFFD3C0 000579 (v01 AMITCG PROC     00000001 INTL 20051117)
[    0.000000] ACPI: BGRT 0x00000000CAFFD940 000038 (v00 ??              01072009 AMI  00010013)
[    0.000000] ACPI: SSDT 0x00000000CAFFD978 00198A (v01 NvdRef NvdTabl  00001000 INTL 20091112)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000001000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000022dffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000c9f09fff]
[    0.000000]   node   0: [mem 0x00000000ca000000-0x00000000ca752fff]
[    0.000000]   node   0: [mem 0x00000000ca800000-0x00000000cafb1fff]
[    0.000000]   node   0: [mem 0x00000000cb000000-0x00000000cc6fdfff]
[    0.000000]   node   0: [mem 0x00000000cc800000-0x00000000cd99afff]
[    0.000000]   node   0: [mem 0x00000000ce3e4000-0x00000000ceeb2fff]
[    0.000000]   node   0: [mem 0x00000000cf3f0000-0x00000000cf3fffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000022dffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000022dffffff]
[    0.000000] On node 0 totalpages: 2081061
[    0.000000]   DMA32 zone: 11541 pages used for memmap
[    0.000000]   DMA32 zone: 28 pages reserved
[    0.000000]   DMA32 zone: 844069 pages, LIFO batch:31
[    0.000000]   Normal zone: 16912 pages used for memmap
[    0.000000]   Normal zone: 1236992 pages, LIFO batch:31
[    0.000000] tboot: non-0 tboot_addr but it is not of type E820_RESERVED
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] e820: [mem 0xcf400000-0xf7ffffff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:4 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
[    0.000000] PERCPU: Embedded 34 pages/cpu @ffff88022dc00000 s99400 r8192 d31672 u524288
[    0.000000] pcpu-alloc: s99400 r8192 d31672 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 2052580
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-4.5.0-rc4-next-20160216-00001-g5269cc926b02 root=/dev/mapper/turing--police-root ro rd.md=0 rd.dm=0 rd.lvm.lv=turing-police/00 console.keymap=us vconsole.font=latarcyrheb-sun16 rd.luks.uuid=luks-665bb147-9e39-4003-b3ae-7be925f51a97 rd.lvm.lv=turing-police/swap rd.lvm.lv=turing-police/root quiet LANG=en_US.UTF-8 nouveau.modeset=0 rd.driver.blacklist=nouveau video=vesa:off single
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.000000] Memory: 7908120K/8324244K available (10069K kernel code, 1814K rwdata, 3672K rodata, 1312K init, 15488K bss, 416124K reserved, 0K cma-reserved)
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU lockdep checking is enabled.
[    0.000000] 	Build-time adjustment of leaf fanout to 64.
[    0.000000] NR_IRQS:4352 nr_irqs:456 16
[    0.000000] Console: colour dummy device 160x64
[    0.000000] console [tty0] enabled
[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000000] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000000] ... CHAINHASH_SIZE:          32768
[    0.000000]  memory used by lock dependency info: 8159 kB
[    0.000000]  per task-struct memory footprint: 1920 bytes
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2691.263 MHz processor
[    0.000076] Calibrating delay loop (skipped), value calculated using timer frequency.. 5382.52 BogoMIPS (lpj=2691263)
[    0.000080] pid_max: default: 32768 minimum: 301
[    0.000091] ACPI: Core revision 20160108
[    0.025074] ACPI: 6 ACPI AML tables successfully acquired and loaded

[    0.025657] Security Framework initialized
[    0.025660] SELinux:  Initializing.
[    0.025699] SELinux:  Starting in permissive mode
[    0.025720] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.025723] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.027284] CPU: Physical Processor ID: 0
[    0.027286] CPU: Processor Core ID: 0
[    0.027291] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.027292] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.027295] mce: CPU supports 7 MCE banks
[    0.027335] process: using mwait in idle threads
[    0.027338] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.027340] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.027881] Freeing SMP alternatives memory: 28K (ffffffff9610f000 - ffffffff96116000)
[    0.049097] ftrace: allocating 31130 entries in 122 pages
[    0.062692] DMAR: Host address width 36
[    0.062697] DMAR: DRHD base: 0x000000fed90000 flags: 0x1
[    0.062774] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap c9008020660262 ecap f0105a
[    0.062777] DMAR: RMRR base: 0x000000cdb11000 end: 0x000000cdb30fff
[    0.062780] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed90000 IOMMU 0
[    0.062782] DMAR-IR: HPET id 0 under DRHD base 0xfed90000
[    0.062784] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.062909] DMAR: DRHD: handling fault status reg 2
[    0.062916] DMAR: DMAR:[DMA Read] Request device [00:1f.2] fault addr cdacd000 
               DMAR:[fault reason 06] PTE Read access is not set
[    0.063012] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.063014] x2apic enabled
[    0.063021] Switched APIC routing to cluster x2apic.
[    0.063859] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.073880] TSC deadline timer enabled
[    0.073885] smpboot: CPU0: Intel(R) Core(TM) i5-3340M CPU @ 2.70GHz (family: 0x6, model: 0x3a, stepping: 0x9)
[    0.073899] Performance Events: PEBS fmt1+, 16-deep LBR, IvyBridge events, full-width counters, Intel PMU driver.
[    0.073929] ... version:                3
[    0.073930] ... bit width:              48
[    0.073931] ... generic registers:      4
[    0.073933] ... value mask:             0000ffffffffffff
[    0.073934] ... max period:             0000ffffffffffff
[    0.073935] ... fixed-purpose events:   3
[    0.073937] ... event mask:             000000070000000f
[    0.080332] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.083185] x86: Booting SMP configuration:
[    0.083188] .... node  #0, CPUs:      #1 #2 #3
[    0.096741] x86: Booted up 1 node, 4 CPUs

--==_Exmh_1457385849_24910
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--==_Exmh_1457385849_24910--
