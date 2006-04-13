From: Brian King <brking@us.ibm.com>
Subject: [PATCH 4/4] libata: Add ata_host_flags
Date: Thu, 13 Apr 2006 14:52:23 -0500
Message-ID: <200604131952.k3DJqOtY012448@d03av01.boulder.ibm.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:8922 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964956AbWDMTw0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Apr 2006 15:52:26 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3DJqPOB002336
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 15:52:25 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3DJmsQC252018
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 13:48:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k3DJqPiV012483
	for <linux-ide@vger.kernel.org>; Thu, 13 Apr 2006 13:52:25 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, brking@us.ibm.com


Since SATA devices attached to SAS HBAs will not have
a host_set, add a helper function to retrieve the host_set
flags which can check for the existence of a host_set.

Signed-off-by: Brian King <brking@us.ibm.com>
---

 libata-dev-bjking1/drivers/scsi/libata-core.c |    7 +++----
 libata-dev-bjking1/include/linux/libata.h     |    7 +++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff -puN drivers/scsi/libata-core.c~libata_sas_no_simplex drivers/scsi/libata-core.c
--- libata-dev/drivers/scsi/libata-core.c~libata_sas_no_simplex	2006-04-11 14:15:38.000000000 -0500
+++ libata-dev-bjking1/drivers/scsi/libata-core.c	2006-04-11 14:15:38.000000000 -0500
@@ -2071,7 +2071,7 @@ int ata_set_mode(struct ata_port *ap, st
 	/* Record simplex status. If we selected DMA then the other
 	 * host channels are not permitted to do so.
 	 */
-	if (used_dma && (ap->host_set->flags & ATA_HOST_SIMPLEX))
+	if (used_dma && (ata_host_flags(ap) & ATA_HOST_SIMPLEX))
 		ap->host_set->simplex_claimed = 1;
 
 	/* step5: chip specific finalisation */
@@ -2904,7 +2904,6 @@ static int ata_dma_blacklisted(const str
  */
 static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev)
 {
-	struct ata_host_set *hs = ap->host_set;
 	unsigned long xfer_mask;
 	int i;
 
@@ -2942,8 +2941,8 @@ static void ata_dev_xfermask(struct ata_
 		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
 		       "disabling DMA\n", ap->id, dev->devno);
 
-	if (hs->flags & ATA_HOST_SIMPLEX) {
-		if (hs->simplex_claimed)
+	if (ata_host_flags(ap) & ATA_HOST_SIMPLEX) {
+		if (ap->host_set->simplex_claimed)
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	}
 
diff -puN include/linux/libata.h~libata_sas_no_simplex include/linux/libata.h
--- libata-dev/include/linux/libata.h~libata_sas_no_simplex	2006-04-11 14:15:38.000000000 -0500
+++ libata-dev-bjking1/include/linux/libata.h	2006-04-11 14:15:38.000000000 -0500
@@ -986,4 +986,11 @@ static inline struct ata_port *ata_shost
 	return (struct ata_port *) &host->hostdata[0];
 }
 
+static inline unsigned int ata_host_flags(struct ata_port *ap)
+{
+	if (ap->host_set)
+		return ap->host_set->flags;
+	return 0;
+}
+
 #endif /* __LINUX_LIBATA_H__ */
_
