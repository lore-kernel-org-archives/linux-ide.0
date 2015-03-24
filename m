From: Tejun Heo <tj@kernel.org>
Subject: [libata/for-4.1 PATCH] libata: remove ATA_FLAG_LOWTAG
Date: Tue, 24 Mar 2015 14:29:47 -0400
Message-ID: <20150324182947.GN3880@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:33474 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbbCXSaK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Mar 2015 14:30:10 -0400
Received: by qgfa8 with SMTP id a8so2734384qgf.0
        for <linux-ide@vger.kernel.org>; Tue, 24 Mar 2015 11:30:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-ide@vger.kernel.org

>From 3a02824396c1df1db422d067b0fdcac724f44dd6 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 24 Mar 2015 14:14:18 -0400

sata_sil24 for some reason pukes when tags are allocated round-robin
which helps tag ordered controllers.  To work around the issue,
72dd299d5039 ("libata: allow sata_sil24 to opt-out of tag ordered
submission") introduced ATA_FLAG_LOWTAG which tells libata tag
allocation to do lowest-first.

However, with the recent switch to blk-mq tag allocation, the liata
tag allocation code path is no longer used and the workaround is now
implemented in the block layer and selected by setting
scsi_host_template->tag_alloc_policy to BLK_TAG_ALLOC_FIFO.  See
9269e23496dd ("libata: make sata_sil24 use fifo tag allocator").

This leaves ATA_FLAG_LOWTAG withoout any actual user.  Remove it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Shaohua Li <shli@fb.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
Applied to libata/for-4.1.

Thanks.

 drivers/ata/libata-scsi.c | 5 +----
 drivers/ata/sata_sil24.c  | 2 +-
 include/linux/libata.h    | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index b061ba2..fd9be17 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4240,10 +4240,7 @@ int ata_sas_allocate_tag(struct ata_port *ap)
 	unsigned int i, tag;
 
 	for (i = 0, tag = ap->sas_last_tag + 1; i < max_queue; i++, tag++) {
-		if (ap->flags & ATA_FLAG_LOWTAG)
-			tag = 1;
-		else
-			tag = tag < max_queue ? tag : 0;
+		tag = tag < max_queue ? tag : 0;
 
 		/* the last tag is reserved for internal command. */
 		if (tag == ATA_TAG_INTERNAL)
diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index ba2667f..5242897 100644
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
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fc03efa..ebe132a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -231,7 +231,6 @@ enum {
 	ATA_FLAG_SW_ACTIVITY	= (1 << 22), /* driver supports sw activity
 					      * led */
 	ATA_FLAG_NO_DIPM	= (1 << 23), /* host not happy with DIPM */
-	ATA_FLAG_LOWTAG		= (1 << 24), /* host wants lowest available tag */
 
 	/* bits 24:31 of ap->flags are reserved for LLD specific flags */
 
-- 
2.1.0

