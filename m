From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/10] libata: make sure PMP notification is turned off during recovery
Date: Mon, 19 May 2008 01:15:11 +0900
Message-ID: <12111273193711-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:52674 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001AbYERQP2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:28 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1010109wfd.4
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:28 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

PMP notification during reset can make some controllers fail reset
processing and needs to be turned off during resets.  PMP attach and
full-revalidation path did this via sata_pmp_configure() but the quick
revalidation wasn't.  Move the notification disable code right above
fan-out port recovery so that it's always turned off.

This fixes obscure reset failures.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-pmp.c |   36 ++++++++++++++++++++----------------
 1 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 04a486a..0f9386d 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -257,19 +257,6 @@ static int sata_pmp_configure(struct ata_device *dev, int print_info)
 		goto fail;
 	}
 
-	/* turn off notification till fan-out ports are reset and configured */
-	if (gscr[SATA_PMP_GSCR_FEAT_EN] & SATA_PMP_FEAT_NOTIFY) {
-		gscr[SATA_PMP_GSCR_FEAT_EN] &= ~SATA_PMP_FEAT_NOTIFY;
-
-		err_mask = sata_pmp_write(dev->link, SATA_PMP_GSCR_FEAT_EN,
-					  gscr[SATA_PMP_GSCR_FEAT_EN]);
-		if (err_mask) {
-			rc = -EIO;
-			reason = "failed to write GSCR_FEAT_EN";
-			goto fail;
-		}
-	}
-
 	if (print_info) {
 		ata_dev_printk(dev, KERN_INFO, "Port Multiplier %s, "
 			       "0x%04x:0x%04x r%d, %d ports, feat 0x%x/0x%x\n",
@@ -860,6 +847,7 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 	struct ata_link *pmp_link = &ap->link;
 	struct ata_device *pmp_dev = pmp_link->device;
 	struct ata_eh_context *pmp_ehc = &pmp_link->eh_context;
+	u32 *gscr = pmp_dev->gscr;
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned int err_mask;
@@ -897,6 +885,22 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 	if (rc)
 		goto pmp_fail;
 
+	/* PHY event notification can disturb reset and other recovery
+	 * operations.  Turn it off.
+	 */
+	if (gscr[SATA_PMP_GSCR_FEAT_EN] & SATA_PMP_FEAT_NOTIFY) {
+		gscr[SATA_PMP_GSCR_FEAT_EN] &= ~SATA_PMP_FEAT_NOTIFY;
+
+		err_mask = sata_pmp_write(pmp_link, SATA_PMP_GSCR_FEAT_EN,
+					  gscr[SATA_PMP_GSCR_FEAT_EN]);
+		if (err_mask) {
+			ata_link_printk(pmp_link, KERN_WARNING,
+				"failed to disable NOTIFY (err_mask=0x%x)\n",
+				err_mask);
+			goto pmp_fail;
+		}
+	}
+
 	/* handle disabled links */
 	rc = sata_pmp_eh_handle_disabled_links(ap);
 	if (rc)
@@ -919,10 +923,10 @@ static int sata_pmp_eh_recover(struct ata_port *ap)
 
 	/* enable notification */
 	if (pmp_dev->flags & ATA_DFLAG_AN) {
-		pmp_dev->gscr[SATA_PMP_GSCR_FEAT_EN] |= SATA_PMP_FEAT_NOTIFY;
+		gscr[SATA_PMP_GSCR_FEAT_EN] |= SATA_PMP_FEAT_NOTIFY;
 
-		err_mask = sata_pmp_write(pmp_dev->link, SATA_PMP_GSCR_FEAT_EN,
-					  pmp_dev->gscr[SATA_PMP_GSCR_FEAT_EN]);
+		err_mask = sata_pmp_write(pmp_link, SATA_PMP_GSCR_FEAT_EN,
+					  gscr[SATA_PMP_GSCR_FEAT_EN]);
 		if (err_mask) {
 			ata_dev_printk(pmp_dev, KERN_ERR, "failed to write "
 				       "PMP_FEAT_EN (Emask=0x%x)\n", err_mask);
-- 
1.5.2.4

