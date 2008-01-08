From: Tejun Heo <htejun@gmail.com>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Tue, 08 Jan 2008 10:16:41 +0900
Message-ID: <4782CEF9.3040708@gmail.com>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca> <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com> <4782C008.3030902@shaw.ca> <4782CB62.7040901@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060400010704080707020507"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.153]:31562 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbYAHBQu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 20:16:50 -0500
Received: by po-out-1718.google.com with SMTP id c31so1678304poi.1
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 17:16:49 -0800 (PST)
In-Reply-To: <4782CB62.7040901@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

This is a multi-part message in MIME format.
--------------060400010704080707020507
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Tejun Heo wrote:
> Robert Hancock wrote:
>>>> This has only been reported on one person's MSI board. Apparently
>>>> another revision of the same board is reported to work, and I can't
>>>> duplicate the problem on my Asus board, so it could just be some
>>>> hardware problem on that motherboard.
>>> IIRC, I have two from suse bug reports and both resolved with adma=0.
>>> I'm not too sure whether post 2.6.23-rcX changes would have fixed those
>>> problems tho.  FWIW, I've disabled ADMA mode on all suse products.
>> A hotplug-related problem? Have a link to the reports?
> 
> Hmmm... I mis-remembered.  The reporter said it was okay in SL102
> (2.6.18, no ADMA) but SL103 (2.6.22, ADMA is on) fell apart.  I asked
> for retest w/ adma=0 but no response yet.
> 
>   https://bugzilla.novell.com/show_bug.cgi?id=347184
> 
> I tried to reproduce the problem on my a8n-e but couldn't.

Okay, just succeeded on the current #upstream-fixes, attaching the log.
 The machine is a brick after the crash.

Thanks.

-- 
tejun

--------------060400010704080707020507
Content-Type: text/x-log;
 name="hard-lockup.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hard-lockup.log"

[    0.000000] Linux version 2.6.24-rc5-work (tj@htj) (gcc version 4.2.1 (SUSE Linux)) #15 SMP PREEMPT Tue Jan 8 00:52:24 KST 2008
[    0.000000] Command line: BOOT_IMAGE=vmlinuz-ck804 root=/dev/hde1 nmi_watchdog=1 printk.printk_time=1 console=ttyS0,115200 console=tty0 sysrq_always_enabled netconsole=6666@10.7.7.17/eth0,6666@10.7.7.1/00:18:f3:ab:44:ab
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
[    0.000000]  BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
[    0.000000]  BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP 000F7560, 0014 (r0 Nvidia)
[    0.000000] ACPI: RSDT 1FFF3040, 0030 (r1 Nvidia AWRDACPI 42302E31 AWRD        0)
[    0.000000] ACPI: FACP 1FFF30C0, 0074 (r1 Nvidia AWRDACPI 42302E31 AWRD        0)
[    0.000000] ACPI: DSDT 1FFF3180, 65F2 (r1 NVIDIA AWRDACPI     1000 MSFT  100000E)
[    0.000000] ACPI: FACS 1FFF0000, 0040
[    0.000000] ACPI: MCFG 1FFF9880, 003C (r1 Nvidia AWRDACPI 42302E31 AWRD        0)
[    0.000000] ACPI: APIC 1FFF97C0, 007C (r1 Nvidia AWRDACPI 42302E31 AWRD        0)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      158
[    0.000000]     0:      256 ->   131056
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] ACPI: PM-Timer IO Port: 0x4008
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
[    0.000000] Processor #1
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: BIOS IRQ0 pin2 override ignored.
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] swsusp: Registered nosave memory region: 000000000009e000 - 000000000009f000
[    0.000000] swsusp: Registered nosave memory region: 000000000009f000 - 00000000000a0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000a0000 - 00000000000f0000
[    0.000000] swsusp: Registered nosave memory region: 00000000000f0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 30000000 (gap: 20000000:c0000000)
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PERCPU: Allocating 30608 bytes of per cpu data
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 124913
[    0.000000] Kernel command line: BOOT_IMAGE=vmlinuz-ck804 root=/dev/hde1 nmi_watchdog=1 printk.printk_time=1 console=ttyS0,115200 console=tty0 sysrq_always_enabled netconsole=6666@10.7.7.17/eth0,6666@10.7.7.1/00:18:f3:ab:44:ab
[    0.000000] Unknown boot option `printk.printk_time=1': ignoring
[    0.000000] debug: sysrq always enabled.
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 2048 (order: 11, 16384 bytes)
[    0.000000] TSC calibrated against PM_TIMER
[   33.584206] Marking TSC unstable due to TSCs unsynchronized
[   33.584208] time.c: Detected 2211.339 MHz processor.
[   33.585864] Console: colour VGA+ 80x25
[   33.585870] console [tty0] enabled
[   33.588975] console [ttyS0] enabled
[   33.984212] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[   33.992009] ... MAX_LOCKDEP_SUBCLASSES:    8
[   33.996316] ... MAX_LOCK_DEPTH:          30
[   34.000536] ... MAX_LOCKDEP_KEYS:        2048
[   34.004929] ... CLASSHASH_SIZE:           1024
[   34.009409] ... MAX_LOCKDEP_ENTRIES:     8192
[   34.013803] ... MAX_LOCKDEP_CHAINS:      16384
[   34.018291] ... CHAINHASH_SIZE:          8192
[   34.022684]  memory used by lock dependency info: 1648 kB
[   34.028126]  per task-struct memory footprint: 1680 bytes
[   34.034166] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
[   34.041553] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
[   34.048513] Checking aperture...
[   34.051785] CPU 0: aperture @ e00000000 size 32 MB
[   34.056618] Aperture too small (32 MB)
[   34.065312] No AGP bridge found
[   34.078971] Memory: 498428k/524224k available (4825k kernel code, 25080k reserved, 2510k data, 264k init)
[   34.170135] Calibrating delay using timer specific routine.. 4426.19 BogoMIPS (lpj=8852396)
[   34.178856] Mount-cache hash table entries: 256
[   34.184127] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   34.191306] CPU: L2 Cache: 1024K (64 bytes/line)
[   34.195967] CPU: Physical Processor ID: 0
[   34.200021] CPU: Processor Core ID: 0
[   34.203749] lockdep: not fixing up alternatives.
[   34.208411] ACPI: Core revision 20070126
[   34.261387] activating NMI Watchdog ... done.
[   34.265831] Using local APIC timer interrupts.
[   34.315533] Detected 12.564 MHz APIC timer.
[   34.319757] APIC timer registered as dummy, due to nmi_watchdog=1!
[   34.326686] lockdep: not fixing up alternatives.
[   34.331460] Booting processor 1/2 APIC 0x1
[   34.345884] Initializing CPU#1
[   34.426168] Calibrating delay using timer specific routine.. 4422.87 BogoMIPS (lpj=8845749)
[   34.426174] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   34.426176] CPU: L2 Cache: 1024K (64 bytes/line)
[   34.426179] CPU: Physical Processor ID: 0
[   34.426180] CPU: Processor Core ID: 1
[   34.426315] AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
[   34.426216] Brought up 2 CPUs
[   34.466899] testing NMI watchdog ... <4>WARNING: CPU#0: NMI appears to be stuck (0->0)!
[   34.555056] WARNING: CPU#1: NMI appears to be stuck (0->0)!
[   34.561367] net_namespace: 144 bytes
[   34.565548] xor: automatically using best checksumming function: generic_sse
[   34.589979]    generic_sse:  6120.000 MB/sec
[   34.594284] xor: using function: generic_sse (6120.000 MB/sec)
[   34.600308] NET: Registered protocol family 16
[   34.605333] ACPI: bus type pci registered
[   34.614553] PCI: Using MMCONFIG at e0000000 - efffffff
[   34.619770] PCI: No mmconfig possible on device 00:18
[   34.648045] ACPI: Interpreter enabled
[   34.651756] ACPI: (supports S0 S1 S3 S4 S5)
[   34.656250] ACPI: Using IOAPIC for interrupt routing
[   34.678749] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   34.684462] PCI: Transparent bridge - 0000:00:09.0
[   34.786517] ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 7 9 10 *11 12 14 15)
[   34.794328] ACPI: PCI Interrupt Link [LNK2] (IRQs *3 4 5 7 9 10 11 12 14 15)
[   34.802154] ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   34.811195] ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   34.820215] ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   34.829238] ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 7 9 10 *11 12 14 15)
[   34.837035] ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   34.846071] ACPI: PCI Interrupt Link [LMAC] (IRQs *3 4 5 7 9 10 11 12 14 15)
[   34.853874] ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[   34.861682] ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   34.870712] ACPI: PCI Interrupt Link [LSMB] (IRQs *3 4 5 7 9 10 11 12 14 15)
[   34.878511] ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[   34.886311] ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   34.895349] ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
[   34.903156] ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
[   34.910969] ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
[   34.920050] ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0
[   34.925840] ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0
[   34.931613] ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
[   34.938383] ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
[   34.945048] ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
[   34.951632] ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0
[   34.958330] ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
[   34.966025] ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0
[   34.972718] ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0
[   34.979418] ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
[   34.987112] ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0
[   34.993809] ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0
[   35.000510] ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
[   35.008215] ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0
[   35.014922] ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0
[   35.021628] ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
[   35.029330] Linux Plug and Play Support v0.97 (c) Adam Belay
[   35.035126] pnp: PnP ACPI init
[   35.038248] ACPI: bus type pnp registered
[   35.050455] pnpacpi: exceeded the max number of mem resources: 12
[   35.056593] pnpacpi: exceeded the max number of mem resources: 12
[   35.062892] pnp: PnP ACPI: found 16 devices
[   35.067121] ACPI: ACPI bus type pnp unregistered
[   35.072588] SCSI subsystem initialized
[   35.076739] usbcore: registered new interface driver usbfs
[   35.082354] usbcore: registered new interface driver hub
[   35.087824] usbcore: registered new device driver usb
[   35.093316] PCI: Using ACPI for IRQ routing
[   35.097548] PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
[   35.134025] system 00:01: ioport range 0x4000-0x407f has been reserved
[   35.140596] system 00:01: ioport range 0x4080-0x40ff has been reserved
[   35.147164] system 00:01: ioport range 0x4400-0x447f has been reserved
[   35.153733] system 00:01: ioport range 0x4480-0x44ff has been reserved
[   35.160300] system 00:01: ioport range 0x4800-0x487f has been reserved
[   35.166871] system 00:01: ioport range 0x4880-0x48ff has been reserved
[   35.173452] system 00:02: ioport range 0x4d0-0x4d1 has been reserved
[   35.179848] system 00:02: ioport range 0x800-0x87f has been reserved
[   35.186244] system 00:02: ioport range 0x290-0x297 has been reserved
[   35.192654] system 00:0e: iomem range 0xe0000000-0xefffffff could not be reserved
[   35.200201] system 00:0f: iomem range 0xd5e00-0xd7fff has been reserved
[   35.206859] system 00:0f: iomem range 0xf0000-0xf7fff could not be reserved
[   35.213862] system 00:0f: iomem range 0xf8000-0xfbfff could not be reserved
[   35.220862] system 00:0f: iomem range 0xfc000-0xfffff could not be reserved
[   35.227863] system 00:0f: iomem range 0x1fff0000-0x1fffffff could not be reserved
[   35.235403] system 00:0f: iomem range 0xffff0000-0xffffffff has been reserved
[   35.242577] system 00:0f: iomem range 0x0-0x9ffff could not be reserved
[   35.249233] system 00:0f: iomem range 0x100000-0x1ffeffff could not be reserved
[   35.256597] system 00:0f: iomem range 0xfec00000-0xfec00fff has been reserved
[   35.263774] system 00:0f: iomem range 0xfee00000-0xfeefffff could not be reserved
[   35.271311] system 00:0f: iomem range 0xfefff000-0xfeffffff has been reserved
[   35.278486] system 00:0f: iomem range 0xfff80000-0xfff80fff has been reserved
[   35.287094] PCI: Bridge: 0000:00:09.0
[   35.290798] Time: acpi_pm clocksource has been installed.
[   35.296246]   IO window: 9000-afff
[   35.299699]   MEM window: d8000000-d9ffffff
[   35.303930]   PREFETCH window: d0000000-d7ffffff
[   35.308617] PCI: Bridge: 0000:00:0b.0
[   35.312317]   IO window: disabled.
[   35.315757]   MEM window: disabled.
[   35.319284]   PREFETCH window: disabled.
[   35.323244] PCI: Bridge: 0000:00:0c.0
[   35.326943]   IO window: disabled.
[   35.330385]   MEM window: disabled.
[   35.333913]   PREFETCH window: disabled.
[   35.337876] PCI: Bridge: 0000:00:0d.0
[   35.341579]   IO window: disabled.
[   35.345020]   MEM window: disabled.
[   35.348546]   PREFETCH window: disabled.
[   35.352507] PCI: Bridge: 0000:00:0e.0
[   35.356205]   IO window: disabled.
[   35.359646]   MEM window: disabled.
[   35.363175]   PREFETCH window: disabled.
[   35.367250] NET: Registered protocol family 2
[   35.406073] IP route cache hash table entries: 4096 (order: 3, 32768 bytes)
[   35.413646] TCP established hash table entries: 16384 (order: 6, 262144 bytes)
[   35.421226] TCP bind hash table entries: 16384 (order: 7, 917504 bytes)
[   35.428995] TCP: Hash tables configured (established 16384 bind 16384)
[   35.435613] TCP reno registered
[   35.454108] SGI XFS with large block/inode numbers, no debug enabled
[   35.461202] async_tx: api initialized (sync-only)
[   35.465955] io scheduler noop registered
[   35.469916] io scheduler anticipatory registered
[   35.474575] io scheduler deadline registered
[   35.478918] io scheduler cfq registered (default)
[   35.506644] PCI: Linking AER extended capability on 0000:00:0b.0
[   35.512720] PCI: Linking AER extended capability on 0000:00:0c.0
[   35.518772] PCI: Linking AER extended capability on 0000:00:0d.0
[   35.524819] PCI: Linking AER extended capability on 0000:00:0e.0
[   35.531279] assign_interrupt_mode Found MSI capability
[   35.536703] assign_interrupt_mode Found MSI capability
[   35.542156] assign_interrupt_mode Found MSI capability
[   35.547564] assign_interrupt_mode Found MSI capability
[   35.553127] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   35.558744] fakephp: Fake PCI Hot Plug Controller Driver
[   35.565844] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[   35.573347] input: Power Button (FF) as /class/input/input0
[   35.578988] ACPI: Power Button (FF) [PWRF]
[   35.583282] input: Power Button (CM) as /class/input/input1
[   35.588892] ACPI: Power Button (CM) [PWRB]
[   35.593185] ACPI: Fan [FAN] (on)
[   35.603430] ACPI: Thermal Zone [THRM] (40 C)
[   35.694019] Non-volatile memory driver v1.2
[   35.698292] Linux agpgart interface v0.102
[   35.702561] Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
[   35.711713] Hangcheck: Using get_cycles().
[   35.717056] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[   35.725267] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   35.732709] 00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[   35.740295] parport_pc 00:09: reported by Plug and Play ACPI
[   35.746034] parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP(,...)]
[   35.754544] loop: module loaded
[   35.757724] Compaq SMART2 Driver (v 2.6.0)
[   35.761973] HP CISS Driver (v 3.6.14)
[   35.765798] Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
[   35.771842] Copyright (c) 1999-2006 Intel Corporation.
[   35.777344] e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
[   35.783479] e100: Copyright(c) 1999-2006 Intel Corporation
[   35.789425] ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
[   35.797502] forcedeth: Reverse Engineered nForce ethernet driver. Version 0.61.
[   35.805428] ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
[   35.811229] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 23
[   36.338640] forcedeth 0000:00:0a.0: ifname eth0, PHY OUI 0x5043 @ 9, addr 00:13:d4:3e:1b:35
[   36.347044] forcedeth 0000:00:0a.0: highdma csum timirq gbit lnktim desc-v3
[   36.354399] netconsole: local port 6666
[   36.358273] netconsole: local IP 10.7.7.17
[   36.362413] netconsole: interface eth0
[   36.366199] netconsole: remote port 6666
[   36.370160] netconsole: remote IP 10.7.7.1
[   36.374295] netconsole: remote ethernet address 00:18:f3:ab:44:ab
[   36.380437] netconsole: device eth0 not up yet, forcing it
[   36.387056] eth0: no link during initialization.
[   39.035607] eth0: link up.
[   39.053761] console [netcon0] enabled
[   40.576718] netconsole: network logging started
[   40.581291] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   40.587696] ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
[   40.595928] HPT372N: IDE controller (0x1103:0x0005 rev 0x02) at  PCI slot 0000:05:07.0
[   40.604224] ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
[   40.610024] ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
[   40.618886] HPT372N: DPLL base: 77 MHz, f_CNT: 79, assuming 33 MHz PCI
[   40.628162] HPT372N: using 66 MHz DPLL clock
[   40.632579] HPT372N: 100% native mode on irq 17
[   40.637161]     ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:DMA, hdf:pio
[   40.644543]     ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
[   41.609716] hde: HDS728080PLAT20, ATA DISK drive
[   41.614601] hde: UDMA/133 mode selected
[   41.618831] ide2 at 0x9400-0x9407,0x9802 on irq 17
[   42.190088] hde: max request size: 512KiB
[   42.199542] hde: Host Protected Area detected.
[   42.199543]  current capacity is 160834367 sectors (82347 MB)
[   42.199544]  native  capacity is 160836480 sectors (82348 MB)
[   42.215762] hde: Host Protected Area disabled.
[   42.220250] hde: 160836480 sectors (82348 MB) w/1719KiB Cache, CHS=16383/255/63
[   42.229312] hde: cache flushes supported
[   42.233456]  hde: hde1 hde2
[   42.245883] st: Version 20070203, fixed bufsize 32768, s/g segs 256
[   42.252375] osst :I: Tape driver with OnStream support version 0.99.4
[   42.252376] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[   42.266124] SCSI Media Changer driver v0.25
[   42.270605] Fusion MPT base driver 3.04.06
[   42.274746] Copyright (c) 1999-2007 LSI Corporation
[   42.279678] Fusion MPT SPI Host driver 3.04.06
[   42.284283] Fusion MPT FC Host driver 3.04.06
[   42.288821] Fusion MPT SAS Host driver 3.04.06
[   42.293431] Fusion MPT misc device (ioctl) driver 3.04.06
[   42.298974] mptctl: Registered with Fusion MPT base driver
[   42.304505] mptctl: /dev/mptctl @ (major,minor=10,220)
[   42.311156] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[   42.321652] serio: i8042 KBD port at 0x60,0x64 irq 1
[   42.326681] serio: i8042 AUX port at 0x60,0x64 irq 12
[   42.332032] mice: PS/2 mouse device common for all mice
[   42.361666] md: linear personality registered for level -1
[   42.367200] md: raid0 personality registered for level 0
[   42.372553] md: raid1 personality registered for level 1
[   42.398261] input: AT Translated Set 2 keyboard as /class/input/input2
[   42.445451] raid6: int64x1   1735 MB/s
[   42.513439] raid6: int64x2   2492 MB/s
[   42.581440] raid6: int64x4   2708 MB/s
[   42.649426] raid6: int64x8   2300 MB/s
[   42.717419] raid6: sse2x1    2394 MB/s
[   42.785411] raid6: sse2x2    3193 MB/s
[   42.853409] raid6: sse2x4    3810 MB/s
[   42.857204] raid6: using algorithm sse2x4 (3810 MB/s)
[   42.862303] md: raid6 personality registered for level 6
[   42.867657] md: raid5 personality registered for level 5
[   42.873012] md: raid4 personality registered for level 4
[   42.878368] md: multipath personality registered for level -4
[   42.884333] device-mapper: ioctl: 4.12.0-ioctl (2007-10-02) initialised: dm-devel@redhat.com
[   42.892831] EDAC MC: Ver: 2.1.0 Jan  4 2008
[   42.897413] usbcore: registered new interface driver usbhid
[   42.903031] drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
[   42.909383] IPv4 over IPv4 tunneling driver
[   42.914097] GRE over IPv4 tunneling driver
[   42.918817] TCP cubic registered
[   42.922117] NET: Registered protocol family 1
[   42.926538] NET: Registered protocol family 17
[   42.931371] RPC: Registered udp transport module.
[   42.936125] RPC: Registered tcp transport module.
[   42.941688] md: Autodetecting RAID arrays.
[   42.945828] md: Scanned 0 and added 0 devices.
[   42.950321] md: autorun ...
[   42.953157] md: ... autorun DONE.
[   42.971499] kjournald starting.  Commit interval 5 seconds
[   42.971876] EXT3-fs: mounted filesystem with ordered data mode.
[   42.971894] VFS: Mounted root (ext3 filesystem) readonly.
[   42.971927] Freeing unused kernel memory: 264k freed
[   44.077299]
[   44.077301] =================================
[   44.083252] [ INFO: inconsistent lock state ]
[   44.087656] 2.6.24-rc5-work #15
[   44.090842] ---------------------------------
[   44.095244] inconsistent {softirq-on-W} -> {in-softirq-W} usage.
[   44.101294] hwup/1109 [HC0[0]:SC1[1]:HE1:SE0] takes:
[   44.106302]  (_xmit_ETHER){-+..}, at: [<ffffffff8063a51e>] dev_watchdog+0x2e/0x120
[   44.114109] {softirq-on-W} state was registered at:
[   44.119031]   [<ffffffff8025f3d8>] mark_held_locks+0x58/0xa0
[   44.124864]   [<ffffffff806b35bb>] _spin_unlock_irq+0x2b/0x60
[   44.130791]   [<ffffffff8025f58f>] trace_hardirqs_on+0xbf/0x160
[   44.136881]   [<ffffffff806b35bb>] _spin_unlock_irq+0x2b/0x60
[   44.142801]   [<ffffffff804e35e2>] nv_start_xmit_optimized+0x3c2/0x4c0
[   44.149515]   [<ffffffff806362aa>] netpoll_send_skb+0x13a/0x1c0
[   44.155598]   [<ffffffff8063626e>] netpoll_send_skb+0xfe/0x1c0
[   44.161595]   [<ffffffff8063721f>] netpoll_send_udp+0x22f/0x2a0
[   44.167688]   [<ffffffff804f0b72>] write_msg+0xa2/0xe0
[   44.173008]   [<ffffffff8023c7e6>] __call_console_drivers+0x66/0x80
[   44.179446]   [<ffffffff8023c87f>] _call_console_drivers+0x7f/0x90
[   44.185799]   [<ffffffff8023c9d8>] release_console_sem+0x108/0x250
[   44.192158]   [<ffffffff8023d546>] register_console+0x156/0x2d0
[   44.198258]   [<ffffffff8097bf88>] init_netconsole+0x1e8/0x210
[   44.204254]   [<ffffffff803f26e9>] __pci_register_driver+0x99/0xc0
[   44.210607]   [<ffffffff8095e78b>] kernel_init+0x15b/0x340
[   44.216274]   [<ffffffff8025f58f>] trace_hardirqs_on+0xbf/0x160
[   44.222356]   [<ffffffff806b28a4>] trace_hardirqs_on_thunk+0x35/0x3a
[   44.228882]   [<ffffffff8025f58f>] trace_hardirqs_on+0xbf/0x160
[   44.234966]   [<ffffffff8020d408>] child_rip+0xa/0x12
[   44.240200]   [<ffffffff8020caf3>] restore_args+0x0/0x30
[   44.245676]   [<ffffffff8095e630>] kernel_init+0x0/0x340
[   44.251168]   [<ffffffff8020d3fe>] child_rip+0x0/0x12
[   44.256386]   [<ffffffffffffffff>] 0xffffffffffffffff
[   44.261602] irq event stamp: 1772
[   44.264956] hardirqs last  enabled at (1772): [<ffffffff806b35bb>] _spin_unlock_irq+0x2b/0x60
[   44.273630] hardirqs last disabled at (1771): [<ffffffff806b30c2>] _spin_lock_irq+0x12/0x50
[   44.282130] softirqs last  enabled at (0): [<ffffffff8023a254>] copy_process+0x324/0x1580
[   44.290458] softirqs last disabled at (1769): [<ffffffff8020d77c>] call_softirq+0x1c/0x30
[   44.298786]
[   44.298786] other info that might help us debug this:
[   44.305406] 1 lock held by hwup/1109:
[   44.309115]  #0:  (&type->i_mutex_dir_key#2){--..}, at: [<ffffffff802a73cb>] do_lookup+0xdb/0x210
[   44.318317]
[   44.318317] stack backtrace:
[   44.322773] Pid: 1109, comm: hwup Not tainted 2.6.24-rc5-work #15
[   44.328906]
[   44.328907] Call Trace:
[   44.332927]  <IRQ>  [<ffffffff8025e32b>] print_usage_bug+0x18b/0x190
[   44.339367]  [<ffffffff8025f36d>] mark_lock+0x63d/0x650
[   44.344638]  [<ffffffff803cfd94>] __freed_request+0xb4/0xc0
[   44.350251]  [<ffffffff8025fe5e>] __lock_acquire+0x37e/0x1150
[   44.356038]  [<ffffffff80260205>] __lock_acquire+0x725/0x1150
[   44.361827]  [<ffffffff8063a4f0>] dev_watchdog+0x0/0x120
[   44.367183]  [<ffffffff80260c8b>] lock_acquire+0x5b/0x80
[   44.372537]  [<ffffffff8063a51e>] dev_watchdog+0x2e/0x120
[   44.377980]  [<ffffffff806b2ecf>] _spin_lock+0x2f/0x40
[   44.383162]  [<ffffffff8063a51e>] dev_watchdog+0x2e/0x120
[   44.388604]  [<ffffffff80246eb8>] run_timer_softirq+0x198/0x200
[   44.394566]  [<ffffffff80242974>] __do_softirq+0x84/0x110
[   44.400007]  [<ffffffff8023e38b>] profile_tick+0x5b/0x90
[   44.405361]  [<ffffffff8020d77c>] call_softirq+0x1c/0x30
[   44.410718]  [<ffffffff8020fb95>] do_softirq+0x65/0xc0
[   44.415899]  [<ffffffff80242875>] irq_exit+0x55/0x60
[   44.420911]  [<ffffffff802211c9>] smp_apic_timer_interrupt+0x49/0x70
[   44.427312]  [<ffffffff8020d22b>] apic_timer_interrupt+0x6b/0x70
[   44.433358]  <EOI>  [<ffffffff806b1a0b>] mutex_lock_nested+0x1eb/0x340
[   44.439979]  [<ffffffff802a73cb>] do_lookup+0xdb/0x210
[   44.445161]  [<ffffffff802a91e5>] __link_path_walk+0x815/0xe60
[   44.451038]  [<ffffffff8027c1e7>] get_page_from_freelist+0x237/0x510
[   44.457432]  [<ffffffff802a9898>] link_path_walk+0x68/0x110
[   44.463049]  [<ffffffff80226fdd>] do_page_fault+0x1cd/0x860
[   44.468662]  [<ffffffff802a995c>] path_walk+0x1c/0x20
[   44.473757]  [<ffffffff802a9bb6>] do_path_lookup+0x96/0x220
[   44.479373]  [<ffffffff802aa7ec>] __user_walk_fd+0x4c/0x80
[   44.484904]  [<ffffffff802a244e>] vfs_stat_fd+0x2e/0x70
[   44.490169]  [<ffffffff80226fdd>] do_page_fault+0x1cd/0x860
[   44.495786]  [<ffffffff802a26a7>] sys_newstat+0x27/0x50
[   44.501053]  [<ffffffff8025f58f>] trace_hardirqs_on+0xbf/0x160
[   44.506929]  [<ffffffff806b28a4>] trace_hardirqs_on_thunk+0x35/0x3a
[   44.513237]  [<ffffffff8020c49e>] system_call+0x7e/0x83
[   44.518505]
[   46.189872] EXT3 (no)acl options not supported
[   46.351158] EXT3 (no)acl options not supported
[   46.356037] EXT3 FS on hde1, internal journal


Welcome to openSUSE 10.2 (X86-64) - Kernel 2.6.24-rc5-work (ttyS0).


ck804 login: [   91.252867] libata version 3.00 loaded.
[   94.628103] sata_nv 0000:00:07.0: version 3.5
[   94.633984] ACPI: PCI Interrupt Link [APSI] enabled at IRQ 22
[   94.639828] ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 22 (level, low) -> IRQ 22
[   94.648868] sata_nv 0000:00:07.0: Using ADMA mode
[   94.653664] sata_nv 0000:00:07.0: WARNING: There are known problems with ADMA mode which may lead to timeouts and/or system lock ups.
[   94.666752] PCI: Setting latency timer of device 0000:00:07.0 to 64
[   94.673390] scsi0 : sata_nv
[   94.678587] scsi1 : sata_nv
[   94.682006] ata1: SATA max UDMA/133 cmd 0x9f0 ctl 0xbf0 bmdma 0xd800 irq 22
[   94.689040] ata2: SATA max UDMA/133 cmd 0x970 ctl 0xb70 bmdma 0xd808 irq 22
[   95.004709] ata1: SATA link down (SStatus 0 SControl 300)
[   95.324722] ata2: SATA link down (SStatus 0 SControl 300)
[   95.331716] ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 21
[   95.337666] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 21 (level, low) -> IRQ 21
[   95.342458] sata_nv 0000:00:08.0: Using ADMA mode
[   95.342460] sata_nv 0000:00:08.0: WARNING: There are known problems with ADMA mode which may lead to timeouts and/or system lock ups.
[   95.347399] PCI: Setting latency timer of device 0000:00:08.0 to 64
[   95.356014] scsi2 : sata_nv
[   95.356141] scsi3 : sata_nv
[   95.356437] ata3: SATA max UDMA/133 cmd 0x9e0 ctl 0xbe0 bmdma 0xc400 irq 21
[   95.356439] ata4: SATA max UDMA/133 cmd 0x960 ctl 0xb60 bmdma 0xc408 irq 21
[   95.820640] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   95.832837] ata3.00: HPA detected: current 312579695, native 312581808
[   95.839465] ata3.00: ATA-7: SAMSUNG HD160JJ, ZM100-41, max UDMA7
[   95.845569] ata3.00: 312579695 sectors, multi 1: LBA48 NCQ (depth 31/32)
[   95.884813] ata3.00: configured for UDMA/133
[   96.200601] ata4: SATA link down (SStatus 0 SControl 300)
[   96.206565] scsi 2:0:0:0: Direct-Access     ATA      SAMSUNG HD160JJ  ZM10 PQ: 0 ANSI: 5
[   96.214748] ata3: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
[   96.223276] sd 2:0:0:0: [sda] 312579695 512-byte hardware sectors (160041 MB)
[   96.230497] sd 2:0:0:0: [sda] Write Protect is off
[   96.235362] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   96.240585] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   96.249852] sd 2:0:0:0: [sda] 312579695 512-byte hardware sectors (160041 MB)
[   96.257094] sd 2:0:0:0: [sda] Write Protect is off
[   96.261970] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   96.267109] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   96.276290]  sda: sda1
[   96.283886] sd 2:0:0:0: [sda] Attached SCSI disk
[   96.290766] sd 2:0:0:0: Attached scsi generic sg0 type 0
[  243.760770] ata3: timeout waiting for ADMA IDLE, stat=0x400
[  243.767336] ata3.00: exception Emask 0x10 SAct 0x7fffffff SErr 0x1810000 action 0xa frozen
[  243.777128] ata3.00: ADMA status 0x00000402: , hot unplug
[  243.777133] ata3: SError: { PHYRdyChg LinkSeq TrStaTrns }
[  243.788044] ata3.00: cmd 60/01:00:8a:91:6b/00:00:04:00:00/40 tag 0 ncq 512 in
[  243.788045]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.788048] ata3.00: status: { DRDY }
[  243.807047] ata3.00: cmd 60/01:08:32:dd:80/00:00:06:00:00/40 tag 1 ncq 512 in
[  243.807051]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807056] ata3.00: status: { DRDY }
[  243.807060] ata3.00: cmd 60/01:10:c4:7b:a4/00:00:07:00:00/40 tag 2 ncq 512 in
[  243.807061]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807063] ata3.00: status: { DRDY }
[  243.807067] ata3.00: cmd 60/01:18:62:05:3a/00:00:05:00:00/40 tag 3 ncq 512 in
[  243.807068]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807070] ata3.00: status: { DRDY }
[  243.807073] ata3.00: cmd 60/01:20:6e:f9:fb/00:00:11:00:00/40 tag 4 ncq 512 in
[  243.807075]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807077] ata3.00: status: { DRDY }
[  243.807080] ata3.00: cmd 60/01:28:1d:32:f2/00:00:06:00:00/40 tag 5 ncq 512 in
[  243.807081]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807083] ata3.00: status: { DRDY }
[  243.807087] ata3.00: cmd 60/01:30:b5:81:50/00:00:0a:00:00/40 tag 6 ncq 512 in
[  243.807088]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807090] ata3.00: status: { DRDY }
[  243.807094] ata3.00: cmd 60/01:38:20:4b:96/00:00:10:00:00/40 tag 7 ncq 512 in
[  243.807095]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807097] ata3.00: status: { DRDY }
[  243.807100] ata3.00: cmd 60/01:40:5e:e3:30/00:00:07:00:00/40 tag 8 ncq 512 in
[  243.807101]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807103] ata3.00: status: { DRDY }
[  243.807107] ata3.00: cmd 60/01:48:af:df:fa/00:00:00:00:00/40 tag 9 ncq 512 in
[  243.807108]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807110] ata3.00: status: { DRDY }
[  243.807114] ata3.00: cmd 60/01:50:f2:3b:74/00:00:12:00:00/40 tag 10 ncq 512 in
[  243.807115]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807117] ata3.00: status: { DRDY }
[  243.807121] ata3.00: cmd 60/01:58:cb:43:52/00:00:11:00:00/40 tag 11 ncq 512 in
[  243.807122]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807127] ata3.00: status: { DRDY }
[  243.807131] ata3.00: cmd 60/01:60:33:67:8d/00:00:05:00:00/40 tag 12 ncq 512 in
[  243.807132]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807134] ata3.00: status: { DRDY }
[  243.807138] ata3.00: cmd 60/01:68:f8:d4:bf/00:00:0f:00:00/40 tag 13 ncq 512 in
[  243.807139]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807141] ata3.00: status: { DRDY }
[  243.807145] ata3.00: cmd 60/01:70:70:66:c2/00:00:10:00:00/40 tag 14 ncq 512 in
[  243.807146]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807148] ata3.00: status: { DRDY }
[  243.807151] ata3.00: cmd 60/01:78:78:12:4b/00:00:10:00:00/40 tag 15 ncq 512 in
[  243.807153]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807155] ata3.00: status: { DRDY }
[  243.807158] ata3.00: cmd 60/01:80:38:47:dd/00:00:0e:00:00/40 tag 16 ncq 512 in
[  243.807159]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807161] ata3.00: status: { DRDY }
[  243.807165] ata3.00: cmd 60/01:88:93:aa:b4/00:00:0e:00:00/40 tag 17 ncq 512 in
[  243.807166]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807168] ata3.00: status: { DRDY }
[  243.807172] ata3.00: cmd 60/01:90:24:b6:c5/00:00:08:00:00/40 tag 18 ncq 512 in
[  243.807173]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807175] ata3.00: status: { DRDY }
[  243.807178] ata3.00: cmd 60/01:98:30:48:49/00:00:11:00:00/40 tag 19 ncq 512 in
[  243.807179]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807181] ata3.00: status: { DRDY }
[  243.807185] ata3.00: cmd 60/01:a0:f2:59:0f/00:00:05:00:00/40 tag 20 ncq 512 in
[  243.807186]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807188] ata3.00: status: { DRDY }
[  243.807192] ata3.00: cmd 60/01:a8:ff:28:06/00:00:02:00:00/40 tag 21 ncq 512 in
[  243.807193]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807195] ata3.00: status: { DRDY }
[  243.807199] ata3.00: cmd 60/01:b0:a2:2c:b4/00:00:10:00:00/40 tag 22 ncq 512 in
[  243.807200]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807202] ata3.00: status: { DRDY }
[  243.807205] ata3.00: cmd 60/01:b8:63:60:2b/00:00:0f:00:00/40 tag 23 ncq 512 in
[  243.807206]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807208] ata3.00: status: { DRDY }
[  243.807212] ata3.00: cmd 60/01:c0:e4:33:15/00:00:09:00:00/40 tag 24 ncq 512 in
[  243.807213]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807215] ata3.00: status: { DRDY }
[  243.807219] ata3.00: cmd 60/01:c8:8f:a2:df/00:00:01:00:00/40 tag 25 ncq 512 in
[  243.807220]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807222] ata3.00: status: { DRDY }
[  243.807226] ata3.00: cmd 60/01:d0:49:27:1a/00:00:03:00:00/40 tag 26 ncq 512 in
[  243.807227]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807229] ata3.00: status: { DRDY }
[  243.807232] ata3.00: cmd 60/01:d8:e3:d6:36/00:00:0d:00:00/40 tag 27 ncq 512 in
[  243.807234]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807235] ata3.00: status: { DRDY }
[  243.807239] ata3.00: cmd 60/01:e0:58:dd:7a/00:00:10:00:00/40 tag 28 ncq 512 in
[  243.807240]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807242] ata3.00: status: { DRDY }
[  243.807246] ata3.00: cmd 60/01:e8:b7:1f:3f/00:00:11:00:00/40 tag 29 ncq 512 in
[  243.807247]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807249] ata3.00: status: { DRDY }
[  243.807253] ata3.00: cmd 60/01:f0:c3:a7:48/00:00:0d:00:00/40 tag 30 ncq 512 in
[  243.807254]          res 40/00:0c:32:dd:80/00:0c:32:dd:80/40 Emask 0x10 (ATA bus error)
[  243.807256] ata3.00: status: { DRDY }
[  243.807263] ata3: hard resetting link
[  244.754966] ata3: SATA link down (SStatus 0 SControl 300)
[  244.760515] ata3: failed to recover some devices, retrying in 5 secs
[  249.770522] ata3: hard resetting link
[  250.090473] ata3: SATA link down (SStatus 0 SControl 300)
[  250.095959] ata3: failed to recover some devices, retrying in 5 secs
[  255.102019] ata3: hard resetting link
[  258.302424] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  258.313816] ata3.00: model number mismatch 'SAMSUNG HD160JJ' != 'WDC WD800JD-00MSA1'
[  258.321667] ata3.00: revalidation failed (errno=-19)
[  258.326702] ata3.00: disabled
[  258.829701] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  258.837959] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  258.845719] Descriptor sense data with sense descriptors (in hex):
[  258.851990]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  258.859257]         32 80 dd 32
[  258.862788] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  258.869777] end_request: I/O error, dev sda, sector 74158474
[  258.875499] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  258.883734] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  258.891452] Descriptor sense data with sense descriptors (in hex):
[  258.897736]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  258.904988]         32 80 dd 32
[  258.908514] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  258.915445] end_request: I/O error, dev sda, sector 109108530
[  258.921347] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  258.929596] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  258.938738] Descriptor sense data with sense descriptors (in hex):
[  258.945029]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  258.952177]         32 80 dd 32
[  258.955668] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  258.962602] end_request: I/O error, dev sda, sector 128220100
[  258.968459] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  258.976692] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  258.984342] Descriptor sense data with sense descriptors (in hex):
[  258.990615]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  258.997775]         32 80 dd 32
[  259.001275] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.008234] end_request: I/O error, dev sda, sector 87688546
[  259.014000] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.022213] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.029871] Descriptor sense data with sense descriptors (in hex):
[  259.036161]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.043310]         32 80 dd 32
[  259.046812] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.053772] end_request: I/O error, dev sda, sector 301726062
[  259.059610] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.067827] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.075477] Descriptor sense data with sense descriptors (in hex):
[  259.081769]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.088917]         32 80 dd 32
[  259.092442] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.099376] end_request: I/O error, dev sda, sector 116535837
[  259.105231] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.113468] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.121118] Descriptor sense data with sense descriptors (in hex):
[  259.127399]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.134539]         32 80 dd 32
[  259.138033] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.144982] end_request: I/O error, dev sda, sector 173048245
[  259.150811] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.159060] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.166525] Descriptor sense data with sense descriptors (in hex):
[  259.172829]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175126]         32 80 dd 32
[  259.175128] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175131] end_request: I/O error, dev sda, sector 278285088
[  259.175139] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175141] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175144] Descriptor sense data with sense descriptors (in hex):
[  259.175146]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175152]         32 80 dd 32
[  259.175155] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175157] end_request: I/O error, dev sda, sector 120644446
[  259.175166] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175168] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175176] Descriptor sense data with sense descriptors (in hex):
[  259.175178]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175184]         32 80 dd 32
[  259.175187] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175189] end_request: I/O error, dev sda, sector 16441263
[  259.175216] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175218] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175221] Descriptor sense data with sense descriptors (in hex):
[  259.175223]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175229]         32 80 dd 32
[  259.175231] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175234] end_request: I/O error, dev sda, sector 309607410
[  259.175259] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175262] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175264] Descriptor sense data with sense descriptors (in hex):
[  259.175266]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175272]         32 80 dd 32
[  259.175274] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175277] end_request: I/O error, dev sda, sector 290603979
[  259.175299] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175301] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175304] Descriptor sense data with sense descriptors (in hex):
[  259.175306]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175311]         32 80 dd 32
[  259.175314] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175317] end_request: I/O error, dev sda, sector 93153075
[  259.175340] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175342] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175345] Descriptor sense data with sense descriptors (in hex):
[  259.175346]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175352]         32 80 dd 32
[  259.175355] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175357] end_request: I/O error, dev sda, sector 264230136
[  259.175389] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175392] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175395] Descriptor sense data with sense descriptors (in hex):
[  259.175396]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175402]         32 80 dd 32
[  259.175404] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175407] end_request: I/O error, dev sda, sector 281175664
[  259.175429] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175432] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175434] Descriptor sense data with sense descriptors (in hex):
[  259.175436]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175442]         32 80 dd 32
[  259.175444] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175447] end_request: I/O error, dev sda, sector 273355384
[  259.175454] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175456] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175459] Descriptor sense data with sense descriptors (in hex):
[  259.175460]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175466]         32 80 dd 32
[  259.175468] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175471] end_request: I/O error, dev sda, sector 249382712
[  259.175494] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175497] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175499] Descriptor sense data with sense descriptors (in hex):
[  259.175501]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175506]         32 80 dd 32
[  259.175509] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175511] end_request: I/O error, dev sda, sector 246721171
[  259.175535] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175538] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175541] Descriptor sense data with sense descriptors (in hex):
[  259.175542]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175548]         32 80 dd 32
[  259.175550] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175553] end_request: I/O error, dev sda, sector 147174948
[  259.175576] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175578] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175581] Descriptor sense data with sense descriptors (in hex):
[  259.175583]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175588]         32 80 dd 32
[  259.175591] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175593] end_request: I/O error, dev sda, sector 290015280
[  259.175616] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175618] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175621] Descriptor sense data with sense descriptors (in hex):
[  259.175622]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175628]         32 80 dd 32
[  259.175630] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175633] end_request: I/O error, dev sda, sector 84892146
[  259.175656] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175658] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175661] Descriptor sense data with sense descriptors (in hex):
[  259.175663]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175668]         32 80 dd 32
[  259.175671] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175673] end_request: I/O error, dev sda, sector 33958143
[  259.175696] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175698] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175701] Descriptor sense data with sense descriptors (in hex):
[  259.175703]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175708]         32 80 dd 32
[  259.175711] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175714] end_request: I/O error, dev sda, sector 280243362
[  259.175736] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175739] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175742] Descriptor sense data with sense descriptors (in hex):
[  259.175743]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175749]         32 80 dd 32
[  259.175751] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175754] end_request: I/O error, dev sda, sector 254500963
[  259.175776] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175779] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175782] Descriptor sense data with sense descriptors (in hex):
[  259.175783]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175789]         32 80 dd 32
[  259.175791] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175794] end_request: I/O error, dev sda, sector 152384484
[  259.175800] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175803] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175805] Descriptor sense data with sense descriptors (in hex):
[  259.175807]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175812]         32 80 dd 32
[  259.175815] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175818] end_request: I/O error, dev sda, sector 31433359
[  259.175842] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175844] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175847] Descriptor sense data with sense descriptors (in hex):
[  259.175849]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175854]         32 80 dd 32
[  259.175857] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175859] end_request: I/O error, dev sda, sector 52045641
[  259.175883] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175885] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175888] Descriptor sense data with sense descriptors (in hex):
[  259.175889]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175895]         32 80 dd 32
[  259.175897] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175900] end_request: I/O error, dev sda, sector 221697763
[  259.175907] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175909] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175912] Descriptor sense data with sense descriptors (in hex):
[  259.175913]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175919]         32 80 dd 32
[  259.175921] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175924] end_request: I/O error, dev sda, sector 276487512
[  259.175947] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175950] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175953] Descriptor sense data with sense descriptors (in hex):
[  259.175954]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.175960]         32 80 dd 32
[  259.175962] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.175965] end_request: I/O error, dev sda, sector 289349559
[  259.175987] sd 2:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
[  259.175990] sd 2:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
[  259.175992] Descriptor sense data with sense descriptors (in hex):
[  259.175994]         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 80 dd
[  259.176000]         32 80 dd 32
[  259.176002] sd 2:0:0:0: [sda] Add. Sense: No additional sense information
[  259.176005] end_request: I/O error, dev sda, sector 222865347
[  259.176030] ata3: EH complete
[  259.191401] ata3.00: detaching (SCSI 2:0:0:0)
[  259.191874] sd 2:0:0:0: [sda] Synchronizing SCSI cache
[  259.191926] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  259.191929] sd 2:0:0:0: [sda] Stopping disk
[  259.191940] sd 2:0:0:0: [sda] START_STOP FAILED
[  259.191941] sd 2:0:0:0: [sda] Result: hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK,SUGGEST_OK
[  291.853710] ata3: exception Emask 0x10 SAct 0x0 SErr 0x1990000 action 0xa frozen
[  291.861246] ata3: SError: { PHYRdyChg 10B8B Dispar LinkSeq TrStaTrns }
[  291.867853] ata3: hard resetting link
[  293.220380] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[  293.228323] ata3.00: ATA-7: WDC WD800JD-00MSA1, 10.01E01, max UDMA/133
[  293.235021] ata3.00: 156301488 sectors, multi 0: LBA48 NCQ (depth 31/32)
[  293.248515] ata3.00: configured for UDMA/133
[  293.252873] ata3: EH complete
[  294.734941] scsi 2:0:0:0: Direct-Access     ATA      WDC WD800JD-00MS 10.0 PQ: 0 ANSI: 5
[  294.743142] ata3: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
[  294.751756] sd 2:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
[  294.758902] sd 2:0:0:0: [sda] Write Protect is off
[  294.763759] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  294.768911] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  294.778158] sd 2:0:0:0: [sda] 156301488 512-byte hardware sectors (80026 MB)
[  294.785335] sd 2:0:0:0: [sda] Write Protect is off
[  294.790179] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  294.795318] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  294.804488]  sda: unknown partition table
[  294.820553] sd 2:0:0:0: [sda] Attached SCSI disk
[  294.826674] sd 2:0:0:0: Attached scsi generic sg0 type 0
[  314.987885] ata3: timeout waiting for ADMA IDLE, stat=0x400
[  314.993556] ata3: timeout waiting for ADMA LEGACY, stat=0x400
[  315.009915] ata3.00: exception Emask 0x10 SAct 0x1 SErr 0x1910000 action 0xa frozen
[  315.017708] ata3.00: ADMA status 0x00000402: , hot unplug
[  315.017714] ata3: SError: { PHYRdyChg Dispar LinkSeq TrStaTrns }
[  315.029239] ata3.00: cmd 60/01:00:92:d7:12/00:00:05:00:00/40 tag 0 ncq 512 in
[  315.029240]          res 40/00:04:92:d7:12/00:04:92:d7:12/40 Emask 0x10 (ATA bus error)
[  315.029243] ata3.00: status: { DRDY }
[  315.048236] ata3: hard resetting link
[  315.774982] ata3: SATA link down (SStatus 0 SControl 300)
[  315.780498] ata3: failed to recover some devices, retrying in 5 secs
[  320.788427] ata3: hard resetting link
[  325.242220] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

--------------060400010704080707020507--
