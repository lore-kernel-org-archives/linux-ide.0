From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 2/5] libata: introduce ata_get_internal_tag()
Date: Thu,  3 Jul 2014 20:09:39 +0800
Message-ID: <1404389382-27298-3-git-send-email-haokexin@gmail.com>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:49068 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbaGCMKj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jul 2014 08:10:39 -0400
Received: by mail-pd0-f175.google.com with SMTP id v10so126214pde.6
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 05:10:38 -0700 (PDT)
In-Reply-To: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

Introduce a helper function to get the tag number which is reserved
for internal use.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/ata/libata-core.c | 2 +-
 drivers/ata/sata_fsl.c    | 4 ++--
 include/linux/libata.h    | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2895254d8388..8807287ab7b0 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1576,7 +1576,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	 * EH stuff without converting to it.
 	 */
 	if (ap->ops->error_handler)
-		tag = ATA_TAG_INTERNAL;
+		tag = ata_get_internal_tag();
 	else
 		tag = 0;
 
diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 07bc7e4dbd04..7fed5c5be426 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1290,9 +1290,9 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
 		return;
 
-	} else if ((ap->qc_active & (1 << ATA_TAG_INTERNAL))) {
+	} else if ((ap->qc_active & (1 << ata_get_internal_tag()))) {
 		iowrite32(1, hcr_base + CC);
-		qc = ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
+		qc = ata_qc_from_tag(ap, ata_get_internal_tag());
 
 		DPRINTK("completing non-ncq cmd, CC=0x%x\n",
 			 ioread32(hcr_base + CC));
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5ab4e3a76721..63462f1274df 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1479,6 +1479,11 @@ static inline unsigned int ata_tag_valid(unsigned int tag)
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
 }
 
+static inline unsigned int ata_get_internal_tag(void)
+{
+	return ATA_TAG_INTERNAL;
+}
+
 static inline unsigned int ata_tag_internal(unsigned int tag)
 {
 	return tag == ATA_TAG_INTERNAL;
-- 
1.9.3

