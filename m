From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] sata_sil24: fix sg table sizing
Date: Thu, 22 Nov 2007 18:46:57 +0900
Message-ID: <20071122094657.GF30919@htj.mynetwork.cxm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:27754 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbXKVJrD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 22 Nov 2007 04:47:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3094321wah
        for <linux-ide@vger.kernel.org>; Thu, 22 Nov 2007 01:47:03 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

sil24 unnecessarily used LIBATA_MAX_PRD and ATAPI sg table was short
by one entry which might cause very obscure problems.  This patch
updates sg table sizing such that

* One full page is used for PRB + sg table.  On 4k page,
  this results in 253 sg's.

* Make ATAPI sg block properly sized.

* Make build fail if command block size doesn't equal PAGE_SIZE.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
Jeff, this one is for #upstream-fixes.

 drivers/ata/sata_sil24.c |   26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

Index: work/drivers/ata/sata_sil24.c
===================================================================
--- work.orig/drivers/ata/sata_sil24.c
+++ work/drivers/ata/sata_sil24.c
@@ -63,6 +63,21 @@ enum {
 	SIL24_HOST_BAR		= 0,
 	SIL24_PORT_BAR		= 2,
 
+	/* sil24 fetches in chunks of 64bytes.  The first block
+	 * contains the PRB and two SGEs.  From the second block, it's
+	 * consisted of four SGEs and called SGT.  Calculate the
+	 * number of SGTs that fit into one page.
+	 */
+	SIL24_PRB_SZ		= sizeof(struct sil24_prb)
+				  + 2 * sizeof(struct sil24_sge),
+	SIL24_MAX_SGT		= (PAGE_SIZE - SIL24_PRB_SZ)
+				  / (4 * sizeof(struct sil24_sge)),
+
+	/* This will give us one unused SGEs for ATA.  This extra SGE
+	 * will be used to store CDB for ATAPI devices.
+	 */
+	SIL24_MAX_SGE		= 4 * SIL24_MAX_SGT + 1,
+
 	/*
 	 * Global controller registers (128 bytes @ BAR0)
 	 */
@@ -247,13 +262,13 @@ enum {
 
 struct sil24_ata_block {
 	struct sil24_prb prb;
-	struct sil24_sge sge[LIBATA_MAX_PRD];
+	struct sil24_sge sge[SIL24_MAX_SGE];
 };
 
 struct sil24_atapi_block {
 	struct sil24_prb prb;
 	u8 cdb[16];
-	struct sil24_sge sge[LIBATA_MAX_PRD - 1];
+	struct sil24_sge sge[SIL24_MAX_SGE];
 };
 
 union sil24_cmd_block {
@@ -378,7 +393,7 @@ static struct scsi_host_template sil24_s
 	.change_queue_depth	= ata_scsi_change_queue_depth,
 	.can_queue		= SIL24_MAX_CMDS,
 	.this_id		= ATA_SHT_THIS_ID,
-	.sg_tablesize		= LIBATA_MAX_PRD,
+	.sg_tablesize		= SIL24_MAX_SGE,
 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
 	.emulated		= ATA_SHT_EMULATED,
 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
@@ -1284,6 +1299,7 @@ static void sil24_init_controller(struct
 
 static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	extern int __MARKER__sil24_cmd_block_is_sized_wrongly;
 	static int printed_version;
 	struct ata_port_info pi = sil24_port_info[ent->driver_data];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
@@ -1292,6 +1308,10 @@ static int sil24_init_one(struct pci_dev
 	int i, rc;
 	u32 tmp;
 
+	/* cause link error if sil24_cmd_block is sized wrongly */
+	if (sizeof(union sil24_cmd_block) != PAGE_SIZE)
+		__MARKER__sil24_cmd_block_is_sized_wrongly = 1;
+
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
