From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: WARNING in ata_qc_issue
Date: Fri, 27 Oct 2017 10:20:13 +0200
Message-ID: <CACT4Y+bkXm6JDovQsOYXu8YrpGaQgqtA+78G2utYpBRP-2OsVw@mail.gmail.com>
References: <001a11425956f5f3d0055c82f08d@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:55064 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbdJ0IUf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 27 Oct 2017 04:20:35 -0400
Received: by mail-io0-f177.google.com with SMTP id e89so11029760ioi.11
        for <linux-ide@vger.kernel.org>; Fri, 27 Oct 2017 01:20:34 -0700 (PDT)
In-Reply-To: <001a11425956f5f3d0055c82f08d@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: syzbot <bot+f7b556d1766502a69d85071d2ff08bd87be53d0f@syzkaller.appspotmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>

On Fri, Oct 27, 2017 at 10:19 AM, syzbot
<bot+f7b556d1766502a69d85071d2ff08bd87be53d0f@syzkaller.appspotmail.com>
wrote:
> Hello,
>
> syzkaller hit the following crash on
> 91dfed74eabcdae9378131546c446442c29bf769
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers


This also happened on more recent commits, including linux-next
36ef71cae353f88fd6e095e2aaa3e5953af1685d (Oct 19):

------------[ cut here ]------------
WARNING: CPU: 2 PID: 3514 at drivers/ata/libata-core.c:5395
ata_qc_issue+0x512/0xe40 drivers/ata/libata-core.c:5394
Kernel panic - not syncing: panic_on_warn set ...

CPU: 2 PID: 3514 Comm: syz-executor3 Not tainted 4.14.0-rc5-next-20171018+ #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x194/0x257 lib/dump_stack.c:52
 panic+0x1e4/0x41c kernel/panic.c:183
 __warn+0x1c4/0x1e0 kernel/panic.c:546
 report_bug+0x211/0x2d0 lib/bug.c:183
 fixup_bug+0x40/0x90 arch/x86/kernel/traps.c:177
 do_trap_no_signal arch/x86/kernel/traps.c:211 [inline]
 do_trap+0x260/0x390 arch/x86/kernel/traps.c:260
 do_error_trap+0x120/0x390 arch/x86/kernel/traps.c:297
 do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:310
 invalid_op+0x18/0x20 arch/x86/entry/entry_64.S:905
RIP: 0010:ata_qc_issue+0x512/0xe40 drivers/ata/libata-core.c:5394
RSP: 0018:ffff880050736f60 EFLAGS: 00010016
RAX: 0000000000010000 RBX: 0000000000000002 RCX: ffffffff837472d2
RDX: 0000000000000531 RSI: ffffc900018d6000 RDI: ffff88003c0d0290
RBP: ffff880050737068 R08: 0000000000000028 R09: 0000000000000000
R10: 0000000000000004 R11: ffffed000781a046 R12: 0000000000000000
R13: ffff88003c0d0248 R14: ffff88003c0d0080 R15: ffff88003c0d01f8
 ata_scsi_translate+0x34a/0x5e0 drivers/ata/libata-scsi.c:2024
 __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4326 [inline]
 ata_scsi_queuecmd+0x2ae/0x6b0 drivers/ata/libata-scsi.c:4375
 scsi_dispatch_cmd+0x432/0xb60 drivers/scsi/scsi_lib.c:1713
 scsi_request_fn+0xdf0/0x1e50 drivers/scsi/scsi_lib.c:1851
 __blk_run_queue_uncond block/blk-core.c:376 [inline]
 __blk_run_queue+0x1a6/0x370 block/blk-core.c:396
 __elv_add_request+0x497/0xce0 block/elevator.c:673
 blk_execute_rq_nowait+0x1f8/0x310 block/blk-exec.c:77
 blk_execute_rq+0x109/0x1c0 block/blk-exec.c:101
 sg_scsi_ioctl+0x38b/0x750 block/scsi_ioctl.c:508
 sg_ioctl+0x1f08/0x2d90 drivers/scsi/sg.c:1078
 vfs_ioctl fs/ioctl.c:45 [inline]
 do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:685
 SYSC_ioctl fs/ioctl.c:700 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
 entry_SYSCALL_64_fastpath+0x1f/0xbe
RIP: 0033:0x447c89
RSP: 002b:00007f28dd18ebd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f28dd18f6cc RCX: 0000000000447c89
RDX: 000000002004bff8 RSI: 0000000000000001 RDI: 0000000000000013
RBP: 0000000000000082 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000300 R14: 00000000006e43a0 R15: 00007f28dd18f700
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 86400 seconds..


> WARNING: CPU: 1 PID: 2909 at drivers/ata/libata-core.c:5391
> ata_qc_issue+0x519/0xea0 drivers/ata/libata-core.c:5390
> Kernel panic - not syncing: panic_on_warn set ...
>
> CPU: 1 PID: 2909 Comm: syzkaller668320 Not tainted 4.13.0-rc4-next-20170811
> #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>  panic+0x1e4/0x417 kernel/panic.c:180
>  __warn+0x1c4/0x1d9 kernel/panic.c:541
>  report_bug+0x211/0x2d0 lib/bug.c:183
>  fixup_bug+0x40/0x90 arch/x86/kernel/traps.c:190
>  do_trap_no_signal arch/x86/kernel/traps.c:224 [inline]
>  do_trap+0x260/0x390 arch/x86/kernel/traps.c:273
>  do_error_trap+0x120/0x390 arch/x86/kernel/traps.c:310
>  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:323
>  invalid_op+0x1e/0x30 arch/x86/entry/entry_64.S:930
> RIP: 0010:ata_qc_issue+0x519/0xea0 drivers/ata/libata-core.c:5390
> RSP: 0018:ffff880069de68f8 EFLAGS: 00010097
> RAX: ffff88006c840580 RBX: 0000000000000002 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffff88006b8b2500 RDI: ffff88006b8b0290
> RBP: ffff880069de6a10 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000004 R11: ffffed000d716046 R12: 0000000000000000
> R13: ffff88006b8b238c R14: ffff88006b8b01f8 R15: ffff88006b8b0080
>  ata_scsi_translate+0x34a/0x5e0 drivers/ata/libata-scsi.c:2023
>  __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4325 [inline]
>  ata_scsi_queuecmd+0x2ae/0x6b0 drivers/ata/libata-scsi.c:4374
>  scsi_dispatch_cmd+0x432/0xb60 drivers/scsi/scsi_lib.c:1686
>  scsi_queue_rq+0x155a/0x1e00 drivers/scsi/scsi_lib.c:1962
>  blk_mq_dispatch_rq_list+0x8bc/0x1720 block/blk-mq.c:1073
>  blk_mq_sched_dispatch_requests+0x752/0xb40 block/blk-mq-sched.c:147
>  __blk_mq_run_hw_queue+0x1aa/0x280 block/blk-mq.c:1155
>  __blk_mq_delay_run_hw_queue+0x175/0x1b0 block/blk-mq.c:1203
>  blk_mq_run_hw_queue+0x1e/0x30 block/blk-mq.c:1224
>  blk_mq_sched_insert_request+0x275/0x890 block/blk-mq-sched.c:386
>  blk_execute_rq_nowait+0x16d/0x310 block/blk-exec.c:64
>  sg_common_write.isra.17+0xf80/0x1c10 drivers/scsi/sg.c:806
>  sg_write+0x7a0/0xc90 drivers/scsi/sg.c:677
>  __vfs_write+0xef/0x970 fs/read_write.c:468
>  vfs_write+0x189/0x510 fs/read_write.c:518
>  SYSC_write fs/read_write.c:565 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:557
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
> RIP: 0033:0x439059
> RSP: 002b:00007ffe8db065b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000439059
> RDX: 000000000000002a RSI: 0000000020010000 RDI: 0000000000000003
> RBP: 0000000000000086 R08: 00000000000000fe R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000401cb0 R14: 0000000000401d40 R15: 0000000000000000
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a11425956f5f3d0055c82f08d%40google.com.
> For more options, visit https://groups.google.com/d/optout.
