From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH RESEND] libata: kill confusing @action local variable from
	ata_eh_reset()
Date: Wed, 24 Oct 2007 15:01:38 +0900
Message-ID: <20071024060138.GC11853@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:45006 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbXJXGBq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Oct 2007 02:01:46 -0400
Received: by rv-out-0910.google.com with SMTP id k20so83780rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 23:01:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Local variable @action in ata_eh_reset() is used only once after
assignment and as all other operations are done on ehc->i.action
directly, it can be a bit confusing.  Kill it.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Forgot subject in the first posting, re-posting.  Sorry.

 drivers/ata/libata-eh.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 93e2b54..5e3f66c 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2071,7 +2071,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	int try = 0;
 	struct ata_device *dev;
 	unsigned long deadline;
-	unsigned int action;
 	ata_reset_fn_t reset;
 	unsigned long flags;
 	int rc;
@@ -2086,11 +2085,10 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/* Determine which reset to use and record in ehc->i.action.
 	 * prereset() may examine and modify it.
 	 */
-	action = ehc->i.action;
 	ehc->i.action &= ~ATA_EH_RESET_MASK;
 	if (softreset && (!hardreset || (!(link->flags & ATA_LFLAG_NO_SRST) &&
 					 !sata_set_spd_needed(link) &&
-					 !(action & ATA_EH_HARDRESET))))
+					 !(ehc->i.action & ATA_EH_HARDRESET))))
 		ehc->i.action |= ATA_EH_SOFTRESET;
 	else
 		ehc->i.action |= ATA_EH_HARDRESET;
