From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: use ata_id_c_string()
Date: Tue, 2 Jan 2007 20:19:40 +0900
Message-ID: <20070102111940.GE10987@htj.dyndns.org>
References: <20070102111849.GD10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:44474 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932777AbXABLTr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 06:19:47 -0500
Content-Disposition: inline
In-Reply-To: <20070102111849.GD10987@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

There were several places where ATA ID strings are manually terminated
and in some places possibly unterminated strings were passed to string
functions which don't limit length like strstr().  This patch converts
all of them over to ata_id_c_string().

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c      |   27 ++++++---------------------
 drivers/ata/pata_ali.c         |    4 ++--
 drivers/ata/pata_hpt366.c      |   18 ++++--------------
 drivers/ata/pata_hpt37x.c      |   18 ++++--------------
 drivers/ata/pata_it821x.c      |   19 +++----------------
 drivers/ata/pata_serverworks.c |   17 +++++------------
 6 files changed, 24 insertions(+), 79 deletions(-)

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -3334,35 +3334,20 @@ static const struct ata_blacklist_entry 
 	{ }
 };
 
-static int ata_strim(char *s, size_t len)
-{
-	len = strnlen(s, len);
-
-	/* ATAPI specifies that empty space is blank-filled; remove blanks */
-	while ((len > 0) && (s[len - 1] == ' ')) {
-		len--;
-		s[len] = 0;
-	}
-	return len;
-}
-
 unsigned long ata_device_blacklisted(const struct ata_device *dev)
 {
-	unsigned char model_num[ATA_ID_PROD_LEN];
-	unsigned char model_rev[ATA_ID_FW_REV_LEN];
-	unsigned int nlen, rlen;
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
+	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
 	const struct ata_blacklist_entry *ad = ata_device_blacklist;
 
-	ata_id_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
-	ata_id_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
-	nlen = ata_strim(model_num, sizeof(model_num));
-	rlen = ata_strim(model_rev, sizeof(model_rev));
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
+	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
 
 	while (ad->model_num) {
-		if (!strncmp(ad->model_num, model_num, nlen)) {
+		if (!strcmp(ad->model_num, model_num)) {
 			if (ad->model_rev == NULL)
 				return ad->horkage;
-			if (!strncmp(ad->model_rev, model_rev, rlen))
+			if (!strcmp(ad->model_rev, model_rev))
 				return ad->horkage;
 		}
 		ad++;
Index: work/drivers/ata/pata_ali.c
===================================================================
--- work.orig/drivers/ata/pata_ali.c
+++ work/drivers/ata/pata_ali.c
@@ -153,11 +153,11 @@ static void ali_early_error_handler(stru
 
 static unsigned long ali_20_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
 {
-	char model_num[ATA_ID_PROD_LEN];
+	char model_num[ATA_ID_PROD_LEN + 1];
 	/* No DMA on anything but a disk for now */
 	if (adev->class != ATA_DEV_ATA)
 		mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-	ata_id_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
+	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	if (strstr(model_num, "WDC"))
 		return mask &= ~ATA_MASK_UDMA;
 	return ata_pci_default_filter(ap, adev, mask);
Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -151,23 +151,13 @@ static const char *bad_ata66_3[] = {
 
 static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr, const char *list[])
 {
-	unsigned char model_num[ATA_ID_PROD_LEN];
-	char *s;
-	unsigned int len;
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	int i = 0;
 
-	ata_id_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
-	s = &model_num[0];
-	len = strnlen(s, sizeof(model_num));
-
-	/* ATAPI specifies that empty space is blank-filled; remove blanks */
-	while ((len > 0) && (s[len - 1] == ' ')) {
-		len--;
-		s[len] = 0;
-	}
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
-	while(list[i] != NULL) {
-		if (!strncmp(list[i], s, len)) {
+	while (list[i] != NULL) {
+		if (!strcmp(list[i], model_num)) {
 			printk(KERN_WARNING DRV_NAME ": %s is not supported for %s.\n",
 				modestr, list[i]);
 			return 1;
Index: work/drivers/ata/pata_it821x.c
===================================================================
--- work.orig/drivers/ata/pata_it821x.c
+++ work/drivers/ata/pata_it821x.c
@@ -529,22 +529,9 @@ static void it821x_smart_set_mode(struct
 
 static void it821x_dev_config(struct ata_port *ap, struct ata_device *adev)
 {
-	unsigned char model_num[ATA_ID_PROD_LEN];
-	char *s;
-	unsigned int len;
-
-	/* This block ought to be a library routine as it is in several
-	   drivers now */
-
-	ata_id_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
-	s = &model_num[0];
-	len = strnlen(s, sizeof(model_num));
-
-	/* ATAPI specifies that empty space is blank-filled; remove blanks */
-	while ((len > 0) && (s[len - 1] == ' ')) {
-		len--;
-		s[len] = 0;
-	}
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
+
+	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
 	if (adev->max_sectors > 255)
 		adev->max_sectors = 255;
Index: work/drivers/ata/pata_serverworks.c
===================================================================
--- work.orig/drivers/ata/pata_serverworks.c
+++ work/drivers/ata/pata_serverworks.c
@@ -218,25 +218,18 @@ static unsigned long serverworks_osb4_fi
 static unsigned long serverworks_csb_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
 {
 	const char *p;
-	char model_num[ATA_ID_PROD_LEN];
-	int len, i;
+	char model_num[ATA_ID_PROD_LEN + 1];
+	int i;
 
 	/* Disk, UDMA */
 	if (adev->class != ATA_DEV_ATA)
 		return ata_pci_default_filter(ap, adev, mask);
 
 	/* Actually do need to check */
-	ata_id_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
-	/* Precuationary - why not do this in the libata core ?? */
+	ata_id_c_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
-	len = strlen(model_num);
-	while ((len > 0) && (model_num[len - 1] == ' ')) {
-		len--;
-		model_num[len] = 0;
-	}
-
-	for(i = 0; (p = csb_bad_ata100[i]) != NULL; i++) {
-		if (!strncmp(p, model_num, len))
+	for (i = 0; (p = csb_bad_ata100[i]) != NULL; i++) {
+		if (!strcmp(p, model_num))
 			mask &= ~(0x1F << ATA_SHIFT_UDMA);
 	}
 	return ata_pci_default_filter(ap, adev, mask);
Index: work/drivers/ata/pata_hpt37x.c
===================================================================
--- work.orig/drivers/ata/pata_hpt37x.c
+++ work/drivers/ata/pata_hpt37x.c
@@ -349,23 +349,13 @@ static u32 hpt37x_find_mode(struct ata_p
 
 static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr, const char *list[])
 {
-	unsigned char model_num[ATA_ID_PROD_LEN];
-	char *s;
-	unsigned int len;
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	int i = 0;
 
-	ata_id_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
-	s = &model_num[0];
-	len = strnlen(s, sizeof(model_num));
-
-	/* ATAPI specifies that empty space is blank-filled; remove blanks */
-	while ((len > 0) && (s[len - 1] == ' ')) {
-		len--;
-		s[len] = 0;
-	}
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
-	while(list[i] != NULL) {
-		if (!strncmp(list[i], s, len)) {
+	while (list[i] != NULL) {
+		if (!strcmp(list[i], model_num)) {
 			printk(KERN_WARNING DRV_NAME ": %s is not supported for %s.\n",
 				modestr, list[i]);
 			return 1;
