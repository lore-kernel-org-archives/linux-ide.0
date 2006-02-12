From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: use ata_dev_id_c_string()
Date: Sun, 12 Feb 2006 22:47:04 +0900
Message-ID: <11397520243797-git-send-email-htejun@gmail.com>
References: <11397520242602-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:37859 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751115AbWBLNrJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 08:47:09 -0500
Received: by zproxy.gmail.com with SMTP id n1so823290nzf
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 05:47:08 -0800 (PST)
In-Reply-To: <11397520242602-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use ata_dev_id_c_string()

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   18 ++++--------------
 drivers/scsi/libata-scsi.c |   11 ++++-------
 drivers/scsi/sata_sil.c    |   21 ++++++---------------
 3 files changed, 14 insertions(+), 36 deletions(-)

8a77e02188b54b55a3d58426e18a6295a2d46f1b
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ea993eb..cb770cb 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2298,24 +2298,14 @@ static const char * const ata_dma_blackl
 
 static int ata_dma_blacklisted(const struct ata_device *dev)
 {
-	unsigned char model_num[40];
-	char *s;
-	unsigned int len;
+	unsigned char model_num[41];
 	int i;
 
-	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
-			  sizeof(model_num));
-	s = &model_num[0];
-	len = strnlen(s, sizeof(model_num));
-
-	/* ATAPI specifies that empty space is blank-filled; remove blanks */
-	while ((len > 0) && (s[len - 1] == ' ')) {
-		len--;
-		s[len] = 0;
-	}
+	ata_dev_id_c_string(dev->id, model_num, ATA_ID_PROD_OFS,
+			    sizeof(model_num));
 
 	for (i = 0; i < ARRAY_SIZE(ata_dma_blacklist); i++)
-		if (!strncmp(ata_dma_blacklist[i], s, len))
+		if (!strcmp(ata_dma_blacklist[i], model_num))
 			return 1;
 
 	return 0;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 26f07a2..ebd7cf4 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1806,15 +1806,12 @@ static int ata_dev_supports_fua(u16 *id)
 	if (!ata_id_has_fua(id))
 		return 0;
 
-	model[40] = '\0';
-	fw[8] = '\0';
+	ata_dev_id_c_string(id, model, ATA_ID_PROD_OFS, sizeof(model));
+	ata_dev_id_c_string(id, fw, ATA_ID_FW_REV_OFS, sizeof(fw));
 
-	ata_dev_id_string(id, model, ATA_ID_PROD_OFS, sizeof(model) - 1);
-	ata_dev_id_string(id, fw, ATA_ID_FW_REV_OFS, sizeof(fw) - 1);
-
-	if (strncmp(model, "Maxtor", 6))
+	if (strcmp(model, "Maxtor"))
 		return 1;
-	if (strncmp(fw, "BANC1G10", 8))
+	if (strcmp(fw, "BANC1G10"))
 		return 1;
 
 	return 0; /* blacklisted */
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index bd28877..61c4ac7 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -337,22 +337,13 @@ static void sil_scr_write (struct ata_po
 static void sil_dev_config(struct ata_port *ap, struct ata_device *dev)
 {
 	unsigned int n, quirks = 0;
-	unsigned char model_num[40];
-	const char *s;
-	unsigned int len;
-
-	ata_dev_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
-			  sizeof(model_num));
-	s = &model_num[0];
-	len = strnlen(s, sizeof(model_num));
-
-	/* ATAPI specifies that empty space is blank-filled; remove blanks */
-	while ((len > 0) && (s[len - 1] == ' '))
-		len--;
+	unsigned char model_num[41];
+
+	ata_dev_id_c_string(dev->id, model_num, ATA_ID_PROD_OFS,
+			    sizeof(model_num));
 
 	for (n = 0; sil_blacklist[n].product; n++)
-		if (!memcmp(sil_blacklist[n].product, s,
-			    strlen(sil_blacklist[n].product))) {
+		if (!strcmp(sil_blacklist[n].product, model_num)) {
 			quirks = sil_blacklist[n].quirk;
 			break;
 		}
@@ -372,7 +363,7 @@ static void sil_dev_config(struct ata_po
 	/* limit to udma5 */
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
 		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",
-		       ap->id, dev->devno, s);
+		       ap->id, dev->devno, model_num);
 		ap->udma_mask &= ATA_UDMA5;
 		return;
 	}
-- 
1.1.5


