From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/5] libata: move cdb_len for host to device
Date: Fri, 27 Jan 2006 00:24:03 +0900
Message-ID: <11382890433660-git-send-email-htejun@gmail.com>
References: <11382890422935-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.195]:402 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932358AbWAZPYK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 10:24:10 -0500
Received: by zproxy.gmail.com with SMTP id 34so368599nzf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jan 2006 07:24:09 -0800 (PST)
In-Reply-To: <11382890422935-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk
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

c9eb7c877e51bac65b1c0a65334f6108f085b952
diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
index 81ba5f5..c8d82cc 100644
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -745,7 +745,8 @@ static void ahci_qc_prep(struct ata_queu
 	ata_tf_to_fis(&qc->tf, pp->cmd_tbl, 0);
 	if (is_atapi) {
 		memset(pp->cmd_tbl + AHCI_CMD_TBL_CDB, 0, 32);
-		memcpy(pp->cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb, ap->cdb_len);
+		memcpy(pp->cmd_tbl + AHCI_CMD_TBL_CDB, qc->cdb,
+		       qc->dev->cdb_len);
 	}
 
 	n_elem = 0;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index e416950..f42c613 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1286,7 +1286,7 @@ static void ata_dev_identify(struct ata_
 	unsigned int using_edd;
 	struct ata_taskfile tf;
 	unsigned int err_mask;
-	int rc;
+	int i, rc;
 
 	if (!ata_dev_present(dev)) {
 		DPRINTK("ENTER/EXIT (host %u, dev %u) -- nodev\n",
@@ -1450,7 +1450,7 @@ retry:
 
 		}
 
-		ap->host->max_cmd_len = 16;
+		dev->cdb_len = 16;
 	}
 
 	/* ATAPI-specific feature tests */
@@ -1463,8 +1463,7 @@ retry:
 			printk(KERN_WARNING "ata%u: unsupported CDB len\n", ap->id);
 			goto err_out_nosup;
 		}
-		ap->cdb_len = (unsigned int) rc;
-		ap->host->max_cmd_len = (unsigned char) ap->cdb_len;
+		dev->cdb_len = (unsigned int) rc;
 
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
@@ -1472,6 +1471,12 @@ retry:
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
 
@@ -4529,7 +4534,7 @@ static void atapi_packet_task(void *_dat
 
 	/* send SCSI cdb */
 	DPRINTK("send cdb\n");
-	assert(ap->cdb_len >= 12);
+	assert(qc->dev->cdb_len >= 12);
 
 	if (qc->tf.protocol == ATA_PROT_ATAPI_DMA ||
 	    qc->tf.protocol == ATA_PROT_ATAPI_NODATA) {
@@ -4543,12 +4548,12 @@ static void atapi_packet_task(void *_dat
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
index cf54536..c0b34bf 100644
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -2113,7 +2113,7 @@ static void atapi_request_sense(struct a
 	ata_sg_init_one(qc, cmd->sense_buffer, sizeof(cmd->sense_buffer));
 	qc->dma_dir = DMA_FROM_DEVICE;
 
-	memset(&qc->cdb, 0, ap->cdb_len);
+	memset(&qc->cdb, 0, qc->dev->cdb_len);
 	qc->cdb[0] = REQUEST_SENSE;
 	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
 
@@ -2215,7 +2215,7 @@ static unsigned int atapi_xlat(struct at
 		if (ata_check_atapi_dma(qc))
 			using_pio = 1;
 
-	memcpy(&qc->cdb, scsicmd, qc->ap->cdb_len);
+	memcpy(&qc->cdb, scsicmd, qc->dev->cdb_len);
 
 	qc->complete_fn = atapi_qc_complete;
 
diff --git a/drivers/scsi/sata_sil24.c b/drivers/scsi/sata_sil24.c
index f2a4e01..95352db 100644
--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -370,7 +370,7 @@ static void sil24_dev_config(struct ata_
 {
 	void __iomem *port = (void __iomem *)ap->ioaddr.cmd_addr;
 
-	if (ap->cdb_len == 16)
+	if (dev->cdb_len == 16)
 		writel(PORT_CS_CDB16, port + PORT_CTRL_STAT);
 	else
 		writel(PORT_CS_CDB16, port + PORT_CTRL_CLR);
@@ -541,7 +541,7 @@ static void sil24_qc_prep(struct ata_que
 		prb = &cb->atapi.prb;
 		sge = cb->atapi.sge;
 		memset(cb->atapi.cdb, 0, 32);
-		memcpy(cb->atapi.cdb, qc->cdb, ap->cdb_len);
+		memcpy(cb->atapi.cdb, qc->cdb, qc->dev->cdb_len);
 
 		if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
 			if (qc->tf.flags & ATA_TFLAG_WRITE)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f4cd1eb..e049fc5 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -356,6 +356,7 @@ struct ata_device {
 
 	unsigned int		multi_count;	/* sectors count for
 						   READ/WRITE MULTIPLE */
+	unsigned int		cdb_len;
 
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */
@@ -385,7 +386,6 @@ struct ata_port {
 	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
-	unsigned int		cdb_len;
 
 	struct ata_device	device[ATA_MAX_DEVICES];
 
-- 
1.1.3


