From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/8] libata: Fix a potential race condition in ata_scsi_park_show()
Date: Mon,  3 Nov 2008 19:01:08 +0900
Message-ID: <1225706469-27870-8-git-send-email-tj@kernel.org>
References: <1225706469-27870-1-git-send-email-tj@kernel.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34658 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754883AbYKCKBi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Nov 2008 05:01:38 -0500
In-Reply-To: <1225706469-27870-1-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Elias Oltmanns <eo@nebensachen.de>

From: Elias Oltmanns <eo@nebensachen.de>

Peter Moulder has pointed out that there is a slight chance that a
negative value might be passed to jiffies_to_msecs() in
ata_scsi_park_show(). This is fixed by saving the value of jiffies in a
local variable, thus also reducing code since the volatile variable
jiffies is accessed only once.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
Signed-off-by: Tejun Heo <tj.kernel.org>
---
 drivers/ata/libata-scsi.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0a0aa95..d12f84f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -191,7 +191,7 @@ static ssize_t ata_scsi_park_show(struct device *device,
 	struct ata_port *ap;
 	struct ata_link *link;
 	struct ata_device *dev;
-	unsigned long flags;
+	unsigned long flags, now;
 	unsigned int uninitialized_var(msecs);
 	int rc = 0;
 
@@ -209,10 +209,11 @@ static ssize_t ata_scsi_park_show(struct device *device,
 	}
 
 	link = dev->link;
+	now = jiffies;
 	if (ap->pflags & ATA_PFLAG_EH_IN_PROGRESS &&
 	    link->eh_context.unloaded_mask & (1 << dev->devno) &&
-	    time_after(dev->unpark_deadline, jiffies))
-		msecs = jiffies_to_msecs(dev->unpark_deadline - jiffies);
+	    time_after(dev->unpark_deadline, now))
+		msecs = jiffies_to_msecs(dev->unpark_deadline - now);
 	else
 		msecs = 0;
 
-- 
1.5.4.5

