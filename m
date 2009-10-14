From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes] sata_nv: make sure link is brough up online
 when skipping hardreset
Date: Wed, 14 Oct 2009 11:18:28 +0900
Message-ID: <4AD534F4.7000306@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50000 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755536AbZJNCTS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Oct 2009 22:19:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org, frodone@gmail.com

prereset doesn't bring link online if hardreset is about to happen and
nv_hardreset() may skip if conditions are not right so softreset may
be entered with non-working link status if the system firmware didn't
bring it up before entering OS code which can happen during resume.
This patch makes nv_hardreset() to bring up the link if it's skipping
reset.

This bug was reported by frodone@gmail.com in the following bug entry.

  http://bugzilla.kernel.org/show_bug.cgi?id=14329

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: frodone@gmail.com
Cc: stable@kernel.org
---
 drivers/ata/sata_nv.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 86a4058..1eb4e02 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -1594,9 +1594,21 @@ static int nv_hardreset(struct ata_link *link, unsigned int *class,
 	    !ata_dev_enabled(link->device))
 		sata_link_hardreset(link, sata_deb_timing_hotplug, deadline,
 				    NULL, NULL);
-	else if (!(ehc->i.flags & ATA_EHI_QUIET))
-		ata_link_printk(link, KERN_INFO,
-				"nv: skipping hardreset on occupied port\n");
+	else {
+		const unsigned long *timing = sata_ehc_deb_timing(ehc);
+		int rc;
+
+		if (!(ehc->i.flags & ATA_EHI_QUIET))
+			ata_link_printk(link, KERN_INFO, "nv: skipping "
+					"hardreset on occupied port\n");
+
+		/* make sure the link is online */
+		rc = sata_link_resume(link, timing, deadline);
+		/* whine about phy resume failure but proceed */
+		if (rc && rc != -EOPNOTSUPP)
+			ata_link_printk(link, KERN_WARNING, "failed to resume "
+					"link (errno=%d)\n", rc);
+	}

 	/* device signature acquisition is unreliable */
 	return -EAGAIN;
