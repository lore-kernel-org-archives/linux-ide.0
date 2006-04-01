From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 11/14] libata: add @cdb to ata_exec_internal()
Date: Sat, 1 Apr 2006 19:48:37 +0900
Message-ID: <11438885171755-git-send-email-htejun@gmail.com>
References: <11438885151530-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.196]:25460 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751507AbWDAKsr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 05:48:47 -0500
Received: by zproxy.gmail.com with SMTP id o37so1210250nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 02:48:47 -0800 (PST)
In-Reply-To: <11438885151530-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add @cdb to ata_exec_internal().  It will be used by new EH.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

528fe36d4d09b5200e52503210298c5569eeb6ff
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index ab7a654..4c9aa75 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -964,6 +964,7 @@ void ata_qc_complete_internal(struct ata
  *	@ap: Port to which the command is sent
  *	@dev: Device to which the command is sent
  *	@tf: Taskfile registers for the command and the result
+ *	@cdb: CDB for packet command
  *	@dma_dir: Data tranfer direction of the command
  *	@buf: Data buffer of the command
  *	@buflen: Length of data buffer
@@ -980,7 +981,7 @@ void ata_qc_complete_internal(struct ata
 
 static unsigned
 ata_exec_internal(struct ata_port *ap, struct ata_device *dev,
-		  struct ata_taskfile *tf,
+		  struct ata_taskfile *tf, const u8 *cdb,
 		  int dma_dir, void *buf, unsigned int buflen)
 {
 	u8 command = tf->command;
@@ -995,6 +996,8 @@ ata_exec_internal(struct ata_port *ap, s
 	BUG_ON(qc == NULL);
 
 	qc->tf = *tf;
+	if (cdb)
+		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
 	qc->dma_dir = dma_dir;
 	if (dma_dir != DMA_NONE) {
 		ata_sg_init_one(qc, buf, buflen);
@@ -1144,7 +1147,7 @@ static int ata_dev_read_id(struct ata_po
 
 	tf.protocol = ATA_PROT_PIO;
 
-	err_mask = ata_exec_internal(ap, dev, &tf, DMA_FROM_DEVICE,
+	err_mask = ata_exec_internal(ap, dev, &tf, NULL, DMA_FROM_DEVICE,
 				     id, sizeof(id[0]) * ATA_ID_WORDS);
 	if (err_mask) {
 		rc = -EIO;
@@ -2977,7 +2980,7 @@ static unsigned int ata_dev_set_xfermode
 	tf.protocol = ATA_PROT_NODATA;
 	tf.nsect = dev->xfer_mode;
 
-	err_mask = ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(ap, dev, &tf, NULL, DMA_NONE, NULL, 0);
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
@@ -3017,7 +3020,7 @@ static unsigned int ata_dev_init_params(
 	tf.nsect = sectors;
 	tf.device |= (heads - 1) & 0x0f; /* max head = num. of heads - 1 */
 
-	err_mask = ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0);
+	err_mask = ata_exec_internal(ap, dev, &tf, NULL, DMA_NONE, NULL, 0);
 
 	DPRINTK("EXIT, err_mask=%x\n", err_mask);
 	return err_mask;
@@ -4471,7 +4474,7 @@ static int ata_do_simple_cmd(struct ata_
 	tf.flags |= ATA_TFLAG_DEVICE;
 	tf.protocol = ATA_PROT_NODATA;
 
-	err = ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0);
+	err = ata_exec_internal(ap, dev, &tf, NULL, DMA_NONE, NULL, 0);
 	if (err)
 		printk(KERN_ERR "%s: ata command failed: %d\n",
 				__FUNCTION__, err);
-- 
1.2.4


