From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/4] libata: move cdb_len for host to device
Date: Sun, 12 Feb 2006 23:32:58 +0900
Message-ID: <113975477815-git-send-email-htejun@gmail.com>
References: <11397547782407-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.179]:28306 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751121AbWBLOdC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Feb 2006 09:33:02 -0500
Received: by pproxy.gmail.com with SMTP id i75so568138pye
        for <linux-ide@vger.kernel.org>; Sun, 12 Feb 2006 06:33:02 -0800 (PST)
In-Reply-To: <11397547782407-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

cdb_len is per-device property.  Sharing cdb_len on ap results in
inaccurate configuration on revalidation and hotplugging.  This patch
makes cdb_len per-device.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ahci.c        |    3 ++-
 drivers/scsi/libata-core.c |   19 ++++++++++++-------
 drivers/scsi/libata-scsi.c |    4 ++--
 drivers/scsi/sata_sil24.c  |    4 ++--
 include/linux/libata.h     |    2 +-
 5 files changed, 19 insertions(+), 13 deletions(-)

3adaa59ad21ad95f5bad4410b8d4334a3f703185
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 24a54a5..23caa0c 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -617,7 +617,8 @@ static void ahci_qc_prep(struct ata_queu
 	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
 	if (is_atapi) {
 		memset(pp->cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
-		memcpy(pp->cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, ap->cdb_len);
+		memcpy(pp->cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb,
+		       qc->dev->cdb_len);
 	}
 
 	n_elem = 0;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 01d0ca8..c62798c 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -931,7 +931,7 @@ static void ata_dev_identify(struct ata_
 	unsigned int using_edd;
 	struct ata_taskfile tf;
 	unsigned int err_mask;
-	int rc;
+	int i, rc;
 
 	if (!ata_dev_present(dev)) {
 		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
@@ -1087,7 +1087,7 @@ retry:
 
 		}
 
-		ap->host->max_cmd_len = 16;
+		dev->cdb_len = 16;
 	}
 
 	/* ATAPI-specific feature tests */
@@ -1100,8 +1100,7 @@ retry:
 			printk(KERN_WARNING "ata%u: unsupported CDB len\n", ap->id);
 			goto err_out_nosup;
 		}
-		ap->cdb_len = (unsigned int) rc;
-		ap->host->max_cmd_len = (unsigned char) ap->cdb_len;
+		dev->cdb_len = (unsigned int) rc;
 
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
@@ -1109,6 +1108,12 @@ retry:
 		       ata_mode_string(xfer_modes));
 	}
 
+	ap->host->max_cmd_len = 0;
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ap->host->max_cmd_len = max_t(unsigned int,
+					      ap->host->max_cmd_len,
+					      ap->device[i].cdb_len);
+
 	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
 	return;
 
@@ -4200,7 +4205,7 @@ static void atapi_packet_task(void *_dat
 
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
-	WARN_ON(ap->cdb_len < 12);
+	WARN_ON(qc->dev->cdb_len < 12);
 
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
 	    qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
@@ -4214,12 +4219,12 @@ static void atapi_packet_task(void *_dat
 		 */
 		spin_lock_irqsave(&ap->host_set->lock, flags);
 		ap->flags &= ~ATA_FLAG_NOINTR;
-		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
 		if (qc->tf.protocol == ATA_PROT_ATAPI_DMA)
 			ap->ops->bmdma_start(qc);	/* initiate bmdma */
 		spin_unlock_irqrestore(&ap->host_set->lock, flags);
 	} else {
-		ata_data_xfer(ap, qc->cdb, ap->cdb_len, 1);
+		ata_data_xfer(ap, qc->cdb, qc->dev->cdb_len, 1);
 
 		/* PIO commands are handled by polling */
 		ap->hsm_task_state = HSM_ST;
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
index ebd7cf4..3628fed 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2146,7 +2146,7 @@ static void atapi_request_sense(struct a
 	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
 	qc->dma_dir = DMA_FROM_DEVICE;
 
-	memset(&qc->cdb, 0, ap->cdb_len);
+	memset(&qc->cdb, 0, qc->dev->cdb_len);
 	qc->cdb[0] = REQUEST_SENSE;
 	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
 
@@ -2248,7 +2248,7 @@ static unsigned int atapi_xlat(struct at
 		if (ata_check_atapi_dma(qc))
 			using_pio = 1;
 
-	memcpy(&qc->cdb, scsicmd, qc->ap->cdb_len);
+	memcpy(&qc->cdb, scsicmd, dev->cdb_len);
 
 	qc->complete_fn = atapi_qc_complete;
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index 228a7fa..24020c6 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -371,7 +371,7 @@ static void sil24_dev_config(struct ata_
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 
-	if (ap->cdb_len == 16)
+	if (dev->cdb_len == 16)
 		writel(PORT_CS_CDB16, port + PORT_CTRL_STAT);
 	else
 		writel(PORT_CS_CDB16, port + PORT_CTRL_CLR);
@@ -543,7 +543,7 @@ static void sil24_qc_prep(struct ata_que
 		prb = &cb->atapi.prb;
 		sge = cb->atapi.sge;
 		memset(cb->atapi.cdb, 0, 32);
-		memcpy(cb->atapi.cdb, qc->cdb, ap->cdb_len);
+		memcpy(cb->atapi.cdb, qc->cdb, qc->dev->cdb_len);
 
 		if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
 			if (qc->tf.flags & ATA_TFLAG_WRITE)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 0853032..853c988 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -348,6 +348,7 @@ struct ata_device {
 
 	unsigned int		multi_count;	/* sectors count for
 						   READ/WRITE MULTIPLE */
+	unsigned int		cdb_len;
 
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */
@@ -377,7 +378,6 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
-	unsigned int		cdb_len;
 
 	struct ata_device	device[ATA_MAX_DEVICES];
 
-- 
1.1.5


