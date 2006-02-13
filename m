From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH] libata: rename ata_dev_id_[c_]string()
Date: Mon, 13 Feb 2006 10:02:46 +0900
Message-ID: <20060213010246.GA9621@htj.dyndns.org>
References: <11397520242535-git-send-email-htejun@gmail.com> <43EF8BB8.2020609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:46324 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751512AbWBMBCu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 20:02:50 -0500
Received: by pproxy.gmail.com with SMTP id d42so515755pyd
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 17:02:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <43EF8BB8.2020609@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

This patch renames ata_dev_id_[c_]string() to ata_id_[c_]string().
All other functions which read data from ATA ID data start with ata_id
and those two function names were getting too long.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   23 +++++++++++------------
 drivers/scsi/libata-scsi.c |   12 ++++++------
 drivers/scsi/sata_sil.c    |    3 +--
 include/linux/libata.h     |    8 ++++----
 4 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 61cba39..28d4606 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -486,7 +486,7 @@ ata_dev_try_classify(struct ata_port *ap
 }
 
 /**
- *	ata_dev_id_string - Convert IDENTIFY DEVICE page into string
+ *	ata_id_string - Convert IDENTIFY DEVICE page into string
  *	@id: IDENTIFY DEVICE results we will examine
  *	@s: string into which data is output
  *	@ofs: offset into identify device page
@@ -500,8 +500,8 @@ ata_dev_try_classify(struct ata_port *ap
  *	caller.
  */
 
-void ata_dev_id_string(const u16 *id, unsigned char *s,
-		       unsigned int ofs, unsigned int len)
+void ata_id_string(const u16 *id, unsigned char *s,
+		   unsigned int ofs, unsigned int len)
 {
 	unsigned int c;
 
@@ -520,27 +520,27 @@ void ata_dev_id_string(const u16 *id, un
 }
 
 /**
- *	ata_dev_id_c_string - Convert IDENTIFY DEVICE page into C string
+ *	ata_id_c_string - Convert IDENTIFY DEVICE page into C string
  *	@id: IDENTIFY DEVICE results we will examine
  *	@s: string into which data is output
  *	@ofs: offset into identify device page
  *	@len: length of string to return. must be an odd number.
  *
- *	This function is identical to ata_dev_id_string except that it
+ *	This function is identical to ata_id_string except that it
  *	trims trailing spaces and terminates the resulting string with
  *	null.  @len must be actual maximum length (even number) + 1.
  *
  *	LOCKING:
  *	caller.
  */
-void ata_dev_id_c_string(const u16 *id, unsigned char *s,
-			 unsigned int ofs, unsigned int len)
+void ata_id_c_string(const u16 *id, unsigned char *s,
+		     unsigned int ofs, unsigned int len)
 {
 	unsigned char *p;
 
 	WARN_ON(!(len & 1));
 
-	ata_dev_id_string(id, s, ofs, len - 1);
+	ata_id_string(id, s, ofs, len - 1);
 
 	p = s + strnlen(s, len - 1);
 	while (p > s && p[-1] == ' ')
@@ -2315,8 +2315,7 @@ static int ata_dma_blacklisted(const str
 	unsigned char model_num[41];
 	int i;
 
-	ata_dev_id_c_string(dev->id, model_num, ATA_ID_PROD_OFS,
-			    sizeof(model_num));
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD_OFS, sizeof(model_num));
 
 	for (i = 0; i < ARRAY_SIZE(ata_dma_blacklist); i++)
 		if (!strcmp(ata_dma_blacklist[i], model_num))
@@ -4933,8 +4932,8 @@ EXPORT_SYMBOL_GPL(ata_scsi_slave_config)
 EXPORT_SYMBOL_GPL(ata_scsi_release);
 EXPORT_SYMBOL_GPL(ata_host_intr);
 EXPORT_SYMBOL_GPL(ata_dev_classify);
-EXPORT_SYMBOL_GPL(ata_dev_id_string);
-EXPORT_SYMBOL_GPL(ata_dev_id_c_string);
+EXPORT_SYMBOL_GPL(ata_id_string);
+EXPORT_SYMBOL_GPL(ata_id_c_string);
 EXPORT_SYMBOL_GPL(ata_dev_config);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 EXPORT_SYMBOL_GPL(ata_eh_qc_complete);
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index 86da465..538784e 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1567,8 +1567,8 @@ unsigned int ata_scsiop_inq_std(struct a
 
 	if (buflen > 35) {
 		memcpy(&rbuf[8], "ATA     ", 8);
-		ata_dev_id_string(args->id, &rbuf[16], ATA_ID_PROD_OFS, 16);
-		ata_dev_id_string(args->id, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
+		ata_id_string(args->id, &rbuf[16], ATA_ID_PROD_OFS, 16);
+		ata_id_string(args->id, &rbuf[32], ATA_ID_FW_REV_OFS, 4);
 		if (rbuf[32] == 0 || rbuf[32] == ' ')
 			memcpy(&rbuf[32], "n/a ", 4);
 	}
@@ -1642,8 +1642,8 @@ unsigned int ata_scsiop_inq_80(struct at
 	memcpy(rbuf, hdr, sizeof(hdr));
 
 	if (buflen > (ATA_SERNO_LEN + 4 - 1))
-		ata_dev_id_string(args->id, (unsigned char *) &rbuf[4],
-				  ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
+		ata_id_string(args->id, (unsigned char *) &rbuf[4],
+			      ATA_ID_SERNO_OFS, ATA_SERNO_LEN);
 
 	return 0;
 }
@@ -1806,8 +1806,8 @@ static int ata_dev_supports_fua(u16 *id)
 	if (!ata_id_has_fua(id))
 		return 0;
 
-	ata_dev_id_c_string(id, model, ATA_ID_PROD_OFS, sizeof(model));
-	ata_dev_id_c_string(id, fw, ATA_ID_FW_REV_OFS, sizeof(fw));
+	ata_id_c_string(id, model, ATA_ID_PROD_OFS, sizeof(model));
+	ata_id_c_string(id, fw, ATA_ID_FW_REV_OFS, sizeof(fw));
 
 	if (strcmp(model, "Maxtor"))
 		return 1;
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index 1534688..e14ed4e 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -338,8 +338,7 @@ static void sil_dev_config(struct ata_po
 	unsigned int n, quirks = 0;
 	unsigned char model_num[41];
 
-	ata_dev_id_c_string(dev->id, model_num, ATA_ID_PROD_OFS,
-			    sizeof(model_num));
+	ata_id_c_string(dev->id, model_num, ATA_ID_PROD_OFS, sizeof(model_num));
 
 	for (n = 0; sil_blacklist[n].product; n++)
 		if (!strcmp(sil_blacklist[n].product, model_num)) {
diff --git a/include/linux/libata.h b/include/linux/libata.h
index afe4645..0d6bf50 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -538,10 +538,10 @@ extern void ata_sg_init_one(struct ata_q
 extern void ata_sg_init(struct ata_queued_cmd *qc, struct scatterlist *sg,
 		 unsigned int n_elem);
 extern unsigned int ata_dev_classify(const struct ata_taskfile *tf);
-extern void ata_dev_id_string(const u16 *id, unsigned char *s,
-			      unsigned int ofs, unsigned int len);
-extern void ata_dev_id_c_string(const u16 *id, unsigned char *s,
-				unsigned int ofs, unsigned int len);
+extern void ata_id_string(const u16 *id, unsigned char *s,
+			  unsigned int ofs, unsigned int len);
+extern void ata_id_c_string(const u16 *id, unsigned char *s,
+			    unsigned int ofs, unsigned int len);
 extern void ata_dev_config(struct ata_port *ap, unsigned int i);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
