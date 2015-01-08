From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] libata: Whitelist SSDs that are known to properly return zeroes after TRIM
Date: Thu,  8 Jan 2015 10:34:27 -0500
Message-ID: <1420731267-7385-1-git-send-email-martin.petersen@oracle.com>
References: <20150108151151.GC9402@htj.dyndns.org>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20150108151151.GC9402@htj.dyndns.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>
List-Id: linux-ide@vger.kernel.org

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
   - Micron M5?0/M600
   - Samsung SSDs
   - Seagate SSDs

Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-core.c | 31 +++++++++++++++++++++++++++----
 drivers/ata/libata-scsi.c | 10 ++++++----
 include/linux/libata.h    |  1 +
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5c84fb5c3372..23c2ae03a7ab 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4233,10 +4233,33 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
 
 	/* devices that don't properly handle queued TRIM commands */
-	{ "Micron_M500*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
-	{ "Crucial_CT???M500SSD*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
-	{ "Micron_M550*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
-	{ "Crucial_CT*M550SSD*",	NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
+	{ "Micron_M[56]*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Crucial_CT*SSD*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM, },
+
+	/*
+	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
+	 * (Return Zero After Trim) flags in the ATA Command Set are
+	 * unreliable in the sense that they only define what happens if
+	 * the device successfully executed the DSM TRIM command. TRIM
+	 * is only advisory, however, and the device is free to silently
+	 * ignore all or parts of the request.
+	 *
+	 * Whitelist drives that are known to reliably return zeroes
+	 * after TRIM.
+	 */
+
+	/*
+	 * The intel 510 drive has buggy DRAT/RZAT. Explicitly exclude
+	 * that model before whitelisting all other intel SSDs.
+	 */
+	{ "INTEL*SSDSC2MH*",		NULL,	0, },
+
+	{ "INTEL*SSD*", 		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "SSD*INTEL*",			NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Samsung*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "SAMSUNG*SSD*",		NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "ST[1248][0248]0[FH]*",	NULL,	ATA_HORKAGE_ZERO_AFTER_TRIM, },
 
 	/*
 	 * Some WD SATA-I drives spin up and down erratically when the link
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 7659d6468303..280729325ebd 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2532,13 +2532,15 @@ static unsigned int ata_scsiop_read_cap(struct ata_scsi_args *args, u8 *rbuf)
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
index 2d182413b1db..f2b440e44fd7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -422,6 +422,7 @@ enum {
 	ATA_HORKAGE_NO_NCQ_TRIM	= (1 << 19),	/* don't use queued TRIM */
 	ATA_HORKAGE_NOLPM	= (1 << 20),	/* don't use LPM */
 	ATA_HORKAGE_WD_BROKEN_LPM = (1 << 21),	/* some WDs have broken LPM */
+	ATA_HORKAGE_ZERO_AFTER_TRIM = (1 << 22),/* guarantees zero after trim */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
-- 
1.9.3

