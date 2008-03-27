From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/4] libata: make ata_tf_to_lba[48]() generic
Date: Thu, 27 Mar 2008 19:14:23 +0900
Message-ID: <12066128661215-git-send-email-htejun@gmail.com>
References: <12066128663306-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:65503 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbYC0KOf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 06:14:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4737766wah.23
        for <linux-ide@vger.kernel.org>; Thu, 27 Mar 2008 03:14:34 -0700 (PDT)
In-Reply-To: <12066128663306-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, liml@rtr.ca
Cc: Tejun Heo <htejun@gmail.com>

ata_tf_to_lba[48]() currently return LBA in tf + 1 for
ata_read_native_max_address().  Make them return LBA and make it
global so that it can be used to read LBA off TF for other purposes.
ata_read_native_max_address() now adds 1 itself.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   12 ++++++------
 drivers/ata/libata.h      |    2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4851988..1a8601f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1255,7 +1255,7 @@ static u64 ata_id_n_sectors(const u16 *id)
 	}
 }
 
-static u64 ata_tf_to_lba48(struct ata_taskfile *tf)
+u64 ata_tf_to_lba48(const struct ata_taskfile *tf)
 {
 	u64 sectors = 0;
 
@@ -1266,10 +1266,10 @@ static u64 ata_tf_to_lba48(struct ata_taskfile *tf)
 	sectors |= (tf->lbam & 0xff) << 8;
 	sectors |= (tf->lbal & 0xff);
 
-	return ++sectors;
+	return sectors;
 }
 
-static u64 ata_tf_to_lba(struct ata_taskfile *tf)
+u64 ata_tf_to_lba(const struct ata_taskfile *tf)
 {
 	u64 sectors = 0;
 
@@ -1278,7 +1278,7 @@ static u64 ata_tf_to_lba(struct ata_taskfile *tf)
 	sectors |= (tf->lbam & 0xff) << 8;
 	sectors |= (tf->lbal & 0xff);
 
-	return ++sectors;
+	return sectors;
 }
 
 /**
@@ -1323,9 +1323,9 @@ static int ata_read_native_max_address(struct ata_device *dev, u64 *max_sectors)
 	}
 
 	if (lba48)
-		*max_sectors = ata_tf_to_lba48(&tf);
+		*max_sectors = ata_tf_to_lba48(&tf) + 1;
 	else
-		*max_sectors = ata_tf_to_lba(&tf);
+		*max_sectors = ata_tf_to_lba(&tf) + 1;
 	if (dev->horkage & ATA_HORKAGE_HPA_SIZE)
 		(*max_sectors)--;
 	return 0;
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index aa884f7..20edee0 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -61,6 +61,8 @@ extern int libata_fua;
 extern int libata_noacpi;
 extern int libata_allow_tpm;
 extern void ata_force_cbl(struct ata_port *ap);
+extern u64 ata_tf_to_lba(const struct ata_taskfile *tf);
+extern u64 ata_tf_to_lba48(const struct ata_taskfile *tf);
 extern struct ata_queued_cmd *ata_qc_new_init(struct ata_device *dev);
 extern int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 			   u64 block, u32 n_block, unsigned int tf_flags,
-- 
1.5.2.4

