From: Byron Bradley <byron.bbradley@gmail.com>
Subject: sata_mv: problems using it as a platform_driver
Date: Fri, 8 Feb 2008 01:33:12 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0802080113560.16853@git.byronbradley.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:35665 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759140AbYBHBdW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 20:33:22 -0500
Received: by ug-out-1314.google.com with SMTP id z38so809713ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 17:33:20 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: saeed@marvell.com, linux-ide@vger.kernel.org, mlord@pobox.com, jeff@garzik.org, linux-arm-kernel@lists.arm.linux.org.uk

I'm having problems getting the sata_mv driver working as a platform
driver on the QNAP TS-209 and the Linkstation/Kurobox (both are Marvell
Orion 88f5182 based devices). First of all it would oops in
mv_port_start() while calling dma_pool_alloc(), the patch to fix this is
at the end of this email.

In mv_platform_probe() host->iomap is set to NULL but it is dereferenced
in mv_start_dma(), I'm not sure what the fix for this is. This is based on
the latest 2.6-git and a merge with the for-rmk branch of the orion git.

Oops is below, if people agree with the DMA patch I can submit that
seperatly to make things easier.

sata_mv sata_mv.0: version 1.20
sata_mv sata_mv.0: slots 32 ports 2
scsi0 : sata_mv
scsi1 : sata_mv
ata1: SATA max UDMA/133 irq 29
ata2: SATA max UDMA/133 irq 29
ata1: SATA link down (SStatus 0 SControl 300)
ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata2.00: ATA-7: Hitachi HDT725050VLA360, V56OA52A, max UDMA/133
ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
scsi 1:0:0:0: Direct-Access     ATA      Hitachi HDT72505 V56O PQ: 0 ANSI: 5
sd 1:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
Modules linked in:
CPU: 0    Not tainted  (2.6.24-08695-gb79ef3b-dirty #53)
PC is at mv_qc_issue+0x104/0x1a0
LR is at ata_qc_issue+0x1d0/0x4c4
pc : [<c029dae4>]    lr : [<c0288fd8>]    psr: 40000093
sp : c7c19678  ip : c7cdea90  fp : c7c1969c
r10: 00000000  r9 : 00000002  r8 : 00000001
r7 : 00000000  r6 : c7e04810  r5 : c7e7c000  r4 : c887c000
r3 : 00000000  r2 : 00002000  r1 : 00000004  r0 : 00000001
Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: a005317f  Table: 00004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc7c18268)
Stack: (0xc7c19678 to 0xc7c1a000)
9660:                                                       00000000 c7e7c07c
9680: 00000001 00000001 c7e7c000 c06c195c c7c196d4 c7c196a0 c0288fd8 c029d9f0
96a0: 00000000 c7e7da88 c0065a60 c7e7c07c 00000000 00000000 c7e7dbb0 c029004c
96c0: c7df3cd8 c7e7c000 c7c196fc c7c196d8 c0290320 c0288e18 c7e7dbb0 c7c3f9c0
96e0: c7e7c000 c7df3400 c0271a70 c7e032a4 c7c19724 c7c19700 c0293a84 c029025c
9700: 00000002 80000013 c7df3c00 c7c3f9c0 c7df3400 c7d792e0 c7c19744 c7c19728
9720: c02720d0 c02939e8 c7c3f9c0 c7df3c00 c7df3400 c7e03160 c7c19774 c7c19748
9740: c027824c c0271fb8 c7e03160 c7e03160 00000000 c7c1981c 00000002 c000008c
9760: c03b9c34 c0073154 c7c1978c c7c19778 c020fba4 c0278090 c7e03160 c7e03160
9780: c7c197a4 c7c19790 c020fe20 c020fb7c 00000002 c7c19814 c7c197b4 c7c197a8
97a0: c020e394 c020fe0c c7c197c4 c7c197b8 c020e3ac c020e388 c7c197d4 c7c197c8
97c0: c00bfce8 c020e3a8 c7c197e4 c7c197d8 c00731a0 c00bfca8 c7c1980c c7c197e8
97e0: c03b3428 c0073164 c07dea00 00000000 c78024a8 00000000 00000000 c00c6e28
9800: c7c1983c c7c19810 c007312c c03b33d0 00000000 c07dea00 00000000 00000001
9820: c7c16000 c0056f14 c00000a8 c00000a8 c7c19864 c7c19840 c00739b4 c00730e4
9840: 00000000 c7c1993c 00000000 00000000 00000000 c78022e0 c7c1987c c7c19868
9860: c0075954 c00738b8 00000036 00000000 c7c19894 c7c19880 c00dcbdc c0075950
9880: c00def20 c7cb1000 c7c1996c c7c19898 c00def68 c00dcbbc c0041224 c0040fe8
98a0: c7cb3000 00000000 00000000 c04bec3f c7c19964 c7cb3000 00000008 c049c15c
98c0: c7c19944 c7cb3000 c0041834 c00634dc c0224c2c c0223004 c7c18000 80000013
98e0: 00000008 00000010 c7cb1000 00000020 c7cb3000 c04412ea 00000000 c7cb1000
9900: c7cb1000 c7cb3000 00000000 c7cb3000 00000000 00000000 c7c1993c 00000010
9920: c7cb1000 00000000 c78022e0 c7cb3000 00000000 00000000 c7c1995c c7c19948
9940: c0041a3c c00def20 c7cb1000 00000001 c78022e0 c7cb3000 c03b9c34 c7cb3000
9960: c7c199ac c7c19970 c00dd288 c00def30 c7c1998c c7c19980 00000000 00000000
9980: c7c199ac c78022e0 c7cb1000 00000000 00000000 c78022ec 00000000 00000000
99a0: c7c199e4 c7c199b0 c00c78c8 c00dd168 c7c199dc 00000000 c002d2b0 00000000
99c0: c7c199e8 c7c19aa0 c78022e0 00000001 00000000 00000000 c7c19b5c c7c199e8
99e0: c00c7a08 c00c76ac 00000000 00000000 00000000 c7c19aa0 00000000 00000000
9a00: 00000000 00000001 00000000 00000000 00000000 00000000 00000000 00000000
9a20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9a40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9a60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9a80: 00000000 00000000 00000000 00000000 00000000 00000000 c78024a8 00000000
9aa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9ac0: 00000000 c7802398 00000000 00000000 00000000 00000000 00000000 00000000
9ae0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9b00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9b20: 00000000 00000000 00000000 00000000 00000000 00000000 c78022e0 c7cb1000
9b40: c7cb1120 00000000 00000000 c7df3cd8 c7c19b6c c7c19b60 c00c7a28 c00c79a4
9b60: c7c19b8c c7c19b70 c00dd13c c00c7a24 c7cb1000 c7e28800 c7df3c00 c7cb1000
9b80: c7c19bac c7c19b90 c0214518 c00dcff0 c02141b4 c7cb1000 00000000 c7e28808
9ba0: c7c19bf4 c7c19bb0 c027f128 c02144d8 00000000 00000001 c7df3cd8 c7df3cd8
9bc0: c7df3db0 00000000 c7c19bf4 c7df3cd8 c04b2ec8 c7df3cd8 c02591e0 c06d9674
9be0: c7df3db0 00000000 c7c19c1c c7c19bf8 c02590dc c027ef04 c7c19c2c 00000000
9c00: c7c19c34 c7df3cd8 c02591e0 c7df3cd8 c7c19c2c c7c19c20 c02591f0 c0259040
9c20: c7c19c5c c7c19c30 c0258154 c02591f0 c00e38a0 c7c13880 c7c1389c c7dde4d0
9c40: c7df3cd8 c7df3df0 c7df3cd8 00000000 c7c19c74 c7c19c60 c02592b4 c02580fc
9c60: c04b28e4 c7df3cd8 c7c19c8c c7c19c78 c02580bc c0259230 c7df3dd4 00000000
9c80: c7c19cc4 c7c19c90 c0256acc c0258080 c04b2790 c7df3818 c7c19cdc 00000000
9ca0: c7df3c00 c7cdec20 00000000 c7df3cd8 c7d8a307 c7d8a300 c7c19cec c7c19cc8
9cc0: c027badc c025673c c7c19cec c7cdec08 c7cdec10 c7cdec20 00000000 c7df3c00
9ce0: c7c19d6c c7c19cf0 c0279700 c027bab4 c7cdec08 c7cdec10 c7cdec20 00000000
9d00: 00000005 c046634c c7c19d7c 00000000 00000000 c7df3400 c7df3dd4 c7df3cd8
9d20: 00000000 00000024 00000012 22220060 22222222 22222222 00000000 00000000
9d40: c7cdea90 c7df3400 c7df3800 c7df3460 ffffffed 00000000 c7cdea94 00000001
9d60: c7c19da4 c7c19d70 c027a678 c0278e90 00000001 00000000 c7df3000 ffffffed
9d80: c7c19da4 c7e7dbb0 c7e7da88 c7e7c000 00000000 00000005 c7c19dd4 c7c19da8
9da0: c0291b7c c027a598 00000000 00000010 c7e7c000 00000001 00000001 c7cdea90
9dc0: 00000002 a0000013 c7c19e14 c7c19dd8 c028da70 c0291a8c c046443c c7e7dac8
9de0: c7c19e08 00000000 c0298b2c c7cdea98 00000002 c7cdea90 0000001d 00000080
9e00: c0025000 00000002 c7c19e44 c7c19e18 c028dbbc c028d800 c04339b8 c7cdea90
9e20: c04993c8 c04993c8 00000000 c049a1cc c7cdea90 c04993d0 c7c19e7c c7c19e48
9e40: c029ce40 c028db28 c04b362c 00000001 c03c8468 00000000 c04993d0 c04b37ec
9e60: c04b37ec c02592bc c06d9674 c7c3fe40 c7c19e8c c7c19e80 c025ae04 c029cce0
9e80: c7c19eb4 c7c19e90 c02590dc c025adf4 c03ae620 c04994e8 c04993d0 c04b37ec
9ea0: c02592bc c04afe08 c7c19ecc c7c19eb8 c02593a0 c0259040 00000000 c7c19ed4
9ec0: c7c19efc c7c19ed0 c02582dc c02592cc c7c3fe40 c7c13054 c7c13070 c049946c
9ee0: 00000000 00000000 c04b37ec c0024b2c c7c19f0c c7c19f00 c0258f3c c0258294
9f00: c7c19f3c c7c19f10 c0258c84 c0258f2c c04339b8 00000001 00000000 00000000
9f20: c04b37ec c0024b2c c7c18000 00000000 c7c19f64 c7c19f40 c02595f4 c0258bf0
9f40: c0259788 00000000 00000000 00000000 c0024b2c c7c18000 c7c19f74 c7c19f68
9f60: c025b090 c02595c0 c7c19f8c c7c19f78 c001d070 c025b034 c0024b28 00000000
9f80: c7c19ff4 c7c19f90 c000895c c001d050 c003d2a4 c003cf5c 00000000 00000000
9fa0: 00000000 c7c19fb0 c0029ae4 c003d298 00000000 00000000 c00088c4 c004429c
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 c7c19ff8 c004429c c00088d4 00000000 00000000
Backtrace:
[<c029d9e0>] (mv_qc_issue+0x0/0x1a0) from [<c0288fd8>] (ata_qc_issue+0x1d0/0x4c4)
[<c0288e08>] (ata_qc_issue+0x0/0x4c4) from [<c0290320>] (ata_scsi_translate+0xd4/0x170)
[<c029024c>] (ata_scsi_translate+0x0/0x170) from [<c0293a84>] (ata_scsi_queuecmd+0xac/0x234)
[<c02939d8>] (ata_scsi_queuecmd+0x0/0x234) from [<c02720d0>] (scsi_dispatch_cmd+0x128/0x270)
 r8:c7d792e0 r7:c7df3400 r6:c7c3f9c0 r5:c7df3c00 r4:80000013
[<c0271fa8>] (scsi_dispatch_cmd+0x0/0x270) from [<c027824c>] (scsi_request_fn+0x1cc/0x318)
 r7:c7e03160 r6:c7df3400 r5:c7df3c00 r4:c7c3f9c0
[<c0278080>] (scsi_request_fn+0x0/0x318) from [<c020fba4>] (__generic_unplug_device+0x38/0x3c)
[<c020fb6c>] (__generic_unplug_device+0x0/0x3c) from [<c020fe20>] (generic_unplug_device+0x24/0x3)
 r4:c7e03160
[<c020fdfc>] (generic_unplug_device+0x0/0x30) from [<c020e394>] (blk_unplug+0x1c/0x20)
 r4:c7c19814
[<c020e378>] (blk_unplug+0x0/0x20) from [<c020e3ac>] (blk_backing_dev_unplug+0x14/0x18)
[<c020e398>] (blk_backing_dev_unplug+0x0/0x18) from [<c00bfce8>] (block_sync_page+0x50/0x58)
[<c00bfc98>] (block_sync_page+0x0/0x58) from [<c00731a0>] (sync_page+0x4c/0x5c)
[<c0073154>] (sync_page+0x0/0x5c) from [<c03b3428>] (__wait_on_bit_lock+0x68/0xa4)
[<c03b33c0>] (__wait_on_bit_lock+0x0/0xa4) from [<c007312c>] (__lock_page+0x58/0x68)
[<c00730d4>] (__lock_page+0x0/0x68) from [<c00739b4>] (read_cache_page_async+0x10c/0x1b0)
[<c00738a8>] (read_cache_page_async+0x0/0x1b0) from [<c0075954>] (read_cache_page+0x14/0x68)
[<c0075940>] (read_cache_page+0x0/0x68) from [<c00dcbdc>] (read_dev_sector+0x30/0x88)
 r4:00000000
[<c00dcbac>] (read_dev_sector+0x0/0x88) from [<c00def68>] (ldm_partition+0x48/0x1274)
 r5:c7cb1000 r4:c00def20
[<c00def20>] (ldm_partition+0x0/0x1274) from [<c00dd288>] (rescan_partitions+0x130/0x270)
[<c00dd158>] (rescan_partitions+0x0/0x270) from [<c00c78c8>] (do_open+0x22c/0x2f8)
[<c00c769c>] (do_open+0x0/0x2f8) from [<c00c7a08>] (__blkdev_get+0x74/0x80)
[<c00c7994>] (__blkdev_get+0x0/0x80) from [<c00c7a28>] (blkdev_get+0x14/0x18)
[<c00c7a14>] (blkdev_get+0x0/0x18) from [<c00dd13c>] (register_disk+0x15c/0x178)
[<c00dcfe0>] (register_disk+0x0/0x178) from [<c0214518>] (add_disk+0x50/0x68)
 r7:c7cb1000 r6:c7df3c00 r5:c7e28800 r4:c7cb1000
[<c02144c8>] (add_disk+0x0/0x68) from [<c027f128>] (sd_probe+0x234/0x394)
 r4:c7e28808
[<c027eef4>] (sd_probe+0x0/0x394) from [<c02590dc>] (driver_probe_device+0xac/0x1b0)
[<c0259030>] (driver_probe_device+0x0/0x1b0) from [<c02591f0>] (__device_attach+0x10/0x14)
 r8:c7df3cd8 r7:c02591e0 r6:c7df3cd8 r5:c7c19c34 r4:00000000
[<c02591e0>] (__device_attach+0x0/0x14) from [<c0258154>] (bus_for_each_drv+0x68/0x94)
[<c02580ec>] (bus_for_each_drv+0x0/0x94) from [<c02592b4>] (device_attach+0x94/0x9c)
 r7:00000000 r6:c7df3cd8 r5:c7df3df0 r4:c7df3cd8
[<c0259220>] (device_attach+0x0/0x9c) from [<c02580bc>] (bus_attach_device+0x4c/0x7c)
 r5:c7df3cd8 r4:c04b28e4
[<c0258070>] (bus_attach_device+0x0/0x7c) from [<c0256acc>] (device_add+0x3a0/0x53c)
 r5:00000000 r4:c7df3dd4
[<c025672c>] (device_add+0x0/0x53c) from [<c027badc>] (scsi_sysfs_add_sdev+0x38/0x1b8)
[<c027baa4>] (scsi_sysfs_add_sdev+0x0/0x1b8) from [<c0279700>] (scsi_probe_and_add_lun+0x880/0x8b)
 r8:c7df3c00 r7:00000000 r6:c7cdec20 r5:c7cdec10 r4:c7cdec08
[<c0278e80>] (scsi_probe_and_add_lun+0x0/0x8b8) from [<c027a678>] (__scsi_add_device+0xf0/0xfc)
[<c027a588>] (__scsi_add_device+0x0/0xfc) from [<c0291b7c>] (ata_scsi_scan_host+0x100/0x30c)
 r8:00000005 r7:00000000 r6:c7e7c000 r5:c7e7da88 r4:c7e7dbb0
[<c0291a7c>] (ata_scsi_scan_host+0x0/0x30c) from [<c028da70>] (ata_host_register+0x280/0x328)
[<c028d7f0>] (ata_host_register+0x0/0x328) from [<c028dbbc>] (ata_host_activate+0xa4/0x104)
[<c028db18>] (ata_host_activate+0x0/0x104) from [<c029ce40>] (mv_platform_probe+0x170/0x1b4)
 r8:c04993d0 r7:c7cdea90 r6:c049a1cc r5:00000000 r4:c04993c8
[<c029ccd0>] (mv_platform_probe+0x0/0x1b4) from [<c025ae04>] (platform_drv_probe+0x20/0x24)
[<c025ade4>] (platform_drv_probe+0x0/0x24) from [<c02590dc>] (driver_probe_device+0xac/0x1b0)
[<c0259030>] (driver_probe_device+0x0/0x1b0) from [<c02593a0>] (__driver_attach+0xe4/0xe8)
 r8:c04afe08 r7:c02592bc r6:c04b37ec r5:c04993d0 r4:c04994e8
[<c02592bc>] (__driver_attach+0x0/0xe8) from [<c02582dc>] (bus_for_each_dev+0x58/0x84)
 r5:c7c19ed4 r4:00000000
[<c0258284>] (bus_for_each_dev+0x0/0x84) from [<c0258f3c>] (driver_attach+0x20/0x28)
 r7:c0024b2c r6:c04b37ec r5:00000000 r4:00000000
[<c0258f1c>] (driver_attach+0x0/0x28) from [<c0258c84>] (bus_add_driver+0xa4/0x238)
[<c0258be0>] (bus_add_driver+0x0/0x238) from [<c02595f4>] (driver_register+0x44/0x100)
[<c02595b0>] (driver_register+0x0/0x100) from [<c025b090>] (platform_driver_register+0x6c/0x88)
 r8:c7c18000 r7:c0024b2c r6:00000000 r5:00000000 r4:00000000
[<c025b024>] (platform_driver_register+0x0/0x88) from [<c001d070>] (mv_init+0x30/0x5c)
[<c001d040>] (mv_init+0x0/0x5c) from [<c000895c>] (kernel_init+0x98/0x2ac)
 r4:00000000
[<c00088c4>] (kernel_init+0x0/0x2ac) from [<c004429c>] (do_exit+0x0/0x7f4)
Code: e795c003 e3a08001 e59c3020 e2000003 (e5932000)
---[ end trace 8ae6add94ca40006 ]---



From: Byron Bradley <byron.bbradley@gmail.com>
Subject: [PATCH] sata_mv: platform driver allocs dma without create

When the sata_mv driver is used as a platform driver,
mv_create_dma_pools() is never called so it fails when trying
to alloc in mv_pool_start().

Signed-off-by: Byron Bradley <byron.bbradley@gmail.com>

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index f5333ce..04b5717 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -2881,6 +2881,26 @@ done:
 	return rc;
 }

+static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device *dev)
+{
+	hpriv->crqb_pool   = dmam_pool_create("crqb_q", dev, MV_CRQB_Q_SZ,
+							     MV_CRQB_Q_SZ, 0);
+	if (!hpriv->crqb_pool)
+		return -ENOMEM;
+
+	hpriv->crpb_pool   = dmam_pool_create("crpb_q", dev, MV_CRPB_Q_SZ,
+							     MV_CRPB_Q_SZ, 0);
+	if (!hpriv->crpb_pool)
+		return -ENOMEM;
+
+	hpriv->sg_tbl_pool = dmam_pool_create("sg_tbl", dev, MV_SG_TBL_SZ,
+							     MV_SG_TBL_SZ, 0);
+	if (!hpriv->sg_tbl_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
 /**
  *      mv_platform_probe - handle a positive probe of an soc Marvell
  *      host
@@ -2934,6 +2954,10 @@ static int mv_platform_probe(struct platform_device *pdev)
 	hpriv->base = ioremap(res->start, res->end - res->start + 1);
 	hpriv->base -= MV_SATAHC0_REG_BASE;

+	rc = mv_create_dma_pools(hpriv, &pdev->dev);
+	if (rc)
+		return rc;
+
 	/* initialize adapter */
 	rc = mv_init_host(host, chip_soc);
 	if (rc)
@@ -3070,26 +3094,6 @@ static void mv_print_info(struct ata_host *host)
 	       scc_s, (MV_HP_FLAG_MSI & hpriv->hp_flags) ? "MSI" : "INTx");
 }

-static int mv_create_dma_pools(struct mv_host_priv *hpriv, struct device *dev)
-{
-	hpriv->crqb_pool   = dmam_pool_create("crqb_q", dev, MV_CRQB_Q_SZ,
-							     MV_CRQB_Q_SZ, 0);
-	if (!hpriv->crqb_pool)
-		return -ENOMEM;
-
-	hpriv->crpb_pool   = dmam_pool_create("crpb_q", dev, MV_CRPB_Q_SZ,
-							     MV_CRPB_Q_SZ, 0);
-	if (!hpriv->crpb_pool)
-		return -ENOMEM;
-
-	hpriv->sg_tbl_pool = dmam_pool_create("sg_tbl", dev, MV_SG_TBL_SZ,
-							     MV_SG_TBL_SZ, 0);
-	if (!hpriv->sg_tbl_pool)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /**
  *      mv_pci_init_one - handle a positive probe of a PCI Marvell host
  *      @pdev: PCI device found
