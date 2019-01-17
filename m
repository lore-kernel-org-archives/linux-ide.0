From: Kyungtae Kim <kt0755@gmail.com>
Subject: KASAN: use-after-free Read in ata_scsi_mode_select_xlat
Date: Thu, 17 Jan 2019 10:07:56 -0500
Message-ID: <CAEAjamszQXz3MizGo6WSTwiptoWE_o4wM9JaTszX=Fy26KAqCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>
Cc: Byoungyoung Lee <lifeasageek@gmail.com>, DaeRyong Jeong <threeearcat@gmail.com>, syzkaller@googlegroups.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

We report a bug in linux-4.17.19: "KASAN: use-after-free Read in
ata_scsi_mode_select_xlat"

kernel config: https://kt0755.github.io/etc/config-4.17.19
repro: https://kt0755.github.io/etc/repro.359bd.c (Not always works)

In this example, a syscall ioctl (i.e., sg_scsi_ioctl) is trying to
access data (drivers/ata/libata-scsi.c:4025),
for some reason, which had been freed by usbdev_release function.

=========================================
BUG: KASAN: use-after-free in ata_scsi_mode_select_xlat+0xd96/0x11b0
drivers/ata/libata-scsi.c:4025
Read of size 1 at addr ffff880117172003 by task syz-executor6/7232

CPU: 0 PID: 7232 Comm: syz-executor6 Not tainted 4.17.19 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xd2/0x148 lib/dump_stack.c:113
 print_address_description+0x7f/0x2c0 mm/kasan/report.c:256
 kasan_report_error mm/kasan/report.c:354 [inline]
 kasan_report+0x257/0x380 mm/kasan/report.c:412
 __asan_report_load1_noabort+0x19/0x20 mm/kasan/report.c:430
 ata_scsi_mode_select_xlat+0xd96/0x11b0 drivers/ata/libata-scsi.c:4025
 ata_scsi_translate+0x33c/0x670 drivers/ata/libata-scsi.c:2015
 __ata_scsi_queuecmd drivers/ata/libata-scsi.c:4340 [inline]
 ata_scsi_queuecmd+0x31c/0x780 drivers/ata/libata-scsi.c:4389
 scsi_dispatch_cmd+0x49b/0xba0 drivers/scsi/scsi_lib.c:1761
 scsi_queue_rq+0x1344/0x19c0 drivers/scsi/scsi_lib.c:2064
 blk_mq_dispatch_rq_list+0x1e0/0x1a50 block/blk-mq.c:1242
 blk_mq_do_dispatch_sched+0x1a0/0x410 block/blk-mq-sched.c:120
 blk_mq_sched_dispatch_requests+0x454/0x740 block/blk-mq-sched.c:216
 __blk_mq_run_hw_queue+0x145/0x210 block/blk-mq.c:1362
 __blk_mq_delay_run_hw_queue+0x3da/0x540 block/blk-mq.c:1430
 blk_mq_run_hw_queue+0x181/0x330 block/blk-mq.c:1467
 blk_mq_sched_insert_request+0x2c0/0x770 block/blk-mq-sched.c:463
 blk_execute_rq_nowait+0x14f/0x2f0 block/blk-exec.c:64
 blk_execute_rq+0xe6/0x1c0 block/blk-exec.c:101
 sg_scsi_ioctl+0x3bf/0x7b0 block/scsi_ioctl.c:509
 sg_ioctl+0x1c6f/0x2e70 drivers/scsi/sg.c:1116
 vfs_ioctl fs/ioctl.c:46 [inline]
 do_vfs_ioctl+0x1aa/0x10a0 fs/ioctl.c:686
 ksys_ioctl+0x9e/0xb0 fs/ioctl.c:701
 __do_sys_ioctl fs/ioctl.c:708 [inline]
 __se_sys_ioctl fs/ioctl.c:706 [inline]
 __x64_sys_ioctl+0x7e/0xc0 fs/ioctl.c:706
 do_syscall_64+0xc4/0x4e0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4497b9
RSP: 002b:00007f92fb915c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f92fb9166cc RCX: 00000000004497b9
RDX: 00000000200004c0 RSI: 0000000000000001 RDI: 0000000000000013
RBP: 000000000071bea0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000005c58 R14: 00000000006eecf8 R15: 00007f92fb916700

Allocated by task 7207:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 kasan_kmalloc+0xc5/0xf0 mm/kasan/kasan.c:553
 kmem_cache_alloc_trace+0x148/0x300 mm/slub.c:2768
 kmalloc include/linux/slab.h:512 [inline]
 kzalloc include/linux/slab.h:701 [inline]
 usbdev_open+0x5b/0x760 drivers/usb/core/devio.c:975
 chrdev_open+0x23a/0x640 fs/char_dev.c:417
 do_dentry_open+0x826/0xe70 fs/open.c:794
 vfs_open+0x123/0x250 fs/open.c:908
 do_last fs/namei.c:3365 [inline]
 path_openat+0x665/0x29f0 fs/namei.c:3505
 do_filp_open+0x1bd/0x2c0 fs/namei.c:3540
 do_sys_open+0x35e/0x4e0 fs/open.c:1101
 __do_sys_open fs/open.c:1119 [inline]
 __se_sys_open fs/open.c:1114 [inline]
 __x64_sys_open+0x89/0xc0 fs/open.c:1114
 do_syscall_64+0xc4/0x4e0 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 7200:
 save_stack+0x43/0xd0 mm/kasan/kasan.c:448
 set_track mm/kasan/kasan.c:460 [inline]
 __kasan_slab_free+0x14d/0x1a0 mm/kasan/kasan.c:521
 kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
 slab_free_hook mm/slub.c:1388 [inline]
 slab_free_freelist_hook mm/slub.c:1415 [inline]
 slab_free mm/slub.c:2988 [inline]
 kfree+0x109/0x340 mm/slub.c:3944
 usbdev_release+0x302/0x3a0 drivers/usb/core/devio.c:1058
 __fput+0x2c7/0x780 fs/file_table.c:209
 ____fput+0x1a/0x20 fs/file_table.c:243
 task_work_run+0x151/0x1d0 kernel/task_work.c:113
 exit_task_work include/linux/task_work.h:22 [inline]
 do_exit+0x8ba/0x30a0 kernel/exit.c:865
 do_group_exit+0x13b/0x3a0 kernel/exit.c:968
 get_signal+0x6bb/0x1650 kernel/signal.c:2482
 do_signal+0x84/0x1b70 arch/x86/kernel/signal.c:810
 exit_to_usermode_loop+0x155/0x190 arch/x86/entry/common.c:162
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:265 [inline]
 do_syscall_64+0x445/0x4e0 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff880117172000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 3 bytes inside of
 512-byte region [ffff880117172000, ffff880117172200)
The buggy address belongs to the page:
page:ffffea00045c5c80 count:1 mapcount:0 mapping:0000000000000000
index:0x0 compound_mapcount: 0
flags: 0x200000000008100(slab|head)
raw: 0200000000008100 0000000000000000 0000000000000000 00000001800c000c
raw: ffffea00043e7100 0000000500000005 ffff88011a003080 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff880117171f00: fb fb fb fb fb fb fb fb fc fc fc fc fb fb fb fb
 ffff880117171f80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
>ffff880117172000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff880117172080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff880117172100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
=========================================

Thanks,
Kyungtae Kim
