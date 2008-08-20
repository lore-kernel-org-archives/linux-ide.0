From: Martin Michlmayr <tbm@cyrius.com>
Subject: 2.6.27-rc3: IP: [<ffffffffa0038b77>] init_irq+0x18d/0x31c
	[ide_core]
Date: Wed, 20 Aug 2008 20:31:22 +0300
Message-ID: <20080820173122.GA7335@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:3965 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834AbYHTRbg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 20 Aug 2008 13:31:36 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pcmcia@lists.infradead.org, linux-ide@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I get the following with 2.6.27-rc3 when inserting a CF card into my
PCMCIA slot:

[  144.983810] pccard: PCMCIA card inserted into slot 0
[  144.983942] cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xe0000-0xfffff
[  144.989008] cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
[  144.989008] cs: memory probe 0xa0000000-0xa0ffffff: clean.
[  145.008898] cs: memory probe 0xe0100000-0xe03fffff: excluding 0xe0100000-0xe012ffff
[  145.021508] pcmcia: registering new device pcmcia0.0
[  145.284012] Probing IDE interface ide1...
[  145.576063] hdc: TOSHIBA THNCF512MMA, CFA DISK drive
[  146.248065] BUG: unable to handle kernel NULL pointer dereference at 00000000000000f8
[  146.248065] IP: [<ffffffffa0038b77>] init_irq+0x18d/0x31c [ide_core]
[  146.248065] PGD 7054a067 PUD 7dc17067 PMD 0 
[  146.248065] Oops: 0000 [1] SMP 
[  146.248065] CPU 0 
[  146.248065] Modules linked in: ide_cs(+) i915 drm rfcomm l2cap bluetooth ppdev parport_pc lp parport acpi_cpufreq cpufreq_powersave cpufreq_conservative cpufreq_ondemand cpufreq_stats freq_table cpufreq_userspace ipv6 tun kvm_intel kvm loop firewire_sbp2 firewire_core crc_itu_t arc4 pcmcia ecb snd_hda_intel snd_pcm_oss snd_mixer_oss iwlagn yenta_socket iwlcore pcspkr snd_pcm rsrc_nonstatic rfkill snd_timer pcmcia_core mac80211 psmouse iTCO_wdt snd serio_raw soundcore cfg80211 snd_page_alloc container video output battery ac e1000e wmi intel_agp button evdev joydev ext3 jbd mbcache sha256_generic aes_x86_64 aes_generic cbc dm_crypt crypto_blkcipher dm_mirror dm_log dm_snapshot dm_mod ide_cd_mod cdrom ide_disk ata_generic libata scsi_mod dock piix ide_pci_generic ide_core ehci_hcd uhci_hc
 d thermal processor fan thermal_sys
[  146.248065] Pid: 4080, comm: modprobe Not tainted 2.6.27-rc3-amd64 #1
[  146.248065] RIP: 0010:[<ffffffffa0038b77>]  [<ffffffffa0038b77>] init_irq+0x18d/0x31c [ide_core]
[  146.248065] RSP: 0018:ffff88007058fa08  EFLAGS: 00010282
[  146.248065] RAX: 0000000000000020 RBX: ffff88007298c000 RCX: 0000000000000000
[  146.248065] RDX: 00000000ffffffff RSI: 0000000000001fe0 RDI: ffffffffa004bf60
[  146.248065] RBP: 0000000000000000 R08: ffff88007f007e6b R09: 0000000000000002
[  146.248065] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000000a
[  146.248065] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88007d81fa40
[  146.248065] FS:  00007f5a836d66e0(0000) GS:ffffffff8058ea00(0000) knlGS:0000000000000000
[  146.248065] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  146.248065] CR2: 00000000000000f8 CR3: 0000000072957000 CR4: 00000000000026e0
[  146.248065] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  146.248065] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  146.248065] Process modprobe (pid: 4080, threadinfo ffff88007058e000, task ffff88007ce7c080)
[  146.248065] Stack:  ffff88007d81fa40 0000000000000282 0000000000000000 ffff88007298c000
[  146.248065]  ffff88007298c028 ffff88007298c028 0000000000000000 ffffffffa0039167
[  146.248065]  ffff88007058fb38 ffff88007d81fa40 00000000fffffff4 ffff88007058fb38
[  146.248065] Call Trace:
[  146.248065]  [<ffffffffa0039167>] ide_host_register+0x3c5/0x59e [ide_core]
[  146.248065]  [<ffffffffa0039576>] ide_host_add+0x31/0x54 [ide_core]
[  146.248065]  [<ffffffffa040a1a2>] idecs_register+0x11c/0x19c [ide_cs]
[  146.248065]  [<ffffffffa040a59f>] ide_probe+0x37d/0x47e [ide_cs]
[  146.248065]  [<ffffffffa02eb863>] pcmcia_device_probe+0xc5/0x124 [pcmcia]
[  146.248065]  [<ffffffff8039cc28>] driver_probe_device+0xd0/0x14d
[  146.248065]  [<ffffffff8039cceb>] __driver_attach+0x46/0x6d
[  146.248065]  [<ffffffff8039cca5>] __driver_attach+0x0/0x6d
[  146.248065]  [<ffffffff8039c3cb>] bus_for_each_dev+0x44/0x6f
[  146.248065]  [<ffffffff8039c801>] bus_add_driver+0xb4/0x203
[  146.248065]  [<ffffffff8039cf53>] driver_register+0x8d/0x101
[  146.248065]  [<ffffffffa02ec50e>] pcmcia_register_driver+0xe4/0x11a [pcmcia]
[  146.248065]  [<ffffffffa0025000>] init_ide_cs+0x0/0xc [ide_cs]
[  146.248065]  [<ffffffff8020a042>] do_one_initcall+0x42/0x13b
[  146.248065]  [<ffffffff8025dc37>] sys_init_module+0x18e1/0x1a6f
[  146.248065]  [<ffffffffa02ecf1c>] pcmcia_request_irq+0x0/0x105 [pcmcia]
[  146.248065]  [<ffffffff8020ff2a>] system_call_fastpath+0x16/0x1b
[  146.248065] 
[  146.248065] 
[  146.248065] Code: fe 48 c7 c7 80 c7 04 a0 e8 db b1 1e e0 90 fb 0f 1f 80 00 00 00 00 eb 5c 48 8b 83 48 07 00 00 83 ca ff 48 85 c0 74 0e 48 8b 40 90 <48> 8b 80 d8 00 00 00 8b 50 04 48 8b 3d 68 36 4f e0 be d0 80 00 
[  146.248065] RIP  [<ffffffffa0038b77>] init_irq+0x18d/0x31c [ide_core]
[  146.248065]  RSP <ffff88007058fa08>
[  146.248065] CR2: 00000000000000f8
[  146.248065] ---[ end trace 979ea53cfe9f0f60 ]---

Complete dmesg is attached.
-- 
Martin Michlmayr
http://www.cyrius.com/

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.6.27-rc3-amd64"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.27-rc3-amd64 (Debian 2.6.27~rc3-1~experimental.1~snapshot.12084) (waldi@debian.org) (gcc version 4.1.3 20080623 (prerelease) (Debian 4.1.2-23+1)) #1 SMP Tue Aug 19 07:44:44 UTC 2008
[    0.000000] Command line: root=/dev/mapper/lucky-root ro vga=791
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000007f7b0000 (usable)
[    0.000000]  BIOS-e820: 000000007f7b0000 - 000000007f7c5400 (reserved)
[    0.000000]  BIOS-e820: 000000007f7c5400 - 000000007f7e7fb8 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000007f7e7fb8 - 0000000080000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed20000 - 00000000fed9a000 (reserved)
[    0.000000]  BIOS-e820: 00000000feda0000 - 00000000fedc0000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffb00000 - 00000000ffc00000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
[    0.000000] last_pfn = 0x7f7b0 max_arch_pfn = 0x3ffffffff
[    0.000000] init_memory_mapping
[    0.000000]  0000000000 - 007f600000 page 2M
[    0.000000]  007f600000 - 007f7b0000 page 4k
[    0.000000] kernel direct mapping tables up to 7f7b0000 @ 8000-c000
[    0.000000] last_map_addr: 7f7b0000 end: 7f7b0000
[    0.000000] RAMDISK: 3788a000 - 37fef83d
[    0.000000] DMI 2.4 present.
[    0.000000] ACPI: RSDP 000F77A0, 0024 (r2 HP    )
[    0.000000] ACPI: XSDT 7F7C81C4, 0074 (r1 HPQOEM SLIC-MPC        1 HP          1)
[    0.000000] ACPI: FACP 7F7C8084, 00F4 (r4 HP     30C9            3 HP          1)
[    0.000000] ACPI: DSDT 7F7C84C0, 13484 (r1 HP       nc2500    10000 MSFT  3000001)
[    0.000000] ACPI: FACS 7F7E7D80, 0040
[    0.000000] ACPI: SLIC 7F7C8238, 0176 (r1 HPQOEM SLIC-MPC        1 HP          1)
[    0.000000] ACPI: HPET 7F7C83B0, 0038 (r1 HP     30C9            1 HP          1)
[    0.000000] ACPI: APIC 7F7C83E8, 0068 (r1 HP     30C9            1 HP          1)
[    0.000000] ACPI: MCFG 7F7C8450, 003C (r1 HP     30C9            1 HP          1)
[    0.000000] ACPI: TCPA 7F7C848C, 0032 (r2 HP     30C9            1 HP          1)
[    0.000000] ACPI: SSDT 7F7DB944, 02BE (r1 HP       HPQPAT        1 MSFT  3000001)
[    0.000000] ACPI: SSDT 7F7DC586, 025F (r1 HP      Cpu0Tst     3000 INTL 20060317)
[    0.000000] ACPI: SSDT 7F7DC7E5, 00A6 (r1 HP      Cpu1Tst     3000 INTL 20060317)
[    0.000000] ACPI: SSDT 7F7DC88B, 04D7 (r1 HP        CpuPm     3000 INTL 20060317)
[    0.000000] ACPI: DMI detected: Hewlett-Packard
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at 0000000000000000-000000007f7b0000
[    0.000000] Bootmem setup node 0 0000000000000000-000000007f7b0000
[    0.000000]   NODE_DATA [0000000000001000 - 0000000000005fff]
[    0.000000]   bootmap [000000000000a000 -  0000000000019ef7] pages 10
[    0.000000] (6 early reservations) ==> bootmem [0000000000 - 007f7b0000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0000006000 - 0000008000]       TRAMPOLINE ==> [0000006000 - 0000008000]
[    0.000000]   #2 [0000200000 - 0000709298]    TEXT DATA BSS ==> [0000200000 - 0000709298]
[    0.000000]   #3 [003788a000 - 0037fef83d]          RAMDISK ==> [003788a000 - 0037fef83d]
[    0.000000]   #4 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #5 [0000008000 - 000000a000]          PGTABLE ==> [0000008000 - 000000a000]
[    0.000000]  [ffffe20000000000-ffffe20001bfffff] PMD -> [ffff880001200000-ffff880002dfffff] on node 0
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00100000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0007f7b0
[    0.000000] On node 0 totalpages: 522063
[    0.000000]   DMA zone: 2553 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 510981 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 0, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] SMP: Allowing 2 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: 000000000009f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
[    0.000000] PERCPU: Allocating 56616 bytes of per cpu data
[    0.000000] NR_CPUS: 32, nr_cpu_ids: 2, nr_node_ids 1
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 513534
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=/dev/mapper/lucky-root ro vga=791
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Extended CMOS year: 2000
[    0.000000] TSC calibrated against PM_TIMER
[    0.000000] Detected 1196.998 MHz processor.
[    0.004000] Console: colour dummy device 80x25
[    0.004000] console [tty0] enabled
[    0.004000] Checking aperture...
[    0.004000] No AGP bridge found
[    0.004000] Calgary: detecting Calgary via BIOS EBDA area
[    0.004000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.004000] Memory: 2046560k/2088640k available (2335k kernel code, 41692k reserved, 1143k data, 488k init)
[    0.004000] CPA: page pool initialized 1 of 1 pages preallocated
[    0.004000] hpet clockevent registered
[    0.004000] Calibrating delay loop (skipped), value calculated using timer frequency.. 2393.99 BogoMIPS (lpj=4787992)
[    0.004000] Security Framework initialized
[    0.004000] SELinux:  Disabled at boot.
[    0.004000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.004000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.004000] Mount-cache hash table entries: 256
[    0.004000] Initializing cgroup subsys ns
[    0.004000] Initializing cgroup subsys cpuacct
[    0.004000] Initializing cgroup subsys devices
[    0.004000] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.004000] CPU: L2 cache: 2048K
[    0.004000] CPU 0/0 -> Node 0
[    0.004000] CPU: Physical Processor ID: 0
[    0.004000] CPU: Processor Core ID: 0
[    0.004000] CPU0: Thermal monitoring handled by SMI
[    0.004000] using mwait in idle threads.
[    0.008000] ACPI: Core revision 20080609
[    0.044002] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.084005] CPU0: Intel(R) Core(TM)2 Duo CPU     U7600  @ 1.20GHz stepping 0d
[    0.084005] Using local APIC timer interrupts.
[    0.088005] APIC timer calibration result 8312496
[    0.088005] Detected 8.312 MHz APIC timer.
[    0.088005] Booting processor 1/1 ip 6000
[    0.096006] Initializing CPU#1
[    0.096006] Calibrating delay using timer specific routine.. 2393.99 BogoMIPS (lpj=4787981)
[    0.096006] CPU: L1 I cache: 32K, L1 D cache: 32K
[    0.096006] CPU: L2 cache: 2048K
[    0.096006] CPU 1/1 -> Node 0
[    0.096006] CPU: Physical Processor ID: 0
[    0.096006] CPU: Processor Core ID: 1
[    0.096006] CPU1: Thermal monitoring enabled (TM2)
[    0.176011] CPU1: Intel(R) Core(TM)2 Duo CPU     U7600  @ 1.20GHz stepping 0d
[    0.176011] checking TSC synchronization [CPU#0 -> CPU#1]: passed.
[    0.180011] Brought up 2 CPUs
[    0.180011] Total of 2 processors activated (4787.98 BogoMIPS).
[    0.180011] CPU0 attaching sched-domain:
[    0.180011]  domain 0: span 0-1 level MC
[    0.180011]   groups: 0 1
[    0.180011]   domain 1: span 0-1 level NODE
[    0.180011]    groups: 0-1
[    0.180011] CPU1 attaching sched-domain:
[    0.180011]  domain 0: span 0-1 level MC
[    0.180011]   groups: 1 0
[    0.180011]   domain 1: span 0-1 level NODE
[    0.180011]    groups: 0-1
[    0.180011] net_namespace: 1552 bytes
[    0.180011] Booting paravirtualized kernel on bare hardware
[    0.180011] NET: Registered protocol family 16
[    0.180011] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.180011] ACPI: bus type pci registered
[    0.180011] PCI: MCFG configuration 0: base f8000000 segment 0 buses 0 - 63
[    0.180011] PCI: Not using MMCONFIG.
[    0.180011] PCI: Using configuration type 1 for base access
[    0.184011] ACPI: EC: Look up EC in DSDT
[    0.185761] ACPI: EC: non-query interrupt received, switching to interrupt mode
[    0.292018] ACPI: Interpreter enabled
[    0.292018] ACPI: (supports S0 S3 S4 S5)
[    0.292018] ACPI: Using IOAPIC for interrupt routing
[    0.292018] PCI: MCFG configuration 0: base f8000000 segment 0 buses 0 - 63
[    0.304019] PCI: MCFG area at f8000000 reserved in ACPI motherboard resources
[    0.308019] PCI: Using MMCONFIG at f8000000 - fbffffff
[    0.332020] ACPI: EC: GPE = 0x16, I/O: command/status = 0x66, data = 0x62
[    0.332020] ACPI: EC: driver started in interrupt mode
[    0.332020] ACPI: PCI Root Bridge [C003] (0000:00)
[    0.332020] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    0.332020] pci 0000:00:19.0: PME# disabled
[    0.332020] pci 0000:00:1a.7: PME# supported from D0 D3hot D3cold
[    0.332020] pci 0000:00:1a.7: PME# disabled
[    0.332020] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.332020] pci 0000:00:1b.0: PME# disabled
[    0.332020] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.332020] pci 0000:00:1c.0: PME# disabled
[    0.332020] pci 0000:00:1c.1: PME# supported from D0 D3hot D3cold
[    0.332020] pci 0000:00:1c.1: PME# disabled
[    0.332020] pci 0000:00:1d.7: PME# supported from D0 D3hot D3cold
[    0.332020] pci 0000:00:1d.7: PME# disabled
[    0.332020] pci 0000:00:1f.0: quirk: region 1000-107f claimed by ICH6 ACPI/GPIO/TCO
[    0.332020] pci 0000:00:1f.0: quirk: region 1100-113f claimed by ICH6 GPIO
[    0.332020] pci 0000:10:00.0: PME# supported from D0 D3hot D3cold
[    0.332020] pci 0000:10:00.0: PME# disabled
[    0.332020] pci 0000:02:06.0: supports D1
[    0.332020] pci 0000:02:06.0: supports D2
[    0.332020] pci 0000:02:06.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.332020] pci 0000:02:06.0: PME# disabled
[    0.332020] pci 0000:02:06.1: supports D1
[    0.332020] pci 0000:02:06.1: supports D2
[    0.332020] pci 0000:02:06.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.332020] pci 0000:02:06.1: PME# disabled
[    0.332020] pci 0000:02:06.2: supports D1
[    0.332020] pci 0000:02:06.2: supports D2
[    0.332020] pci 0000:02:06.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.332020] pci 0000:02:06.2: PME# disabled
[    0.332020] pci 0000:02:06.3: supports D1
[    0.332020] pci 0000:02:06.3: supports D2
[    0.332020] pci 0000:02:06.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.332020] pci 0000:02:06.3: PME# disabled
[    0.332020] pci 0000:00:1e.0: transparent bridge
[    0.332020] ACPI: PCI Interrupt Routing Table [\_SB_.C003._PRT]
[    0.336021] ACPI: PCI Interrupt Routing Table [\_SB_.C003.C0B2._PRT]
[    0.336021] ACPI: PCI Interrupt Routing Table [\_SB_.C003.C11F._PRT]
[    0.336021] ACPI: PCI Interrupt Routing Table [\_SB_.C003.C133._PRT]
[    0.416026] ACPI: PCI Interrupt Link [C12F] (IRQs *10 11)
[    0.416026] ACPI: PCI Interrupt Link [C130] (IRQs *10 11)
[    0.416026] ACPI: PCI Interrupt Link [C131] (IRQs 10 *11)
[    0.416026] ACPI: PCI Interrupt Link [C132] (IRQs 10 11) *5
[    0.416026] ACPI: PCI Interrupt Link [C142] (IRQs *10 11)
[    0.416026] ACPI: PCI Interrupt Link [C143] (IRQs 10 11) *0, disabled.
[    0.420026] ACPI: PCI Interrupt Link [C144] (IRQs 10 *11)
[    0.420026] ACPI Exception (pci_link-0189): AE_NOT_FOUND, Evaluating _PRS [20080609]
[    0.420026] ACPI: Power Resource [C29F] (on)
[    0.420026] ACPI: Power Resource [C1C7] (off)
[    0.420026] ACPI: Power Resource [C3AD] (off)
[    0.420026] ACPI: Power Resource [C3B0] (off)
[    0.420026] ACPI: Power Resource [C3C3] (off)
[    0.420026] ACPI: Power Resource [C3C4] (off)
[    0.420026] ACPI: Power Resource [C3C5] (off)
[    0.420026] ACPI: Power Resource [C3C6] (off)
[    0.420026] ACPI: Power Resource [C3C7] (off)
[    0.420026] Linux Plug and Play Support v0.97 (c) Adam Belay
[    0.420026] pnp: PnP ACPI init
[    0.420026] ACPI: bus type pnp registered
[    0.420026] pnp 00:00: parse allocated resources
[    0.420026] pnp 00:00:   add mem 0x0-0x9ffff flags 0x1
[    0.420026] pnp 00:00:   add mem 0xe0000-0xfffff flags 0x0
[    0.420026] pnp 00:00:   add mem 0x100000-0x7f7fffff flags 0x1
[    0.420026] pnp 00:00: PNP0c01: calling quirk_system_pci_resources+0x0/0x182
[    0.420026] pnp 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.420026] pnp 00:01: parse allocated resources
[    0.428026] pnp 00:01:   add io  0xcf8-0xcff flags 0x1
[    0.428026] pnp 00:01: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.432027] pnp 00:02: parse allocated resources
[    0.432027] pnp 00:02:   add io  0x560-0x56f flags 0x1
[    0.432027] pnp 00:02:   add io  0x570-0x57f flags 0x1
[    0.432027] pnp 00:02:   add mem 0xfed40000-0xfed44fff flags 0x1
[    0.432027] pnp 00:02: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
[    0.432027] pnp 00:03: parse allocated resources
[    0.432027] pnp 00:03:   add io  0xf0-0xff flags 0x1
[    0.432027] pnp 00:03:   add irq 13 flags 0x1
[    0.432027] pnp 00:03: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.432027] pnp 00:04: parse allocated resources
[    0.432027] pnp 00:04:   add io  0x0-0xf flags 0x1
[    0.432027] pnp 00:04:   add io  0x80-0x8f flags 0x1
[    0.432027] pnp 00:04:   add io  0xc0-0xdf flags 0x1
[    0.432027] pnp 00:04:   add dma 4 flags 0x2
[    0.432027] pnp 00:04: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.432027] pnp 00:05: parse allocated resources
[    0.432027] pnp 00:05:   add io  0x61-0x61 flags 0x1
[    0.432027] pnp 00:05: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.432027] pnp 00:06: parse allocated resources
[    0.432027] pnp 00:06:   add io  0x70-0x71 flags 0x1
[    0.432027] pnp 00:06:   add io  0x72-0x73 flags 0x1
[    0.432027] pnp 00:06:   add irq 8 flags 0x1
[    0.432027] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.432027] pnp 00:07: parse allocated resources
[    0.432027] pnp 00:07:   add mem 0xfed00000-0xfed003ff flags 0x0
[    0.432027] pnp 00:07: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.432027] pnp 00:08: parse allocated resources
[    0.432027] pnp 00:08:   add io  0x60-0x60 flags 0x1
[    0.432027] pnp 00:08:   add io  0x64-0x64 flags 0x1
[    0.432027] pnp 00:08:   add irq 1 flags 0x1
[    0.432027] pnp 00:08: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.432027] pnp 00:09: parse allocated resources
[    0.432027] pnp 00:09:   add irq 12 flags 0x1
[    0.432027] pnp 00:09: Plug and Play ACPI device, IDs SYN0130 SYN0100 SYN0002 PNP0f13 (active)
[    0.432027] pnp 00:0a: parse allocated resources
[    0.432027] pnp 00:0a:   add io  0x10-0x1f flags 0x1
[    0.432027] pnp 00:0a:   add io  0x24-0x3f flags 0x1
[    0.432027] pnp 00:0a:   add io  0x4e-0x4f flags 0x1
[    0.432027] pnp 00:0a:   add io  0x50-0x53 flags 0x1
[    0.432027] pnp 00:0a:   add io  0x63-0x63 flags 0x1
[    0.432027] pnp 00:0a:   add io  0x65-0x65 flags 0x1
[    0.432027] pnp 00:0a:   add io  0x67-0x67 flags 0x1
[    0.432027] pnp 00:0a:   add io  0x74-0x77 flags 0x1
[    0.432027] pnp 00:0a:   add io  0x90-0x9f flags 0x1
[    0.432027] pnp 00:0a:   add io  0xa4-0xbd flags 0x1
[    0.432027] pnp 00:0a:   add io  0x500-0x55f flags 0x1
[    0.432027] pnp 00:0a:   add io  0x800-0x80f flags 0x1
[    0.432027] pnp 00:0a:   add mem 0xffb00000-0xffbfffff flags 0x0
[    0.432027] pnp 00:0a:   add mem 0xfff00000-0xffffffff flags 0x0
[    0.432027] pnp 00:0a: PNP0c02: calling quirk_system_pci_resources+0x0/0x182
[    0.432027] pnp 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.436027] pnp 00:0b: parse allocated resources
[    0.436027] pnp 00:0b:   add irq 23 flags 0x1
[    0.436027] pnp 00:0b: Plug and Play ACPI device, IDs HPQ0004 (active)
[    0.436027] pnp 00:0c: parse allocated resources
[    0.436027] pnp 00:0c:   add io  0x4d0-0x4d1 flags 0x1
[    0.436027] pnp 00:0c:   add io  0x2f8-0x2ff flags 0x1
[    0.436027] pnp 00:0c:   add io  0x3f8-0x3ff flags 0x1
[    0.436027] pnp 00:0c:   add io  0x1000-0x107f flags 0x1
[    0.436027] pnp 00:0c:   add io  0x1100-0x113f flags 0x1
[    0.436027] pnp 00:0c:   add io  0x1200-0x121f flags 0x1
[    0.436027] pnp 00:0c:   add mem 0xf8000000-0xfbffffff flags 0x1
[    0.436027] pnp 00:0c:   add mem 0xfec00000-0xfec000ff flags 0x1
[    0.436027] pnp 00:0c:   add mem 0xfed20000-0xfed3ffff flags 0x1
[    0.436027] pnp 00:0c:   add mem 0xfed45000-0xfed8ffff flags 0x1
[    0.436027] pnp 00:0c:   add mem 0xfed90000-0xfed99fff flags 0x1
[    0.436027] pnp 00:0c: PNP0c02: calling quirk_system_pci_resources+0x0/0x182
[    0.436027] pnp 00:0c: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.436027] pnp 00:0d: parse allocated resources
[    0.440027] pnp 00:0d:   add mem 0xcee00-0xcffff flags 0x0
[    0.440027] pnp 00:0d:   add mem 0xd2000-0xd3fff flags 0x0
[    0.440027] pnp 00:0d:   add mem 0xfeda0000-0xfedbffff flags 0x1
[    0.440027] pnp 00:0d:   add mem 0xfee00000-0xfee00fff flags 0x1
[    0.440027] pnp 00:0d: PNP0c02: calling quirk_system_pci_resources+0x0/0x182
[    0.440027] pnp 00:0d: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.440027] pnp: PnP ACPI: found 14 devices
[    0.440027] ACPI: ACPI bus type pnp unregistered
[    0.440027] usbcore: registered new interface driver usbfs
[    0.440027] usbcore: registered new interface driver hub
[    0.440027] usbcore: registered new device driver usb
[    0.440027] PCI: Using ACPI for IRQ routing
[    0.460028] PCI-GART: No AMD northbridge found.
[    0.460028] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.460028] hpet0: 3 64-bit timers, 14318180 Hz
[    0.460028] ACPI: RTC can wake from S4
[    0.476029] pnp: the driver 'system' has been registered
[    0.476029] system 00:00: iomem range 0x0-0x9ffff could not be reserved
[    0.476029] system 00:00: iomem range 0xe0000-0xfffff could not be reserved
[    0.476029] system 00:00: iomem range 0x100000-0x7f7fffff could not be reserved
[    0.476029] system 00:00: driver attached
[    0.476029] system 00:0a: ioport range 0x500-0x55f has been reserved
[    0.476029] system 00:0a: ioport range 0x800-0x80f has been reserved
[    0.476029] system 00:0a: iomem range 0xffb00000-0xffbfffff could not be reserved
[    0.476029] system 00:0a: iomem range 0xfff00000-0xffffffff could not be reserved
[    0.476029] system 00:0a: driver attached
[    0.476029] system 00:0c: ioport range 0x4d0-0x4d1 has been reserved
[    0.476029] system 00:0c: ioport range 0x2f8-0x2ff has been reserved
[    0.476029] system 00:0c: ioport range 0x3f8-0x3ff has been reserved
[    0.476029] system 00:0c: ioport range 0x1000-0x107f has been reserved
[    0.476029] system 00:0c: ioport range 0x1100-0x113f has been reserved
[    0.476029] system 00:0c: ioport range 0x1200-0x121f has been reserved
[    0.476029] system 00:0c: iomem range 0xf8000000-0xfbffffff has been reserved
[    0.476029] system 00:0c: iomem range 0xfec00000-0xfec000ff could not be reserved
[    0.476029] system 00:0c: iomem range 0xfed20000-0xfed3ffff could not be reserved
[    0.476029] system 00:0c: iomem range 0xfed45000-0xfed8ffff could not be reserved
[    0.476029] system 00:0c: iomem range 0xfed90000-0xfed99fff could not be reserved
[    0.476029] system 00:0c: driver attached
[    0.476029] system 00:0d: iomem range 0xcee00-0xcffff has been reserved
[    0.476029] system 00:0d: iomem range 0xd2000-0xd3fff has been reserved
[    0.476029] system 00:0d: iomem range 0xfeda0000-0xfedbffff could not be reserved
[    0.476029] system 00:0d: iomem range 0xfee00000-0xfee00fff could not be reserved
[    0.476029] system 00:0d: driver attached
[    0.476735] pci 0000:02:06.0: BAR 9 too large: 0x00000000000000-0x00000003ffffff
[    0.476735] pci 0000:00:1c.0: PCI bridge, secondary bus 0000:08
[    0.476735] pci 0000:00:1c.0:   IO window: disabled
[    0.476735] pci 0000:00:1c.0:   MEM window: disabled
[    0.476735] pci 0000:00:1c.0:   PREFETCH window: disabled
[    0.476735] pci 0000:00:1c.1: PCI bridge, secondary bus 0000:10
[    0.476735] pci 0000:00:1c.1:   IO window: disabled
[    0.476735] pci 0000:00:1c.1:   MEM window: 0xe0000000-0xe00fffff
[    0.476735] pci 0000:00:1c.1:   PREFETCH window: disabled
[    0.476735] pci 0000:02:06.0: CardBus bridge, secondary bus 0000:03
[    0.476735] pci 0000:02:06.0:   IO window: 0x003000-0x0030ff
[    0.476735] pci 0000:02:06.0:   IO window: 0x003400-0x0034ff
[    0.476735] pci 0000:02:06.0:   MEM window: 0x88000000-0x8bffffff
[    0.476735] pci 0000:00:1e.0: PCI bridge, secondary bus 0000:02
[    0.476735] pci 0000:00:1e.0:   IO window: 0x3000-0x3fff
[    0.476735] pci 0000:00:1e.0:   MEM window: 0xe0100000-0xe03fffff
[    0.476735] pci 0000:00:1e.0:   PREFETCH window: disabled
[    0.476735] pci 0000:00:1c.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    0.476735] pci 0000:00:1c.0: setting latency timer to 64
[    0.476735] pci 0000:00:1c.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    0.476735] pci 0000:00:1c.1: setting latency timer to 64
[    0.476735] pci 0000:00:1e.0: setting latency timer to 64
[    0.476735] pci 0000:02:06.0: PCI INT A -> GSI 18 (level, low) -> IRQ 18
[    0.476735] NET: Registered protocol family 2
[    0.504027] Switched to high resolution mode on CPU 1
[    0.508028] Switched to high resolution mode on CPU 0
[    0.524002] IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.524002] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[    0.528021] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.528021] TCP: Hash tables configured (established 262144 bind 65536)
[    0.528021] TCP reno registered
[    0.540002] NET: Registered protocol family 1
[    0.540002] checking if image is initramfs... it is
[    1.571849] Freeing initrd memory: 7574k freed
[    1.580136] audit: initializing netlink socket (disabled)
[    1.580136] type=2000 audit(1219169759.576:1): initialized
[    1.580136] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.580136] VFS: Disk quotas dquot_6.5.1
[    1.580183] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.580303] msgmni has been set to 4011
[    1.581003] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[    1.581003] io scheduler noop registered
[    1.581003] io scheduler anticipatory registered
[    1.581003] io scheduler deadline registered
[    1.581003] io scheduler cfq registered (default)
[    1.581003] pci 0000:00:02.0: Boot video device
[    1.581003] pcieport-driver 0000:00:1c.0: setting latency timer to 64
[    1.581003] pcieport-driver 0000:00:1c.0: found MSI capability
[    1.581003] pci_express 0000:00:1c.0:pcie00: allocate port service
[    1.581003] pci_express 0000:00:1c.0:pcie03: allocate port service
[    1.581003] pcieport-driver 0000:00:1c.1: setting latency timer to 64
[    1.581003] pcieport-driver 0000:00:1c.1: found MSI capability
[    1.581003] pci_express 0000:00:1c.1:pcie00: allocate port service
[    1.581003] pci_express 0000:00:1c.1:pcie03: allocate port service
[    1.581003] vesafb: framebuffer at 0xd0000000, mapped to 0xffffc20004980000, using 3072k, total 7616k
[    1.581003] vesafb: mode is 1024x768x16, linelength=2048, pages=3
[    1.581003] vesafb: scrolling: redraw
[    1.581003] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    1.601001] Console: switching to colour frame buffer device 128x48
[    1.621001] fb0: VESA VGA frame buffer device
[    1.625003] hpet_resources: 0xfed00000 is busy
[    1.625003] Linux agpgart interface v0.103
[    1.625003] Serial: 8250/16550 driver4 ports, IRQ sharing enabled
[    1.625003] pnp: the driver 'serial' has been registered
[    1.629003] brd: module loaded
[    1.629003] input: Macintosh mouse button emulation as /class/input/input0
[    1.629003] pnp: the driver 'i8042 kbd' has been registered
[    1.629003] i8042 kbd 00:08: driver attached
[    1.629003] pnp: the driver 'i8042 aux' has been registered
[    1.629003] i8042 aux 00:09: driver attached
[    1.629003] PNP: PS/2 Controller [PNP0303:C29C,PNP0f13:C29D] at 0x60,0x64 irq 1,12
[    1.632685] i8042.c: Detected active multiplexing controller, rev 1.1.
[    1.633180] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.633180] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    1.633180] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    1.633180] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    1.633180] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    1.645002] mice: PS/2 mouse device common for all mice
[    1.645002] cpuidle: using governor ladder
[    1.645002] cpuidle: using governor menu
[    1.645002] No iBFT detected.
[    1.645002] TCP cubic registered
[    1.645002] NET: Registered protocol family 17
[    1.645002] registered taskstats version 1
[    1.645002] Freeing unused kernel memory: 488k freed
[    1.665004] input: AT Translated Set 2 keyboard as /class/input/input1
[    1.924432] ACPI: Transitioning device [C3B1] to D3
[    1.928898] fan PNP0C0B:00: registered as cooling_device0
[    1.933037] ACPI: Fan [C3B1] (off)
[    1.937193] ACPI: Transitioning device [C3B2] to D3
[    1.941834] fan PNP0C0B:01: registered as cooling_device1
[    1.945988] ACPI: Fan [C3B2] (off)
[    1.951032] ACPI: Transitioning device [C3C8] to D3
[    1.956499] fan PNP0C0B:02: registered as cooling_device2
[    1.960508] ACPI: Fan [C3C8] (off)
[    1.965917] ACPI: Transitioning device [C3C9] to D3
[    1.972224] fan PNP0C0B:03: registered as cooling_device3
[    1.976234] ACPI: Fan [C3C9] (off)
[    1.982104] ACPI: Transitioning device [C3CA] to D3
[    1.988356] fan PNP0C0B:04: registered as cooling_device4
[    1.993222] ACPI: Fan [C3CA] (off)
[    1.999531] ACPI: Transitioning device [C3CB] to D3
[    2.005371] fan PNP0C0B:05: registered as cooling_device5
[    2.011668] ACPI: Fan [C3CB] (off)
[    2.018361] ACPI: Transitioning device [C3CC] to D3
[    2.024419] fan PNP0C0B:06: registered as cooling_device6
[    2.030867] ACPI: Fan [C3CC] (off)
[    2.048940] ACPI: SSDT 7F7DBCCA, 023D (r1 HP      Cpu0Ist     3000 INTL 20060317)
[    2.056438] ACPI: SSDT 7F7DBF8C, 05FA (r1 HP      Cpu0Cst     3001 INTL 20060317)
[    2.068002] Monitor-Mwait will be used to enter C-1 state
[    2.068002] Monitor-Mwait will be used to enter C-2 state
[    2.069003] ACPI: CPU0 (power states: C1[C1] C2[C2])
[    2.075421] processor ACPI0007:00: registered as cooling_device7
[    2.082272] ACPI: Processor [CPU0] (supports 8 throttling states)
[    2.089592] ACPI: SSDT 7F7DBC02, 00C8 (r1 HP      Cpu1Ist     3000 INTL 20060317)
[    2.096936] ACPI: SSDT 7F7DBF07, 0085 (r1 HP      Cpu1Cst     3000 INTL 20060317)
[    2.105002] Marking TSC unstable due to TSC halts in idle
[    2.115432] ACPI: CPU1 (power states: C1[C1] C2[C2])
[    2.121682] processor ACPI0007:01: registered as cooling_device8
[    2.122679] ACPI: Processor [CPU1] (supports 8 throttling states)
[    2.141466] thermal LNXTHERM:01: registered as thermal_zone0
[    2.148446] ACPI: Thermal Zone [TZ6] (25 C)
[    2.172010] thermal LNXTHERM:02: registered as thermal_zone1
[    2.194487] ACPI: Thermal Zone [TZ0] (71 C)
[    2.208095] thermal LNXTHERM:03: registered as thermal_zone2
[    2.213903] ACPI: Thermal Zone [TZ1] (76 C)
[    2.231215] thermal LNXTHERM:04: registered as thermal_zone3
[    2.237011] ACPI: Thermal Zone [TZ3] (62 C)
[    2.258945] thermal LNXTHERM:05: registered as thermal_zone4
[    2.281390] ACPI: Thermal Zone [TZ4] (44 C)
[    2.291011] thermal LNXTHERM:06: registered as thermal_zone5
[    2.307021] ACPI: Thermal Zone [TZ5] (83 C)
[    2.796007] USB Universal Host Controller Interface driver v3.0
[    2.801072] uhci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.811998] uhci_hcd 0000:00:1a.0: setting latency timer to 64
[    2.811998] uhci_hcd 0000:00:1a.0: UHCI Host Controller
[    2.819465] uhci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    2.827003] uhci_hcd 0000:00:1a.0: irq 16, io base 0x00002040
[    2.834415] usb usb1: configuration #1 chosen from 1 choice
[    2.842104] hub 1-0:1.0: USB hub found
[    2.849370] hub 1-0:1.0: 2 ports detected
[    2.962131] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    2.969008] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    2.976717] usb usb1: Product: UHCI Host Controller
[    2.980204] usb usb1: Manufacturer: Linux 2.6.27-rc3-amd64 uhci_hcd
[    2.987874] usb usb1: SerialNumber: 0000:00:1a.0
[    3.000005] uhci_hcd 0000:00:1a.1: PCI INT B -> GSI 17 (level, low) -> IRQ 17
[    3.006786] uhci_hcd 0000:00:1a.1: setting latency timer to 64
[    3.006786] uhci_hcd 0000:00:1a.1: UHCI Host Controller
[    3.014631] uhci_hcd 0000:00:1a.1: new USB bus registered, assigned bus number 2
[    3.022198] uhci_hcd 0000:00:1a.1: irq 17, io base 0x00002060
[    3.029775] usb usb2: configuration #1 chosen from 1 choice
[    3.037238] hub 2-0:1.0: USB hub found
[    3.044734] hub 2-0:1.0: 2 ports detected
[    3.052402] Uniform Multi-Platform E-IDE driver
[    3.158137] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    3.165009] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.176022] usb usb2: Product: UHCI Host Controller
[    3.180302] usb usb2: Manufacturer: Linux 2.6.27-rc3-amd64 uhci_hcd
[    3.184031] usb usb2: SerialNumber: 0000:00:1a.1
[    3.200263] uhci_hcd 0000:00:1d.0: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    3.205031] uhci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.205058] uhci_hcd 0000:00:1d.0: UHCI Host Controller
[    3.213032] uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 3
[    3.224021] uhci_hcd 0000:00:1d.0: irq 20, io base 0x00002080
[    3.232022] usb usb3: configuration #1 chosen from 1 choice
[    3.240021] hub 3-0:1.0: USB hub found
[    3.245570] hub 3-0:1.0: 2 ports detected
[    3.359105] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001
[    3.364052] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.368287] usb usb3: Product: UHCI Host Controller
[    3.376117] usb usb3: Manufacturer: Linux 2.6.27-rc3-amd64 uhci_hcd
[    3.384045] usb usb3: SerialNumber: 0000:00:1d.0
[    3.399770] ehci_hcd 0000:00:1a.7: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    3.403481] ehci_hcd 0000:00:1a.7: setting latency timer to 64
[    3.407466] ehci_hcd 0000:00:1a.7: EHCI Host Controller
[    3.414841] ehci_hcd 0000:00:1a.7: new USB bus registered, assigned bus number 4
[    3.422549] ehci_hcd 0000:00:1a.7: debug port 1
[    3.429021] ehci_hcd 0000:00:1a.7: cache line size of 32 is not supported
[    3.433426] ehci_hcd 0000:00:1a.7: irq 18, io mem 0xe0621000
[    3.453608] ehci_hcd 0000:00:1a.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    3.456302] usb usb4: configuration #1 chosen from 1 choice
[    3.470461] hub 4-0:1.0: USB hub found
[    3.475168] hub 4-0:1.0: 4 ports detected
[    3.502536] Clocksource tsc unstable (delta = -129407064 ns)
[    3.584694] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002
[    3.588476] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.595894] usb usb4: Product: EHCI Host Controller
[    3.607235] usb usb4: Manufacturer: Linux 2.6.27-rc3-amd64 ehci_hcd
[    3.614589] usb usb4: SerialNumber: 0000:00:1a.7
[    3.622046] uhci_hcd 0000:00:1d.1: PCI INT B -> GSI 22 (level, low) -> IRQ 22
[    3.629655] uhci_hcd 0000:00:1d.1: setting latency timer to 64
[    3.629655] uhci_hcd 0000:00:1d.1: UHCI Host Controller
[    3.637159] uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 5
[    3.648021] uhci_hcd 0000:00:1d.1: irq 22, io base 0x000020a0
[    3.648555] usb usb5: configuration #1 chosen from 1 choice
[    3.663165] hub 5-0:1.0: USB hub found
[    3.667547] hub 5-0:1.0: 2 ports detected
[    3.779773] usb usb5: New USB device found, idVendor=1d6b, idProduct=0001
[    3.783061] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.791878] usb usb5: Product: UHCI Host Controller
[    3.799577] usb usb5: Manufacturer: Linux 2.6.27-rc3-amd64 uhci_hcd
[    3.807244] usb usb5: SerialNumber: 0000:00:1d.1
[    3.819609] uhci_hcd 0000:00:1d.2: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    3.822602] uhci_hcd 0000:00:1d.2: setting latency timer to 64
[    3.822602] uhci_hcd 0000:00:1d.2: UHCI Host Controller
[    3.834486] uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 6
[    3.841938] uhci_hcd 0000:00:1d.2: irq 18, io base 0x000020c0
[    3.849344] usb usb6: configuration #1 chosen from 1 choice
[    3.856710] hub 6-0:1.0: USB hub found
[    3.860001] hub 6-0:1.0: 2 ports detected
[    3.972930] usb usb6: New USB device found, idVendor=1d6b, idProduct=0001
[    3.976759] usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.983454] usb usb6: Product: UHCI Host Controller
[    3.991092] usb usb6: Manufacturer: Linux 2.6.27-rc3-amd64 uhci_hcd
[    3.998510] usb usb6: SerialNumber: 0000:00:1d.2
[    4.011688] ehci_hcd 0000:00:1d.7: PCI INT A -> GSI 20 (level, low) -> IRQ 20
[    4.013873] ehci_hcd 0000:00:1d.7: setting latency timer to 64
[    4.017438] ehci_hcd 0000:00:1d.7: EHCI Host Controller
[    4.024702] ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 7
[    4.032022] ehci_hcd 0000:00:1d.7: debug port 1
[    4.041047] ehci_hcd 0000:00:1d.7: cache line size of 32 is not supported
[    4.041047] ehci_hcd 0000:00:1d.7: irq 20, io mem 0xe0628000
[    4.061010] ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
[    4.068626] usb usb7: configuration #1 chosen from 1 choice
[    4.076648] hub 7-0:1.0: USB hub found
[    4.084387] hub 7-0:1.0: 6 ports detected
[    4.195044] usb usb7: New USB device found, idVendor=1d6b, idProduct=0002
[    4.201042] usb usb7: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.208593] usb usb7: Product: EHCI Host Controller
[    4.212264] usb usb7: Manufacturer: Linux 2.6.27-rc3-amd64 ehci_hcd
[    4.219912] usb usb7: SerialNumber: 0000:00:1d.7
[    4.237061] piix 0000:00:1f.1: IDE controller (0x8086:0x2850 rev 0x03)
[    4.241034] PIIX_IDE 0000:00:1f.1: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    4.250100] piix 0000:00:1f.1: IDE port disabled
[    4.257649] piix 0000:00:1f.1: not 100% native mode: will probe irqs later
[    4.265425]     ide0: BM-DMA at 0x20e0-0x20e7
[    4.273649] Probing IDE interface ide0...
[    4.560479] hda: TOSHIBA MK8009GAH, ATA DISK drive
[    5.012043] hdb: MATSHITADVD-RAM UJ-842S, ATAPI CD/DVD-ROM drive
[    5.075969] hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    5.076068] hda: UDMA/100 mode selected
[    5.084042] hdb: host max PIO4 wanted PIO255(auto-tune) selected PIO4
[    5.084042] hdb: MWDMA2 mode selected
[    5.092024] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    5.099915] isa bounce pool size: 16 pages
[    5.143078] No dock devices found.
[    5.165290] SCSI subsystem initialized
[    5.193205] libata version 3.00 loaded.
[    5.213093] hda: max request size: 128KiB
[    5.224117] hda: 156301488 sectors (80026 MB), CHS=65535/16/63
[    5.228574] hda: cache flushes supported
[    5.235784]  hda: hda1 hda2 hda3
[    5.261553] hdb: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
[    5.274152] Uniform CD-ROM driver Revision: 3.20
[    5.872135] device-mapper: uevent: version 1.0.3
[    5.882975] device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised: dm-devel@redhat.com
[   10.128006] PM: Starting manual resume from disk
[   10.287923] kjournald starting.  Commit interval 5 seconds
[   10.290422] EXT3-fs: mounted filesystem with ordered data mode.
[   14.689005] input: Power Button (FF) as /class/input/input2
[   14.761006] ACPI: Power Button (FF) [PWRF]
[   14.768274] input: Sleep Button (CM) as /class/input/input3
[   14.797006] agpgart-intel 0000:00:00.0: Intel 965GM Chipset
[   14.806205] agpgart-intel 0000:00:00.0: detected 7676K stolen memory
[   14.829005] agpgart-intel 0000:00:00.0: AGP aperture is 256M @ 0xd0000000
[   14.861002] ACPI: Sleep Button (CM) [C2BF]
[   14.868165] input: Lid Switch as /class/input/input4
[   14.897006] ACPI: Lid Switch [C155]
[   14.904296] ACPI: WMI: Mapper loaded
[   14.932228] e1000e: Intel(R) PRO/1000 Network Driver - 0.3.3.3-k2
[   14.935943] e1000e: Copyright (c) 1999-2008 Intel Corporation.
[   14.943978] e1000e 0000:00:19.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   14.955259] e1000e 0000:00:19.0: setting latency timer to 64
[   14.989005] ACPI: AC Adapter [C23B] (on-line)
[   15.085005] ACPI: Battery Slot [C23D] (battery present)
[   15.149007] acpi device:02: registered as cooling_device9
[   15.159022] input: Video Bus as /class/input/input5
[   15.189006] 0000:00:19.0: eth0: (PCI Express:2.5GB/s:Width x1) 00:1e:68:06:12:ee
[   15.197017] 0000:00:19.0: eth0: Intel(R) PRO/1000 Network Connection
[   15.204419] 0000:00:19.0: eth0: MAC: 4, PHY: 6, PBA No: ffffff-0ff
[   15.269005] ACPI: Video Device [C09A] (multi-head: yes  rom: no  post: no)
[   16.081005] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.03 (30-Apr-2008)
[   16.089124] iTCO_wdt: Found a ICH8M-E TCO device (Version=2, TCOBASE=0x1060)
[   16.096603] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   16.533433] input: PC Speaker as /class/input/input6
[   16.615814] Yenta: CardBus bridge found at 0000:02:06.0 [103c:30c9]
[   16.620069] yenta_cardbus 0000:02:06.0: CardBus bridge, secondary bus 0000:03
[   16.633024] yenta_cardbus 0000:02:06.0:   IO window: 0x003000-0x0030ff
[   16.638628] yenta_cardbus 0000:02:06.0:   IO window: 0x003400-0x0034ff
[   16.646568] yenta_cardbus 0000:02:06.0:   PREFETCH window: 0x8c400000-0x8c7fffff
[   16.654210] yenta_cardbus 0000:02:06.0:   MEM window: 0x88000000-0x8bffffff
[   16.735101] iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, 1.3.27k
[   16.737643] input: PS/2 Generic Mouse as /class/input/input7
[   16.749022] iwlagn: Copyright(c) 2003-2008 Intel Corporation
[   16.793020] Yenta: ISA IRQ mask 0x0cb8, PCI irq 18
[   16.796714] Socket status: 30000006
[   16.812706] Yenta: Raising subordinate bus# of parent bus (#02) from #03 to #06
[   16.823599] pcmcia: parent PCI bridge I/O window: 0x3000 - 0x3fff
[   16.823607] pcmcia: parent PCI bridge Memory window: 0xe0100000 - 0xe03fffff
[   16.839171] iwlagn 0000:10:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   16.841023] iwlagn 0000:10:00.0: setting latency timer to 64
[   16.841023] iwlagn: Detected Intel Wireless WiFi Link 4965AGN REV=0x4
[   16.893007] iwlagn: Tunable channels: 13 802.11bg, 19 802.11a channels
[   16.906419] iwlagn 0000:10:00.0: PCI INT A disabled
[   16.917442] phy0: Selected rate control algorithm 'iwl-agn-rs'
[   17.130306] HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
[   17.133379] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   17.145411] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   17.152682] Error: Driver 'pcspkr' is already registered, aborting...
[   17.538402] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x1a0b1, caps: 0xa04713/0x200000
[   17.587205] input: SynPS/2 Synaptics TouchPad as /class/input/input8
[   20.012415] EXT3 FS on dm-1, internal journal
[   20.641024] loop: module loaded
[   20.757801] tun: Universal TUN/TAP device driver, 1.6
[   20.761625] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   22.924746] kjournald starting.  Commit interval 5 seconds
[   22.933993] EXT3 FS on hda1, internal journal
[   22.940263] EXT3-fs: mounted filesystem with ordered data mode.
[   22.991405] kjournald starting.  Commit interval 5 seconds
[   23.000845] EXT3 FS on dm-3, internal journal
[   23.005099] EXT3-fs: mounted filesystem with ordered data mode.
[   23.062009] Adding 1048568k swap on /dev/mapper/lucky-swap.  Priority:-1 extents:1 across:1048568k
[   26.101679] NET: Registered protocol family 10
[   26.112756] lo: Disabled Privacy Extensions
[   26.123185] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   33.748141] pnp: the driver 'parport_pc' has been registered
[   33.748716] lp: driver loaded but no devices found
[   33.841006] ppdev: user-space parallel port driver
[   48.116139] Bluetooth: Core ver 2.12
[   48.131407] NET: Registered protocol family 31
[   48.131742] Bluetooth: HCI device and connection manager initialized
[   48.145613] Bluetooth: HCI socket layer initialized
[   48.194702] Bluetooth: L2CAP ver 2.10
[   48.209009] Bluetooth: L2CAP socket layer initialized
[   48.317919] Bluetooth: RFCOMM socket layer initialized
[   48.329035] Bluetooth: RFCOMM TTY layer initialized
[   48.342099] Bluetooth: RFCOMM ver 1.10
[   57.681440] hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
[   57.681440] hdb: task_no_data_intr: error=0x04 { AbortedCommand }
[   57.681440] ide: failed opcode was: 0xef
[   57.685907] [drm] Initialized drm 1.1.0 20060810
[   57.723193] pci 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[   57.723193] pci 0000:00:02.0: setting latency timer to 64
[   57.723193] [drm] Initialized i915 1.6.0 20060119 on minor 0
[   84.723869] warning: `zsh' uses 32-bit capabilities (legacy support in use)
[   92.507445] iwlagn 0000:10:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   92.507462] iwlagn 0000:10:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
[   92.507462] firmware: requesting iwlwifi-4965-2.ucode
[   92.589583] iwlagn: iwlwifi-4965-2.ucode firmware file req failed: Reason -2
[   92.589583] iwlagn: Could not read microcode: -2
[   92.589583] iwlagn 0000:10:00.0: PCI INT A disabled
[   92.589583] iwlagn 0000:10:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   92.589583] iwlagn 0000:10:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
[   92.589583] firmware: requesting iwlwifi-4965-2.ucode
[   92.600828] iwlagn: iwlwifi-4965-2.ucode firmware file req failed: Reason -2
[   92.600828] iwlagn: Could not read microcode: -2
[   92.600828] iwlagn 0000:10:00.0: PCI INT A disabled
[  124.688011] iwlagn 0000:10:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[  124.689008] iwlagn 0000:10:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
[  124.689008] firmware: requesting iwlwifi-4965-2.ucode
[  124.697010] iwlagn: iwlwifi-4965-2.ucode firmware file req failed: Reason -2
[  124.697010] iwlagn: Could not read microcode: -2
[  124.697010] iwlagn 0000:10:00.0: PCI INT A disabled
[  124.697010] iwlagn 0000:10:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[  124.697010] iwlagn 0000:10:00.0: restoring config space at offset 0x1 (was 0x100002, writing 0x100006)
[  124.697010] firmware: requesting iwlwifi-4965-2.ucode
[  124.709008] iwlagn: iwlwifi-4965-2.ucode firmware file req failed: Reason -2
[  124.709008] iwlagn: Could not read microcode: -2
[  124.709008] iwlagn 0000:10:00.0: PCI INT A disabled
[  144.983810] pccard: PCMCIA card inserted into slot 0
[  144.983942] cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xd3fff 0xe0000-0xfffff
[  144.989008] cs: memory probe 0x60000000-0x60ffffff: excluding 0x60000000-0x60ffffff
[  144.989008] cs: memory probe 0xa0000000-0xa0ffffff: clean.
[  145.008898] cs: memory probe 0xe0100000-0xe03fffff: excluding 0xe0100000-0xe012ffff
[  145.021508] pcmcia: registering new device pcmcia0.0
[  145.284012] Probing IDE interface ide1...
[  145.576063] hdc: TOSHIBA THNCF512MMA, CFA DISK drive
[  146.248065] BUG: unable to handle kernel NULL pointer dereference at 00000000000000f8
[  146.248065] IP: [<ffffffffa0038b77>] init_irq+0x18d/0x31c [ide_core]
[  146.248065] PGD 7054a067 PUD 7dc17067 PMD 0 
[  146.248065] Oops: 0000 [1] SMP 
[  146.248065] CPU 0 
[  146.248065] Modules linked in: ide_cs(+) i915 drm rfcomm l2cap bluetooth ppdev parport_pc lp parport acpi_cpufreq cpufreq_powersave cpufreq_conservative cpufreq_ondemand cpufreq_stats freq_table cpufreq_userspace ipv6 tun kvm_intel kvm loop firewire_sbp2 firewire_core crc_itu_t arc4 pcmcia ecb snd_hda_intel snd_pcm_oss snd_mixer_oss iwlagn yenta_socket iwlcore pcspkr snd_pcm rsrc_nonstatic rfkill snd_timer pcmcia_core mac80211 psmouse iTCO_wdt snd serio_raw soundcore cfg80211 snd_page_alloc container video output battery ac e1000e wmi intel_agp button evdev joydev ext3 jbd mbcache sha256_generic aes_x86_64 aes_generic cbc dm_crypt crypto_blkcipher dm_mirror dm_log dm_snapshot dm_mod ide_cd_mod cdrom ide_disk ata_generic libata scsi_mod dock piix ide_pci_generic ide_core ehci_hcd uhci_hc
 d thermal processor fan thermal_sys
[  146.248065] Pid: 4080, comm: modprobe Not tainted 2.6.27-rc3-amd64 #1
[  146.248065] RIP: 0010:[<ffffffffa0038b77>]  [<ffffffffa0038b77>] init_irq+0x18d/0x31c [ide_core]
[  146.248065] RSP: 0018:ffff88007058fa08  EFLAGS: 00010282
[  146.248065] RAX: 0000000000000020 RBX: ffff88007298c000 RCX: 0000000000000000
[  146.248065] RDX: 00000000ffffffff RSI: 0000000000001fe0 RDI: ffffffffa004bf60
[  146.248065] RBP: 0000000000000000 R08: ffff88007f007e6b R09: 0000000000000002
[  146.248065] R10: 0000000000000001 R11: 0000000000000001 R12: 000000000000000a
[  146.248065] R13: 0000000000000000 R14: 0000000000000000 R15: ffff88007d81fa40
[  146.248065] FS:  00007f5a836d66e0(0000) GS:ffffffff8058ea00(0000) knlGS:0000000000000000
[  146.248065] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[  146.248065] CR2: 00000000000000f8 CR3: 0000000072957000 CR4: 00000000000026e0
[  146.248065] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  146.248065] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  146.248065] Process modprobe (pid: 4080, threadinfo ffff88007058e000, task ffff88007ce7c080)
[  146.248065] Stack:  ffff88007d81fa40 0000000000000282 0000000000000000 ffff88007298c000
[  146.248065]  ffff88007298c028 ffff88007298c028 0000000000000000 ffffffffa0039167
[  146.248065]  ffff88007058fb38 ffff88007d81fa40 00000000fffffff4 ffff88007058fb38
[  146.248065] Call Trace:
[  146.248065]  [<ffffffffa0039167>] ide_host_register+0x3c5/0x59e [ide_core]
[  146.248065]  [<ffffffffa0039576>] ide_host_add+0x31/0x54 [ide_core]
[  146.248065]  [<ffffffffa040a1a2>] idecs_register+0x11c/0x19c [ide_cs]
[  146.248065]  [<ffffffffa040a59f>] ide_probe+0x37d/0x47e [ide_cs]
[  146.248065]  [<ffffffffa02eb863>] pcmcia_device_probe+0xc5/0x124 [pcmcia]
[  146.248065]  [<ffffffff8039cc28>] driver_probe_device+0xd0/0x14d
[  146.248065]  [<ffffffff8039cceb>] __driver_attach+0x46/0x6d
[  146.248065]  [<ffffffff8039cca5>] __driver_attach+0x0/0x6d
[  146.248065]  [<ffffffff8039c3cb>] bus_for_each_dev+0x44/0x6f
[  146.248065]  [<ffffffff8039c801>] bus_add_driver+0xb4/0x203
[  146.248065]  [<ffffffff8039cf53>] driver_register+0x8d/0x101
[  146.248065]  [<ffffffffa02ec50e>] pcmcia_register_driver+0xe4/0x11a [pcmcia]
[  146.248065]  [<ffffffffa0025000>] init_ide_cs+0x0/0xc [ide_cs]
[  146.248065]  [<ffffffff8020a042>] do_one_initcall+0x42/0x13b
[  146.248065]  [<ffffffff8025dc37>] sys_init_module+0x18e1/0x1a6f
[  146.248065]  [<ffffffffa02ecf1c>] pcmcia_request_irq+0x0/0x105 [pcmcia]
[  146.248065]  [<ffffffff8020ff2a>] system_call_fastpath+0x16/0x1b
[  146.248065] 
[  146.248065] 
[  146.248065] Code: fe 48 c7 c7 80 c7 04 a0 e8 db b1 1e e0 90 fb 0f 1f 80 00 00 00 00 eb 5c 48 8b 83 48 07 00 00 83 ca ff 48 85 c0 74 0e 48 8b 40 90 <48> 8b 80 d8 00 00 00 8b 50 04 48 8b 3d 68 36 4f e0 be d0 80 00 
[  146.248065] RIP  [<ffffffffa0038b77>] init_irq+0x18d/0x31c [ide_core]
[  146.248065]  RSP <ffff88007058fa08>
[  146.248065] CR2: 00000000000000f8
[  146.248065] ---[ end trace 979ea53cfe9f0f60 ]---

--k1lZvvs/B4yU6o8G--
