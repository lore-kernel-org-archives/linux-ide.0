From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/3] libata: straighten out ATA_ID_* constants
Date: Tue, 2 Jan 2007 20:18:49 +0900
Message-ID: <20070102111849.GD10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [221.139.199.108] ([221.139.199.108]:44470 "EHLO htj.dyndns.org"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932832AbXABLSv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Jan 2007 06:18:51 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

* Kill _OFS suffixes in ATA_ID_{SERNO|FW_REV|PROD}_OFS for consistency
  with other ATA_ID_* constants.

* Kill ATA_SERNO_LEN

* Add and use ATA_ID_SERNO_LEN, ATA_ID_FW_REV_LEN and ATA_ID_PROD_LEN.
  This change also makes ata_device_blacklisted() use proper length
  for fwrev.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c      |   21 ++++++++++-----------
 drivers/ata/libata-scsi.c      |   33 ++++++++++++++++-----------------
 drivers/ata/pata_ali.c         |    4 ++--
 drivers/ata/pata_hpt366.c      |    4 ++--
 drivers/ata/pata_hpt37x.c      |    5 ++---
 drivers/ata/pata_it821x.c      |    5 ++---
 drivers/ata/pata_serverworks.c |    4 ++--
 drivers/ata/sata_sil.c         |    4 ++--
 include/linux/ata.h            |   11 +++++++----
 9 files changed, 45 insertions(+), 46 deletions(-)

Index: work/include/linux/ata.h
===================================================================
--- work.orig/include/linux/ata.h
+++ work/include/linux/ata.h
@@ -44,9 +44,9 @@ enum {
 	ATA_MAX_SECTORS_LBA48	= 65535,/* TODO: 65536? */
 
 	ATA_ID_WORDS		= 256,
-	ATA_ID_SERNO_OFS	= 10,
-	ATA_ID_FW_REV_OFS	= 23,
-	ATA_ID_PROD_OFS		= 27,
+	ATA_ID_SERNO		= 10,
+	ATA_ID_FW_REV		= 23,
+	ATA_ID_PROD		= 27,
 	ATA_ID_OLD_PIO_MODES	= 51,
 	ATA_ID_FIELD_VALID	= 53,
 	ATA_ID_MWDMA_MODES	= 63,
@@ -58,8 +58,11 @@ enum {
 	ATA_ID_MAJOR_VER	= 80,
 	ATA_ID_PIO4		= (1 << 1),
 
+	ATA_ID_SERNO_LEN	= 20,
+	ATA_ID_FW_REV_LEN	= 8,
+	ATA_ID_PROD_LEN		= 40,
+
 	ATA_PCI_CTL_OFS		= 2,
-	ATA_SERNO_LEN		= 20,
 	ATA_UDMA0		= (1 << 0),
 	ATA_UDMA1		= ATA_UDMA0 | (1 << 1),
 	ATA_UDMA2		= ATA_UDMA1 | (1 << 2),
Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c
+++ work/drivers/ata/libata-core.c
@@ -3196,7 +3196,8 @@ static int ata_dev_same_device(struct at
 			       const u16 *new_id)
 {
 	const u16 *old_id = dev->id;
-	unsigned char model[2][41], serial[2][21];
+	unsigned char model[2][ATA_ID_PROD_LEN + 1];
+	unsigned char serial[2][ATA_ID_SERNO_LEN + 1];
 	u64 new_n_sectors;
 
 	if (dev->class != new_class) {
@@ -3205,10 +3206,10 @@ static int ata_dev_same_device(struct at
 		return 0;
 	}
 
-	ata_id_c_string(old_id, model[0], ATA_ID_PROD_OFS, sizeof(model[0]));
-	ata_id_c_string(new_id, model[1], ATA_ID_PROD_OFS, sizeof(model[1]));
-	ata_id_c_string(old_id, serial[0], ATA_ID_SERNO_OFS, sizeof(serial[0]));
-	ata_id_c_string(new_id, serial[1], ATA_ID_SERNO_OFS, sizeof(serial[1]));
+	ata_id_c_string(old_id, model[0], ATA_ID_PROD, sizeof(model[0]));
+	ata_id_c_string(new_id, model[1], ATA_ID_PROD, sizeof(model[1]));
+	ata_id_c_string(old_id, serial[0], ATA_ID_SERNO, sizeof(serial[0]));
+	ata_id_c_string(new_id, serial[1], ATA_ID_SERNO, sizeof(serial[1]));
 	new_n_sectors = ata_id_n_sectors(new_id);
 
 	if (strcmp(model[0], model[1])) {
@@ -3347,15 +3348,13 @@ static int ata_strim(char *s, size_t len
 
 unsigned long ata_device_blacklisted(const struct ata_device *dev)
 {
-	unsigned char model_num[40];
-	unsigned char model_rev[16];
+	unsigned char model_num[ATA_ID_PROD_LEN];
+	unsigned char model_rev[ATA_ID_FW_REV_LEN];
 	unsigned int nlen, rlen;
 	const struct ata_blacklist_entry *ad = ata_device_blacklist;
 
-	ata_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
-			  sizeof(model_num));
-	ata_id_string(dev->id, model_rev, ATA_ID_FW_REV_OFS,
-			  sizeof(model_rev));
+	ata_id_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
+	ata_id_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
 	nlen = ata_strim(model_num, sizeof(model_num));
 	rlen = ata_strim(model_rev, sizeof(model_rev));
 
Index: work/drivers/ata/libata-scsi.c
===================================================================
--- work.orig/drivers/ata/libata-scsi.c
+++ work/drivers/ata/libata-scsi.c
@@ -1660,8 +1660,8 @@ unsigned int ata_scsiop_inq_std(struct a
 
 	if (buflen > 35) {
 		memcpy(&rbuf[8], "ATA     ", 8);
-		ata_id_string(args->id, &rbuf[16], ATA_ID_PROD_OFS, 16);
-		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
+		ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
+		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV, 4);
 		if (rbuf[32] == 0 || rbuf[32] == ' ')
 			memcpy(&rbuf[32], "n/a ", 4);
 	}
@@ -1730,13 +1730,13 @@ unsigned int ata_scsiop_inq_80(struct at
 		0,
 		0x80,			/* this page code */
 		0,
-		ATA_SERNO_LEN,		/* page len */
+		ATA_ID_SERNO_LEN,	/* page len */
 	};
 	memcpy(rbuf, hdr, sizeof(hdr));
 
-	if (buflen > (ATA_SERNO_LEN + 4 - 1))
+	if (buflen > (ATA_ID_SERNO_LEN + 4 - 1))
 		ata_id_string(args->id, (unsigned char *) &rbuf[4],
-			      ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
+			      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
 
 	return 0;
 }
@@ -1761,19 +1761,18 @@ unsigned int ata_scsiop_inq_83(struct at
 {
 	int num;
 	const int sat_model_serial_desc_len = 68;
-	const int ata_model_byte_len = 40;
 
 	rbuf[1] = 0x83;			/* this page code */
 	num = 4;
 
-	if (buflen > (ATA_SERNO_LEN + num + 3)) {
+	if (buflen > (ATA_ID_SERNO_LEN + num + 3)) {
 		/* piv=0, assoc=lu, code_set=ACSII, designator=vendor */
 		rbuf[num + 0] = 2;
-		rbuf[num + 3] = ATA_SERNO_LEN;
+		rbuf[num + 3] = ATA_ID_SERNO_LEN;
 		num += 4;
 		ata_id_string(args->id, (unsigned char *) rbuf + num,
-			      ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
-		num += ATA_SERNO_LEN;
+			      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
+		num += ATA_ID_SERNO_LEN;
 	}
 	if (buflen > (sat_model_serial_desc_len + num + 3)) {
 		/* SAT defined lu model and serial numbers descriptor */
@@ -1785,11 +1784,11 @@ unsigned int ata_scsiop_inq_83(struct at
 		memcpy(rbuf + num, "ATA     ", 8);
 		num += 8;
 		ata_id_string(args->id, (unsigned char *) rbuf + num,
-			      ATA_ID_PROD_OFS, ata_model_byte_len);
-		num += ata_model_byte_len;
+			      ATA_ID_PROD, ATA_ID_PROD_LEN);
+		num += ATA_ID_PROD_LEN;
 		ata_id_string(args->id, (unsigned char *) rbuf + num,
-			      ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
-		num += ATA_SERNO_LEN;
+			      ATA_ID_SERNO, ATA_ID_SERNO_LEN);
+		num += ATA_ID_SERNO_LEN;
 	}
 	rbuf[3] = num - 4;    /* page len (assume less than 256 bytes) */
 	return 0;
@@ -1917,15 +1916,15 @@ static unsigned int ata_msense_rw_recove
  */
 static int ata_dev_supports_fua(u16 *id)
 {
-	unsigned char model[41], fw[9];
+	unsigned char model[ATA_ID_PROD_LEN + 1], fw[ATA_ID_FW_REV_LEN + 1];
 
 	if (!libata_fua)
 		return 0;
 	if (!ata_id_has_fua(id))
 		return 0;
 
-	ata_id_c_string(id, model, ATA_ID_PROD_OFS, sizeof(model));
-	ata_id_c_string(id, fw, ATA_ID_FW_REV_OFS, sizeof(fw));
+	ata_id_c_string(id, model, ATA_ID_PROD, sizeof(model));
+	ata_id_c_string(id, fw, ATA_ID_FW_REV, sizeof(fw));
 
 	if (strcmp(model, "Maxtor"))
 		return 1;
Index: work/drivers/ata/pata_ali.c
===================================================================
--- work.orig/drivers/ata/pata_ali.c
+++ work/drivers/ata/pata_ali.c
@@ -153,11 +153,11 @@ static void ali_early_error_handler(stru
 
 static unsigned long ali_20_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
 {
-	char model_num[40];
+	char model_num[ATA_ID_PROD_LEN];
 	/* No DMA on anything but a disk for now */
 	if (adev->class != ATA_DEV_ATA)
 		mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
-	ata_id_string(adev->id, model_num, ATA_ID_PROD_OFS, sizeof(model_num));
+	ata_id_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	if (strstr(model_num, "WDC"))
 		return mask &= ~ATA_MASK_UDMA;
 	return ata_pci_default_filter(ap, adev, mask);
Index: work/drivers/ata/pata_hpt366.c
===================================================================
--- work.orig/drivers/ata/pata_hpt366.c
+++ work/drivers/ata/pata_hpt366.c
@@ -151,12 +151,12 @@ static const char *bad_ata66_3[] = {
 
 static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr, const char *list[])
 {
-	unsigned char model_num[40];
+	unsigned char model_num[ATA_ID_PROD_LEN];
 	char *s;
 	unsigned int len;
 	int i = 0;
 
-	ata_id_string(dev->id, model_num, ATA_ID_PROD_OFS, sizeof(model_num));
+	ata_id_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	s = &model_num[0];
 	len = strnlen(s, sizeof(model_num));
 
Index: work/drivers/ata/pata_it821x.c
===================================================================
--- work.orig/drivers/ata/pata_it821x.c
+++ work/drivers/ata/pata_it821x.c
@@ -529,15 +529,14 @@ static void it821x_smart_set_mode(struct
 
 static void it821x_dev_config(struct ata_port *ap, struct ata_device *adev)
 {
-	unsigned char model_num[40];
+	unsigned char model_num[ATA_ID_PROD_LEN];
 	char *s;
 	unsigned int len;
 
 	/* This block ought to be a library routine as it is in several
 	   drivers now */
 
-	ata_id_string(adev->id, model_num, ATA_ID_PROD_OFS,
-			  sizeof(model_num));
+	ata_id_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	s = &model_num[0];
 	len = strnlen(s, sizeof(model_num));
 
Index: work/drivers/ata/pata_serverworks.c
===================================================================
--- work.orig/drivers/ata/pata_serverworks.c
+++ work/drivers/ata/pata_serverworks.c
@@ -218,7 +218,7 @@ static unsigned long serverworks_osb4_fi
 static unsigned long serverworks_csb_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long mask)
 {
 	const char *p;
-	char model_num[40];
+	char model_num[ATA_ID_PROD_LEN];
 	int len, i;
 
 	/* Disk, UDMA */
@@ -226,7 +226,7 @@ static unsigned long serverworks_csb_fil
 		return ata_pci_default_filter(ap, adev, mask);
 
 	/* Actually do need to check */
-	ata_id_string(adev->id, model_num, ATA_ID_PROD_OFS, sizeof(model_num));
+	ata_id_string(adev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	/* Precuationary - why not do this in the libata core ?? */
 
 	len = strlen(model_num);
Index: work/drivers/ata/sata_sil.c
===================================================================
--- work.orig/drivers/ata/sata_sil.c
+++ work/drivers/ata/sata_sil.c
@@ -541,9 +541,9 @@ static void sil_dev_config(struct ata_po
 {
 	int print_info = ap->eh_context.i.flags & ATA_EHI_PRINTINFO;
 	unsigned int n, quirks = 0;
-	unsigned char model_num[41];
+	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 
-	ata_id_c_string(dev->id, model_num, ATA_ID_PROD_OFS, sizeof(model_num));
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 
 	for (n = 0; sil_blacklist[n].product; n++)
 		if (!strcmp(sil_blacklist[n].product, model_num)) {
Index: work/drivers/ata/pata_hpt37x.c
===================================================================
--- work.orig/drivers/ata/pata_hpt37x.c
+++ work/drivers/ata/pata_hpt37x.c
@@ -349,13 +349,12 @@ static u32 hpt37x_find_mode(struct ata_p
 
 static int hpt_dma_blacklisted(const struct ata_device *dev, char *modestr, const char *list[])
 {
-	unsigned char model_num[40];
+	unsigned char model_num[ATA_ID_PROD_LEN];
 	char *s;
 	unsigned int len;
 	int i = 0;
 
-	ata_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
-			  sizeof(model_num));
+	ata_id_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	s = &model_num[0];
 	len = strnlen(s, sizeof(model_num));
 
