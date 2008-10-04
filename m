From: Elias Oltmanns <eo@nebensachen.de>
Subject: libata: Fix a potential race condition in ata_scsi_park_show()
Date: Sat, 04 Oct 2008 11:41:32 +0200
Message-ID: <87prmgzohf.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nebensachen.de ([195.34.83.29]:41256 "EHLO mail.nebensachen.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbYJDJlo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 4 Oct 2008 05:41:44 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Peter Moulder has pointed out that there is a slight chance that a
negative value might be passed to jiffies_to_msecs() in
ata_scsi_park_show(). This is fixed by saving the value of jiffies in a
local variable, thus also reducing code since the volatile variable
jiffies is accessed only once.

Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
---
Applies to your upstream branch.

 drivers/ata/libata-scsi.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index fccd5e4..e1f916f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -190,7 +190,7 @@ static ssize_t ata_scsi_park_show(struct device *device,
 	struct ata_port *ap;
 	struct ata_link *link;
 	struct ata_device *dev;
-	unsigned long flags;
+	unsigned long flags, now;
 	unsigned int uninitialized_var(msecs);
 	int rc = 0;
 
@@ -208,10 +208,11 @@ static ssize_t ata_scsi_park_show(struct device *device,
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
 
