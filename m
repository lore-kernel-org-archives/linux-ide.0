From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 5/5] sata_fsl: set the correct queue depth for the host controller
Date: Thu,  3 Jul 2014 20:09:42 +0800
Message-ID: <1404389382-27298-6-git-send-email-haokexin@gmail.com>
References: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46637 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbaGCMKs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jul 2014 08:10:48 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so120397pde.38
        for <linux-ide@vger.kernel.org>; Thu, 03 Jul 2014 05:10:48 -0700 (PDT)
In-Reply-To: <1404389382-27298-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>

The fsl sata controller only implement a queue depth of 16. So use
the ata_host_set_queue_depth() to set the correct queue depth for
host controller.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/ata/sata_fsl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index bffdd96538ff..7174998cf1bc 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -1219,6 +1219,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 	u32 SError;
 	u32 tag;
 	u32 status_mask = INT_ON_ERROR;
+	unsigned int max_queue = ap->host->queue_depth;
 
 	hstatus = ioread32(hcr_base + HSTATUS);
 
@@ -1229,7 +1230,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
 
 	/* Workaround for data length mismatch errata */
 	if (unlikely(hstatus & INT_ON_DATA_LENGTH_MISMATCH)) {
-		for (tag = 0; tag < ATA_MAX_QUEUE; tag++) {
+		for (tag = 0; tag < max_queue; tag++) {
 			qc = ata_qc_from_tag(ap, tag);
 			if (qc && ata_is_atapi(qc->tf.protocol)) {
 				u32 hcontrol;
@@ -1509,6 +1510,8 @@ static int sata_fsl_probe(struct platform_device *ofdev)
 		goto error_exit_with_cleanup;
 	}
 
+	ata_host_set_queue_depth(host, SATA_FSL_QUEUE_DEPTH);
+
 	/* host->iomap is not used currently */
 	host->private_data = host_priv;
 
-- 
1.9.3

