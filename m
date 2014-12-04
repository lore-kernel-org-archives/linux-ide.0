From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Wed, 03 Dec 2014 21:44:46 -0500
Message-ID: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:47934 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbaLDCow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Dec 2014 21:44:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org


As defined, the DRAT (Deterministic Read After Trim) and RZAT (Return
Zero After Trim) flags in the ATA Command Set are unreliable in the
sense that they only define what happens if the device successfully
executed the DSM TRIM command. TRIM is only advisory, however, and the
device is free to silently ignore all or parts of the request.

In practice this renders the DRAT and RZAT flags completely useless and
because the results are unpredictable we decided to disable discard in
MD for 3.18 to avoid the risk of data corruption.

Hardware vendors in the real world obviously need better guarantees than
what the standards bodies provide. Unfortuntely those guarantees are
encoded in product requirements documents rather than somewhere we can
key off of them programatically. So we are compelled to disabling
discard_zeroes_data for all devices unless we explicitly have data to
support whitelisting them.

This patch whitelists SSDs from a few of the main vendors. None of the
whitelists are based on written guarantees. They are purely based on
empirical evidence collected from internal and external users that have
tested or qualified these drives in RAID deployments.

The whitelist is only meant as a starting point and is by no means
comprehensive:

   - All intel SSD models except for 510
   - Micron M5*
   - Samsung SSDs
   - Seagate SSDs

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-core.c |   18 ++++++++++++++----
 drivers/ata/libata-scsi.c |   10 ++++++----
 include/linux/libata.h    |    1 +
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c5ba15af87d3..f41f24a8bc21 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4225,10 +4225,20 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* devices that don't properly handle queued TRIM commands */
-	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
-	{ "Crucial_CT???M500SSD*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
-	{ "Micron_M550*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
-	{ "Crucial_CT*M550SSD*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
+	{ "Micron_M5?0*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial_CT???M5?0SSD*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
+
+	/*
+	 * DRAT/RZAT are weak guarantees. Explicitly black/whitelist
+	 * SSDs that provide reliable zero after TRIM.
+	 */
+	{ "INTEL*SSDSC2MH*",		NULL,	0, }, /* Blacklist intel 510 */
+	{ "INTEL*SSD*", 		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "SAMSUNG*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
 	/*
 	 * Some WD SATA-I drives spin up and down erratically when the link
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 0586f66d70fa..a19479282b65 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2515,13 +2515,15 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
 		rbuf[15] = lowest_aligned;
 
 		if (ata_id_has_trim(args->id)) {
-			rbuf[14] |= 0x80; /* TPE */
+			rbuf[14] |= 0x80; /* LBPME */
 
-			if (ata_id_has_zero_after_trim(args->id))
-				rbuf[14] |= 0x40; /* TPRZ */
+			if (ata_id_has_zero_after_trim(args->id) &&
+			    dev->horkage & ATA_HORKAGE_ZERO_AFTER_TRIM) {
+				ata_dev_info(dev, "Enabling discard_zeroes_data\n");
+				rbuf[14] |= 0x40; /* LBPRZ */
+			}
 		}
 	}
-
 	return 0;
 }
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bd5fefeaf548..45ac825b8366 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -421,6 +421,7 @@ enum {
 	ATA_HORKAGE_NO_NCQ_TRIM	= (1 << 19),	/* don't use queued TRIM */
 	ATA_HORKAGE_NOLPM	= (1 << 20),	/* don't use LPM */
 	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
+	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */


-- 
Martin K. Petersen	Oracle Linux Engineering
