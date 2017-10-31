From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: BUG: unable to handle kernel paging request in ata_bmdma_qc_prep
Date: Tue, 31 Oct 2017 13:08:06 +0300
Message-ID: <CACT4Y+ZyY6sniPhH+yyU2V4sGeaMJkrV_2piD5_+1-9pdMnvgA@mail.gmail.com>
References: <001a114aa95cfa4339055cd4e8e0@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001a114aa95cfa4339055cd4e8e0@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <bot+1ff6f9fcc3c35f1c72a95e26528c8e7e3276e4da@syzkaller.appspotmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Oct 31, 2017 at 1:06 PM, syzbot
<bot+1ff6f9fcc3c35f1c72a95e26528c8e7e3276e4da@syzkaller.appspotmail.com>
wrote:
> Hello,
>
> syzkaller hit the following crash on
> 1f183459b5144384e2669a3f757d36bacab108cf
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers

This also happened on more recent commits, including linux-next
36ef71cae353f88fd6e095e2aaa3e5953af1685d (few days ago):

BUG: unable to handle kernel paging request at ffffed01078d4fff
IP: ata_bmdma_fill_sg drivers/ata/libata-sff.c:2650 [inline]
IP: ata_bmdma_qc_prep+0x30a/0x3d0 drivers/ata/libata-sff.c:2727
PGD 7fff6067 P4D 7fff6067 PUD 0
Oops: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 3 PID: 14842 Comm: syz-executor0 Not tainted 4.14.0-rc5-next-20171018+ #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff8800618ce4c0 task.stack: ffff880061760000
RIP: 0010:ata_bmdma_fill_sg drivers/ata/libata-sff.c:2650 [inline]
RIP: 0010:ata_bmdma_qc_prep+0x30a/0x3d0 drivers/ata/libata-sff.c:2727
RSP: 0018:ffff880061766e10 EFLAGS: 00010807
RAX: dffffc0000000000 RBX: ffff88083c6a7ff8 RCX: ffffffff8378cee1
RDX: 1ffff101078d4fff RSI: ffffc90004024000 RDI: ffff88083c6a7ffc
RBP: ffff880061766e70 R08: ffff88003c6b02a4 R09: ffff88003c6b02a8
R10: 0000000000000003 R11: ffffed00078d6051 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  00007f298a7bb700(0000) GS:ffff88006df00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed01078d4fff CR3: 0000000062c5e000 CR4: 00000000000006e0
DR0: 0000000020000000 DR1: 0000000020001000 DR2: 0000000020001000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 ata_qc_issue+0x61e/0xe40 drivers/ata/libata-core.c:5411
 ata_scsi_translate+0x34a/0x5e0 drivers/ata/libata-scsi.c:2024
 __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4326 [inline]
 ata_scsi_queuecmd+0x2ae/0x6b0 drivers/ata/libata-scsi.c:4375
 scsi_dispatch_cmd+0x432/0xb60 drivers/scsi/scsi_lib.c:1713
 scsi_request_fn+0xdf0/0x1e50 drivers/scsi/scsi_lib.c:1851
 __blk_run_queue_uncond block/blk-core.c:376 [inline]
 __blk_run_queue+0x1a6/0x370 block/blk-core.c:396
 blk_execute_rq_nowait+0x200/0x310 block/blk-exec.c:78
 sg_common_write.isra.17+0xbf8/0x1cb0 drivers/scsi/sg.c:806
 sg_new_write.isra.20+0x5c0/0x830 drivers/scsi/sg.c:746
 sg_ioctl+0x1be4/0x2d90 drivers/scsi/sg.c:890
 vfs_ioctl fs/ioctl.c:45 [inline]
 do_vfs_ioctl+0x1b1/0x1520 fs/ioctl.c:685
 SYSC_ioctl fs/ioctl.c:700 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:691
 entry_SYSCALL_64_fastpath+0x1f/0xbe
RIP: 0033:0x447c89
RSP: 002b:00007f298a7babd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f298a7bb6cc RCX: 0000000000447c89
RDX: 0000000020007000 RSI: 0000000000002285 RDI: 0000000000000017
RBP: 0000000000000082 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000027f0 R14: 00000000006e6890 R15: 00007f298a7bb700
Code: 41 8d 5e ff e8 c8 ef f5 fd 48 c1 e3 03 e8 bf ef f5 fd 48 03 5d
c8 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f>
b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 0c
RIP: ata_bmdma_fill_sg drivers/ata/libata-sff.c:2650 [inline] RSP:
ffff880061766e10
RIP: ata_bmdma_qc_prep+0x30a/0x3d0 drivers/ata/libata-sff.c:2727 RSP:
ffff880061766e10
CR2: ffffed01078d4fff
---[ end trace b511aa859839054c ]---





> IP: ata_bmdma_fill_sg drivers/ata/libata-sff.c:2650 [inline]
> IP: ata_bmdma_qc_prep+0x30a/0x3d0 drivers/ata/libata-sff.c:2727
> PGD 7fff6067 P4D 7fff6067 PUD 0
> Oops: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 2984 Comm: syzkaller781870 Not tainted 4.13.0-next-20170915+ #5
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> task: ffff88006afb03c0 task.stack: ffff88006caa0000
> RIP: 0010:ata_bmdma_fill_sg drivers/ata/libata-sff.c:2650 [inline]
> RIP: 0010:ata_bmdma_qc_prep+0x30a/0x3d0 drivers/ata/libata-sff.c:2727
> RSP: 0018:ffff88006caa7040 EFLAGS: 00010807
> RAX: dffffc0000000000 RBX: ffff88086b6d7ff8 RCX: ffff88003ae23340
> RDX: 1ffff1010d6dafff RSI: 0000000000000001 RDI: ffff88086b6d7ffc
> RBP: ffff88006caa70a0 R08: ffff88006b710234 R09: ffff88006b710238
> R10: 0000000000000003 R11: ffffed000d6e2043 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
> FS:  0000000001071880(0000) GS:ffff88003ec00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffed010d6dafff CR3: 000000003d9a9000 CR4: 00000000000006f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  ata_qc_issue+0x625/0xea0 drivers/ata/libata-core.c:5410
>  ata_scsi_translate+0x34a/0x5e0 drivers/ata/libata-scsi.c:2023
>  __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4325 [inline]
>  ata_scsi_queuecmd+0x2ae/0x6b0 drivers/ata/libata-scsi.c:4374
>  scsi_dispatch_cmd+0x432/0xb60 drivers/scsi/scsi_lib.c:1712
>  scsi_request_fn+0xdf0/0x1e50 drivers/scsi/scsi_lib.c:1847
>  __blk_run_queue_uncond block/blk-core.c:376 [inline]
>  __blk_run_queue+0x1a6/0x370 block/blk-core.c:396
>  blk_execute_rq_nowait+0x200/0x310 block/blk-exec.c:78
>  sg_common_write.isra.17+0xbf8/0x1cb0 drivers/scsi/sg.c:806
>  sg_write+0x7a6/0xca0 drivers/scsi/sg.c:677
>  __vfs_write+0xef/0x970 fs/read_write.c:479
>  vfs_write+0x18f/0x510 fs/read_write.c:543
>  SYSC_write fs/read_write.c:588 [inline]
>  SyS_write+0xef/0x220 fs/read_write.c:580
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
> RIP: 0033:0x4391a9
> RSP: 002b:00007ffdb9e3ae48 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004391a9
> RDX: 00000000000000c7 RSI: 0000000020515000 RDI: 0000000000000003
> RBP: 0000000000000082 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000000000fe R11: 0000000000000293 R12: 0000000000000000
> R13: 0000000000401e00 R14: 0000000000401e90 R15: 0000000000000000
> Code: 41 8d 5e ff e8 18 5c 07 fe 48 c1 e3 03 e8 0f 5c 07 fe 48 03 5d c8 48
> b8 00 00 00 00 00 fc ff df 48 8d 7b 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48
> 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 0c
> RIP: ata_bmdma_fill_sg drivers/ata/libata-sff.c:2650 [inline] RSP:
> ffff88006caa7040
> RIP: ata_bmdma_qc_prep+0x30a/0x3d0 drivers/ata/libata-sff.c:2727 RSP:
> ffff88006caa7040
> CR2: ffffed010d6dafff
> ---[ end trace f22b269ecd4dbac4 ]---
>
>
> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
> Please credit me with: Reported-by: syzbot
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
> Note: all commands must start from beginning of the line.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a114aa95cfa4339055cd4e8e0%40google.com.
> For more options, visit https://groups.google.com/d/optout.
