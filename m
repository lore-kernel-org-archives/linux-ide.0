From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/10] libata: ignore SIMG4726 config pseudo device
Date: Mon, 19 May 2008 01:15:14 +0900
Message-ID: <12111273201859-git-send-email-htejun@gmail.com>
References: <12111273141039-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:23414 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbYERQPa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 May 2008 12:15:30 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1008620rvb.1
        for <linux-ide@vger.kernel.org>; Sun, 18 May 2008 09:15:30 -0700 (PDT)
In-Reply-To: <12111273141039-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: liml@rtr.ca, Tejun Heo <htejun@gmail.com>

I was hoping ATA_HORKAGE_NODMA | ATA_HORKAGE_SKIP_PM could keep it
happy but no even this doesn't work under certain configurations and
it's not like we can do anything useful with the cofig device anyway.
Replace ATA_HORKAGE_SKIP_PM with ATA_HORKAGE_DISABLE and use it for
the config device.  This makes the device completely ignored by
libata.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |   10 ++++++++--
 drivers/ata/libata-scsi.c |    6 ------
 include/linux/libata.h    |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a12a27e..3c89f20 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2126,6 +2126,13 @@ int ata_dev_configure(struct ata_device *dev)
 	dev->horkage |= ata_dev_blacklisted(dev);
 	ata_force_horkage(dev);
 
+	if (dev->horkage & ATA_HORKAGE_DISABLE) {
+		ata_dev_printk(dev, KERN_INFO,
+			       "unsupported device, disabling\n");
+		ata_dev_disable(dev);
+		return 0;
+	}
+
 	/* let ACPI work its magic */
 	rc = ata_acpi_on_devcfg(dev);
 	if (rc)
@@ -3893,8 +3900,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ "SAMSUNG CD-ROM SN-124", "N001",	ATA_HORKAGE_NODMA },
 	{ "Seagate STT20000A", NULL,		ATA_HORKAGE_NODMA },
 	/* Odd clown on sil3726/4726 PMPs */
-	{ "Config  Disk",	NULL,		ATA_HORKAGE_NODMA |
-						ATA_HORKAGE_SKIP_PM },
+	{ "Config  Disk",	NULL,		ATA_HORKAGE_DISABLE },
 
 	/* Weird ATAPI devices */
 	{ "TORiSAN DVD-ROM DRD-N216", NULL,	ATA_HORKAGE_MAX_SEC_128 },
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 3ce4392..aeb6e01 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1082,12 +1082,6 @@ static unsigned int ata_scsi_start_stop_xlat(struct ata_queued_cmd *qc)
 	if (((cdb[4] >> 4) & 0xf) != 0)
 		goto invalid_fld;       /* power conditions not supported */
 
-	if (qc->dev->horkage & ATA_HORKAGE_SKIP_PM) {
-		/* the device lacks PM support, finish without doing anything */
-		scmd->result = SAM_STAT_GOOD;
-		return 1;
-	}
-
 	if (cdb[4] & 0x1) {
 		tf->nsect = 1;	/* 1 sector, lba=0 */
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 95e4169..95a2000 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -351,7 +351,7 @@ enum {
 	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 	ATA_HORKAGE_MAX_SEC_128	= (1 << 3),	/* Limit max sects to 128 */
 	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
-	ATA_HORKAGE_SKIP_PM	= (1 << 5),	/* Skip PM operations */
+	ATA_HORKAGE_DISABLE	= (1 << 5),	/* Disable it */
 	ATA_HORKAGE_HPA_SIZE	= (1 << 6),	/* native size off by one */
 	ATA_HORKAGE_IPM		= (1 << 7),	/* Link PM problems */
 	ATA_HORKAGE_IVB		= (1 << 8),	/* cbl det validity bit bugs */
-- 
1.5.2.4

