From: akpm@osdl.org
Subject: [patch 10/12] libata: Revamp blacklist support to allow multiple kinds of blacklisting flaws
Date: Fri, 20 Oct 2006 14:39:43 -0700
Message-ID: <200610202139.k9KLdhOZ003589@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:48771 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422980AbWJTVk6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Oct 2006 17:40:58 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com, htejun@gmail.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Signed-off-by: Alan Cox <alan@redhat.com>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/ata/libata-core.c |  123 +++++++++++++++++++++---------------
 include/linux/libata.h    |    3 
 2 files changed, 78 insertions(+), 48 deletions(-)

diff -puN drivers/ata/libata-core.c~libata-revamp-blacklist-support-to-allow-multiple-kinds drivers/ata/libata-core.c
--- a/drivers/ata/libata-core.c~libata-revamp-blacklist-support-to-allow-multiple-kinds
+++ a/drivers/ata/libata-core.c
@@ -1360,7 +1360,10 @@ static void ata_dev_config_ncq(struct at
 		desc[0] = '\0';
 		return;
 	}
-
+	if (ata_device_blacklisted(dev) & ATA_HORKAGE_NONCQ) {
+		snprintf(desc, desc_sz, "NCQ (not used)");
+		return;
+	}
 	if (ap->flags & ATA_FLAG_NCQ) {
 		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE - 1);
 		dev->flags |= ATA_DFLAG_NCQ;
@@ -3041,37 +3044,55 @@ int ata_dev_revalidate(struct ata_device
 	return rc;
 }
 
-static const char * const ata_dma_blacklist [] = {
-	"WDC AC11000H", NULL,
-	"WDC AC22100H", NULL,
-	"WDC AC32500H", NULL,
-	"WDC AC33100H", NULL,
-	"WDC AC31600H", NULL,
-	"WDC AC32100H", "24.09P07",
-	"WDC AC23200L", "21.10N21",
-	"Compaq CRD-8241B",  NULL,
-	"CRD-8400B", NULL,
-	"CRD-8480B", NULL,
-	"CRD-8482B", NULL,
- 	"CRD-84", NULL,
-	"SanDisk SDP3B", NULL,
-	"SanDisk SDP3B-64", NULL,
-	"SANYO CD-ROM CRD", NULL,
-	"HITACHI CDR-8", NULL,
-	"HITACHI CDR-8335", NULL,
-	"HITACHI CDR-8435", NULL,
-	"Toshiba CD-ROM XM-6202B", NULL,
-	"TOSHIBA CD-ROM XM-1702BC", NULL,
-	"CD-532E-A", NULL,
-	"E-IDE CD-ROM CR-840", NULL,
-	"CD-ROM Drive/F5A", NULL,
-	"WPI CDD-820", NULL,
-	"SAMSUNG CD-ROM SC-148C", NULL,
-	"SAMSUNG CD-ROM SC", NULL,
-	"SanDisk SDP3B-64", NULL,
-	"ATAPI CD-ROM DRIVE 40X MAXIMUM",NULL,
-	"_NEC DV5800A", NULL,
-	"SAMSUNG CD-ROM SN-124", "N001"
+struct ata_blacklist_entry {
+	const char *model_num;
+	const char *model_rev;
+	unsigned long horkage;
+};
+
+static const struct ata_blacklist_entry ata_device_blacklist [] = {
+	/* Devices with DMA related problems under Linux */
+	{ "WDC AC11000H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC22100H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC32500H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC33100H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC31600H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC32100H",	"24.09P07",	ATA_HORKAGE_NODMA },
+	{ "WDC AC23200L",	"21.10N21",	ATA_HORKAGE_NODMA },
+	{ "Compaq CRD-8241B", 	NULL,		ATA_HORKAGE_NODMA },
+	{ "CRD-8400B",		NULL, 		ATA_HORKAGE_NODMA },
+	{ "CRD-8480B",		NULL,		ATA_HORKAGE_NODMA },
+	{ "CRD-8482B",		NULL,		ATA_HORKAGE_NODMA },
+	{ "CRD-84",		NULL,		ATA_HORKAGE_NODMA },
+	{ "SanDisk SDP3B",	NULL,		ATA_HORKAGE_NODMA },
+	{ "SanDisk SDP3B-64",	NULL,		ATA_HORKAGE_NODMA },
+	{ "SANYO CD-ROM CRD",	NULL,		ATA_HORKAGE_NODMA },
+	{ "HITACHI CDR-8",	NULL,		ATA_HORKAGE_NODMA },
+	{ "HITACHI CDR-8335",	NULL,		ATA_HORKAGE_NODMA },
+	{ "HITACHI CDR-8435",	NULL,		ATA_HORKAGE_NODMA },
+	{ "Toshiba CD-ROM XM-6202B", NULL,	ATA_HORKAGE_NODMA },
+	{ "TOSHIBA CD-ROM XM-1702BC", NULL,	ATA_HORKAGE_NODMA },
+	{ "CD-532E-A", 		NULL,		ATA_HORKAGE_NODMA },
+	{ "E-IDE CD-ROM CR-840",NULL,		ATA_HORKAGE_NODMA },
+	{ "CD-ROM Drive/F5A",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WPI CDD-820", 	NULL,		ATA_HORKAGE_NODMA },
+	{ "SAMSUNG CD-ROM SC-148C", NULL,	ATA_HORKAGE_NODMA },
+	{ "SAMSUNG CD-ROM SC",	NULL,		ATA_HORKAGE_NODMA },
+	{ "SanDisk SDP3B-64", 	NULL,		ATA_HORKAGE_NODMA },
+	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",NULL,ATA_HORKAGE_NODMA },
+	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
+	{ "SAMSUNG CD-ROM SN-124","N001",	ATA_HORKAGE_NODMA },
+
+	/* Devices we expect to fail diagnostics */
+
+	/* Devices where NCQ should be avoided */
+	/* NCQ is slow */
+        { "WDC WD740ADFD-00",   NULL,		ATA_HORKAGE_NONCQ },
+
+	/* Devices with NCQ limits */
+
+	/* End Marker */
+	{ }
 };
 
 static int ata_strim(char *s, size_t len)
@@ -3086,20 +3107,12 @@ static int ata_strim(char *s, size_t len
 	return len;
 }
 
-static int ata_dma_blacklisted(const struct ata_device *dev)
+unsigned long ata_device_blacklisted(const struct ata_device *dev)
 {
 	unsigned char model_num[40];
 	unsigned char model_rev[16];
 	unsigned int nlen, rlen;
-	int i;
-
-	/* We don't support polling DMA.
-	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
-	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
-	 */
-	if ((dev->ap->flags & ATA_FLAG_PIO_POLLING) &&
-	    (dev->flags & ATA_DFLAG_CDB_INTR))
-		return 1;
+	const struct ata_blacklist_entry *ad = ata_device_blacklist;
 
 	ata_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
 			  sizeof(model_num));
@@ -3108,17 +3121,30 @@ static int ata_dma_blacklisted(const str
 	nlen = ata_strim(model_num, sizeof(model_num));
 	rlen = ata_strim(model_rev, sizeof(model_rev));
 
-	for (i = 0; i < ARRAY_SIZE(ata_dma_blacklist); i += 2) {
-		if (!strncmp(ata_dma_blacklist[i], model_num, nlen)) {
-			if (ata_dma_blacklist[i+1] == NULL)
-				return 1;
-			if (!strncmp(ata_dma_blacklist[i], model_rev, rlen))
-				return 1;
+	while (ad->model_num) {
+		if (!strncmp(ad->model_num, model_num, nlen)) {
+			if (ad->model_rev == NULL)
+				return ad->horkage;
+			if (!strncmp(ad->model_rev, model_rev, rlen))
+				return ad->horkage;
 		}
+		ad++;
 	}
 	return 0;
 }
 
+static int ata_dma_blacklisted(const struct ata_device *dev)
+{
+	/* We don't support polling DMA.
+	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
+	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
+	 */
+	if ((dev->ap->flags & ATA_FLAG_PIO_POLLING) &&
+	    (dev->flags & ATA_DFLAG_CDB_INTR))
+		return 1;
+	return (ata_device_blacklisted(dev) & ATA_HORKAGE_NODMA) ? 1 : 0;
+}
+
 /**
  *	ata_dev_xfermask - Compute supported xfermask of the given device
  *	@dev: Device to compute xfermask for
@@ -6184,6 +6210,7 @@ EXPORT_SYMBOL_GPL(ata_host_suspend);
 EXPORT_SYMBOL_GPL(ata_host_resume);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
+EXPORT_SYMBOL_GPL(ata_device_blacklisted);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
diff -puN include/linux/libata.h~libata-revamp-blacklist-support-to-allow-multiple-kinds include/linux/libata.h
--- a/include/linux/libata.h~libata-revamp-blacklist-support-to-allow-multiple-kinds
+++ a/include/linux/libata.h
@@ -310,6 +310,8 @@ enum {
 	   (some horkage may be drive/controller pair dependant */
 
 	ATA_HORKAGE_DIAGNOSTIC	= (1 << 0),	/* Failed boot diag */
+	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
+	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 };
 
 enum hsm_task_states {
@@ -796,6 +798,7 @@ extern void ata_id_string(const u16 *id,
 			  unsigned int ofs, unsigned int len);
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
+extern unsigned long ata_device_blacklisted(const struct ata_device *dev);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
_
