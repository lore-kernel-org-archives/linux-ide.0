From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: cosmetic clean up in ata_eh_reset()
Date: Wed, 24 Oct 2007 15:21:26 +0900
Message-ID: <20071024062126.GD11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:47986 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbXJXGVd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 02:21:33 -0400
Received: by wa-out-1112.google.com with SMTP id v27so115103wah
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 23:21:33 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Local variable @action usage in ata_eh_reset() is a bit confusing.
It's used only to cache ehc->i.action to test reset masks after
clearing it; however, due to the generic name "action", it's easy to
misinterpret the local variable as containing the selected reset
method later.  Also, the reason for caching the original value is easy
to miss.

This patch renames @action to @tmp_action and make it buffer newly
selected value instead to improve readability.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-eh.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 93e2b54..8cb35bb 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2071,7 +2071,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	int try = 0;
 	struct ata_device *dev;
 	unsigned long deadline;
-	unsigned int action;
+	unsigned int tmp_action;
 	ata_reset_fn_t reset;
 	unsigned long flags;
 	int rc;
@@ -2086,14 +2086,14 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
 	 */
-	action = ehc->i.action;
-	ehc->i.action &= ~ATA_EH_RESET_MASK;
 	if (softreset && (!hardreset || (!(link->flags & ATA_LFLAG_NO_SRST) &&
 					 !sata_set_spd_needed(link) &&
-					 !(action & ATA_EH_HARDRESET))))
-		ehc->i.action |= ATA_EH_SOFTRESET;
+					 !(ehc->i.action & ATA_EH_HARDRESET))))
+		tmp_action = ATA_EH_SOFTRESET;
 	else
-		ehc->i.action |= ATA_EH_HARDRESET;
+		tmp_action = ATA_EH_HARDRESET;
+
+	ehc->i.action = (ehc->i.action & ~ATA_EH_RESET_MASK) | tmp_action;
 
 	if (prereset) {
 		rc = prereset(link, jiffies + ATA_EH_PRERESET_TIMEOUT);
