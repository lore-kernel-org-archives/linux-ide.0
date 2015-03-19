From: Tejun Heo <tj@kernel.org>
Subject: [PATCH libata/for-4.0-fixes] ata: Add a new flag to destinguish sas
 controller
Date: Thu, 19 Mar 2015 14:17:42 -0400
Message-ID: <20150319181742.GA19657@htj.duckdns.org>
References: <5500863D.4070807@cybernetics.com>
 <5500B783.20106@fb.com>
 <5500BF6F.6080000@cybernetics.com>
 <20150312023148.GA1960870@devbig257.prn2.facebook.com>
 <CAPcyv4izOUB93ySh1Qua6qbDC8utgCjY5Zj__NbUXvS9MNY5EQ@mail.gmail.com>
 <20150312121157.GH25944@htj.duckdns.org>
 <20150312124601.GA2750169@devbig257.prn2.facebook.com>
 <20150312135926.GK25944@htj.duckdns.org>
 <20150312173218.GA3109737@devbig257.prn2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:35619 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbbCSSRr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Mar 2015 14:17:47 -0400
Content-Disposition: inline
In-Reply-To: <20150312173218.GA3109737@devbig257.prn2.facebook.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Tony Battersby <tonyb@cybernetics.com>, Jens Axboe <axboe@fb.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

>From 5067c0469c643512f24786990e315f9c15cc7d24 Mon Sep 17 00:00:00 2001
From: Shaohua Li <shli@fb.com>
Date: Thu, 12 Mar 2015 10:32:18 -0700

SAS controller has its own tag allocation, which doesn't directly match to ATA
tag, so SAS and SATA have different code path for ata tags. Originally we use
port->scsi_host (98bd4be1) to destinguish SAS controller, but libsas set
->scsi_host too, so we can't use it for the destinguish, we add a new flag for
this purpose.

Without this patch, the following oops can happen because scsi-mq uses
a host-wide tag map shared among all devices with some integer tag
values >= ATA_MAX_QUEUE.  These unexpectedly high tag values cause
__ata_qc_from_tag() to return NULL, which is then dereferenced in
ata_qc_new_init().

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
  IP: [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
  PGD 32adf0067 PUD 32adf1067 PMD 0
  Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
  Modules linked in: iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi igb
  i2c_algo_bit ptp pps_core pm80xx libsas scsi_transport_sas sg coretemp
  eeprom w83795 i2c_i801
  CPU: 4 PID: 1450 Comm: cydiskbench Not tainted 4.0.0-rc3 #1
  Hardware name: Supermicro X8DTH-i/6/iF/6F/X8DTH, BIOS 2.1b       05/04/12
  task: ffff8800ba86d500 ti: ffff88032a064000 task.ti: ffff88032a064000
  RIP: 0010:[<ffffffff804fd46e>]  [<ffffffff804fd46e>] ata_qc_new_init+0x3e/0x120
  RSP: 0018:ffff88032a067858  EFLAGS: 00010046
  RAX: 0000000000000000 RBX: ffff8800ba0d2230 RCX: 000000000000002a
  RDX: ffffffff80505ae0 RSI: 0000000000000020 RDI: ffff8800ba0d2230
  RBP: ffff88032a067868 R08: 0000000000000201 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800ba0d0000
  R13: ffff8800ba0d2230 R14: ffffffff80505ae0 R15: ffff8800ba0d0000
  FS:  0000000041223950(0063) GS:ffff88033e480000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
  CR2: 0000000000000058 CR3: 000000032a0a3000 CR4: 00000000000006e0
  Stack:
   ffff880329eee758 ffff880329eee758 ffff88032a0678a8 ffffffff80502dad
   ffff8800ba167978 ffff880329eee758 ffff88032bf9c520 ffff8800ba167978
   ffff88032bf9c520 ffff88032bf9a290 ffff88032a0678b8 ffffffff80506909
  Call Trace:
   [<ffffffff80502dad>] ata_scsi_translate+0x3d/0x1b0
   [<ffffffff80506909>] ata_sas_queuecmd+0x149/0x2a0
   [<ffffffffa0046650>] sas_queuecommand+0xa0/0x1f0 [libsas]
   [<ffffffff804ea544>] scsi_dispatch_cmd+0xd4/0x1a0
   [<ffffffff804eb50f>] scsi_queue_rq+0x66f/0x7f0
   [<ffffffff803e5098>] __blk_mq_run_hw_queue+0x208/0x3f0
   [<ffffffff803e54b8>] blk_mq_run_hw_queue+0x88/0xc0
   [<ffffffff803e5c74>] blk_mq_insert_request+0xc4/0x130
   [<ffffffff803e0b63>] blk_execute_rq_nowait+0x73/0x160
   [<ffffffffa0023fca>] sg_common_write+0x3da/0x720 [sg]
   [<ffffffffa0025100>] sg_new_write+0x250/0x360 [sg]
   [<ffffffffa0025feb>] sg_write+0x13b/0x450 [sg]
   [<ffffffff8032ec91>] vfs_write+0xd1/0x1b0
   [<ffffffff8032ee54>] SyS_write+0x54/0xc0
   [<ffffffff80689932>] system_call_fastpath+0x12/0x17

tj: updated description.

Fixes: 12cb5ce101ab ("libata: use blk taging")
Reported-and-tested-by: Tony Battersby <tonyb@cybernetics.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied with description updated.

Thanks.

 drivers/ata/libata-core.c     | 4 ++--
 drivers/scsi/ipr.c            | 3 ++-
 drivers/scsi/libsas/sas_ata.c | 3 ++-
 include/linux/libata.h        | 1 +
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4c35f08..ef150eb 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4737,7 +4737,7 @@ struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev, int tag)
 		return NULL;
 
 	/* libsas case */
-	if (!ap->scsi_host) {
+	if (ap->flags & ATA_FLAG_SAS_HOST) {
 		tag = ata_sas_allocate_tag(ap);
 		if (tag < 0)
 			return NULL;
@@ -4776,7 +4776,7 @@ void ata_qc_free(struct ata_queued_cmd *qc)
 	tag = qc->tag;
 	if (likely(ata_tag_valid(tag))) {
 		qc->tag = ATA_TAG_POISON;
-		if (!ap->scsi_host)
+		if (ap->flags & ATA_FLAG_SAS_HOST)
 			ata_sas_free_tag(tag, ap);
 	}
 }
diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 9219953..d9afc51 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -6815,7 +6815,8 @@ static struct ata_port_operations ipr_sata_ops = {
 };
 
 static struct ata_port_info sata_port_info = {
-	.flags		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA,
+	.flags		= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
+			  ATA_FLAG_SAS_HOST,
 	.pio_mask	= ATA_PIO4_ONLY,
 	.mwdma_mask	= ATA_MWDMA2,
 	.udma_mask	= ATA_UDMA6,
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 932d9cc..9c706d8 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -547,7 +547,8 @@ static struct ata_port_operations sas_sata_ops = {
 };
 
 static struct ata_port_info sata_port_info = {
-	.flags = ATA_FLAG_SATA | ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ,
+	.flags = ATA_FLAG_SATA | ATA_FLAG_PIO_DMA | ATA_FLAG_NCQ |
+		 ATA_FLAG_SAS_HOST,
 	.pio_mask = ATA_PIO4,
 	.mwdma_mask = ATA_MWDMA2,
 	.udma_mask = ATA_UDMA6,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fc03efa..6b08cc1 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -232,6 +232,7 @@ enum {
 					      * led */
 	ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
 	ATA_FLAG_LOWTAG		= (1 << 24), /* host wants lowest available tag */
+	ATA_FLAG_SAS_HOST	= (1 << 25), /* SAS host */
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
-- 
2.1.0

