From: Dmitry Vyukov <dvyukov@google.com>
Subject: ata: WARNING in ata_qc_issue
Date: Thu, 23 Mar 2017 14:25:02 +0100
Message-ID: <CACT4Y+YJznO4fj5zuEELE9DTf6jL2tx5EkGLdQff09iYMsmTZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34172 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbdCWNZY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2017 09:25:24 -0400
Received: by mail-vk0-f52.google.com with SMTP id z204so89577886vkd.1
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2017 06:25:23 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>

Hello,

The following program triggers WARNING in ata_qc_issue:
https://gist.githubusercontent.com/dvyukov/3503afce181b7d48dabb421e10e70b00/raw/d049bd2128a8b1089497beb6104ba48c5550b4a8/gistfile1.txt

------------[ cut here ]------------
WARNING: CPU: 3 PID: 2956 at drivers/ata/libata-core.c:5317
ata_qc_issue+0xd14/0x1040 drivers/ata/libata-core.c:5316
CPU: 3 PID: 2956 Comm: a.out Not tainted 4.11.0-rc3+ #365
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x1b8/0x28d lib/dump_stack.c:52
 panic+0x20c/0x423 kernel/panic.c:180
 __warn+0x1c4/0x1e0 kernel/panic.c:541
 warn_slowpath_null+0x2c/0x40 kernel/panic.c:584
 ata_qc_issue+0xd14/0x1040 drivers/ata/libata-core.c:5316
 ata_scsi_translate+0x34a/0x5e0 drivers/ata/libata-scsi.c:2021
 __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4249 [inline]
 ata_scsi_queuecmd+0x2ae/0x660 drivers/ata/libata-scsi.c:4298
 scsi_dispatch_cmd+0x43e/0xb70 drivers/scsi/scsi_lib.c:1665
 scsi_request_fn+0x13dc/0x1ec0 drivers/scsi/scsi_lib.c:1800
 __blk_run_queue_uncond block/blk-core.c:305 [inline]
 __blk_run_queue+0xe3/0x150 block/blk-core.c:323
 __elv_add_request+0x494/0xce0 block/elevator.c:677
 blk_execute_rq_nowait+0x214/0x370 block/blk-exec.c:78
 blk_execute_rq+0x1ca/0x280 block/blk-exec.c:103
 sg_scsi_ioctl+0x3d0/0x7f0 block/scsi_ioctl.c:510
 sg_ioctl+0x1fdd/0x2f00 drivers/scsi/sg.c:1075
 vfs_ioctl fs/ioctl.c:45 [inline]
 do_vfs_ioctl+0x1af/0x16d0 fs/ioctl.c:685
 SYSC_ioctl fs/ioctl.c:700 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x434cd9
RSP: 002b:00007ffc5cd86308 EFLAGS: 00000286 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002b0 RCX: 0000000000434cd9
RDX: 0000000020001000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000000086 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000000
R13: 0000000000401a30 R14: 0000000000401ac0 R15: 0000000000000000

On commit 093b995e3b55a0ae0670226ddfcb05bfbf0099ae
