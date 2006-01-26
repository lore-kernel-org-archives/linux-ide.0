From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 02/16] libata: use ata_dev_id_c_string()
Date: Fri, 27 Jan 2006 00:39:11 +0900
Message-ID: <1138289951235-git-send-email-htejun@gmail.com>
References: <1138289951261-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:21074 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932368AbWAZPjY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:39:24 -0500
Received: by zproxy.gmail.com with SMTP id 34so372383nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:39:24 -0800 (PST)
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
Cc: Tejun Heo <htejun@gmail.com>

Use ata_dev_id_c_string()

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   18 ++++--------------
 drivers/scsi/sata_sil.c    |   21 ++++++---------------
 2 files changed, 10 insertions(+), 29 deletions(-)

22d4913cf3ea0abd082d94abc648bb2be3142673
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 2dfc3e9..4b9d7f4 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2645,24 +2645,14 @@ static const char * const ata_dma_blackl
 
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
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 7c28f38..7b099e6 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -331,22 +331,13 @@ static void sil_scr_write (struct ata_po
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
@@ -362,7 +353,7 @@ static void sil_dev_config(struct ata_po
 	/* limit to udma5 */
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
 		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",
-		       ap->id, dev->devno, s);
+		       ap->id, dev->devno, model_num);
 		ap->udma_mask &= ATA_UDMA5;
 		return;
 	}
-- 
1.1.3


