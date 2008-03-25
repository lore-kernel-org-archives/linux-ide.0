From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 19/27] libata: unify mechanism to request follow-up SRST
Date: Tue, 25 Mar 2008 22:16:57 +0900
Message-ID: <1206451028739-git-send-email-htejun@gmail.com>
References: <1206451025926-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:13913 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128AbYCYNRn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Mar 2008 09:17:43 -0400
Received: by rn-out-0910.google.com with SMTP id v46so1793752rnb.15
        for <linux-ide@vger.kernel.org>; Tue, 25 Mar 2008 06:17:42 -0700 (PDT)
In-Reply-To: <1206451025926-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, James.Bottomley@HansenPartnership.com, brking@us.ibm.com, ashish.kalra@freescale.com, leoli@freescale.com
Cc: Tejun Heo <htejun@gmail.com>

Previously, there were two ways to trigger follow-up SRST from
hardreset method - returning -EAGAIN and leaving all device classes
unmodified.  Drivers never used the latter mechanism and the only use
case for the former was when hardreset couldn't classify.

Drop the latter mechanism and let -EAGAIN mean "perform follow-up SRST
if classification is required".  This change removes unnecessary
follow-up SRSTs and simplifies reset implementations.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/ahci.c        |    3 ---
 drivers/ata/libata-core.c |    1 -
 drivers/ata/libata-eh.c   |   26 ++++++++------------------
 drivers/ata/libata-sff.c  |    1 -
 4 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a69bcca..3071a23 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1365,7 +1365,6 @@ static int ahci_hardreset(struct ata_link *link, unsigned int *class,
 
 	ahci_start_engine(ap);
 
-	*class = ATA_DEV_NONE;
 	if (online)
 		*class = ahci_dev_classify(ap);
 
@@ -1394,7 +1393,6 @@ static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *class,
 	/* vt8251 doesn't clear BSY on signature FIS reception,
 	 * request follow-up softreset.
 	 */
-	*class = ATA_DEV_NONE;
 	return online ? -EAGAIN : rc;
 }
 
@@ -1439,7 +1437,6 @@ static int ahci_p5wdh_hardreset(struct ata_link *link, unsigned int *class,
 		if (rc)
 			ahci_kick_engine(ap, 0);
 	}
-	*class = ATA_DEV_NONE;
 	return rc;
 }
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3b89539..d99929c 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -3663,7 +3663,6 @@ int sata_std_hardreset(struct ata_link *link, unsigned int *class,
 
 	/* do hardreset */
 	rc = sata_link_hardreset(link, timing, deadline, &online, NULL);
-	*class = ATA_DEV_NONE;
 	return online ? -EAGAIN : rc;
 }
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 621c6e4..ebcd73f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2050,20 +2050,10 @@ static int ata_do_reset(struct ata_link *link, ata_reset_fn_t reset,
 	if (rc)
 		return rc;
 
-	/* If any class isn't ATA_DEV_UNKNOWN, consider classification
-	 * is complete and convert all ATA_DEV_UNKNOWN to
-	 * ATA_DEV_NONE.
-	 */
+	/* convert all ATA_DEV_UNKNOWN to ATA_DEV_NONE */
 	ata_link_for_each_dev(dev, link)
-		if (classes[dev->devno] != ATA_DEV_UNKNOWN)
-			break;
-
-	if (dev) {
-		ata_link_for_each_dev(dev, link) {
-			if (classes[dev->devno] == ATA_DEV_UNKNOWN)
-				classes[dev->devno] = ATA_DEV_NONE;
-		}
-	}
+		if (classes[dev->devno] == ATA_DEV_UNKNOWN)
+			classes[dev->devno] = ATA_DEV_NONE;
 
 	return 0;
 }
@@ -2074,15 +2064,15 @@ static int ata_eh_followup_srst_needed(struct ata_link *link,
 {
 	if (link->flags & ATA_LFLAG_NO_SRST)
 		return 0;
-	if (rc == -EAGAIN)
-		return 1;
+	if (rc == -EAGAIN) {
+		if (classify)
+			return 1;
+		rc = 0;
+	}
 	if (rc != 0)
 		return 0;
 	if ((link->ap->flags & ATA_FLAG_PMP) && ata_is_host_link(link))
 		return 1;
-	if (classify && !(link->flags & ATA_LFLAG_ASSUME_CLASS) &&
-	    classes[0] == ATA_DEV_UNKNOWN)
-		return 1;
 	return 0;
 }
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index f464ca1..5be8a60 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1929,7 +1929,6 @@ int sata_sff_hardreset(struct ata_link *link, unsigned int *class,
 
 	rc = sata_link_hardreset(link, timing, deadline, &online,
 				 ata_sff_check_ready);
-	*class = ATA_DEV_NONE;
 	if (online)
 		*class = ata_sff_dev_classify(link->device, 1, NULL);
 
-- 
1.5.2.4

