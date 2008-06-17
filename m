From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 2/2] libata: implement ATAPI_HORKAGE_NOPIO
 and apply it to GGW-H10N
Date: Tue, 17 Jun 2008 12:37:24 +0900
Message-ID: <48573174.9050103@kernel.org>
References: <4857313A.1000405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39311 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542AbYFQDhe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Jun 2008 23:37:34 -0400
In-Reply-To: <4857313A.1000405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>
Cc: luke@lukeross.name

LG blueray drive GGW-H10N can't do ATAPI PIO.  Implement
ATAPI_HORKAGE_NOPIO and apply it to the drive.  If the horkage is
active, atapi_check_dma() always returns 0 and warns if the controller
needs ATAPI PIO for certain commands.

Reported by Luke Ross in bz 10091.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Luke Ross <luke@lukeross.name>
---
 drivers/ata/libata-core.c |   30 +++++++++++++++++++++++++-----
 drivers/ata/libata-eh.c   |    1 +
 include/linux/libata.h    |    2 ++
 3 files changed, 28 insertions(+), 5 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -2266,6 +2266,7 @@ int ata_dev_configure(struct ata_device 
 		const char *cdb_intr_string = "";
 		const char *atapi_an_string = "";
 		const char *dma_dir_string = "";
+		const char *nopio_string = "";
 		u32 sntf;
 
 		rc = atapi_cdb_len(id);
@@ -2311,14 +2312,17 @@ int ata_dev_configure(struct ata_device 
 			dma_dir_string = ", DMADIR";
 		}
 
+		if (dev->horkage & ATAPI_HORKAGE_NOPIO)
+			nopio_string = ", no PIO";
+
 		/* print device info to dmesg */
 		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO,
-				       "ATAPI: %s, %s, max %s%s%s%s\n",
+				       "ATAPI: %s, %s, max %s%s%s%s%s\n",
 				       modelbuf, fwrevbuf,
 				       ata_mode_string(xfer_mask),
 				       cdb_intr_string, atapi_an_string,
-				       dma_dir_string);
+				       dma_dir_string, nopio_string);
 	}
 
 	/* determine max_sectors */
@@ -3946,6 +3950,9 @@ static const struct ata_blacklist_entry 
 	{ "TSSTcorp CDDVDW SH-S202N", "SB00",	  ATA_HORKAGE_IVB, },
 	{ "TSSTcorp CDDVDW SH-S202N", "SB01",	  ATA_HORKAGE_IVB, },
 
+	/* AAAARGH... this one can't do ATAPI PIO */
+	{ "HL-DT-ST BD-RE  GGW-H10N", NULL,	ATAPI_HORKAGE_NOPIO },
+
 	/* End Marker */
 	{ }
 };
@@ -4313,17 +4320,30 @@ void ata_sg_clean(struct ata_queued_cmd 
 int atapi_check_dma(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	bool nopio = dev->horkage & ATAPI_HORKAGE_NOPIO;
+	int rc = 0;
 
 	/* Don't allow DMA if it isn't multiple of 16 bytes.  Quite a
 	 * few ATAPI devices choke on such DMA requests.
 	 */
-	if (unlikely(qc->nbytes & 15))
+	if (unlikely(qc->nbytes & 15) && !nopio)
 		return 1;
 
 	if (ap->ops->check_atapi_dma)
-		return ap->ops->check_atapi_dma(qc);
+		rc = ap->ops->check_atapi_dma(qc);
 
-	return 0;
+	if (unlikely(rc) && nopio) {
+		if (!(dev->flags & ATAPI_DFLAG_WARNED_NOPIO)) {
+			ata_dev_printk(dev, KERN_ERR,
+			       "device can't handle ATAPI PIO but "
+			       "controller needs it, expect problem\n");
+			dev->flags |= ATAPI_DFLAG_WARNED_NOPIO;
+		}
+		rc = 0;	/* we're screwed, be optimistic while being screwed */
+	}
+
+	return rc;
 }
 
 /**
Index: work/drivers/ata/libata-eh.c
===================================================================
--- work.orig/drivers/ata/libata-eh.c
+++ work/drivers/ata/libata-eh.c
@@ -1693,6 +1693,7 @@ static unsigned int ata_eh_speed_down(st
 	 */
 	if ((verdict & ATA_EH_SPDN_FALLBACK_TO_PIO) && (dev->spdn_cnt >= 2) &&
 	    (link->ap->cbl != ATA_CBL_SATA || dev->class == ATA_DEV_ATAPI) &&
+	    !(dev->horkage & ATAPI_HORKAGE_NOPIO) &&
 	    (dev->xfer_shift != ATA_SHIFT_PIO)) {
 		if (ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO) == 0) {
 			dev->spdn_cnt = 0;
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -145,6 +145,7 @@ enum {
 	ATA_DFLAG_SPUNDOWN	= (1 << 14), /* XXX: for spindown_compat */
 	ATA_DFLAG_SLEEPING	= (1 << 15), /* device is sleeping */
 	ATA_DFLAG_DUBIOUS_XFER	= (1 << 16), /* data transfer not verified */
+	ATAPI_DFLAG_WARNED_NOPIO = (1 << 17), /* warned about ATAPI NOPIO */
 	ATA_DFLAG_INIT_MASK	= (1 << 24) - 1,
 
 	ATA_DFLAG_DETACH	= (1 << 24),
@@ -353,6 +354,7 @@ enum {
 	ATA_HORKAGE_IPM		= (1 << 7),	/* Link PM problems */
 	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
 	ATA_HORKAGE_STUCK_ERR	= (1 << 9),	/* stuck ERR on next PACKET */
+	ATAPI_HORKAGE_NOPIO	= (1 << 10),	/* don't use ATAPI PIO */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
