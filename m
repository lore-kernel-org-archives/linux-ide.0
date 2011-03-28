From: Daniel Palmer <me@danielpalmer.co.uk>
Subject: PATA_ARTOP oppes in 2.6.38
Date: Mon, 28 Mar 2011 01:31:13 +0100
Message-ID: <4D8FD6D1.2020501@danielpalmer.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tomato.cardboardbox.org.uk ([174.143.157.65]:44297 "EHLO
	tomato.cardboardbox.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752553Ab1C1BNl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Mar 2011 21:13:41 -0400
Received: from p20199-ipngn100202sizuokaden.shizuoka.ocn.ne.jp ([180.24.243.199] helo=[192.168.1.12])
	by tomato.cardboardbox.org.uk with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.74)
	(envelope-from <me@danielpalmer.co.uk>)
	id 1Q40I5-00077f-MK
	for linux-ide@vger.kernel.org; Mon, 28 Mar 2011 00:26:42 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I posted this on the linux-sh list too 
(http://marc.info/?l=linux-sh&m=130121196319157&w=2).
With vanilla 2.6.38 the board/arch specific code was generating the 
wrong address for one of the IO ports associated with the PATA 
controller (I don't really understand how PCI works, I'm just guessing 
here based on the dmesg output really.. ;)). In vanilla 2.6.38 
pata_artop oops on "Unable to handle kernel paging request at virtual 
address 000013ff" instead.. this is now fixed so it's not accessing 
outside of the assigned ranges but it still oops.

I've attached the full output from the board below.. you should be able 
to see where I load modules and it oops when pata_artop is loaded.

If someone could help me debug this I would be very grateful.

Regards,

Daniel


SH IPL+g version 0.9, Copyright (C) 2000 Free Software Foundation, Inc.

This software comes with ABSOLUTELY NO WARRANTY; for details type `w'.
This is free software, and you are welcome to redistribute it under
certain conditions; type `l' for details.

2002/09/09 Making.  2003/10/16 I-O DATA NSD NWG Update.
266:133:33 on base clock 22.22MHz and SDRAM 4 burst. ATA boot.

A-Card ATP865 ATA controller found.
PCIC initialization done.
MASTER:48bit LBA mode non support
Disk drive detected: SanDisk SDCFH-004G HDX 5.04      ALZ012210190202
LBA: 00778E30
DiskSize: 4011614208Byte
PIO MODE1
Set Transfer Mode result: 50
A-Card ATP865 ATA controller found.
 > b
Set Transfer Mode result: 50
Initialize Device Parameters result: 50
IDLE result: 50
LILO boot:

   1 : NEW
   2 : CF
   3 : TEST
   4 : 38

Select boot image -> 4
Loading 38.....................................................done.
[    0.000000] Setting GDB trap vector to 80000100
[    0.000000] Linux version 2.6.38dgp (root@momoko) (gcc version 4.4.5 
(Debian 4.4.5-12) ) #1 Sun Mar 27 12:06:40 JST 2011
[    0.000000] Boot params:
[    0.000000] ... MOUNT_ROOT_RDONLY - 00000001
[    0.000000] ... RAMDISK_FLAGS     - 00000000
[    0.000000] ... ORIG_ROOT_DEV     - 00000301
[    0.000000] ... LOADER_TYPE       - 00000001
[    0.000000] ... INITRD_START      - 00000000
[    0.000000] ... INITRD_SIZE       - 00000000
[    0.000000] Memory limited to 64MB
[    0.000000] Booting machvec: LANDISK
[    0.000000] initrd disabled
[    0.000000] Node 0: start_pfn = 0xc000, low = 0x10000
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x0000c000 -> 0x00010000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x0000c000 -> 0x00010000
[    0.000000] I-O DATA DEVICE, INC. "LANDISK Series" support.
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 16256
[    0.000000] Kernel command line: ro mem=64M console=ttySC1,9600 
root=/dev/hda3 rootdelay=20
[    0.000000] PID hash table entries: 256 (order: -2, 1024 bytes)
[    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 
bytes)
[    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] PVR=04050005 CVR=20480000 PRR=00000113
[    0.000000] I-cache : n_ways=2 n_sets=256 way_incr=8192
[    0.000000] I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 
n_aliases=2
[    0.000000] D-cache : n_ways=2 n_sets=512 way_incr=16384
[    0.000000] D-cache : entry_mask=0x00003fe0 alias_mask=0x00003000 
n_aliases=4
[    0.000000] Memory: 60832k/65536k available (2257k kernel code, 546k 
data, 1200k init)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xdfff7000 - 0xdffff000   (  32 kB)
[    0.000000]     vmalloc : 0xc0000000 - 0xdfff5000   ( 511 MB)
[    0.000000]     lowmem  : 0x8c000000 - 0x90000000   (  64 MB) (cached)
[    0.000000]             : 0xa0000000 - 0xc0000000   ( 512 MB) (uncached)
[    0.000000]       .init : 0x8c2bf000 - 0x8c3eb000   (1200 kB)
[    0.000000]       .data : 0x8c2356b4 - 0x8c2be100   ( 546 kB)
[    0.000000]       .text : 0x8c001000 - 0x8c2356b4   (2257 kB)
[    0.000000] NR_IRQS:512 nr_irqs:512 8
[    0.000000] intc: Registered controller 'sh7750' with 20 IRQs
[    0.000000] intc: Registered controller 'sh7750_dma8' with 9 IRQs
[    0.000000] intc: Registered controller 'sh7750_tmu34' with 2 IRQs
[    0.000000] intc: Registered controller 'sh7750_pci' with 8 IRQs
[    0.000000] intc: Registered controller 'landisk' with 8 IRQs
[    0.000000] Console: colour dummy device 80x25
[    0.000000]  sh_tmu.0: used for clock events
[    0.000000]  sh_tmu.0: used for periodic clock events
[    0.000000]  sh_tmu.1: used as clock source
[    0.000000] Calibrating delay loop (skipped)... 266.66 BogoMIPS 
PRESET (lpj=533333)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] Mount-cache hash table entries: 512
[    0.000000] CPU: SH7751R
[    0.008000] print_constraints: dummy:
[    0.008000] NET: Registered protocol family 16
[    0.020000] PCI: Starting initialization.
[    0.044000] bio: create slab <bio-0> at 0
[    0.048000] vgaarb: loaded
[    0.052000] SCSI subsystem initialized
[    0.064000] pci 0000:00:01.0: BAR 6: assigned [mem 
0xfd000000-0xfd00ffff pref]
[    0.064000] pci 0000:00:02.0: BAR 0: assigned [mem 
0xfd010000-0xfd010fff]
[    0.064000] pci 0000:00:02.0: BAR 0: set to [mem 
0xfd010000-0xfd010fff] (PCI address [0xfd010000-0xfd010fff])
[    0.064000] pci 0000:00:02.1: BAR 0: assigned [mem 
0xfd011000-0xfd011fff]
[    0.064000] pci 0000:00:02.1: BAR 0: set to [mem 
0xfd011000-0xfd011fff] (PCI address [0xfd011000-0xfd011fff])
[    0.064000] pci 0000:00:00.0: BAR 0: assigned [io  0x1000-0x10ff]
[    0.064000] pci 0000:00:00.0: BAR 0: set to [io  0x1000-0x10ff] (PCI 
address [0x1000-0x10ff])
[    0.064000] pci 0000:00:00.0: BAR 1: assigned [mem 
0xfd012000-0xfd0120ff]
[    0.064000] pci 0000:00:00.0: BAR 1: set to [mem 
0xfd012000-0xfd0120ff] (PCI address [0xfd012000-0xfd0120ff])
[    0.064000] pci 0000:00:02.2: BAR 0: assigned [mem 
0xfd012100-0xfd0121ff]
[    0.064000] pci 0000:00:02.2: BAR 0: set to [mem 
0xfd012100-0xfd0121ff] (PCI address [0xfd012100-0xfd0121ff])
[    0.064000] pci 0000:00:01.0: BAR 4: assigned [io  0x1400-0x140f]
[    0.064000] pci 0000:00:01.0: BAR 4: set to [io  0x1400-0x140f] (PCI 
address [0x1400-0x140f])
[    0.064000] pci 0000:00:01.0: BAR 0: assigned [io  0x1410-0x1417]
[    0.064000] pci 0000:00:01.0: BAR 0: set to [io  0x1410-0x1417] (PCI 
address [0x1410-0x1417])
[    0.064000] pci 0000:00:01.0: BAR 2: assigned [io  0x1418-0x141f]
[    0.064000] pci 0000:00:01.0: BAR 2: set to [io  0x1418-0x141f] (PCI 
address [0x1418-0x141f])
[    0.064000] pci 0000:00:01.0: BAR 1: assigned [io  0x1420-0x1423]
[    0.064000] pci 0000:00:01.0: BAR 1: set to [io  0x1420-0x1423] (PCI 
address [0x1420-0x1423])
[    0.064000] pci 0000:00:01.0: BAR 3: assigned [io  0x1424-0x1427]
[    0.064000] pci 0000:00:01.0: BAR 3: set to [io  0x1424-0x1427] (PCI 
address [0x1424-0x1427])
[    0.068000] Switching to clocksource sh_tmu.1
[    0.072000] platform sh_tmu.0: used for oneshot clock events
[    0.152000] NET: Registered protocol family 2
[    0.152000] IP route cache hash table entries: 1024 (order: 0, 4096 
bytes)
[    0.152000] TCP established hash table entries: 2048 (order: 2, 16384 
bytes)
[    0.152000] TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
[    0.152000] TCP: Hash tables configured (established 2048 bind 2048)
[    0.152000] TCP reno registered
[    0.152000] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.152000] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.456000] sq: Registering store queue API.
[    0.460000] gio: driver initialized
[    0.472000] VFS: Disk quotas dquot_6.5.2
[    0.472000] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.472000] ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.472000] msgmni has been set to 118
[    0.476000] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 253)
[    0.476000] io scheduler noop registered (default)
[    1.624000] SuperH SCI(F) driver initialized
[    1.628000] sh-sci.0: ttySC0 at MMIO 0xffe00000 (irq = 23) is a sci
[    1.632000] sh-sci.1: ttySC1 at MMIO 0xffe80000 (irq = 40) is a scif
[    8.500000] console [ttySC1] enabled
[    8.664000] brd: module loaded
[    8.708000] mousedev: PS/2 mouse device common for all mice
[    8.776000] cpuidle: using governor ladder
[    8.832000] sh_tmu sh_tmu.0: kept as earlytimer
[    8.888000] sh_tmu sh_tmu.1: kept as earlytimer
[    8.948000] TCP cubic registered
[    8.984000] Registering the dns_resolver key type
[    9.048000] registered taskstats version 1
[    9.104000] Freeing unused kernel memory: 1200k freed
Dropping into initramfs environment
/bin/sh: can't access tty; job control turned off
/ # insmod
bin/      init      modules/  sbin/     usr/
dev/      mnt/      proc/     sys/
/ # insmod modules/
ext3.ko        jbd.ko         libata.ko      mbcache.ko     pata_artop.ko
/ # insmod modules/jbd.ko
/ # insmod modules/mbcache.ko
/ # insmod modules/ext3.ko
/ # insmod modules/libata.ko
/ # insmod modules/pata_artop.ko
[   58.284000] Unable to handle kernel paging request at virtual address 
00001400
[   58.372000] pc = c00fa28e
[   58.400000] *pde = 00000000
[   58.436000] Oops: 0000 [#1]
[   58.436000] last sysfs file:
[   58.436000] Modules linked in: pata_artop(+) libata ext3 mbcache jbd
[   58.436000]
[   58.436000] Pid : 783, Comm:                 insmod
[   58.436000] CPU : 0                  Not tainted  (2.6.38dgp #1)
[   58.436000]
[   58.436000] PC is at artop_init_one+0xee/0x1e0 [pata_artop]
[   58.436000] PR is at artop_init_one+0xee/0x1e0 [pata_artop]
[   58.436000] PC  : c00fa28e SP  : 8ff9fe58 SR  : 40008101 TEA : 00001400
[   58.436000] R0  : 00001400 R1  : 00000000 R2  : 00000001 R3  : 00001000
[   58.436000] R4  : 00001400 R5  : 00000001 R6  : 00000005 R7  : 00000005
[   58.436000] R8  : 8ff9fe58 R9  : 8fc3b020 R10 : c00fa81c R11 : 8fc3b020
[   58.436000] R12 : 8c003a80 R13 : 8c182780 R14 : 004ae284
[   58.436000] MACH: 0000016b MACL: 0000019a GBR : 0051c470 PR  : c00fa28e
[   58.436000]
[   58.436000] Call trace:
[   58.436000]  [<8c1494ea>] local_pci_probe+0x4a/0x120
[   58.436000]  [<8c003a80>] arch_local_save_flags+0x0/0x20
[   58.436000]  [<8c003a40>] arch_local_irq_restore+0x0/0x40
[   58.436000]  [<8c131c10>] kobject_get+0x10/0x20
[   58.436000]  [<8c149a22>] pci_device_probe+0x62/0xa0
[   58.436000]  [<8c003a80>] arch_local_save_flags+0x0/0x20
[   58.436000]  [<8c17da64>] driver_probe_device+0xa4/0x220
[   58.436000]  [<8c003a40>] arch_local_irq_restore+0x0/0x40
[   58.436000]  [<8c17dc66>] __driver_attach+0x86/0xa0
[   58.436000]  [<8c232a00>] mutex_lock+0x0/0x60
[   58.436000]  [<8c17d10e>] bus_for_each_dev+0x4e/0x80
[   58.436000]  [<8c22bd60>] klist_next+0x0/0xe0
[   58.436000]  [<8c17dbe0>] __driver_attach+0x0/0xa0
[   58.436000]  [<8c17c8e2>] bus_add_driver+0x82/0x240
[   58.436000]  [<8c17dff2>] driver_register+0x52/0x160
[   58.436000]  [<c00fd000>] artop_init+0x0/0x1c [pata_artop]
[   58.436000]  [<8c149c6e>] __pci_register_driver+0x2e/0xa0
[   58.436000]  [<c00fd000>] artop_init+0x0/0x1c [pata_artop]
[   58.436000]  [<8c002084>] do_one_initcall+0x24/0x1c0
[   58.436000]  [<8c04c992>] sys_init_module+0x92/0x1c0
[   58.436000]  [<8c03a620>] blocking_notifier_call_chain+0x0/0x20
[   58.436000]  [<8c008232>] syscall_call+0xc/0x10
[   58.436000]  [<8c04c900>] sys_init_module+0x0/0x1c0
[   58.436000]
[   58.436000] Process: insmod (pid: 783, stack limit = 8ff9e001)
[   58.436000] Stack: (0x8ff9fe58 to 0x8ffa0000)
[   58.436000] 
fe40:                                                       c00fa718 
00000000
[   58.436000] fe60: 004ae284 8c1494ea 8c003a80 8fc3b020 8fc3b07c 
8c003a40 8ff9fea4 8c131c10
[   58.436000] fe80: 8c149a22 004ae284 c00fa884 8c003a80 8c3f9ae8 
8fc3b0bc c00fa854 8fc3b020
[   58.436000] fea0: 8fc3b07c c00fa854 8fc3b020 c00fa81c 8c17da64 
8c003a40 8fc3b07c 8ffb8340
[   58.436000] fec0: 8c17dc66 004ae284 00423ae0 00000000 8c232a00 
8fc3b0b0 c00fa884 8fc3b07c
[   58.436000] fee0: 8c17d10e 8c22bd60 8c17dbe0 8c2b5570 c00fa884 
8fc2e918 8fc3f7f0 8c17c8e2
[   58.436000] ff00: 00000000 fffffff4 8ffb8340 8c2b5570 c00fa884 
8c17dff2 004ae284 00423ae0
[   58.436000] ff20: fffffff0 c00fd000 8c3eb064 c00fa884 c00fa854 
00000000 8c149c6e 00000000
[   58.436000] ff40: c00fd000 8c3eb064 c00fa884 c00fa854 00000000 
8c002084 8c3eb064 00000000
[   58.436000] ff60: c00fab34 00000000 00000000 8f8438a0 8c04c992 
004ae284 00423ae0 00000000
[   58.436000] ff80: c00fac30 8c03a620 c00fab34 c00fab34 8c008232 
00000000 00000071 00000100
[   58.436000] ffa0: 8c04c900 00000000 ffffffff fffffff4 00000080 
0051d688 00002046 004e0028
[   58.436000] ffc0: 00002050 7bb65ec8 004e0028 7bb65d7c 7bb65ecc 
00000000 00423ae0 004ae284
[   58.436000] ffe0: 7bb65c2c 00455006 004b3a28 00008001 0051c470 
00000022 ffffe000 00000054
[   62.304000] ---[ end trace 7f9ead9e754eeb05 ]---
Segmentation fault
/ #

