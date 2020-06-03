Return-Path: <SRS0=RB9J=7Q=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9919EC433DF
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 12:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7765320678
	for <linux-ide@archiver.kernel.org>; Wed,  3 Jun 2020 12:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgFCMcf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:32:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47970 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbgFCMce (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 3 Jun 2020 08:32:34 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B242ED9D6CD8C02E338C;
        Wed,  3 Jun 2020 20:32:28 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 20:32:20 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <axboe@kernel.dk>, <linux-ide@vger.kernel.org>,
        <hch@infradead.org>, <pbonzini@redhat.com>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2] ata/libata: Fix usage of page address by page_address in ata_scsi_mode_select_xlat function
Date:   Wed, 3 Jun 2020 20:39:24 +0800
Message-ID: <20200603123924.135160-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

BUG: KASAN: use-after-free in ata_scsi_mode_select_xlat+0x10bd/0x10f0
drivers/ata/libata-scsi.c:4045
Read of size 1 at addr ffff88803b8cd003 by task syz-executor.6/12621

CPU: 1 PID: 12621 Comm: syz-executor.6 Not tainted 4.19.95 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
Call Trace:
__dump_stack lib/dump_stack.c:77 [inline]
dump_stack+0xac/0xee lib/dump_stack.c:118
print_address_description+0x60/0x223 mm/kasan/report.c:253
kasan_report_error mm/kasan/report.c:351 [inline]
kasan_report mm/kasan/report.c:409 [inline]
kasan_report.cold+0xae/0x2d8 mm/kasan/report.c:393
ata_scsi_mode_select_xlat+0x10bd/0x10f0 drivers/ata/libata-scsi.c:4045
ata_scsi_translate+0x2da/0x680 drivers/ata/libata-scsi.c:2035
__ata_scsi_queuecmd drivers/ata/libata-scsi.c:4360 [inline]
ata_scsi_queuecmd+0x2e4/0x790 drivers/ata/libata-scsi.c:4409
scsi_dispatch_cmd+0x2ee/0x6c0 drivers/scsi/scsi_lib.c:1867
scsi_queue_rq+0xfd7/0x1990 drivers/scsi/scsi_lib.c:2170
blk_mq_dispatch_rq_list+0x1e1/0x19a0 block/blk-mq.c:1186
blk_mq_do_dispatch_sched+0x147/0x3d0 block/blk-mq-sched.c:108
blk_mq_sched_dispatch_requests+0x427/0x680 block/blk-mq-sched.c:204
__blk_mq_run_hw_queue+0xbc/0x200 block/blk-mq.c:1308
__blk_mq_delay_run_hw_queue+0x3c0/0x460 block/blk-mq.c:1376
blk_mq_run_hw_queue+0x152/0x310 block/blk-mq.c:1413
blk_mq_sched_insert_request+0x337/0x6c0 block/blk-mq-sched.c:397
blk_execute_rq_nowait+0x124/0x320 block/blk-exec.c:64
blk_execute_rq+0xc5/0x112 block/blk-exec.c:101
sg_scsi_ioctl+0x3b0/0x6a0 block/scsi_ioctl.c:507
sg_ioctl+0xd37/0x23f0 drivers/scsi/sg.c:1106
vfs_ioctl fs/ioctl.c:46 [inline]
file_ioctl fs/ioctl.c:501 [inline]
do_vfs_ioctl+0xae6/0x1030 fs/ioctl.c:688
ksys_ioctl+0x76/0xa0 fs/ioctl.c:705
__do_sys_ioctl fs/ioctl.c:712 [inline]
__se_sys_ioctl fs/ioctl.c:710 [inline]
__x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:710
do_syscall_64+0xa0/0x2e0 arch/x86/entry/common.c:293
entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c479
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89
f7 48
89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
ff 0f
83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb0e9602c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb0e96036d4 RCX: 000000000045c479
RDX: 0000000020000040 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 000000000076bfc0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 000000000000046d R14: 00000000004c6e1a R15: 000000000076bfcc

Allocated by task 12577:
set_track mm/kasan/kasan.c:460 [inline]
kasan_kmalloc mm/kasan/kasan.c:553 [inline]
kasan_kmalloc+0xbf/0xe0 mm/kasan/kasan.c:531
__kmalloc+0xf3/0x1e0 mm/slub.c:3749
kmalloc include/linux/slab.h:520 [inline]
load_elf_phdrs+0x118/0x1b0 fs/binfmt_elf.c:441
load_elf_binary+0x2de/0x4610 fs/binfmt_elf.c:737
search_binary_handler fs/exec.c:1654 [inline]
search_binary_handler+0x15c/0x4e0 fs/exec.c:1632
exec_binprm fs/exec.c:1696 [inline]
__do_execve_file.isra.0+0xf52/0x1a90 fs/exec.c:1820
do_execveat_common fs/exec.c:1866 [inline]
do_execve fs/exec.c:1883 [inline]
__do_sys_execve fs/exec.c:1964 [inline]
__se_sys_execve fs/exec.c:1959 [inline]
__x64_sys_execve+0x8a/0xb0 fs/exec.c:1959
do_syscall_64+0xa0/0x2e0 arch/x86/entry/common.c:293
entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 12577:
set_track mm/kasan/kasan.c:460 [inline]
__kasan_slab_free+0x129/0x170 mm/kasan/kasan.c:521
slab_free_hook mm/slub.c:1370 [inline]
slab_free_freelist_hook mm/slub.c:1397 [inline]
slab_free mm/slub.c:2952 [inline]
kfree+0x8b/0x1a0 mm/slub.c:3904
load_elf_binary+0x1be7/0x4610 fs/binfmt_elf.c:1118
search_binary_handler fs/exec.c:1654 [inline]
search_binary_handler+0x15c/0x4e0 fs/exec.c:1632
exec_binprm fs/exec.c:1696 [inline]
__do_execve_file.isra.0+0xf52/0x1a90 fs/exec.c:1820
do_execveat_common fs/exec.c:1866 [inline]
do_execve fs/exec.c:1883 [inline]
__do_sys_execve fs/exec.c:1964 [inline]
__se_sys_execve fs/exec.c:1959 [inline]
__x64_sys_execve+0x8a/0xb0 fs/exec.c:1959
do_syscall_64+0xa0/0x2e0 arch/x86/entry/common.c:293
entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff88803b8ccf00
which belongs to the cache kmalloc-512 of size 512
The buggy address is located 259 bytes inside of
512-byte region [ffff88803b8ccf00, ffff88803b8cd100)
The buggy address belongs to the page:
page:ffffea0000ee3300 count:1 mapcount:0 mapping:ffff88806cc03080
index:0xffff88803b8cc780 compound_mapcount: 0
flags: 0x100000000008100(slab|head)
raw: 0100000000008100 ffffea0001104080 0000000200000002 ffff88806cc03080
raw: ffff88803b8cc780 00000000800c000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
ffff88803b8ccf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88803b8ccf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803b8cd000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88803b8cd080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88803b8cd100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

You can refer to "https://www.lkml.org/lkml/2019/1/17/474" reproduce
this error.

The exception code is "bd_len = p[3];", "p" value is ffff88803b8cd000
which belongs to the cache kmalloc-512 of size 512. The "page_address(sg_page(scsi_sglist(scmd)))"
maybe from sg_scsi_ioctl function "buffer" which allocated by kzalloc, so "buffer"
may not page aligned.
This also looks completely buggy on highmem systems and really needs to use a
kmap_atomic.      --Christoph Hellwig
To address above bugs, Paolo Bonzini advise to simpler to just make a char array
of size CACHE_MPAGE_LEN+8+8+4-2(or just 64 to make it easy), use sg_copy_to_buffer
to copy from the sglist into the buffer, and workthere.
---
 drivers/ata/libata-scsi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 435781a16875..2e1b569334c2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3684,12 +3684,13 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *scmd = qc->scsicmd;
 	const u8 *cdb = scmd->cmnd;
-	const u8 *p;
 	u8 pg, spg;
 	unsigned six_byte, pg_len, hdr_len, bd_len;
 	int len;
 	u16 fp = (u16)-1;
 	u8 bp = 0xff;
+	u8 buffer[64];
+	u8 *p = buffer;
 
 	VPRINTK("ENTER\n");
 
@@ -3723,12 +3724,14 @@ static unsigned int ata_scsi_mode_select_xlat(struct ata_queued_cmd *qc)
 	if (!scsi_sg_count(scmd) || scsi_sglist(scmd)->length < len)
 		goto invalid_param_len;
 
-	p = page_address(sg_page(scsi_sglist(scmd)));
-
 	/* Move past header and block descriptors.  */
 	if (len < hdr_len)
 		goto invalid_param_len;
 
+	if (sg_copy_to_buffer(scsi_sglist(scmd), scsi_sg_count(scmd),
+			      buffer, 64) != 64)
+		goto invalid_param_len;
+
 	if (six_byte)
 		bd_len = p[3];
 	else
-- 
2.16.2.dirty

