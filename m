From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH v2] libata: fixup wait_for_completion_timeout return handling
Date: Tue, 10 Feb 2015 11:22:37 -0500
Message-ID: <1423585357-2580-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:53016 "EHLO www.osadl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbbBJQ1P (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 10 Feb 2015 11:27:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>

return type of wait_for_completion_timeout is unsigned long not int. The
return variable is renamed to reflect its use and the type adjusted to
unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

v2: rename of variable to make the timeout condition clear
    as requested by Tejun Heo <tj@kernel.org>

Patch was only compile tested with x86_64_defconfig
(implies CONFIG_ATA=y)

Patch is against 3.19.0 (localversion-next is -next-20150210)

 drivers/ata/libata-core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4c35f08..0d9ef27 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1563,7 +1563,7 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	DECLARE_COMPLETION_ONSTACK(wait);
 	unsigned long flags;
 	unsigned int err_mask;
-	int rc;
+	unsigned long time_left;
 
 	spin_lock_irqsave(ap->lock, flags);
 
@@ -1644,14 +1644,15 @@ unsigned ata_exec_internal_sg(struct ata_device *dev,
 	if (ap->ops->error_handler)
 		ata_eh_release(ap);
 
-	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
+	time_left = wait_for_completion_timeout(&wait,
+						msecs_to_jiffies(timeout));
 
 	if (ap->ops->error_handler)
 		ata_eh_acquire(ap);
 
 	ata_sff_flush_pio_task(ap);
 
-	if (!rc) {
+	if (time_left == 0) {
 		spin_lock_irqsave(ap->lock, flags);
 
 		/* We're racing with irq here.  If we lose, the
-- 
1.7.10.4

