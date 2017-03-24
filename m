From: Dmitry Vyukov <dvyukov@google.com>
Subject: ata: WARNING in ata_bmdma_qc_issue
Date: Fri, 24 Mar 2017 15:14:14 +0100
Message-ID: <CACT4Y+b+t9TPkVhZPdoeSGfe3rujUdv267HW8yPqoTbKtLUScA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>
List-Id: linux-ide@vger.kernel.org

Hello,

The following program triggers WARNING in ata_bmdma_qc_issue:
https://gist.githubusercontent.com/dvyukov/7497a05853e58598b74a2c48030c41f4/raw/38885f75eb05f72bb47fff9c9de657728f529927/gistfile1.txt


------------[ cut here ]------------
WARNING: CPU: 3 PID: 2963 at drivers/ata/libata-sff.c:2827
ata_bmdma_qc_issue+0x2bb/0x5b0 drivers/ata/libata-sff.c:2827
CPU: 3 PID: 2963 Comm: a.out Not tainted 4.11.0-rc3+ #367
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x1b8/0x28d lib/dump_stack.c:52
 panic+0x20c/0x423 kernel/panic.c:180
 __warn+0x1c4/0x1e0 kernel/panic.c:541
 warn_slowpath_null+0x2c/0x40 kernel/panic.c:584
 ata_bmdma_qc_issue+0x2bb/0x5b0 drivers/ata/libata-sff.c:2827
 ata_qc_issue+0x6f2/0x1040 drivers/ata/libata-core.c:5335
 ata_scsi_translate+0x34a/0x5e0 drivers/ata/libata-scsi.c:2021
 __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4249 [inline]
 ata_scsi_queuecmd+0x2ae/0x660 drivers/ata/libata-scsi.c:4298
 scsi_dispatch_cmd+0x43e/0xb70 drivers/scsi/scsi_lib.c:1665
 scsi_request_fn+0x13dc/0x1ec0 drivers/scsi/scsi_lib.c:1800
 __blk_run_queue_uncond block/blk-core.c:305 [inline]
 __blk_run_queue+0xe3/0x150 block/blk-core.c:323
 blk_execute_rq_nowait+0x21c/0x370 block/blk-exec.c:79
 sg_common_write.isra.19+0x1057/0x1ac0 drivers/scsi/sg.c:803
 sg_write+0x78a/0xd40 drivers/scsi/sg.c:679
 __vfs_write+0xfb/0x890 fs/read_write.c:508
 vfs_write+0x187/0x530 fs/read_write.c:558
 SYSC_write fs/read_write.c:605 [inline]
 SyS_write+0xef/0x220 fs/read_write.c:597
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x4469d9
RSP: 002b:00007fff3adf5a58 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004469d9
RDX: 0000000000000090 RSI: 0000000020012000 RDI: 0000000000000003
RBP: 0000000000000086 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000402c00 R14: 0000000000402c90 R15: 0000000000000000

On commit ebe64824e9de4b3ab3bd3928312b4b2bc57b4b7e

Looks similar to the WARNING in ata_sff_qc_issue:
https://groups.google.com/forum/#!topic/syzkaller/0v1qHkmM-VU
Should we also remove the WARNING in ata_bmdma_qc_issue?
