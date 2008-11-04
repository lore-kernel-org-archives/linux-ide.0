From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] libata: fix last_reset timestamp handling
Date: Tue, 04 Nov 2008 16:32:25 +0900
Message-ID: <490FFA89.1030002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56482 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbYKDHch (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 02:32:37 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Shane Huang <Shane.Huang@amd.com>
Cc: stable@kernel.org

ehc->last_reset is used to ensure that resets are not issued too close
to each other.  It's initialized to jiffies minus one minute on EH
entry.  However, when new links are initialized after PMP is probed,
new links have zero for this timestamp resulting in long wait
depending on the current jiffies.

This patch makes last_set considered iff ATA_EHI_DID_RESET is set, in
which case last_reset is always initialized.  As an added precaution,
WARN_ON() is added so that warning is printed if last_reset is in
future.

This problem is spotted and debugged by Shane Huang.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Shane Huang <Shane.Huang@amd.com>
---
This one also should go into 2.6.27-x.  Thanks.

 drivers/ata/libata-eh.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 6b05809..1b46f60 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -632,9 +632,6 @@ void ata_scsi_error(struct Scsi_Host *host)
 				if (ata_ncq_enabled(dev))
 					ehc->saved_ncq_enabled |= 1 << devno;
 			}
-
-			/* set last reset timestamp to some time in the past */
-			ehc->last_reset = jiffies - 60 * HZ;
 		}
 
 		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
@@ -2308,10 +2305,15 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	if (link->flags & ATA_LFLAG_NO_SRST)
 		softreset = NULL;
 
-	now = jiffies;
-	deadline = ata_deadline(ehc->last_reset, ATA_EH_RESET_COOL_DOWN);
-	if (time_before(now, deadline))
-		schedule_timeout_uninterruptible(deadline - now);
+	/* make sure each reset attemp is at least COOL_DOWN apart */
+	if (ehc->i.flags & ATA_EHI_DID_RESET) {
+		now = jiffies;
+		WARN_ON(time_after(ehc->last_reset, now));
+		deadline = ata_deadline(ehc->last_reset,
+					ATA_EH_RESET_COOL_DOWN);
+		if (time_before(now, deadline))
+			schedule_timeout_uninterruptible(deadline - now);
+	}
 
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags |= ATA_PFLAG_RESETTING;
@@ -2406,7 +2408,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	/*
 	 * Perform reset
 	 */
-	ehc->last_reset = jiffies;
 	if (ata_is_host_link(link))
 		ata_eh_freeze_port(ap);
 
@@ -2418,6 +2419,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 					reset == softreset ? "soft" : "hard");
 
 		/* mark that this EH session started with reset */
+		ehc->last_reset = jiffies;
 		if (reset == hardreset)
 			ehc->i.flags |= ATA_EHI_DID_HARDRESET;
 		else
@@ -2562,7 +2564,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
 	ata_eh_done(link, NULL, ATA_EH_RESET);
 	if (slave)
 		ata_eh_done(slave, NULL, ATA_EH_RESET);
-	ehc->last_reset = jiffies;
+	ehc->last_reset = jiffies;	/* update to completion time */
 	ehc->i.action |= ATA_EH_REVALIDATE;
 
 	rc = 0;
