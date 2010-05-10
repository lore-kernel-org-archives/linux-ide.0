From: saeed bishara <saeed.bishara@gmail.com>
Subject: [BUG] bug when enabling VM DEBUG
Date: Mon, 10 May 2010 16:06:07 +0300
Message-ID: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57300 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754322Ab0EJNGI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 May 2010 09:06:08 -0400
Received: by wyb32 with SMTP id 32so23115wyb.19
        for <linux-ide@vger.kernel.org>; Mon, 10 May 2010 06:06:07 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,
 I got the following bug when enabling the VM_DEBGU on 2.6.34-rc6:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 805 [#1]
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.34-rc6-00176-g00047b8-dirty #331)
PC is at flush_dcache_page+0x2c/0xc4
LR is at ata_pio_sector+0xd8/0x124
pc : [<c002d30c>]    lr : [<c01c29d4>]    psr: 20000013
sp : f5513ee8  ip : 79a50000  fp : 00001ee8
r10: 00000058  r9 : f54f0000  r8 : 00000000
r7 : f54f1358  r6 : c03e6b84  r5 : 00000000  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : f54f17b8  r0 : c0ac4e20
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 00004019  DAC: 00000017
Process ata/0 (pid: 145, stack limit = 0xf55122f0)
Stack: (0xf5513ee8 to 0xf5514000)
3ee0:                   c0ac4e20 c01c29d4 00000009 f54f1358 f54f1358 00000001
3f00: c040d18c c01c2ad8 00000005 00000009 f54f0000 c01c3204 c03cfe78 00000000
3f20: 00200200 f54f13d4 c00446e4 00000001 f54f1424 00000000 00000000 00000000
3f40: 00000000 00000000 ffffffff 00000009 f54f0000 f54f1358 00000001 c040d18c
3f60: 00000005 0000000a 00001ee8 c01c46d8 f5413c70 f54b5b68 c01c45d4 f54b5b60
3f80: f5512000 f5513f9c 00000000 00000000 00000000 c004b2c0 00000000 00000000
3fa0: f54be0c0 c004e12c f5513fa8 f5513fa8 f5429ec8 f5513fd4 f5429ec8 f54b5b60
3fc0: c004b1c8 00000000 00000000 c004e014 00000000 00000000 f5513fd8 f5513fd8
3fe0: 00000000 00000000 00000000 00000000 00000000 c0026dec bc7e4afb 6a3a8a30
[<c002d30c>] (flush_dcache_page+0x2c/0xc4) from [<c01c29d4>]
(ata_pio_sector+0xd8/0x124)
[<c01c29d4>] (ata_pio_sector+0xd8/0x124) from [<c01c2ad8>]
(ata_pio_sectors+0xb8/0xc4)
[<c01c2ad8>] (ata_pio_sectors+0xb8/0xc4) from [<c01c3204>]
(ata_sff_hsm_move+0x618/0x76c)
[<c01c3204>] (ata_sff_hsm_move+0x618/0x76c) from [<c01c46d8>]
(ata_pio_task+0x104/0x124)
[<c01c46d8>] (ata_pio_task+0x104/0x124) from [<c004b2c0>]
(worker_thread+0xf8/0x170)
[<c004b2c0>] (worker_thread+0xf8/0x170) from [<c004e014>] (kthread+0x78/0x80)
[<c004e014>] (kthread+0x78/0x80) from [<c0026dec>] (kernel_thread_exit+0x0/0x8)
Code: e5904010 e3130080 0a000002 e3a03000 (e5833000)
---[ end trace 8a7ce1ae66250005 ]---
