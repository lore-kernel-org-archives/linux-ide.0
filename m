From: Shaohua Li <shli@fb.com>
Subject: [PATCH] libata: make sata_sil24 use fifo tag allocator
Date: Fri, 23 Jan 2015 20:17:59 -0800
Message-ID: <e836211c9bce48b23ddf37a4d8832e1b2fbd893c.1422072962.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7082 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751317AbbAXESF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Jan 2015 23:18:05 -0500
Received: from pps.filterd (m0004347 [127.0.0.1])
	by m0004347.ppops.net (8.14.5/8.14.5) with SMTP id t0O4H83L016798
	for <linux-ide@vger.kernel.org>; Fri, 23 Jan 2015 20:18:03 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
	by m0004347.ppops.net with ESMTP id 1s3y510ewu-2
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
	for <linux-ide@vger.kernel.org>; Fri, 23 Jan 2015 20:18:03 -0800
Received: from facebook.com (2401:db00:20:7003:face:0:4d:0)	by
 mx-out.facebook.com (10.212.232.63) with ESMTP	id
 fb722522a37f11e497d60002c992ebde-d16d7390 for <linux-ide@vger.kernel.org>;
	Fri, 23 Jan 2015 20:18:00 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>

libata starts using block tag now, we can use BLK_TAG_ALLOC_FIFO to
solve the sata_sil24 tag bug.

https://bugzilla.kernel.org/show_bug.cgi?id=87101

Cc: Jens Axboe <axboe@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/ata/sata_sil24.c | 3 ++-
 include/linux/libata.h   | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index ea65594..5242897 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -246,7 +246,7 @@ enum {
 	/* host flags */
 	SIL24_COMMON_FLAGS	= ATA_FLAG_SATA | ATA_FLAG_PIO_DMA |
 				  ATA_FLAG_NCQ | ATA_FLAG_ACPI_SATA |
-				  ATA_FLAG_AN | ATA_FLAG_PMP | ATA_FLAG_LOWTAG,
+				  ATA_FLAG_AN | ATA_FLAG_PMP,
 	SIL24_FLAG_PCIX_IRQ_WOC	= (1 << 24), /* IRQ loss errata on PCI-X */
 
 	IRQ_STAT_4PORTS		= 0xf,
@@ -388,6 +388,7 @@ static struct scsi_host_template sil24_sht = {
 	.can_queue		= SIL24_MAX_CMDS,
 	.sg_tablesize		= SIL24_MAX_SGE,
 	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.tag_alloc_policy	= BLK_TAG_ALLOC_FIFO,
 };
 
 static struct ata_port_operations sil24_ops = {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f9adde4..adad50d 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -231,7 +231,6 @@ enum {
 	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
 					      * led */
 	ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
-	ATA_FLAG_LOWTAG		= (1 << 24), /* host wants lowest available tag */
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
-- 
1.8.1

